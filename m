From: Jeff King <peff@peff.net>
Subject: [PATCH 5/9] strbuf_addch: avoid calling strbuf_grow
Date: Thu, 16 Apr 2015 04:53:56 -0400
Message-ID: <20150416085356.GE17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YifYj-0003eN-PB
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 10:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbbDPIyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 04:54:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:46107 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751488AbbDPIx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 04:53:59 -0400
Received: (qmail 21790 invoked by uid 102); 16 Apr 2015 08:53:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 03:53:59 -0500
Received: (qmail 23481 invoked by uid 107); 16 Apr 2015 08:54:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:54:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 04:53:56 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267266>

We mark strbuf_addch as inline, because we expect it may be
called from a tight loop. However, the first thing it does
is call the non-inline strbuf_grow(), which can handle
arbitrary-sized growth. Since we know that we only need a
single character, we can use the inline strbuf_avail() to
quickly check whether we need to grow at all.

Our check is redundant when we do call strbuf_grow(), but
that's OK. The common case is that we avoid calling it at
all, and we have made that case faster.

On a silly pathological case:

  perl -le '
    print "[core]";
    print "key$_ = value$_" for (1..1000000)
  ' >input
  git config -f input core.key1

this dropped the time to run git-config from:

  real    0m0.159s
  user    0m0.152s
  sys     0m0.004s

to:

  real    0m0.140s
  user    0m0.136s
  sys     0m0.004s

for a savings of 12%.

Signed-off-by: Jeff King <peff@peff.net>
---
I doubt anybody will really notice this in practice with config files,
and for the most part we do not have tight loops of strbuf_addch
elsewhere. But it is such an easy optimization, I'd rather do it now
while we're thinking about it.

 strbuf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 1883494..01c5c63 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -205,7 +205,8 @@ extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
  */
 static inline void strbuf_addch(struct strbuf *sb, int c)
 {
-	strbuf_grow(sb, 1);
+	if (!strbuf_avail(sb))
+		strbuf_grow(sb, 1);
 	sb->buf[sb->len++] = c;
 	sb->buf[sb->len] = '\0';
 }
-- 
2.4.0.rc2.384.g7297a4a
