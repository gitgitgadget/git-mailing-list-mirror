Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2981F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbdAYTVP (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:21:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59500 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752351AbdAYTVO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:21:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32396628E1;
        Wed, 25 Jan 2017 14:21:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yNJeog4pL2LdSwnZeNanekc0Fig=; b=qdMS/6
        TpGMfHPMIQWDFHLgse4hHGO72B4jtVDNY1f1C+N/GsvZ2mSnyTJ+bh+HxxxHdgvr
        nTDHsAuYvco3cSJovUmYSz3uqu981dFOJcKzSbPr8Gdp8rlpAZUnzrWvD6Ow4CS/
        m5fCWCFssGPiMDodDxD8txhUR003kA3qJteVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JKsIsBt/+6PQBk8X0hjM0F/uer5q5AJD
        vi8wFzmKlGf8i9MpR+QE9rfO/T+cnBvwKLl4jm2pIJobpvE9XhmYTU+w2fozHfsj
        X1ApilGKyf6O+kcr0HWAATovRAnrRG3xVixPo0Z+ZhhMzKPZJH67RY4izf/T7ydd
        ZnXCngBxf1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28A92628E0;
        Wed, 25 Jan 2017 14:21:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6EA54628DF;
        Wed, 25 Jan 2017 14:21:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/12] fetch-pack: cache results of for_each_alternate_ref
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124004559.vlsrwwphuzdsfqoq@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 11:21:11 -0800
In-Reply-To: <20170124004559.vlsrwwphuzdsfqoq@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Jan 2017 19:45:59 -0500")
Message-ID: <xmqqinp3aqu0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EE465C0-E333-11E6-8BC8-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +struct alternate_object_cache {
> +	struct object **items;
> +	size_t nr, alloc;
> +};
> +
> +static void cache_one_alternate(const char *refname,
> +				const struct object_id *oid,
> +				void *vcache)
> +{
> +	struct alternate_object_cache *cache = vcache;
> +	struct object *obj = parse_object(oid->hash);
> +
> +	if (!obj || (obj->flags & ALTERNATE))
> +		return;
> +
> +	obj->flags |= ALTERNATE;
> +	ALLOC_GROW(cache->items, cache->nr + 1, cache->alloc);
> +	cache->items[cache->nr++] = obj;
> +}

Nice.  I love simplicity.

> diff --git a/object.h b/object.h
> index 614a00675..f52957dcb 100644
> --- a/object.h
> +++ b/object.h
> @@ -29,7 +29,7 @@ struct object_array {
>  /*
>   * object flag allocation:
>   * revision.h:      0---------10                                26
> - * fetch-pack.c:    0---4
> + * fetch-pack.c:    0---5
>   * walker.c:        0-2
>   * upload-pack.c:       4       11----------------19
>   * builtin/blame.c:               12-13

This is a tangent, but I am not sure how much it buys us to keep
track of the information here in object.h, as all that picture says
is "revision traversal machinery given by revision.[ch] can never be
used inside fetch-pack and upload-pack", and that is already said by
the current picture that says fetch-pack.c uses 0 thru 4, and
updating it to say that we now use 0 thru 5 would not change the
conclusion.

What I am trying to get at is that we may want to (re)consider how
we manage these bits.  But that is totally outside the scope of this
series, and updating the above is the right thing to do here.

Thanks.
