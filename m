Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917BA201CF
	for <e@80x24.org>; Sat, 20 May 2017 08:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbdETIab (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 04:30:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:55175 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdETIa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 04:30:28 -0400
Received: (qmail 19079 invoked by uid 109); 20 May 2017 08:30:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 May 2017 08:30:27 +0000
Received: (qmail 435 invoked by uid 111); 20 May 2017 08:31:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 May 2017 04:31:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 May 2017 04:30:25 -0400
Date:   Sat, 20 May 2017 04:30:25 -0400
From:   Jeff King <peff@peff.net>
To:     Chris West <solo-git-vger@goeswhere.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] revision.c: ignore broken tags with ignore_missing_links
Message-ID: <20170520083025.nv7hqwy6of3mkkjs@sigill.intra.peff.net>
References: <20170519172856.GA14673@blind.goeswhere.com>
 <20170520080312.nwb277swvmpq7iq6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170520080312.nwb277swvmpq7iq6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When peeling a tag for prepare_revision_walk(), we do not
respect the ignore_missing_links flag. This can lead to a
bogus error when pack-objects walks the possibly-broken
unreachable-but-recent part of the object graph.

The other link-following all happens via traverse_commit_list(),
which explains why this case was missed. And our tests
covered only broken links from commits. Let's be more
comprehensive and cover broken tree entries (which do work)
and tags (which shows off this bug).

Signed-off-by: Jeff King <peff@peff.net>
---
So here's the fix I showed earlier polished up as a real patch. I still
think your patch to improve the error message is a good suggestion. I
was going to just re-send it out on top of this, but I realized it was
missing your signoff. Do you want to resend?

 revision.c                 |  2 +-
 t/t6501-freshen-objects.sh | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 8a8c1789c..610638f2e 100644
--- a/revision.c
+++ b/revision.c
@@ -230,7 +230,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			die("bad tag");
 		object = parse_object(tag->tagged->oid.hash);
 		if (!object) {
-			if (flags & UNINTERESTING)
+			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
 			die("bad object %s", oid_to_hex(&tag->tagged->oid));
 		}
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index cf076dcd9..394b169ea 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -129,7 +129,7 @@ for repack in '' true; do
 	'
 done
 
-test_expect_success 'do not complain about existing broken links' '
+test_expect_success 'do not complain about existing broken links (commit)' '
 	cat >broken-commit <<-\EOF &&
 	tree 0000000000000000000000000000000000000001
 	parent 0000000000000000000000000000000000000002
@@ -144,4 +144,29 @@ test_expect_success 'do not complain about existing broken links' '
 	test_must_be_empty stderr
 '
 
+test_expect_success 'do not complain about existing broken links (tree)' '
+	cat >broken-tree <<-\EOF &&
+	100644 blob 0000000000000000000000000000000000000003	foo
+	EOF
+	tree=$(git mktree --missing <broken-tree) &&
+	git gc 2>stderr &&
+	git cat-file -e $tree &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'do not complain about existing broken links (tag)' '
+	cat >broken-tag <<-\EOF &&
+	object 0000000000000000000000000000000000000004
+	type commit
+	tag broken
+	tagger whatever <whatever@example.com> 1234 -0000
+
+	this is a broken tag
+	EOF
+	tag=$(git hash-object -t tag -w broken-tag) &&
+	git gc 2>stderr &&
+	git cat-file -e $tag &&
+	test_must_be_empty stderr
+'
+
 test_done
-- 
2.13.0.234.g029c1392a


