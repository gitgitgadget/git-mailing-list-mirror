From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] diff_filespec: use only 2 bits for is_binary flag
Date: Thu, 16 Jan 2014 20:25:40 -0500
Message-ID: <20140117012540.GE7249@sigill.intra.peff.net>
References: <20140117011844.GA6870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 02:25:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3yBw-0000ua-2o
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 02:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaAQBZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 20:25:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:33887 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751805AbaAQBZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 20:25:42 -0500
Received: (qmail 6185 invoked by uid 102); 17 Jan 2014 01:25:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 19:25:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 20:25:40 -0500
Content-Disposition: inline
In-Reply-To: <20140117011844.GA6870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240555>

The is_binary flag needs only three values: -1, 0, and 1.
However, we use a whole 32-bit int for it on most systems
(both 32- and 64- bit).

Instead, we can mark it to use only 2 bits. On 32-bit
systems, this lets it end up as part of the bitfield above
(saving 4 bytes). On 64-bit systems, we don't see any change
(because the savings end up as padding), but it does leave
room for another "free" 32-bit value to be added later.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't typically use bit-sized integers like this for anything but
unsigned integers to be used as flags. My understanding is that using
signed integers is explicitly permitted by the standard. I don't know if
we're guaranteed a 2's-complement representation, but I can't imagine an
implementation providing any range besides -2..1, which is what we need.

 diffcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore.h b/diffcore.h
index d911bf0..79de8cf 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -46,7 +46,7 @@ struct diff_filespec {
 	unsigned is_stdin : 1;
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
-	int is_binary;
+	int is_binary : 2;
 	struct userdiff_driver *driver;
 };
 
-- 
1.8.5.2.500.g8060133
