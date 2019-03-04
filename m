Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6A720248
	for <e@80x24.org>; Mon,  4 Mar 2019 17:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCDRk4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 12:40:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:38126 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727278AbfCDRk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 12:40:56 -0500
Received: (qmail 27163 invoked by uid 109); 4 Mar 2019 17:40:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Mar 2019 17:40:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24242 invoked by uid 111); 4 Mar 2019 17:41:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 12:41:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 12:40:54 -0500
Date:   Mon, 4 Mar 2019 12:40:54 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: [PATCH] rev-list: allow cached objects in existence check
Message-ID: <20190304174053.GA27497@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a regression in 7c0fe330d5 (rev-list: handle missing tree
objects properly, 2018-10-05) where rev-list will now complain about the
empty tree when it doesn't physically exist on disk.

Before that commit, we relied on the traversal code in list-objects.c to
walk through the trees. Since it uses parse_tree(), we'd do a normal
object lookup that includes looking in the set of "cached" objects
(which is where our magic internal empty-tree kicks in).

After that commit, we instead tell list-objects.c not to die on any
missing trees, and we check them ourselves using has_object_file(). But
that function uses OBJECT_INFO_SKIP_CACHED, which means we won't use our
internal empty tree.

This normally wouldn't come up. For most operations, Git will try to
write out the empty tree object as it would any other object. And
pack-objects in a push or fetch will send the empty tree (even if it's
virtual on the sending side). However, there are cases where this can
matter. One I found in the wild:

  1. The root tree of a commit became empty by deleting all files,
     without using an index. In this case it was done using libgit2's
     tree builder API, but as the included test shows, it can easily be
     done with regular git using hash-object.

     The resulting repo works OK, as we'd avoid walking over our own
     reachable commits for a connectivity check.

  2. Cloning with --reference pointing to the repository from (1) can
     trigger the problem, because we tell the other side we already have
     that commit (and hence the empty tree), but then walk over it
     during the connectivity check (where we complain about it missing).

Arguably the workflow in step (1) should be more careful about writing
the empty tree object if we're referencing it. But this workflow did
work prior to 7c0fe330d5, so let's restore it.

This patch makes the minimal fix, which is to swap out a direct call to
oid_object_info_extended(), minus the SKIP_CACHED flag, instead of
calling has_object_file(). This is all that has_object_file() is doing
under the hood. And there's little danger of unrelated fallout from
other unexpected "cached" objects, since there's only one call site that
ends such a cached object, and it's in git-blame.

Signed-off-by: Jeff King <peff@peff.net>
---
I prepared this directly on top of 7c0fe330d5, but it should merge
cleanly into the current tip of master.

I think we might also consider just having has_object_file() respect
cached objects. The SKIP_CACHED flag comes from Jonathan Tan's
e83e71c5e1 (sha1_file: refactor has_sha1_file_with_flags, 2017-06-21).
But it was just matching the old behavior; it's not clear to me that we
particularly care about that, and it wasn't simply that nobody bothered
to put the cached-object check into has_sha1_file().

Some concerns/arguments against it:

  - we probably would want to make sure we do not short-cut
    write_sha1_file(). I.e., we should still write it to disk when
    somebody wants it. But I think that works, because that function
    uses its own check-and-freshen infrastructure.

  - some callers of has_sha1_file() might care about durability between
    processes. Because it's baked in, the empty tree is safe for that
    (whatever follow-on process runs, it will also be baked in there).
    But that's not necessarily true for other "cached" objects. I'm not
    really that worried about it because we use it sparingly (the only
    call to pretend_sha1_file() is in git-blame, and if it ever did ask
    "do we have this object", I actually think the right answer would be
    "yes").

    But if this is a concern, we could perhaps have two levels of flags:
    SKIP_CACHED and SKIP_INTERNAL.

 builtin/rev-list.c           |  2 +-
 t/t1060-object-corruption.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 49d6deed70..877b6561f4 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -237,7 +237,7 @@ static inline void finish_object__ma(struct object *obj)
 static int finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (!has_object_file(&obj->oid)) {
+	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
 		finish_object__ma(obj);
 		return 1;
 	}
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index ac1f189fd2..807b63b473 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -125,4 +125,14 @@ test_expect_success 'fetch into corrupted repo with index-pack' '
 	)
 '
 
+test_expect_success 'internal tree objects are not "missing"' '
+	git init missing-empty &&
+	(
+		cd missing-empty &&
+		empty_tree=$(git hash-object -t tree /dev/null) &&
+		commit=$(echo foo | git commit-tree $empty_tree) &&
+		git rev-list --objects $commit
+	)
+'
+
 test_done
-- 
2.21.0.684.gc9dc8b89c9
