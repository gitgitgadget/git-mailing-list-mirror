Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE09B20193
	for <e@80x24.org>; Thu,  4 Aug 2016 17:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933812AbcHDRlr (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 13:41:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933845AbcHDRlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 13:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B969331EBF;
	Thu,  4 Aug 2016 13:41:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rciz30sTAPVpgrfvhQdZnS8Ec68=; b=TozU6L
	9hyVPY+uA/E7kYJ29zFZ/ksQ6xY6haDn9RNNvo2aBxdL/z6dDh7eP//dd+Bnux3d
	lsNnEKUtrTyJg1S5lMbfw4fDGo64JRk8UqrUVS5OpgWbERvv1A2E+TGodYxs40tv
	zoJ3nr1Uf50GlLerARM+1e3Ene7MSiRXnXW3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+G/U0P0znCtbfYXjLVtapZ8+re4Y5dE
	H6IO8eSFvLRGI7Q1dPu3hydCLvpqBCs89DCn0iUl3jH0OOJkkHESu5FuzjnM+EFR
	xTmEkSTSCnQNckJpJiPPDsC6IDP6Eef5bfSow6vb+DzGe7hAteRDztQFnAcWfjm4
	W55KtMgiUMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B16A731EBE;
	Thu,  4 Aug 2016 13:41:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 189E931EBA;
	Thu,  4 Aug 2016 13:41:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
	<57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
Date:	Thu, 04 Aug 2016 10:41:41 -0700
In-Reply-To: <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 4 Aug 2016 18:07:08 +0200
	(CEST)")
Message-ID: <xmqqoa584eju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B59958C4-5A6A-11E6-A9E3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> With GCC 6, the strdup() function is declared with the "nonnull"
> attribute, stating that it is not allowed to pass a NULL value as
> parameter.
>
> In nedmalloc()'s reimplementation of strdup(), Postel's Law is heeded
> and NULL parameters are handled gracefully. GCC 6 complains about that
> now because it thinks that NULL cannot be passed to strdup() anyway.
>
> Let's just shut up GCC >= 6 in that case and go on with our lives.
>
> See https://gcc.gnu.org/gcc-6/porting_to.html for details.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/nedmalloc/nedmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> index 677d1b2..3f28c0b 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -956,6 +956,9 @@ void **nedpindependent_comalloc(nedpool *p, size_t elems, size_t *sizes, void **
>  char *strdup(const char *s1)
>  {
>  	char *s2 = 0;
> +#if __GNUC__ >= 6
> +#pragma GCC diagnostic ignored "-Wnonnull-compare"
> +#endif
>  	if (s1) {
>  		size_t len = strlen(s1) + 1;
>  		s2 = malloc(len);

Is it a common convention to place "#pragma GCC diagnostic"
immediately before the statement you want to affect, and have the
same pragma in effect until the end of the compilation unit?

I know this function is at the end and it is not worth doing
push/ignored/pop dance, and I assumed that it is the reason why we
see a single "ignore from here on", which is much simpler, but it is
somewhat distracting.  It made me wonder if it makes it easier to
read and less distracting to have these three lines in front of and
outside the function definition, while thinking that it would have a
documentation value to have it immediately before the statement you
want to affect.  Help me convince myself that this is the best
place.

Thanks.

