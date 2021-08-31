Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D50CC4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0051D610CE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhHaRHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:07:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57685 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhHaRHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 13:07:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71C47ED4A5;
        Tue, 31 Aug 2021 13:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bwx8AXO4+gnArFGZYZ8QozWQtJOGuJ9C7/6Ps4
        6sscc=; b=VWfpGq6Wcd8dZqSUBEwVzT2jEAMPs8oP6ljsSpahoH2az9AmjhjCsH
        lXbUJpI3Lmd2G/KH2iFbQUw3HK6oOLk6wbA2XKyJDF5+6+8RUfrjcqGxv4xJJMao
        Xfv04RMSHn3+ZDr/RwgKYefN0oTYGbQpmj/kqCU+d88LZOaybdYSE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A3D9ED4A4;
        Tue, 31 Aug 2021 13:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0949ED4A3;
        Tue, 31 Aug 2021 13:06:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RESEND v2] make: add install-stripped target
References: <20210831013235.388682-1-bagasdotme@gmail.com>
Date:   Tue, 31 Aug 2021 10:06:49 -0700
In-Reply-To: <20210831013235.388682-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Tue, 31 Aug 2021 08:32:36 +0700")
Message-ID: <xmqq8s0hwnkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4D1F692-0A7D-11EC-9E65-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Add the target that install Git with stripped executables.
> ...
> +
> +install-stripped: INSTALL_OPTS = -s --strip-program=$(STRIP)

Not everybody's $(INSTALL) supports --strip-program, does it?  

FreeBSD seems to lack the option, and instead uses the $STRIPBIN
environment variable to specify which program to use.

The manual page for macOS [*] does not mention --strip-program or
STRIPBIN.

If the user leaves STRIP as the default (i.e. strip), this target
fails, not because the user does not have 'strip', but because the
'install' used by the user does not know the --strip-program option,
even though there is no need to use the option in such a case.

Given that, I am not sure if we really want "install-stripped"
target.  Adding INSTALL_OPTS make variable that defaults to an empty
string is a good idea, but we probably can and should stop there.

Then users can do any of the following:

	$ make INSTALL_OPTS=-s install

	$ STRIPBIN=my-strip make INSTALL_OPTS=-s install

depending on their system, which sounds sufficient, and is a vast
improvement over the current

	$ make ; make strip ; make install 

I would think.


[Reference]

* https://opensource.apple.com/source/file_cmds/file_cmds-321.40.3/install/install.1.auto.html
