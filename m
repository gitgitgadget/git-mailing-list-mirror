Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FAAC433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 06:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhL0GGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 01:06:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64733 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhL0GGw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 01:06:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CB2916311D;
        Mon, 27 Dec 2021 01:06:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=59S7tjaXviQV
        s7XPoNATQLSiQ49glYt+c/+UwmdqA6Y=; b=NpNnbi+zxz3aZvRNETbFubXjxEwR
        NA3bEM34vtcMp1Qn/ADHp/XZ4GtyBxjkn8roIWBUjI73Li5Hlbfi86LVdEpKMgXV
        //2eh0J1Q5FogoCWy3yoKN8V3Zi6Gb+dOM3WSm8EYHBfFPnbKAd1mU324zNgJN5X
        agImegh6b0WOr8o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 759AA16311C;
        Mon, 27 Dec 2021 01:06:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D361A16311B;
        Mon, 27 Dec 2021 01:06:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v6 7/7] grep: simplify config parsing and option parsing
References: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
        <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
        <patch-v6-7.7-88dfd40bf9e-20211226T223035Z-avarab@gmail.com>
Date:   Sun, 26 Dec 2021 22:06:47 -0800
In-Reply-To: <patch-v6-7.7-88dfd40bf9e-20211226T223035Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 26 Dec
 2021 23:37:19
        +0100")
Message-ID: <xmqqpmpid1jc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D7ED4FE-66DB-11EC-82B3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -143,7 +142,6 @@ struct grep_opt {
>  	int unmatch_name_only;
>  	int count;
>  	int word_regexp;
> -	int fixed;
>  	int all_match;
>  #define GREP_BINARY_DEFAULT	0
>  #define GREP_BINARY_NOMATCH	1
> @@ -152,7 +150,6 @@ struct grep_opt {
>  	int allow_textconv;
>  	int extended;
>  	int use_reflog_filter;
> -	int pcre2;
>  	int relative;
>  	int pathname;
>  	int null_following_name;
> @@ -162,7 +159,7 @@ struct grep_opt {
>  	int funcname;
>  	int funcbody;
>  	int extended_regexp_option;
> -	int pattern_type_option;
> +	enum grep_pattern_type pattern_type_option;
>  	int ignore_locale;
>  	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
>  	unsigned pre_context;
> @@ -181,7 +178,6 @@ struct grep_opt {
>  	.relative =3D 1, \
>  	.pathname =3D 1, \
>  	.max_depth =3D -1, \
> -	.pattern_type_option =3D GREP_PATTERN_TYPE_UNSPECIFIED, \
>  	.colors =3D { \
>  		[GREP_COLOR_CONTEXT] =3D "", \
>  		[GREP_COLOR_FILENAME] =3D "", \

I very much like the lossage of redundant fixed and pcre2 members.

As I kept telling you, we still need a separate bit to keep track of
the last value of grep.extendedRegexp, but the primary mechanism to
determine what pattern type to use should be a single enum that is
pattern_type.  When we see "fixed", "pcre", "-G", etc. from
grep.patternType config or from command line, we can stuff their
enum values in pattern_type member of this struct, and when we see
"default", we need to leave "default" in pattern_type member until
we see the last definition of grep.extendedRegexp, at which time
we can turn it into either "basic" or "extended".

So having only two members is absolutely the right thing to do.

But this part convinces me that whatever this patch does, it will
not possible be capable of doing the right thing.  You cannot
implement "we have to remember that the last grep.patternType we saw
was DEFAULT and in that case we cannot decide the real pattern type
until we see the last definition of grep.extendedRegexp, which may
be well after we saw the last grep.patternType definition" without a
value in this enum to express that the last value we saw was DEFAULT.

>  enum grep_pattern_type {
> -	GREP_PATTERN_TYPE_UNSPECIFIED =3D 0,
> -	GREP_PATTERN_TYPE_BRE,
> +	GREP_PATTERN_TYPE_BRE =3D 0,
>  	GREP_PATTERN_TYPE_ERE,
>  	GREP_PATTERN_TYPE_FIXED,
>  	GREP_PATTERN_TYPE_PCRE

> @@ -982,7 +981,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
>  	argc =3D parse_options(argc, argv, prefix, options, grep_usage,
>  			     PARSE_OPT_KEEP_DASHDASH |
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
> -	grep_commit_pattern_type(pattern_type_arg, &opt);

In other words, this lossage is likely wrong.  Let's keep reading
and see how well the config reader in this patch does.=20

> @@ -61,11 +59,25 @@ int grep_config(const char *var, const char *value,=
 void *cb)
>  		return -1;
> =20
>  	if (!strcmp(var, "grep.extendedregexp")) {
> +		if (opt->extended_regexp_option =3D=3D -1)
> +			return 0;
>  		opt->extended_regexp_option =3D git_config_bool(var, value);
> +		if (opt->extended_regexp_option)
> +			opt->pattern_type_option =3D GREP_PATTERN_TYPE_ERE;
> +		else
> +			opt->pattern_type_option =3D GREP_PATTERN_TYPE_BRE;
> +		return 0;
> +	}
> +	if (!strcmp(var, "grep.patterntype") &&
> +	    !strcmp(value, "default")) {
> +		opt->pattern_type_option =3D opt->extended_regexp_option =3D=3D 1
> +			? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
>  		return 0;
>  	}
> =20
>  	if (!strcmp(var, "grep.patterntype")) {
> +		opt->extended_regexp_option =3D -1; /* ignore */
>  		opt->pattern_type_option =3D parse_pattern_type_arg(var, value);
>  		return 0;
>  	}

The above does not look correct at all.

What happens when the configuration parser sees these configuration
variables in this sequence:

 - grep.patternType set to say "pcre" (or anything not "default").
 - grep.extendedRegexp set to "true".
 - grep.patternType set to "default".

After these three variable definitions with the usual "last one
wins" (for each variable independently), the last value for the
grep.patternType variable is "default", and the last value for
the grep.extendedRegexp variable is "true".  The user wants to use
the ERE patterns.

The way the above code would work on this three variable definition
sequence, as far as I read it, would however not give us the desired
behaviour.  First we drop extended_regexp_option member to -1 while
setting PCRE to attern_type_option member, and then grep.extendedRegexp
is totally ignored, and then we see patterntype set to default and
notice extended_regexp_option is *NOT* 1 (because you ignored it and
left it to -1), and end up using BRE, no?

I agree 100% with the direction that .fixed and .pcre2 members that
were added over time to the struct are redundant and it is a very
good idea to get rid of them.  But we need to keep track of two
configuration variables separately to allow them the "last one wins"
semantics independently, and for that, you cannot lose the "default"
value from the enum.  It is impossible not to store the fact that
"default" was the last value so far we saw for grep.patternType
because you do not know, at the point of seeing "default", what the
final value for grep.extendedRegexp will be.  If you want to correctly
implement the interaction between two variables without regression,
that is.
