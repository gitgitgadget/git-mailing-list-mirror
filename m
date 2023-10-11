Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89530CDB482
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjJKTiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjJKTiM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:38:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCE90
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:38:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B4821BF45;
        Wed, 11 Oct 2023 15:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=tlLsxv/m1NkMFbwMcHAnDXWkD7Twpt1x+SNexS
        M/UVI=; b=vriK7w38AyaXSZVGMnGo8MLISmg3R4r8ws3Z0XVr8JN6nayGXb/kAN
        VJhIKRzKgw3rheOY4LoEDX3Fozv1vm6oJRFs04LOLa9JNiuCxG8Fcbp2DE/y0238
        4TvGSyU8KjIS6Ngg8KOJw4KHhXNY+6z4XjqsagaHhzXAVtDDL/th0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9485D1BF44;
        Wed, 11 Oct 2023 15:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD5A51BF43;
        Wed, 11 Oct 2023 15:38:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk,
        Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Izzy <winglovet@gmail.com>
Subject: Re: [PATCH v6] merge-tree: add -X strategy option
In-Reply-To: <20231009185234.GB3270793@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 9 Oct 2023 14:52:34 -0400")
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
        <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
        <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>
        <20231009155315.GA3252778@coredump.intra.peff.net>
        <xmqq4jiz3env.fsf@gitster.g>
        <20231009185234.GB3270793@coredump.intra.peff.net>
Date:   Wed, 11 Oct 2023 12:38:03 -0700
Message-ID: <xmqqlec9kl0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2584D1E-686D-11EE-9EB7-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Oops, I totally missed the loop around the call to real_merge(). So
> yeah, I think this is rather tricky.
> ...
> I don't think there are any bugs with the state at the current tip of
> ty/merge-tree-strategy-options, but if we want to make it safer, I think
> we have two options:
>
>   - delay the conversion of the "xopts" list into merge_options until we
>     initialize it in real_merge(). This avoids breaking abstraction
>     boundaries, but does mean that the sanity-checking of the options
>     happens a little later (but not much in practice).
>
>   - provide a copy_merge_options() function, which makes this kind of
>     "set up a template and then copy it" pattern official. It can be a
>     struct assignment for now, but it at least alerts anybody adding new
>     options to the notion that a deep copy might be required.
>
> Option 1 looks something like this (a lot of the hunks are just
> reverting the tip of that branch, so squashed in it would be even
> smaller):

If we have no plan and intention to extend "merge-tree" even more in
the future, then option 1 would be the approach with least patch
noise, and as your "something like this" shows, it is a nice and
clean solution.  I very much like it.

But as the renovated "merge-tree" is a relatively young thing in our
toolbox, I suspect that more and more work may want to go into it.
And the other "official copy_merge_options()" approach would be a
more healthy solution in the longer run, I would think.  If we were
to go that route, we should also give an interface to free the
resources held by the copy.

It is not that much code on top of the commit that is already queued
in 'next', I suspect.  Perhaps something like this?

 builtin/merge-tree.c |  4 +++-
 merge-recursive.c    | 16 ++++++++++++++++
 merge-recursive.h    |  3 +++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git c/builtin/merge-tree.c w/builtin/merge-tree.c
index 7024b5ce2e..a35e0452d6 100644
--- c/builtin/merge-tree.c
+++ w/builtin/merge-tree.c
@@ -425,10 +425,11 @@ static int real_merge(struct merge_tree_options *o,
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *merge_bases = NULL;
-	struct merge_options opt = o->merge_options;
 	struct merge_result result = { 0 };
 	int show_messages = o->show_messages;
+	struct merge_options opt;
 
+	copy_merge_options(&opt, &o->merge_options);
 	parent1 = get_merge_parent(branch1);
 	if (!parent1)
 		help_unknown_ref(branch1, "merge-tree",
@@ -507,6 +508,7 @@ static int real_merge(struct merge_tree_options *o,
 	if (o->use_stdin)
 		putchar(line_termination);
 	merge_finalize(&opt, &result);
+	clear_merge_options(&opt);
 	return !result.clean; /* result.clean < 0 handled above */
 }
 
diff --git c/merge-recursive.c w/merge-recursive.c
index 0d7e57e2df..e3beb0801b 100644
--- c/merge-recursive.c
+++ w/merge-recursive.c
@@ -3912,6 +3912,22 @@ void init_merge_options(struct merge_options *opt,
 		opt->buffer_output = 0;
 }
 
+/*
+ * For now, members of merge_options do not need deep copying, but
+ * it may change in the future, in which case we would need to update
+ * this, and also make a matching change to clear_merge_options() to
+ * release the resources held by a copied instance.
+ */
+void copy_merge_options(struct merge_options *dst, struct merge_options *src)
+{
+	*dst = *src;
+}
+
+void clear_merge_options(struct merge_options *opt UNUSED)
+{
+	; /* no-op as our copy is shallow right now */
+}
+
 int parse_merge_opt(struct merge_options *opt, const char *s)
 {
 	const char *arg;
diff --git c/merge-recursive.h w/merge-recursive.h
index b88000e3c2..3d3b3e3c29 100644
--- c/merge-recursive.h
+++ w/merge-recursive.h
@@ -55,6 +55,9 @@ struct merge_options {
 
 void init_merge_options(struct merge_options *opt, struct repository *repo);
 
+void copy_merge_options(struct merge_options *dst, struct merge_options *src);
+void clear_merge_options(struct merge_options *opt);
+
 /* parse the option in s and update the relevant field of opt */
 int parse_merge_opt(struct merge_options *opt, const char *s);
 

