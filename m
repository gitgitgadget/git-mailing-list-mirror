Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D55C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiFFRAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiFFRAY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:00:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72DDA7E3E
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 09:53:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4C8E19E5A6;
        Mon,  6 Jun 2022 12:53:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=a2DlvrcEnDC0
        0/yvUvLvBiUv3nonSl9vw9F6OszO6qw=; b=cIw2znQgtttUHp2KXrs67efHfn9i
        lnJ+dosHrdK/Wn8VjeV2e9lXmYkehMC9Mv2w8sR68qH/BE/qoSAxB6XSm0H0Z44R
        wQWLwJuNu9VruaSJhRVDB/iTh5smOb/cfeywY0ktN6toU7LEzGkd7uvO4GMTYjvy
        x+DhZgeRhRjpbCY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCA4219E5A4;
        Mon,  6 Jun 2022 12:53:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D0BC19E5A2;
        Mon,  6 Jun 2022 12:53:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
        <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
        <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
        <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
        <1de74bf7-0e75-8ae3-6ea7-62939b540061@web.de>
        <220604.868rqcwfnw.gmgdl@evledraar.gmail.com>
Date:   Mon, 06 Jun 2022 09:53:11 -0700
In-Reply-To: <220604.868rqcwfnw.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 04 Jun 2022 18:23:13 +0200")
Message-ID: <xmqq7d5tag3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 276A9B68-E5B9-11EC-8492-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Future analyzer reports are likely of the same quality as the current
>> ones.  If the goal is to shush them then we should just not use the
>> analyzer.  If reports contain a helpful signal, e.g. pointing to a rea=
l
>> bug or to overly complicated code, then we better address these issues=
.
>>
>> We can think about automating the analyzer once we have a certain numb=
er
>> of commits with improvements that would not have been made without it.
>
> We might decide not to go with -fanalyzer in CI or whatever, but I
> really think that your line of reasoning here is just the wrong way to
> evaluate the cost/benefit of -fanalyzer, a new warning or whatever.

To me, your priorities look much less in line with this project's
than what Rt R=C3=A9ne gave us above.

> The question shouldn't be whether those things in particular were worth
> the effort, but whether the added safety of getting the new diagnostic
> going forward is worth the one-time cost.

Workarounds for false positives are hardly one-time cost.  They have
to stay with us until the -fanalyzer gets corrected, somebody needs
to remember to occasionally check if that happened, and revert the
workaround to bring the code into their more natural form.  What has
been good and readable for human programmers for a long time does
not need to be touched just to work around a false positive bug in a
new tool.

> I find the warning output from -fanalyzer to be *really useful*.

I do not mind if you add -fanalyzer during your build via your own
config.mak file, and you would help them improve the analyzer by
reporting false positive bugs while finding possible bugs in the
code we have (like you did in a few patches in this series) and the
code you are writing.  You are capable enough to keep your own set
of patches to work around their false positive bugs locally.

But if you have to send in 15 patches with more workaround changes
than real fix, then it is premature for us to bear the cost to have
workaround for the tool.

There are folks who use our codebase as a suitably-sized guinea pig
to improve their tool, and we should not make it harder for them to
do so, but our priority is to improve the product of this project.

Come to think of it, adding unnecessary workarounds is a hostile act
to those who are trying to improve -fanalyzer, I guess, too.  They
may want to fix problems in their tool, but workarounds hide them.

