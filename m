Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A82C433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 15:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiI2PsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiI2Prl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 11:47:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082DF12AEF5
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 08:47:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 435D31B13FA;
        Thu, 29 Sep 2022 11:47:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ow27ozMHlN7X
        mfYum96T0Ipcse4u37sGhNAzhJCYWq8=; b=aMGaWlY9tQWKmc/M18JFfFdogOfE
        jDk5gqAmZXG/DNK6XpbZBrZNInP0pyg26eFyCOPniCVqm1LgpkUzKhC/fxI3X1zr
        yt4G0pMHAcPxIoPiqhsxrxHXOMsFFCg057kME2tGAVlLPBUfBqdWjUr6McydN0Ur
        yvRA7Fx+v7xrDmE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C54A1B13F9;
        Thu, 29 Sep 2022 11:47:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E07BF1B13E9;
        Thu, 29 Sep 2022 11:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/3] read-cache: read on-disk entries in byte order
References: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
        <YzPLuizoOlDuPu4G@coredump.intra.peff.net>
        <YzWBEoRkCmbUkIs8@coredump.intra.peff.net>
Date:   Thu, 29 Sep 2022 08:47:24 -0700
In-Reply-To: <YzWBEoRkCmbUkIs8@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 29 Sep 2022 07:27:14 -0400")
Message-ID: <xmqqczbep4hf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04020F1C-400E-11ED-8A0E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 28, 2022 at 12:21:15AM -0400, Jeff King wrote:
>
>> The downside is that we're copying the data an extra time. It's not ve=
ry
>> much data, and it's all fixed size, so the compiler should be able to =
do
>> a reasonable job of optimizing here. But I didn't time the potential
>> impact.
> ...
>   Summary
>     './test-tool.old read-cache 1000' ran
>       1.11 =C2=B1 0.04 times faster than './test-tool.new read-cache 10=
00'
>
> I think that's probably the nail in the coffin for my proposed approach=
.
> To be fair, it's only .3ms extra for a normal program which reads the
> index once. That's not that big in absolute numbers. But there are
> larger index files in the wild. And the improvement in simplicity and
> readability is simply not that great.

Thanks for the due diligence.  This result may be an indication of
how efficient the existing code is, but it is a bit surprising that
one more copy of the stat_data struct makes that much difference.

