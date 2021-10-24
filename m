Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC15C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 04:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43DB601FC
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 04:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhJXE7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 00:59:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53097 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJXE7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 00:59:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0161163F67;
        Sun, 24 Oct 2021 00:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M41Cp/ViwnW+MvAV5OJlgEHccUOUwHp8szbh40
        7CpGc=; b=DQ94yVNoOor/P9Y2iWk8WIk1EZppUHQttKS8rdPHh+It/zaLkXPB1y
        iAt2rElW1+BkNVTzbTLIJs763fLNGGVStX685K1eAnZ6Xe3BK125WEf9NoxA4g7o
        nFcPUBVcMnl3B5D7BtPPyoms+aK0dPnRiZyFBZUeq/2Eo0LfnAI/g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C913A163F66;
        Sun, 24 Oct 2021 00:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35E86163F5B;
        Sun, 24 Oct 2021 00:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/3] pretty: add tag option to %(describe)
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
        <20211024014256.3569322-3-eschwartz@archlinux.org>
Date:   Sat, 23 Oct 2021 21:57:01 -0700
In-Reply-To: <20211024014256.3569322-3-eschwartz@archlinux.org> (Eli
        Schwartz's message of "Sat, 23 Oct 2021 21:42:55 -0400")
Message-ID: <xmqq5ytn6mw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D39FE08A-3486-11EC-BC37-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Schwartz <eschwartz@archlinux.org> writes:

> The %(describe) placeholder by default, like `git describe`, only
> supports annotated tags. However, some people do use lightweight tags
> for releases, and would like to describe those anyway. The command line
> tool has an option to support this.
>
> Teach the placeholder to support this as well.
>
> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
> ---
>  Documentation/pretty-formats.txt | 11 ++++++-----
>  pretty.c                         | 23 +++++++++++++++++++----
>  t/t4205-log-pretty-formats.sh    |  8 ++++++++
>  3 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index ef6bd420ae..14107ac191 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -220,6 +220,7 @@ The placeholders are:
>  			  inconsistent when tags are added or removed at
>  			  the same time.
>  +
> +** 'tags[=<BOOL>]': Also consider lightweight tags.
>  ** 'match=<pattern>': Only consider tags matching the given
>     `glob(7)` pattern, excluding the "refs/tags/" prefix.
>  ** 'exclude=<pattern>': Do not consider tags matching the given

What is the guiding principle used in this patch to decide where the
new entry should go?  

The existing 'match' and 'exclude' are the opposites to each other,
and it makes sense to keep them together, and between them, 'match'
is the positive variant while 'exclude' is the negative one, so the
current order makes sense.  I wonder why the new "also consider"
should come before them, instead of after.

I am not saying you should change the order, and I would be most
unhappy if you did so without explanation in an updated patch.
Rather, I would like to hear the reasoning behind the decision,
preferrably in the proposed log message.

> @@ -273,11 +274,6 @@ endif::git-rev-list[]
>  			  If any option is provided multiple times the
>  			  last occurrence wins.
>  +
> -The boolean options accept an optional value `[=<BOOL>]`. The values
> -`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
> -sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
> -option is given with no value, it's enabled.
> -+
>  ** 'key=<K>': only show trailers with specified key. Matching is done
>     case-insensitively and trailing colon is optional. If option is
>     given multiple times trailer lines matching any of the keys are
> @@ -313,6 +309,11 @@ insert an empty string unless we are traversing reflog entries (e.g., by
>  decoration format if `--decorate` was not already provided on the command
>  line.
>  
> +The boolean options accept an optional value `[=<BOOL>]`. The values
> +`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
> +sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
> +option is given with no value, it's enabled.
> +

This paragraph used to be inside the description of %(trailers:...),
but that was only because %(trailers) was the only one that took a
boolean value for its options, and not because it was the only one
that had special treatment for its boolean options.  Because the
existing rule for an option that takes a boolean value equally
applies to the %(describe:...), and more importantly, because we
expect that any other pretty-format placeholder that would acquire
an option with boolean value would follow the same rule, it makes
sense to move it here, together with other rules like %+ and %- that
apply to any placeholders.

Makes sense.  I very much appreciate this extra attention to the
detail.


> diff --git a/pretty.c b/pretty.c
> index 9db2c65538..3a41bedf1a 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1216,28 +1216,43 @@ int format_set_trailers_options(struct process_trailer_options *opts,
>  
>  static size_t parse_describe_args(const char *start, struct strvec *args)
>  {
> +	const char *options[] = { "tags" };
>  	const char *option_arguments[] = { "match", "exclude" };
>  	const char *arg = start;
>  
>  	for (;;) {
>  		const char *matched = NULL;
> -		const char *argval;
> +		const char *argval = NULL;
>  		size_t arglen = 0;
> +		int optval = 0;
>  		int i;
>  
>  		for (i = 0; i < ARRAY_SIZE(option_arguments); i++) {
>  			if (match_placeholder_arg_value(arg, option_arguments[i], &arg,
>  							&argval, &arglen)) {
>  				matched = option_arguments[i];
> +				if (!arglen)
> +					return 0;
>  				break;
>  			}
>  		}
> +		if (!matched)
> +			for (i = 0; i < ARRAY_SIZE(options); i++) {
> +				if (match_placeholder_bool_arg(arg, options[i], &arg,
> +								&optval)) {
> +					matched = options[i];
> +					break;
> +				}
> +			}
>  		if (!matched)
>  			break;
>  

I find this new structure of the code somewhat dubious.  Shouldn't
we be rather starting with an array of struct that describes the
token to match and how the token should be handled?  Something like

    struct {
	const char *name;
	enum { OPT_STRING, OPT_BOOL } type;
    } option[] = {
	{ "exclude", OPT_STRING },
        { "match", OPT_STRING },
	{ "tags", OPT_BOOL },
    };

    for (;;) {
	int i;
	int found = 0;
	...
        for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
            switch (option.type) {
            case OPT_STRING:
                if (match_placeholder_arg_value(...)) {
                    strvec_pushf(args, "--%s=%.*s", ...);
		    found = 1;
		}
                break;
            case OPT_BOOL:
                if (match_placeholder_bool_arg(...)) {
		    found = 1;
		    if (optval)
			strvec_pushf(args, "--%s", option.name);
		    else
			strvec_pushf(args, "--no-%s", option.name);
		}
		break;
	    }
	}
    }

And instead of the option -> option_arguments rename, the 1/3 of the
series can be to introduce the above structure, without introducing
OPT_BOOL and "tags" element to the option[] array.

> -		if (!arglen)
> -			return 0;
> -		strvec_pushf(args, "--%s=%.*s", matched, (int)arglen, argval);
> +
> +		if (argval) {
> +			strvec_pushf(args, "--%s=%.*s", matched, (int)arglen, argval);
> +		} else if (optval) {
> +			strvec_pushf(args, "--%s", matched);
> +		}
>  	}
>  	return arg - start;
>  }
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 5865daa8f8..d4acf8882f 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -1002,4 +1002,12 @@ test_expect_success '%(describe:exclude=...) vs git describe --exclude ...' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '%(describe:tags) vs git describe --tags' '
> +	test_when_finished "git tag -d tagname" &&
> +	git tag tagname &&
> +	git describe --tags >expect &&
> +	git log -1 --format="%(describe:tags)" >actual &&
> +	test_cmp expect actual
> +'

Nice.

I like how the end-user visible part of this addition is designed to
look very much.  With a cleaned up implementation it would be great.

Thanks.

