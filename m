Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15CA31F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbfHBQTb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:19:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51766 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732651AbfHBQTb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:19:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E89757EBAA;
        Fri,  2 Aug 2019 12:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CaT4H0EkITDa
        yaweRmrAj5qmg4E=; b=CjR1gOASs03MI/4IQheAzgFjcRFB+BXcwyuc16LQXGn1
        +X4IOk9Cm1Dc45/ZQJoJSLahMwnMamCeaTKRuLakFNkHqddjV4Y9mN1mxL0CPgrR
        bYD0JQGW6bz0+6a7xAT3q+jMIYSFj+f5aZ7uMNSjv4+wqdW6AM+YH1diR3kZx9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bgvuMe
        Oy5jk/BacAd/qa2QwS7e5p96Znsk10KuwYbOkO3RFuf4xp0QZe8QkurWB48VxqMM
        84SrKysngfstLrZkcT6DwEjCwSCJnva2tsUf3JMaBJCKTDPk1Q+Rg2+tNB5Wj6hR
        QIpyQg4JDxkYTmjdSIGpYY2SAqeajUrnQMkNc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0CF87EBA9;
        Fri,  2 Aug 2019 12:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05B4E7EBA8;
        Fri,  2 Aug 2019 12:19:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, l.s.r@web.de
Subject: Re: [PATCH v2] grep: avoid leak of chartables in PCRE2
References: <20190727202759.22310-1-carenas@gmail.com>
        <20190801170946.81221-1-carenas@gmail.com>
Date:   Fri, 02 Aug 2019 09:19:20 -0700
In-Reply-To: <20190801170946.81221-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 1 Aug 2019 10:09:46 -0700")
Message-ID: <xmqqwofvleuv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 49FDBDA0-B541-11E9-91FE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 94da9193a6 ("grep: add support for PCRE v2", 2017-06-01) introduced
> a small memory leak visible with valgrind in t7813.
>
> Complete the creation of a PCRE2 specific variable that was missing fro=
m
> the original change and free the generated table just like it is done
> for PCRE1.
>
> The table cleanup use free as there is no global context defined when
> it was created (pcre2_maketables is passed a NULL pointer) but if that
> gets ever changed will need to be updated in tandem.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> V2:
> * better document why free is used as suggested by Ren=C3=A9
> * avoid reusing PCRE1 variable for easy of maintenance (per =C3=86var)

Thanks; will queue.

>
>  grep.c | 7 ++++---
>  grep.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index f7c3a5803e..fbd3f3757c 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -488,7 +488,6 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>  	PCRE2_UCHAR errbuf[256];
>  	PCRE2_SIZE erroffset;
>  	int options =3D PCRE2_MULTILINE;
> -	const uint8_t *character_tables =3D NULL;
>  	int jitret;
>  	int patinforet;
>  	size_t jitsizearg;
> @@ -499,9 +498,10 @@ static void compile_pcre2_pattern(struct grep_pat =
*p, const struct grep_opt *opt
> =20
>  	if (opt->ignore_case) {
>  		if (has_non_ascii(p->pattern)) {
> -			character_tables =3D pcre2_maketables(NULL);
> +			p->pcre2_tables =3D pcre2_maketables(NULL);
>  			p->pcre2_compile_context =3D pcre2_compile_context_create(NULL);
> -			pcre2_set_character_tables(p->pcre2_compile_context, character_tabl=
es);
> +			pcre2_set_character_tables(p->pcre2_compile_context,
> +							p->pcre2_tables);
>  		}
>  		options |=3D PCRE2_CASELESS;
>  	}
> @@ -605,6 +605,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
>  	pcre2_match_data_free(p->pcre2_match_data);
>  	pcre2_jit_stack_free(p->pcre2_jit_stack);
>  	pcre2_match_context_free(p->pcre2_match_context);
> +	free((void *)p->pcre2_tables);
>  }
>  #else /* !USE_LIBPCRE2 */
>  static void compile_pcre2_pattern(struct grep_pat *p, const struct gre=
p_opt *opt)
> diff --git a/grep.h b/grep.h
> index 1875880f37..26d21a3433 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -96,6 +96,7 @@ struct grep_pat {
>  	pcre2_compile_context *pcre2_compile_context;
>  	pcre2_match_context *pcre2_match_context;
>  	pcre2_jit_stack *pcre2_jit_stack;
> +	const uint8_t *pcre2_tables;
>  	uint32_t pcre2_jit_on;
>  	kwset_t kws;
>  	unsigned fixed:1;
