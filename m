Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48360209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 11:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034003AbcIZL7v (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 07:59:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:48020 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965095AbcIZL7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 07:59:50 -0400
Received: (qmail 18609 invoked by uid 109); 26 Sep 2016 11:59:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 11:59:50 +0000
Received: (qmail 4340 invoked by uid 111); 26 Sep 2016 12:00:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:00:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 07:59:48 -0400
Date:   Mon, 26 Sep 2016 07:59:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 04/10] get_short_sha1: peel tags when looking for treeish
Message-ID: <20160926115947.hksmtkqp3i4tfftx@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The treeish disambiguation function tries to peel tags, but
it does so by calling:

  deref_tag(lookup_object(sha1), ...);

This will only work if we have previously looked at the tag
and created a "struct tag" for it. Since parsing revision
arguments typically happens before anything else, this is
usually not the case, and we would fail to peel the tag (we
are lucky that deref_tag() gracefully handles the NULL and
does not segfault).

Instead, we can use parse_object(). Note that this is the
same fix done by 94d75d1 (get_short_sha1(): correctly
disambiguate type-limited abbreviation, 2013-07-01), but
that commit fixed only the committish disambiguator, and
left the bug in the treeish one.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c                         | 2 +-
 t/t1512-rev-parse-disambiguation.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 38e51d9..432a308 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -269,7 +269,7 @@ static int disambiguate_treeish_only(const unsigned char *sha1, void *cb_data_un
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(lookup_object(sha1), NULL, 0);
+	obj = deref_tag(parse_object(sha1), NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 30e0b80..dfd3567 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -264,6 +264,13 @@ test_expect_success 'ambiguous commit-ish' '
 	test_must_fail git log 000000000...
 '
 
+# There are three objects with this prefix: a blob, a tree, and a tag. We know
+# the blob will not pass as a treeish, but the tree and tag should (and thus
+# cause an error).
+test_expect_success 'ambiguous tags peel to treeish' '
+	test_must_fail git rev-parse 0000000000f^{tree}
+'
+
 test_expect_success 'rev-parse --disambiguate' '
 	# The test creates 16 objects that share the prefix and two
 	# commits created by commit-tree in earlier tests share a
-- 
2.10.0.492.g14f803f

