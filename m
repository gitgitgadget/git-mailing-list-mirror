From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/6] Move computation of absolute paths from Makefile to runtime and compute prefix on the fly if RUNTIME_PREFIX set
Date: Sat, 10 Jan 2009 14:50:47 +0100
Message-ID: <1231595452-27698-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 14:53:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLeH1-0006VW-2L
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 14:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbZAJNv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 08:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbZAJNvY
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 08:51:24 -0500
Received: from mailer.zib.de ([130.73.108.11]:45488 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbZAJNvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 08:51:22 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0ADoro0025831;
	Sat, 10 Jan 2009 14:51:03 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0ADorWL016764;
	Sat, 10 Jan 2009 14:50:53 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105109>

This is the first commit of a series that adds support for
relocatable binaries (called RUNTIME_PREFIX).  Such binaries can be
moved together with the system configuration files to a different
directory, as long as the relative paths from the binary to the
configuration files is preserved.  This functionality is essential
on Windows where we deliver git binaries with an installer that
allows to freely choose the installation location.  The commit
series implements RUNTIME_PREFIX only on Windows.  Adding support
on Unix should not be too hard, though.

This first commits makes all paths relative in the Makefile and
teaches system_path() to add the prefix instead.  We used to
compute absolute paths in the Makefile and passed them to C as
defines.  We now pass relative paths to C and call system_path() to
add the prefix at runtime.

If RUNTIME_PREFIX is unset we use the static prefix.  This will be
the default on Unix.  Thus, the behavior on Unix will stay
identical to the old implementation, which added the prefix in the
Makefile.

If RUNTIME_PREFIX is set the prefix is computed from the location
of the executable.  In this case, system_path() tries to strip
known directories that executables can be located in from the path
of the executable.  If the path is successfully stripped it is used
as the prefix.  For example, if the executable is
"/msysgit/bin/git" and BINDIR is "bin", then the prefix computed is
"/msysgit".

If the runtime prefix computation fails, we fall back to the static
prefix specified in the makefile.  This can be the case if the
executable is not installed at a known location.  Note that our
test system sets GIT_CONFIG_NOSYSTEM to tell git to ignore global
configuration files during testing.  Hence testing does not trigger
the fall back.

Note that the implementation requires argv0_path to be set to an
absolute path, which is currently the case only on Windows.
argv0_path must point to the directory of the executable.  We use
assert() to verify this in debug builds.  On Windows, the wrapper
for main() (see compat/mingw.h) guarantees that argv0_path is
correctly initialized.  On Unix, further work is required before
RUNTIME_PREFIX can be enabled.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile       |   45 +++++++++++++++++++++++++++++----------------
 builtin-help.c |    4 ++--
 exec_cmd.c     |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 81 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index dee97c1..a7728a3 100644
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
@@ -1027,6 +1031,9 @@ ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
 endif
+ifdef RUNTIME_PREFIX
+	COMPAT_CFLAGS += -DRUNTIME_PREFIX
+endif
 
 ifdef NO_PTHREADS
 	THREADED_DELTA_SEARCH =
@@ -1086,6 +1093,7 @@ ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_SQ = $(subst ','\'',$(mandir))
 infodir_SQ = $(subst ','\'',$(infodir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
@@ -1251,7 +1259,12 @@ git.o git.spec \
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
 
@@ -1400,17 +1413,17 @@ remove-dashes:
 
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
index cdd35f9..669b82e 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -9,11 +9,57 @@ static const char *argv0_path;
 
 const char *system_path(const char *path)
 {
-	if (!is_absolute_path(path) && argv0_path) {
-		struct strbuf d = STRBUF_INIT;
-		strbuf_addf(&d, "%s/%s", argv0_path, path);
-		path = strbuf_detach(&d, NULL);
+	static const char *prefix;
+
+	if (is_absolute_path(path)) {
+		return path;
+	}
+
+#ifdef RUNTIME_PREFIX
+	assert(argv0_path);
+	assert(is_absolute_path(argv0_path));
+
+	if (!prefix) {
+		const char *strip[] = {
+			GIT_EXEC_PATH,
+			BINDIR,
+			0
+		};
+		const char **s;
+
+		for (s = strip; *s; s++) {
+			const char *sargv = argv0_path + strlen(argv0_path);
+			const char *ss = *s + strlen(*s);
+			while (argv0_path < sargv && *s < ss
+				&& (*sargv == *ss ||
+				    (is_dir_sep(*sargv) && is_dir_sep(*ss)))) {
+				sargv--;
+				ss--;
+			}
+			if (*s == ss) {
+				struct strbuf d = STRBUF_INIT;
+				/* We also skip the trailing directory separator. */
+				assert(sargv - argv0_path - 1 >= 0);
+				strbuf_add(&d, argv0_path, sargv - argv0_path - 1);
+				prefix = strbuf_detach(&d, NULL);
+				break;
+			}
+		}
 	}
+
+	if (!prefix) {
+		prefix = PREFIX;
+		fprintf(stderr, "RUNTIME_PREFIX requested, "
+				"but prefix computation failed.  "
+				"Using static fallback '%s'.\n", prefix);
+	}
+#else
+	prefix = PREFIX;
+#endif
+
+	struct strbuf d = STRBUF_INIT;
+	strbuf_addf(&d, "%s/%s", prefix, path);
+	path = strbuf_detach(&d, NULL);
 	return path;
 }
 
-- 
1.6.1.85.g32c5d
