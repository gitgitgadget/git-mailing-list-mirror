Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57D020196
	for <e@80x24.org>; Thu, 14 Jul 2016 17:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbcGNRDf (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 13:03:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751300AbcGNRDe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 13:03:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E7082AB78;
	Thu, 14 Jul 2016 13:03:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NkVIkBusPLF3
	tfKyJCY3vLve4DI=; b=hNlSnp/pXrgrhpCCLO/6xVAWVhJt56OBVJWtt8w4gig9
	wSpkLuDFcNTUN5gyhiKMioVMGTEiBVNmoWc7BppE+pUYeJZTQkXMoLWuub3fMDv8
	UO6AitZy0Ct9mNOE1OA7/EefM24qtF6vVodc7MU4/7q/PW8luOsD39k+bvZrsTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=k+1963
	cdhy2CFAUVz4mdvKs8ggZfgeNBfUl+xTFAeFjuPZM2uTQDe1MjA7mgyRrSAcoIXE
	EAFMicvnhjb/PTr2/l8xJ/Sd9abW7uXfm2pLZFTSypCh/2EMrrJHqPoYtn9t+ToZ
	JRgQo3lbqVym4djKarlkhIbRF+8P9Aa4zvBck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9370E2AB76;
	Thu, 14 Jul 2016 13:03:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17AC22AB75;
	Thu, 14 Jul 2016 13:03:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/3] fsck_walk(): optionally name objects on the go
References: <cover.1468510191.git.johannes.schindelin@gmx.de>
	<f5ef009d2be6bf0137b33ac9ce85ff0ce03a48e8.1468510191.git.johannes.schindelin@gmx.de>
Date:	Thu, 14 Jul 2016 10:03:29 -0700
In-Reply-To: <f5ef009d2be6bf0137b33ac9ce85ff0ce03a48e8.1468510191.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 14 Jul 2016 17:30:24 +0200
	(CEST)")
Message-ID: <xmqqeg6wrw2m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4C7FFD8-49E4-11E6-82C3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Note that this patch opts for decorating the objects with plain strings
> instead of full-blown structs (à la `struct rev_name` in the code of
> the `git name-rev` command), for several reasons:
>
> - the code is much simpler than if it had to work with structs that
>   describe arbitrarily long names such as "master~14^2~5:builtin/am.c",
>
> - the string processing is actually quite light-weight compared to the
>   rest of fsck's operation,
>
> - the caller of fsck_walk() is expected to provide names for the
>   starting points, and using plain and simple strings is just the
>   easiest way to do that.

Simpler is good; we can always optimize something well-isolated like
this later if it proves necessary.

> +static char *get_object_name(struct fsck_options *options, struct object *obj)
> +{
> +	return options->object_names ?
> +		lookup_decoration(options->object_names, obj) : NULL;
> +}
> +
> +static void put_object_name(struct fsck_options *options, struct object *obj,
> +	const char *fmt, ...)
> +{
> +	va_list ap;
> +	char *existing = lookup_decoration(options->object_names, obj);
> +	struct strbuf buf = STRBUF_INIT;

When reading a few early calling sites, it wasn't quite obvious how
the code avoids the "naming" when .object_names decoration is not
initialized (which is tied to the --name-objects option to decide if
the feature needs to be triggered).  The current "if get_object_name
for the containing object gives us NULL, then we refrain from
calling put_object_name()" may be good enough, but having an early
return similar to get_object_name() would make it easier to grok,
i.e.

	get_object_name(...)
        {
        	if (!options->object_names)
                	return NULL;
		return lookup_decoration(...);
	}

	put_object_name(...)
        {
		... decls ...

        	if (!options->object_names)
                	return NULL;
		existing = lookup_decoration(...);
                if (existing)
                	return existing;
		...
	}

It is a minor point, as the caller needs to check "name" that is the
value returned from get_object_name() for the containing object to
avoid wasting cycles to compute the parameters to pass to
put_object_name() anyway.

>  	while (tree_entry(&desc, &entry)) {
>  		int result;
>  
> +		if (name) {
> +			struct object *obj = parse_object(entry.oid->hash);

This worries me somewhat.  IIRC, "git fsck" uses object->parsed to
tell between objects that are unreachable or not and act differently
so I would fear that parsing the object here would screw up that
logic, when the call comes from fsck_dir() -> fsck_sha1_list() ->
fsck_sha1() -> fsck_obj() -> fsck_walk() -> fsck_walk_tree()
codepath.  Is it no longer the case, I wonder?

I see in the same loop there is a call to lookup_tree()->object, which
probably is how the existing code avoids that issue?
