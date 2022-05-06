Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92418C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443962AbiEFVEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444332AbiEFVDq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:03:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561966F4A7
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:59:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1449B1871DC;
        Fri,  6 May 2022 16:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iTzpO0X9YByWrU9rXPX/tqFzHuKOILv3qySG+Q
        269xs=; b=VeZwHRgMHorPfCyVHC/Ukue9jRC5V/x86LU9QMkgnxpBFnlNTuFnxQ
        j90YjATLNzPJrPVBPvJe+b0PKqzie9pw3DiXKUM+m4TDa1TSInSDEq+VEEDpnmO/
        kgaDoKt5EiMC4CvWs1HvKomby/YbLr/MNURTkB1K3s4Hivt8JkukA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C05D1871D9;
        Fri,  6 May 2022 16:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E798F1871D5;
        Fri,  6 May 2022 16:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220503065442.95699-1-carenas@gmail.com>
        <20220503065442.95699-3-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
        <c9fc0fc6-c688-022d-9476-aaa87c66d295@gmail.com>
        <CAPUEspiMsvNhQF-RjW5eu3Xco9gU7TFt4w9dOOcF1PGM4Z+ceQ@mail.gmail.com>
        <xmqq35hml9cs.fsf@gitster.g>
        <CAPUEspj98i9oTECSvSp4c-sDQ=hrxJHCY3Nn6QwqdAf9Ntnahw@mail.gmail.com>
Date:   Fri, 06 May 2022 13:59:52 -0700
In-Reply-To: <CAPUEspj98i9oTECSvSp4c-sDQ=hrxJHCY3Nn6QwqdAf9Ntnahw@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 6 May 2022 13:22:49 -0700")
Message-ID: <xmqqh762js1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A65AF76-CD7F-11EC-A2ED-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Fri, May 6, 2022 at 1:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Carlo Arenas <carenas@gmail.com> writes:
>>
>> > which is also why we can't use it, any possibly bogus or suspicious
>> > value we get from SUDO_UID MUST be ignored.
>>
>> I do not think I agree.  If we have a strange value in SUDO_UID, it
>> would be much better and safer to err on the safe side.
>
> ignoring it is the safe side; for example if we replace the current
> function with the proposed one then some user lucky enough to have
> access to the latest linux supercomputer that has been patched to have
> a 64-bit uid_t (because who makes 32-bit supercomputers nowadays)
> would get root[1] access by simply faking his SUDO_UID to be UINT_MAX
> + 1.

Since we do not pay attention to SUDO_UID unless euid is root,
anybody who can attack by faking SUDO_UID to affect what Git does
can already become root on the box.  So such an attacker would
already have root access without our help, or they would not.

In any case, if we notice that SUDO_UID is not a valid number and
die(), we deny the access anyway, so there is no need to write more
code to ignore.

