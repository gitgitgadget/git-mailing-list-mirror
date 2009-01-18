From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/7 v2] Move computation of absolute paths from Makefile to runtime (in preparation for RUNTIME_PREFIX)
Date: Sun, 18 Jan 2009 13:00:09 +0100
Message-ID: <1232280015-8144-2-git-send-email-prohaska@zib.de>
References: <1232280015-8144-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 13:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOWML-0007Kr-0o
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 13:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbZARMAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 07:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbZARMAs
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 07:00:48 -0500
Received: from mailer.zib.de ([130.73.108.11]:32930 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765776AbZARMAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 07:00:39 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0IC0FJ1026427;
	Sun, 18 Jan 2009 13:00:20 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0IC0FJ2001758;
	Sun, 18 Jan 2009 13:00:15 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1232280015-8144-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106177>

This commit prepares the Makefile for relocatable binaries (called
RUNTIME_PREFIX).  Such binaries will be able to be moved together
with the system configuration files to a different directory,
requiring to compute the prefix at runtime.

In a first step, we make all paths relative in the Makefile and
teach system_path() to add the prefix instead.  We used to compute
absolute paths in the Makefile and passed them to C as defines.  We
now pass relative paths to C and call system_path() to add the
prefix at runtime.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile       |   42 ++++++++++++++++++++++++++----------------
 builtin-help.c |    4 ++--
 exec_cmd.c     |   12 ++++++++----
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 2b873fa..1d2060a 100644
--- a/Makefile
+++ b/Makefile
@@ -179,28 +179,32 @@ STRIP ?= strip
 # Among the variables below, these:
 #   gitexecdir
 #   template_dir
+#   mandir
+#   infodir
 #   htmldir
 #   ETC_GITCONFIG (but not sysconfdir)
-# can be specified as a relative path ../some/where/else (which must begin
-# with ../); this is interpreted as relative to $(bindir) and "git" at
+# can be specified as a relative path some/where/else;
+# this is interpreted as relative to $(prefix) and "git" at
 # runtime figures out where they are based on the path to the executable.
 # This can help installing the suite in a relocatable way.
 
 prefix = $(HOME)
-bindir = $(prefix)/bin
-mandir = $(prefix)/share/man
-infodir = $(prefix)/share/info
-gitexecdir = $(prefix)/libexec/git-core
+bindir_relative = bin
+bindir = $(prefix)/$(bindir_relative)
+mandir = share/man
+infodir = share/info
+gitexecdir = libexec/git-core
 sharedir = $(prefix)/share
-template_dir = $(sharedir)/git-core/templates
-htmldir=$(sharedir)/doc/git-doc
+template_dir = share/git-core/templates
+htmldir = share/doc/git-doc
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
+ETC_GITCONFIG = $(sysconfdir)/gitconfig
 else
 sysconfdir = $(prefix)/etc
+ETC_GITCONFIG = etc/gitconfig
 endif
 lib = lib
-ETC_GITCONFIG = $(sysconfdir)/gitconfig
 # DESTDIR=
 
 # default configuration for gitweb
@@ -1086,6 +1090,7 @@ ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_SQ = $(subst ','\'',$(mandir))
 infodir_SQ = $(subst ','\'',$(infodir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
@@ -1251,7 +1256,12 @@ git.o git.spec \
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
+		'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+		'-DBINDIR="$(bindir_relative_SQ)"' \
+		'-DPREFIX="$(prefix_SQ)"' \
+		$<
+
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
 
@@ -1407,17 +1417,17 @@ remove-dashes:
 
 ### Installation rules
 
-ifeq ($(firstword $(subst /, ,$(template_dir))),..)
-template_instdir = $(bindir)/$(template_dir)
-else
+ifeq ($(abspath $(template_dir)),$(template_dir))
 template_instdir = $(template_dir)
+else
+template_instdir = $(prefix)/$(template_dir)
 endif
 export template_instdir
 
-ifeq ($(firstword $(subst /, ,$(gitexecdir))),..)
-gitexec_instdir = $(bindir)/$(gitexecdir)
-else
+ifeq ($(abspath $(gitexecdir)),$(gitexecdir))
 gitexec_instdir = $(gitexecdir)
+else
+gitexec_instdir = $(prefix)/$(gitexecdir)
 endif
 gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
 export gitexec_instdir
diff --git a/builtin-help.c b/builtin-help.c
index f076efa..9b57a74 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -329,7 +329,7 @@ static void setup_man_path(void)
 	 * old_path, the ':' at the end will let 'man' to try
 	 * system-wide paths after ours to find the manual page. If
 	 * there is old_path, we need ':' as delimiter. */
-	strbuf_addstr(&new_path, GIT_MAN_PATH);
+	strbuf_addstr(&new_path, system_path(GIT_MAN_PATH));
 	strbuf_addch(&new_path, ':');
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
@@ -375,7 +375,7 @@ static void show_man_page(const char *git_cmd)
 static void show_info_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
-	setenv("INFOPATH", GIT_INFO_PATH, 1);
+	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
 	execlp("info", "info", "gitman", page, NULL);
 }
 
diff --git a/exec_cmd.c b/exec_cmd.c
index cdd35f9..b7e7b60 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -9,11 +9,15 @@ static const char *argv0_path;
 
 const char *system_path(const char *path)
 {
-	if (!is_absolute_path(path) && argv0_path) {
-		struct strbuf d = STRBUF_INIT;
-		strbuf_addf(&d, "%s/%s", argv0_path, path);
-		path = strbuf_detach(&d, NULL);
+	static const char *prefix = PREFIX;
+
+	if (is_absolute_path(path)) {
+		return path;
 	}
+
+	struct strbuf d = STRBUF_INIT;
+	strbuf_addf(&d, "%s/%s", prefix, path);
+	path = strbuf_detach(&d, NULL);
 	return path;
 }
 
-- 
1.6.1.87.g15624
