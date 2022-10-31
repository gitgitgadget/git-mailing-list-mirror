Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E64CFA3744
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJaW3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJaW3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:29:20 -0400
Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE126FE
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
        s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
        Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oE+0GlvZWF5qa2IHUZw58QwgRQmWUdSDhVeEM+a1LmQ=; b=vbMfaBywmEUEbncSzTesIaZ0an
        iCJXmB/WsmZ39YO1uG+ZGBVrl9ID/R9jjHLxmEYfgvrFWJttl5ui5Rfx1WPkRNisgsmqoI+CAKRUa
        YNkMwLAbsJ2AJXeyDgSrjgZMXv7xLMQvEStvkuXzpnT2tOCT1uXbX8hljwUF69DuzcAM=;
Received: from [2001:470:1d21:0:1b49:e745:2847:2811] (helo=tamla)
        by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95 (FreeBSD))
        (envelope-from <mark@xwax.org>)
        id 1opdHF-0002Al-5T;
        Mon, 31 Oct 2022 22:29:05 +0000
Received: from localhost (tamla.localdomain [local])
        by tamla.localdomain (OpenSMTPD) with ESMTPA id a9688f5b;
        Mon, 31 Oct 2022 22:29:04 +0000 (GMT)
Date:   Mon, 31 Oct 2022 22:29:04 +0000 (GMT)
From:   Mark Hills <mark@xwax.org>
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: Consist timestamps within a checkout/clone
In-Reply-To: <221031.86zgdb68p3.gmgdl@evledraar.gmail.com>
Message-ID: <a87ebafd-c83-7a1d-d8d2-953bc9a93184@xwax.org>
References: <2210311614160.25661@stax.localdomain> <221031.86zgdb68p3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1889463661-1667255344=:17252"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1889463661-1667255344=:17252
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Oct 2022, =C6var Arnfj=F6r=F0 Bjarmason wrote:

>=20
> On Mon, Oct 31 2022, Mark Hills wrote:
>=20
> > Our use case: we commit some compiled objects to the repo, where compil=
ing=20
> > is either slow or requires software which is not always available.
> >
> > Since upgrading Git 2.26.3 -> 2.32.4 (as part of Alpine Linux OS upgrad=
e)=20
> > we are noticing a change in build behaviour.
> >
> > Now, after a "git clone" we find the Makefile intermittently attempting=
=20
> > (and failing) some builds that are not intended.
> >
> > Indeed, Make is acting reasonably as the source file is sometimes=20
> > marginally newer than the destination (both checked out by Git), exampl=
e=20
> > below.
> >
> > I've never had to consider consistency timestamps within a Git checkout=
=20
> > until now.
> >
> > It's entirely possible there's _never_ a guarantee of consistency here.
> >
> > But then something has certainly changed in practice, as this fault has=
=20
> > gone from never happening to now every couple of days.
> >
> > Imaginging I can't be the first person to encounter this, I searched fo=
r=20
> > existing threads or docs, but overwhemingly the results were question o=
f=20
> > Git tracking the timestamps (as part of the commit) which this is not;=
=20
> > it's consistency within one checkout.
> >
> > $ git clone --depth 1 file:///path/to/repo.git
> >
> > $ stat winner.jpeg
> >   File: winner.jpeg
> >   Size: 258243          Blocks: 520        IO Block: 4096   regular fil=
e
> > Device: fd07h/64775d    Inode: 33696       Links: 1
> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier=
)
> > Access: 2022-10-31 16:05:17.756858496 +0000
> > Modify: 2022-10-31 16:05:17.756858496 +0000
> > Change: 2022-10-31 16:05:17.756858496 +0000
> >  Birth: -
> >
> > $ stat winner.svg
> >   File: winner.svg
> >   Size: 52685           Blocks: 112        IO Block: 4096   regular fil=
e
> > Device: fd07h/64775d    Inode: 33697       Links: 1
> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier=
)
> > Access: 2022-10-31 16:05:17.766859030 +0000
> > Modify: 2022-10-31 16:05:17.766859030 +0000
> > Change: 2022-10-31 16:05:17.766859030 +0000
> >  Birth: -
> >
> > Elsewhere in the repository, it's clear the timestamps are not consiste=
nt:
> >
> > $ stat Makefile
> >   File: Makefile
> >   Size: 8369            Blocks: 24         IO Block: 4096   regular fil=
e
> > Device: fd07h/64775d    Inode: 33655       Links: 1
> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier=
)
> > Access: 2022-10-31 16:05:51.628660212 +0000
> > Modify: 2022-10-31 16:05:17.746857963 +0000
> > Change: 2022-10-31 16:05:17.746857963 +0000
> >  Birth: -
>=20
> I think you're almost certainly running into the parallel checkout,
> which is new in that revision range. Try tweaking checkout.workers and
> checkout.thresholdForParallelism (see "man git-config").

Thanks, it will be interesting to try this and I'll report back.
=20
> I can't say without looking at the code/Makefile (and even then, I don't
> have time to dig here:), but if I had to bet I'd say that your
> dependencies have probably always been broken with these checked-in
> files, but they happend to work out if they were checked out in sorted
> order.
>
> And now with the parallel checkout they're not guaranteed to do that, as
> some workers will "race ahead" and finish in an unpredictable order.

These are very simple Makefile rules, I don't think these dependencies are=
=20
broken; but your theory is in good alignment with the observed behaviour.

For example, the rule from the recent case above is:

  %.jpeg:         %.png
                  convert $< $(IMFLAGS) $@

  %.png:          %.svg
                  inkscape --export-type=3Dpng --export-filename=3D$@ $<

As you suggest, perhaps the Git implementation previously ran checked out=
=20
in some kind of time order then this happens to fulfil a useful behaviour.

Specificaly with build artefacts. These are likely to have been added to=20
the repo after the source file. This could have been providing some=20
pratical and useful tendency of ordering.

> But that's all just a guess, perhaps it has nothing to do with parallel
> checkout, such dependency issues are sensitive to all sorts of other
> things, e.g. maybe git got slightly faster (or slower), so now files
> that were always on different seconds (or the same) aren't in the state
> they were in before...

Hopefully I'll get to some experiments to narrow this down.

Thanks

--=20
Mark
--0-1889463661-1667255344=:17252--
