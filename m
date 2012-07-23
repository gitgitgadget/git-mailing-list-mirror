From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] advice: pass varargs to strbuf_vaddf, not strbuf_addf
Date: Mon, 23 Jul 2012 14:48:57 -0400
Message-ID: <20120723184857.GA27588@sigill.intra.peff.net>
References: <20120723184634.GA31905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramana Kumar <ramana@member.fsf.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:49:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNgp-0000yh-HX
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab2GWStB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:49:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59058 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab2GWStB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:49:01 -0400
Received: (qmail 5664 invoked by uid 107); 23 Jul 2012 18:49:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jul 2012 14:49:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2012 14:48:57 -0400
Content-Disposition: inline
In-Reply-To: <20120723184634.GA31905@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201958>

The advise() function takes a variable number of arguments
and converts them into a va_list object to pass to strbuf
for handling. However, we accidentally called strbuf_addf
(that takes a variable number of arguments) instead of
strbuf_vaddf (that takes a va_list).

This bug dates back to v1.7.8.1-1-g23cb5bf, but we never
noticed because none of the current callers passes a string
with a format specifier in it. And the compiler did not
notice because the format string is not available at
compile time.

Signed-off-by: Jeff King <peff@peff.net>
---
 advice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index a492eea..edfbd4a 100644
--- a/advice.c
+++ b/advice.c
@@ -32,7 +32,7 @@ void advise(const char *advice, ...)
 	const char *cp, *np;
 
 	va_start(params, advice);
-	strbuf_addf(&buf, advice, params);
+	strbuf_vaddf(&buf, advice, params);
 	va_end(params);
 
 	for (cp = buf.buf; *cp; cp = np) {
-- 
1.7.10.5.40.g059818d
