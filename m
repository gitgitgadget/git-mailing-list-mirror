From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] use appropriate typedefs
Date: Tue, 15 Aug 2006 10:40:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151037570.28175@chino.corp.google.com>
References: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com>
 <7vveou8myg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0608151000350.26891@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 19:41:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD2uK-0005Mv-U5
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 19:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWHORkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 13:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWHORkg
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 13:40:36 -0400
Received: from smtp-out.google.com ([216.239.45.12]:46049 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030367AbWHORkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 13:40:35 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id k7FHeDRB002954;
	Tue, 15 Aug 2006 10:40:13 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=wmUQBGSqzl9bd0AvrMqKEucTPLCGAiWwAXgVRrD35uwwkgUvdI1iyFJVEDeFtK12u
	I/SW/GqgDTsvz4iOfE9Tg==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps36.corp.google.com with ESMTP id k7FHe7N4027539;
	Tue, 15 Aug 2006 10:40:07 -0700
Received: by localhost (Postfix, from userid 24081)
	id AC0A287D71; Tue, 15 Aug 2006 10:40:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 5781887D70;
	Tue, 15 Aug 2006 10:40:06 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0608151000350.26891@chino.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25471>

On Tue, 15 Aug 2006, David Rientjes wrote:
> 
> Please cite where this function is specified to return zero on success and not 
> the return value of waitpid which, after all, is the only assignment to the 
> return value.  waitpid only returns when the status of the child is available or 
> an error has occurred as a result of an interrupt.  The correct interface, in my 
> opinion, for this function is to return what waitpid returns and allow it to 
> indicate the pid of the child or interrupt to the caller.  The signature now 
> suggests that.  If Linus did indeed write this, he did so to spin until the 
> status of the child was known.
> 

Forget this, the function is correct as is because EINTR is only returned on 
signal interrupt and ret is set to -1 (by the waitpid spec) implicitly.

Please replace the original patch with the following.


Replaces types with appropriate typedefs.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-apply.c |    2 +-
 fetch-clone.c   |    3 +--
 merge-index.c   |    3 ++-
 run-command.c   |    8 ++++----
 unpack-trees.c  |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 9cf477c..56c5394 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2097,7 +2097,7 @@ static void create_one_file(char *path, 
 	}
 
 	if (errno == EEXIST) {
-		unsigned int nr = getpid();
+		pid_t nr = getpid();
 
 		for (;;) {
 			const char *newpath;
diff --git a/fetch-clone.c b/fetch-clone.c
index 5e84c46..c5cf477 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -44,9 +44,8 @@ static int finish_pack(const char *pack_
 
 	for (;;) {
 		int status, code;
-		int retval = waitpid(pid, &status, 0);
 
-		if (retval < 0) {
+		if (waitpid(pid, &status, 0) < 0) {
 			if (errno == EINTR)
 				continue;
 			error("waitpid failed (%s)", strerror(errno));
diff --git a/merge-index.c b/merge-index.c
index 0498a6f..a9c8cc1 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -11,7 +11,8 @@ static int err;
 
 static void run_program(void)
 {
-	int pid = fork(), status;
+	pid_t pid = fork();
+	int status;
 
 	if (pid < 0)
 		die("unable to fork");
diff --git a/run-command.c b/run-command.c
index ca67ee9..3bacc1b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -25,15 +25,15 @@ int run_command_v_opt(int argc, const ch
 	}
 	for (;;) {
 		int status, code;
-		int retval = waitpid(pid, &status, 0);
+		pid_t waiting = waitpid(pid, &status, 0);
 
-		if (retval < 0) {
+		if (waiting < 0) {
 			if (errno == EINTR)
 				continue;
-			error("waitpid failed (%s)", strerror(retval));
+			error("waitpid failed (%s)", strerror(waiting));
 			return -ERR_RUN_COMMAND_WAITPID;
 		}
-		if (retval != pid)
+		if (waiting != pid)
 			return -ERR_RUN_COMMAND_WAITPID_WRONG_PID;
 		if (WIFSIGNALED(status))
 			return -ERR_RUN_COMMAND_WAITPID_SIGNAL;
diff --git a/unpack-trees.c b/unpack-trees.c
index a20639b..e496d8c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -278,7 +278,7 @@ static void unlink_entry(char *name)
 	}
 }
 
-static volatile int progress_update = 0;
+static volatile sig_atomic_t progress_update = 0;
 
 static void progress_interval(int signum)
 {
-- 
1.4.2.g460c-dirty
