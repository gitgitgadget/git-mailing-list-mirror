Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44817C433E0
	for <git@archiver.kernel.org>; Sat, 26 Dec 2020 21:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067FA21D7A
	for <git@archiver.kernel.org>; Sat, 26 Dec 2020 21:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgLZVxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Dec 2020 16:53:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57122 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLZVxF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Dec 2020 16:53:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 339571035B9;
        Sat, 26 Dec 2020 16:52:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F5KO1Ypn9Kek
        OIROeQSU1EwkLus=; b=yAHUsj5M+67Da0KQZHqFIxfJDr4WSYS/tRZ0B1j8G9Ce
        GR7Ck1MA/AUZ396OdIEuXcBfxNVzf0EyIe0BhEPMrYJcbsDra65CZ6ivpugM0S5j
        WB9J80V6zzWIJtjpRbl3MmLOCq2c+sgPbxtzxThKAVzze0eyfUOf+N3D7gOUmIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SdqAlE
        L24pMbxm0fly54i+alZ6fPpRYcxaH6IT8hifq+wcA2Asu//yra441TqNB+ozP4Wc
        dgpOL900PsJXERoikGHctOIAISHZ4VC8cXJbv4axaGXmjVeoOrBLWClGAK72FjT9
        G9YodKfrY9iyAAOpcZvqQEH0K693aLRhEtlZI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B6A71035B8;
        Sat, 26 Dec 2020 16:52:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7AD641035B7;
        Sat, 26 Dec 2020 16:52:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?SsOpcsOpbWll?= Detrey <Jeremie.Detrey@altu.fr>
Cc:     git@vger.kernel.org, Shulhan <m.shulhan@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-remote: load config whenever create_symref() might
 be called
References: <20201226134420.722643-1-Jeremie.Detrey@altu.fr>
Date:   Sat, 26 Dec 2020 13:52:17 -0800
In-Reply-To: <20201226134420.722643-1-Jeremie.Detrey@altu.fr>
 (=?utf-8?B?IkrDqXLDqW1pZQ==?=
        Detrey"'s message of "Sat, 26 Dec 2020 14:44:20 +0100")
Message-ID: <xmqqeejcqlpq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A0FEED1A-47C4-11EB-8D48-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

J=C3=A9r=C3=A9mie Detrey <Jeremie.Detrey@altu.fr> writes:

> Currently, the calls to `create_symref()` do not honor the
> `core.logAllRefUpdates` nor the `user.{name,email}` configuration
> settings, and therefore write reflogs even when explicitly asked not
> to, and ignore the configured user identity.
>
> This happens on `git remote add --fetch`, `git remote set-head`, and
> `git remote rename`: these are the three commands which may create
> a symbolic-ref for the remote's HEAD.

Good problem description.

The usual way we structure the program start-up is do things in the
following order:

 - have the hard-coded built-in default in the form of file-scope
   static variable definition with initial values; remote.c::value
   is an example that by default we are not verbose unless anybody
   else (below) says otherwise.

 - call git_config() to read and set configured defaults, which
   would override the hard-coded built-in default values.

 - call parse_options(), or other use some other means, to parse the
   command line options to further override the values that may have
   been set by reading the configuration files.

My gut feeling says that the best place to call git_config() on
git_default_config would actually be in cmd_remote(), immediately
before we call parse_options() to parse the main options shared by
all subcommands of "git remote".  Is there a reason why codepaths
other than the three you singled out should *not* be affected by the
basic set of configuration variables?

Thanks.
