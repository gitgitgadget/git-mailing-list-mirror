Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED8C33C9E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 11:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD182077B
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 11:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgAHLnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:43:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:60162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728167AbgAHLnq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 06:43:46 -0500
Received: (qmail 21614 invoked by uid 109); 8 Jan 2020 11:43:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 11:43:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9213 invoked by uid 111); 8 Jan 2020 11:49:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 06:49:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 06:43:44 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten Krah <krah.tm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] restore: invalidate cache-tree when removing entries with
 --staged
Message-ID: <20200108114344.GA3380580@coredump.intra.peff.net>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
 <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
 <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
 <20200108091119.GB87523@coredump.intra.peff.net>
 <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
 <20200108104008.GA2207365@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108104008.GA2207365@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 05:40:08AM -0500, Jeff King wrote:

> So there seem to be at least two bugs:
> 
>  - git-restore doesn't properly invalidate the cache-tree
> 
>  - the index-reading code is not careful enough about bogus cache-trees,
>    and may segfault

Here's a fix for the first one. I'm adding Junio to the cc as an expert
in index and cache-tree issues. I'm pretty sure this is the correct fix,
but I have some lingering questions below.

I'm not planning on working on the second one immediately. Between this
and Emily's patch from yesterday, I have a feeling that the index code
could use an audit to be a bit more careful about handling bogus on-disk
data.

-- >8 --
Subject: restore: invalidate cache-tree when removing entries with --staged

When "git restore --staged <path>" removes a path that's in the index,
it marks the entry with CE_REMOVE, but we don't do anything to
invalidate the cache-tree. In the non-staged case, we end up in
checkout_worktree(), which calls remove_marked_cache_entries(). That
actually drops the entries from the index, as well as invalidating the
cache-tree and untracked-cache.

But with --staged, we never call checkout_worktree(), and the CE_REMOVE
entries remain. Interestingly, they are dropped when we write out the
index, but that means the resulting index is inconsistent: its
cache-tree will not match the actual entries, and running "git commit"
immediately after will create the wrong tree.

We can solve this by calling remove_marked_cache_entries() ourselves
before writing out the index. Note that we can't just hoist it out of
checkout_worktree(); that function needs to iterate over the CE_REMOVE
entries (to drop their matching worktree files) before removing them.

One curiosity about the test: without this patch, it actually triggers a
BUG() when running git-restore:

  BUG: cache-tree.c:810: new1 with flags 0x4420000 should not be in cache-tree

But in the original problem report, which used a similar recipe,
git-restore actually creates the bogus index (and the commit is created
with the wrong tree). I'm not sure why the test here behaves differently
than my out-of-suite reproduction, but what's here should catch either
symptom (and the fix corrects both cases).

Reported-by: Torsten Krah <krah.tm@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
So I'm mildly puzzled about the BUG thing above. But also: it seems
really weird that do_write_index() will drop CE_REMOVE entries as it
writes, but not invalidate the cache-tree (or the untracked-cache, which
AFAICT is probably similarly affected). Should it be doing that
invalidation? Or should it be a BUG() to write out an index without
having done remove_marked_cache_entries()?

 builtin/checkout.c |  2 ++
 t/t2070-restore.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b52c490c8f..18ef5fb975 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -524,6 +524,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	/* Now we are committed to check them out */
 	if (opts->checkout_worktree)
 		errs |= checkout_worktree(opts);
+	else
+		remove_marked_cache_entries(&the_index, 1);
 
 	/*
 	 * Allow updating the index when checking out from the index.
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 21c3f84459..06a5976143 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -96,6 +96,7 @@ test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
 '
 
 test_expect_success 'restore --staged adds deleted intent-to-add file back to index' '
+	test_when_finished git reset --hard &&
 	echo "nonempty" >nonempty &&
 	>empty &&
 	git add nonempty empty &&
@@ -106,4 +107,21 @@ test_expect_success 'restore --staged adds deleted intent-to-add file back to in
 	git diff --cached --exit-code
 '
 
+test_expect_success 'restore --staged invalidates cache tree for deletions' '
+	test_when_finished git reset --hard &&
+	>new1 &&
+	>new2 &&
+	git add new1 new2 &&
+
+	# It is important to commit and then reset here, so that the index
+	# contains a valid cache-tree for the "both" tree.
+	git commit -m both &&
+	git reset --soft HEAD^ &&
+
+	git restore --staged new1 &&
+	git commit -m "just new2" &&
+	git rev-parse HEAD:new2 &&
+	test_must_fail git rev-parse HEAD:new1
+'
+
 test_done
-- 
2.25.0.rc1.622.g8cfac75bdd

