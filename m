From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches
 fail
Date: Thu, 23 Feb 2012 05:04:34 -0500
Message-ID: <20120223100434.GA3083@sigill.intra.peff.net>
References: <8739bacpql.fsf@thomas.inf.ethz.ch>
 <1327079011-24788-1-git-send-email-spearce@spearce.org>
 <20120222101302.GA11606@sigill.intra.peff.net>
 <CAJo=hJsFDrt4rsxVAnx86bxZDY3yfWc1=GDd8opUU+9z7esLnw@mail.gmail.com>
 <20120222204050.GB6781@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 11:04:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VXk-0008Jm-6X
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 11:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab2BWKEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 05:04:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48632
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab2BWKEk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 05:04:40 -0500
Received: (qmail 8386 invoked by uid 107); 23 Feb 2012 10:04:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Feb 2012 05:04:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2012 05:04:34 -0500
Content-Disposition: inline
In-Reply-To: <20120222204050.GB6781@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191345>

On Wed, Feb 22, 2012 at 03:40:50PM -0500, Jeff King wrote:

> I'll re-send the patch with a stand-alone commit message.

Here it is.

-- >8 --
Subject: [PATCH] disconnect from remote helpers more gently

When git spawns a remote helper program (like git-remote-http),
the last thing we do before closing the pipe to the child
process is to send a blank line, telling the helper that we
are done issuing commands. However, the helper may already
have exited, in which case the parent git process will
receive SIGPIPE and die.

In particular, this can happen with the remote-curl helper
when it encounters errors during a push. The helper reports
individual errors for each ref back to git-push, and then
exits with a non-zero exit code. Depending on the exact
timing of the write, the parent process may or may not
receive SIGPIPE.

This causes intermittent test failure in t5541.8, and is a
side effect of 5238cbf (remote-curl: Fix push status report
when all branches fail). Before that commit, remote-curl
would not send the final blank line to indicate that the
list of status lines was complete; it would just exit,
closing the pipe. The parent git-push would notice the
closed pipe while reading the status report and exit
immediately itself, propagating the failing exit code. But
post-5238cbf, remote-curl completes the status list before
exiting, git-push actually runs to completion, and then it
tries to cleanly disconnect the helper, leading to the
SIGPIPE race above.

This patch drops all error-checking when sending the final
"we are about to hang up" blank line to helpers. There is
nothing useful for the parent process to do about errors at
that point anyway, and certainly failing to send our "we are
done with commands" line to a helper that has already exited
is not a problem.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 6f227e2..f6b3b1f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -9,6 +9,7 @@
 #include "remote.h"
 #include "string-list.h"
 #include "thread-utils.h"
+#include "sigchain.h"
 
 static int debug;
 
@@ -220,15 +221,21 @@ static struct child_process *get_helper(struct transport *transport)
 static int disconnect_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
-	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
 
 	if (data->helper) {
 		if (debug)
 			fprintf(stderr, "Debug: Disconnecting.\n");
 		if (!data->no_disconnect_req) {
-			strbuf_addf(&buf, "\n");
-			sendline(data, &buf);
+			/*
+			 * Ignore write errors; there's nothing we can do,
+			 * since we're about to close the pipe anyway. And the
+			 * most likely error is EPIPE due to the helper dying
+			 * to report an error itself.
+			 */
+			sigchain_push(SIGPIPE, SIG_IGN);
+			xwrite(data->helper->in, "\n", 1);
+			sigchain_pop(SIGPIPE);
 		}
 		close(data->helper->in);
 		close(data->helper->out);
-- 
1.7.8.4.8.g10fac
