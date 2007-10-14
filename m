From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH amend 14/14] Use the asyncronous function infrastructure to run the content filter.
Date: Sun, 14 Oct 2007 19:14:11 +0200
Message-ID: <200710141914.11775.johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <1192305984-22594-15-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0710140404480.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih72m-0000Ff-5z
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbXJNROO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbXJNROO
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:14:14 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:45867 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbXJNRON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:14:13 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 309E9BF7FF;
	Sun, 14 Oct 2007 19:14:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id EDACE58CE9;
	Sun, 14 Oct 2007 19:14:11 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0710140404480.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60874>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
On Sunday 14 October 2007 05:07, Johannes Schindelin wrote:
> On Sat, 13 Oct 2007, Johannes Sixt wrote:
> >  	status = finish_command(&child_process);
> >  	if (status)
> > -		error("external filter %s failed %d", cmd, -status);
> > +		error("external filter %s failed", params->cmd);
>
> Did you mean to remove the status from the output (it should probably read
> "(exit status %d)" instead of just "%d", but an exit status can help
> identify problems, right?

I didn't mean to change the error message here.

> > +	if (start_async(&async))
> > +		return 0;	/* error was already reported */
>
> Please write "return NULL;"

This patch now does just that.

-- Hannes

 convert.c |   60 +++++++++++++++++++++++++++---------------------------------
 1 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/convert.c b/convert.c
index c870817..ac04157 100644
--- a/convert.c
+++ b/convert.c
@@ -201,15 +201,21 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	return buffer;
 }
 
-static int filter_buffer(int fd, const char *src,
-			 unsigned long size, const char *cmd)
+struct filter_params {
+	const char *src;
+	unsigned long size;
+	const char *cmd;
+};
+
+static int filter_buffer(int fd, void *data)
 {
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
 	 */
 	struct child_process child_process;
+	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
-	const char *argv[] = { "sh", "-c", cmd, NULL };
+	const char *argv[] = { "sh", "-c", params->cmd, NULL };
 
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
@@ -217,17 +223,17 @@ static int filter_buffer(int fd, const char *src,
 	child_process.out = fd;
 
 	if (start_command(&child_process))
-		return error("cannot fork to run external filter %s", cmd);
+		return error("cannot fork to run external filter %s", params->cmd);
 
-	write_err = (write_in_full(child_process.in, src, size) < 0);
+	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
-		error("cannot feed the input to external filter %s", cmd);
+		error("cannot feed the input to external filter %s", params->cmd);
 
 	status = finish_command(&child_process);
 	if (status)
-		error("external filter %s failed %d", cmd, -status);
+		error("external filter %s failed %d", params->cmd, -status);
 	return (write_err || status);
 }
 
@@ -241,42 +247,31 @@ static char *apply_filter(const char *path, const char *src,
 	 * (child --> cmd) --> us
 	 */
 	const int SLOP = 4096;
-	int pipe_feed[2];
-	int status;
 	char *dst;
 	unsigned long dstsize, dstalloc;
-	struct child_process child_process;
+	struct async async;
+	struct filter_params params;
 
 	if (!cmd)
 		return NULL;
 
-	memset(&child_process, 0, sizeof(child_process));
-
-	if (pipe(pipe_feed) < 0) {
-		error("cannot create pipe to run external filter %s", cmd);
-		return NULL;
-	}
+	memset(&async, 0, sizeof(async));
+	async.proc = filter_buffer;
+	async.data = &params;
+	params.src = src;
+	params.size = *sizep;
+	params.cmd = cmd;
 
 	fflush(NULL);
-	child_process.pid = fork();
-	if (child_process.pid < 0) {
-		error("cannot fork to run external filter %s", cmd);
-		close(pipe_feed[0]);
-		close(pipe_feed[1]);
-		return NULL;
-	}
-	if (!child_process.pid) {
-		close(pipe_feed[0]);
-		exit(filter_buffer(pipe_feed[1], src, *sizep, cmd));
-	}
-	close(pipe_feed[1]);
+	if (start_async(&async))
+		return NULL;	/* error was already reported */
 
 	dstalloc = *sizep;
 	dst = xmalloc(dstalloc);
 	dstsize = 0;
 
 	while (1) {
-		ssize_t numread = xread(pipe_feed[0], dst + dstsize,
+		ssize_t numread = xread(async.out, dst + dstsize,
 					dstalloc - dstsize);
 
 		if (numread <= 0) {
@@ -293,15 +288,14 @@ static char *apply_filter(const char *path, const char *src,
 			dst = xrealloc(dst, dstalloc);
 		}
 	}
-	if (close(pipe_feed[0])) {
+	if (close(async.out)) {
 		error("read from external filter %s failed", cmd);
 		free(dst);
 		dst = NULL;
 	}
 
-	status = finish_command(&child_process);
-	if (status) {
-		error("external filter %s failed %d", cmd, -status);
+	if (finish_async(&async)) {
+		error("external filter %s failed", cmd);
 		free(dst);
 		dst = NULL;
 	}
-- 
1.5.3.2.141.g48f10
