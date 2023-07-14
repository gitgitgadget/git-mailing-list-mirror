Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27954EB64DA
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 06:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjGNGWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 02:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjGNGWc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 02:22:32 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217772D57
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:22:30 -0700 (PDT)
Date:   Fri, 14 Jul 2023 06:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689315747; x=1689574947;
        bh=ClbWmYrl1gTxF2RiXKDuJ/IyC7sbpsQeb9PyUTia/mE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=rAKhY/1/FUXdYroCFARlex883Zc6dRko4k6PEL3ch8Fshgkivd7fKQjekYuaT9jmA
         4pNMB7dmDI8lfiuDIqzt9UEN6WnwoY8q6qaAmSQqdrn4Ow8U+aYu+ZOUCW4b45/IH6
         xfE1rsINVjwJxVGFFTC1UKs552gEPOyAxpYpLxPa+Af0cSpXMK6Hxtq7Nj9Co6NFPf
         Xjf/TegpLJSpYHNXW2g15AyITSwbwrFwMxt0Z9JIvBUYYUvd9wz7HdIwYZOOux3myA
         wbtPzL15W7NokhEM1SzoRCQU4PAzIEDziBV/NLF37tXg7ad6RV14pReSZGSaG55pDP
         A0XtnqfdKvKQg==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: t2400 on freebsd12
Message-ID: <356tacvizwbtwigdkz4byrrzsyjuktcb7cxaibf6wjocffgycp@iwhmszuuvzpl>
In-Reply-To: <xmqqfs5ro8v7.fsf@gitster.g>
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com> <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com> <xmqqfs5ro8v7.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/13 01:27PM, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
> > "D. Ben Knoble" <ben.knoble@gmail.com> wrote:
> > [...]
> >>
> >> Summary output:
> >>
> >> Test Summary Report
> >> -------------------
> >> t2400-worktree-add.sh                            (Wstat: 256 Tests:
> >> 227 Failed: 27)
> >>   Failed tests:  50-52, 91-93, 107-109, 123-125, 139-141
> >>                 159-161, 175-177, 191-193, 207-209
> >>   Non-zero exit status: 1
> >>
> >> Proximate log entry:
> >>
> >> [16:19:43] t2400-worktree-add.sh ..............................
> >> Dubious, test returned 1 (wstat 256, 0x100)
> >> Failed 27/227 subtests
>=20
> [...]
>=20
> Given that the tests seem to randomly fail, I can believe if this is
> due to a flakey test that needs to be fixed, but from what we can
> see in the webpage of Cirrus CI, I cannot even guess what the
> problem is.
>=20
> I do not offhand know how well the FreeBSD port has been maintained,
> or those who have (or had once in the past) stake in it are keeping
> an eye on it.  Anybody?

I wrote these tests[1]. All the tests that are failing are:

- running `git worktree add` without `--orphan` or `--quiet`.
- running in a repo with 1 local branch with a valid commit.
- running in a worktree with an invalid/unborn HEAD.

The resulting code path should be git failing with:

- a warning containing the path to the HEAD file for the worktree=20
  that is in scope and the contents of that HEAD.
- a hint to try using `--orphan`.
- an error `fatal: invalid reference`.

There are other minor variations between all the tests but these are
the commonalities between the tests. No other tests stress that
particular codepath.

My guess is something in `can_use_local_ref()` (`builtin/worktree.c`)=20
is triggering the crash.

>=20
> [...]

1. https://lore.kernel.org/git/20230517214711.12467-1-jacobabel@nullpo.dev/

