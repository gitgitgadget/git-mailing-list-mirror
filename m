Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC291F462
	for <e@80x24.org>; Mon, 29 Jul 2019 04:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfG2E51 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 00:57:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65346 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfG2E51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 00:57:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D8ED165C23;
        Mon, 29 Jul 2019 00:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dltvMPO4dF0p
        9cZeXIC0G+jUs5k=; b=xStMkrXENiDyp/egAZ75NSGf/f9wTr7YHRtTv7kVztvK
        FXVjcHn2cy6gWIopUgKV2ADtCkHVI7tZfFlWRhuXWL+Whrix41Z4+tfxHC0sE1vJ
        09yC1xArsoA6mlZrtcqDMvNqZGyrZw9YsHOwleIsa0u8RpKHsDCg122O/YzjKQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WW0cZM
        6jeCPrhTxfqxBwDj0Xn7F3/sZCmhHqTDLNuyAVougP1Q5GgHLVXbLsKIHGPJihkt
        WOAziucksH/Xdc4HFyF27IqNERy0lDv7wq+OEEhOURV4KecjbSDjbhZwpROrkuiD
        39xSofzU7fI8fU2kyyUi7reZXLW1//wj+w1SM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 444C8165C22;
        Mon, 29 Jul 2019 00:57:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7068165C21;
        Mon, 29 Jul 2019 00:57:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
References: <20190728235427.41425-1-carenas@gmail.com>
Date:   Sun, 28 Jul 2019 21:57:19 -0700
In-Reply-To: <20190728235427.41425-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 28 Jul 2019 16:54:27 -0700")
Message-ID: <xmqqimrll9ow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 58B9ED50-B1BD-11E9-962B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> PCRE1 allowed for a compile time flag to disable JIT, but PCRE2 never
> had one, forcing the use of JIT if -P was requested.
>
> After ed0479ce3d (Merge branch 'ab/no-kwset' into next, 2019-07-15)
> the PCRE2 engine will be used more broadly and therefore adding this
> knob will give users a fallback for situations like the one observed
> in OpenBSD with a JIT enabled PCRE2, because of W^X restrictions:
>
>   $ git grep 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -G 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -E 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -F 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'

;-) Yeah, we should have known that security-paranoid distros would
have W^X issues with this series, too.

I am not sure I like a config-only knob like this,
though---shouldn't we have a command line knob to turn jit off
first, and then for those who gets tired of having to type it all
the time add the configuration to flip the default for them?

Other than that, the feature itself makes quite a lot of sense.

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Documentation/git-grep.txt |  4 ++++
>  grep.c                     | 15 +++++++++++++--
>  grep.h                     |  1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index c89fb569e3..ff544bdeec 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -69,6 +69,10 @@ grep.fallbackToNoIndex::
>  	If set to true, fall back to git grep --no-index if git grep
>  	is executed outside of a git repository.  Defaults to false.
> =20
> +pcre.jit::
> +	If set to false, disable JIT when using PCRE.  Defaults to
> +	true.
> +
> =20
>  OPTIONS
>  -------
> diff --git a/grep.c b/grep.c
> index c7c06ae08d..3524d353dd 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -56,6 +56,7 @@ void init_grep_defaults(struct repository *repo)
>  	opt->repo =3D repo;
>  	opt->relative =3D 1;
>  	opt->pathname =3D 1;
> +	opt->pcre_jit =3D 1;
>  	opt->max_depth =3D -1;
>  	opt->pattern_type_option =3D GREP_PATTERN_TYPE_UNSPECIFIED;
>  	color_set(opt->colors[GREP_COLOR_CONTEXT], "");
> @@ -125,6 +126,12 @@ int grep_config(const char *var, const char *value=
, void *cb)
>  		return 0;
>  	}
> =20
> +	if (!strcmp(var, "pcre.jit")) {
> +		int is_bool;
> +		opt->pcre_jit =3D git_config_bool_or_int(var, value, &is_bool);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "color.grep"))
>  		opt->color =3D git_config_colorbool(var, value);
>  	if (!strcmp(var, "color.grep.match")) {
> @@ -163,6 +170,7 @@ void grep_init(struct grep_opt *opt, struct reposit=
ory *repo, const char *prefix
>  	opt->pattern_tail =3D &opt->pattern_list;
>  	opt->header_tail =3D &opt->header_list;
> =20
> +	opt->pcre_jit =3D def->pcre_jit;
>  	opt->only_matching =3D def->only_matching;
>  	opt->color =3D def->color;
>  	opt->extended_regexp_option =3D def->extended_regexp_option;
> @@ -393,7 +401,8 @@ static void compile_pcre1_regexp(struct grep_pat *p=
, const struct grep_opt *opt)
>  		die("%s", error);
> =20
>  #ifdef GIT_PCRE1_USE_JIT
> -	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
> +	if (opt->pcre_jit)
> +		pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
>  #endif
>  }
> =20
> @@ -489,7 +498,9 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>  		compile_regexp_failed(p, (const char *)&errbuf);
>  	}
> =20
> -	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
> +	if (opt->pcre_jit)
> +		pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
> +
>  	if (p->pcre2_jit_on) {
>  		jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>  		if (jitret)
> diff --git a/grep.h b/grep.h
> index c0c71eb4a9..fff152e606 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -151,6 +151,7 @@ struct grep_opt {
>  	int allow_textconv;
>  	int extended;
>  	int use_reflog_filter;
> +	int pcre_jit;
>  	int pcre1;
>  	int pcre2;
>  	int relative;
