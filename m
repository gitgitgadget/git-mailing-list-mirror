From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] diff_filespec: reorder is_binary field
Date: Thu, 16 Jan 2014 20:22:56 -0500
Message-ID: <20140117012255.GD7249@sigill.intra.peff.net>
References: <20140117011844.GA6870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 02:23:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3y9F-0004oX-JW
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 02:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbaAQBW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 20:22:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:33884 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751333AbaAQBW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 20:22:57 -0500
Received: (qmail 6076 invoked by uid 102); 17 Jan 2014 01:22:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 19:22:57 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 20:22:56 -0500
Content-Disposition: inline
In-Reply-To: <20140117011844.GA6870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240554>

The middle of the diff_filespec struct contains a mixture of
ints, shorts, and bit-fields, followed by a pointer. On an
x86-64 system with an LP64 or LLP64 data model (i.e., most
of them), the integers and flags end up being padded out by
41 bits to put the pointer at an 8-byte boundary.

After the pointer, we have the "int is_binary" field, which
is only 32 bits. We end up wasting another 32 bits to pad
the struct size up to a multiple of 64 bits.

We can move the is_binary field before the pointer, which
lets the compiler store it where we used to have padding.
This shrinks the top padding to only 9 bits (from the
bit-fields), and eliminates the bottom padding entirely,
dropping the struct size from 88 to 80 bytes.

On a 32-bit system, there is no benefit, but nor should
there be any harm (we only need 4-byte alignment there, so
we were already using only 9 bits of padding).

Signed-off-by: Jeff King <peff@peff.net>
---

 diffcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore.h b/diffcore.h
index 22993e1..d911bf0 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -45,9 +45,9 @@ struct diff_filespec {
 #define DIRTY_SUBMODULE_MODIFIED  2
 	unsigned is_stdin : 1;
 	unsigned has_more_entries : 1; /* only appear in combined diff */
-	struct userdiff_driver *driver;
 	/* data should be considered "binary"; -1 means "don't know yet" */
 	int is_binary;
+	struct userdiff_driver *driver;
 };
 
 extern struct diff_filespec *alloc_filespec(const char *);
-- 
1.8.5.2.500.g8060133
