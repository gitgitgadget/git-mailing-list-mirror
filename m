Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA36FC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B57E2075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yOfcCStJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgKYWIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:08:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51810 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731719AbgKYWIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:08:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17E4910408E;
        Wed, 25 Nov 2020 17:08:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qswncha6qjWDYSV+PsZuN1CcYO4=; b=yOfcCS
        tJzDT36NM0iqqDXx/cUyaHUfQW1jQPkQuklbWwU937jUA3M1zC4gqICTiHiDc1GA
        1G4diVFT2hG4EuuEj2MSmRlYhg14q8y0Ixe9bwq4PghxwdQRqLO+ot12YYB6fwIE
        ISVpfzWN+IfNAZqX9ghex3CXgSQJ657R0JrIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i7BIaaIXhbCJFwfIYsLHPLBDejK2q+2l
        C0SCuuYVs1Ck8vXhpOA1CsWp1S3ZbolUTHbbkYfiLunNWNPn2a/dt3prfFzGUm2J
        CDdstFa8Tx5/AvMnoMeZAEoTXomchZnHzITrhNpC5bCDOVkEBn2t3i2Gp6lgidHC
        +CZzX4UcEhE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FE6D10408D;
        Wed, 25 Nov 2020 17:08:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52B4110408B;
        Wed, 25 Nov 2020 17:08:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/11] Advertise session ID in protocol capabilities
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1605136908.git.steadmon@google.com>
Date:   Wed, 25 Nov 2020 14:08:04 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com> (Josh Steadmon's
        message of "Wed, 11 Nov 2020 15:29:23 -0800")
Message-ID: <xmqqpn41ccor.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1F461E4-2F6A-11EB-A5D3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In order to more easily debug remote operations, it is useful to be able
> to identify sessions on either side of the connection. This series
> allows clients and servers to provide a unique session ID via a new
> "session-id" protocol capability. This session ID can be logged on each
> side of the connection, allowing logs to be joined during debugging
> sessions.
>
> Changes from V2:
> * De-emphasize connection to trace2
> * Renamed capability from "trace2-sid" to "session-id"
> * Noted (lack of) session ID structure in capability docs
> * Advertise SID regardless of whether trace2 is enabled
> * Simplify conditionals
> * Style cleanups
>
> Changes since V1:
> * Added a public trace2_session_id() function to trace2.{h,c}. Used this
>   in place of tr2_sid_get().
> * Fixed a style issue regarding using NULL rather than 0.

This round didn't see any responses, but it has already been
extensively reviewed in the previous two rounds and looking good.

Will mark to be merged to 'next', but please holler to stop me if
needed (those in v2 review CC'ed).

Thanks.

