From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 03/10] git_connect: remove artificial limit of a remote command
Date: Thu, 21 Nov 2013 21:38:56 +0100
Message-ID: <201311212138.57581.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb26-00087l-B2
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab3KUUjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:39:12 -0500
Received: from mout.web.de ([212.227.15.14]:54269 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3KUUjL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:39:11 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MORuj-1VnBOq2Ui5-005taN for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:39:09 +0100
X-Provags-ID: V03:K0:l9wUgBUGA7x/bHm5r9zwGy8ISz+CsDIV2l1TbZ8m/XAFkABs41v
 nJrNGScpjdreFezEUwfVtLQCrlf5ElCQCbkX1AoNGCSYl3asO81RNDlG1OPu1NXVlaQd4zR
 /0SFAVRToqjJsRz6cS2+RLLslGtUaSgSXwYFUCRtcUCnXdbR+AgNicW9+A0UZygWiJnl+JK
 xf/vYMIx8npEpvUIJlc5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238141>

Since day one, function git_connect() had a limit on the command line of
the command that is invoked to make a connection. 7a33bcbe converted the
code that constructs the command to strbuf. This would have been the
right time to remove the limit, but it did not happen. Remove it now.

git_connect() uses start_command() to invoke the command; consequently,
the limits of the system still apply, but are diagnosed only at execve()
time. But these limits are more lenient than the 1K that git_connect()
imposed.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 connect.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 06e88b0..6cc1f8d 100644
--- a/connect.c
+++ b/connect.c
@@ -527,8 +527,6 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	return proxy;
 }
 
-#define MAX_CMD_LEN 1024
-
 static char *get_port(char *host)
 {
 	char *end;
@@ -570,7 +568,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	int free_path = 0;
 	char *port = NULL;
 	const char **arg;
-	struct strbuf cmd;
+	struct strbuf cmd = STRBUF_INIT;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -676,12 +674,9 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 
 	conn = xcalloc(1, sizeof(*conn));
 
-	strbuf_init(&cmd, MAX_CMD_LEN);
 	strbuf_addstr(&cmd, prog);
 	strbuf_addch(&cmd, ' ');
 	sq_quote_buf(&cmd, path);
-	if (cmd.len >= MAX_CMD_LEN)
-		die("command line too long");
 
 	conn->in = conn->out = -1;
 	conn->argv = arg = xcalloc(7, sizeof(*arg));
-- 
1.8.4.457.g424cb08
