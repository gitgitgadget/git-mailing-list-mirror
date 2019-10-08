Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A621F4BE
	for <e@80x24.org>; Tue,  8 Oct 2019 02:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfJHCcW (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 22:32:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54736 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJHCcV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 22:32:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDBF82F21B;
        Mon,  7 Oct 2019 22:32:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pMHrF7c8l/H7VbXQYMo9MW5uNbU=; b=OY/Xin
        mxlEupRB7d6sB+qIjLzzsjkN2PDvymGz9tyjuo48Ivly1r8nf8VvOFyGdxtmp9gK
        LHwEFXwxq5utD4bxowP240lluRbhnKzkFxGjhv9Ulqp3xte71CXWW15jHxzry5vV
        tzWT7Uiyb1BBOws3+7UpWwFrp40IxVgStfmwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WPOWGUYpNCDyEbTNw29YSxDef8uaW0Ky
        7cjI2H3F5T6oYrNr9lwVl8VtwYPnbAAWulzHeH3cOTEHE1aVMegCu53oaRAfVvt9
        sw0D+TtoI6MuRH7eGkZzyTHzdS2frTawoTVAl9AXuclQCAECy9gBjhQ7DPrGEelj
        cKTKqvOq+3U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D70572F21A;
        Mon,  7 Oct 2019 22:32:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48DA12F219;
        Mon,  7 Oct 2019 22:32:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge-recursive: fix the fix to the diff3 common ancestor label
References: <xmqq7e5h46an.fsf@gitster-ct.c.googlers.com>
        <20191007155211.23067-1-newren@gmail.com>
Date:   Tue, 08 Oct 2019 11:32:18 +0900
In-Reply-To: <20191007155211.23067-1-newren@gmail.com> (Elijah Newren's
        message of "Mon, 7 Oct 2019 08:52:11 -0700")
Message-ID: <xmqqv9t0nf0t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D99FBD08-E973-11E9-880C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This resulted in garbage strings being printed for the virtual merge
> bases, which was visible in git.git by just merging commit b744c3af07
> into commit 6d8cb22a4f.  There are two ways to fix this: set
> opt->ancestor to NULL after using it to avoid re-use, or add a
> !opt->priv->call_depth check to the if block for using a pre-defined
> opt->ancestor.  Apply both fixes.

Thanks for quickly fixing this.  Will apply.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index e12d91f48a..2653ba9a50 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3550,7 +3550,7 @@ static int merge_recursive_internal(struct merge_options *opt,
>  		merged_merge_bases = make_virtual_commit(opt->repo, tree,
>  							 "ancestor");
>  		ancestor_name = "empty tree";
> -	} else if (opt->ancestor) {
> +	} else if (opt->ancestor && !opt->priv->call_depth) {
>  		ancestor_name = opt->ancestor;
>  	} else if (merge_bases) {
>  		ancestor_name = "merged common ancestors";
> @@ -3600,6 +3600,7 @@ static int merge_recursive_internal(struct merge_options *opt,
>  							  merged_merge_bases),
>  				     &result_tree);
>  	strbuf_release(&merge_base_abbrev);
> +	opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
>  	if (clean < 0) {
>  		flush_output(opt);
>  		return clean;
