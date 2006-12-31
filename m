From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Use /dev/null for update hook stdin.
Date: Sat, 30 Dec 2006 21:55:22 -0500
Message-ID: <20061231025522.GC5530@spearce.org>
References: <a0aecffe21074288c911c396f92901bfb558d591.1167533707.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qrG-0003rN-Ss
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWLaCz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWLaCz1
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:55:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40262 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690AbWLaCz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:55:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0qqu-0002gb-Ad; Sat, 30 Dec 2006 21:55:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D2BE920FB65; Sat, 30 Dec 2006 21:55:22 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <a0aecffe21074288c911c396f92901bfb558d591.1167533707.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35657>

Currently the update hook invoked by receive-pack has its stdin
connected to the pushing client.  The hook shouldn't attempt to
read from this stream, and doing so may consume data that was
meant for receive-pack.  Instead we should give the update hook
/dev/null as its stdin, ensuring that it always receives EOF and
doesn't disrupt the protocol if it attempts to read any data.

The post-update hook is similar, as it gets invoked with /dev/null
on stdin to prevent the hook from reading data from the client.
Previously we had invoked it with stdout also connected to /dev/null,
throwing away anything on stdout, to prevent client protocol errors.
Instead we should redirect stdout to stderr, like we do with the
update hook.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |    6 ++++--
 run-command.c  |    6 +++---
 run-command.h  |    2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index 64289e9..cf83109 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -73,7 +73,8 @@ static int run_update_hook(const char *refname,
 
 	if (access(update_hook, X_OK) < 0)
 		return 0;
-	code = run_command_opt(RUN_COMMAND_STDOUT_TO_STDERR,
+	code = run_command_opt(RUN_COMMAND_NO_STDIN
+		| RUN_COMMAND_STDOUT_TO_STDERR,
 		update_hook, refname, old_hex, new_hex, NULL);
 	switch (code) {
 	case 0:
@@ -188,7 +189,8 @@ static void run_update_post_hook(struct command *cmd)
 		argc++;
 	}
 	argv[argc] = NULL;
-	run_command_v_opt(argv, RUN_COMMAND_NO_STDIO);
+	run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
+		| RUN_COMMAND_STDOUT_TO_STDERR);
 }
 
 /*
diff --git a/run-command.c b/run-command.c
index 7e4ca43..cfbad74 100644
--- a/run-command.c
+++ b/run-command.c
@@ -9,12 +9,12 @@ int run_command_v_opt(const char **argv, int flags)
 	if (pid < 0)
 		return -ERR_RUN_COMMAND_FORK;
 	if (!pid) {
-		if (flags & RUN_COMMAND_NO_STDIO) {
+		if (flags & RUN_COMMAND_NO_STDIN) {
 			int fd = open("/dev/null", O_RDWR);
 			dup2(fd, 0);
-			dup2(fd, 1);
 			close(fd);
-		} else if (flags & RUN_COMMAND_STDOUT_TO_STDERR)
+		}
+		if (flags & RUN_COMMAND_STDOUT_TO_STDERR)
 			dup2(2, 1);
 		if (flags & RUN_GIT_CMD) {
 			execv_git_cmd(argv);
diff --git a/run-command.h b/run-command.h
index 8156eac..59c4476 100644
--- a/run-command.h
+++ b/run-command.h
@@ -11,7 +11,7 @@ enum {
 	ERR_RUN_COMMAND_WAITPID_NOEXIT,
 };
 
-#define RUN_COMMAND_NO_STDIO 1
+#define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
-- 
1.5.0.rc0.g6bb1
