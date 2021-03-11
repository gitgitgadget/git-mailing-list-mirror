Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DA5C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5180964F3B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCKRe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:34:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62032 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhCKRd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:33:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C36D9BBDAE;
        Thu, 11 Mar 2021 12:33:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pBSW0Me6OOkM
        4qiw4KA1KIR2QnU=; b=iXUwAH8WOKopOcuveywoxbHZHCweJPDAdsBVtHC+T/QN
        AWGgfgPE8ZrVVJnQ1LQloqUpSalpoo5xVU/aI4cFCyGN5qMAA5fviAIvuRREu5sQ
        i34Fj6QFLEDfe+XdpZWcqthD91LNW1HCvAE7rTiyusYMyanzBSNY7E7EX3SNknw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SmLuMU
        9idyCntM5nTtbZPR/8om2r4V0+5wVCaFs5x/T7+AmCsCY9oYN3PUSHnehSIvEuXZ
        VFPWh0Z8KK9mmOTprzzAahDMdSCUY5ZHUZLr/yqcNCeVmqtFmmD+xWf0lccD5UKp
        pZ0uqC49ck7RjXllQX2D0x3r+UHkMA+fVgT04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9C61BBDAD;
        Thu, 11 Mar 2021 12:33:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E7A0BBDAC;
        Thu, 11 Mar 2021 12:33:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: guard against being run as 'prove t*.sh'
References: <20210311124216.25036-1-avarab@gmail.com>
Date:   Thu, 11 Mar 2021 09:33:53 -0800
In-Reply-To: <20210311124216.25036-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 11 Mar 2021 13:42:16 +0100")
Message-ID: <xmqqwnudegse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F42183A8-828F-11EB-9C93-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We have t/Makefile targets to properly run the tests with prove,
> however it's also just as valid to run them as e.g.:
>
>     prove t[0-9]*.sh
>
> But if they're run as:
>
>     prove t*.sh

I am not sure if the above is a good enough excuse to diverge from
our convention not to add #! to signal that a scriptlet is not to
be used standalone but is meant to be dot-sourced.  At least to me,
this change looks like making the codebase worse to protect from a
mistake that we should not have to worry about in real life.

But that may be because my use of prove is limited to a more
targetted and narrow set of tests (i.e. either use "t4???-*.sh" for
an area, or a single test---anything broader I'd use "make").
