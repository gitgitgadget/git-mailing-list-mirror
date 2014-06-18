From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] record_author_info: fix memory leak on malformed commit
Date: Wed, 18 Jun 2014 16:28:49 -0400
Message-ID: <20140618202849.GB23896@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:28:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMTX-0006T5-Aq
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949AbaFRU2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:28:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:47003 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753611AbaFRU2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:28:51 -0400
Received: (qmail 603 invoked by uid 102); 18 Jun 2014 20:28:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:28:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:28:49 -0400
Content-Disposition: inline
In-Reply-To: <20140618201944.GA23238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252057>

If we hit the end-of-header without finding an "author"
line, we just return from the function. We should jump to
the fail_exit path to clean up the buffer that we may have
allocated.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index d04b525..0c40cfa 100644
--- a/commit.c
+++ b/commit.c
@@ -617,7 +617,7 @@ static void record_author_date(struct author_date_slab *author_date,
 		ident_line = skip_prefix(buf, "author ");
 		if (!ident_line) {
 			if (!line_end[0] || line_end[1] == '\n')
-				return; /* end of header */
+				goto fail_exit; /* end of header */
 			continue;
 		}
 		if (split_ident_line(&ident,
-- 
2.0.0.566.gfe3e6b2
