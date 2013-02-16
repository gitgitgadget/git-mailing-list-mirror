From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] pkt-line: teach packet_get_line a no-op mode
Date: Sat, 16 Feb 2013 01:46:12 -0500
Message-ID: <20130216064612.GA22626@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 07:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6bXj-00047g-3i
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 07:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874Ab3BPGqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 01:46:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49775 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab3BPGqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 01:46:15 -0500
Received: (qmail 2900 invoked by uid 107); 16 Feb 2013 06:47:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Feb 2013 01:47:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2013 01:46:12 -0500
Content-Disposition: inline
In-Reply-To: <20130216064455.GA27063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216378>

You can use packet_get_line to parse a single packet out of
a stream and into a buffer. However, if you just want to
throw away a set of packets from the stream, there's no need
to even bother copying the bytes. This patch treats a NULL
output buffer as a hint that the caller does not even want
to see the output.

We have to tweak the packet_trace call, too, since it showed
the trace from the copied buffer, which now might not exist.
The new code is actually more correct, though, as it shows
just what we parsed, not any cruft that may have been in the
output buffer before (it never mattered, though, because all
callers gave us a fresh buffer).

Signed-off-by: Jeff King <peff@peff.net>
---
 pkt-line.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index eaba15f..7f28701 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -234,9 +234,10 @@ int packet_get_line(struct strbuf *out,
 	*src_len -= 4;
 	len -= 4;
 
-	strbuf_add(out, *src_buf, len);
+	if (out)
+		strbuf_add(out, *src_buf, len);
+	packet_trace(*src_buf, len, 0);
 	*src_buf += len;
 	*src_len -= len;
-	packet_trace(out->buf, out->len, 0);
 	return len;
 }
-- 
1.8.1.2.11.g1a2f572
