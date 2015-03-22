From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: read submodule process output before calling
 wait()
Date: Sun, 22 Mar 2015 04:07:08 -0400
Message-ID: <20150322080708.GA3456@peff.net>
References: <CAPx-p4sKD0Nut3E1jnWfPPx4=--ZOxBgiVdt3RRb5tktw31qDg@mail.gmail.com>
 <20150322074455.GA1303@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 09:07:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZaun-0003BM-91
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 09:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbCVIHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 04:07:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:36672 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751481AbbCVIHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 04:07:10 -0400
Received: (qmail 27488 invoked by uid 102); 22 Mar 2015 08:07:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 03:07:11 -0500
Received: (qmail 6477 invoked by uid 107); 22 Mar 2015 08:07:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 04:07:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 04:07:08 -0400
Content-Disposition: inline
In-Reply-To: <20150322074455.GA1303@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266055>

On Sun, Mar 22, 2015 at 03:44:55AM -0400, Jeff King wrote:

> The status code tries to read the output of "git submodule
> summary" over a pipe by waiting for the program to finish
> and then reading its output, like this:
> 
>   run_command(&sm_summary);
>   len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);

By the way, I spotted this code as bogus immediately upon seeing it
(though certainly it helped to know there was a deadlock in the area,
which had me thinking about such things). So I wondered if it could have
been easy to catch in review, but its introduction was a little bit
subtle.

The original run_command invocation came in ac8d5af (builtin-status:
submodule summary support, 2008-04-12), which just let the sub-process
dump its stdout to the same descriptor that the rest of the status
output was going to. So the use of run_command there was fine. It was
later, in 3ba7407 (submodule summary: ignore --for-status option,
2013-09-06), that we started post-processing the output and it became
buggy. But that's harder to see in review.

> Besides being a violation of the run-command API (which
> makes no promises about the state of the struct after
> run_command returns),

This may be overly harsh of me. Certainly we make no guarantees (and
things like the dynamic "args" and "env_array" are cleaned up
automatically after finish_command returns), but I would not be
surprised if there are other spots that treat "struct child_process" as
transparent rather than as a black box.

It's really the run_command + pipe construct that is really the danger
here. I wonder if we should do something like this:

diff --git a/run-command.c b/run-command.c
index 3afb124..78807de 100644
--- a/run-command.c
+++ b/run-command.c
@@ -557,7 +557,12 @@ int finish_command(struct child_process *cmd)
 
 int run_command(struct child_process *cmd)
 {
-	int code = start_command(cmd);
+	int code;
+
+	if (cmd->out < 0)
+		die("BUG: run_command with a pipe can cause deadlock");
+
+	code = start_command(cmd);
 	if (code)
 		return code;
 	return finish_command(cmd);

It seems to catch at least one other dubious construct.

-Peff
