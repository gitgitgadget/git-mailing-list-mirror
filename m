Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52754C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 15:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiJKPvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJKPup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 11:50:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93ACE0C7
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 08:46:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD8DB14AEDC;
        Tue, 11 Oct 2022 11:46:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q54qhFv6W2OD
        un1zxlKEthKyxJpUAL8UVuXpXIvgegs=; b=tMhTQCjBJUQ11Pt8mlNQqaQIvB+j
        t+2o6qouB10qg/hIjy4TmKtBO15rj07vGHgVVixitc+6zgY9U9frONrv2cTmaoKa
        317FAZr2R6wQLid1KKUQL9r+xpLmKwn23ZgNXTM5gULcA78UeBmoGx5ysDQgAEZo
        GXXcfdQy3abUCww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B333C14AEDB;
        Tue, 11 Oct 2022 11:46:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C41B14AED9;
        Tue, 11 Oct 2022 11:46:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, orygaw <orygaw@protonmail.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] grep.c: remove "extended" in favor of
 "pattern_expression", fix segfault
References: <patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com>
        <patch-v2-1.1-6ad7627706f-20221011T094715Z-avarab@gmail.com>
Date:   Tue, 11 Oct 2022 08:46:35 -0700
In-Reply-To: <patch-v2-1.1-6ad7627706f-20221011T094715Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 11 Oct
 2022 11:48:45
        +0200")
Message-ID: <xmqqczayweg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3D772F0-497B-11ED-BB18-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  grep.c         | 15 +++++++--------
>  grep.h         |  1 -
>  t/t4202-log.sh |  9 +++++++++
>  3 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 52a894c9890..06eed694936 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -708,6 +708,7 @@ void compile_grep_patterns(struct grep_opt *opt)
>  {
>  	struct grep_pat *p;
>  	struct grep_expr *header_expr =3D prep_header_patterns(opt);
> +	int extended =3D 0;
> =20
>  	for (p =3D opt->pattern_list; p; p =3D p->next) {
>  		switch (p->token) {
> @@ -717,14 +718,14 @@ void compile_grep_patterns(struct grep_opt *opt)
>  			compile_regexp(p, opt);
>  			break;
>  		default:
> -			opt->extended =3D 1;
> +			extended =3D 1;
>  			break;
>  		}
>  	}
> =20
>  	if (opt->all_match || opt->no_body_match || header_expr)
> -		opt->extended =3D 1;
> -	else if (!opt->extended)
> +		extended =3D 1;
> +	else if (!extended)
>  		return;

Nice. I like this change to make "!!opt->pattern_expression" the
authoritative source of truth for opt->extended by getting rid of
the latter.  This function did need to have a handy way to tell "do
we need to populate pattern_expression?" while going over the list
and also use of some features forced us to do so no matter how
simple the patterns on the list are, but after doing so and
populating the pattern_expression, there was no reason to keep it
around by having it as a member in the opt structure.

> @@ -790,7 +791,7 @@ void free_grep_patterns(struct grep_opt *opt)
>  		free(p);
>  	}
> =20
> -	if (!opt->extended)
> +	if (!opt->pattern_expression)
>  		return;
>  	free_pattern_expr(opt->pattern_expression);
>  }
> @@ -971,8 +972,6 @@ static int match_expr_eval(struct grep_opt *opt, st=
ruct grep_expr *x,
>  {
>  	int h =3D 0;
> =20
> -	if (!x)
> -		die("Not a valid grep expression");
>  	switch (x->node) {
>  	case GREP_NODE_TRUE:
>  		h =3D 1;
> @@ -1052,7 +1051,7 @@ static int match_line(struct grep_opt *opt,
>  	struct grep_pat *p;
>  	int hit =3D 0;
> =20
> -	if (opt->extended)
> +	if (opt->pattern_expression)
>  		return match_expr(opt, bol, eol, ctx, col, icol,
>  				  collect_hits);
> =20
> @@ -1370,7 +1369,7 @@ static int should_lookahead(struct grep_opt *opt)
>  {
>  	struct grep_pat *p;
> =20
> -	if (opt->extended)
> +	if (opt->pattern_expression)
>  		return 0; /* punt for too complex stuff */
>  	if (opt->invert)
>  		return 0;

And the necessary change for users is surprisingly small.

> diff --git a/grep.h b/grep.h
> index bdcadce61b8..6075f997e68 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -151,7 +151,6 @@ struct grep_opt {
>  #define GREP_BINARY_TEXT	2
>  	int binary;
>  	int allow_textconv;
> -	int extended;
>  	int use_reflog_filter;
>  	int relative;
>  	int pathname;
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index cc15cb4ff62..2ce2b41174d 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -249,6 +249,15 @@ test_expect_success 'log --grep' '
>  	test_cmp expect actual
>  '
> =20
> +for noop_opt in --invert-grep --all-match
> +do
> +	test_expect_success "log $noop_opt without --grep is a NOOP" '
> +		git log >expect &&
> +		git log $noop_opt >actual &&
> +		test_cmp expect actual
> +	'
> +done

OK.

Thanks, will queue.
