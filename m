From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] start_command(), if .in/.out > 0, closes file descriptors, not the callers
Date: Sat, 16 Feb 2008 18:36:39 +0100
Message-ID: <1203183399-4813-2-git-send-email-johannes.sixt@telecom.at>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org>
 <1203183399-4813-1-git-send-email-johannes.sixt@telecom.at>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 18:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQQyU-00036J-Kx
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 18:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbYBPRgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 12:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755604AbYBPRgn
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 12:36:43 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:57163 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbYBPRgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 12:36:41 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 17096BF1DE;
	Sat, 16 Feb 2008 18:36:40 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1203183399-4813-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74050>

Callers of start_command() can set the members .in and .out of struct
child_process to a value > 0 to specify that this descriptor is used as
the stdin or stdout of the child process.

Previously, if start_command() was successful, this descriptor was closed
upon return. Here we now make sure that the descriptor is also closed in
case of failures. All callers are updated not to close the file descriptor
themselves after start_command() was called.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-send-pack.c  |   14 ++++++++------
 builtin-verify-tag.c |    1 -
 bundle.c             |    5 +++--
 run-command.c        |   20 +++++++++++++++++++-
 run-command.h        |   17 +++++++++++++++++
 5 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index ba9bc91..b0cfae8 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -404,12 +404,15 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-					       nr_refspec, refspec, flags))
+		       nr_refspec, refspec, flags)) {
+		close(out);
 		return -1;
+	}
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
 			"Perhaps you should specify a branch such as 'master'.\n");
+		close(out);
 		return 0;
 	}
 
@@ -496,12 +499,11 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 
 	packet_flush(out);
 	if (new_refs && !args.dry_run) {
-		if (pack_objects(out, remote_refs) < 0) {
-			close(out);
+		if (pack_objects(out, remote_refs) < 0)
 			return -1;
-		}
 	}
-	close(out);
+	else
+		close(out);
 
 	if (expect_status_report)
 		ret = receive_status(in, remote_refs);
@@ -649,7 +651,7 @@ int send_pack(struct send_pack_args *my_args,
 	conn = git_connect(fd, dest, args.receivepack, args.verbose ? CONNECT_VERBOSE : 0);
 	ret = do_send_pack(fd[0], fd[1], remote, dest, nr_heads, heads);
 	close(fd[0]);
-	close(fd[1]);
+	/* do_send_pack always closes fd[1] */
 	ret |= finish_connect(conn);
 	return !!ret;
 }
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index b3010f9..f3ef11f 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -45,7 +45,6 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args_gpg;
 	gpg.in = -1;
-	gpg.out = 1;
 	args_gpg[2] = path;
 	if (start_command(&gpg))
 		return error("could not run gpg.");
diff --git a/bundle.c b/bundle.c
index f150c19..eac7350 100644
--- a/bundle.c
+++ b/bundle.c
@@ -335,8 +335,9 @@ int create_bundle(struct bundle_header *header, const char *path,
 	close(rls.in);
 	if (finish_command(&rls))
 		return error ("pack-objects died");
-
-	return bundle_to_stdout ? close(bundle_fd) : commit_lock_file(&lock);
+	if (!bundle_to_stdout)
+		commit_lock_file(&lock);
+	return 0;
 }
 
 int unbundle(struct bundle_header *header, int bundle_fd)
diff --git a/run-command.c b/run-command.c
index 2919330..6c35d3c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -20,10 +20,18 @@ int start_command(struct child_process *cmd)
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
 
+	/*
+	 * In case of errors we must keep the promise to close FDs
+	 * that have been passed in in ->in, ->out, and ->err.
+	 */
+
 	need_in = !cmd->no_stdin && cmd->in < 0;
 	if (need_in) {
-		if (pipe(fdin) < 0)
+		if (pipe(fdin) < 0) {
+			if (cmd->out > 1)
+				close(cmd->out);
 			return -ERR_RUN_COMMAND_PIPE;
+		}
 		cmd->in = fdin[1];
 	}
 
@@ -34,6 +42,8 @@ int start_command(struct child_process *cmd)
 		if (pipe(fdout) < 0) {
 			if (need_in)
 				close_pair(fdin);
+			else if (cmd->in)
+				close(cmd->in);
 			return -ERR_RUN_COMMAND_PIPE;
 		}
 		cmd->out = fdout[0];
@@ -44,8 +54,12 @@ int start_command(struct child_process *cmd)
 		if (pipe(fderr) < 0) {
 			if (need_in)
 				close_pair(fdin);
+			else if (cmd->in)
+				close(cmd->in);
 			if (need_out)
 				close_pair(fdout);
+			else if (cmd->out > 1)
+				close(cmd->out);
 			return -ERR_RUN_COMMAND_PIPE;
 		}
 		cmd->err = fderr[0];
@@ -55,8 +69,12 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0) {
 		if (need_in)
 			close_pair(fdin);
+		else if (cmd->in > 0)
+			close(cmd->in);
 		if (need_out)
 			close_pair(fdout);
+		else if (cmd->out > 1)
+			close(cmd->out);
 		if (need_err)
 			close_pair(fderr);
 		return -ERR_RUN_COMMAND_FORK;
diff --git a/run-command.h b/run-command.h
index e9c84d0..0e67472 100644
--- a/run-command.h
+++ b/run-command.h
@@ -14,6 +14,23 @@ enum {
 struct child_process {
 	const char **argv;
 	pid_t pid;
+	/*
+	 * Using .in, .out, .err:
+	 * - Specify 0 to inherit stdin, stdout, stderr from parent.
+	 * - Specify -1 to have a pipe allocated as follows:
+	 *     .in: returns the writable pipe end; parent writes to it,
+	 *          the readable pipe end becomes child's stdin
+	 *     .out, .err: returns the readable pipe end; parent reads from
+	 *          it, the writable pipe end becomes child's stdout/stderr
+	 *   The caller of start_command() must close the returned FDs
+	 *   after it has completed reading from/writing to it!
+	 * - Specify > 0 to give away a FD as follows:
+	 *     .in: a readable FD, becomes child's stdin
+	 *     .out: a writable FD, becomes child's stdout/stderr
+	 *     .err > 0 not supported
+	 *   The specified FD is closed by start_command(), even in case
+	 *   of errors!
+	 */
 	int in;
 	int out;
 	int err;
-- 
1.5.4.1.126.ge5a7d
