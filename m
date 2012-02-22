From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches
 fail
Date: Wed, 22 Feb 2012 05:13:02 -0500
Message-ID: <20120222101302.GA11606@sigill.intra.peff.net>
References: <8739bacpql.fsf@thomas.inf.ethz.ch>
 <1327079011-24788-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 11:13:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S09CG-0003Ux-9I
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 11:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab2BVKNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 05:13:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47004
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113Ab2BVKNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 05:13:08 -0500
Received: (qmail 27260 invoked by uid 107); 22 Feb 2012 10:13:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 05:13:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 05:13:02 -0500
Content-Disposition: inline
In-Reply-To: <1327079011-24788-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191244>

On Fri, Jan 20, 2012 at 09:03:31AM -0800, Shawn O. Pearce wrote:

> diff --git a/remote-curl.c b/remote-curl.c
> index 48c20b8..25c1af7 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -822,12 +822,13 @@ static void parse_push(struct strbuf *buf)
>  			break;
>  	} while (1);
>  
> -	if (push(nr_spec, specs))
> -		exit(128); /* error already reported */
> -
> +	ret = push(nr_spec, specs);
>  	printf("\n");
>  	fflush(stdout);
>  
> +	if (ret)
> +		exit(128); /* error already reported */
> +

This hunk is causing intermittent failures of t5541 for me, especially
when the system is under heavy load (e.g., make -j32 test). Before your
patch, this is what happened:

  1. remote-curl relays the status lines from send-pack, then sees that
     send-pack reported error, and it exits

  2. push reads the status lines, looking for a blank line to terminate
     them. It sees EOF instead of the blank line and exits(128) itself.

After your patch, this happens:

  1. remote-curl relays the status lines, alway appends the blank line
     terminator, and then exits

  2. push reads the status lines, including the blank line terminator,
     and reports them to the user.

  3. push then disconnects the remote-curl helper by writing a blank
     line to it (to signal end-of-input), followed by finish_command().
     The latter propagates the error code from the exit in step 1, and
     we use that to signal failure from "git push".

There's a race condition now in step 3. The push process may write to
the pipe going to remote-curl after it has exited, causing it to receive
SIGPIPE and die.  We can block SIGPIPE, but that's not sufficient; we'll
still notice that our write() returns EPIPE and die.

Obviously we can't not print the post-push "\n" in remote-curl, for the
reasons you outlined in the commit message of this patch. We also can't
not exit from remote-curl on error. Even though in the test in t5541 we
have signaled error via the ref statuses, we might have received an
error that does not come through a ref status (e.g., if we couldn't run
send-pack at all).

We can't not write the "\n" to signal end-of-input to remote-curl,
because we don't actually know yet that there's an error (we find out
when we wait() on the process). Barring any asynchronous SIGCHLD
handling, of course, but I don't think we want to get into that.

So it's kind of a bug in the remote helper protocol. The helpers can
signal failure only by dying, but we can find out about that failure
only after disconnecting, which involves writing to them. It would be
much more sane if the helpers returned an overall text status from each
command (e.g., printed "error push failed" instead of dying).

But that would involve changing the protocol, of course. I think our
best option is to work around it by considering the final blank line we
send before disconnect as "best effort". That is, it is a courtesy to
the remote helper to tell it we are hanging up cleanly, and if it does
not arrive, then we can ignore the problem and proceed with closing the
pipe. I.e., something like:

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

which makes the t5541 failures go away for me. What do you think?

-Peff
