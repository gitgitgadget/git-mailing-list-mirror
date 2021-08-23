Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE1CC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7291A611AF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 15:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhHWP4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 11:56:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57361 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhHWP4d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 11:56:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCCF4E6A56;
        Mon, 23 Aug 2021 11:55:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=pAVznmZasTnL7q+J9nNhr2QGB
        +0d6N1vVWL8ExNu0e8=; b=dG5y3kQg3b4EcNiftihtM3nHP+Epk8o+QsTerv97n
        8dRLlrhHG6oBFv9ZKF9ABWvaNIRsNMXhvk+cANQKDgqblPsXrsqtyYj8ADsmboAU
        Ld+e3vT0taa144d3ZMmDNydfOdyaAl/SAOD966HdvbAQk7kqXnf/Ca7SAx0hyspS
        bM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D26EAE6A55;
        Mon, 23 Aug 2021 11:55:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B8AAE6A54;
        Mon, 23 Aug 2021 11:55:48 -0400 (EDT)
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
        <YR+Tp2AGeeKyRKoC@danh.dev> <xmqqwnogt20q.fsf@gitster.g>
        <YSBhPdK8jYIQUNhP@danh.dev>
Date:   Mon, 23 Aug 2021 08:55:47 -0700
Message-ID: <xmqq5yvwrw8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 95701C94-042A-11EC-8ED9-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> In that case, we can use this construct (since we depends on GNU Make,
> anyway).
>
> ---- 8< ------
> ifneq ($(filter install,$(MAKECMDGOALS)),)
> ifneq ($(filter strip,$(MAKECMDGOALS)),)
> install: strip
> endif
> endif
> ---- >8 -----
>
> MAKECMDGOALS is available from at least GNU Make 3.75.1 in 1997.

Or the "|" thing Dscho floated earlier?

> Anyway, maybe it's only me, but I think people may want to install
> first, then strip later for debug mapping.

Perhaps.  One bad thing with the current "strip" arrangement is that
it is done in the built directory, and because "make install" would
blindly install whatever in the built directory, if you truly care
that you install unstripped binaries, you need to see if they are
stripped and rebuild them as needed, because "make strip" may or may
not have been done.  From that point of view, getting rid of the
current "make strip" and introducing either "make strip-installed"
("we've installed things earlier---go strip them") or "make
install-stripped" ("we've built (or if we haven't please build them
first), now install them and strip them in the installed directory")
may make more sense.  And for that, any idea that came up in this
discussion that relies on the current "strip" target would not help.

Thanks.

