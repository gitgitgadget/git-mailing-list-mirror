Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C26C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 09:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FAF60233
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 09:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCVJep (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 05:34:45 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:41790 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCVJeT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 05:34:19 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp1-g21.free.fr (Postfix) with ESMTP id 1278FB00571;
        Mon, 22 Mar 2021 10:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1616405628;
        bh=rTIST2q5UQipnmJJGZaA7J1yCiPwHyus1iSRmP5ZMpA=;
        h=Date:From:To:Cc:In-Reply-To:Subject:From;
        b=KgxmG3eLFpfM5oboaxclxLjnUV4OS4BKnGOm+wd7dGjyq/lE92HzIHzuUZ8WiTY7e
         XkUlR/VmDYiPgCBmCvKffvz7wmGgEv9MDlARIKbl4huL8yAkHcAh9xnt+BU9MWHhGk
         OGPs9y65NEAWA01ltJAISBbOcqLtVSZIdvkggqVjSeLsWWrib4nwmp95RVOMKHa/WI
         XEYeu3uwDmXy+R8DGDOk8qvbgjxiAaOejGsZPHdLqGeStsZjDrE54ANoBrZw8EosHf
         /nw/JYPYEfrhcuRqD0WYpVqKZGSeoJJlXBpfgPMHP9b7sGVuKS52FLZhp5RNiATdUm
         FrlJiMCYAnyLQ==
Date:   Mon, 22 Mar 2021 10:33:48 +0100 (CET)
From:   ydirson@free.fr
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Message-ID: <529810619.466659941.1616405628030.JavaMail.root@zimbra39-e7>
In-Reply-To: <CAP8UFD3r+kJTxYCvaToyQXO59PNJiZOfOFwUz7FzTfs=hMuHWQ@mail.gmail.com>
Subject: Re: [RFC] git-rebase-rewind, nested rebases, remembering stgit
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

> De: "Christian Couder" <christian.couder@gmail.com>
> =C3=80: "Yann Dirson" <ydirson@free.fr>
> Cc: "git" <git@vger.kernel.org>
> Envoy=C3=A9: Lundi 22 Mars 2021 09:49:23
> Objet: Re: [RFC] git-rebase-rewind, nested rebases, remembering stgit
>=20
> Hi Yann,
>=20
> Nice to hear from you on the list!
>=20
> On Sat, Mar 13, 2021 at 5:45 PM <ydirson@free.fr> wrote:
> >
> > Hello there,
> >
> > I often find myself doing iterative refactorings, which can lead to
> > long branches, and while rebasing to edit HEAD~10 realize that I
> > first
> > need to edit HEAD~20 or to add more commits below that stack.
> >
> > If you've used stgit when it was a thing, you probably see how it
> > helped doing that.  While git-rebase has grown to do much more than
> > stgit in most areas, this is still one area where with a pain point
> > for me.
> >
> > Here is a small git-rebase-rewind script I've been using for a few
> > weeks,
> > starting with my most common use-case: automate worklow "edit
> > git-rebase-todo
> > to prepend 'pick' commands for the N previous commits, then reset
> > --hard HEAD~N".
> >
> > As you will see from the new needs revealed by using this script
> > (see in the
> > script header), I believe it would be valuable to integrate such a
> > mechanism
> > directly into git-rebase.  Notably, "git rebase -i" itself can be
> > seen as a
> > form of rewind, and this rewind feature would benefit from all the
> > interactive
> > rebase work.
> >
> > Does that sound like reasonable premises ?
>=20
> Sorry for the late answer. It sounds reasonable to me.
>=20
> It looks to me like a way to restart the whole interactive rebase
> process though, so I wonder if calling it "--restart" would be better
> than "--rewind".

Right, it is indeed like doing another interactive rebase while the
current one is not finished.  Maybe just running "rebase -i" without
more option could be sufficient ?  That could break the expectation
when someone relies on rebase refusing to proceed while already rebasing,
though it could be mitigated if a "rebase --abort" just aborts the
most recent rebase.

There are quite a few UI issues to be thought through around here :)


