From: David Rientjes <rientjes@google.com>
Subject: [PATCH] use appropriate typedefs
Date: Mon, 14 Aug 2006 23:07:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 15 08:07:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCs5P-00050Q-A3
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 08:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWHOGHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 02:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWHOGHb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 02:07:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:56477 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965176AbWHOGHb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 02:07:31 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7F67TEn027412
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 23:07:29 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=urI2WIZ4OsYo6ZzKfiK7xIWRx8VAGWRFEoKsr9gur/M7WAFtF1U8R6jtMgMRC4U2U
	Ith02UTp3ra3/RMRztZAw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7F67TfT020934
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 23:07:29 -0700
Received: by localhost (Postfix, from userid 24081)
	id 06EFA87D71; Mon, 14 Aug 2006 23:07:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id B900287D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 23:07:28 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25436>

Replaces int types with the appropriate definition in atomic and PID instances.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-apply.c     |    2 +-
 builtin-read-tree.c |    2 +-
 builtin-tar-tree.c  |    4 ++--
 connect.c           |    4 ++--
 fetch-clone.c       |    3 +--
 merge-index.c       |    3 ++-
 run-command.c       |    8 ++++----
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index be2c715..2862eb1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2097,7 +2097,7 @@ static void create_one_file(char *path, 
 	}
 
 	if (errno == EEXIST) {
-		unsigned int nr = getpid();
+		pid_t nr = getpid();
 
 		for (;;) {
 			const char *newpath;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index b30160a..f902fee 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -23,7 +23,7 @@ static int nontrivial_merge = 0;
 static int trivial_merges_only = 0;
 static int aggressive = 0;
 static int verbose_update = 0;
-static volatile int progress_update = 0;
+static volatile sig_atomic_t progress_update = 0;
 static const char *prefix = NULL;
 
 static int head_idx = -1;
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 215892b..6fed919 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -361,8 +361,8 @@ static const char *exec = "git-upload-ta
 
 static int remote_tar(int argc, const char **argv)
 {
-	int fd[2], ret, len;
-	pid_t pid;
+	int fd[2], len;
+	pid_t pid, ret;
 	char buf[1024];
 	char *url;
 
diff --git a/connect.c b/connect.c
index 4422a0d..a4c02d1 100644
--- a/connect.c
+++ b/connect.c
@@ -735,9 +735,9 @@ int git_connect(int fd[2], char *url, co
 	return pid;
 }
 
-int finish_connect(pid_t pid)
+pid_t finish_connect(pid_t pid)
 {
-	int ret;
+	pid_t ret;
 
 	for (;;) {
 		ret = waitpid(pid, NULL, 0);
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
-- 
1.4.2.GIT
