Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E90720899
	for <e@80x24.org>; Fri, 11 Aug 2017 18:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbdHKSnb (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 14:43:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64521 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752883AbdHKSna (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 14:43:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65681A231B;
        Fri, 11 Aug 2017 14:43:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SBATQ1XsjeOp1JfzVvPjut40PkQ=; b=lyDj8E
        J97O9pCn/l6/0x5pyCyKszDFDNC2qelT1xXSum4Bjtoxj/6gr4F0mfs/5u8dLgWE
        PZE1p9MS672mCcFaD8IuT8+ejKQOfrnbI8d4sWUZJ1+BBj2mfU3bdI6wWlVZbIZ8
        0qhb/4NgkJF07vu8eOcI779Sizjubna8tvE4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ll1dgfdkSOtR0Vt5FWK4IPcOiw5lyhlk
        QNVdmv+50RmEoIfX8xPtsl8sb4IxhQhzFw96ofMDGhCeYmW4SML3Ve7mefNnIOAN
        DXmiHfRZDl1Xrjoht1k1dGtoWay/zLAgSLFjazmgzIPGR0bugUjkZ5vhZFKDKUUI
        9HTUQuHtlqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D317A231A;
        Fri, 11 Aug 2017 14:43:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA099A2319;
        Fri, 11 Aug 2017 14:43:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH V2 1/2] Fix delta integer overflows
References: <1502348462-4992-1-git-send-email-martin@mail.zuhause>
        <xmqqmv772nmc.fsf@gitster.mtv.corp.google.com>
        <20170810203612.lt342yq3gnfadjlp@sigill.intra.peff.net>
Date:   Fri, 11 Aug 2017 11:43:21 -0700
In-Reply-To: <20170810203612.lt342yq3gnfadjlp@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Aug 2017 16:36:12 -0400")
Message-ID: <xmqqy3qqymgm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3D7C7D6-7EC4-11E7-814B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 10, 2017 at 01:07:07PM -0700, Junio C Hamano wrote:
>
>> Perhaps we should teach the receiving end to notice that the varint
>> data it reads encodes a size that is too large for it to grok and
>> die.  With that, we can safely move forward with whatever size_t
>> each platform uses.
>
> Yes, this is very important even for "unsigned long". I'd worry that
> malicious input could cause us to wrap to 0, and we'd potentially write
> into a too-small buffer[1].
>
> There's some prior art with checking this against bitsizeof() in
> unpack_object_header_buffer() but get_delta_hdr_size() does not seem to
> have a check.
>
> -Peff
>
> [1] In most cases it's _probably_ not a vulnerability to wrap here,
>     because we'd just read less data than we ought to. But it makes me
>     nervous nonetheless.

As I said in my other message in the thread, as long as the callers
of get_delta_hdr_size() are written correctly, it should be OK.  And
patch_delta() should be OK, even for "unsigned long" when it is too
small.  It just will not produce correct result and instead abort,
and the patch under discussion fixes that.


