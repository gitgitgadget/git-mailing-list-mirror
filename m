Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF58D207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 19:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424670AbdDUTND (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 15:13:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37899 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424667AbdDUTNC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 15:13:02 -0400
Received: (qmail 13936 invoked by uid 109); 21 Apr 2017 18:46:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 18:46:19 +0000
Received: (qmail 18759 invoked by uid 111); 21 Apr 2017 18:46:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 14:46:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 14:46:17 -0400
Date:   Fri, 21 Apr 2017 14:46:17 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] cache-tree: reject entries with null sha1
Message-ID: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We generally disallow null sha1s from entering the index,
due to 4337b5856 (do not write null sha1s to on-disk index,
2012-07-28). However, we loosened that in 83bd7437c
(write_index: optionally allow broken null sha1s,
2013-08-27) so that tools like filter-branch could be used
to repair broken history.

However, we should make sure that these broken entries do
not get propagated into new trees. For most entries, we'd
catch them with the missing-object check (since presumably
the null sha1 does not exist in our object database). But
gitlink entries do not need reachability, so we may blindly
copy the entry into a bogus tree.

This patch rejects all null sha1s (with the same "invalid
entry" message that missing objects get) when building trees
from the index. It does so even for non-gitlinks, and even
when "write-tree" is given the --missing-ok flag. The null
sha1 is a special sentinel value that is already rejected in
trees by fsck; whether the object exists or not, it is an
error to put it in a tree.

Note that for this to work, we must also avoid reusing an
existing cache-tree that contains the null sha1. This patch
does so by just refusing to write out any cache tree when
the index contains a null sha1. This is blunter than we need
to be; we could just reject the subtree that contains the
offending entry. But it's not worth the complexity. The
behavior is unchanged unless you have a broken index entry,
and even then we'd refuse the whole index write unless the
emergency GIT_ALLOW_NULL_SHA1 is in use. And even then the
end result is only a performance drop (any write-tree will
have to generate the whole cache-tree from scratch).

The tests bear some explanation.

The existing test in t7009 doesn't catch this problem,
because our index-filter runs "git rm --cached", which will
try to rewrite the updated index and barf on the bogus
entry. So we never even make it to write-tree.  The new test
there adds a noop index-filter, which does show the problem.

The new tests in t1601 are slightly redundant with what
filter-branch is doing under the hood in t7009. But as
they're much more direct, they're easier to reason about.
And should filter-branch ever change or go away, we'd want
to make sure that these plumbing commands behave sanely.

Signed-off-by: Jeff King <peff@peff.net>
---
When merged to pu, this fixes the existing test breakage in t7009 when
GIT_TEST_SPLIT_INDEX is used (because the split index didn't rewrite the
whole index, "git rm --cached" didn't always barf). But I think it's
worth doing on its own merits, as demonstrated by the new tests.

The one thing I haven't figured out it is why the new test in t7009
fails with the split-index. And even more curiously, the new tests in
t1601 _don't_ fail with it, even if I instrument the fake index to have
more entries (making it more likely to split).

 cache-tree.c                       |  4 +++-
 read-cache.c                       |  5 ++++-
 t/t1601-index-bogus.sh             | 22 ++++++++++++++++++++++
 t/t7009-filter-branch-null-sha1.sh |  6 ++++++
 4 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 t/t1601-index-bogus.sh

diff --git a/cache-tree.c b/cache-tree.c
index 345ea3596..34baa6d85 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -354,7 +354,9 @@ static int update_one(struct cache_tree *it,
 			entlen = pathlen - baselen;
 			i++;
 		}
-		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
+
+		if (is_null_sha1(sha1) ||
+		    (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
diff --git a/read-cache.c b/read-cache.c
index e44775182..6851de892 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2054,6 +2054,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	int drop_cache_tree = 0;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2104,6 +2105,8 @@ static int do_write_index(struct index_state *istate, int newfd,
 				warning(msg, ce->name);
 			else
 				return error(msg, ce->name);
+
+			drop_cache_tree = 1;
 		}
 		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
 			return -1;
@@ -2122,7 +2125,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->cache_tree) {
+	if (!strip_extensions && !drop_cache_tree && istate->cache_tree) {
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
diff --git a/t/t1601-index-bogus.sh b/t/t1601-index-bogus.sh
new file mode 100755
index 000000000..73cc9323c
--- /dev/null
+++ b/t/t1601-index-bogus.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='test handling of bogus index entries'
+. ./test-lib.sh
+
+test_expect_success 'create tree with null sha1' '
+	tree=$(printf "160000 commit $_z40\\tbroken\\n" | git mktree)
+'
+
+test_expect_success 'read-tree refuses to read null sha1' '
+	test_must_fail git read-tree $tree
+'
+
+test_expect_success 'GIT_ALLOW_NULL_SHA1 overrides refusal' '
+	GIT_ALLOW_NULL_SHA1=1 git read-tree $tree
+'
+
+test_expect_success 'git write-tree refuses to write null sha1' '
+	test_must_fail git write-tree
+'
+
+test_done
diff --git a/t/t7009-filter-branch-null-sha1.sh b/t/t7009-filter-branch-null-sha1.sh
index c27f90f28..a8d9ec498 100755
--- a/t/t7009-filter-branch-null-sha1.sh
+++ b/t/t7009-filter-branch-null-sha1.sh
@@ -31,6 +31,12 @@ test_expect_success 'setup: bring HEAD and index in sync' '
 	git commit -a -m "back to normal"
 '
 
+test_expect_success 'noop filter-branch complains' '
+	test_must_fail git filter-branch \
+		--force --prune-empty \
+		--index-filter "true"
+'
+
 test_expect_success 'filter commands are still checked' '
 	test_must_fail git filter-branch \
 		--force --prune-empty \
-- 
2.13.0.rc0.364.g36b4d8031
