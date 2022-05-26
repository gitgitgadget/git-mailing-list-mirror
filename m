Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1063C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348571AbiEZS4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiEZS4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:56:02 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB8C965E
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:56:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FA2D19E8DE;
        Thu, 26 May 2022 14:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TpzNYdwqqsoM
        3tZsDc6oOPwg91z+cIf6bjAfrcTEt6Y=; b=gCQz8U41xE+8zdMcvPWbRVTPPfM6
        /FQEdi5AjeKmFRrbw3Q/NJcQ6UZD8X1fS6VvNx+wobVnXBzDiA1kaypXLnUwDKhR
        FGGNlaEescOXonmeNmuZl9i1B2quPRiQLiIpZHBXlAf9CiB1CYbvImRpGwpTfzG0
        HEt5gE7Myi33Uas=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9899A19E8DD;
        Thu, 26 May 2022 14:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4FFB819E8DC;
        Thu, 26 May 2022 14:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
        <xmqqpmk15o46.fsf@gitster.g> <xmqqh75d2aif.fsf@gitster.g>
        <220526.86fskw7mbv.gmgdl@evledraar.gmail.com>
        <xmqqleuo1beq.fsf@gitster.g>
        <220526.868rqo5enf.gmgdl@evledraar.gmail.com>
Date:   Thu, 26 May 2022 11:55:55 -0700
In-Reply-To: <220526.868rqo5enf.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 May 2022 20:29:20 +0200")
Message-ID: <xmqqmtf4yvgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 797D5266-DD25-11EC-B3BD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, May 26 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I don't think we should do it like that and keep it a BUG() not to ca=
ll
>>> BUG_if_bug() when we hit exit(), because e.g. in the case of
>>> parse-options.c once we have the a bad "struct options" we don't want=
 to
>>> continue, as we might segfault, or have other bad behavior etc. So we=
'd
>>> like to BUG() out as soon as possible.
>>
>> Oh, there is no question about that.  When we detect that the
>> program is in an inconsistent and unexpected state, we would want to
>> bug out instead of continuing at some point, and that is why we would
>> want to have BUG_if_bug(), or exit_if_called_bug(), as I called in
>> the message you are reponding to.
>>
>> What I am getting at is that the code often or usually calls
>> BUG_if_bug() is not a reason to require it to be called, especially
>> if there are conditional calls to bug() near the end of the program.
>> Imagine a program, after finishing to respond to the end-user
>> request, before the end of the program, performing some self sanity
>> checks with a series of "if (condition) bug()", and there is no more
>> thing that needs to be done other than exiting after such check.  I
>> would have added such a call to sanity_check_refcnt() at the end of
>> "git blame", for example, if the facility existed.
>
> But you wouldn't want to just stick BUG_if_bug() at the end of those
> sanity checks?
>
> I suppose I can drop the paranoia of requiring it, but since all
> existing callers want to act that way, and I couldn't imagine a case
> where you didn't want that I made it act that way.

It just is one more thing that needs testing.  But in any case, that
was more or less a tongue-in-cheek suggestion and not a serious
counter proposal.  Let's drop it now and stop wasting our time.

Thanks.
