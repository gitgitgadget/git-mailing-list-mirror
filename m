Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8DDE8FDAF
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbjJCUUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbjJCUUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:20:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187AAC
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:20:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58D7A1B866A;
        Tue,  3 Oct 2023 16:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Vg/RjTZ1Kx4yWfa6IUGrHGtPPhtwg4Nbpnmatr
        yfQd0=; b=dWvnCAHEVP4sHY/MgL/lb2G1t/2c4fC8//2xCNoKQ79bOJWXsL+vA0
        4TQ6j7Zf1Cmwfo4p1+eaU26qGawsdNi29uVmYmfVMAqXDOHojuTNcGzgLWcAEPTH
        fC9Nha3WpyE+Ez/jP9Krh7lORH25L8q9hYwr73njLflCBrytyXAVw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FB871B8669;
        Tue,  3 Oct 2023 16:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7FE11B8668;
        Tue,  3 Oct 2023 16:20:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/repack.c: avoid making cruft packs preferred
In-Reply-To: <ZRxBlrjyuBmJnx3p@nand.local> (Taylor Blau's message of "Tue, 3
        Oct 2023 12:30:14 -0400")
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
        <ZRxBlrjyuBmJnx3p@nand.local>
Date:   Tue, 03 Oct 2023 13:20:24 -0700
Message-ID: <xmqqa5szzcdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A2D8B58-622A-11EE-A158-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 03, 2023 at 12:27:51PM -0400, Taylor Blau wrote:
>> I've had this sitting in my patch queue for a while now. It's a
>> non-critical performance fix that avoids the repack/MIDX machinery from
>> ever choosing a cruft pack as preferred when writing a MIDX bitmap
>> without a given --preferred-pack.
>>
>> There is no correctness issue here, but choosing a pack with few/no
>> reachable objects means that our pack reuse mechanism will rarely kick
>> in, resulting in performance degradation.
>>
>>  builtin/repack.c        | 47 ++++++++++++++++++++++++++++++++++++++++-
>>  t/t7704-repack-cruft.sh | 39 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 85 insertions(+), 1 deletion(-)
>
> Oops, I should have mentioned that this is meant to be applied on top of
> 'tb/multi-cruft-pack' to reduce the conflict resolution burden. Sorry
> about that.

Sorry, but I do not follow.  tb/multi-cruft-pack was merged to
'master' at c0b5d46d (Documentation/gitformat-pack.txt: drop mixed
version section, 2023-08-28) but back then t7704 did not exist.  Do
you mean the other topic in-flight from you about max-cruft-size?

