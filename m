Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A2E1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 22:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfHGW2w (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 18:28:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGW2w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 18:28:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87AD98EB9E;
        Wed,  7 Aug 2019 18:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W4ooF0mhNpqr
        tw8tWCb9K6qr1wM=; b=m5Mj2QN0QcPKDfCWKTYBxm6SeYTxLCEccmWJoi5Tyewz
        wGl28OVXQCP7PAAK/NTcMfYdtyDWyzZwVzpWlxOBur5B712Da+UKVtQjpXBvV4Li
        kJgL+txOdhcp5Y9WAEHOKx7TE8Z2ct90Fpn0wOgvXgbj4/QX/7QfIwam4Gp7Ekg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EO9XzB
        jbptChLeIWYV8fmEKUbtZ8mgPEWKbPGAMfWb32Jj1Z4xr2ENwCrgvYoklVeBNybC
        aTrR17jUGZBfl/6s9Hw/EWdSbro0VfaD82duLttUC3uj2eMVRZ82WlKoyVesdNls
        5xHXrZrI4q9ML5sh4C3SsbNE2fLKdWXo9yihs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EAEF8EB9D;
        Wed,  7 Aug 2019 18:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A9DAB8EB9C;
        Wed,  7 Aug 2019 18:28:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v4 2/3] grep: make PCRE2 aware of custom allocator
References: <20190806163658.66932-1-carenas@gmail.com>
        <20190807213945.10464-1-carenas@gmail.com>
        <20190807213945.10464-3-carenas@gmail.com>
Date:   Wed, 07 Aug 2019 15:28:43 -0700
In-Reply-To: <20190807213945.10464-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 7 Aug 2019 14:39:44 -0700")
Message-ID: <xmqq4l2shap0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B80A5B76-B962-11E9-B4BB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

As we already have such an ifdef block here...

> +#ifdef USE_LIBPCRE2
> +static pcre2_general_context *pcre2_global_context;
> +
> +#ifdef USE_NED_ALLOCATOR
> +static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_d=
ata)
> +{
> +	return xmalloc(size); /* will use nedalloc underneath */
> +}
> +
> +static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
> +{
> +	return free(pointer);
> +}
> +#endif
> +#endif

... perhaps an ugly ifdef block like this one ...

> +static struct grep_pat *create_grep_pat(struct grep_opt *opt,
> +					const char *pat, size_t patlen,
>  					const char *origin, int no,
>  					enum grep_pat_token t,
>  					enum grep_header_field field)
>  {
>  	struct grep_pat *p =3D xcalloc(1, sizeof(*p));
> +
> +#if defined(USE_LIBPCRE2) && defined(USE_NED_ALLOCATOR)
> +	/* BUG: this is technically not needed if we will do UTF matching
> +	 *      but UTF locale detection is currently broken  */
> +	/* SMELL: opt shouldn't be needed at this level but it is used
> +	 *        here to keep the way we were detecting the need for
> +	 *        the chartable consistent and until it can be refactored
> +	 *        properly.  the NULL check is needed as a workaround
> +	 *        for segfaulting in t7810.102 and should also go */
> +	/* TODO: has_non_ascii doesn't support NUL in pattern */
> +	if (!pcre2_global_context && opt && opt->ignore_case &&
> +		has_non_ascii(pat))
> +		pcre2_global_context =3D pcre2_general_context_create(
> +					pcre2_malloc, pcre2_free, NULL);
> +#endif
> +

... can be abstracted away by *not* having the #if/#endif here and
instead have a line that looks like this:

	setup_pcre2_as_needed(opt, pat);

which implementation can be prepared near the top, close to where
pcre2_malloc/free are defined (or not) above, i.e.

	#if defined(USE_LIBPCRE2) && defined(USE_NED_ALLOCATOR)
	static void setup_pcre2_as_needed(struct grep_opt *opt,	const char *pat)
	{
		... the above one ...
	}
	#else
	#define setup_pcre2_as_needed(ignore1, ignore2) /* nothing */
	#endif

The conditional code in grep_destroy() can be eliminated in a
similar fashion, i.e.

	void grep_destroy(void)
	{
		cleanup_pcre2_as_needed();
	}

with

	#ifdef USE_LIBPCRE2
	static void cleanup_pcre2_as_needed(void)
	{
		pcre2_general_context_free(pcre2_global_context);
	}
	#else
	#define cleanup_pcre2_as_needed() /* nothing */
	#endif

near the top (the beneral idea is to "call" a helper function whose
name describes what the call is for in a more general terms, and let
only the implementation details be hidden inside ifdef blocks).

Also,=20

	/*=20
	 * our multi-line comments are supposed to be formatted like
	 * this, with opening and closing slash-asterisk and asterisk-slash
	 * on their own lines.
	 */

