Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44816C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BE1613B2
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbhDMHSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:18:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:50780 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239201AbhDMHSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:18:09 -0400
Received: (qmail 28557 invoked by uid 109); 13 Apr 2021 07:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:17:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23049 invoked by uid 111); 13 Apr 2021 07:17:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:17:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:17:48 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] revision: avoid parsing with --exclude-promisor-objects
Message-ID: <YHVFnNvGim8Iduwq@coredump.intra.peff.net>
References: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --exclude-promisor-objects is given, before traversing any objects
we iterate over all of the objects in any promisor packs, marking them
as UNINTERESTING and SEEN. We turn the oid we get from iterating the
pack into an object with parse_object(), but this has two problems:

  - it's slow; we are zlib inflating (and reconstructing from deltas)
    every byte of every object in the packfile

  - it leaves the tree buffers attached to their structs, which means
    our heap usage will grow to store every uncompressed tree
    simultaneously. This can be gigabytes.

We can obviously fix the second by freeing the tree buffers after we've
parsed them. But we can observe that the function doesn't look at the
object contents at all! The only reason we call parse_object() is that
we need a "struct object" on which to set the flags. There are two
options here:

  - we can look up just the object type via oid_object_info(), and then
    call the appropriate lookup_foo() function

  - we can call lookup_unknown_object(), which gives us an OBJ_NONE
    struct (which will get auto-converted later by object_as_type() via
    calls to lookup_commit(), etc).

The first one is closer to the current code, but we do pay the price to
look up the type for each object. The latter should be more efficient in
CPU, though it wastes a little bit of memory (the "unknown" object
structs are a union of all object types, so some of the structs are
bigger than they need to be). It also runs the risk of triggering a
latent bug in code that calls lookup_object() directly but isn't ready
to handle OBJ_NONE (such code would already be buggy, but we use
lookup_unknown_object() infrequently enough that it might be hiding).

I went with the second option here. I don't think the risk is high (and
we'd want to find and fix any such bugs anyway), and it should be more
efficient overall.

The new tests in p5600 show off the improvement (this is on git.git):

  Test                                 HEAD^               HEAD
  -------------------------------------------------------------------------------
  5600.5: count commits                0.37(0.37+0.00)     0.38(0.38+0.00) +2.7%
  5600.6: count non-promisor commits   11.74(11.37+0.37)   0.04(0.03+0.00) -99.7%

The improvement is particularly big in this script because _every_
object in the newly-cloned partial repo is a promisor object. So after
marking them all, there's nothing left to traverse.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c                    | 2 +-
 t/perf/p5600-partial-clone.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 553c0faa9b..7e73dafd96 100644
--- a/revision.c
+++ b/revision.c
@@ -3271,7 +3271,7 @@ static int mark_uninteresting(const struct object_id *oid,
 			      void *cb)
 {
 	struct rev_info *revs = cb;
-	struct object *o = parse_object(revs->repo, oid);
+	struct object *o = lookup_unknown_object(revs->repo, oid);
 	o->flags |= UNINTERESTING | SEEN;
 	return 0;
 }
diff --git a/t/perf/p5600-partial-clone.sh b/t/perf/p5600-partial-clone.sh
index 754aaec3dc..ca785a3341 100755
--- a/t/perf/p5600-partial-clone.sh
+++ b/t/perf/p5600-partial-clone.sh
@@ -27,4 +27,12 @@ test_perf 'fsck' '
 	git -C bare.git fsck
 '
 
+test_perf 'count commits' '
+	git -C bare.git rev-list --all --count
+'
+
+test_perf 'count non-promisor commits' '
+	git -C bare.git rev-list --all --count --exclude-promisor-objects
+'
+
 test_done
-- 
2.31.1.659.g9b9913af63
