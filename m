Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EDAC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 20:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbiA0UaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:30:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58836 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiA0UaN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 15:30:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BFDE107066;
        Thu, 27 Jan 2022 15:30:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yZEEc7ddQuXm
        G+KpE73cVMmpSMhLb8kbGgQpKNCVDFE=; b=TZ4VqIBO1/kaT377m2gUGAZvnTwz
        uu6hDnhoy1DF/LGCm0/V+N1zgo2AUxb1jldPZVl2toVHr97R0/fC5QxsbkhQsNlM
        EMz7yQ4sdpNL5czLMWlJi3rnU12Uhf7SIhbu669Ukdy2sWBkW/YtMXsZlf/Nax4W
        N7wO/DNGvDKHq34=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F8E5107065;
        Thu, 27 Jan 2022 15:30:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D4BD107064;
        Thu, 27 Jan 2022 15:30:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v9 9/9] grep: simplify config parsing and option parsing
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
        <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
        <patch-v9-9.9-445467e87f7-20220127T115058Z-avarab@gmail.com>
Date:   Thu, 27 Jan 2022 12:30:09 -0800
In-Reply-To: <patch-v9-9.9-445467e87f7-20220127T115058Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 27 Jan
 2022 12:56:31
        +0100")
Message-ID: <xmqq35l82a7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED20AFB6-7FAF-11EC-9000-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In a preceding commit we changed grep_config() to be called after
> grep_init(), which means that much of the complexity here can go
> away.
>
> As before both "grep.patternType" and "grep.extendedRegexp" are
> last-one-wins variable, with "grep.extendedRegexp" yielding to
> "grep.patternType", except when "grep.patternType=3Ddefault".
>
> Note that this applies as we parse the config, i.e. a sequence of:
>
>     -c grep.patternType=3Dperl
>     -c grep.extendedRegexp=3Dtrue \
>     -c grep.patternType=3Ddefault
>
> should select ERE due to "grep.extendedRegexp=3Dtrue and
> grep.patternType=3Ddefault".

Correct.  The same reasoning would apply to:

	-c grep.extendedRegexp=3Dtrue \=20
	-c grep.patternType=3Dperl \
	-c grep.patternType=3Ddefault

which should also select ERE due to "grep.extendedRegexp=3Dtrue and
grep.patternType=3Ddefault".  As we re-check grep.extendedRegexp every
time grep.patternType changes, and we keep extendedRegexp as a
separate copy without getting lost like earlier rounds of this
series, this should work.

Would this also work?

	-c grep.extendedRegexp=3Dfalse \
	-c grep.patternType=3Ddefault \
	-c grep.extendedRegexp=3Dtrue

We do keep extendedRegexp, but as soon as we read .patternType that
is default, adjust_pattern_type() overwrites the pattern_type_option
member with BRE, and the fact that .patternType was specified as "do
whatever the .extendedRegexp says" is lost when we read the third
one.

So, no, I am not sure this is correct.

> diff --git a/grep.c b/grep.c
> index 60228a95a4f..f07a21ff1aa 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -48,6 +48,12 @@ static int parse_pattern_type_arg(const char *opt, c=
onst char *arg)
> =20
>  define_list_config_array_extra(color_grep_slots, {"match"});
> =20
> +static void adjust_pattern_type(enum grep_pattern_type *pto, const int=
 ero)
> +{
> +	if (*pto =3D=3D GREP_PATTERN_TYPE_UNSPECIFIED)
> +		*pto =3D ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
> +}

OK.  Earlier rounds just replaced the UNSPECIFIED with hardcoded value "0=
",
which was more or less pointless.  I think this is easier to follow.

But as I said, "committing" ERE vs BRE in this manner is probably
way too early and produce an incorrect result.  Instead ...

> @@ -490,9 +446,9 @@ static void compile_regexp(struct grep_pat *p, stru=
ct grep_opt *opt)

... this is the right place to do the "see if pattern_type_option is
'default' and if so use 'extended_regexp_option' to commit to either
BRE or ERE".

I guess that is what I have been repeating during the review of the
past few rounds.  Am I overlooking some other cases where that
simpler-to-explain approach does not work?

>  	p->word_regexp =3D opt->word_regexp;
>  	p->ignore_case =3D opt->ignore_case;
> -	p->fixed =3D opt->fixed;
> +	p->fixed =3D opt->pattern_type_option =3D=3D GREP_PATTERN_TYPE_FIXED;
> =20
> -	if (!opt->pcre2 &&
> +	if (opt->pattern_type_option !=3D GREP_PATTERN_TYPE_PCRE &&
>  	    memchr(p->pattern, 0, p->patternlen))
>  		die(_("given pattern contains NULL byte (via -f <file>). This is onl=
y supported with -P under PCRE v2"));
> =20
> @@ -544,14 +500,14 @@ static void compile_regexp(struct grep_pat *p, st=
ruct grep_opt *opt)
>  		return;
>  	}
> =20
> -	if (opt->pcre2) {
> +	if (opt->pattern_type_option =3D=3D GREP_PATTERN_TYPE_PCRE) {
>  		compile_pcre2_pattern(p, opt);
>  		return;
>  	}
> =20
>  	if (p->ignore_case)
>  		regflags |=3D REG_ICASE;
> -	if (opt->extended_regexp_option)
> +	if (opt->pattern_type_option =3D=3D GREP_PATTERN_TYPE_ERE)
>  		regflags |=3D REG_EXTENDED;
>  	err =3D regcomp(&p->regexp, p->pattern, regflags);
>  	if (err) {
> diff --git a/grep.h b/grep.h
> index 89a2ce51130..f89324e9aa9 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -143,7 +143,6 @@ struct grep_opt {
>  	int unmatch_name_only;
>  	int count;
>  	int word_regexp;
> -	int fixed;
>  	int all_match;
>  	int no_body_match;
>  	int body_hit;
> @@ -154,7 +153,6 @@ struct grep_opt {
>  	int allow_textconv;
>  	int extended;
>  	int use_reflog_filter;
> -	int pcre2;
>  	int relative;
>  	int pathname;
>  	int null_following_name;
> @@ -183,6 +181,7 @@ struct grep_opt {
>  	.relative =3D 1, \
>  	.pathname =3D 1, \
>  	.max_depth =3D -1, \
> +	.extended_regexp_option =3D -1, \

I do not think you meant this.  Uninitialized grep.extendedRegexp
defaults to 0 (BRE), I think.

>  	.pattern_type_option =3D GREP_PATTERN_TYPE_UNSPECIFIED, \
>  	.colors =3D { \
>  		[GREP_COLOR_CONTEXT] =3D "", \
> @@ -202,7 +201,6 @@ struct grep_opt {
> =20
>  int grep_config(const char *var, const char *value, void *);
>  void grep_init(struct grep_opt *, struct repository *repo);
> -void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt =
*opt);
> =20
>  void append_grep_pat(struct grep_opt *opt, const char *pat, size_t pat=
len, const char *origin, int no, enum grep_pat_token t);
>  void append_grep_pattern(struct grep_opt *opt, const char *pat, const =
char *origin, int no, enum grep_pat_token t);
> diff --git a/revision.c b/revision.c
> index d6e0e2b23b5..dd301e30147 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2860,8 +2860,6 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
> =20
>  	diff_setup_done(&revs->diffopt);
> =20
> -	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
> -				 &revs->grep_filter);
>  	if (!is_encoding_utf8(get_log_output_encoding()))
>  		revs->grep_filter.ignore_locale =3D 1;
>  	compile_grep_patterns(&revs->grep_filter);
