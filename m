Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978AEC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 01:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FD02071A
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 01:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="apUZtz23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKYB2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:28:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57870 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfKYB2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 20:28:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB5B88A086;
        Sun, 24 Nov 2019 20:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k1xBz5THJg/v
        PaRUbfpiQ7Eqh6I=; b=apUZtz237hlUP3Y7dx83rD0YaQLcDki8KbEquRhLsjQA
        78PsiKlXSmupAIusb5WL/RluzBUSzB/KeKFcpa/hslV9acGhgTFiLnQAvDY5rY51
        AiRSpX4WWuTsao4b0DPGLOp3/OR56ndkFjlsKMYlrL6PL8P4mWHqeYAzo74p46Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nlfOuZ
        X7Q8stjD/lvPz86ZENHYZvYBQAbtReQEtn4X0VII0zlYJLUMbjyh6tMqB6Qg4pN9
        SKgOKzTa+/v/dEpOCY8vsu7bFkWLyR5ujpnYlsbeqD5wr23xX7veYVZjCSAalLAd
        NDSItYzyOq6fknr9adY40Wuw1DdW8WT8PZn4Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D25BC8A084;
        Sun, 24 Nov 2019 20:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05A0A8A083;
        Sun, 24 Nov 2019 20:28:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3429: try to protect against a potential racy todo file problem
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
        <20191123172046.16359-1-szeder.dev@gmail.com>
        <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
        <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
        <20191124211021.GB23183@szeder.dev>
Date:   Mon, 25 Nov 2019 10:28:01 +0900
In-Reply-To: <20191124211021.GB23183@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sun, 24 Nov 2019 22:10:21 +0100")
Message-ID: <xmqqk17ozqvy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D386BC12-0F22-11EA-AC35-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Sun, Nov 24, 2019 at 10:44:10AM +0000, Phillip Wood wrote:
>> On 24/11/2019 04:49, Junio C Hamano wrote:
>>  ...
>> >Hmph, that makes it sound as if the right fix is to re-read after
>> >writing the first version of the todo file out, so that the stat
>> >data matches reality and tells us that it has never been modified?
>>=20
>> I think we should update the stat data after we write the todo list.
>
> Well, yes and no.
>
> No, because we are dealing with regression in v2.24.0 here, so the
> simpler the fix the better it is for maint.  I don't think a fix can
> get any simpler than my patch, with or without the suggestions from
> Phillip.

Of course, the simplest "fix" for regression is to revert the
offending one, and anything else is a band-aid ;-).  The question is
which band-aid is the least risky and which one takes us the closest
to the real solution.  I tend to agree that forcing to skip checking
no matter what the variable "check_todo" says unless is_rebase_i()
qualifies as the band-aid that is the least risky.

> Yes, we should definitely consider updating the stat data after the
> sequencer writes the todo list, or any other options with which the
> sequencer could notice a modified todo list file with less subtlety.
> Alas, there is a big can of worms in that direction, see the patch
> below, and we have to be very careful going that way, so I think it's
> only viable in the long term, but less suitable as a regression fix
> for maint.

Yes, I agree that it is much less suitable than even reverting the
offending one outright.

> (Hrm, perhaps I spent too many words on the all zeroed out stat data,
> and managed to sidetrack you a bit...)

No, I do not think so.  Thinking about what we need to do in the
longer term, while coming up with a shorter term fix, is a necessary
step of gaining confidence in the latter.

Again, thanks both for thinking about this issue.
