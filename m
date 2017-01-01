Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06BEF20441
	for <e@80x24.org>; Sun,  1 Jan 2017 01:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbdAAB0i (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 20:26:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55070 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754862AbdAAB0h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 20:26:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35B995C6C0;
        Sat, 31 Dec 2016 20:26:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fRqEFrAZPmxR
        enooCa5FL6oUe0w=; b=cdotYfiW/3YHVdKbxyVWaetOO4MnDKoHNLOL1Mq+zgNt
        /7to/oexDjZ07m3Wfg4NRGPlDp2LzH2FSCtv0H72XB0mlbrNNzt+eMKjjAeq4IRx
        WPli/v3R3hV5/i76PSg1rckLroM7co1zp5kRkMFR2sStIZEhQpaZ/CXEWdXpX9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QDDZGd
        bUbdEUTTPL6r/B+Jh9aRG+90ln5Il0K2FdQ4LHRrbcl/B403MRNYkuEDK17shJ/Y
        ZHfu6HR4x5K2OmV/M8ezOC7Wqd8AdUmHqifIVhBUHF+5VPCd3wJ1cVvp6r8hrLuk
        zlMR+fVt5gkEBM4sOQJQmG5mLCzUBSwswdyP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E93B5C6BF;
        Sat, 31 Dec 2016 20:26:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86B755C6BE;
        Sat, 31 Dec 2016 20:26:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, l.s.r@web.de
Subject: Re: [PATCHv2] unpack-trees: move checkout state into check_updates
References: <20161229194309.2373-1-sbeller@google.com>
Date:   Sat, 31 Dec 2016 17:26:34 -0800
In-Reply-To: <20161229194309.2373-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 29 Dec 2016 11:43:09 -0800")
Message-ID: <xmqq8tqv6051.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 55BFED38-CFC1-11E6-84B4-E17F7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The checkout state was introduced via 16da134b1f9
> (read-trees: refactor the unpack_trees() part, 2006-07-30). An attempt =
to
> refactor the checkout state was done in b56aa5b268e (unpack-trees: pass
> checkout state explicitly to check_updates(), 2016-09-13), but we can
> go even further.
>
> The `struct checkout state` is not used in unpack_trees apart from
> initializing it, so move it into the function that makes use of it,
> which is `check_updates`.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

I'd add Ren=C3=A9's Reviewed-by: here.

> -static int check_updates(struct unpack_trees_options *o,
> -			 const struct checkout *state)
> +static int check_updates(struct unpack_trees_options *o)
>  {
>  	unsigned cnt =3D 0, total =3D 0;
>  	struct progress *progress =3D NULL;
>  	struct index_state *index =3D &o->result;
> -	int i;
> -	int errs =3D 0;
> +	struct checkout state =3D CHECKOUT_INIT;
> +	int i, errs =3D 0;
> +
> +	state.force =3D 1;
> +	state.quiet =3D 1;
> +	state.refresh_cache =3D 1;
> +	state.istate =3D index;

I think moving heavier and initialized variables earlier and more
lightweight and ephemeral ones like "i" later does make it easier to
follow.  "errs" has the significance and the lifetime similar to
cnt/total, and logically should be higher, though.  It is not a big
enough deal to reroll (but as your futzing of the variable definition
order was not a big enough deal to do in this patch, either, so...).

Queued.  Thanks.
