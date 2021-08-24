Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AAAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7826661374
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhHXS7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:59:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64489 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhHXS7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:59:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E8AE143869;
        Tue, 24 Aug 2021 14:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j2avQwa5CvgdDSam6bAxq/TziiHaUv7OouDUe5
        hP93M=; b=Ch8svRiwTesQOJhDn3FtML3p5Hymba9/tDm2Cxmszj0Bz6bihN+S8V
        TmN3XGQWtuHtfvjIhkxGymBWDi5HWJClaF42qRbck+R+DHffUCNFMblJoTIXfM35
        jiOlVhR0S8wlKSv3itDSfiPC/67v+UAjM1YRxGUuOojscxM8zESlw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26808143868;
        Tue, 24 Aug 2021 14:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 60790143867;
        Tue, 24 Aug 2021 14:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make: add INSTALL_STRIP variable
References: <20210820105052.30631-1-bagasdotme@gmail.com>
        <YR+Tp2AGeeKyRKoC@danh.dev> <xmqqwnogt20q.fsf@gitster.g>
        <YSBhPdK8jYIQUNhP@danh.dev> <xmqq5yvwrw8s.fsf@gitster.g>
        <6e0ef7f2-3dd0-09e4-5a1d-7e59b979d624@gmail.com>
Date:   Tue, 24 Aug 2021 11:58:15 -0700
In-Reply-To: <6e0ef7f2-3dd0-09e4-5a1d-7e59b979d624@gmail.com> (Bagas Sanjaya's
        message of "Tue, 24 Aug 2021 16:39:44 +0700")
Message-ID: <xmqqv93uoek8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DF9600E-050D-11EC-B81C-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 23/08/21 22.55, Junio C Hamano wrote:
>> Perhaps.  One bad thing with the current "strip" arrangement is that
>> it is done in the built directory, and because "make install" would
>> blindly install whatever in the built directory, if you truly care
>> that you install unstripped binaries, you need to see if they are
>> stripped and rebuild them as needed, because "make strip" may or may
>> not have been done.  From that point of view, getting rid of the
>> current "make strip" and introducing either "make strip-installed"
>> ("we've installed things earlier---go strip them") or "make
>> install-stripped" ("we've built (or if we haven't please build them
>> first), now install them and strip them in the installed directory")
>> may make more sense.  And for that, any idea that came up in this
>> discussion that relies on the current "strip" target would not help.
>
> But often the installed directory (install prefix) is owned by root,
> so one has to `sudo make install-strip`, right?

Whatever you would need to do for "make install" would be necessary,
because you would be touching the system directories, so there isn't
anything new, I would think.
