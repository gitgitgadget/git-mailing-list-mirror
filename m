Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F38120899
	for <e@80x24.org>; Fri, 11 Aug 2017 18:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbdHKSlE (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 14:41:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53128 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752781AbdHKSlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 14:41:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7664FAC24A;
        Fri, 11 Aug 2017 14:40:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6mRfT2bl6kyQblknoX+16I5qVdg=; b=ZLMZqL
        NnwBcihFaa1MirPQkqdXT3KpfhPg+XMRk7NF45xndejpFcdMOrOylWVf86yX+Ccu
        oNRyNnUQKnLcOWJyA1M05RLZOFuHHsOp+sWiP5D4IOuQEofDlzweaR+Wsa0ZAmjS
        +1kPxOyjL/gCxDag4wBoxbHgA6bKAiP5LhFHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z41j2NG3/IIsOmNDDNqalgXCz3MxZcQJ
        A7nPcV6WGkbwikZHWhNuqCw+ninSsV33tQadd+iBBh4yHIQMhzm7u5d50pcpNYux
        B+Xb2Xo2fPCl4lghGb1kopa3cPvsAEpxQeFdC7HA3zXFFrf2CYUBvygWjl0odgbS
        ZeBhnIH8V1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C87DAC249;
        Fri, 11 Aug 2017 14:40:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4F44AC245;
        Fri, 11 Aug 2017 14:40:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH V2 1/2] Fix delta integer overflows
References: <1502348462-4992-1-git-send-email-martin@mail.zuhause>
        <xmqqmv772nmc.fsf@gitster.mtv.corp.google.com>
        <20170811074341.GD15128@mail.zuhause>
Date:   Fri, 11 Aug 2017 11:40:55 -0700
In-Reply-To: <20170811074341.GD15128@mail.zuhause> (Martin Koegler's message
        of "Fri, 11 Aug 2017 09:43:41 +0200")
Message-ID: <xmqq378y0wy0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CD88916-7EC4-11E7-82CA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> On Thu, Aug 10, 2017 at 01:07:07PM -0700, Junio C Hamano wrote:
>> > The current delta code produces incorrect pack objects for files > 4GB.
>> >
>> > Signed-off-by: Martin Koegler <martin.koegler@chello.at>
>> 
>> I am a bit torn on this change.
>> 
>> Given that this is not merely a local storage format but it also is
>> an interchange format, we would probably want to make sure that the
>> receiving end (e.g. get_delta_hdr_size() that is used at the
>> beginning of patch_delta()) on a platform whose size_t is smaller
>> than that of a platform that produced the delta stream with this
>> code behaves "sensibly".
>
> Overflows would already be detected during unpack:
> * Assuming size_t = uint32, the system should just be able to handle up to 4GB of process memory.
> So loading any source blob larger than 4GB should already fail.

After re-reading patch_delta(), I agree.  The loading of the base
object (i.e. the procedure to prepare src_buf & src_size fed to the
function) would have failed already.

> * Assuming size_t = uint32 and a source blob size < 4 GB, the
> target blob size would be readed truncated. apply_delta checks,
> that the generated result matches the encoded size - this check
> would fail.

When target size is truncated, we allocate much less than the real
target size, and start reading the input.  But patch_delta() makes
sure that what is copied into the buffer, either by copying bytes
literally from the pack data or by copying from src_buf, will never
cause the resulting dst_buf overflow (especially after your change
updates "size" to size_t), so we should be safe on this side, too.
>  
>> If we replaced ulong we use in create/patch delta codepaths with
>> uint32_t, that would be safer, just because the encoder would not be
>> able to emit varint that is larger than the receivers to handle.
>> But that defeats the whole point of using varint() to encode the
>> sizes in the first place.  It was partly done for space saving, but
>> more for allowing larger sizes and larger ulong in the future
>> without having to change the file format.
>
> The ondisk-format is able to handle larger sizes [using a slightly worse compression].
> The current implementation is just buggy.
>
> I would not move to uint32_t. The remaing part of git uses "unsigned long", so the 
> delta code could still be called with larger files.

Oh, absolutely.  I was merely commenting on the lack of any error
checking in get_delta_hdr_size() helper function, and dismissing a
naive move to limiting the file format by insisting on uint32_t as
an unworkable workaround.
