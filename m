From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFH] send-pack: fix pipeline.
Date: Sun, 31 Dec 2006 01:30:27 -0800
Message-ID: <7v1wmgfm4s.fsf@assigned-by-dhcp.cox.net>
References: <7v1wmjoumq.fsf@assigned-by-dhcp.cox.net>
	<7vzm96latb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612291307520.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 10:30:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0x1m-00057d-Ci
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 10:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbWLaJar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 04:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933100AbWLaJar
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 04:30:47 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36247 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933097AbWLaJaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 04:30:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231093043.YNHY9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 04:30:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5MVs1W0061kojtg0000000; Sun, 31 Dec 2006 04:29:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612291307520.4473@woody.osdl.org> (Linus
	Torvalds's message of "Fri, 29 Dec 2006 13:20:41 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35689>

Linus Torvalds <torvalds@osdl.org> writes:

> For some reason I thought we had fixed that by just generating the object 
> list internally, but I guess we don't do that. That's just stupid.

Thanks.  How about this?

-- >8 --
[PATCH] send-pack: tell pack-objects to use its internal rev-list.

This means one less process in the pipeline to worry about, and
removes about 1/8 of the code.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 send-pack.c |  139 ++++++++++++++++++-----------------------------------------
 1 files changed, 42 insertions(+), 97 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 29cf736..eaa6efb 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -14,100 +14,49 @@ static int send_all;
 static int force_update;
 static int use_thin_pack;
 
-static void exec_pack_objects(void)
-{
-	static const char *args[] = {
-		"pack-objects",
-		"--all-progress",
-		"--stdout",
-		NULL
-	};
-	execv_git_cmd(args);
-	die("git-pack-objects exec failed (%s)", strerror(errno));
-}
-
-static void exec_rev_list(struct ref *refs)
-{
-	static const char *args[4];
-	int i = 0;
-
-	args[i++] = "rev-list";	/* 0 */
-	if (use_thin_pack)	/* 1 */
-		args[i++] = "--objects-edge";
-	else
-		args[i++] = "--objects";
-
-	args[i++] = "--stdin";
-
-	args[i] = NULL;
-	execv_git_cmd(args);
-	die("git-rev-list exec failed (%s)", strerror(errno));
-}
-
 /*
- * Run "rev-list --stdin | pack-objects" pipe.
- */
-static void rev_list(struct ref *refs)
-{
-	int pipe_fd[2];
-	pid_t pack_objects_pid;
-
-	if (pipe(pipe_fd) < 0)
-		die("rev-list setup: pipe failed");
-	pack_objects_pid = fork();
-	if (!pack_objects_pid) {
-		/* The child becomes pack-objects; reads from pipe
-		 * and writes to the original fd
-		 */
-		dup2(pipe_fd[0], 0);
-		close(pipe_fd[0]);
-		close(pipe_fd[1]);
-		exec_pack_objects();
-		die("pack-objects setup failed");
-	}
-	if (pack_objects_pid < 0)
-		die("pack-objects fork failed");
-
-	/* We become rev-list --stdin; output goes to pipe. */
-	dup2(pipe_fd[1], 1);
-	close(pipe_fd[0]);
-	close(pipe_fd[1]);
-	exec_rev_list(refs);
-}
-
-/*
- * Create "rev-list --stdin | pack-objects" pipe and feed
- * the refs into the pipeline.
+ * Make a pack stream and spit it out into file descriptor fd
  */
-static void rev_list_generate(int fd, struct ref *refs)
+static int pack_objects(int fd, struct ref *refs)
 {
 	int pipe_fd[2];
-	pid_t rev_list_generate_pid;
+	pid_t pid;
 
 	if (pipe(pipe_fd) < 0)
-		die("rev-list-generate setup: pipe failed");
-	rev_list_generate_pid = fork();
-	if (!rev_list_generate_pid) {
-		/* The child becomes the "rev-list | pack-objects"
-		 * pipeline.  It takes input from us, and its output
-		 * goes to fd.
+		return error("send-pack: pipe failed");
+	pid = fork();
+	if (!pid) {
+		/*
+		 * The child becomes pack-objects --revs; we feed
+		 * the revision parameters to it via its stdin and
+		 * let its stdout go back to the other end.
 		 */
+		static const char *args[] = {
+			"pack-objects",
+			"--all-progress",
+			"--revs",
+			"--stdout",
+			NULL,
+			NULL,
+		};
+		if (use_thin_pack)
+			args[4] = "--thin";
 		dup2(pipe_fd[0], 0);
 		dup2(fd, 1);
 		close(pipe_fd[0]);
 		close(pipe_fd[1]);
 		close(fd);
-		rev_list(refs);
-		die("rev-list setup failed");
+		execv_git_cmd(args);
+		die("git-pack-objects exec failed (%s)", strerror(errno));
 	}
-	if (rev_list_generate_pid < 0)
-		die("rev-list-generate fork failed");
 
-	/* We feed the rev parameters to them.  We do not write into
-	 * fd nor read from the pipe.
+	/*
+	 * We feed the pack-objects we just spawned with revision
+	 * parameters by writing to the pipe.
 	 */
 	close(pipe_fd[0]);
 	close(fd);
+
 	while (refs) {
 		char buf[42];
 
@@ -126,28 +75,24 @@ static void rev_list_generate(int fd, struct ref *refs)
 		refs = refs->next;
 	}
 	close(pipe_fd[1]);
-	// waitpid(rev_list_generate_pid);
-	exit(0);
-}
 
-/*
- * Make a pack stream and spit it out into file descriptor fd
- */
-static void pack_objects(int fd, struct ref *refs)
-{
-	pid_t rev_list_pid;
+	for (;;) {
+		int status, code;
+		pid_t waiting = waitpid(pid, &status, 0);
 
-	rev_list_pid = fork();
-	if (!rev_list_pid) {
-		rev_list_generate(fd, refs);
-		die("rev-list setup failed");
+		if (waiting < 0) {
+			if (errno == EINTR)
+				continue;
+			return error("waitpid failed (%s)", strerror(errno));
+		}
+		if ((waiting != pid) || WIFSIGNALED(status) ||
+		    !WIFEXITED(status))
+			return error("pack-objects died with strange error");
+		code = WEXITSTATUS(status);
+		if (code)
+			return -code;
+		return 0;
 	}
-	if (rev_list_pid < 0)
-		die("rev-list fork failed");
-	/*
-	 * We don't wait for the rev-list pipeline in the parent:
-	 * we end up waiting for the other end instead
-	 */
 }
 
 static void unmark_and_free(struct commit_list *list, unsigned int mark)
@@ -379,7 +324,7 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 
 	packet_flush(out);
 	if (new_refs)
-		pack_objects(out, remote_refs);
+		ret = pack_objects(out, remote_refs);
 	close(out);
 
 	if (expect_status_report) {
