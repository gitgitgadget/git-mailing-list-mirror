Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E51FC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 01:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiADBTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 20:19:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62286 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiADBTo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 20:19:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ECD0F32DA;
        Mon,  3 Jan 2022 20:19:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LvcrjEHznQFoBl4tyB80FneYbViGPHznuA1lCK
        NhPV8=; b=Ro72I10mt2H1ZVWuiixZsPc/vKsBKsEvUODVnLVqaSxKQ3S/7zX0az
        yRKY7Pt8hbrRNq05WS4+HuDzfywO9bPiO6sDpaF5GOIayqLkBgW+woNLuE8LPCQu
        BoS0M3yqd1k+Eu0693scnQ51DI4kMuUh15/hXgcg6WRxajTUusxs8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75BF1F32D8;
        Mon,  3 Jan 2022 20:19:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7251F32D7;
        Mon,  3 Jan 2022 20:19:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
        <20220103095337.600536-1-fs@gigacodes.de>
        <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
        <xmqqee5oieb2.fsf@gitster.g>
        <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
Date:   Mon, 03 Jan 2022 17:19:41 -0800
In-Reply-To: <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 3 Jan 2022 19:41:51 -0500")
Message-ID: <xmqqmtkcguvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6550BA6A-6CFC-11EC-8219-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jan 3, 2022 at 6:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Mon, Jan 3, 2022 at 9:24 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> >> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
>> >> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
>> >> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
>> >> this hypothesis. Signature verification passes with the fix.
>> >> ---
>> >> -                       trust_size = strcspn(line, "\n");
>> >> +                       trust_size = strcspn(line, "\n"); /* truncate at LF */
>> >> +                       if (trust_size && trust_size != strlen(line) &&
>> >> +                           line[trust_size - 1] == '\r')
>> >> +                               trust_size--; /* the LF was part of CRLF at the end */
>> >
>> > I may be misunderstanding, but isn't the strlen() unnecessary?
>> >
>> >     if (trust_size && line[trust_size] &&
>> >         line[trust_size - 1] == '\r')
>> >             trust_size--;
>>
>> That changes behaviour when "line" has more than one lines in it.
>> strcspn() finds the first LF, and the posted patch ignores CRLF not
>> at the end of line[].  Your variant feels more correct if the
>> objective is to find the end of the first line (regardless of the
>> choice of the end-of-line convention, either LF or CRLF) and omit
>> the line terminator.
>
> Okay, that makes sense if that's the intention of the patch. Perhaps
> the commit message should mention that `line` might contain multiple
> lines and that it's only interested in the very last LF (unless it's
> already obvious to everyone else, even though it wasn't to me).

I do not think that is the case.  strcspn(line, "\n") will stop at
the first one, so unless it is guaranteed that "line" has only one
line in it, the patch as posted is not correct.  Your variant
without strlen() feels more correct, as I said.

