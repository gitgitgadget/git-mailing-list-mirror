Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651B11F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 21:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfHPVeA (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 17:34:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53163 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfHPVeA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 17:34:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42BBE682BE;
        Fri, 16 Aug 2019 17:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rs4MHHpu0/uArMHPZpyFmGjZhkY=; b=n8CpAE
        PVCKt5eh3OG336evQq+Bv4X46tq6ptCTG3JwwTrK0TvwpwRYLqUXf9t8ci2gEoBm
        tgf1xEmM9v9zoVPyYtp9PtiMtvnIP6biheetU7DE36eWS8R+KA0zIXOuP+9rcQ8p
        017dZr0HOnVJItKzWJ/kNt56HJZW7vc+/u2Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F2MjuTLlo56dXS+GKu8jk13/GXbWpCaT
        pmL0OMPcZAFzFrStkk2TVU2k+I7+nweZOrV3wQAEM2E0bikfSpq9hEZk8hcyWewY
        7jIUw2GTdSNVGq5ODtg428DhO/iJNeks9qRFX/C8g7UopZvxQ+LO8EIx2ZFgYQvF
        ur4uMyn9U8M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A9C3682BD;
        Fri, 16 Aug 2019 17:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D330682BC;
        Fri, 16 Aug 2019 17:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 04/24] merge-recursive: provide a better label for diff3 common ancestor
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-5-newren@gmail.com>
Date:   Fri, 16 Aug 2019 14:33:50 -0700
In-Reply-To: <20190815214053.16594-5-newren@gmail.com> (Elijah Newren's
        message of "Thu, 15 Aug 2019 14:40:33 -0700")
Message-ID: <xmqqpnl4ztfl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AD39E3A-C06D-11E9-A3CE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> @@ -3507,6 +3507,11 @@ int merge_recursive(struct merge_options *opt,
>  	struct commit *merged_common_ancestors;
>  	struct tree *mrtree;
>  	int clean;
> +	int num_merge_bases;
> +	struct strbuf merge_base_abbrev = STRBUF_INIT;
> +
> +	if (!opt->call_depth)
> +		assert(opt->ancestor == NULL);

Hmph.  Do we have anything to say on this field when call_depth is
not zero?  Is it OK for opt->ancestor to be sometimes NULL and non
NULL some other times?

> @@ -3528,6 +3533,7 @@ int merge_recursive(struct merge_options *opt,
>  			output_commit_title(opt, iter->item);
>  	}
>  
> +	num_merge_bases = commit_list_count(ca);

Criss-cross merge with very large number of merge bases is rare, so
it is OK to count them all, even though we only care about "is it
zero, is it one, or is it two or more?"

I suspect this does not have to count, though, if we really wanted
to avoid counting.

>  	merged_common_ancestors = pop_commit(&ca);
>  	if (merged_common_ancestors == NULL) {
>  		/* if there is no common ancestor, use an empty tree */

Here is the case where we can already decide the ancestor name for
the later merge_trees() should be "empty tree".

And if merged_common_ancestors is not NULL, ca may have run out (in
which case, we only have a single merge base), or ca still has
another merge base (in which case, we have two or more).  So, if you
add
		ancestor_name = "empty tree";
	} else if (ca) {
		ancestor_name = "merged common ancestors";
	} else {
		ancestor_name = abbrev_name(merged_common_ancestors);
	}

to that if() statement above, that should be sufficient, no?

opt is used for inner merge in the for() loop, so you would probably
need another "char *" variable without contaminating opt->ancestor_name
at this point, and then assign the value in the temporary to the
opt->ancestor field where the original always assigned "merged
common ancestors".

> @@ -3568,10 +3574,23 @@ int merge_recursive(struct merge_options *opt,
>  	if (!opt->call_depth)
>  		repo_read_index(opt->repo);
>  
> -	opt->ancestor = "merged common ancestors";
> +	switch (num_merge_bases) {
> +	case 0:
> +		opt->ancestor = "<empty tree>";

Also, I do not see a reason why you want angle bra-ket pair around
"empty tree".  You are already using "merged common ancestors"
literal phrase without any special marker syntax.

Thanks.
