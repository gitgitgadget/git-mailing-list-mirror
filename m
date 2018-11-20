Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175AA1F97E
	for <e@80x24.org>; Tue, 20 Nov 2018 05:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbeKTQMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:12:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55581 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKTQMW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:12:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5491C12641F;
        Tue, 20 Nov 2018 00:45:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pl8iIa8g987+4cjjpFC3qEF5ycI=; b=AIUcKy
        kXn3K6QpflrIILrRJRO5C5T14knqyynkIsgA8PxmN7/vDSwLJPuAcjDr4twkWCL8
        0aYQ5dux6MkK62oWlBj8Robml7bd8ov5UY6XFahqjD5PGU+wCiBnpWyT/I0FXtxp
        ioDGkW42ALcY3p8JABc/3vYwJP7oJw455o+A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NkjVL553kzC1w4EqFDcwRrKt2AfUo9Q+
        VqqYocxxSSjgrNlq4V78vqnUP4kCSBEkXBcjqKtbAMYFwx9n9yHIYffcqzYAE6mk
        2HNwchoXEpX/0uBDAlWyBo4iWwPqm9+gSWxSthy3Z+NK50twLURoelAnlgP8P6JA
        PcTR4HdXINs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A78212641D;
        Tue, 20 Nov 2018 00:45:04 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72F6512641B;
        Tue, 20 Nov 2018 00:45:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] pretty: allow showing specific trailers
References: <20181104152232.20671-1-anders@0x63.nu>
        <20181118114427.1397-1-anders@0x63.nu>
        <20181118114427.1397-3-anders@0x63.nu>
Date:   Tue, 20 Nov 2018 14:45:02 +0900
In-Reply-To: <20181118114427.1397-3-anders@0x63.nu> (Anders Waldenborg's
        message of "Sun, 18 Nov 2018 12:44:24 +0100")
Message-ID: <xmqq36rwb8v5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D68420C-EC87-11E8-BA5B-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> +  followed by a colon and zero or more comma-separated options:
> +  ** 'only': omit non-trailer lines from the trailer block.
> +  ** 'unfold': make it behave as if interpret-trailer's `--unfold`
> +     option was given.
> +  ** 'key=<K>': only show trailers with specified key. Matching is
> +     done case-insensitively and trailing colon is optional. If option
> +     is given multiple times only last one is used.
> +  ** Examples: `%(trailers:only,unfold)` unfolds and shows all trailer
> +     lines, `%(trailers:key=Reviewed-by,unfold)` unfolds and shows
> +     trailer lines with key `Reviewed-by`.

The last "Examples" item does not logically belong to the other
three, which bothers me a bit.

> diff --git a/pretty.c b/pretty.c
> index aa03d5b23..aaedc8447 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1074,6 +1074,17 @@ static int match_placeholder_arg(const char *to_parse, const char *candidate,
>  	return 0;
>  }
>  
> +struct format_trailer_match_data {
> +	const char *trailer;
> +	size_t trailer_len;
> +};
> +
> +static int format_trailer_match_cb(const struct strbuf *sb, void *ud)
> +{
> +	struct format_trailer_match_data *data = ud;
> +	return data->trailer_len == sb->len && !strncasecmp (data->trailer, sb->buf, sb->len);
> +}

>  	if (skip_prefix(placeholder, "(trailers", &arg)) {
>  		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +		struct format_trailer_match_data filter_data;
>  		size_t ret = 0;
>  
>  		opts.no_divider = 1;
> @@ -1323,7 +1335,24 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  					opts.only_trailers = 1;
>  				else if (match_placeholder_arg(arg, "unfold", &arg))
>  					opts.unfold = 1;
> -				else
> +				else if (skip_prefix(arg, "key=", &arg)) {
> +					const char *end = arg + strcspn(arg, ",)");
> +
> +					filter_data.trailer = arg;
> +					filter_data.trailer_len = end - arg;
> +
> +					if (filter_data.trailer_len &&
> +					    filter_data.trailer[filter_data.trailer_len - 1] == ':')
> +						filter_data.trailer_len--;
> +
> +					opts.filter = format_trailer_match_cb;
> +					opts.filter_data = &filter_data;
> +					opts.only_trailers = 1;
> +
> +					arg = end;
> +					if (*arg == ',')
> +						arg++;
> +				} else
>  					break;
>  			}

This is part of a loop that is entered after seeing "%(trailers:"
and existing one looks for 'unfold' and 'only' by using the
match_placeholder_arg() helper, which

 - returns false if the keyword is not what is being sought after;
 - returns 1 if it finds the keyword, followed by ',' or ')', and
   updates the end pointer to point at either the closing ')' or one
   place after the ','.

The new part cannot directly reuse the same helper because it
expects some non-constant string after "key=", but shouldn't we be
introducing a similar helper with extended feature to help this part
of the code to stay readable?  Exposing the minute details of the
logic to parse "key=<value>,..." while hiding the counterpart to
parse "(only|unfold),..." makes the implementation of the above loop
uneven and hard to follow.

I wonder if a helper like this would help:

static int match_placeholder(const char *to_parse, const char *keyword,
			     const char **value, size_t *valuelen,
			     const char **end)
{
	const char *p;

	if (!(skip_prefix(to_parse, keyword, &p)))
		return 0;

	if (value && valuelen) {
		/* expect "<keyword>=<value>" */
		size_t vlen;
		if (*p++ != '=')
			return 1;
		vlen = strcspn(p, ",)");
		if (!p[vlen])
			return 0;
		*value = p;
		*valuelen = vlen;
		p = p + vlen;
	}

	if (*p == ',') {
		*end = p + 1;
		return 1;
	}
	if (*p == ')') {
		*end = p;
		return 1;
	}
	return 0;
}

which would allow the existing one to become a thin wrapper

static int match_placeholder_arg(const char *a, const char *b, const char **c)
{
	return match_placeholder(a, b, NULL, NULL, c);
}

or can simply be eliminated by updating its only two callsites.

In the version you wrote, it is not clear what would happen if the
format string ends with "%(trailers:key=" (no value, no comma, not
even the closing paren).  I do not think it would fall into infinite
loop, but I do not think the code structure without the helper that
makes the loop's logic uniform would allow it to properly diagnose
such a malformed string.
