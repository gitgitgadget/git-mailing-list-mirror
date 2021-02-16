Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F740C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 20:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398E964EB1
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 20:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBPUXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:23:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61894 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBPUXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 15:23:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F8BD117B9C;
        Tue, 16 Feb 2021 15:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+h9SZmDAs86dyiv4QJILpyKw6fU=; b=vgOkKE
        UF0SyozrlUm8fPs10dfv7LpbAK7kxJ/EKlbeSk9UDw/XDKrTz8uJCiWnweK7/+5+
        iAdMVYqhw6HGE7l248R0XWsyrdv0CImW96juROK82nNTg8ITjCUow0TAuw+AjXgM
        yk6gXowj11z+fMquhgUNT3r5g0rLNiODYVt6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nwTAjZIvzSLJHaF37/joD+LOn83lsOna
        IqgCIqA1OYjN96FjUs+H7+Anw3IG23mV8li5okKKToDVUM6iOTH4+o0jK0lBe65B
        hRfLSHyrO/O+yYaG08oqg6tk/3AnaiE8OVx/K1hqvKjuaZw5ixlkq/Bl/ViU70m5
        h9cle0hZOIc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68AFC117B9B;
        Tue, 16 Feb 2021 15:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0F21117B99;
        Tue, 16 Feb 2021 15:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] stash show: teach --include-untracked and
 --only-untracked
References: <cover.1612855690.git.liu.denton@gmail.com>
        <cover.1613459474.git.liu.denton@gmail.com>
        <85b81f2f06bd1b40ee2de220cc84dd74b425daf3.1613459475.git.liu.denton@gmail.com>
Date:   Tue, 16 Feb 2021 12:22:52 -0800
In-Reply-To: <85b81f2f06bd1b40ee2de220cc84dd74b425daf3.1613459475.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Feb 2021 23:11:56 -0800")
Message-ID: <xmqqczwzpxsz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0397602-7094-11EB-B5E7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
> +{
> +	const struct object_id *oid[] = { &info->w_commit, &info->u_tree };
> +	struct tree *tree[ARRAY_SIZE(oid)];
> +	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
> +	struct unpack_trees_options unpack_tree_opt = { 0 };
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(oid); i++) {
> +		tree[i] = parse_tree_indirect(oid[i]);
> +		if (parse_tree(tree[i]) < 0)
> +			die(_("failed to parse tree"));
> +		init_tree_desc(&tree_desc[i], tree[i]->buffer, tree[i]->size);
> +	}
> +
> +	unpack_tree_opt.head_idx = -1;
> +	unpack_tree_opt.src_index = &the_index;
> +	unpack_tree_opt.dst_index = &the_index;
> +	unpack_tree_opt.fn = twoway_merge;

OK, it looks like this was borrowed from read_tree implementation
for reading two trees into the index, sort-of, but is a bit funny.

The setting of .fn to twoway_merge is misleading.  The .fn callback
is to be used when .merge is set (otherwise nothing should call it
inside unpack-trees.c), but nobody seems to set opt.merge to true.

> +	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
> +		die(_("failed to unpack trees"));
> +
> +	do_diff_cache(&info->b_commit, diff_opt);
> +}

Nice to see that it was just a simple matter of programming ;-)



 builtin/stash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/builtin/stash.c w/builtin/stash.c
index c788a3e236..7e0204bd8a 100644
--- c/builtin/stash.c
+++ w/builtin/stash.c
@@ -807,10 +807,11 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 		init_tree_desc(&tree_desc[i], tree[i]->buffer, tree[i]->size);
 	}
 
+	/* mimic "git read-tree W U" without "-m" */
 	unpack_tree_opt.head_idx = -1;
 	unpack_tree_opt.src_index = &the_index;
 	unpack_tree_opt.dst_index = &the_index;
-	unpack_tree_opt.fn = twoway_merge;
+	unpack_tree_opt.fn = NULL;
 
 	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
 		die(_("failed to unpack trees"));
