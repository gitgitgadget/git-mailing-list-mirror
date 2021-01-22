Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A2C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF5123B17
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbhAVVOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:14:39 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:32792 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbhAVVNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 16:13:46 -0500
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10MLD4Vb020173
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jan 2021 16:13:04 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10MLD4Vb020173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611349985; bh=BnZ/NGItIDcs+6PwSKHY2gwLQZvt4ja52H8NDcRy+d8=;
        h=Reply-To:From:To:References:In-Reply-To:Subject:Date:From;
        b=mFE0XBkqY9lmBZTozsWNgJSLHhH2a1l5IjaXUF605r/0xnD0Os2Ihplty0tMlex0w
         PFCdQ/BRDaj/oDIu8w9WSLgWVE+Oz6PrWBAd/t0WrGsim/oth0JaJk6AYrYhFqbdLL
         tcBZBhfZjkTD22OTDV7HNuqGqwErpZheWfZw+B/nT+oNaKQPHj3hCSyWFxgUOEApr3
         4HXkQOwIxFGV+PCsmO4I/AwZH1vx3rooDMC65l39hEczwxF5uL4zAMMzdnjdOAeSdI
         a44OPNyR7uhhbhMBSwLUfO4mCA/UhpcPhUIGza9pCliZsZ3LilGdlDqoBOXbGtueDv
         wsOF/hqZmeHSg==
Reply-To: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
          <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        <git@vger.kernel.org>
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us> <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
In-Reply-To: <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
Subject: RE: git archive setting user and group
Date:   Fri, 22 Jan 2021 16:13:15 -0500
Organization: PD Inc
Message-ID: <045801d6f103$664852a0$32d8f7e0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHBx3N2zV0SHJfdC165O07jxI29BQN7dRGLqkKapRA=
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Ren=C3=A9 Scharfe=20
> Sent: Friday, January 22, 2021 4:00 PM
>=20
> Am 22.01.21 um 21:40 schrieb Jason Pyeron:
> >> From: Jason Pyeron
> >> Sent: Friday, January 22, 2021 3:09 PM
> >>
> >> I am about to make a release for logwatch tonight. Historically the =
files are owned by logwatch in
> the
> >> tgz file. When I use git archive it is owned by uid 0, is there an =
option to set the uid/uname,
> >> gid/gname owner of the files?
> >
> > Answer: not at this time, as it is hard coded in the source.
> >
> > archive-tar.c:
> > static void prepare_header(struct archiver_args *args,
> >                            struct ustar_header *header,
> >                            unsigned int mode, unsigned long size)
> > {
> >         xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & =
07777);
> >         xsnprintf(header->size, sizeof(header->size), "%011"PRIoMAX =
, S_ISREG(mode) ?
> (uintmax_t)size : (uintmax_t)0);
> >         xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", =
(unsigned long) args->time);
> >
> >         xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
> >         xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
> >         strlcpy(header->uname, "root", sizeof(header->uname));
> >         strlcpy(header->gname, "root", sizeof(header->gname));
> >
> >
> > meh.
> >
>=20
> Adding support for using a custom user and group should be easy.  Is
> this just a cosmetic thing?  Regular users would ignore the user info =
in

In this case, likely a cosmetic thing.=20

> the archive, and root should not be used for extracting, and on =
systems

But I can think of situations, where it would matter - and I do not =
agree that "root should not be used for extraction".

> that don't have a logwatch user this wouldn't make a difference =
anyway,
> right?

I updated the hard coded values to match what was needed, did a make and =
presto all was happy.

The backend should take:

--group=3DNAME
--group-id=3DGID
--owner=3DNAME
--owner-id=3DUID

Patch wanted?

