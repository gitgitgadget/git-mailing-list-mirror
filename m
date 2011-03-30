From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 23:30:17 -0400
Message-ID: <20110330033017.GA18157@sigill.intra.peff.net>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 05:30:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4m70-0007jx-Kw
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 05:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342Ab1C3DaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 23:30:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45161
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab1C3DaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 23:30:20 -0400
Received: (qmail 5258 invoked by uid 107); 30 Mar 2011 03:31:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 23:31:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 23:30:17 -0400
Content-Disposition: inline
In-Reply-To: <20110330002921.GC14578@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170350>

On Tue, Mar 29, 2011 at 07:29:21PM -0500, Jonathan Nieder wrote:

> > Did you try my 5>/dev/null patch? With it, I get no hang at all.
> 
> Haven't tried it yet but will try.
> 
> I really don't like that as a long-term solution.  Yes, it gets prove
> to stop hanging, but meanwhile we have no control over the child
> processes we have spawned.  I'd rather just drop the tests.

Agreed, it's a horrible fix. I just wanted to make sure it fixed it for
you, too. After thinking on it more, I figured out an elegant fix.
Patch is below.

-- >8 --
Subject: [PATCH] t0081: kill backgrounded processes more robustly

This test creates several background processes that write to
a fifo and then go to sleep for a while (so the reader of
the fifo does not see EOF).

Each background process is made in a curly-braced block in
the shell, and after we are done reading from the fifo, we
use "kill $!" to kill it off.

For a simple, single-command process, this works reliably
and kills the child sleep process. But for more complex
commands like "make_some_output && sleep", the results are
less predictable. When executing under bash, we end up with
a subshell that gets killed by the $! but leaves the sleep
process still alive.

This is bad not only for process hygeine (we are leaving
random sleep processes to expire after a while), but also
interacts badly with the "prove" command. When prove
executes a test, it does not realize the test is done when
it sees SIGCHLD, but rather waits until the test's stdout
pipe is closed. The orphaned sleep process may keep that
pipe open via test-lib's file descriptor 5, causing prove to
hang for 100 seconds.

The solution is to explicitly use a subshell and to exec the
final sleep process, so that when we "kill $!" we get the
process id of the sleep process.

While we're at it, let's make the "kill" process a little
more robust. Specifically:

  1. Wrap the "kill" in a test_when_finished, since we want
     to clean up the process whether the test succeeds or not.

  2. The "kill" is part of our && chain for test success. It
     probably won't fail, but it can if the process has
     expired before we manage to kill it. So let's mark it
     as OK to fail.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, my (2) above is unlikely to trigger, since the test would have
to hang for 100 seconds first, which probably means it is failing
anyway. But I did run across it when I screwed up my fix.

Also, is it just me, or does it seem weird that test_when_finished
blocks failing can produce test failure? I would think you would be able
to put any old cleanup crap into them and not care whether it worked or
not.

 t/t0081-line-buffer.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 1dbe1c9..416ccc1 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -47,16 +47,16 @@ long_read_test () {
 	rm -f input &&
 	mkfifo input &&
 	{
-		{
+		(
 			generate_tens_of_lines $tens_of_lines "$line" &&
-			sleep 100
-		} >input &
+			exec sleep 100
+		) >input &
 	} &&
+	test_when_finished "kill $! || true" &&
 	test-line-buffer input <<-EOF >output &&
 	binary $readsize
 	copy $copysize
 	EOF
-	kill $! &&
 	test_line_count = $lines output &&
 	tail -n 1 <output >actual &&
 	test_cmp expect actual
@@ -86,11 +86,11 @@ test_expect_success PIPE '0-length read, no input available' '
 	{
 		sleep 100 >input &
 	} &&
+	test_when_finished "kill $! || true" &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 0
 	copy 0
 	EOF
-	kill $! &&
 	test_cmp expect actual
 '
 
@@ -109,17 +109,17 @@ test_expect_success PIPE '1-byte read, no input available' '
 	rm -f input &&
 	mkfifo input &&
 	{
-		{
+		(
 			printf "%s" a &&
 			printf "%s" b &&
-			sleep 100
-		} >input &
+			exec sleep 100
+		) >input &
 	} &&
+	test_when_finished "kill $! || true" &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 1
 	copy 1
 	EOF
-	kill $! &&
 	test_cmp expect actual
 '
 
-- 
1.7.4.2.7.g9407
