From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] Fix a memory leak in "connect.c" and die if command too
 long.
Date: Mon, 11 Sep 2006 07:04:50 +0200
Message-ID: <20060911070450.bf4cc778.chriscool@tuxfamily.org>
References: <20060911065922.93139e5d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 06:59:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMdsv-000100-Uz
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 06:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWIKE7B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 00:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWIKE7A
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 00:59:00 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45968 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932205AbWIKE67 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 00:58:59 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id C879429B4;
	Mon, 11 Sep 2006 06:58:58 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
In-Reply-To: <20060911065922.93139e5d.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26836>

Use "add_to_string" instead of "sq_quote" and "snprintf", so
that there is no memory allocation and no memory leak.
Also check if the command is too long to fit into the buffer
and die if this is the case, instead of truncating it to the
buffer size.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 connect.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 1c6429b..49251f9 100644
--- a/connect.c
+++ b/connect.c
@@ -599,12 +599,13 @@ static void git_proxy_connect(int fd[2],
 	close(pipefd[1][0]);
 }
 
+#define MAX_CMD_LEN 1024
+
 /*
  * Yeah, yeah, fixme. Need to pass in the heads etc.
  */
 int git_connect(int fd[2], char *url, const char *prog)
 {
-	char command[1024];
 	char *host, *path = url;
 	char *end;
 	int c;
@@ -697,8 +698,18 @@ int git_connect(int fd[2], char *url, co
 	if (pid < 0)
 		die("unable to fork");
 	if (!pid) {
-		snprintf(command, sizeof(command), "%s %s", prog,
-			 sq_quote(path));
+		char command[MAX_CMD_LEN];
+		char *posn = command;
+		int size = MAX_CMD_LEN;
+		int of = 0;
+
+		of |= add_to_string(&posn, &size, prog, 0);
+		of |= add_to_string(&posn, &size, " ", 0);
+		of |= add_to_string(&posn, &size, path, 1);
+
+		if (of)
+			die("command line too long");
+
 		dup2(pipefd[1][0], 0);
 		dup2(pipefd[0][1], 1);
 		close(pipefd[0][0]);
-- 
1.4.2.g430e
