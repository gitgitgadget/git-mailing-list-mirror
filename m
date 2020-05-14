Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F6C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 20:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA04120675
	for <git@archiver.kernel.org>; Thu, 14 May 2020 20:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rc4qP2BN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgENUWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 16:22:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59726 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgENUWU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 16:22:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D48DBC5A09;
        Thu, 14 May 2020 16:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XYNT+LQ9npAGwXsc6qYmGGyv1bE=; b=Rc4qP2
        BNZ7luPtZKEeD83qVlMKE6vE/iK9OE2WZa24xsZ+6dTUFJQewRwGO4YxThrgTlCM
        DXwij2flUMqKKkZVQ5hyAU0P+3PsC3/u621X4qPosjyTWRHy7LbDm8eBkG5sJ8Fc
        2MNI0HgmxbuZlTMLTKsg4emp0cIZfqaz7J7ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TIDRwgikVZ51DayA5JvvcFOFDDaEwJdK
        MSzO/2cO13SGz3IlnQsLeZGwUFrnXDy9rb7KXA2vaxQvKsa/bcr7TdLJ8GimfRnX
        qbme0dtDCTd8zwND77g/awpFYmQEVeGKnFvmsyMZ8sDkkcakdyhI3APliuJoY9vO
        qvETZjBxhtw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD273C5A08;
        Thu, 14 May 2020 16:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C42EC5A07;
        Thu, 14 May 2020 16:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] unpack-trees: also allow get_progress() to work on a different index
References: <pull.785.git.git.1589486002453.gitgitgadget@gmail.com>
Date:   Thu, 14 May 2020 13:22:12 -0700
In-Reply-To: <pull.785.git.git.1589486002453.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 14 May 2020 19:53:22
        +0000")
Message-ID: <xmqq4ksiqnbf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 992EC1F6-9620-11EA-A675-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> commit b0a5a12a60 ("unpack-trees: allow check_updates() to work on a
> different index", 2020-03-27) allowed check_updates() to work on a
> different index, but it called get_progress() which was hardcoded to
> work on o->result much like check_updates() had been.  Update it to also
> accept an index parameter and have check_updates() pass that parameter
> along so that both are working on the same index.
>
> Noticed-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     unpack-trees: also allow get_progress() to work on a different index
>     
>     This is a fix to a minor 2.27 regression, from the en/sparse-checkout
>     series.

OK, so update_sparsity() calls the function with o->src_index,
get_progress() without this fix would iterate over an unrelated
o->result to count the cache entries that are marked for update or
removal and show the progress based on that number without this
patch?  The other caller in unpack_trees() uses o->result so there
is no change in the behaviour with or without the patch.

The flag bits on cache entries used to count the entries in the
index by the get_progress() function are applied only on the
o->result side when merged_entry() and friends call do_add_entry(),
no?  

Do we see these CE_UPDATE|CE_WT_REMOVE bits attached to the cache
entries in the o->src_index array when get_progress() is fed the
src_index in the first place?

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-785%2Fnewren%2Frecent-sparse-checkout-bugfix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-785/newren/recent-sparse-checkout-bugfix-v1
> Pull-Request: https://github.com/git/git/pull/785
>
>  unpack-trees.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 1fe3764f2b2..2e6e9d5eeb8 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -333,10 +333,10 @@ static void load_gitmodules_file(struct index_state *index,
>  	}
>  }
>  
> -static struct progress *get_progress(struct unpack_trees_options *o)
> +static struct progress *get_progress(struct unpack_trees_options *o,
> +				     struct index_state *index)
>  {
>  	unsigned cnt = 0, total = 0;
> -	struct index_state *index = &o->result;
>  
>  	if (!o->update || !o->verbose_update)
>  		return NULL;
> @@ -415,7 +415,7 @@ static int check_updates(struct unpack_trees_options *o,
>  	if (o->clone)
>  		setup_collided_checkout_detection(&state, index);
>  
> -	progress = get_progress(o);
> +	progress = get_progress(o, index);
>  
>  	git_attr_set_direction(GIT_ATTR_CHECKOUT);
>  
>
> base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
