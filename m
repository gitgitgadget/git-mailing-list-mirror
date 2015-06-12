From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] pkt-line: simplify starts_with checks in packet tracing
Date: Fri, 12 Jun 2015 17:28:08 -0400
Message-ID: <20150612212808.GA25757@peff.net>
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
	id 1Z3WUz-0005Rn-D1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbbFLV2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:28:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:45438 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750753AbbFLV2L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:28:11 -0400
Received: (qmail 10524 invoked by uid 102); 12 Jun 2015 21:28:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 16:28:10 -0500
Received: (qmail 17737 invoked by uid 107); 12 Jun 2015 21:28:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 17:28:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 17:28:08 -0400
Content-Disposition: inline
In-Reply-To: <20150612212526.GA25447@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271527>

We carefully check that our pkt buffer has enough characters
before seeing if it starts with "PACK". The intent is to
avoid reading random memory if we get a short buffer like
"PAC".

However, we know that the traced packets are always
NUL-terminated. They come from one of these sources:

  1. A string literal.

  2. `format_packet`, which uses a strbuf.

  3. `packet_read`, which defensively NUL-terminates what we
     read.

We can therefore drop the length checks, as we know we will
hit the trailing NUL if we have a short input.

Signed-off-by: Jeff King <peff@peff.net>
---
 pkt-line.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 187a229..0477d2e 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -24,8 +24,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_addf(&out, "packet: %12s%c ",
 		    packet_trace_prefix, write ? '>' : '<');
 
-	if ((len >= 4 && starts_with(buf, "PACK")) ||
-	    (len >= 5 && starts_with(buf+1, "PACK"))) {
+	if (starts_with(buf, "PACK") || starts_with(buf + 1, "PACK")) {
 		strbuf_addstr(&out, "PACK ...");
 		trace_disable(&trace_packet);
 	}
-- 
2.4.2.752.geeb594a
