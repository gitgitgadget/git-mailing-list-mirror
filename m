Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F8B20986
	for <e@80x24.org>; Wed, 19 Oct 2016 21:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756891AbcJSVXq (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 17:23:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52855 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756890AbcJSVXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 17:23:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B446C4791C;
        Wed, 19 Oct 2016 17:23:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SHkcB/POrqAyVi4HLOEBxxdmaoE=; b=kT2e8v
        iKt8bu8JwE20gxqjLeXdVntjCJUN5DAXlwb/LruAjYrpAChqXN7lqRnzSSevuaCS
        35eUTwZEWJJmex9Qx5+fKNGC6qbEASZZCCw0VcZzNs8MLbQRDCrHaQRHDwayS1Or
        5V/l70rrdSQ773tz5OgQ5EecGXu3sazalA1eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lfdZNAgjp0worDQAqGEQCrDYbMwMAn5M
        OUCAeBtqqSehFwZee2U4rF4zktDGmUjgaY2ELWai7iilxF66xLJLOU4vLD8fcqqz
        1SyPgALiYrcD8l10WvRQL4asFaJtfdeBLUqWZAu8vtunBY/nQUbWpqP//qBNckHV
        wueKIWyEOQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C0D74791A;
        Wed, 19 Oct 2016 17:23:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBDB747919;
        Wed, 19 Oct 2016 17:23:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        sunshine@sunshineco.com, walters@verbum.org,
        Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: split ref_kind_from_filter
References: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
        <20161019203546.dfqmi2czcxopgj6w@sigill.intra.peff.net>
Date:   Wed, 19 Oct 2016 14:23:41 -0700
In-Reply-To: <20161019203546.dfqmi2czcxopgj6w@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 19 Oct 2016 16:35:46 -0400")
Message-ID: <xmqqd1iwkp7m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FB1EA8A-9642-11E6-8FFA-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: Re: [PATCH 1/2] ref-filter: split ref_kind_from_filter

I think you meant ref_kind_from_refname() ;-)

Looks like a good idea.

> This function does two things: if we know we are filtering
> only a certain kind of ref, then we can immediately know
> that we have that kind. If not, then we compute the kind
> from the fully-qualified refname. The latter half is useful
> for other callers; let's split it out.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index cfbcd73..77ec9de 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1329,7 +1329,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
>  	return ref;
>  }
>  
> -static int filter_ref_kind(struct ref_filter *filter, const char *refname)
> +static int ref_kind_from_refname(const char *refname)
>  {
>  	unsigned int i;
>  
> @@ -1342,11 +1342,7 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
>  		{ "refs/tags/", FILTER_REFS_TAGS}
>  	};
>  
> -	if (filter->kind == FILTER_REFS_BRANCHES ||
> -	    filter->kind == FILTER_REFS_REMOTES ||
> -	    filter->kind == FILTER_REFS_TAGS)
> -		return filter->kind;
> -	else if (!strcmp(refname, "HEAD"))
> +	if (!strcmp(refname, "HEAD"))
>  		return FILTER_REFS_DETACHED_HEAD;
>  
>  	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
> @@ -1357,6 +1353,15 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
>  	return FILTER_REFS_OTHERS;
>  }
>  
> +static int filter_ref_kind(struct ref_filter *filter, const char *refname)
> +{
> +	if (filter->kind == FILTER_REFS_BRANCHES ||
> +	    filter->kind == FILTER_REFS_REMOTES ||
> +	    filter->kind == FILTER_REFS_TAGS)
> +		return filter->kind;
> +	return ref_kind_from_refname(refname);
> +}
> +
>  /*
>   * A call-back given to for_each_ref().  Filter refs and keep them for
>   * later object processing.
