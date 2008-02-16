From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] start_command(), .in/.out/.err = -1: Callers must close the file descriptor
Date: Sat, 16 Feb 2008 18:36:38 +0100
Message-ID: <1203183399-4813-1-git-send-email-johannes.sixt@telecom.at>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 18:37:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQQyV-00036J-Ig
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 18:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbYBPRgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 12:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755641AbYBPRgo
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 12:36:44 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:57160 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbYBPRgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 12:36:41 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 7D98EBF1D6;
	Sat, 16 Feb 2008 18:36:39 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74051>

By setting .in, .out, or .err members of struct child_process to -1, the
callers of start_command() can request that a pipe is allocated that talks
to the child process and one end is returned by replacing -1 with the
file descriptor.

Previously, a flag was set (for .in and .out, but not .err) to signal
finish_command() to close the pipe end that start_command() had handed out,
so it was optional for callers to close the pipe, and many already do so.
Now we make it mandatory to close the pipe.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-fetch-pack.c |    4 +++-
 builtin-send-pack.c  |    1 +
 builtin-tag.c        |    3 ++-
 builtin-verify-tag.c |    1 -
 bundle.c             |    1 +
 receive-pack.c       |    2 ++
 run-command.c        |    6 ------
 run-command.h        |    2 --
 8 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index f401352..5ea48ca 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -538,8 +538,10 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
 		die("fetch-pack: unable to fork off %s", argv[0]);
-	if (do_keep && pack_lockfile)
+	if (do_keep && pack_lockfile) {
 		*pack_lockfile = index_pack_lockfile(cmd.out);
+		close(cmd.out);
+	}
 
 	if (finish_command(&cmd))
 		die("%s failed", argv[0]);
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8afb1d0..ba9bc91 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -71,6 +71,7 @@ static int pack_objects(int fd, struct ref *refs)
 		refs = refs->next;
 	}
 
+	close(po.in);
 	if (finish_command(&po))
 		return error("pack-objects died with strange error");
 	return 0;
diff --git a/builtin-tag.c b/builtin-tag.c
index 4a4a88c..8f7936d 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -226,12 +226,13 @@ static int do_sign(struct strbuf *buffer)
 
 	if (write_in_full(gpg.in, buffer->buf, buffer->len) != buffer->len) {
 		close(gpg.in);
+		close(gpg.out);
 		finish_command(&gpg);
 		return error("gpg did not accept the tag data");
 	}
 	close(gpg.in);
-	gpg.close_in = 0;
 	len = strbuf_read(buffer, gpg.out, 1024);
+	close(gpg.out);
 
 	if (finish_command(&gpg) || !len || len < 0)
 		return error("gpg failed to sign the tag");
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index cc4c55d..b3010f9 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -52,7 +52,6 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 
 	write_in_full(gpg.in, buf, len);
 	close(gpg.in);
-	gpg.close_in = 0;
 	ret = finish_command(&gpg);
 
 	unlink(path);
diff --git a/bundle.c b/bundle.c
index 5c95eca..f150c19 100644
--- a/bundle.c
+++ b/bundle.c
@@ -332,6 +332,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 		write_or_die(rls.in, sha1_to_hex(object->sha1), 40);
 		write_or_die(rls.in, "\n", 1);
 	}
+	close(rls.in);
 	if (finish_command(&rls))
 		return error ("pack-objects died");
 
diff --git a/receive-pack.c b/receive-pack.c
index 3267495..a971433 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -132,6 +132,7 @@ static int run_hook(const char *hook_name)
 				break;
 		}
 	}
+	close(proc.in);
 	return hook_status(finish_command(&proc), hook_name);
 }
 
@@ -414,6 +415,7 @@ static const char *unpack(void)
 		if (start_command(&ip))
 			return "index-pack fork failed";
 		pack_lockfile = index_pack_lockfile(ip.out);
+		close(ip.out);
 		status = finish_command(&ip);
 		if (!status) {
 			reprepare_packed_git();
diff --git a/run-command.c b/run-command.c
index 476d00c..2919330 100644
--- a/run-command.c
+++ b/run-command.c
@@ -25,7 +25,6 @@ int start_command(struct child_process *cmd)
 		if (pipe(fdin) < 0)
 			return -ERR_RUN_COMMAND_PIPE;
 		cmd->in = fdin[1];
-		cmd->close_in = 1;
 	}
 
 	need_out = !cmd->no_stdout
@@ -38,7 +37,6 @@ int start_command(struct child_process *cmd)
 			return -ERR_RUN_COMMAND_PIPE;
 		}
 		cmd->out = fdout[0];
-		cmd->close_out = 1;
 	}
 
 	need_err = !cmd->no_stderr && cmd->err < 0;
@@ -157,10 +155,6 @@ static int wait_or_whine(pid_t pid)
 
 int finish_command(struct child_process *cmd)
 {
-	if (cmd->close_in)
-		close(cmd->in);
-	if (cmd->close_out)
-		close(cmd->out);
 	return wait_or_whine(cmd->pid);
 }
 
diff --git a/run-command.h b/run-command.h
index 1fc781d..e9c84d0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -19,8 +19,6 @@ struct child_process {
 	int err;
 	const char *dir;
 	const char *const *env;
-	unsigned close_in:1;
-	unsigned close_out:1;
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
 	unsigned no_stderr:1;
-- 
1.5.4.1.126.ge5a7d
