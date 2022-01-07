Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30FC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 00:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbiAGAKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 19:10:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56809 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiAGAKX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 19:10:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22096108427;
        Thu,  6 Jan 2022 19:10:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Eoj1VDSNXNkJpK6i60t4MBdO3
        gbsPMtFdQRoDT++xMM=; b=bzf3hqdqfXvW2RzHbxSPSN0OGfVkcSnU7Bt0DrJlm
        PuHpNXbTx1heFzQ29+p8NXqIMG5zgzqvCHnw8D4ApL2TYAK5UEXTUBoly85WhW54
        mXo4MGRIDyRuVI+2AVzAdHg4BkTb8N5U7wdlmTmNNm69CoGCBNGAJhfcvDk6ewb6
        ho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1828D108425;
        Thu,  6 Jan 2022 19:10:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67D6D108422;
        Thu,  6 Jan 2022 19:10:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
        <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
        <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
X-Gnus-Delayed: Thu, 06 Jan 2022 19:30:08 -0800
Date:   Thu, 06 Jan 2022 16:10:21 -0800
Message-ID: <xmqqfsq09ziq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 34BB9C68-6F4E-11EC-A048-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jessica Clarke <jrtc27@jrtc27.com> writes:

> This is also true of uint128_t, it doesn=E2=80=99t fit in a uintmax_t e=
ither.

uintmax_t is supposed to be an unsigned integer type capable of
representing any value of any unsigned integer type, so if you have
128-bit unsigned integer, your uintmax_t should be at last that
wide, or your uintmax_t is not uintmax_t as far as C standard is
concerned, no?

uintptr_t is an unsigned integer type that any valid pointer to void
can be converted to this type, then converted back to pointer to
void, and the result will compare equal to the original pointer.  So
the value of uintptr_t cannot be represented by uintmax_t, there is
something wrong.

> uintmax_t was a mistake as it becomes part of the ABI and can never be
> revised even when new integer types come along. uintmax_t can hold any
> valid address, but will strip the metadata.

It is a flaw in the implementation of uintmax_t on the architecture
that needs "the metadata", no?  If the implementation supports a
notion of uintptr_t (i.e. there exists an unsigned integer type that
can safely go back and forth from pointer to void), an unsigned
integer type that is at least as wide as any unsigned integer type
should certainly be able to hold what would fit in uintptr_t, no?

Puzzled.

