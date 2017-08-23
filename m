Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285B920899
	for <e@80x24.org>; Wed, 23 Aug 2017 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbdHWSaR (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 14:30:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51805 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932396AbdHWSaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 14:30:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB889A6146;
        Wed, 23 Aug 2017 14:30:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fxI4oWCz/Ibs
        Z67eAvIaetUCaog=; b=oIYE1Wwq4ZsF/inYBXev+YD9/znKgTj1yz7uQhxUoRBl
        9ldty5WVOIG4J3lr2bbOOSz1ksRCZz8lwozaJR6+Sm9tKpXx2qgqE1sa2vGz43SS
        a75qMZNlPTs6ZBh/VK3sIeQLoqyrPf2oTPsotjm3tgPzSyPDR+68Oj/q2G6e/Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qD22Yg
        /Ldbir1N9j73yjWEbH2gomIxxMsuI/KIfHmlhzqt1xHH4Zl0pRGJFNN50VFd3mAt
        NMDAFjZMzQYrX0xhKplTfsfb6QFbKwAxaTNCFYrdUWqi9bZWT/aZWSt78cl3pUMJ
        7zKgfHNkMlOa44s49buzZ6/gGHQ8NJ+8Ocxhk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3181A6145;
        Wed, 23 Aug 2017 14:30:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35996A6144;
        Wed, 23 Aug 2017 14:30:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
References: <cover.1502780343.git.martin.agren@gmail.com>
        <cover.1503323390.git.martin.agren@gmail.com>
        <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
        <xmqq378i19ku.fsf@gitster.mtv.corp.google.com>
        <CAN0heSoqnEx=vPVZ5-OfqMkzL_JKKoa+iyP=G5h-cnqOwjPPYg@mail.gmail.com>
Date:   Wed, 23 Aug 2017 11:30:13 -0700
In-Reply-To: <CAN0heSoqnEx=vPVZ5-OfqMkzL_JKKoa+iyP=G5h-cnqOwjPPYg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 23 Aug 2017 19:43:01
 +0200")
Message-ID: <xmqqk21uyw5m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B63109C-8831-11E7-8890-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On 23 August 2017 at 19:24, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>
>>> strbuf_setlen(., 0) writes '\0' to sb.buf[0], where buf is either
>>> allocated and unique to sb, or the global slopbuf. The slopbuf is mea=
nt
>>> to provide a guarantee that buf is not NULL and that a freshly
>>> initialized buffer contains the empty string, but it is not supposed =
to
>>> be written to. That strbuf_setlen writes to slopbuf has at least two
>>> implications:
>>>
>>> First, it's wrong in principle. Second, it might be hiding misuses wh=
ich
>>> are just waiting to wreak havoc. Third, ThreadSanitizer detects a rac=
e
>>> when multiple threads write to slopbuf at roughly the same time, thus
>>> potentially making any more critical races harder to spot.
>>
>> There are two hard things in computer science ;-).
>
> Indeed. :-)
>
>>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>>> ---
>>> v2: no "ifdef TSAN"; moved check from strbuf_reset into strbuf_setlen
>>
>> Looks much better.  I have a mild objection to "suggested-by",
>> though.  It makes it sound as if this were my itch, but it is not.
>>
>> All the credit for being motivate to fix the issue should go to you.
>> For what I did during the review of the previous one to lead to this
>> simpler version, if you want to document it, "helped-by" would be
>> more appropriate.
>
> Ok, so that's two things to tweak in the commit message. I'll hold off
> on v3 in case I get some more feedback the coming days. Thanks.

Well, this one is good enough and your "at least two" is technically
fine ;-)  Let's not reroll this any further.
