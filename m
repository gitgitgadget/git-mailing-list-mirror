Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2787C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A062061056
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhHTSRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:17:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52780 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhHTSRU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 14:17:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03F07140BC3;
        Fri, 20 Aug 2021 14:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bpg81OW+xSof
        ppK2EtdPN/rc1COZ0o2myA8rlFAfyZQ=; b=ev+Wk2A3Oji0GR3IYn76ARrgHa0z
        XP5WnCOwpY3fDR6hy5bOt/cmXy7eDUHcJ7GKYCtdv4U0f2wqHc7c89ErJh5cLW4M
        VsapI3uM0Uyhe+PdSkcPZmHmJjk1fdA554hhUNae3JA/yq2iIOOOURPcx9IbJi5Q
        +oYGLzlSzNEDAys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF8EA140BC2;
        Fri, 20 Aug 2021 14:16:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3828C140BC1;
        Fri, 20 Aug 2021 14:16:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make: add INSTALL_STRIP variable
References: <20210820105052.30631-1-bagasdotme@gmail.com>
        <YR+Tp2AGeeKyRKoC@danh.dev>
Date:   Fri, 20 Aug 2021 11:16:37 -0700
In-Reply-To: <YR+Tp2AGeeKyRKoC@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Fri, 20 Aug 2021 18:36:07 +0700")
Message-ID: <xmqqwnogt20q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C34C85A2-01E2-11EC-A0F7-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>>  install: all
>> +ifdef INSTALL_STRIP
>> +	$(MAKE) strip
>> +endif
>
> I believe it's better to write like this:
>
> ----- 8< ------
> ifdef INSTALL_STRIP
> install: strip
> endif
>
> install: all
> 	....
> ---- >8-------
>
> IOW, install depends on strip, not install invoke strip.
> I think it would work better for:
>
> 	make install strip

I think you meant "it would work better than 'make install strip'",
and if so, I tend to agree.  With

	echo INSTALL_STRIP=3DYesPlease >>config.mak

either Bagas's or your "before installing, make sure we strip"
change lets

	make install

just work without "strip" given on the command line.

If users with such a config.mak type "make install strip", it will
make the recipe for "install" wait until "strip" is done, which is
what we want, but "strip" on the command line for them is redundant,
and there is no way for them to install unstripped binaries, which
may be a bit of downside.

But for those who do not always want to use INSTALL_STRIP, as Dscho
said after I mentioned the "make variable" thing, we probably a
wrong thing when they say "make -j strip install", as there is
nothing to make recipe for "install" to wait for "strip", so it is
not a fully satisfactory solution.

I think we want two things:

 (1) if a user says "make [-j] strip install", make sure "install"
     won't start before "strip" finishes;

 (2) if a user wants to always install stripped binary, allow some
     make variable in config.mak so that "make install" would do
     that without an explicit "strip".

Of course, if a user does not have (2) configured, "make install"
should install unstripped binaries, but that goes without saying.

And after thinking it like this, perhaps a new "install-stripped"
target that runs "strip" and then "install" as originally proposed
in the thread that triggered this discussion may be the simplest
approach.  We can control the optional dependency between "strip"
and "install", those who want to install stripped binary can use
"install-stripped" instead of "install", and they can on-demand
choose to install unstripped binary (which was a potential downside
of the "make variable" approach under discussion here).

Thanks.

