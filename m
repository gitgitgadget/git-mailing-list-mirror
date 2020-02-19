Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C17AC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33142208C4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JWpAf6W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBSTQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:16:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60423 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBSTQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:16:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D909F47B80;
        Wed, 19 Feb 2020 14:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bk5FqD/fXz6+6OLIKDuF6VOIeRs=; b=JWpAf6
        W8htNfoC5dtnHgLHZjakZKz3Hbe6E01O/qYT9EUcsgCIhHLJUq0uLxn5t0jYciE3
        T9Gk8kw4quqwHYlBu07qUmKpsPqqr1bBGw7v5/eI9UrrmbtJWznpDUeN56eHKGuX
        sDMXZE3s3GvLT6QOGvBlf+m0Ho+YpMa69+0x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YEOQ33U/o2HJy7g+/S2prkgLyH7ztiAz
        JMlNSjqKcv9tlGnRxNNJgQabjrnGpseTyGTN7wAYhc6kL4oOqLXhKzhbgYMNvluY
        pBFgDNNA1JqIzKa7gGum7picWmsLEmcBug50gG68S7HZ33HINP8DqFitIBT7My9d
        xKNPEL9PCgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD24047B7F;
        Wed, 19 Feb 2020 14:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1585B47B7E;
        Wed, 19 Feb 2020 14:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pbonzini@redhat.com
Cc:     git@vger.kernel.org, bfields@redhat.com
Subject: Re: [PATCH 1/4] parse-options: convert "command mode" to a flag
References: <20200219161352.13562-1-pbonzini@redhat.com>
        <20200219161352.13562-2-pbonzini@redhat.com>
Date:   Wed, 19 Feb 2020 11:15:53 -0800
In-Reply-To: <20200219161352.13562-2-pbonzini@redhat.com>
        (pbonzini@redhat.com's message of "Wed, 19 Feb 2020 17:13:49 +0100")
Message-ID: <xmqqzhdee6c6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4062E2B2-534C-11EA-B5EB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pbonzini@redhat.com writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> OPTION_CMDMODE is essentially OPTION_SET_INT plus the extra check
> that the variable had not set before.  In order to allow custom
> processing, change it to OPTION_SET_INT plus a new flag that takes
> care of the check.  This works as long as the option value points
> to an int.

It is unclear but I am guessing that the purpose of this change is
to make "only one of these" orthgonal to "the value of this option
is an int", in preparation to allow options other than SET_INT to
also be combined with "only one of these"?

If my reading is not correct, that would be an indication that the
above paragraph does not tell what it wants to to readers.  

It is unclear at this step what other kind of option the flag wants
to be combined, though.

> diff --git a/parse-options.c b/parse-options.c
> index a0cef401fc..c6e9e2733b 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -61,7 +61,7 @@ static enum parse_opt_result opt_command_mode_error(
>  	 */
>  	for (that = all_opts; that->type != OPTION_END; that++) {
>  		if (that == opt ||
> -		    that->type != OPTION_CMDMODE ||
> +		    !(that->flags & PARSE_OPT_CMDMODE) ||
>  		    that->value != opt->value ||
>  		    that->defval != *(int *)opt->value)
>  			continue;
> @@ -95,6 +95,14 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
>  	if (!(flags & OPT_SHORT) && p->opt && (opt->flags & PARSE_OPT_NOARG))
>  		return error(_("%s takes no value"), optname(opt, flags));
>  
> +	/*
> +	 * Giving the same mode option twice, although unnecessary,
> +	 * is not a grave error, so let it pass.
> +	 */
> +	if ((opt->flags & PARSE_OPT_CMDMODE) &&
> +	    *(int *)opt->value && *(int *)opt->value != opt->defval)
> +		return opt_command_mode_error(opt, all_opts, flags);
> +

... and when there is no error, we fall through and process it as a
regular SET_INT, which makes sense.

> @@ -168,8 +168,8 @@ struct option {
>  #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
>  #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
>  				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
> -#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
> -				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
> +#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
> +				      (h), PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }

OK.

> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> index af82db06ac..2051ce57db 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -121,6 +121,8 @@ int cmd__parse_options(int argc, const char **argv)
>  		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
>  		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
>  		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
> +		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
> +		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
>  		OPT_CALLBACK('L', "length", &integer, "str",
>  			"get length of <str>", length_callback),
>  		OPT_FILENAME('F', "file", &file, "set file to <file>"),
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 9d7c7fdaa2..7f4c15a52b 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -23,6 +23,8 @@ usage: test-tool parse-options <options>
>      -j <n>                get a integer, too
>      -m, --magnitude <n>   get a magnitude
>      --set23               set integer to 23
> +    --mode1               set integer to 1 (cmdmode option)
> +    --mode2               set integer to 2 (cmdmode option)
>      -L, --length <str>    get length of <str>
>      -F, --file <file>     set file to <file>
>  
> @@ -324,6 +326,22 @@ test_expect_success 'OPT_NEGBIT() works' '
>  	test-tool parse-options --expect="boolean: 6" -bb --no-neg-or4
>  '
>  
> +test_expect_success 'OPT_CMDMODE() works' '
> +	test-tool parse-options --expect="integer: 1" --mode1
> +'
> +
> +test_expect_success 'OPT_CMDMODE() detects incompatibility' '
> +	test_must_fail test-tool parse-options --mode1 --mode2 >output 2>output.err &&
> +	test_must_be_empty output &&
> +	grep "incompatible with --mode" output.err
> +'
> +
> +test_expect_success 'OPT_CMDMODE() detects incompatibility with something else' '
> +	test_must_fail test-tool parse-options --set23 --mode2 >output 2>output.err &&
> +	test_must_be_empty output &&
> +	grep "incompatible with something else" output.err
> +'
> +
>  test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
>  	test-tool parse-options --expect="boolean: 6" + + + + + +
>  '

Would the updated test-parse-options.c with these three new tests
work the same way with or without changes to parse-options.[ch]?
That would be a good indication that the change to the code is
"upward compatible".

Thanks.
