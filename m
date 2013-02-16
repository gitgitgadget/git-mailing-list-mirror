From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] remote-curl: verify smart-http metadata lines
Date: Sat, 16 Feb 2013 01:47:07 -0500
Message-ID: <20130216064707.GB22626@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 07:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6bYc-0004Qs-Ri
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 07:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949Ab3BPGrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 01:47:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49777 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab3BPGrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 01:47:10 -0500
Received: (qmail 2919 invoked by uid 107); 16 Feb 2013 06:48:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Feb 2013 01:48:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2013 01:47:07 -0500
Content-Disposition: inline
In-Reply-To: <20130216064455.GA27063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216379>

A smart http ref advertisement starts with a packet
containing the service header, followed by an arbitrary
number of packets containing other metadata headers,
followed by a flush packet.

We don't currently recognize any other metadata headers, so
we just parse through any extra packets, throwing away their
contents. However, we don't do so very carefully, and just
stop at the first error or flush packet.

Let's flag any errors we see here, which might be a sign of
truncated or corrupted output. Since the rest of the data
should be the ref advertisement, and since we pass that
along to our helper programs (like fetch-pack), they will
probably notice the error, as whatever cruft is in the
buffer will not parse. However, it's nice to note problems
as early as possible, which can help in debugging the root
cause.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 933c69a..73134f5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -90,6 +90,17 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
+static int read_packets_until_flush(char **buf, size_t *len)
+{
+	while (1) {
+		int r = packet_get_line(NULL, buf, len);
+		if (r < 0)
+			return -1;
+		if (r == 0)
+			return 0;
+	}
+}
+
 static struct discovery* discover_refs(const char *service)
 {
 	struct strbuf exp = STRBUF_INIT;
@@ -155,11 +166,13 @@ static struct discovery* discover_refs(const char *service)
 
 		/* The header can include additional metadata lines, up
 		 * until a packet flush marker.  Ignore these now, but
-		 * in the future we might start to scan them.
+		 * in the future we might start to scan them. However, we do
+		 * still check to make sure we are getting valid packet lines,
+		 * ending with a flush.
 		 */
-		strbuf_reset(&buffer);
-		while (packet_get_line(&buffer, &last->buf, &last->len) > 0)
-			strbuf_reset(&buffer);
+		if (read_packets_until_flush(&last->buf, &last->len) < 0)
+			die("smart-http metadata lines are invalid at %s",
+			    refs_url);
 
 		last->proto_git = 1;
 	}
-- 
1.8.1.2.11.g1a2f572
