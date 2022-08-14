Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A471C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 06:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiHNG3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 02:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNG3W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 02:29:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC71DA7B
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 23:29:21 -0700 (PDT)
Received: (qmail 18351 invoked by uid 109); 14 Aug 2022 06:29:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Aug 2022 06:29:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31421 invoked by uid 111); 14 Aug 2022 06:29:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Aug 2022 02:29:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 14 Aug 2022 02:29:15 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Olsen <andrew.olsen@koordinates.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: [PATCH] is_promisor_object(): fix use-after-free of tree buffer
Message-ID: <YviWO9Bhz5PU1HaL@coredump.intra.peff.net>
References: <CAPJmHpVssKshapGYDF-ifU1fts-jFTC-HqxnjN8meSMP3weB4g@mail.gmail.com>
 <YvS50W6wku5Y/NC7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvS50W6wku5Y/NC7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2022 at 04:12:01AM -0400, Jeff King wrote:

> So something like this makes the bug go away, though it does feel a
> little dirty:

Having slept on this, I actually think it's the right approach, for the
reasons given in the commit message below. And we definitely need to do
_something_ to fix the bug, and preferably something small and un-risky,
since this should probably go to 'maint'. The other obvious option is
reverting the original patch, but I think the memory savings it brought
would be hard to give up, and this patch should reliably fix the bug.

Thanks again for a clear bug report.

-- >8 --
Subject: is_promisor_object(): fix use-after-free of tree buffer

Since commit fcc07e980b (is_promisor_object(): free tree buffer after
parsing, 2021-04-13), we'll always free the buffers attached to a
"struct tree" after searching them for promisor links. But there's an
important case where we don't want to do so: if somebody else is already
using the tree!

This can happen during a "rev-list --missing=allow-promisor" traversal
in a partial clone that is missing one or more trees or blobs. The
backtrace for the free looks like this:

      #1 free_tree_buffer tree.c:147
      #2 add_promisor_object packfile.c:2250
      #3 for_each_object_in_pack packfile.c:2190
      #4 for_each_packed_object packfile.c:2215
      #5 is_promisor_object packfile.c:2272
      #6 finish_object__ma builtin/rev-list.c:245
      #7 finish_object builtin/rev-list.c:261
      #8 show_object builtin/rev-list.c:274
      #9 process_blob list-objects.c:63
      #10 process_tree_contents list-objects.c:145
      #11 process_tree list-objects.c:201
      #12 traverse_trees_and_blobs list-objects.c:344
      [...]

We're in the middle of walking through the entries of a tree object via
process_tree_contents(). We see a blob (or it could even be another tree
entry) that we don't have, so we call is_promisor_object() to check it.
That function loops over all of the objects in the promisor packfile,
including the tree we're currently walking. When we're done with it
there, we free the tree buffer. But as we return to the walk in
process_tree_contents(), it's still holding on to a pointer to that
buffer, via its tree_desc iterator, and it accesses the freed memory.

Even a trivial use of "--missing=allow-promisor" triggers this problem,
as the included test demonstrates (it's just a vanilla --blob:none
clone).

We can detect this case by only freeing the tree buffer if it was
allocated on our behalf. This is a little tricky since that happens
inside parse_object(), and it doesn't tell us whether the object was
already parsed, or whether it allocated the buffer itself. But by
checking for an already-parsed tree beforehand, we can distinguish the
two cases.

That feels a little hacky, and does incur an extra lookup in the
object-hash table. But that cost is fairly minimal compared to actually
loading objects (and since we're iterating the whole pack here, we're
likely to be loading most objects, rather than reusing cached results).

It may also be a good direction for this function in general, as there
are other possible optimizations that rely on doing some analysis before
parsing:

  - we could detect blobs and avoid reading their contents; they can't
    link to other objects, but parse_object() doesn't know that we don't
    care about checking their hashes.

  - we could avoid allocating object structs entirely for most objects
    (since we really only need them in the oidset), which would save
    some memory.

  - promisor commits could use the commit-graph rather than loading the
    object from disk

This commit doesn't do any of those optimizations, but I think it argues
that this direction is reasonable, rather than relying on parse_object()
and trying to teach it to give us more information about whether it
parsed.

The included test fails reliably under SANITIZE=address just when
running "rev-list --missing=allow-promisor". Checking the output isn't
strictly necessary to detect the bug, but it seems like a reasonable
addition given the general lack of coverage for "allow-promisor" in the
test suite.

Reported-by: Andrew Olsen <andrew.olsen@koordinates.com>
Signed-off-by: Jeff King <peff@peff.net>
---
The bug is in v2.32.0. I prepared this directly on top of fcc07e980b,
but it should apply cleanly to any recent maint or master tips.

 packfile.c               | 15 +++++++++++++--
 t/t5616-partial-clone.sh |  7 +++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index b79cbc8cd4..1556a5c3f3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2225,7 +2225,17 @@ static int add_promisor_object(const struct object_id *oid,
 			       void *set_)
 {
 	struct oidset *set = set_;
-	struct object *obj = parse_object(the_repository, oid);
+	struct object *obj;
+	int we_parsed_object;
+
+	obj = lookup_object(the_repository, oid);
+	if (obj && obj->parsed) {
+		we_parsed_object = 0;
+	} else {
+		we_parsed_object = 1;
+		obj = parse_object(the_repository, oid);
+	}
+
 	if (!obj)
 		return 1;
 
@@ -2247,7 +2257,8 @@ static int add_promisor_object(const struct object_id *oid,
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
 			oidset_insert(set, &entry.oid);
-		free_tree_buffer(tree);
+		if (we_parsed_object)
+			free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 5cb415386e..9c0e422a14 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,6 +49,13 @@ test_expect_success 'do partial clone 1' '
 	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
 '
 
+test_expect_success 'rev-list --missing=allow-promisor on partial clone' '
+	git -C pc1 rev-list --objects --missing=allow-promisor HEAD >actual &&
+	git -C pc1 rev-list --objects --missing=print HEAD >expect.raw &&
+	grep -v "^?" expect.raw >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-- 
2.37.1.926.g40145d0bb9

