From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Mon, 09 Jan 2006 18:36:50 -0500
Message-ID: <1136849810.11717.518.camel@brick.watson.ibm.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 10 00:35:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew6Y3-0001q8-Nn
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWAIXfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWAIXfU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:35:20 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:30356 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751629AbWAIXfS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 18:35:18 -0500
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com [129.34.20.40])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k09NbUdr023242
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:37:30 -0500
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k09NZGc355374
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:35:16 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k09NZFs377704
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:35:16 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0A0W5Ce005818
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 19:32:05 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k09NZEm31700
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:35:14 -0500
To: git@vger.kernel.org
In-Reply-To: <1136849678.11717.514.camel@brick.watson.ibm.com>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14388>

Calls to git_setup_exec_path() are inserted on paths that will execute
other git programs. git_setup_exec_path() will ensure that the git
installation directories are in the path.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 daemon.c      |    2 ++
 fetch-clone.c |    2 ++
 run-command.c |    1 +
 send-pack.c   |    2 ++
 upload-pack.c |    4 +++-
 5 files changed, 10 insertions(+), 1 deletions(-)

bb14b4b61f53f755486695e5bdc45b5623a6f8c5
diff --git a/daemon.c b/daemon.c
index 3bd1426..d653f33 100644
--- a/daemon.c
+++ b/daemon.c
@@ -226,6 +226,8 @@ static int upload(char *dir)
 
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 
+	git_setup_exec_path();
+
 	/* git-upload-pack only ever reads stuff, so this is safe */
 	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf,
".", NULL);
 	return -1;
diff --git a/fetch-clone.c b/fetch-clone.c
index f46fe6e..afbbb79 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -98,6 +98,8 @@ int receive_unpack_pack(int fd[2], const
 	int status;
 	pid_t pid;
 
+	git_setup_exec_path();
+
 	pid = fork();
 	if (pid < 0)
 		die("%s: unable to fork off git-unpack-objects", me);
diff --git a/run-command.c b/run-command.c
index 8bf5922..993a3f9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -9,6 +9,7 @@ int run_command_v_opt(int argc, char **a
 	if (pid < 0)
 		return -ERR_RUN_COMMAND_FORK;
 	if (!pid) {
+		git_setup_exec_path();
 		if (flags & RUN_COMMAND_NO_STDIO) {
 			int fd = open("/dev/null", O_RDWR);
 			dup2(fd, 0);
diff --git a/send-pack.c b/send-pack.c
index cd36193..a241f00 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -30,6 +30,7 @@ static void exec_pack_objects(void)
 		"--stdout",
 		NULL
 	};
+	git_setup_exec_path();
 	execvp("git-pack-objects", args);
 	die("git-pack-objects exec failed (%s)", strerror(errno));
 }
@@ -58,6 +59,7 @@ static void exec_rev_list(struct ref *re
 		refs = refs->next;
 	}
 	args[i] = NULL;
+	git_setup_exec_path();
 	execvp("git-rev-list", args);
 	die("git-rev-list exec failed (%s)", strerror(errno));
 }
diff --git a/upload-pack.c b/upload-pack.c
index 1834b6b..f8d4fbe 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -270,7 +270,9 @@ int main(int argc, char **argv)
 			break;
 		}
 	}
-	
+
+	git_setup_exec_path();
+
 	if (i != argc-1)
 		usage(upload_pack_usage);
 	dir = argv[i];
-- 
0.99.9m-g02ad
