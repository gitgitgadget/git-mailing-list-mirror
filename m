From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH v2] start_command(), if .in/.out > 0, closes file descriptors, not the callers
Date: Thu, 21 Feb 2008 23:42:56 +0100
Message-ID: <200802212342.56629.johannes.sixt@telecom.at>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org> <7vmyq07bqe.fsf@gitster.siamese.dyndns.org> <200802171029.17850.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 23:43:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSK8k-0006aW-RU
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 23:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761837AbYBUWnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 17:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761894AbYBUWnF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 17:43:05 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:48582 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761812AbYBUWnB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 17:43:01 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 0AC4F13A41E;
	Thu, 21 Feb 2008 23:42:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A88D85BC26;
	Thu, 21 Feb 2008 23:42:57 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <200802171029.17850.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74673>

Callers of start_command() can set the members .in and .out of struct
child_process to a value > 0 to specify that this descriptor is used as
the stdin or stdout of the child process.

Previously, if start_command() was successful, this descriptor was closed
upon return. Here we now make sure that the descriptor is also closed in
case of failures. All callers are updated not to close the file descriptor
themselves after start_command() was called.

Note that earlier run_gpg_verify() of git-verify-tag set .out = 1, which
worked because start_command() treated this as a special case, but now
this is incorrect because it closes the descriptor. The intent here is to
inherit stdout to the child, which is achieved by .out = 0.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
On Sunday 17 February 2008 10:29, Johannes Sixt wrote:
> On Saturday 16 February 2008 23:55, Junio C Hamano wrote:
> > Johannes Sixt <johannes.sixt@telecom.at> writes:
> > > +	 * - Specify > 0 to give away a FD as follows:
> > > +	 *     .in: a readable FD, becomes child's stdin
> > > +	 *     .out: a writable FD, becomes child's stdout/stderr
> > > +	 *     .err > 0 not supported
> > > +	 *   The specified FD is closed by start_command(), even in case
> > > +	 *   of errors!
> >
> > Perhaps you would need to spell out the semantic differences you
> > are assigning to "inherit" vs "give away".  I presume the former
> > is something run_command() would not touch vs the latter is
> > closed by run_command()?
>
> I'll clearify it.

And here it is.

The other issues you raised -- ->out sometimes compared > 0, sometimes > 1,
and treated different from ->in -- I addressed, too, by adjusting all uses
that were inconsitent. Note that there is still one ->out > 0, but that is
because we don't have set up need_out at this time, and I also left the
cmd->out > 1 in the child process alone.

Note also the amended commit message that describes the change in
builtin-verify-tag.c.

-- Hannes

 builtin-send-pack.c  |   14 ++++++++------
 builtin-verify-tag.c |    1 -
 bundle.c             |    5 +++--
 run-command.c        |   22 ++++++++++++++++++++--
 run-command.h        |   18 ++++++++++++++++++
 5 files changed, 49 insertions(+), 11 deletions(-)

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
index 4352ce8..0ba5df1 100644
--- a/bundle.c
+++ b/bundle.c
@@ -336,8 +336,9 @@ int create_bundle(struct bundle_header *header, const char *path,
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
index 2919330..743757c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -20,10 +20,18 @@ int start_command(struct child_process *cmd)
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
 
+	/*
+	 * In case of errors we must keep the promise to close FDs
+	 * that have been passed in via ->in and ->out.
+	 */
+
 	need_in = !cmd->no_stdin && cmd->in < 0;
 	if (need_in) {
-		if (pipe(fdin) < 0)
+		if (pipe(fdin) < 0) {
+			if (cmd->out > 0)
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
+			else if (cmd->out)
+				close(cmd->out);
 			return -ERR_RUN_COMMAND_PIPE;
 		}
 		cmd->err = fderr[0];
@@ -55,8 +69,12 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0) {
 		if (need_in)
 			close_pair(fdin);
+		else if (cmd->in)
+			close(cmd->in);
 		if (need_out)
 			close_pair(fdout);
+		else if (cmd->out)
+			close(cmd->out);
 		if (need_err)
 			close_pair(fderr);
 		return -ERR_RUN_COMMAND_FORK;
@@ -118,7 +136,7 @@ int start_command(struct child_process *cmd)
 
 	if (need_out)
 		close(fdout[1]);
-	else if (cmd->out > 1)
+	else if (cmd->out)
 		close(cmd->out);
 
 	if (need_err)
diff --git a/run-command.h b/run-command.h
index e9c84d0..debe307 100644
--- a/run-command.h
+++ b/run-command.h
@@ -14,6 +14,24 @@ enum {
 struct child_process {
 	const char **argv;
 	pid_t pid;
+	/*
+	 * Using .in, .out, .err:
+	 * - Specify 0 for no redirections (child inherits stdin, stdout,
+	 *   stderr from parent).
+	 * - Specify -1 to have a pipe allocated as follows:
+	 *     .in: returns the writable pipe end; parent writes to it,
+	 *          the readable pipe end becomes child's stdin
+	 *     .out, .err: returns the readable pipe end; parent reads from
+	 *          it, the writable pipe end becomes child's stdout/stderr
+	 *   The caller of start_command() must close the returned FDs
+	 *   after it has completed reading from/writing to it!
+	 * - Specify > 0 to set a channel to a particular FD as follows:
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
