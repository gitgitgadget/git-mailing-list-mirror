From: Jeff King <peff@peff.net>
Subject: [PATCHv2 04/10] pkt-line: change error message for oversized packet
Date: Mon, 18 Feb 2013 04:22:21 -0500
Message-ID: <20130218092221.GD5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:22:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Mvy-0001Kj-1s
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab3BRJWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:22:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51669 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab3BRJWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:22:24 -0500
Received: (qmail 17622 invoked by uid 107); 18 Feb 2013 09:23:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:23:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:22:21 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216449>

If we get a packet from the remote side that is too large to
fit in our buffer, we currently complain "protocol error:
bad line length".  This is a bit vague. The line length the
other side sent is not "bad" per se; the actual problem is
that it exceeded our expectation for buffer length.

This will generally not happen between two git-core
implementations, because the sender limits themselves to
either 1000, or to LARGE_PACKET_MAX (depending on what is
being sent, sideband-64k negotiation, etc), and the receiver
uses a buffer of the appropriate size.

The protocol document indicates the LARGE_PACKET_MAX limit
(of 65520), but does not actually specify the 1000-byte
limit for ref lines. It is likely that other implementations
just create a packet as large as they need, and this doesn't
come up often because nobody has 1000-character ref names
(or close to it, counting sha1 and other boilerplate).

We may want to increase the size of our receive buffers for
ref lines to prepare for such writers (whether they are
other implementations, or if we eventually want to bump the
write size in git-core). In the meantime, this patch tries
to give a more clear message in case it does come up.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm really tempted to bump all of our 1000-byte buffers to just use
LARGE_PACKET_MAX. If we provided a packet_read variant that used a
static buffer (which is fine for all but one or two callers), then it
would not take much memory (right now we stick some LARGE_PACKET_MAX
buffers on the stack, which is slightly questionable for
stack-restricted systems). But I left that for a different topic (and
even if we do, we would still want this message to catch anything over
the bizarre 65520 limit).

Out of curiosity, I grepped the list archives, and found only one
instance of this message. And it was somebody whose data stream was tainted
with random crud that happened to be numbers (much more common is "bad line
length character", when the crud does not look like a packet length).

 pkt-line.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 62479d3..f2a7575 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -160,7 +160,8 @@ static int packet_read_internal(int fd, char *buffer, unsigned size, int gently)
 	}
 	len -= 4;
 	if (len >= size)
-		die("protocol error: bad line length %d", len);
+		die("protocol error: line too large: (expected %u, got %d)",
+		    size, len);
 	ret = safe_read(fd, buffer, len, gently);
 	if (ret < 0)
 		return ret;
-- 
1.8.1.20.g7078b03
