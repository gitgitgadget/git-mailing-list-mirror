From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver definition.
Date: Sat, 21 Apr 2007 20:39:29 -0400
Message-ID: <20070422003929.GD17480@spearce.org>
References: <11771520591529-git-send-email-junkio@cox.net> <11771520591703-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 02:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfQ7I-0005Qv-Mo
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 02:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbXDVAje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 20:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbXDVAje
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 20:39:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35439 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbXDVAjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 20:39:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfQ6r-0000H5-AN; Sat, 21 Apr 2007 20:39:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE9E520FBAE; Sat, 21 Apr 2007 20:39:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11771520591703-git-send-email-junkio@cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45200>

Junio C Hamano <junkio@cox.net> wrote:
> The interface is similar to the custom low-level merge drivers.
... 
> +static int filter_buffer(const char *path, const char *src,
> +			 unsigned long size, const char *cmd)
> +{
> +	/*
> +	 * Spawn cmd and feed the buffer contents through its stdin.
> +	 */
...

ick.  What about something like this on top?  I moved the extra child
process for the input pipe down into the start_command routine,
where we can do something a little smarter on some systems, like
using a thread rather than a full process.  Its also a shorter
patch and uses more of the run-command API.

Its not documented very well, but if you set child_process.{in,out}
to <0 we open the pipe for you, and close your side of the pipe
for you.  That really simplifies the logic in the callers.

I did consider rewriting this as a select() based loop to feed the
input and read the output, but that might not port well onto a more
native Win32 based set of APIs.

---
diff --git a/convert.c b/convert.c
index 62d8cee..2ba7ea3 100644
--- a/convert.c
+++ b/convert.c
@@ -201,99 +201,37 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	return buffer;
 }
 
-static int filter_buffer(const char *path, const char *src,
-			 unsigned long size, const char *cmd)
-{
-	/*
-	 * Spawn cmd and feed the buffer contents through its stdin.
-	 */
-	struct child_process child_process;
-	int pipe_feed[2];
-	int write_err, status;
-
-	memset(&child_process, 0, sizeof(child_process));
-
-	if (pipe(pipe_feed) < 0) {
-		error("cannot create pipe to run external filter %s", cmd);
-		return 1;
-	}
-
-	child_process.pid = fork();
-	if (child_process.pid < 0) {
-		error("cannot fork to run external filter %s", cmd);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		return 1;
-	}
-	if (!child_process.pid) {
-		dup2(pipe_feed[0], 0);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		execlp(cmd, cmd, NULL);
-		return 1;
-	}
-	close(pipe_feed[0]);
-
-	write_err = (write_in_full(pipe_feed[1], src, size) < 0);
-	if (close(pipe_feed[1]))
-		write_err = 1;
-	if (write_err)
-		error("cannot feed the input to external filter %s", cmd);
-
-	status = finish_command(&child_process);
-	if (status)
-		error("external filter %s failed %d", cmd, -status);
-	return (write_err || status);
-}
-
 static char *apply_filter(const char *path, const char *src,
 			  unsigned long *sizep, const char *cmd)
 {
-	/*
-	 * Create a pipeline to have the command filter the buffer's
-	 * contents.
-	 *
-	 * (child --> cmd) --> us
-	 */
 	const int SLOP = 4096;
-	int pipe_feed[2];
+	struct child_process filter_process;
+	const char *filter_argv[] = {cmd, NULL};
 	int status;
 	char *dst;
 	unsigned long dstsize, dstalloc;
-	struct child_process child_process;
 
 	if (!cmd)
 		return NULL;
 
-	memset(&child_process, 0, sizeof(child_process));
-
-	if (pipe(pipe_feed) < 0) {
-		error("cannot create pipe to run external filter %s", cmd);
-		return NULL;
-	}
-
-	child_process.pid = fork();
-	if (child_process.pid < 0) {
-		error("cannot fork to run external filter %s", cmd);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
+	memset(&filter_process, 0, sizeof(filter_process));
+	filter_process.in_bufptr = src;
+	filter_process.in_buflen = *sizep;
+	filter_process.out = -1;
+	filter_process.argv = filter_argv;
+	status = start_command(&filter_process);
+	if (status) {
+		error("external filter %s failed %d", cmd, -status);
 		return NULL;
 	}
-	if (!child_process.pid) {
-		dup2(pipe_feed[1], 1);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		exit(filter_buffer(path, src, *sizep, cmd));
-	}
-	close(pipe_feed[1]);
 
 	dstalloc = *sizep;
 	dst = xmalloc(dstalloc);
 	dstsize = 0;
 
 	while (1) {
-		ssize_t numread = xread(pipe_feed[0], dst + dstsize,
-					dstalloc - dstsize);
+		ssize_t numread = xread(filter_process.out,
+			dst + dstsize, dstalloc - dstsize);
 
 		if (numread <= 0) {
 			if (!numread)
@@ -310,7 +248,7 @@ static char *apply_filter(const char *path, const char *src,
 		}
 	}
 
-	status = finish_command(&child_process);
+	status = finish_command(&filter_process);
 	if (status) {
 		error("external filter %s failed %d", cmd, -status);
 		free(dst);
diff --git a/run-command.c b/run-command.c
index eff523e..72887f8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -20,12 +20,29 @@ int start_command(struct child_process *cmd)
 	int need_in, need_out;
 	int fdin[2], fdout[2];
 
-	need_in = !cmd->no_stdin && cmd->in < 0;
+	need_in = !cmd->no_stdin && (cmd->in_bufptr || cmd->in < 0);
 	if (need_in) {
 		if (pipe(fdin) < 0)
 			return -ERR_RUN_COMMAND_PIPE;
-		cmd->in = fdin[1];
-		cmd->close_in = 1;
+		if (cmd->in_bufptr) {
+			pid_t in_feeder = fork();
+			if (in_feeder < 0) {
+				close_pair(fdin);
+				return -ERR_RUN_COMMAND_PIPE;
+			}
+			if (!in_feeder) {
+				close(fdin[0]);
+				if (write_in_full(fdin[1],
+					cmd->in_bufptr,
+					cmd->in_buflen) != cmd->in_buflen)
+					die("'%s' did not read all input", cmd->argv[0]);
+				exit(0);
+			}
+			close(fdin[1]);
+		} else {
+			cmd->in = fdin[1];
+			cmd->close_in = 1;
+		}
 	}
 
 	need_out = !cmd->no_stdout
diff --git a/run-command.h b/run-command.h
index 3680ef9..7632843 100644
--- a/run-command.h
+++ b/run-command.h
@@ -13,6 +13,8 @@ enum {
 
 struct child_process {
 	const char **argv;
+	const char *in_bufptr;
+	size_t in_buflen;
 	pid_t pid;
 	int in;
 	int out;
-- 
1.5.1.1.135.gf948


-- 
Shawn.
