Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85847C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4048F20795
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h3GBKIqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIRACC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 20:02:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIRACB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 20:02:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB0F66AA0B;
        Thu, 17 Sep 2020 20:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=YzbQ+c/6cCVQKBafZqZkUWende4=; b=h3GBKIqWRBtfZg8FgD0q
        kSZN17io1myQdK8nPHYt4V0nWcDGADyG0frVNf22YQYEzN7uNcBZ9LsHivxs6gTe
        QYCxy8bDnsCvG/qYMk+y01LDx5SKb/oNsYPubN67mXy52PIPDf6Q3dEf5vwPDjUm
        9HBIRNlazMG0WtPMg5pskIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=dshmGX9hV8umprf/8hwPzlgsbTnP/XnzuWNw+g0kBT5ejP
        N2uYVDyyWbXgqH6lsT6zE9A81K2zbnIiOuSwJHRjjRU1mS5X62C1rjMP89zlZUDh
        xGI1NiwNWBxHZ8Y/1tpUhgBIlhykD2j2MHcnLn9E3nQk0jRYULMSTl7B71GaU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A21E46AA0A;
        Thu, 17 Sep 2020 20:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 286E66AA08;
        Thu, 17 Sep 2020 20:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC v2 1/1] refspec: add support for negative refspecs
References: <20200821215247.758978-1-jacob.e.keller@intel.com>
        <20200821215247.758978-2-jacob.e.keller@intel.com>
Date:   Thu, 17 Sep 2020 17:01:58 -0700
Message-ID: <xmqqzh5onea1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C22CB36-F942-11EA-8967-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> @@ -66,6 +74,28 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>  	item->src = xstrndup(lhs, llen);
>  	flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
>  
> +	if (item->negative) {
> +		struct object_id unused;
> +
> +		/*
> +		 * Negative refspecs only have a LHS, which indicates a ref
> +		 * (or pattern of refs) to exclude from other matches. This
> +		 * can either be a simple ref, a glob pattern, or even an
> +		 * exact sha1 match.
> +		 */
> +		if (!*item->src)
> +			return 0; /* negative refspecs must not be empty */
> +		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
> +			item->exact_sha1 = 1; /* ok */
> +		else if (!check_refname_format(item->src, flags))
> +			; /* valid looking ref is ok */
> +		else
> +			return 0;
> +
> +		/* other rules for negative refspecs don't apply */

This comment confused me a bit; did you mean "other rules don't
apply to negative refspecs"?

> +		return 1;
> +	}
> +
>  	if (fetch) {
>  		struct object_id unused;


> diff --git a/remote.c b/remote.c
> index c5ed74f91c63..2f583d72c3f0 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1058,7 +1172,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
>  	const char *dst_value = rs->dst;
>  	char *dst_guess;
>  
> -	if (rs->pattern || rs->matching)
> +	if (rs->pattern || rs->matching || rs->negative)
>  		return 0;

OK.  These "special" ones do not participate in explicit matching.

> @@ -1134,6 +1248,10 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
>  	int matching_refs = -1;
>  	for (i = 0; i < rs->nr; i++) {
>  		const struct refspec_item *item = &rs->items[i];
> +
> +		if (item->negative)
> +			continue;
> +

And a negative one does not decide if a ref being pushed will be
pushed out for real at this point.  This helper is only to enumerate
the candidate refs to be pushed out; the caller makes a separate
call to apply_negative_refspecs() to cull the candidate list later.

OK.

> @@ -1339,7 +1457,7 @@ int check_push_refs(struct ref *src, struct refspec *rs)
>  	for (i = 0; i < rs->nr; i++) {
>  		struct refspec_item *item = &rs->items[i];
>  
> -		if (item->pattern || item->matching)
> +		if (item->pattern || item->matching || item->negative)
>  			continue;
>  
>  		ret |= match_explicit_lhs(src, item, NULL, NULL);

match_explicit_lhs(), like match_explicit(), are for explicit
matching and should not be called for the "special" ones.  OK.

> @@ -1441,6 +1559,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
>  		string_list_clear(&src_ref_index, 0);
>  	}
>  
> +	*dst = apply_negative_refspecs(*dst, rs);
> +
>  	if (errs)
>  		return -1;
>  	return 0;

And after grabbing all the candidate refs to be updated via this
push, we filter out the ones that match negative pattern.  Can it
also produce an error, or it can never fail (to udpate errs)?

> @@ -1810,6 +1930,9 @@ int get_fetch_map(const struct ref *remote_refs,
>  {
>  	struct ref *ref_map, **rmp;
>  
> +	if (refspec->negative)
> +		return 0;
> +

Again, the idea is to let the existing codepath to only deal with
the positive refspec elements to keep the same behaviour, and let
the caller filter the ones that match negative ones out of the
result.  So we return without anything here for negative one.

Nothing jumped out at me as being suspicious so far, other than that
the GNU "?<empty>:" thing needs to be fixed as pointed out by Dscho.

Thanks.
