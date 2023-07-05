Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B24CEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 20:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjGEUdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGEUdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 16:33:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C686198B
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 13:33:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EB2C1A410C;
        Wed,  5 Jul 2023 16:33:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yLsP96hXmQiL
        kcztc5wJpIoCrJgRJt6utqGBEk3P7vg=; b=wX8q1oC1TsBUIZOKVmt+mK1fIYzO
        Cpp/O5pFgiWup/tQUW6saJtW0o6/8pD9LQglepp5wi42qwrlhDal33OTc5c2gGMC
        ywbj5v/t4SVlFdK81q6wxCgld6w6OkRmSJ5htt3iPs02XnZKhRqPsInB5ZfpUuxK
        yZYPSyFSfTERbH4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 066F01A410B;
        Wed,  5 Jul 2023 16:33:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D2C21A410A;
        Wed,  5 Jul 2023 16:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: don't check string length in packet_length()
References: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
        <xmqqttui3nqn.fsf@gitster.g>
        <32f41065-a78c-aa60-0d78-4dbfa8827b1a@web.de>
Date:   Wed, 05 Jul 2023 13:33:11 -0700
In-Reply-To: <32f41065-a78c-aa60-0d78-4dbfa8827b1a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 5 Jul 2023 18:15:56 +0200")
Message-ID: <xmqq4jmiyu7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 294F7F8E-1B73-11EE-A834-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> I do like the resulting code, but I feel a bit uneasy to sell this
>> change as "the code becomes more streamlined without losing safety".
>> It looks more like "this change is safe for our two callers; those
>> adding more callers in the future are better be very careful", no?
>
> With no way to enforce passing an array of a certain size to a function
> the only safe options I see are keeping the length check, using a macro
> or inlining the calculation.  Hmm.

We keep repeating "length check" because that is what the comment in
the function says, but even if the caller has 4-byte, that 4-byte
substring at the beginning is what it read from the untrusted side
over the network.  We should be checking if we have 4 hexadecimal
length even if we are not running beyond the end of the buffer, no?

So it may be that the comment needs to be fixed more than the code.

Thanks.
