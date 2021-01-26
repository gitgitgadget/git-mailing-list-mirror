Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8821BC43331
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663A42067B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbhAZWDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:03:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53618 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390115AbhAZT0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 14:26:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A2979B505;
        Tue, 26 Jan 2021 14:25:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pnsNMlU7zuHL
        pHd7SqgZJbXWj44=; b=codol2r35mUripuA8ut9AX+qv8U154rJBitZrKpWmH2T
        2dzu2QnJsQN4J66pAM17ulEP/RK+cGus1CQb68N65DASrcvfZwuwOz3ZBMOcbKF5
        w56KuUbjGOv4yLLx73uiOk4XhvW848ydU357w9nAIL7KmKsVgk91l1FMrQI8BEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AeaSs4
        9GYNv/BbWY1Qd8C1XM2off4RTgxvOGnIw08mnyWwy+Lx455jQRke+QEdc1JeHAjq
        sMRxdYdgoYn+tMRjSXBx0XHyLc75Lc/8dI3NDxKc8BLJ+Ufzz3J1j5X4sDKxjf7U
        rM1i9JtcBuSukQnuNGZjg7ld99MO2GEkpgLi0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 219F09B503;
        Tue, 26 Jan 2021 14:25:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 942779B502;
        Tue, 26 Jan 2021 14:25:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] range-diff/format-patch: refactor check for
 commit range
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
        <3f21e10f919eead049dc2440a29bb2bed6c99d0d.1611339373.git.gitgitgadget@gmail.com>
        <xmqqzh107m5d.fsf@gitster.c.googlers.com>
        <20210125073508.l7ksohyfhcogch4x@pengutronix.de>
        <xmqqpn1syg3s.fsf@gitster.c.googlers.com>
        <20210125212525.dpnsj7ejngvpkd5y@pengutronix.de>
Date:   Tue, 26 Jan 2021 11:25:11 -0800
In-Reply-To: <20210125212525.dpnsj7ejngvpkd5y@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 25 Jan 2021 22:25:25
 +0100")
Message-ID: <xmqqzh0v1ox4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3690842E-600C-11EB-B46D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

>> > My POV is that if it's easy to use the same function (and so the sam=
e
>> > set of range descriptors) for git log and git range-diff then do so.
>> > This yields a consistent behaviour which is IMHO better than prevent=
ing
>> > people to do things that are considered strange today.
>>=20
>> ... I am OK with that point of view.  It certainly is simpler to
>> explain to end users.
>
> It seems you understood my argument :-)

So it seems ;-).

>> Having said that, it would make it much harder to implement
>> efficiently, though.  For example, when your user says
>>=20
>> 	git range-diff A B
>>=20
>> to compare "git log A" (all the way down to the root) and "git log
>> B" (likewise), you'd certainly optimize the older common part of the
>> history out, essentially turning it into
>>=20
>> 	git range-diff A..B B..A
>>=20
>> or its moral equivalent
>>=20
>> 	git range-diff A...B
>>=20
>> But you cannot apply such an optimization blindly.  When the user
>> gives A..B and B..A as two args, you somehow need to notice that=20
>> you shouldn't rewrite it to "A..B...B..A", and for that, you'd still
>> need some "parsing" of these args.
>
> I agree that for a long history
>
> 	git range-diff A B
>
> is an expensive request and I wouldn't invest too many cycles optimizin=
g
> it.

Well, your devil's advocate can argue that accepting an input that
can easily make the tool unusable would be irresponsible, though.

And there are two possible ways out:

 (1) declare that optimizing "A B" into "A...B" is way too difficult
     to do in general, and find a good enough way to see if A and B
     individually gives a "range" that should be manageable; or

 (2) invest cycles to optimize, so your users do not have to care.

I think the series takes the former approach, and I find it
understandable.

It is a different matter if the way found and implemented in the
patch is "good enough" to tell if a given argument names a
manageable range.  You said something about "rev^{/^here are
two..dots}" that can be mistaken as a "good enough" range, but it
actually names a revision and all the way down to the root.

> (And if I'd optimize it, it wouldn't be done using textual
> combination of the two strings but by checking if the two ranges
> intersect.

Yup, that is in line with what I mumbled earlier about
setup_revisions() and inspecting the rev_info.pending, I think.

>> So, I dunno.  Limiting the second form to only forms that the
>> implementation does not have to do such optimization would certainly
>> make it simpler for Dscho to implement ;-)
>
> I don't want to make it more complicated for Dscho, I'm happy if I can
> in the near future use range-diff with $rev1^! $ref2^! . So feel free t=
o
> ignore me.
>
> Best regards
> Uwe

