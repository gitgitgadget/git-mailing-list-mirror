Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01851C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76F220776
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbgFWPYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:24:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:40124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgFWPYu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:24:50 -0400
Received: (qmail 11797 invoked by uid 109); 23 Jun 2020 15:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:24:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16894 invoked by uid 111); 23 Jun 2020 15:24:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:24:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:24:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 02/10] fast-export: use xmemdupz() for anonymizing oids
Message-ID: <20200623152449.GB1435482@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our anonymize_mem() function is careful to take a ptr/len pair to allow
storing binary tokens like object ids, as well as partial strings (e.g.,
just "foo" of "foo/bar"). But it duplicates the hash key using
xstrdup()! That means that:

  - for a partial string, we'd store all bytes up to the NUL, even
    though we'd never look at anything past "len". This didn't produce
    wrong behavior, but was wasteful.

  - for a binary oid that doesn't contain a zero byte, we'd copy garbage
    bytes off the end of the array (though as long as nothing complained
    about reading uninitialized bytes, further reads would be limited by
    "len", and we'd produce the correct results)

  - for a binary oid that does contain a zero byte, we'd copy _fewer_
    bytes than intended into the hashmap struct. When we later try to
    look up a value, we'd access uninitialized memory and potentially
    falsely claim that a particular oid is not present.

The most common reason to store an oid is an anonymized gitlink, but our
test case doesn't have any gitlinks at all. So let's add one whose oid
contains a NUL and is present at two different paths. ASan catches the
memory error, but even without it we can detect the bug because the oid
is not anonymized the same way for both paths.

And of course the fix is to copy the correct number of bytes. We don't
technically need the appended NUL from xmemdupz(), but it doesn't hurt
as an extra protection against anybody treating it like a string (plus a
future patch will push us more in that direction).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c            |  2 +-
 t/t9351-fast-export-anonymize.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85868162ee..289395a131 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -162,7 +162,7 @@ static const void *anonymize_mem(struct hashmap *map,
 	if (!ret) {
 		ret = xmalloc(sizeof(*ret));
 		hashmap_entry_init(&ret->hash, key.hash.hash);
-		ret->orig = xstrdup(orig);
+		ret->orig = xmemdupz(orig, *len);
 		ret->orig_len = *len;
 		ret->anon = generate(orig, len);
 		ret->anon_len = *len;
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index e772cf9930..dc5d75cd19 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -10,6 +10,10 @@ test_expect_success 'setup simple repo' '
 	mkdir subdir &&
 	test_commit subdir/bar &&
 	test_commit subdir/xyzzy &&
+	fake_commit=$(echo $ZERO_OID | sed s/0/a/) &&
+	git update-index --add --cacheinfo 160000,$fake_commit,link1 &&
+	git update-index --add --cacheinfo 160000,$fake_commit,link2 &&
+	git commit -m "add gitlink" &&
 	git tag -m "annotated tag" mytag
 '
 
@@ -26,6 +30,12 @@ test_expect_success 'stream omits path names' '
 	! grep xyzzy stream
 '
 
+test_expect_success 'stream omits gitlink oids' '
+	# avoid relying on the whole oid to remain hash-agnostic; this is
+	# plenty to be unique within our test case
+	! grep a000000000000000000 stream
+'
+
 test_expect_success 'stream allows master as refname' '
 	grep master stream
 '
@@ -89,6 +99,11 @@ test_expect_success 'paths in subdir ended up in one tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'identical gitlinks got identical oid' '
+	awk "/commit/ { print \$3 }" <root | sort -u >commits &&
+	test_line_count = 1 commits
+'
+
 test_expect_success 'tag points to branch tip' '
 	git rev-parse $other_branch >expect &&
 	git for-each-ref --format="%(*objectname)" | grep . >actual &&
-- 
2.27.0.517.gbc32778fa3

