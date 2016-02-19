From: Jeff King <peff@peff.net>
Subject: [PATCH 03/21] tree-diff: catch integer overflow in combine_diff_path
 allocation
Date: Fri, 19 Feb 2016 06:21:30 -0500
Message-ID: <20160219112130.GC9319@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 12:21:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWj82-0002s1-CF
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427651AbcBSLVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:21:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:45225 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423104AbcBSLVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:21:32 -0500
Received: (qmail 20156 invoked by uid 102); 19 Feb 2016 11:21:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:21:33 -0500
Received: (qmail 26488 invoked by uid 107); 19 Feb 2016 11:21:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:21:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 06:21:30 -0500
Content-Disposition: inline
In-Reply-To: <20160219111941.GA31906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286687>

A combine_diff_path struct has two "flex" members allocated
alongside the struct: a string to hold the pathname, and an
array of parent pointers. We use an "int" to compute this,
meaning we may easily overflow it if the pathname is
extremely long.

We can fix this by using size_t, and checking for overflow
with the st_add helper.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.h      | 4 ++--
 tree-diff.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.h b/diff.h
index 70b2d70..beafbbd 100644
--- a/diff.h
+++ b/diff.h
@@ -222,8 +222,8 @@ struct combine_diff_path {
 	} parent[FLEX_ARRAY];
 };
 #define combine_diff_path_size(n, l) \
-	(sizeof(struct combine_diff_path) + \
-	 sizeof(struct combine_diff_parent) * (n) + (l) + 1)
+	st_add4(sizeof(struct combine_diff_path), (l), 1, \
+		st_mult(sizeof(struct combine_diff_parent), (n)))
 
 extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
 			      int dense, struct rev_info *);
diff --git a/tree-diff.c b/tree-diff.c
index 290a1da..4dda9a1 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -124,8 +124,8 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	unsigned mode, const unsigned char *sha1)
 {
 	struct combine_diff_path *p;
-	int len = base->len + pathlen;
-	int alloclen = combine_diff_path_size(nparent, len);
+	size_t len = st_add(base->len, pathlen);
+	size_t alloclen = combine_diff_path_size(nparent, len);
 
 	/* if last->next is !NULL - it is a pre-allocated memory, we can reuse */
 	p = last->next;
-- 
2.7.1.577.gfed91b8
