From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 6/7 v2] Compute prefix at runtime if RUNTIME_PREFIX is set
Date: Sun, 18 Jan 2009 13:00:14 +0100
Message-ID: <1232280015-8144-7-git-send-email-prohaska@zib.de>
References: <1232280015-8144-1-git-send-email-prohaska@zib.de>
 <1232280015-8144-2-git-send-email-prohaska@zib.de>
 <1232280015-8144-3-git-send-email-prohaska@zib.de>
 <1232280015-8144-4-git-send-email-prohaska@zib.de>
 <1232280015-8144-5-git-send-email-prohaska@zib.de>
 <1232280015-8144-6-git-send-email-prohaska@zib.de>
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
	id 1LOWML-0007Kr-Mr
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 13:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbZARMAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 07:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbZARMAv
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 07:00:51 -0500
Received: from mailer.zib.de ([130.73.108.11]:32931 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765845AbZARMAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 07:00:40 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0IC0GGf026434;
	Sun, 18 Jan 2009 13:00:21 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0IC0FJ7001758;
	Sun, 18 Jan 2009 13:00:16 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1232280015-8144-6-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106176>

This commit adds support for relocatable binaries (called
RUNTIME_PREFIX).  Such binaries can be moved together with the
system configuration files to a different directory, as long as the
relative paths from the binary to the configuration files is
preserved.  This functionality is essential on Windows where we
deliver git binaries with an installer that allows to freely choose
the installation location.

If RUNTIME_PREFIX is unset we use the static prefix.  This will be
the default on Unix.  Thus, the behavior on Unix will remain
identical to the old implementation, which used to add the prefix
in the Makefile.

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

Note that RUNTIME_PREFIX only works on Windows, though adding
support on Unix should not be too hard.  The implementation
requires argv0_path to be set to an absolute path.  argv0_path must
point to the directory of the executable.  We use assert() to
verify this in debug builds.  On Windows, the wrapper for main()
(see compat/mingw.h) guarantees that argv0_path is correctly
initialized.  On Unix, further work is required before
RUNTIME_PREFIX can be enabled.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile   |    3 +++
 exec_cmd.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1d2060a..fbe52c9 100644
--- a/Makefile
+++ b/Makefile
@@ -1031,6 +1031,9 @@ ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
 endif
+ifdef RUNTIME_PREFIX
+	COMPAT_CFLAGS += -DRUNTIME_PREFIX
+endif
 
 ifdef NO_PTHREADS
 	THREADED_DELTA_SEARCH =
diff --git a/exec_cmd.c b/exec_cmd.c
index d9408db..5f59880 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -9,12 +9,56 @@ static const char *argv0_path;
 
 const char *system_path(const char *path)
 {
+#ifdef RUNTIME_PREFIX
+	static const char *prefix = 0;
+#else
 	static const char *prefix = PREFIX;
+#endif
 
 	if (is_absolute_path(path)) {
 		return path;
 	}
 
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
+	}
+
+	if (!prefix) {
+		prefix = PREFIX;
+		fprintf(stderr, "RUNTIME_PREFIX requested, "
+				"but prefix computation failed.  "
+				"Using static fallback '%s'.\n", prefix);
+	}
+#endif
+
 	struct strbuf d = STRBUF_INIT;
 	strbuf_addf(&d, "%s/%s", prefix, path);
 	path = strbuf_detach(&d, NULL);
-- 
1.6.1.87.g15624
