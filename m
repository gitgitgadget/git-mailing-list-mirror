Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF7C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 20:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbiC3U0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiC3U0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 16:26:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0D437BF0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 13:24:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B87EB119857;
        Wed, 30 Mar 2022 16:24:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vD3yWsi/4bcveySMScyZez2xGf59DFAsWpruQH
        dehHg=; b=eaHFOhx450RwRo2JmLD4UBlOz65UUTrEtwELlAeSIVwnZHod7EkTYq
        GfscM+ry/lay/mzTDPey4VyCDatCErgBO03VvsidoEaknAqoedYMgz/x1+STKNgG
        C13hnbI7a48VCi3+EDtWhzSHUjG3Wc0+1ABhsDbuouBOyn2HLNhzk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF680119856;
        Wed, 30 Mar 2022 16:24:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26740119855;
        Wed, 30 Mar 2022 16:24:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 01/14] bulk-checkin: rename 'state' variable and
 separate 'plugged' boolean
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648616734.git.gitgitgadget@gmail.com>
        <xmqqpmm39xhx.fsf@gitster.g>
        <CANQDOdfWTufEn0NRSAOG991JcS4x8GsCC62UCLUTEc3gD6tfGA@mail.gmail.com>
Date:   Wed, 30 Mar 2022 13:24:52 -0700
In-Reply-To: <CANQDOdfWTufEn0NRSAOG991JcS4x8GsCC62UCLUTEc3gD6tfGA@mail.gmail.com>
        (Neeraj Singh's message of "Wed, 30 Mar 2022 11:34:58 -0700")
Message-ID: <xmqqr16j6ve3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74F1B466-B067-11EC-8C33-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> We should add a new function, flush_bulk_checking_packfile(), to
>> flush only the packfile part of the bulk_checkin_state without
>> affecting other things---the "plugged" bit is the only one in the
>> current code before this series, but it does not have to stay to be
>> so
>
> I'm happy to rename the packfile related stuff to end with _packfile
> to make it clear that all of that state and functionality is related
> to batching of packfile additions.

I do not care about names, though.  If you took that I hinted any
such change, sorry about that.  _state is fine as-is.

I do care about not ejecting plugged out of the structure and
instead keeping them together, with proper way to flush the part
that deflate_to_pack() wants to flush, instead of abusing the
"finish".

Thanks.
