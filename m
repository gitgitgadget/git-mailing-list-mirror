Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A0620248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfDDXXB (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:23:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:47404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729501AbfDDXXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:23:01 -0400
Received: (qmail 1416 invoked by uid 109); 4 Apr 2019 23:23:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:23:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20392 invoked by uid 111); 4 Apr 2019 23:23:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:23:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:22:59 -0400
Date:   Thu, 4 Apr 2019 19:22:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/12] packfile: factor out .pack to .idx name conversion
Message-ID: <20190404232259.GC21839@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we open a pack .idx, we have to convert the "foo.pack" name stored
in the packed_git struct to "foo.idx". This isn't too complicated, but
we do encode some policy in the form of a BUG(). Let's pull this into
its own function so it can be reused.

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 16bcb75262..054269ae5d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -186,18 +186,24 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	return 0;
 }
 
+static char *pack_name_to_idx(const char *pack_name)
+{
+	size_t len;
+
+	if (!strip_suffix(pack_name, ".pack", &len))
+		BUG("pack_name does not end in .pack");
+	return xstrfmt("%.*s.idx", (int)len, pack_name);
+}
+
 int open_pack_index(struct packed_git *p)
 {
 	char *idx_name;
-	size_t len;
 	int ret;
 
 	if (p->index_data)
 		return 0;
 
-	if (!strip_suffix(p->pack_name, ".pack", &len))
-		BUG("pack_name does not end in .pack");
-	idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
+	idx_name = pack_name_to_idx(p->pack_name);
 	ret = check_packed_git_idx(idx_name, p);
 	free(idx_name);
 	return ret;
-- 
2.21.0.714.gd1be1d035b

