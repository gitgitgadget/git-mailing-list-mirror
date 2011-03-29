From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 18:16:52 -0400
Message-ID: <20110329221652.GB23510@sigill.intra.peff.net>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:17:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4hDk-0003uO-0O
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 00:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab1C2WQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 18:16:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47803
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab1C2WQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 18:16:56 -0400
Received: (qmail 678 invoked by uid 107); 29 Mar 2011 22:17:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 18:17:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 18:16:52 -0400
Content-Disposition: inline
In-Reply-To: <20110329200230.GA377@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170332>

On Tue, Mar 29, 2011 at 03:02:48PM -0500, Jonathan Nieder wrote:

> Next step is to figure out the longstanding mysterious bash + prove
> hang in t0081.

This patch solves it for me:

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 1dbe1c9..7ea1317 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -50,7 +50,7 @@ long_read_test () {
 		{
 			generate_tens_of_lines $tens_of_lines "$line" &&
 			sleep 100
-		} >input &
+		} >input 5>/dev/null &
 	} &&
 	test-line-buffer input <<-EOF >output &&
 	binary $readsize
@@ -84,7 +84,7 @@ test_expect_success PIPE '0-length read, no input available' '
 	rm -f input &&
 	mkfifo input &&
 	{
-		sleep 100 >input &
+		sleep 100 >input 5>/dev/null &
 	} &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 0
@@ -113,7 +113,7 @@ test_expect_success PIPE '1-byte read, no input available' '
 			printf "%s" a &&
 			printf "%s" b &&
 			sleep 100
-		} >input &
+		} >input 5>/dev/null &
 	} &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 1

The problem is that the sleeps hang around for 100 seconds, and they are
connected to the test script's stdout. It works to run "./t0081-*"
because bash sees the SIGCHLD and knows the script is done. But the
prove program actually ignore the SIGCHLD and waits until stdout and
stderr on the child are closed.

I'm not sure why it hangs with bash and not dash. Perhaps it has to do
with one of them using an internal "sleep" and the other not.
Double-weird is that if you "strace" the prove process, it will still
hang. But if you "strace -f", it _won't_ hang. Which makes no sense,
because the only extra thing happening is strace-ing the now-zombie bash
process and the sleeps which are, well, sleeping.

So there is definitely some deep mystery, but I think the fix can be
simpler: we should not leave processes hanging around that might have
descriptors open. Though the above works, I don't like scripts having to
know about the descriptor 5 magic above. The right solution to me is
either:

  1. Close descriptor 5 before running test code. But I'm not sure that
     will work, since we actually execute the test code in the _current_
     shell, not a subshell. Meaning we would be closing it for good.

     It also doesn't address descriptor 4, which might also go to
     stdout (if "-v" was used). I think the saving grace is that "prove"
     is the only thing that cares, and it doesn't use "-v".

  2. Tests should kill their backgrounded sleeps themselves. I think I
     saw some "kill $!" lines in there, but maybe we are missing one.

-Peff
