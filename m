Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41EAC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D8564DEC
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBPBat (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 20:30:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61029 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhBPBat (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 20:30:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E56A7110B4B;
        Mon, 15 Feb 2021 20:30:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DkWHx86IHYBX
        LdI9HXyUQc+WF4k=; b=CsyeBTvGpqs/PGOaBBB0mIlHbWCsB6eraaVSY+raz+cm
        OZuX09yIQaSQBbwQEF0IFQtityk57iOGgb2U2s7l4+sG3gEH4zgBH6hq/ZmR+mdX
        Y7aw6tsYX2Sf824qBOnpuQPFwICCOWnWLVtFE6xHzKigRnkTPXUJoD/oOk12iag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QkzoEG
        SGDpzTeEieAZ9I6DWXBLlAnkka/l6iUiU3423yBffUnZ/Ji+cYfEWOoZKoV1Sd4Q
        +lIt3NIsrs81QLcrqBFN4AmvNmh4uMD62o6Y98P1D3BS9YStqc60H4gTDOe2s200
        3Vn0fB5SYyeB7eJQwRSPYLNTYlCkRZ2ch/ik8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDA45110B4A;
        Mon, 15 Feb 2021 20:30:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5EC8110B42;
        Mon, 15 Feb 2021 20:30:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diff: do not display hunk context under -W
References: <20210215154427.32693-1-avarab@gmail.com>
        <20210215155020.2804-2-avarab@gmail.com>
Date:   Mon, 15 Feb 2021 17:30:00 -0800
In-Reply-To: <20210215155020.2804-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 15 Feb 2021 16:50:19 +0100")
Message-ID: <xmqq7dn8u7dz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7DD87748-6FF6-11EB-99C0-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The long-standing semantics of how -W works and interacts with -U<n>
> are rather easy to reason about:
>
>  * -W extends the context line up to the start of the function. With
>     userdiff this means the language-aware regex rules in userdiff.c,
>     or user-supplied rules.

OK.

>  * -U<n>, which defaults to -U3 shows at least <n> lines of context,
>     if that's greater than what we'd extend the context to under -W
>     then -U<n> wins.

Sorry, but I cannot quite guess what you mean here.  Do you mean:

    We first go back <n> lines due to -U<n>.  If we have not found a
    function header line that comes before the first changed line
    within that <n> lines, we keep going back to satisfy -W (i.e. -W
    "wins" if "-U<n>" is small).  On the other hand, after going
    back <n> lines, if we have already seen a function header before
    the first changed line within these <n> lines, there is no need
    to go back further to satisfy -W (i.e. -U<n> "wins" and makes -W
    irrelevant).

If that is the case, I think I understand it.

>  * When showing the hunk context we look up from the first line we
>    show of the diff, and find whatever looks like useful context above
>    that line.

Yes.

> Thus in e.g. the xdiff/xemit.c change being made in this commit we'll
> correctly show "xdl_emit_diff()" in the hunk context under default
> diff settings.
>
> But if we viewed it with the -W option we'd show "is_empty_rec()",
> because we'd first find the "xdl_emit_diff()" context line, extend the
> diff to that, and then would go look for context to show again.

Makes sense.  As long as we apply this when "-W wins", i.e we extend
the precontext so that the hunk begins on the line that match the
function header pattern, there isn't much point in showing only the
name of the function that comes before this hunk.

On the other hand, if "-U<n> won", i.e. the first precontext line
that is shown in the hunk is _before_ the line -W chose to extend
the hunk to (in this case, where xdl_emit_diff begins) because -U<n>
gave a large enough number, I do want to see the name of the fuction
I am looking at the tail of in the precontext on the hunk header
line.  E.g. "git diff -W -U120 xdiff/xemit.c" on this patch should
show is_empty_rec() as the hunk header.

> This new behavior does give us the edge case that if we e.g. view the
> diff here with "-U150 -W" we'd previously extend the context to the
> middle of the "is_func_rec()" function, and show that function in the
> hunk context. Now we'll show nothing.

To me, that sounds like a grave regression.  Why lose the
information?

This may be coming from the difference between us, i.e. I read a lot
more patches written by other people than my own changes written for
my next commit, so every bit of hint helps, and the name of the
function I am seeing its latter half in the precontext is sometimes
a useful thing to see.
