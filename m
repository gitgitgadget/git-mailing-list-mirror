Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B379DC11F69
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A146141C
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhGBPae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:30:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54457 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhGBPab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 11:30:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 683B3BCA37;
        Fri,  2 Jul 2021 11:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kAwAGjafXhscA/nXLQ/P7IIu6TWuA1bL6yzgzY
        XHfis=; b=SE3N24Uim/Nm2FnEfzY9Q3ns+njbgQmuEe0amqTM7hT3C+6eVEXIqR
        uRJDxIKgdHzxz0YhfLjJgjIcbfxe8g4OCit6VlOeWpq9v3D2D5iizBirdurxMJ3S
        MgXZSOdKKHId2yK57XtewsWjB/QtyBDoTCNIT1quSBslGRQzWSShI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5857FBCA36;
        Fri,  2 Jul 2021 11:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6CC5BCA34;
        Fri,  2 Jul 2021 11:27:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 14/15] [GSOC] cat-file: re-implement --textconv,
 --filters options
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
        <3aeb4d3d3ec9dc112a19a8b4adeaf213577b4028.1625155693.git.gitgitgadget@gmail.com>
        <xmqqo8blrdzr.fsf@gitster.g>
        <CAOLTT8Qj0BO35+gTFdZ4jkNP=n8TarQX+s0PeCz2i+5yCCj-4w@mail.gmail.com>
Date:   Fri, 02 Jul 2021 08:27:57 -0700
In-Reply-To: <CAOLTT8Qj0BO35+gTFdZ4jkNP=n8TarQX+s0PeCz2i+5yCCj-4w@mail.gmail.com>
        (ZheNing Hu's message of "Fri, 2 Jul 2021 20:46:15 +0800")
Message-ID: <xmqqy2aopwg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14436DB4-DB4A-11EB-94F6-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> These global variables are problematic.  The places that check them
>> are quite isolated, and it makes me wonder why we cannot pass a
>> format instance through the callchain down to get_object().
>
> If we pass such two options In such a deep call chain, it seems not
> worth to do it.

OK.  After all, ref-filter.c has too many existing global variables
(starting from the used_atom[] array) that makes it impossible to be
a proper API that can be used to handle more than one invocations at
once, so two more globals aren't making it any more hopeless than it
currently is.  If we wanted to make the API reentrant, we'd need a
bigger change anyway.

> Or just use "static" prefix?

Yes, that is needed regardless to pass "make sparse".

TShanks.
