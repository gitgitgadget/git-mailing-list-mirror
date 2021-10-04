Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3808C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F2C61264
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbhJDSMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:12:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62067 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbhJDSMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 14:12:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0765148D5E;
        Mon,  4 Oct 2021 14:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L7+1Q79qWt8q
        aYt1ZrEpmi+nnFWtcA0H6rLSWkLD64E=; b=QNaiaxVpHjHQz0H7m3cvTgzAujbY
        7Kaya5GxPvHPeNKH3kFQ7cBRvszFpLVln/Bs2K7SgCx7Rg80Ql2MH2Yb/ldWF0q5
        Xurj3nFYhorg0U4/msELODfXKcFtijquxelR6pQUipBIyCY+01QCDvhzpm7O/sGk
        NdRuqzBZNa+TSF4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C821F148D5D;
        Mon,  4 Oct 2021 14:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F2DD148D5C;
        Mon,  4 Oct 2021 14:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/2] terminal: teach git how to save/restore its
 terminal settings
References: <20211002153654.52443-1-carenas@gmail.com>
        <20211004072600.74241-1-carenas@gmail.com>
        <20211004072600.74241-2-carenas@gmail.com>
        <xmqq1r50ycgf.fsf@gitster.g>
        <CAPUEsph_Aqaveur4qZ+Z+85gw1z2CvPOkzbkqW9zt56RoHhUJw@mail.gmail.com>
Date:   Mon, 04 Oct 2021 11:10:49 -0700
In-Reply-To: <CAPUEsph_Aqaveur4qZ+Z+85gw1z2CvPOkzbkqW9zt56RoHhUJw@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 4 Oct 2021 10:27:06 -0700")
Message-ID: <xmqqlf38wthy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67D82828-253E-11EC-80AA-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Mon, Oct 4, 2021 at 9:36 AM Junio C Hamano <gitster@pobox.com> wrote=
:
>> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>> > diff --git a/compat/terminal.c b/compat/terminal.c
>> > index 43b73ddc75..1fadbfd6b6 100644
>> > --- a/compat/terminal.c
>> > +++ b/compat/terminal.c
>> > @@ -8,7 +8,7 @@
>> >
>> >  #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
>> >
>> > -static void restore_term(void);
>> > +void restore_term(void);
>>
>> Curious why you need this because (1) we do not have the same for
>> save_term() here, and (2) we include compat/terminal.h where these
>> two are declared next to each other.
>
> It is in preparation for the next patch where we will call these newly
> public functions from editor.c
> I'll be reusing restore_term(), while save_term() is new, hence why
> only one had this change.

I think I understand all that correctly.

I was curious why the patch left a forward declaration, instead of
just removing it, which it can do because now we have the necessary
declaration in the header file it includes.

With only [1/2]:

 - we already have save_term() and restore_term() externally
   declared, so even outside users can use them (which is a good
   thing to do), as long as they include <compat/terminal.h>.

 - we include <compat/terminal.h> in compat/terminal.c; I do not see
   why the patch needs to turn a static forward declaration into an
   extern one in the hunk in question.

Thanks.
