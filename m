Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69554C43219
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE682343F
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbhALPML (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:12:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:53482 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbhALPMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:12:10 -0500
Received: (qmail 11077 invoked by uid 109); 12 Jan 2021 15:11:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 15:11:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15341 invoked by uid 111); 12 Jan 2021 15:11:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 10:11:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 10:11:29 -0500
From:   Jeff King <peff@peff.net>
To:     Arnaud Morin <arnaud.morin@gmail.com>
Cc:     git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: rev-list with multiple commits sharing same patch-id
Message-ID: <X/28IXBpse2dNZQH@coredump.intra.peff.net>
References: <20210109162440.GM31701@sync>
 <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 09:17:37AM -0500, Jeff King wrote:

> It looks like this was broken in v2.10.0, via dfb7a1b4d0 (patch-ids:
> stop using a hand-rolled hashmap implementation, 2016-07-29).
> 
> I think the issue is that it is allowing duplicate entries in the
> hashmap. The algorithm is something like:
> 
>   - iterate over left-hand commits, inserting patch-id for each into
>     hashmap
> 
>   - iterate over right-hand commits, seeing if any are present in
>     hashmap. If so, we exclude the commit _and_ mark the patch-id as
>     "seen"
> 
>   - iterate again over left-hand commits, omitting any whose patch-ids
>     are marked as "seen"
> 
> So if two commits on the left-hand side have the same patch-id, if we
> insert two entries into the hashmap, then only one of them is going to
> get its "seen" flag marked in the middle step.

Yeah, that's definitely it. Here's what the fix would look like directly
on top of dfb7a1b4d0:

diff --git a/patch-ids.c b/patch-ids.c
index db31fa647a..a8ed4f0872 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -66,12 +66,24 @@ struct patch_id *add_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
 	struct patch_id *key = xcalloc(1, sizeof(*key));
+	struct patch_id *old;
 
 	if (init_patch_id_entry(key, commit, ids)) {
 		free(key);
 		return NULL;
 	}
 
+	/*
+	 * Don't allow duplicates. Note that we can't use hashmap_put here; we
+	 * must retain the _old_ struct, because some commit->util is pointing
+	 * to it.
+	 */
+	old = hashmap_get(&ids->patches, key, ids);
+	if (old) {
+		free(key);
+		return old;
+	}
+
 	hashmap_add(&ids->patches, key);
 	return key;
 }
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 28d4f6b259..0c5f1dcc54 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -207,4 +207,16 @@ test_expect_success '--count --left-right' '
 	test_cmp expect actual
 '
 
+test_expect_success '--cherry-pick with duplicates on each side' '
+	git checkout -b dup-orig &&
+	test_commit dup-base &&
+	git revert dup-base &&
+	git cherry-pick dup-base &&
+	git checkout -b dup-side HEAD~3 &&
+	test_tick &&
+	git cherry-pick -3 dup-orig &&
+	git rev-list --cherry-pick dup-orig...dup-side >actual &&
+	test_must_be_empty actual
+'
+
 test_done


Unfortunately we can't do the same thing now. The "seen" flag went away
in 683f17ec44 (patch-ids: replace the seen indicator with a commit
pointer, 2016-07-29), in favor of having each patch_id struct point to a
"struct commit". We could revert that, or turn that pointer into a list,
but it gets worse. Later, b3dfeebb92 (rebase: avoid computing
unnecessary patch IDs, 2016-07-29) built on that by lazily computing the
patch-ids. So each patch_id struct must point to exactly one commit!

We'll have to either:

  - split them apart into two structs at the time of the lazy computation

or

  - accept having duplicate patch_ids, but on lookup make sure we find
    _all_ matches, not just the first one.

Hmm, that last one might not be too bad, since we have
hashmap_get_next() (it does mean iterating over a chained bucket
linearly, but that's already the worst-case for a hash lookup).

-Peff
