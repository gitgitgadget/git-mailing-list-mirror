Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2AC433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 21:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiAUVT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 16:19:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50182 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiAUVT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 16:19:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEA84100C74;
        Fri, 21 Jan 2022 16:19:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hv0eVUhPTDq1
        D8xbJlCNdPInAkf5F1i2x1m7EWezs6c=; b=SOK1Sqj/0ZDGjTf1/Ohkv3cnIHOu
        dCF1WkB2T0fsVuApZZbyH6ojKb10d8RmqWHUdogkK9uy/ywFtok5R0nbSaIXtRhP
        eAtNAy8xbZNO6qa7+7OpnBViQsc1q9WuqibWkA4l7jnoYkXYfH/jCJ8eP06nHwoH
        CnwivcnbaiVG1G8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A634B100C73;
        Fri, 21 Jan 2022 16:19:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19709100C72;
        Fri, 21 Jan 2022 16:19:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
References: <YemTGQZ97vAPUPY0@pobox.com>
        <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
        <xmqqee52ghwg.fsf@gitster.g>
        <220121.86iludl4d9.gmgdl@evledraar.gmail.com>
Date:   Fri, 21 Jan 2022 13:19:54 -0800
In-Reply-To: <220121.86iludl4d9.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 21 Jan 2022 12:14:58 +0100")
Message-ID: <xmqqczkkg51h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E18FF3F0-7AFF-11EC-B6C9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> So, unless I hear more convincing arguments (and Todd's example or
>> anything similar that makes "git commit" from that state update a
>> ref outside local branches is *not*), I am hesitant to call the new
>> behaviour and 9081a421a6d a regression.
>
> Well, the user is doing odd things with git, but we should reserve BUG(=
)
> for things that aren't rechable. Any time a user is able to arrange our
> tooling in such a way as to call BUG() is a ... bug.

Yes, I concur.

>> What did the code before that BUG() do when faced with this nonsense
>> configuration?  If forbidding outright broke a sensible workflow
>> that happened to have been "working", I am OK to demote it to
>> warning() and restore the previous behaviour temporarily, whatever
>> it was (I think it was just old_branch_info.name was left unset
>> because we were not on local branch, but I don't know if the missing
>> .name was making any irrecoverable damage).  But the longer term
>> direction should be that we treat the "update HEAD ends up updating
>> some ref outside refs/heads/" a longstanding bug that needs to be
>> fixed.
>
> The behavior with my patch here is exactly the same as before. I.e. it
> was rather straightforward, the xstrdup() is new, but before we'd just
> take the un-skipped string that didn't start with refs/heads/ as-is.

OK, that might have done a wrong thing (instead of dying) for a
strange settings like that, but the change was never about
tightening and detecting such a strangeness but only about plugging
leaks, so reverting that narrow part of the patch is the right thing
to do.

> I agree that it's better to look at this more deeply, but given the rc2
> being out, and this surely being something we want in the final I'd
> think we'd want to keep this patch as-is.

Yes, except for the update in the test.  I do not think we want to
promise what should happen to the _values_ of these refs after the
operation at all.  If it only says "checkout should not exit with
non-zero status", I would be OK.  Promising anything more than that,
I do not think it is a good idea.

For now, I plan to do the "revert the check-and-BUG and nothing
else" change.

Thanks.

