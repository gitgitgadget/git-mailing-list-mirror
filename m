Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68578C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392404AbiEFUE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392475AbiEFUE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 16:04:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490885F8D7
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:00:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05922186A22;
        Fri,  6 May 2022 16:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+/SI+aRi1uHjyPN86G/KZVOh3fIXvsCK6Xdzc0
        yx8so=; b=X7O8l6RddSFBmolg9hIIJ0u8cWYVOIHa/0xGaXIcWw6GHjT6iSi5TC
        ZJtMOfkcoRtdHPfeDeV5AYBxgQnKNTExpUxGONpIijSnqt5taeBVuSFjnc4GPeo4
        HHaF4bHU1dq2wYbkhNYZkWiUGGgJYf44PeT/o5rg3KKedTqcUzqXc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1B32186A21;
        Fri,  6 May 2022 16:00:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F1B6186A1C;
        Fri,  6 May 2022 16:00:36 -0400 (EDT)
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
Date:   Fri, 06 May 2022 13:00:35 -0700
In-Reply-To: <CAPUEspiMsvNhQF-RjW5eu3Xco9gU7TFt4w9dOOcF1PGM4Z+ceQ@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 6 May 2022 12:15:06 -0700")
Message-ID: <xmqq35hml9cs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3214EA46-CD77-11EC-A9A5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> which is also why we can't use it, any possibly bogus or suspicious
> value we get from SUDO_UID MUST be ignored.

I do not think I agree.  If we have strange value in SUDO_UID, it
would be much better and safer to err on the safe side.  

Instead of ignoring, in the situation where we care about the value
we read from SUDO_UID (i.e. when euid==0), we should die loudly when
it has a strange value.
