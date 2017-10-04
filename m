Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31062036B
	for <e@80x24.org>; Wed,  4 Oct 2017 06:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdJDGHf (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 02:07:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56581 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751266AbdJDGHd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 02:07:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83246A17D1;
        Wed,  4 Oct 2017 02:07:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+07hbyNTHHcAl1pDp6AzdiwtZNw=; b=LiNyL1
        X5asILoJRjJrdFnvR3ntmuMkBe0wWHxNxHK/iSgj1absN6VcEG7amBxzkJPY4aQ6
        v4ynQxQk4NFBW34mzkQ9UxtHDOpJmyEhxZdIgz/lnYZ3OECZfLpvO6LtwXdjCINZ
        EEr+ibMrQk45RyrEuEweCr3eM5ewzs4jmDd6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f+18Gr2C80sxKHJxJNIqb6GlujBdQ/bY
        FcSyXsHh1r4Ayn2n8bjm1MIaQlBm9309aKU5+OfBZ50MUgxC+wJoLD2r04NeCyne
        2CFJUjf0qT6/E7u6IFeVEovqk+ScglPuZ86o5ySlt1rZWYouDuwDSvepOEh71V7p
        HT8J0Wo4dWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B182A17CF;
        Wed,  4 Oct 2017 02:07:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB9C5A17CE;
        Wed,  4 Oct 2017 02:07:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com,
        sbeller@google.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20171002145651.204984-4-dstolee@microsoft.com>
Date:   Wed, 04 Oct 2017 15:07:25 +0900
In-Reply-To: <20171002145651.204984-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Oct 2017 10:56:49 -0400")
Message-ID: <xmqqtvzfcuoy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BFC3472-A8CA-11E7-AB28-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> -int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
> +struct min_abbrev_data {
> +	unsigned int init_len;
> +	unsigned int cur_len;
> +	char *hex;
> +};
> +
> +static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
>  {
> -	int status, exists;
> +	struct min_abbrev_data *mad = cb_data;
> +
> +	char *hex = oid_to_hex(oid);
> +	unsigned int i = mad->init_len;
> +	while (mad->hex[i] && mad->hex[i] == hex[i])
> +		i++;
> +
> +	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
> +		mad->cur_len = i + 1;
> +
> +	return 0;
> +}

The idea is to keep the target to be abbreviated in mad->hex[], and
as the two functions find_short_{object_filename,packed_object}
discover objects whose first 'len' letters of hexname are the same
as the target, they'd call into the "always_call_fn" callback, which
is this function, and it keeps track of the maximum of the common
prefix it has seen.  Which makes sense.  Well, sort of.

> -	exists = has_sha1_file(sha1);
> -	while (len < GIT_SHA1_HEXSZ) {
> -		struct object_id oid_ret;
> -		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
> -		if (exists
> -		    ? !status
> -		    : status == SHORT_NAME_NOT_FOUND) {
> -			hex[len] = 0;
> -			return len;
> -		}
> -		len++;
> -	}
> -	return len;

The "always_call_fn" thing is a big sledgehammer that overrides
everything else in update_candidates().  It bypasses the careful
machinery set up to avoid having to open ambiguous object to learn
their types as much as possible.  One narrow exception when it is OK
to use is if we never limit our candidates with type.

And it might appear that the conversion is safe (if only because we
do not see any type limitation in the get_short_oid() call above),
but I think there is one case where this patch changes the
behaviour: what happens if core.disambiguate was set to anything
other than "none"?  The new code does not know anything about type
based filtering, so it can end up reporting longer abbreviation than
it was asked to produce.  It may not be a problem in practice, though.

I am not sure if setting core.disambiguate is generally a good idea
in the first place, and if it is OK to break find_unique_abbrev()
with respect to the configuration variable like this patch does.

I'd feel safe if we get extra input from Peff, who introduced the
feature in 5b33cb1f ("get_short_sha1: make default disambiguation
configurable", 2016-09-27).

> +
> +	if (init_object_disambiguation(hex, len, &ds) < 0)
> +		return -1;
> +
> +	mad.init_len = len;
> +	mad.cur_len = len;
> +	mad.hex = hex;
> +
> +	ds.fn = extend_abbrev_len;
> +	ds.always_call_fn = 1;
> +	ds.cb_data = (void*)&mad;
> +
> +	find_short_object_filename(&ds);
> +	find_short_packed_object(&ds);
> +	(void)finish_object_disambiguation(&ds, &oid_ret);
> +
> +	hex[mad.cur_len] = 0;
> +	return mad.cur_len;
>  }
>  
>  const char *find_unique_abbrev(const unsigned char *sha1, int len)
