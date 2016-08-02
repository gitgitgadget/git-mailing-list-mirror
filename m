Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5BB1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129AbcHBSGP (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 14:06:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757020AbcHBSFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 14:05:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45C1732DBF;
	Tue,  2 Aug 2016 13:31:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DMj/IAdaMoDsuq3tLKucBnF1HwQ=; b=WrSJHD
	OHghx1tIC8BCw0zq54rQkf/Ukw8mUQW2C0o3aDvIMwAQoapSGPsbQa+Qth/msfm/
	vwxd3nZOm0gsC1lI5Y0Y3QpYIJdqagK27IYzZw8BQm60CwDKZW9SbaQQhQiEjGxt
	ccjNY19jUHPZ0Q7UtcbYSLp1dHRA6fVGfTasg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CC4fvTrPhh5BZ6sjDUbjBWIwUe/kb5fg
	lWvUdsvcrshJGIs2k+8hCgcFHC8RwSHNYH8w00qT3wU/31YlYowBwWFUWshvxhwN
	qeq2e9sP6dn4qPy6W/urGxh+0wgmWI6k0dUVZNQ37tQ0bzS1VZgel42J9eRvZULL
	DcO1AVJVeGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E00432DBE;
	Tue,  2 Aug 2016 13:31:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4A5032DBD;
	Tue,  2 Aug 2016 13:31:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 02/13] bisect: rewrite `check_term_format` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423cc5-691952fa-3726-4132-bcc1-dfa55d4c0895-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 10:31:39 -0700
In-Reply-To: <0102015640423cc5-691952fa-3726-4132-bcc1-dfa55d4c0895-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqq7fbzf56s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9BCBA90-58D6-11E6-972B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +/*
> + * Check whether the string `term` belongs to the set of strings
> + * included in the variable arguments.
> + */
> +static int one_of(const char *term, ...)
> +{
> +	int res = 0;
> +	va_list matches;
> +	const char *match;
> +
> +	va_start(matches, term);
> +	while (!res && (match = va_arg(matches, const char *)))
> +		res = !strcmp(term, match);
> +	va_end(matches);
> +
> +	return res;
> +}

It might be safer to mark this function with LAST_ARG_MUST_BE_NULL,
but because this is static to this function, it may not matter too
much.  Just an observation, not a strong suggestion to change the
patch.

> +static int check_term_format(const char *term, const char *orig_term)
> +{
> +	int res;
> +	char *new_term = xstrfmt("refs/bisect/%s", term);
> +
> +	res = check_refname_format(new_term, 0);
> +	free(new_term);

Yup, that looks much more straight-forward than using a one-time-use
strbuf.
