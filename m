From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/7] system_path(): Add prefix computation at runtime if RUNTIME_PREFIX set
Date: Sun, 21 Sep 2008 18:24:33 +0200
Message-ID: <1222014278-11071-3-git-send-email-prohaska@zib.de>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de>
 <1222014278-11071-2-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 21 18:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRnE-0001jZ-TX
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYIUQ1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbYIUQ1H
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:27:07 -0400
Received: from mailer.zib.de ([130.73.108.11]:50799 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbYIUQ1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:27:06 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8LGOd8N004995;
	Sun, 21 Sep 2008 18:24:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8LGOcxP015855;
	Sun, 21 Sep 2008 18:24:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1222014278-11071-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96406>

This commit modifies system_path() to compute the prefix at runtime if
configured to do so.  If RUNTIME_PREFIX is defined, system_path() tries
to strip known directories that executables can be located in from the
path of the executable.  If the path is successfully stripped it is used
as the prefix.  For example, if the executable is "/msysgit/bin/git" and
BINDIR is "/bin", then the prefix is computed as "/msysgit".

We report an error if the runtime prefix computation fails, which can
happen if the executable is not installed at a known location.  The user
should know that the global configuration is not picked up, because this
can cause unexpected behavior.  If we explicitly want to ignore system
wide paths, we can set the environment variable GIT_CONFIG_NOSYSTEM, as
our tests do.

The implementation requires that argv0_path is set up properly, which is
currently the case only on Windows.  argv0_path must point to the
absolute path of the directory of the executable, which is verified by
two calls to assert().  On Windows, the wrapper for main() (see
compat/mingw.h) guarantees that this is the case.  On Unix, further work
is required before RUNTIME_PREFIX can be enabled.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile   |    3 +++
 exec_cmd.c |   45 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 140a2b2..8181f74 100644
--- a/Makefile
+++ b/Makefile
@@ -1006,6 +1006,9 @@ ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
 endif
+ifdef RUNTIME_PREFIX
+	COMPAT_CFLAGS += -DRUNTIME_PREFIX
+endif
 
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
diff --git a/exec_cmd.c b/exec_cmd.c
index ce6741e..9fa89b8 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -9,11 +9,48 @@ static const char *argv0_path;
 
 const char *system_path(const char *path)
 {
-	if (!is_absolute_path(path) && argv0_path) {
-		struct strbuf d = STRBUF_INIT;
-		strbuf_addf(&d, "%s/%s", argv0_path, path);
-		path = strbuf_detach(&d, NULL);
+#ifdef RUNTIME_PREFIX
+	static const char *prefix;
+
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
+				strbuf_add(&d, argv0_path, sargv - argv0_path);
+				prefix = strbuf_detach(&d, NULL);
+				break;
+			}
+		}
 	}
+
+	if (!prefix) {
+		fprintf(stderr, "RUNTIME_PREFIX requested for path '%s', "
+				"but prefix computation failed.\n", path);
+		return path;
+	}
+
+	struct strbuf d = STRBUF_INIT;
+	strbuf_addf(&d, "%s/%s", prefix, path);
+	path = strbuf_detach(&d, NULL);
+#endif
 	return path;
 }
 
-- 
1.6.0.2.GIT
