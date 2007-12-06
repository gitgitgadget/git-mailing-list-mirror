From: Sergei Organov <osv@javad.com>
Subject: [PATCH v2] Let git-help prefer man-pages installed with this version of git
Date: Thu, 6 Dec 2007 21:33:01 +0300
Message-ID: <87k5nq628e.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 14:53:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ddo-0002n4-0U
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 14:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbXLGNw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 08:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbXLGNw6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 08:52:58 -0500
Received: from javad.com ([216.122.176.236]:2997 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbXLGNw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 08:52:57 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB7DqtU33613;
	Fri, 7 Dec 2007 13:52:56 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1J0ddJ-0004GX-Il; Fri, 07 Dec 2007 16:52:49 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67426>

Prepend $(prefix)/share/man to the MANPATH environment variable before
invoking 'man' from help.c:show_man_page().  There may be other git
documentation in the user's MANPATH but the user is asking a specific
instance of git about its own documentation, so we'd better show the
documentation for _that_ instance of git.

Signed-off-by: Sergei Organov <osv@javad.com>
---

Apart from better commit message suggested by Junio, this version of the
patch fixes behavior when MANPATH environment variable is _not_
set. With this patch, if it happens that manual pages are not installed
for given version of git, the git-help will indeed try to find manual
page elsewhere, according to system-wide configuration.

 Makefile |    5 ++++-
 help.c   |   24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 999391e..3030d31 100644
--- a/Makefile
+++ b/Makefile
@@ -154,6 +154,7 @@ STRIP ?= strip
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+mandir = $(prefix)/share/man
 gitexecdir = $(bindir)
 sharedir = $(prefix)/share
 template_dir = $(sharedir)/git-core/templates
@@ -744,6 +745,7 @@ ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+mandir_SQ = $(subst ','\'',$(mandir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 prefix_SQ = $(subst ','\'',$(prefix))
@@ -790,7 +792,8 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.o: common-cmds.h
+help.o: help.c common-cmds.h GIT-CFLAGS
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_MAN_PATH="$(mandir_SQ)"' $<
 
 git-merge-subtree$X: git-merge-recursive$X
 	$(QUIET_BUILT_IN)$(RM) $@ && ln git-merge-recursive$X $@
diff --git a/help.c b/help.c
index 37a9c25..1782730 100644
--- a/help.c
+++ b/help.c
@@ -8,6 +8,8 @@
 #include "exec_cmd.h"
 #include "common-cmds.h"
 
+static const char *builtin_man_path = GIT_MAN_PATH;
+
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -239,6 +241,27 @@ void list_common_cmds_help(void)
 	}
 }
 
+static void setup_man_path(void)
+{
+	struct strbuf new_path;
+	const char *old_path = getenv("MANPATH");
+
+	strbuf_init(&new_path, 0);
+
+	/* We should always put ':' after our path. If there is no
+	 * old_path, the ':' at the end will let 'man' to try
+	 * system-wide paths after ours to find the manual page. If
+	 * there is old_path, we need ':' as delimiter. */
+	strbuf_addstr(&new_path, builtin_man_path);
+	strbuf_addch(&new_path, ':');
+	if (old_path)
+		strbuf_addstr(&new_path, old_path);
+
+	setenv("MANPATH", new_path.buf, 1);
+
+	strbuf_release(&new_path);
+}
+
 static void show_man_page(const char *git_cmd)
 {
 	const char *page;
@@ -254,6 +277,7 @@ static void show_man_page(const char *git_cmd)
 		page = p;
 	}
 
+	setup_man_path();
 	execlp("man", "man", page, NULL);
 }
 
-- 
1.5.3.4
