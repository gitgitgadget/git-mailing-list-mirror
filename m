Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F3F20705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933418AbcIEVw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:52:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:38486 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932217AbcIEVw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:52:28 -0400
Received: (qmail 7979 invoked by uid 109); 5 Sep 2016 21:52:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 21:52:28 +0000
Received: (qmail 22380 invoked by uid 111); 5 Sep 2016 21:52:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 17:52:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2016 17:52:26 -0400
Date:   Mon, 5 Sep 2016 17:52:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] pack-objects: walk tag chains for --include-tag
Message-ID: <20160905215226.m6vv2tk5pe2qt4ui@sigill.intra.peff.net>
References: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pack-objects is given --include-tag, it peels each tag
ref down to a non-tag object, and if that non-tag object is
going to be packed, we include the tag, too. But what
happens if we have a chain of tags (e.g., tag "A" points to
tag "B", which points to commit "C")?

We'll peel down to "C" and realize that we want to include
tag "A", but we do not ever consider tag "B", leading to a
broken pack (assuming "B" was not otherwise selected).
Instead, we have to walk the whole chain, adding any tags we
find to the pack.

Interestingly, it doesn't seem possible to trigger this
problem with "git fetch", but you can with "git clone
--single-branch". The reason is that we generate the correct
pack when the client explicitly asks for "A" (because we do
a real reachability analysis there), and "fetch" is more
willing to do so. There are basically two cases:

  1. If "C" is already a ref tip, then the client can deduce
     that it needs "A" itself (via find_non_local_tags), and
     will ask for it explicitly rather than relying on the
     include-tag capability. Everything works.

  2. If "C" is not already a ref tip, then we hope for
     include-tag to send us the correct tag. But it doesn't;
     it generates a broken pack. However, the next step is
     to do a follow-up run of find_non_local_tags(),
     followed by fetch_refs() to backfill any tags we
     learned about.

     In the normal case, fetch_refs() calls quickfetch(),
     which does a connectivity check and sees we have no
     new objects to fetch. We just write the refs.

     But for the broken-pack case, the connectivity check
     fails, and quickfetch will follow-up with the remote,
     asking explicitly for each of the ref tips. This picks
     up the missing object in a new pack.

For a regular "git clone", we are similarly OK, because we
explicitly request all of the tag refs, and get a correct
pack. But with "--single-branch", we kick in tag
auto-following via "include-tag", but do _not_ do a
follow-up backfill. We just take whatever the server sent us
via include-tag and write out tag refs for any tag objects
we were sent. So prior to c6807a4 (clone: open a shortcut
for connectivity check, 2013-05-26), we actually claimed the
clone was a success, but the result was silently
corrupted!  Since c6807a4, index-pack's connectivity
check catches this case, and we correctly complain.

The included test directly checks that pack-objects does not
generate a broken pack, but also confirms that "clone
--single-branch" does not hit the bug.

Note that tag chains introduce another interesting question:
if we are packing the tag "B" but not the commit "C", should
"A" be included?

Both before and after this patch, we do not include "A",
because the initial peel_ref() check only knows about the
bottom-most level, "C". To realize that "B" is involved at
all, we would have to switch to an incremental peel, in
which we examine each tagged object, asking if it is being
packed (and including the outer tag if so).

But that runs contrary to the optimizations in peel_ref(),
which avoid accessing the objects at all, in favor of using
the value we pull from packed-refs. It's OK to walk the
whole chain once we know we're going to include the tag (we
have to access it anyway, so the effort is proportional to
the pack we're generating). But for the initial selection,
we have to look at every ref. If we're only packing a few
objects, we'd still have to parse every single referenced
tag object just to confirm that it isn't part of a tag
chain.

This could be addressed if packed-refs stored the complete
tag chain for each peeled ref (in most cases, this would be
the same cost as now, as each "chain" is only a single
link). But given the size of that project, it's out of scope
for this fix (and probably nobody cares enough anyway, as
it's such an obscure situation). This commit limits itself
to just avoiding the creation of a broken pack.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 31 +++++++++++++++++++++++++++++-
 t/t5305-include-tag.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4a63398..0954375 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2123,6 +2123,35 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 #define ll_find_deltas(l, s, w, d, p)	find_deltas(l, &s, w, d, p)
 #endif
 
+static void add_tag_chain(const struct object_id *oid)
+{
+	struct tag *tag;
+
+	/*
+	 * We catch duplicates already in add_object_entry(), but we'd
+	 * prefer to do this extra check to avoid having to parse the
+	 * tag at all if we already know that it's being packed (e.g., if
+	 * it was included via bitmaps, we would not have parsed it
+	 * previously).
+	 */
+	if (packlist_find(&to_pack, oid->hash, NULL))
+		return;
+
+	tag = lookup_tag(oid->hash);
+	while (1) {
+		if (!tag || parse_tag(tag) || !tag->tagged)
+			die("unable to pack objects reachable from tag %s",
+			    oid_to_hex(oid));
+
+		add_object_entry(tag->object.oid.hash, OBJ_TAG, NULL, 0);
+
+		if (tag->tagged->type != OBJ_TAG)
+			return;
+
+		tag = (struct tag *)tag->tagged;
+	}
+}
+
 static int add_ref_tag(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct object_id peeled;
@@ -2130,7 +2159,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, peeled.hash)    && /* peelable? */
 	    packlist_find(&to_pack, peeled.hash, NULL))      /* object packed? */
-		add_object_entry(oid->hash, OBJ_TAG, NULL, 0);
+		add_tag_chain(oid);
 	return 0;
 }
 
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index e3c6c62..a5eca21 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -63,4 +63,56 @@ test_expect_success 'check unpacked result (have commit, have tag)' '
 	test_cmp list.expect list.actual
 '
 
+# A tag of a tag, where the "inner" tag is not otherwise
+# reachable, and a full peel points to a commit reachable from HEAD.
+test_expect_success 'create hidden inner tag' '
+	test_commit commit &&
+	git tag -m inner inner HEAD &&
+	git tag -m outer outer inner &&
+	git tag -d inner
+'
+
+test_expect_success 'pack explicit outer tag' '
+	packname=$(
+		{
+			echo HEAD &&
+			echo outer
+		} |
+		git pack-objects --revs test-hidden-explicit
+	)
+'
+
+test_expect_success 'unpack objects' '
+	rm -rf clone.git &&
+	git init clone.git &&
+	git -C clone.git unpack-objects <test-hidden-explicit-${packname}.pack
+'
+
+test_expect_success 'check unpacked result (have all objects)' '
+	git -C clone.git rev-list --objects $(git rev-parse outer HEAD)
+'
+
+test_expect_success 'pack implied outer tag' '
+	packname=$(
+		echo HEAD |
+		git pack-objects --revs --include-tag test-hidden-implied
+	)
+'
+
+test_expect_success 'unpack objects' '
+	rm -rf clone.git &&
+	git init clone.git &&
+	git -C clone.git unpack-objects <test-hidden-implied-${packname}.pack
+'
+
+test_expect_success 'check unpacked result (have all objects)' '
+	git -C clone.git rev-list --objects $(git rev-parse outer HEAD)
+'
+
+test_expect_success 'single-branch clone can transfer tag' '
+	rm -rf clone.git &&
+	git clone --no-local --single-branch -b master . clone.git &&
+	git -C clone.git fsck
+'
+
 test_done
-- 
2.10.0.rc2.154.gb4a4b8b
