Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2DC0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 23:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGSXYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGSXYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 19:24:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38866268B
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 16:23:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B33521FC97;
        Wed, 19 Jul 2023 19:23:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vMK3jWtddBjVL9pTmoIGgSClict1TeOOWqd4GC
        r+nSQ=; b=sKDAIwwVSRb29fuZkg35pQRruUWXi0oTOnYxGBFEdJZ+D5DPaaz9aR
        OhLz+FUCNiPCYDq8CN1d+QsPSZMF2jQrL45/F4V9Py7q5aLNEBWkftE3+4x5gShK
        EKCl3t6jSOm8w7YJ7rg9R8/K8Ps0YDrSzd8IHSMrnvX1+Rc48tO0k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AADB71FC96;
        Wed, 19 Jul 2023 19:23:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32B991FC93;
        Wed, 19 Jul 2023 19:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 1/2] ref-filter: add multiple-option parsing functions
References: <20230714194249.66862-1-five231003@gmail.com>
        <20230719162424.70781-1-five231003@gmail.com>
        <20230719162424.70781-2-five231003@gmail.com>
Date:   Wed, 19 Jul 2023 16:23:15 -0700
In-Reply-To: <20230719162424.70781-2-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Wed, 19 Jul 2023 21:45:05 +0530")
Message-ID: <xmqqjzuv5vvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D167518-268B-11EE-8E9F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

>  ref-filter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

New helper functions that do not have any caller and no
documentation to explain how they are supposed to be called
(i.e. the expectation on the callers---what values they need to feed
as parameters when they call these helpers, and the expectation by
the callers---what they expect to get out of the helpers once they
return) makes it impossible to evaluate if they are any good [*].

	Side note.  Those of you who are keen to add unit tests to
	the system (Cc:ed) , do you think a patch line this one that
	adds a new helper function to the system, would benefit from
	being able to add a few unit tests for these otherwise
	unused helper functions?

	The calls to the new functions that the unit test framework
	would make should serve as a good piece of interface
	documentation, showing what the callers are supposed to pass
	and what they expect, I guess.

	So whatever framework we choose, it should allow adding a
	test or two to this patch easily, without being too
	intrusive.  Would that be a good and concrete evaluation
	criterion?

Anyway, because of that, I had to read [2/2] first and then come
back here to review this one.

The following is my attempt to write down the contract between the
callers and this new helper function---please give something like
that to the final version.  The the example below is there just to
illustrate the level of information that would be desired to help
future readers and programmers.  Do not take the contents as-written
as truth---I may have (deliberately) mixed in incorrect descriptions
;-).

/*
 * The string "to_parse" is expected to be a comma-separated list
 * of "key" or "key=val".  If your atom allows "key1" and "key2"
 * (possibly with their values) as options, make two calls to this
 * funtion, passing "key1" in candiate and then passing "key2" in
 * candidate.
 *
 * The function Returns true ONLY when the to_parse string begins
 * with the candidate key, possibly followed by its value (valueless
 * key-only entries are allowed in the comman-separated list).
 * Otherwise, *end, *valuestart and *valuelen are LEFT INTACT and
 * the function returns false.
 *
 * *valuestart will point at the byte after '=' (i.e. the beginning
 * of the value), and the number of bytes in the value will be set
 * to *valuelen.
 * A key-only entry results in *valuestart set to NULL and *valuelen
 * set to 0.
 * *end will point at the next key[=val] in the comma-separated list
 * or NULL when the list ran out.
 */

> +static int match_atom_arg_value(const char *to_parse, const char *candidate,
> +				const char **end, const char **valuestart,
> +				size_t *valuelen)
> +{
> +	const char *atom;
> +
> +	if (!(skip_prefix(to_parse, candidate, &atom)))
> +		return 0;
> +	if (valuestart) {

As far as I saw, no callers pass NULL to valuestart.  Getting rid of
this if() statement and always entering its body would clarify what
is going on, I think.

> +		if (*atom == '=') {
> +			*valuestart = atom + 1;
> +			*valuelen = strcspn(*valuestart, ",\0");
> +			atom = *valuestart + *valuelen;
> +		} else {
> +			if (*atom != ',' && *atom != '\0')
> +				return 0;
> +			*valuestart = NULL;
> +			*valuelen = 0;
> +		}
> +	}
> +	if (*atom == ',') {
> +		*end = atom + 1;
> +		return 1;
> +	}
> +	if (*atom == '\0') {
> +		*end = atom;
> +		return 1;
> +	}
> +	return 0;
> +}

/*
 * Write something similar to document the contract between the caller
 * and this function here.
 */
> +static int match_atom_bool_arg(const char *to_parse, const char *candidate,
> +				const char **end, int *val)
> +{

Thanks.
