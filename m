Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E937720986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbcJDVqt (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:46:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53779 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750792AbcJDVqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:46:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4E9C4416D;
        Tue,  4 Oct 2016 17:46:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nHm5acJNkgbm5Ur1XD4E94adG70=; b=kHncci
        ReiLtOTK2lxVMJojM7hhY2FtxQT6S92RUcP02n6YxCh6918G5t4bfyuJHq6NBzIt
        LpSOtUTFb/i1SfgavjkApnpDX6bKlHelEabg1PQPG2YVqMpdp52QSePM7IhFIfyS
        +9iIToFLq7p8Av2+h7nA4ETxNAoLa/RtK/CEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=APYRGBij1I8tNatnJKUmDcA6XBiEjr0L
        U8NiQDmH8oZMEn+sLmYjD/wEB3CfYRfNF4JQp3pBcA1OHzlB37m3hbZX9C3M+ra5
        OrTSykxbu0i2PN+xXt185tHUjFX1dIR1OT/8afkxRE2B3HClfRrMiBRWkTdtnABW
        hyO7OiJ0JXI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD06A4416C;
        Tue,  4 Oct 2016 17:46:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66AC544167;
        Tue,  4 Oct 2016 17:46:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 13/18] fill_sha1_file: write "boring" characters
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203555.6xadycotmmkuf34h@sigill.intra.peff.net>
        <CA+P7+xpOxoRBDZGF_CU1Q-SYiQZtMx2vuwQKS0og864awZod5g@mail.gmail.com>
Date:   Tue, 04 Oct 2016 14:46:44 -0700
In-Reply-To: <CA+P7+xpOxoRBDZGF_CU1Q-SYiQZtMx2vuwQKS0og864awZod5g@mail.gmail.com>
        (Jacob Keller's message of "Mon, 3 Oct 2016 23:13:59 -0700")
Message-ID: <xmqqbmyzss6z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C100568-8A7C-11E6-93D6-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Oct 3, 2016 at 1:35 PM, Jeff King <peff@peff.net> wrote:
>> This function forms a sha1 as "xx/yyyy...", but skips over
>> the slot for the slash rather than writing it, leaving it to
>> the caller to do so. It also does not bother to put in a
>> trailing NUL, even though every caller would want it (we're
>> forming a path which by definition is not a directory, so
>> the only thing to do with it is feed it to a system call).
>>
>> Let's make the lives of our callers easier by just writing
>> out the internal "/" and the NUL.
>> ...
>
> I think this makes a lot more sense than making the callers have to do this.

The cost of fill function having to do the same thing repeatedly is
negligible, so I am OK with the result, but for fairness, this was
not "make the callers do this extra thing", but was "the caller can
prepare these unchanging parts just once, and the fill function that
is repeatedly run does not have to."

