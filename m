Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928881F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 14:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbeGKOSl (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 10:18:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:55194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726639AbeGKOSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 10:18:41 -0400
Received: (qmail 9878 invoked by uid 109); 11 Jul 2018 14:14:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 14:14:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7249 invoked by uid 111); 11 Jul 2018 14:14:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 10:14:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 10:14:06 -0400
Date:   Wed, 11 Jul 2018 10:14:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] has_uncommitted_changes(): fall back to empty tree
Message-ID: <20180711141406.GE23835@sigill.intra.peff.net>
References: <87k1q2c9zq.fsf@evledraar.gmail.com>
 <20180711133402.GD23835@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711133402.GD23835@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 09:34:02AM -0400, Jeff King wrote:

> I do worry that other callers of run_diff_index() might have similar
> problems, though. Grepping around, the other callers seem to fall into
> one of three categories:
> 
>  - they resolve the object themselves and put it in the pending list
>    (and often fallback to the empty tree, which is more or less what the
>    patch above is doing)
> 
>  - they resolve the object themselves and avoid calling run_diff_index()
>    if it's not valid
> 
>  - they use setup_revisions(), which will barf on the broken object
> 
> So I think this may be sufficient. We probably should also add an
> assertion to run_diff_index(), since that's better than segfaulting.

Here's a patch to do that. I tweaked it slightly from what I showed
earlier to use the empty tree, which matches what other code (e.g.,
git-diff) would do.

-- >8 --
Subject: has_uncommitted_changes(): fall back to empty tree

If has_uncommitted_changes() can't resolve HEAD (e.g.,
because it's unborn or corrupt), then we end up calling
run_diff_index() with an empty revs.pending array. This
causes a segfault, as run_diff_index() blindly looks at the
first pending item.

Fixing this raises a question of fault: should
run_diff_index() handle this case, or is the caller wrong to
pass an empty pending list?

Looking at the other callers of run_diff_index(), they
handle this in one of three ways:

 - they resolve the object themselves, and avoid doing the
   diff if it's not valid

 - they resolve the object themselves, and fall back to the
   empty tree

 - they use setup_revisions(), which will die() if the
   object isn't valid

Since this is the only broken caller, that argues that the
fix should go there. Falling back to the empty tree makes
sense here, as we'd claim uncommitted changes if and only if
the index is non-empty. This may be a little funny in the
case of corruption (the corrupt HEAD probably _isn't_
empty), but:

  - we don't actually know the reason here that HEAD didn't
    resolve (the much more likely case is that we have an
    unborn HEAD, in which case the empty tree comparison is
    the right thing)

  - this matches how other code, like "git diff", behaves

While we're thinking about it, let's add an assertion to
run_diff_index(). It should always be passed a single
object, and as this bug shows, it's easy to get it wrong
(and an assertion is easier to hunt down than a segfault, or
a quietly ignored extra tree).

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c      |  3 +++
 t/t5520-pull.sh | 12 ++++++++++++
 wt-status.c     | 10 ++++++++++
 3 files changed, 25 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index a9f38eb5a3..732f684a49 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -520,6 +520,9 @@ int run_diff_index(struct rev_info *revs, int cached)
 	struct object_array_entry *ent;
 	uint64_t start = getnanotime();
 
+	if (revs->pending.nr != 1)
+		BUG("run_diff_index must be passed exactly one tree");
+
 	ent = revs->pending.objects;
 	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
 		exit(128);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 59c4b778d3..68aa5f0340 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -618,6 +618,18 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
 	)
 '
 
+test_expect_success 'pull --rebase fails on corrupt HEAD' '
+	test_when_finished "rm -rf corrupt" &&
+	git init corrupt &&
+	(
+		cd corrupt &&
+		test_commit one &&
+		obj=$(git rev-parse --verify HEAD | sed "s#^..#&/#") &&
+		rm -f .git/objects/$obj &&
+		test_must_fail git pull --rebase
+	)
+'
+
 test_expect_success 'setup for detecting upstreamed changes' '
 	mkdir src &&
 	(cd src &&
diff --git a/wt-status.c b/wt-status.c
index d1c05145a4..d89c41ba10 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2340,7 +2340,17 @@ int has_uncommitted_changes(int ignore_submodules)
 	if (ignore_submodules)
 		rev_info.diffopt.flags.ignore_submodules = 1;
 	rev_info.diffopt.flags.quick = 1;
+
 	add_head_to_pending(&rev_info);
+	if (!rev_info.pending.nr) {
+		/*
+		 * We have no head (or it's corrupt); use the empty tree,
+		 * which will complain if the index is non-empty.
+		 */
+		struct tree *tree = lookup_tree(the_hash_algo->empty_tree);
+		add_pending_object(&rev_info, &tree->object, "");
+	}
+
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
 	return diff_result_code(&rev_info.diffopt, result);
-- 
2.18.0.400.g702e398724

