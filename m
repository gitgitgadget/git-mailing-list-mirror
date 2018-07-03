Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227841F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 16:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933569AbeGCQzW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 12:55:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:57854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932775AbeGCQzV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 12:55:21 -0400
Received: (qmail 26370 invoked by uid 109); 3 Jul 2018 16:55:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Jul 2018 16:55:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3271 invoked by uid 111); 3 Jul 2018 16:55:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Jul 2018 12:55:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2018 12:55:19 -0400
Date:   Tue, 3 Jul 2018 12:55:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH] t5500: prettify non-commit tag tests
Message-ID: <20180703165518.GA29295@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to use backslash continuation, as the "&&"
already provides continuation (and happily soaks up empty
lines between commands).

We can also expand the multi-line printf into a
here-document, which lets us use line breaks more naturally
(and avoids another continuation that required us to break
the natural indentation).

Signed-off-by: Jeff King <peff@peff.net>
---
I had prepared this as a squash-in for what became c12c9df527, but since
that's now in master, it can go on top (or get dropped, but I think it
is worth it as a style fixup).

 t/t5500-fetch-pack.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index ea6570e819..3d33ab3875 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -533,19 +533,26 @@ test_expect_success 'test --all wrt tag to non-commits' '
 	# are reachable only via created tag references.
 	blob=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
 	git tag -a -m "tag -> blob" tag-to-blob $blob &&
- \
+
 	tree=$(printf "100644 blob $blob\tfile" | git mktree) &&
 	git tag -a -m "tag -> tree" tag-to-tree $tree &&
- \
+
 	tree2=$(printf "100644 blob $blob\tfile2" | git mktree) &&
 	commit=$(git commit-tree -m "hello commit" $tree) &&
 	git tag -a -m "tag -> commit" tag-to-commit $commit &&
- \
+
 	blob2=$(echo "hello blob2" | git hash-object -t blob -w --stdin) &&
-	tag=$(printf "object $blob2\ntype blob\ntag tag-to-blob2\n\
-tagger author A U Thor <author@example.com> 0 +0000\n\nhello tag" | git mktag) &&
+	tag=$(git mktag <<-EOF
+		object $blob2
+		type blob
+		tag tag-to-blob2
+		tagger author A U Thor <author@example.com> 0 +0000
+
+		hello tag
+	EOF
+	) &&
 	git tag -a -m "tag -> tag" tag-to-tag $tag &&
- \
+
 	# `fetch-pack --all` should succeed fetching all those objects.
 	mkdir fetchall &&
 	(
-- 
2.18.0.359.ge51c883f96
