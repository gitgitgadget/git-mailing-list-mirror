Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167FBC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 16:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350311AbiCPQwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbiCPQv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 12:51:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3590837BCF
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 09:50:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0ED9126B28;
        Wed, 16 Mar 2022 12:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wd0STY48QG3LQwZMutekiB4rwNCa/002yql19u
        XG4vs=; b=rvgTtdoefXn8msTWmcAS5C8Ol10vg3y3g0Mrv534Gm6fTpRsyI1QbW
        khD1ke+5rhym2Vev4UktJkFCg7pLpIoGT+hto7i78fw2IxFp+d6mXZOdnF/hA12M
        o9jPT9b1ombl6jU8wYlfxs++iF8qdD+W02tPleCHS2xhOAnKSwBXM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9374126B27;
        Wed, 16 Mar 2022 12:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61718126B26;
        Wed, 16 Mar 2022 12:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/6] builtin/stash: fill in all commit data
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220310173236.4165310-3-sandals@crustytoothpaste.net>
Date:   Wed, 16 Mar 2022 09:50:42 -0700
In-Reply-To: <20220310173236.4165310-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Mar 2022 17:32:32 +0000")
Message-ID: <xmqqv8wdn8nx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 381B1D8A-A549-11EC-89DE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> get_stash_info doesn't ensure that all entries are filled in in all
> cases.  However, we'll want to use this information to write new
> commits, and when we do so, we'll need all the information to be
> present.  Fill in all the commit information whenever we call this
> function.
>
> Note that the behavior of info->has_u doesn't change here.  If we
> previously read a tree a refs/stash^3:, then refs/stash^3 must be a
> treeish.  We already here assume that the other parents specifically
> commits, so it should be safe to do so here as well.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/stash.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 2aa06cc91d..128f0a01ef 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -124,6 +124,7 @@ static void free_stash_info(struct stash_info *info)

Before this function ...

>  static void assert_stash_like(struct stash_info *info, const char *revision)
>  {
>  	if (get_oidf(&info->b_commit, "%s^1", revision) ||
> +	    get_oidf(&info->i_commit, "%s^2", revision) ||
>  	    get_oidf(&info->w_tree, "%s:", revision) ||
>  	    get_oidf(&info->b_tree, "%s^1:", revision) ||
>  	    get_oidf(&info->i_tree, "%s^2:", revision))

... there is this comment.

/*
 * w_commit is set to the commit containing the working tree
 * b_commit is set to the base commit
 * i_commit is set to the commit containing the index tree
 * u_commit is set to the commit containing the untracked files tree
 * w_tree is set to the working tree
 * b_tree is set to the base tree
 * i_tree is set to the index tree
 * u_tree is set to the untracked files tree
 */

We probably would want to comment that u_commit (hence u_tree) is
optional.  That is why assert_stash_like() does not say anything
about u_commit or u_tree, right?

It is curious why the function does not learn to check w_commit,
even though the proposed commit log message claims that this is
about filling all commit data.

> @@ -166,7 +167,8 @@ static int get_stash_info_1(struct stash_info *info, const char *commit, int qui
>  
>  	assert_stash_like(info, revision);
>  
> -	info->has_u = !get_oidf(&info->u_tree, "%s^3:", revision);
> +	info->has_u = !get_oidf(&info->u_commit, "%s^3", revision) &&
> +		      !get_oidf(&info->u_tree, "%s^3:", revision);
>  
>  	end_of_rev = strchrnul(revision, '@');
>  	strbuf_add(&symbolic, revision, end_of_rev - revision);
