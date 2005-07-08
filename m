From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use sq_quote() to properly quote the parameter to call shell.
Date: Fri, 08 Jul 2005 00:02:52 -0700
Message-ID: <7vslypbx0j.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050706203139.GA19198@kroah.com>
	<Pine.LNX.4.58.0507061335100.4159@g5.osdl.org>
	<7v64vnwrwg.fsf@assigned-by-dhcp.cox.net>
	<7v3bqpdbs7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 09:04:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqmu4-0002pP-53
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 09:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVGHHD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 03:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVGHHD2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 03:03:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64998 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262279AbVGHHCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 03:02:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050708070254.SKUY7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 8 Jul 2005 03:02:54 -0400
To: git@vger.kernel.org
In-Reply-To: <7v3bqpdbs7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 07 Jul 2005 23:58:32 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This tries to be more lenient to the users and stricter to the
attackers by quoting the input properly for shell safety,
instead of forbidding certain characters from the input.

Things to note:

 - We do not quote "prog" parameter (which comes from --exec).
   The user should know what he is doing.  --exec='echo foo'
   will supply the first two parameters to the resulting
   command, while --exec="'echo foo'" will give the first
   parameter, a single string with a space inside.

 - We do not care too much about leaking the sq_quote() output
   just before running exec().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
This depends on the previous [PATCH] Make sq_expand() available as sq_quote().
Please discard the one I sent by mistake that lacks additions of
quote.[ch] files.

To verify the stuff is quoted properly, I used the following
command invocations.  They show that the metacharacters are
passed unmolested by the intervening shell and ssh commands:

    $ git-send-pack --exec=/bin/echo '0011 abc;d\ef g<h'
    fatal: protocol error: expected sha/ref, got ' abc;d\ef g<h'
    $ git-send-pack --exec=/bin/echo localhost:'0011 abc;d\ef g<h'
    fatal: protocol error: expected sha/ref, got ' abc;d\ef g<h'
    $ git-fetch-pack '0011 abc;d\ef g<h' a
    fatal: git-upload-pack unable to chdir to 0011 abc;d\ef g<h
    fatal: unexpected EOF
    $ git-fetch-pack localhost:'0011 abc;d\ef g<h' a
    fatal: git-upload-pack unable to chdir to 0011 abc;d\ef g<h
    fatal: unexpected EOF

Also by storing the following executable script in
/var/tmp/j0.sh and using git-send-pack --exec=/var/tmp/j0.sh
with the same parameters:

    #!/bin/sh
    o=/var/tmp/j0.out 
    echo $$ >>$o

    i=0
    echo "0: [$0]" >>$o
    for x
    do
	i=$(expr $i + 1)
	echo "$i: [$x]" >>$o
    done

it can be verified that the funny string is indeed passed as a
single parameter to it.

 connect.c |   33 +++------------------------------
 1 files changed, 3 insertions(+), 30 deletions(-)

e6e65f02919048f37467a9aca55ed19892dd2a7e
diff --git a/connect.c b/connect.c
--- a/connect.c
+++ b/connect.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pkt-line.h"
+#include "quote.h"
 #include <sys/wait.h>
 
 int get_ack(int fd, unsigned char *result_sha1)
@@ -42,34 +43,6 @@ int path_match(const char *path, int nr,
 }
 
 /*
- * First, make it shell-safe.  We do this by just disallowing any
- * special characters. Somebody who cares can do escaping and let
- * through the rest. But since we're doing to feed this to ssh as
- * a command line, we're going to be pretty damn anal for now.
- */
-static char *shell_safe(char *url)
-{
-	char *n = url;
-	unsigned char c;
-	static const char flags[256] = {
-		['0'...'9'] = 1,
-		['a'...'z'] = 1,
-		['A'...'Z'] = 1,
-		['.'] = 1, ['/'] = 1,
-		['-'] = 1, ['+'] = 1,
-		[':'] = 1, ['_'] = 1,
-		['@'] = 1, [','] = 1,
-		['~'] = 1, ['^'] = 1,
-	};
-
-	while ((c = *n++) != 0) {
-		if (flags[c] != 1)
-			die("I don't like '%c'. Sue me.", c);
-	}
-	return url;
-}
-
-/*
  * Yeah, yeah, fixme. Need to pass in the heads etc.
  */
 int git_connect(int fd[2], char *url, const char *prog)
@@ -80,7 +53,6 @@ int git_connect(int fd[2], char *url, co
 	int pipefd[2][2];
 	pid_t pid;
 
-	url = shell_safe(url);
 	host = NULL;
 	path = url;
 	colon = strchr(url, ':');
@@ -89,11 +61,12 @@ int git_connect(int fd[2], char *url, co
 		host = url;
 		path = colon+1;
 	}
-	snprintf(command, sizeof(command), "%s %s", prog, path);
 	if (pipe(pipefd[0]) < 0 || pipe(pipefd[1]) < 0)
 		die("unable to create pipe pair for communication");
 	pid = fork();
 	if (!pid) {
+		snprintf(command, sizeof(command), "%s %s", prog,
+			 sq_quote(path));
 		dup2(pipefd[1][0], 0);
 		dup2(pipefd[0][1], 1);
 		close(pipefd[0][0]);
