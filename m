Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FCC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 00:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CDE61157
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 00:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhDIAIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 20:08:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54212 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIAIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 20:08:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38FAD117F60;
        Thu,  8 Apr 2021 20:08:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QNQSgKpgrDDc
        XqFvSn5VwuAvCJg=; b=F2nj8b7e2lbwcuPp3EOCGa6OEkmf9BXik0hAnFO9XcAI
        HvTg9GFPxk6EuuE899Xns+In9whhR8EHcebuUqo3ss3GYgzXVfvL3xgNAJJBl+hr
        QvdvvHN4O+bkzdf73RN0r2cFl3J/o+mWOHWISOuRm896qGpArZMeyT8P2IGFZGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h2CpLb
        ahTqe1Aw9qKHU3Zv342xLB2SSlfKjXgRKPL9RCx17BwIk/XCewFpbw207pJJP6UG
        bGYbqb/88EVnNIkucA5wEydTX+VGPsmqMqGCecQVpCUAaX09jrkwiwntSLKlxN+W
        lp6DdXA2C7vK6Z9gOD0SZaDs01Z+JoEo4muhk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31CDE117F5C;
        Thu,  8 Apr 2021 20:08:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 59095117F59;
        Thu,  8 Apr 2021 20:08:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] git-send-email: refactor duplicate $? checks
 into a function
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
        <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
        <xmqqft0447lu.fsf@gitster.g> <xmqqpmz4qtxi.fsf@gitster.g>
        <xmqqft00qtrj.fsf@gitster.g> <87tuoggwmy.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 17:08:30 -0700
In-Reply-To: <87tuoggwmy.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Apr 2021 01:54:45 +0200")
Message-ID: <xmqqblaopbep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B85A97C6-98C7-11EB-A0FF-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Apr 09 2021, Junio C Hamano wrote:
> ...
>> What's the status of that topic, if there weren't other topics in
>> flight that interfere with it, by the way?  Is it otherwise a good
>> enough shape to be given priority and stable enough to get other
>> topics rebased on top of it?
>
> I see I've mentioned [1] in passing to you before, but in summary I hav=
e
> some major qualms about parts of it, but very much like the overall
> direction/goal of having hooks in config.
>
> Elevator pitch summary of the lengthy [1]: hooks in config: good, but
> having a "git hook" command introduce some nascent UI for managing a
> subset of git-config: somewhere between "meh" / "bad idea" (see securit=
y
> concerns in [1]) / "not needed". I.e. I demonstrated that we can replac=
e
> it with a trivial git-config wrapper, if the series doesn't go out of
> its way to make it difficult (i.e. we can/should stick all config for a
> given hook in the same <prefix>, and not re-invent the
> "sendemail.identity" special-case).
>
> I'd very much like the author to respond to that :) And/or for others t=
o
> chime in with what they think.
>
> 1. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/

OK, Emily, I guess the ball is in your court now?
