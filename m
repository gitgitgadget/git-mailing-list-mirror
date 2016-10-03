Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125B5207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbcJCUg1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:36:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:51473 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbcJCUgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:36:25 -0400
Received: (qmail 17464 invoked by uid 109); 3 Oct 2016 20:36:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:36:25 +0000
Received: (qmail 29899 invoked by uid 111); 3 Oct 2016 20:36:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:36:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:36:22 -0400
Date:   Mon, 3 Oct 2016 16:36:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 17/18] sha1_file: always allow relative paths to alternates
Message-ID: <20161003203622.7uz76ay5f7bqqpfm@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recursively expand alternates repositories, so that if A
borrows from B which borrows from C, A can see all objects.

For the root object database, we allow relative paths, so A
can point to B as "../B/objects". However, we currently do
not allow relative paths when recursing, so B must use an
absolute path to reach C.

That is an ancient protection from c2f493a (Transitively
read alternatives, 2006-05-07) that tries to avoid adding
the same alternate through two different paths. Since
5bdf0a8 (sha1_file: normalize alt_odb path before comparing
and storing, 2011-09-07), we use a normalized absolute path
for each alt_odb entry.

This means that in most cases the protection is no longer
necessary; we will detect the duplicate no matter how we got
there (but see below).  And it's a good idea to get rid of
it, as it creates an unnecessary complication when setting
up recursive alternates (B has to know that A is going to
borrow from it and make sure to use an absolute path).

Note that our normalization doesn't actually look at the
filesystem, so it can still be fooled by crossing symbolic
links. But that's also true of absolute paths, so it's not a
good reason to disallow only relative paths (it's
potentially a reason to switch to real_path(), but that's a
separate and non-trivial change).

We adjust the test script here to demonstrate that this now
works, and add new tests to show that the normalization does
indeed suppress duplicates.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c               |  7 +------
 t/t5613-info-alternate.sh | 24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 80a3333..b514167 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -354,12 +354,7 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 		const char *entry = entries.items[i].string;
 		if (entry[0] == '\0' || entry[0] == '#')
 			continue;
-		if (!is_absolute_path(entry) && depth) {
-			error("%s: ignoring relative alternate object store %s",
-					relative_base, entry);
-		} else {
-			link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
-		}
+		link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
 	}
 	string_list_clear(&entries, 0);
 	free(alt_copy);
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 74f6770..76525a0 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -92,8 +92,28 @@ test_expect_success 'that relative alternate is possible for current dir' '
 	git fsck
 '
 
-test_expect_success 'that relative alternate is only possible for current dir' '
-	test_must_fail git -C D fsck
+test_expect_success 'that relative alternate is recursive' '
+	git -C D fsck
+'
+
+# we can reach "A" from our new repo both directly, and via "C".
+# The deep/subdir is there to make sure we are not doing a stupid
+# pure-text comparison of the alternate names.
+test_expect_success 'relative duplicates are eliminated' '
+	mkdir -p deep/subdir &&
+	git init --bare deep/subdir/duplicate.git &&
+	cat >deep/subdir/duplicate.git/objects/info/alternates <<-\EOF &&
+	../../../../C/.git/objects
+	../../../../A/.git/objects
+	EOF
+	cat >expect <<-EOF &&
+	alternate: $(pwd)/C/.git/objects
+	alternate: $(pwd)/B/.git/objects
+	alternate: $(pwd)/A/.git/objects
+	EOF
+	git -C deep/subdir/duplicate.git count-objects -v >actual &&
+	grep ^alternate: actual >actual.alternates &&
+	test_cmp expect actual.alternates
 '
 
 test_done
-- 
2.10.0.618.g82cc264

