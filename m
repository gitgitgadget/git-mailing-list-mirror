From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] git_connect: remove artificial limit of a remote command
Date: Tue, 05 Nov 2013 20:35:30 +0100
Message-ID: <52794882.2020108@kdbg.org>
References: <201311042220.50178.tboegi@web.de> <52789AE5.2010702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 05 20:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdmPb-0007En-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 20:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab3KETff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 14:35:35 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:25132 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752906Ab3KETff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 14:35:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ED76B130052;
	Tue,  5 Nov 2013 20:35:31 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0199619F3EE;
	Tue,  5 Nov 2013 20:35:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <52789AE5.2010702@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237338>

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
Am 05.11.2013 08:14, schrieb Johannes Sixt:
> Can you please make this into a series of small patches so that we can
> more easily see the good and the bad parts? One of the patches could be a
> clean-up of the current protocol determination and URL dissection, which
> is indigestible spaghetti right now.

Maybe start with these two.

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
1.8.4.33.gd68f7e8
