Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247ABEB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 10:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjFWKCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjFWKCU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 06:02:20 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE872736
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 03:02:09 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:f15:0:640:e80a:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 102005EAB8;
        Fri, 23 Jun 2023 13:02:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 42EnZPWDROs0-Lg5xDb6c;
        Fri, 23 Jun 2023 13:02:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687514524;
        bh=gXCJaJpwLf8c+wZ7NLu4+detKOHFSB8B2/nWtrL1DjM=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=QfPLQnaAXlbD3ppm0pra1IAG2DKiHS6pOQD//GbkAcae96z3t0jANISiOZ6P2ab2L
         AwMHvSnMy3oZUjPNdDY1ezWOOpmRt+lT4lwqDzXISfbdsa/rvqvAIkLoXcthuiRQEH
         J3LDY6EQxPB17CQIXA/AliWJzwT6PnJLmZvWmcFc=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0610eb14b9ebafd531d9e952e135171267479c66.camel@yandex.ru>
Subject: Re: Getting path to a file from arbitrary project directory
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Date:   Fri, 23 Jun 2023 13:02:04 +0300
In-Reply-To: <20230623094525.GA4204@szeder.dev>
References: <21c8396c1441dd4f74cd2097ac970a2033b81da4.camel@yandex.ru>
         <20230623094525.GA4204@szeder.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much, works for me!

On Fri, 2023-06-23 at 11:45 +0200, SZEDER G=C3=A1bor wrote:
> On Fri, Jun 23, 2023 at 11:52:58AM +0300, Konstantin Kharlamov wrote:
> > (please keep me CC'ed, I'm not subscribed)
> >=20
> > Hello! I'm trying to solve a simple problem: while I am inside an arbit=
rary
> > project directory, I want to get a path to a file `filename.c` located
> > elsewhere in the same project.=C2=B9
> >=20
> > One way to implement that is with a command chain:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cd $(git rev-parse --sh=
ow-toplevel) && git ls-files --full-name --
> > "*filename.c"
> >=20
> > But it is pretty clunky, because that requires you to modify state (cha=
nging
> > current directory). It may not matter though, but I'm just wondering if
> > there's a better way to do that, something like `git ls-files --top -- =
=E2=80=A6`,
> > or anything like that? Haven't found nothing similar in `man git-ls-fil=
es`.
>=20
> When a command expects pathspecs as arguments, then in general the
> leading ':/' magic means the root of the working tree (not sure where
> it is documented, though), i.e. you could try this:
>=20
> =C2=A0 git ls-files --full-name ':/*filename.c'
>=20
>=20
> > As a separate note, this doesn't work:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ls-files --full-name --=
 $(git rev-parse --show-
> > toplevel)"*filename.c"
> >=20
> > 1: the usecase is I have a Emacs helper function to pick up a an aribtr=
arily
> > mangled path to a file in the project from the primary clipboard and op=
en
> > that file. It's often "mangled", because gdb prints it with `../`, then=
 logs
> > print no path whatsoever, just a filename=E2=80=A6 So it's generally us=
eful to have.

