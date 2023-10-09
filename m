Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72993CD610E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376329AbjJIRKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377264AbjJIRKg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:10:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAD094
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:10:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1929F2997E;
        Mon,  9 Oct 2023 13:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=GlLfqHIJ5A9Ct8hf7VPE2I7XlhivChgCQ7lrMd
        n0de8=; b=b503/+7KmX7OZHOxIOBygMTI+OQG5R+DILYPsynLgo8Z/43kNInhDQ
        qacfRPHjhYYrr5gHdyqwgbRhi9XsIxAy06qgFppztbgYW9DNf+PatoQ87ZkH+AT5
        fAL4YpeackY490WXBCGPxSJ3bOFKT5l5mxjuu018GufIPOApXUZPQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 112652997D;
        Mon,  9 Oct 2023 13:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 628152997C;
        Mon,  9 Oct 2023 13:10:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk,
        Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Izzy <winglovet@gmail.com>
Subject: Re: [PATCH v6] merge-tree: add -X strategy option
In-Reply-To: <20231009155315.GA3252778@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 9 Oct 2023 11:53:15 -0400")
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
        <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
        <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>
        <20231009155315.GA3252778@coredump.intra.peff.net>
Date:   Mon, 09 Oct 2023 10:10:28 -0700
Message-ID: <xmqq4jiz3env.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFE6D9F8-66C6-11EE-80BE-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that struct-copying is an unusual pattern, and we'd potentially
> run into problems with duplication. But I think it is even trickier than
> that here. We also go on to actually _modify_ opt in this function,
> assigning to various members (both directly, and I think the merge code
> itself will write to opt->priv).
>
> So if we use a pointer (rather than struct assignment), those changes
> will persist in the merge_options struct that was passed in. Which is
> also weird.
>
> Between the two, I think using a pointer is probably the least-weird.
> This real_merge() function is only called once, and is a static-local
> helper for cmd_merge_tree(). So the two functions work as a single unit,
> and munging "opt" is not a big deal.

It is called once per --stdin input to perform many merges in a row.
The most obvious "structure to pointer to structure" conversion
below seems to break an assertion (which is not very surprising, as
it happens inside that --stdin loop), so I am tempted to revert the
whole thing for now.

Thanks.


git: merge-ort.c:5110: merge_incore_recursive: Assertion `opt->ancestor == NULL' failed.
./test-lib.sh: line 1067: 738791 Done                    printf "c1 c3\nc2 -- c1 c3\nc2 c3"
     738792 Aborted                 | git -C repo merge-tree --stdin > actual


 builtin/merge-tree.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git c/builtin/merge-tree.c w/builtin/merge-tree.c
index 7024b5ce2e..1cb1fba2de 100644
--- c/builtin/merge-tree.c
+++ w/builtin/merge-tree.c
@@ -425,7 +425,7 @@ static int real_merge(struct merge_tree_options *o,
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *merge_bases = NULL;
-	struct merge_options opt = o->merge_options;
+	struct merge_options *opt = &o->merge_options;
 	struct merge_result result = { 0 };
 	int show_messages = o->show_messages;
 
@@ -439,10 +439,10 @@ static int real_merge(struct merge_tree_options *o,
 		help_unknown_ref(branch2, "merge-tree",
 				 _("not something we can merge"));
 
-	opt.show_rename_progress = 0;
+	opt->show_rename_progress = 0;
 
-	opt.branch1 = branch1;
-	opt.branch2 = branch2;
+	opt->branch1 = branch1;
+	opt->branch2 = branch2;
 
 	if (merge_base) {
 		struct commit *base_commit;
@@ -452,11 +452,11 @@ static int real_merge(struct merge_tree_options *o,
 		if (!base_commit)
 			die(_("could not lookup commit '%s'"), merge_base);
 
-		opt.ancestor = merge_base;
+		opt->ancestor = merge_base;
 		base_tree = repo_get_commit_tree(the_repository, base_commit);
 		parent1_tree = repo_get_commit_tree(the_repository, parent1);
 		parent2_tree = repo_get_commit_tree(the_repository, parent2);
-		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
+		merge_incore_nonrecursive(opt, base_tree, parent1_tree, parent2_tree, &result);
 	} else {
 		/*
 		 * Get the merge bases, in reverse order; see comment above
@@ -467,7 +467,7 @@ static int real_merge(struct merge_tree_options *o,
 		if (!merge_bases && !o->allow_unrelated_histories)
 			die(_("refusing to merge unrelated histories"));
 		merge_bases = reverse_commit_list(merge_bases);
-		merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+		merge_incore_recursive(opt, merge_bases, parent1, parent2, &result);
 	}
 
 	if (result.clean < 0)
@@ -501,12 +501,12 @@ static int real_merge(struct merge_tree_options *o,
 	}
 	if (show_messages) {
 		putchar(line_termination);
-		merge_display_update_messages(&opt, line_termination == '\0',
+		merge_display_update_messages(opt, line_termination == '\0',
 					      &result);
 	}
 	if (o->use_stdin)
 		putchar(line_termination);
-	merge_finalize(&opt, &result);
+	merge_finalize(opt, &result);
 	return !result.clean; /* result.clean < 0 handled above */
 }
 

