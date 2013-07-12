From: Jeff King <peff@peff.net>
Subject: [PATCH] t0008: avoid SIGPIPE race condition on fifo
Date: Fri, 12 Jul 2013 06:35:23 -0400
Message-ID: <20130712103522.GA4750@sigill.intra.peff.net>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
 <20130711133414.GF6015@sigill.intra.peff.net>
 <7vli5drsbw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 12:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxahF-0004Or-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 12:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655Ab3GLKf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 06:35:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:38201 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757646Ab3GLKfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 06:35:25 -0400
Received: (qmail 29737 invoked by uid 102); 12 Jul 2013 10:36:43 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 05:36:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 06:35:23 -0400
Content-Disposition: inline
In-Reply-To: <7vli5drsbw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230193>

On Thu, Jul 11, 2013 at 09:09:55AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Jul 10, 2013 at 12:36:40PM -0400, Brian Gernhardt wrote:
> >
> >> The newest test in t0008 "streaming support for --stdin", seems to
> >> hang sporadically on my MacBook Pro (running 10.8.4).  The hang seems
> >> to be related to running it in parallel with other tests, as I can
> >> only reliably cause it by running with prove  and -j 3.  However, once
> >> that has hung I am able to semi-reliably have it occur by running the
> >> test separately (with the test hung in the background, using separate
> >> trash directories via the --root option).
> >
> > I can't replicate the hang here (on Linux) doing:
> >
> >   for i in `seq 1 30`; do
> >       ./t0008-ignores.sh --root=/tmp/foo/$i &
> >   done
> 
> It seems to hang on me with bash, but not dash, here.

Thanks, I was able to replicate it with bash, and like Brian, I saw it
hanging in the second read. strace revealed that we were blocked on
open("out").

The patch below should fix it. I'm still not sure why the choice of
shell matters; it may simply be a timing fluke that bash is more likely
to hit for some reason.

-- >8 --
Subject: [PATCH] t0008: avoid SIGPIPE race condition on fifo

To test check-ignore's --stdin feature, we use two fifos to
send and receive data. We carefully keep a descriptor to its
input open so that it does not receive EOF between input
lines. However, we do not do the same for its output. That
means there is a potential race condition in which
check-ignore has opened the output pipe once (when we read
the first line), and then writes the second line before we
have re-opened the pipe.

In that case, check-ignore gets a SIGPIPE and dies. The
outer shell then tries to open the output fifo but blocks
indefinitely, because there is no writer.  We can fix it by
keeping a descriptor open through the whole procedure.

This should also help if check-ignore dies for any other
reason (we would already have opened the fifo and would
therefore not block, but just get EOF on read).

However, we are technically still susceptible to
check-ignore dying early, before we have opened the fifo.
This is an unlikely race and shouldn't generally happen in
practice, though, so we can hopefully ignore it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0008-ignores.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index a56db80..c29342d 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -697,13 +697,21 @@ test_expect_success PIPE 'streaming support for --stdin' '
 	# shell, and then echo to the fd. We make sure to close it at
 	# the end, so that the subprocess does get EOF and dies
 	# properly.
+	#
+	# Similarly, we must keep "out" open so that check-ignore does
+	# not ever get SIGPIPE trying to write to us. Not only would that
+	# produce incorrect results, but then there would be no writer on the
+	# other end of the pipe, and we would potentially block forever trying
+	# to open it.
 	exec 9>in &&
+	exec 8<out &&
 	test_when_finished "exec 9>&-" &&
+	test_when_finished "exec 8<&-" &&
 	echo >&9 one &&
-	read response <out &&
+	read response <&8 &&
 	echo "$response" | grep "^\.gitignore:1:one	one" &&
 	echo >&9 two &&
-	read response <out &&
+	read response <&8 &&
 	echo "$response" | grep "^::	two"
 '
 
-- 
1.8.3.rc1.30.gff0fb75
