From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/7] system_path(): Add prefix computation at runtime if RUNTIME_PREFIX set
Date: Sun, 17 Aug 2008 14:44:38 +0200
Message-ID: <1218977083-14526-3-git-send-email-prohaska@zib.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de>
 <1218977083-14526-2-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUhej-0001rR-7b
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbYHQMp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 08:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbYHQMp2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:45:28 -0400
Received: from mailer.zib.de ([130.73.108.11]:52204 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbYHQMp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 08:45:26 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7HCivSi022016;
	Sun, 17 Aug 2008 14:45:02 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7HCihbP002872;
	Sun, 17 Aug 2008 14:44:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1218977083-14526-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92604>

This commit modifies system_path() to compute the prefix at runtime
if explicitly requested to do so.  If RUNTIME_PREFIX is defined,
system_path() tries to strip known directories that executables can
be located in from the path of the executable.  If the path is
successfully stripped it is used as the prefix.

We print errors if the runtime prefix computation fails.  The user
needs to know that the global configuration are not picked up,
because this can cause unexpected behavior.  If a user explicitly
wants to ignore system wide paths, he can set GIT_CONFIG_NOSYSTEM,
as our tests do.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile   |    3 +++
 exec_cmd.c |   48 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 9df5a9d..8341558 100644
--- a/Makefile
+++ b/Makefile
@@ -982,6 +982,9 @@ ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
 endif
+ifdef RUNTIME_PREFIX
+	COMPAT_CFLAGS += -DRUNTIME_PREFIX
+endif
 
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
diff --git a/exec_cmd.c b/exec_cmd.c
index ce6741e..1622481 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -9,11 +9,51 @@ static const char *argv0_path;
 
 const char *system_path(const char *path)
 {
-	if (!is_absolute_path(path) && argv0_path) {
-		struct strbuf d = STRBUF_INIT;
-		strbuf_addf(&d, "%s/%s", argv0_path, path);
-		path = strbuf_detach(&d, NULL);
+#ifdef RUNTIME_PREFIX
+	static const char *prefix;
+
+	if (!argv0_path) {
+		fprintf(stderr, "RUNTIME_PREFIX requested for path '%s', "
+				"but argv0_path not set.\n", path);
+		return path;
+	}
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
1.6.0.rc3.22.g053fd
