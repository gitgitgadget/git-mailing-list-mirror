Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C188C0015E
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 19:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjGNTqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjGNTqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 15:46:22 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E80B2D57
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:46:20 -0700 (PDT)
Date:   Fri, 14 Jul 2023 19:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689363978; x=1689623178;
        bh=e0oYKYtIjt8CAfQC8cPm66tb1dlh3zGrXZqukIOMDXc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=rxE96gC4NKS6yfxdI6eadhpANVlVOH2e05MSMen+mJ3avgOfiG+x5XKx/Uj7K0jDO
         yZrOmwo8hcyKOmKVdXsNrpQqV0X9ciAr+oHA3E+R0af3LsNCBNB9UWokWyUk3K05tw
         tYAuNYJfPZT36Mns0CQodX8BmJ2m/FD8YbbKaU6e1bWJ38IZhdrYhYk74rn6yeXpo6
         XQ/sshQy1QNFNzX/GmTAf9G9Q19dJCInuGLvgLf5jX8yvE49k8pFZMgxluHBfDuVsQ
         N2By+cMK5mhxAGBiHvnp3e4Yd5G6jfoj9/wt8ZSf70wL6Cf6i+mRsf7bifjeQtp1W2
         IglVpvA3/obZw==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: t2400 on freebsd12
Message-ID: <zznttv6pkjwtaoboiiz7z77of5pq7vtwk4gm7hkurkbbcnouq3@3c2yhx2tr5yw>
In-Reply-To: <CAPig+cRMXJkrEgyVtC0u2QK=5QNnJOQnXBU_rE+JiGufEYH9sg@mail.gmail.com>
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com> <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com> <xmqqfs5ro8v7.fsf@gitster.g> <356tacvizwbtwigdkz4byrrzsyjuktcb7cxaibf6wjocffgycp@iwhmszuuvzpl> <CAPig+cRMXJkrEgyVtC0u2QK=5QNnJOQnXBU_rE+JiGufEYH9sg@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/14 12:19PM, Eric Sunshine wrote:
> On Fri, Jul 14, 2023 at 2:30=E2=80=AFAM Jacob Abel <jacobabel@nullpo.dev>=
 wrote:
> > On 23/07/13 01:27PM, Junio C Hamano wrote:
> > > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> > > >> t2400-worktree-add.sh                            (Wstat: 256 Tests=
:
> > > >> 227 Failed: 27)
> > > >>   Failed tests:  50-52, 91-93, 107-109, 123-125, 139-141
> > > >>                 159-161, 175-177, 191-193, 207-209
> >>
> > > I do not offhand know how well the FreeBSD port has been maintained,
> > > or those who have (or had once in the past) stake in it are keeping
> > > an eye on it.  Anybody?
> >
> > I wrote these tests[1]. All the tests that are failing are:
> >
> > - running `git worktree add` without `--orphan` or `--quiet`.
> > - running in a repo with 1 local branch with a valid commit.
> > - running in a worktree with an invalid/unborn HEAD.
> >
> > 1. https://lore.kernel.org/git/20230517214711.12467-1-jacobabel@nullpo.=
dev/
>=20
> I haven't been following this thread closely, but I wonder if the
> `grep` introduced by patch [3/8] of the cited patch series is
> problematic:
>=20
>     grep -E "fatal:( options)? .* cannot be used together" actual
>=20
> since BSD lineage regexp (including macOS) historically did not
> support the "?" repetition operator. Perhaps an easy fix would be to
> simplify this to:
>=20
>     grep "cannot be used together" actual

The only tests that use the `?` operator are tests 32-38 which use=20
`test_wt_add_excl()`. Those tests all seem to be consistently passing.

I probably should have mentioned in my original post the exact lines
that were causing the error. Line numbers mentioned below are from the
current head of the master branch (830b4a04c4, 'the tenth batch')

Tests 50-52 are the `test_wt_add_orphan_hint()` tests on lines 428-430
of t2400 (the fn is defined right above them). These were introduced in=20
patch 6/8 [1].

The rest of the tests correspond to the `test_dwim_orphan('warn_bad_head', =
...)`=20
tests on lines 1039-1041 and likewise that function is defined
directly above those lines. These were introduced in patch 8/8 [2]=20
however the bulk of the test code was introduced in the previous=20
patch (7/8) [3].

Of particular note out of the details I gave in my previous post is=20
that these tests all cause the command to emit the bad HEAD warning.=20
I bring this up because in that warning code (patch 8/8 [2]) there=20
is path string manipulation and a file read (both of which could be
stepping on some platform dependent behavior).

1. https://lore.kernel.org/git/20230517214711.12467-7-jacobabel@nullpo.dev/
2. https://lore.kernel.org/git/20230517214711.12467-9-jacobabel@nullpo.dev/
3. https://lore.kernel.org/git/20230517214711.12467-8-jacobabel@nullpo.dev/

