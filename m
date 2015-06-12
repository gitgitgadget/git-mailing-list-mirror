From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] pkt-line: tighten sideband PACK check when tracing
Date: Fri, 12 Jun 2015 17:28:14 -0400
Message-ID: <20150612212814.GB25757@peff.net>
References: <20150612212526.GA25447@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Augie Fackler <augie@google.com>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:28:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3WUz-0005Rn-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbbFLV2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:28:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:45442 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750753AbbFLV2R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:28:17 -0400
Received: (qmail 10537 invoked by uid 102); 12 Jun 2015 21:28:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 16:28:16 -0500
Received: (qmail 17744 invoked by uid 107); 12 Jun 2015 21:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 17:28:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 17:28:14 -0400
Content-Disposition: inline
In-Reply-To: <20150612212526.GA25447@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271526>

To find the start of the pack data, we accept the word PACK
at the beginning of any sideband channel, even though what
we really want is to find the pack data on channel 1. In
practice this doesn't matter, as sideband-2 messages tend to
start with "error:" or similar, but it is a good idea to be
explicit (especially as we add more code in this area, we
will rely on this assumption).

Signed-off-by: Jeff King <peff@peff.net>
---
 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 0477d2e..e75af02 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -24,7 +24,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_addf(&out, "packet: %12s%c ",
 		    packet_trace_prefix, write ? '>' : '<');
 
-	if (starts_with(buf, "PACK") || starts_with(buf + 1, "PACK")) {
+	if (starts_with(buf, "PACK") || starts_with(buf, "\1PACK")) {
 		strbuf_addstr(&out, "PACK ...");
 		trace_disable(&trace_packet);
 	}
-- 
2.4.2.752.geeb594a
