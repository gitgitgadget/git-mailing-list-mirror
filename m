Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726A6EE3F3F
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 00:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjIMAbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 20:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjIMAbP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 20:31:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852010CC
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 17:31:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E65FF19E509;
        Tue, 12 Sep 2023 20:31:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qfPgrj2A1GVQ
        amuDUD+YnIiTOYnfQ2d16IpUXj0E9aw=; b=V7vt/VDXgvrIGtupUdMQ+ea3uK7e
        iqP2FChZhOzVg0UKDtBe9pnxSZhZpxtm4rN+L12bnwuRirnUbwwQSXnlSy2tr7fW
        sVmArJQTSv0ePYD24X5ryZ2/6rorIvNg/Jruk6NqNG4u/A3PJZpGEmnS9H10jf+0
        7ynr+cUD2oA21iw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC6E819E508;
        Tue, 12 Sep 2023 20:31:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D17E19E507;
        Tue, 12 Sep 2023 20:31:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
In-Reply-To: <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 12 Sep 2023 20:07:06 +0200")
References: <20230911121126.GA17383@redhat.com>
        <20230911121211.GA17401@redhat.com> <xmqq34zktk4h.fsf@gitster.g>
        <20230911231756.GA2840@redhat.com> <20230912130429.GA9982@redhat.com>
        <20230912135124.GA11315@redhat.com>
        <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de>
Date:   Tue, 12 Sep 2023 17:31:09 -0700
Message-ID: <xmqq1qf2lxrm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D622319A-51CC-11EE-9A9A-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> To me, this behaviour looks as
>>>
>>> 		Show the preceding line that contains the function name of
>>> 		the match, unless the _PREVIOUS_ matching line is a function
>>> 		name itself.
>
> To me it looks like:
>
> 		Show the preceding line that contains the function name of
> 		the match.
>
> ("Show" meaning "show once", not "show for each match again and again".=
)
>
> Or:
>
> 		Show the preceding line that contains the function name of
> 		the match, unless it is already shown for a different
> 		reason, e.g. as a match or as the function line of a
> 		previous match.

Wow, that was a mouthful, but matches my understanding.  I na=C3=AFvely
thought "when showing a hit, we may add the line that matches the
function header pattern before the hit even that header line does
not hit the grep pattern. But if the header line does hit the grep
pattern, we do not bother show the same thing twice." was a
reasonable goal to have.

> Indeed that matches the letter of the documentation.
>
>> 	$ ./git grep --untracked -pn xxx TEST2.c
>> 	TEST2.c:1:void func(xxx)
>> 	TEST2.c=3D1=3Dvoid func(xxx)
>> 	TEST2.c:3:      use(xxx);
>
> That one as well.
>
>> Or I am totally confused?
>
> No, I think the documentation is wrong.  I'd simply remove the part
> after the comma, but there are probably better options.

Documentation may not match the behaviour, but do we know what the
behaviour we want is?  To me, the last example that shows the same
line twice (one as a real hit, the other because of "-p") looks a
bit counter-intuitive for the purpose of "help me locate where the
grep hits are".  I dunno.
