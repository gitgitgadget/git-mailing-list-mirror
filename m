From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 34/40] Windows: Make the pager work.
Date: Wed, 27 Feb 2008 19:54:57 +0100
Message-ID: <1204138503-6126-35-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVa-00022R-Om
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbYB0S4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755649AbYB0S4V
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:21 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40439 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476AbYB0SzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:12 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 7733D9771F;
	Wed, 27 Feb 2008 19:55:10 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75264>

Since we have neither fork() nor exec(), we have to spawn the pager and
feed it with the program's output.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 pager.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index ca002f9..3f7f8c1 100644
--- a/pager.c
+++ b/pager.c
@@ -1,12 +1,13 @@
 #include "cache.h"
 
 /*
- * This is split up from the rest of git so that we might do
- * something different on Windows, for example.
+ * This is split up from the rest of git so that we can do
+ * something different on Windows.
  */
 
 static int spawned_pager;
 
+#ifndef __MINGW32__
 static void run_pager(const char *pager)
 {
 	/*
@@ -22,11 +23,31 @@ static void run_pager(const char *pager)
 	execlp(pager, pager, NULL);
 	execl("/bin/sh", "sh", "-c", pager, NULL);
 }
+#else
+#include "run-command.h"
+
+static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
+static struct child_process pager_process = {
+	.argv = pager_argv,
+	.in = -1
+};
+static void wait_for_pager(void)
+{
+	fflush(stdout);
+	fflush(stderr);
+	/* signal EOF to pager */
+	close(1);
+	close(2);
+	finish_command(&pager_process);
+}
+#endif
 
 void setup_pager(void)
 {
+#ifndef __MINGW32__
 	pid_t pid;
 	int fd[2];
+#endif
 	const char *pager = getenv("GIT_PAGER");
 
 	if (!isatty(1))
@@ -45,6 +66,7 @@ void setup_pager(void)
 
 	spawned_pager = 1; /* means we are emitting to terminal */
 
+#ifndef __MINGW32__
 	if (pipe(fd) < 0)
 		return;
 	pid = fork();
@@ -72,6 +94,20 @@ void setup_pager(void)
 	run_pager(pager);
 	die("unable to execute pager '%s'", pager);
 	exit(255);
+#else
+	/* spawn the pager */
+	pager_argv[2] = pager;
+	if (start_command(&pager_process))
+		return;
+
+	/* original process continues, but writes to the pipe */
+	dup2(pager_process.in, 1);
+	dup2(pager_process.in, 2);
+	close(pager_process.in);
+
+	/* this makes sure that the parent terminates after the pager */
+	atexit(wait_for_pager);
+#endif
 }
 
 int pager_in_use(void)
-- 
1.5.4.1.126.ge5a7d
