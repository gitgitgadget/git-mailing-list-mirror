Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E89F20899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdHBWlz (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:41:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50358 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751145AbdHBWly (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:41:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A3DFA127E;
        Wed,  2 Aug 2017 18:41:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7M3+WI1af9OlBIAJgEGWSYtydP8=; b=hU4mIE
        sYrs2Zy1Ip9tJpPwEsdjWFvcAoHqo2JOTZFJWZX2f8UVzy9O2krKvbXv3ukIxJJP
        jH43am7QlKAjPGbCCQWnconFSLH40tv3eycvF7yRq+Lo6kc4W3vhQx3LmT+yOo+s
        IJ/bRLt4wrF6IeQ8k2O9cSYY4bMjVQn1uWr6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KmZG4MQ08TeXY5gfVb5+zWlHW84NTBJ5
        xzazSTMK8GumMSTGaE26Oi40M0pZ/hDqTx7PFELZSt99xClUzFBS6B96LncAwl7o
        T1Qa9vLUqNS51tjq8Ae+2a+Ov9ndHCk8VIkmCCrqmIE/zkqqUYI6b3VRpBluhjSR
        5pPs7/ZhIRI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22E34A127C;
        Wed,  2 Aug 2017 18:41:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 860B0A127A;
        Wed,  2 Aug 2017 18:41:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] revision: add rev_input_given flag
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
        <20170802222527.mnn7e6hlyevsgk7a@sigill.intra.peff.net>
Date:   Wed, 02 Aug 2017 15:41:52 -0700
In-Reply-To: <20170802222527.mnn7e6hlyevsgk7a@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 2 Aug 2017 18:25:27 -0400")
Message-ID: <xmqqd18dr3rj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C80482A4-77D3-11E7-BCC8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Normally a caller that invokes setup_revisions() has to
> check rev.pending to see if anything was actually queued for
> the traversal. But they can't tell the difference between
> two cases:
>
>   1. The user gave us no tip from which to start a
>      traversal.
>
>   2. The user tried to give us tips via --glob, --all, etc,
>      but their patterns ended up being empty.
>
> Let's set a flag in the rev_info struct that callers can use
> to tell the difference.  We can set this from the
> init_all_refs_cb() function.  That's a little funny because
> it's not exactly about initializing the "cb" struct itself.
> But that function is the common setup place for doing
> pattern traversals that is used by --glob, --all, etc.

...and "--bisect", which is an oddball so we probably do not have to
care.  I didn't check if there is a fallout on that codepath.




> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  revision.c | 1 +
>  revision.h | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 6603af944..08d5806b8 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1168,6 +1168,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
>  {
>  	cb->all_revs = revs;
>  	cb->all_flags = flags;
> +	revs->rev_input_given = 1;
>  }
>  
>  void clear_ref_exclusion(struct string_list **ref_excludes_p)
> diff --git a/revision.h b/revision.h
> index f96e7f7f4..c8f4e91f2 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -71,6 +71,13 @@ struct rev_info {
>  	const char *def;
>  	struct pathspec prune_data;
>  
> +	/*
> +	 * Whether the arguments parsed by setup_revisions() included any
> +	 * "input" revisions that might still have yielded an empty pending
> +	 * list (e.g., patterns like "--all" or "--glob").
> +	 */
> +	int rev_input_given;
> +
>  	/* topo-sort */
>  	enum rev_sort_order sort_order;
