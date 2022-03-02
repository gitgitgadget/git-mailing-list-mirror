Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2BEC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbiCBUiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiCBUiy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:38:54 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BDD2C122
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:38:10 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2EBF17AA35;
        Wed,  2 Mar 2022 15:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SAzCrdx/lfQH
        htjJfuQshSFUQB/2IIL/xT+MledViqk=; b=GR3pwCO8zqjmBv1QF6tZDkZaSAlc
        024aPJZbPUpqV/M3yRpkJralFIu2LWPqdrP+tJW4na8or8r3ou2Kf2AZ9Rbd9a61
        sT4S0a10qSWiYP1c9t/c3gegY1nuZQXkvbuWWM6CtwtH+Mmvo6Jb77AwCwj8KhLf
        USF1kKhr2iutxkg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBF9E17AA34;
        Wed,  2 Mar 2022 15:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0D55417AA33;
        Wed,  2 Mar 2022 15:38:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 9/9] Makefiles: add and use wildcard "mkdir -p" template
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
        <patch-v4-9.9-4cc4aeabb20-20220302T124320Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 12:38:05 -0800
In-Reply-To: <patch-v4-9.9-4cc4aeabb20-20220302T124320Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 13:49:17
        +0100")
Message-ID: <xmqqtucgjdjm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA940A0C-9A68-11EC-A7C7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a template to do the "mkdir -p" of $(@D) (the parent dir of $@)
> for us, and use it for the "make lint-docs" targets I added in
> 8650c6298c1 (doc lint: make "lint-docs" non-.PHONY, 2021-10-15).

Sounds good.

> But as it turns out we can use this neat trick of only doing a "mkdir
> -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
> of a performance test similar to that noted downthread of [1] in [2]
> shows that this is faster, in addition to being less verbose and more
> reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3])=
:

Cute.

> diff --git a/shared.mak b/shared.mak
> index bb910273538..83c22d5e7b3 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -59,6 +59,8 @@ ifndef V
>  	QUIET          =3D @
>  	QUIET_GEN      =3D @echo $(wspfx_SQ) GEN $@;
> =20
> +	QUIET_MKDIR_P_PARENT  =3D @echo $(wspfx_SQ) MKDIR -p $(@D);
> +
>  ## Used in "Makefile"
>  	QUIET_CC       =3D @echo $(wspfx_SQ) CC $@;
>  	QUIET_AR       =3D @echo $(wspfx_SQ) AR $@;
> @@ -90,3 +92,18 @@ ifndef V
>  	export V
>  endif
>  endif

It is unfortunate that this came after [8/9] and needs manual
resolution to reorder to leave 8/9 for later series.


