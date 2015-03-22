From: Jeff King <peff@peff.net>
Subject: [PATCH] status: read submodule process output before calling wait()
Date: Sun, 22 Mar 2015 03:44:56 -0400
Message-ID: <20150322074455.GA1303@peff.net>
References: <CAPx-p4sKD0Nut3E1jnWfPPx4=--ZOxBgiVdt3RRb5tktw31qDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 08:45:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZaZE-0006Rh-Ir
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 08:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbbCVHo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 03:44:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:36664 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751326AbbCVHo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 03:44:59 -0400
Received: (qmail 26435 invoked by uid 102); 22 Mar 2015 07:44:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 02:44:59 -0500
Received: (qmail 6359 invoked by uid 107); 22 Mar 2015 07:45:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 03:45:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 03:44:56 -0400
Content-Disposition: inline
In-Reply-To: <CAPx-p4sKD0Nut3E1jnWfPPx4=--ZOxBgiVdt3RRb5tktw31qDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266054>

On Sat, Mar 21, 2015 at 10:56:54PM -0700, Wincent Colaiuta wrote:

> I've never seen this hang before despite frequent use of submodules.
> Oddly, I was able to work around the hang by moving the submodule in
> two hops (one from Ansible v1.6.10 to v1.7.0, then from v1.7.0 to
> v1.8.4). I am not sure if this is specific to the Ansible repo, or
> whether the length of the summary is crossing some threshold that
> triggers the bug to manifest. If I run the forked commands manually
> from an interactive shell, they complete just fine.

It's the length of the summary. The fix is below.

-- >8 --
The status code tries to read the output of "git submodule
summary" over a pipe by waiting for the program to finish
and then reading its output, like this:

  run_command(&sm_summary);
  len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);

Besides being a violation of the run-command API (which
makes no promises about the state of the struct after
run_command returns), this can easily lead to deadlock. The
"submodule status" process may fill up the pipe buffer and
block on write(). Meanwhile, the reading side in the parent
process is blocked in wait(), waiting for the child to
finish.

Instead, we should start the process, read everything it
produces, and only then call wait() to finish it off.

Signed-off-by: Jeff King <peff@peff.net>
---
I notice that we also don't detect when the sub-command fails. I don't
know what we would do in that case (abort the status? print a message?)
and it's orthogonal to this issue, so I left it for somebody more
clueful in the area to think about.

 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 7036fa2..96f0033 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -748,9 +748,9 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	fflush(s->fp);
 	sm_summary.out = -1;
 
-	run_command(&sm_summary);
-
+	start_command(&sm_summary);
 	len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);
+	finish_command(&sm_summary);
 
 	/* prepend header, only if there's an actual output */
 	if (len) {
-- 
2.3.3.618.ga041503
