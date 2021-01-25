Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D6C10F09
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE4323121
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbhAZFEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:04:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65338 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbhAYTZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:25:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEC089081C;
        Mon, 25 Jan 2021 14:24:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9b0N5b3ZW/ea
        SE+Jh0LpaHAbfVU=; b=mDMN6zCtSwofRjOSTXRrxgKZdckAFAgc7YFUxJl/TTpP
        xrEONufq4IczythYa/vmz4v3p6m9E8H4RjOvpRx8k1JVcyJG97wR/Y3SfyxFHn1s
        mjPhUTJjonEfWjVvkmIt+TH/RxAK995cDdkNlf2pIQeKBCoPkUW4ZTnQfqe56Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y2R+8u
        /IVSNl/C3ESibPKQLI5LfGIbtZeiGagAYeAJ/6+P7GjLcghFftOcBdV8PbGi4PQR
        qphWENya1yfOtOp/hrNxLkWMjxtrDYEWpLFghFnra2s3ve3rVeGNKoshOT9yuaHR
        M5v/EClhE9gi2FeA0kUYBEv7+yTkQQfjuDe0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4DEF9081B;
        Mon, 25 Jan 2021 14:24:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B9119081A;
        Mon, 25 Jan 2021 14:24:40 -0500 (EST)
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
Date:   Mon, 25 Jan 2021 11:24:39 -0800
In-Reply-To: <20210125073508.l7ksohyfhcogch4x@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 25 Jan 2021 08:35:08
 +0100")
Message-ID: <xmqqpn1syg3s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F844BDEE-5F42-11EB-9FC9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

>> > In preparation for allowing more sophisticated ways to specify commi=
t
>> > ranges, let's refactor the check into its own function.
>>=20
>> I think the sharing between the two makes sense, but the helper
>> function should make it clear in its name that this is "the kind of
>> commit range range-diff wants to take".  Among the commit range "git
>> log" and friends can take, range-diff can take only a subset of it,
>> and only a subset of it is meaningful to range-diff (e.g. HEAD^@ is
>> still a commit range you can give to "git log", but it would not
>> make much sense to give it to range-diff).
>
> Does it make so little sense to forbid passing HEAD^@ as a range to
> range-diff? I can imagine situations where is would make sense, e.g. I
> often create customer patch stacks from a set of topic branches using
> octopus merge. To compare two of these ^@ might be handy.

You can discuss for each individual syntax of a single-token range
and decide which ones are and are not suitable for range-diff, but I
suspect the reason behind this business started with dot-dot is to
perform a superficial "sanity check" at the command line parser
level before passing them to the revision machinery, and having to
deal with potential errors and/or having to compare unreasonably
large segments of history that the user did not intend.

Also I first thought that the command changes the behaviour, given
two tokens, depending on the shape of these two tokens (i.e. when
they satisfy the "is-range?" we are discussing, they are taken as
two ranges to be compared, and otherwise does something else), but
after revisiting the code and "git help range-diff", it always does
one thing when given=20

 (1) one arg: gives a symmetric range and what is to be compared
     is its left and right half,

 (2) two args: each is meant to name a set of commits and these two
     are to be compared) or

 (3) three args: each is meant to name a commit, and the arg1..arg2
     and arg1..arg3 are the ranges to be compared.

so ...

> My POV is that if it's easy to use the same function (and so the same
> set of range descriptors) for git log and git range-diff then do so.
> This yields a consistent behaviour which is IMHO better than preventing
> people to do things that are considered strange today.

... I am OK with that point of view.  It certainly is simpler to
explain to end users.

Having said that, it would make it much harder to implement
efficiently, though.  For example, when your user says

	git range-diff A B

to compare "git log A" (all the way down to the root) and "git log
B" (likewise), you'd certainly optimize the older common part of the
history out, essentially turning it into

	git range-diff A..B B..A

or its moral equivalent

	git range-diff A...B

But you cannot apply such an optimization blindly.  When the user
gives A..B and B..A as two args, you somehow need to notice that=20
you shouldn't rewrite it to "A..B...B..A", and for that, you'd still
need some "parsing" of these args.

So, I dunno.  Limiting the second form to only forms that the
implementation does not have to do such optimization would certainly
make it simpler for Dscho to implement ;-)
