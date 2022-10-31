Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8920AFA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJaWb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaWb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:31:26 -0400
Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A864510FC
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
        s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
        Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bUoP2LVTbYKzh7J54G58M3qObYeec2loex/bXuPrFFE=; b=P+TeFRyHc2NsjLqiBe8w+NKz8r
        EP272Q9mTiAafUvUXKH/BgvwSlqNJ/Xir//HTBv9PJ4g825eIlbZuQy17MWpsOHh+psGXPDF0zLL8
        7wDpSfsV1EgzxzB1Zhc6OarTskIouZD4JgVGTAJV912n5ajRZ1icA1RYYw1it4ILiAuI=;
Received: from [2001:470:1d21:0:1b49:e745:2847:2811] (helo=tamla)
        by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95 (FreeBSD))
        (envelope-from <mark@xwax.org>)
        id 1opdJU-00086y-88;
        Mon, 31 Oct 2022 22:31:24 +0000
Received: from localhost (tamla.localdomain [local])
        by tamla.localdomain (OpenSMTPD) with ESMTPA id bfb61e0f;
        Mon, 31 Oct 2022 22:31:23 +0000 (GMT)
Date:   Mon, 31 Oct 2022 22:31:23 +0000 (GMT)
From:   Mark Hills <mark@xwax.org>
To:     Taylor Blau <me@ttaylorr.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: Consist timestamps within a checkout/clone
In-Reply-To: <Y2Ax5XOgSOOcgo8J@nand.local>
Message-ID: <d4db484f-a525-f6db-1bfb-922f788dacd@xwax.org>
References: <2210311614160.25661@stax.localdomain> <221031.86zgdb68p3.gmgdl@evledraar.gmail.com> <Y2Ax5XOgSOOcgo8J@nand.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-603039300-1667255483=:18869"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-603039300-1667255483=:18869
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Oct 2022, Taylor Blau wrote:

> On Mon, Oct 31, 2022 at 09:21:20PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> > I think you're almost certainly running into the parallel checkout,
> > which is new in that revision range. Try tweaking checkout.workers and
> > checkout.thresholdForParallelism (see "man git-config").
> >
> > I can't say without looking at the code/Makefile (and even then, I don'=
t
> > have time to dig here:), but if I had to bet I'd say that your
> > dependencies have probably always been broken with these checked-in
> > files, but they happend to work out if they were checked out in sorted
> > order.
> >
> > And now with the parallel checkout they're not guaranteed to do that, a=
s
> > some workers will "race ahead" and finish in an unpredictable order.
>=20
> Doesn't checkout.thresholdForParallelism only matter when
> checkout.workers !=3D 1?
>=20
> So what you wrote seems like a reasonable explanation, but only if the
> original reporter set checkout.workers to imply the non-sequential
> behavior in the first place.
>=20
> That said...
>=20
>   - I also don't know off-hand of a place where we've defined the order
>     where Git will checkout files in the working copy. So depending on
>     that behavior isn't a safe thing to do.
>=20
>   - Committing build artifacts into your repository is generally
>     discouraged.

If it's undefined and never implemented this is reasonable.

But "generally" is a caveat, so while I agree with the statement it also=20
implies there's valid cases outside of that. Ones which used to work, too.

Here are some useful cases I have seen for the combination of build rule +=
=20
checked in file:

- part of a build requires licensed software that's not always available

- part of the build requires large memory that other builders generally do=
=20
  not have available

- part of the build process uses a different platform or some other system=
=20
  requirement

- to fetch data eg. from a URL, with a record of the URL/automation but=20
  also a copy of the file as a record and for offline use

So it's useful, to retain repeatable automation but not always build from=
=20
square one.

Generally discouraged to check in build results yes, but I've found it=20
very practical.
=20
> So while I'd guess that setting `checkout.workers` back to "1" (if it=20
> wasn't already) will probably restore the existing behavior, counting on=
=20
> that behavior in the first place is wrong.

I think perhaps the tail is wagging the dog here, though.

It's 'wrong' because it doesn't work; but I haven't seen anything to make=
=20
me think this is fundamentally or theoretically flawed.

If we had a transactional file system we'd reasonably expect a checkout to=
=20
be an atomic operation -- same timestamp on the files created in that=20
step. A discrepancy in timestamps would be considered incorrect; it would=
=20
imply an 'order' to the checkout which, as you say, is order-less.

Sowhat could be the bad outcomes if Git created files stamped with the=20
point in time of the "git checkout"?

> Thanks,
> Taylor
>=20
>=20

--=20
Mark
--0-603039300-1667255483=:18869--
