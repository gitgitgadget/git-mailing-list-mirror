From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/4] git_connect: extend to take a pseudo format string for the program to run
Date: Thu, 28 Apr 2016 23:12:36 +0900
Message-ID: <1461852759-28429-2-git-send-email-mh@glandium.org>
References: <1461852759-28429-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 16:12:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmgT-0000yc-C3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 16:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbcD1OMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 10:12:46 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45582 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbcD1OMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 10:12:44 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avmgJ-0007PJ-GF; Thu, 28 Apr 2016 23:12:39 +0900
X-Mailer: git-send-email 2.8.1.5.g18c8a48
In-Reply-To: <1461852759-28429-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292886>

Currently, the path extracted from the url is passed as last argument to
the program/command passed to git_connect(). In every case the function
is used in the git code base, it's enough, but in order to allow the
reuse of e.g. the GIT_SSH/GIT_SSH_COMMAND logic, additional flexibility
is welcome.

With this change, when the program/command passed to git_connect()
contains a "%s", that "%s" is replaced with the path from the url,
allowing the path to be at a different position than last on the
executed command line.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index dccf673..96c8c1d 100644
--- a/connect.c
+++ b/connect.c
@@ -658,6 +658,25 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 
 static struct child_process no_fork = CHILD_PROCESS_INIT;
 
+static void prepare_connect_command(struct strbuf *cmd, const char *prog,
+                                    const char *path, int quote)
+{
+	const char *found = strstr(prog, "%s");
+	if (found)
+		strbuf_add(cmd, prog, found - prog);
+	else {
+		strbuf_addstr(cmd, prog);
+		strbuf_addch(cmd, ' ');
+	}
+	if (quote)
+		sq_quote_buf(cmd, path);
+	else
+		strbuf_addstr(cmd, path);
+
+	if (found)
+		strbuf_addstr(cmd, found + 2);
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -717,18 +736,18 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * Note: Do not add any other headers here!  Doing so
 		 * will cause older git-daemon servers to crash.
 		 */
+		prepare_connect_command(&cmd, prog, path, 0);
 		packet_write(fd[1],
-			     "%s %s%chost=%s%c",
-			     prog, path, 0,
+			     "%s%chost=%s%c",
+			     cmd.buf, 0,
 			     target_host, 0);
+		strbuf_release(&cmd);
 		free(target_host);
 	} else {
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
 
-		strbuf_addstr(&cmd, prog);
-		strbuf_addch(&cmd, ' ');
-		sq_quote_buf(&cmd, path);
+		prepare_connect_command(&cmd, prog, path, 1);
 
 		/* remove repo-local variables from the environment */
 		conn->env = local_repo_env;
-- 
2.8.1.5.g18c8a48
