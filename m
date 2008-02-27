From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 05/40] Windows: Strip ".exe" from the program name.
Date: Wed, 27 Feb 2008 19:54:28 +0100
Message-ID: <1204138503-6126-6-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:56:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURRZ-0000Km-15
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbYB0SzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbYB0SzQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:16 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40427 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbYB0SzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:07 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id E3C75974E8;
	Wed, 27 Feb 2008 19:55:04 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75248>

Before we can successfully parse a builtin command from the program name
we must strip off unneeded parts, that is, the file extension.
Additionally, we must take Windows style path names into account.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    1 +
 git.c    |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index bc8a487..069939f 100644
--- a/Makefile
+++ b/Makefile
@@ -543,6 +543,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PERL_MAKEMAKER = YesPlease
 	NO_EXTRA_PROGRAMS = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
+	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
 	EXTLIBS += -lws2_32
 	X = .exe
diff --git a/git.c b/git.c
index 0cb8688..32166a4 100644
--- a/git.c
+++ b/git.c
@@ -372,6 +372,15 @@ static void handle_internal_command(int argc, const char **argv)
 	};
 	int i;
 
+#ifdef STRIP_EXTENSION
+	i = strlen(argv[0]) - strlen(STRIP_EXTENSION);
+	if (i > 0 && !strcmp(argv[0] + i, STRIP_EXTENSION)) {
+		char *argv0 = strdup(argv[0]);
+		argv[0] = cmd = argv0;
+		argv0[i] = '\0';
+	}
+#endif
+
 	/* Turn "git cmd --help" into "git help cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
 		argv[1] = argv[0];
@@ -398,6 +407,11 @@ int main(int argc, const char **argv)
 	 * name, and the dirname as the default exec_path
 	 * if we don't have anything better.
 	 */
+#ifdef __MINGW32__
+	char *bslash = strrchr(cmd, '\\');
+	if (!slash || (bslash && bslash > slash))
+		slash = bslash;
+#endif
 	if (slash) {
 		*slash++ = 0;
 		cmd_path = cmd;
-- 
1.5.4.1.126.ge5a7d
