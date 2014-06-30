From: Jeff King <peff@peff.net>
Subject: [PATCH 7/9] strbuf: implement strbuf_strip_suffix
Date: Mon, 30 Jun 2014 13:01:51 -0400
Message-ID: <20140630170151.GG16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:02:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1exp-00035o-1X
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 19:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbaF3RBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 13:01:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:53668 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754168AbaF3RBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 13:01:52 -0400
Received: (qmail 7947 invoked by uid 102); 30 Jun 2014 17:01:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 12:01:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 13:01:51 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252689>

You can almost get away with just calling "strip_suffix_mem"
on a strbuf's buf and len fields. But we also need to move
the NUL-terminator to satisfy strbuf's invariants. Let's
provide a convenience wrapper that handles this.

Signed-off-by: Jeff King <peff@peff.net>
---
I called strbuf_setlen here because it seemed sensible to use that as an
opaque building block, but we are violating the invariant here for a
moment by setting sb->len for a moment. I think that is fine, as this is
a strbuf function, and can violate the invariant for a moment if it
wants to.

But if we care, we can keep a separate "size_t len" variable, and
strbuf_setlen to that.

Or we can make it less opaque, and replace the setlen with
"sb->buf[sb->len] = 0".

 strbuf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index e9ad03e..ec11742 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -49,6 +49,15 @@ extern int strbuf_reencode(struct strbuf *sb, const char *from, const char *to);
 extern void strbuf_tolower(struct strbuf *sb);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
+static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
+{
+	if (strip_suffix_mem(sb->buf, &sb->len, suffix)) {
+		strbuf_setlen(sb, sb->len);
+		return 1;
+	} else
+		return 0;
+}
+
 /*
  * Split str (of length slen) at the specified terminator character.
  * Return a null-terminated array of pointers to strbuf objects
-- 
2.0.0.566.gfe3e6b2
