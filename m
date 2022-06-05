Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B3C433EF
	for <git@archiver.kernel.org>; Sun,  5 Jun 2022 22:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348496AbiFEWmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jun 2022 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiFEWmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jun 2022 18:42:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ADEC0E
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654468923;
        bh=CBh/PBptcnHzLUbWI1A7QT23j9HbSW7G3JMGiEWCdUc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I36GppiznudUlmpuggbaZRhZGeaFSe67WQZgqdm7Vxg7J5CrvGhLnsduTkQ3GgcIa
         m2a3fVZR4Zk4WslGzsP++S0Z7TDTbkJ9aJgL/4i+ymPjMbqsO0B0x2IjEUb07g4aN2
         43KXgUyUu2VmyuA7Tj6Lc9hSzA1342E+AsKety/k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1nZhp425qz-00xtkx; Mon, 06
 Jun 2022 00:42:03 +0200
Date:   Mon, 6 Jun 2022 00:42:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <nycvar.QRO.7.76.6.2206051733040.349@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2206060019510.349@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
 <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com> <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com> <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet>
 <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com> <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet> <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com> <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet> <CABPp-BHQPrun3xhXBhbBnZ9cAy1sV7_r-kGsQhC-YsRMvoERmw@mail.gmail.com> <nycvar.QRO.7.76.6.2206032359210.349@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2206051733040.349@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QCyEzNwstdTkcNkD1G25KNEl/y5EjFIjANR+XxLiveuMaMak1bG
 EC5J2nVomcqvdqe0dKCg2ykgr3G7vpFfCdrITGCbpLJzJZKIIf6vdsZIbr8VrZ2PtF3uL+p
 YGk1qKmQTNXmvpuT48jQiqcevtsfz7rzvyy3nKRYpdQtEJKuND/FwmRPiXeNeHFY/aFb7E0
 NhwIXR4155PF7b4rGiBsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tJ/I/n6YSCs=:YtacDzxF/zMXhbEypsNgT8
 l96HPJo7xY/EH/4lgxrSRa5Mh5FmpM5RUJ/HRSZSKurVuu0cUY/fWaNz1NFBdonGoKtvdHKVT
 LM7lGa4ksTJUQZKGFOuSU/xNMSOzHfXJZDFCJ/hU0hFZ7NvcMVNk3xhLxHloSp8vj47ega4ug
 Qi3Po2HzdHKhi/HKO5O41jI8eO/QQNIM5S2ZoRJBsFB1J5nJHamMDrpNDqPmf7ImgBVjodE3E
 iKzwF1HU0X+PLZLmuvZvxb8pL1ensetuSn4C3aJwQH4Ea5IWqtSQaomzotzLAqlCzqqbjOusr
 DyEqaxyFYghf+KTYdBcX5NcUC1Vj4wOYOrfWRDKwZxXDaadGOc2Gxs8oVng3vM9SvAi/xK7oJ
 Nnqjg9AucIhDRP2OWi6uTccrXxUkpt3rApshZzERN5ew8VGCilf7FyxopjvUfOEKToYRJedYy
 DQnMWgFo21VkYrG/V+Z/7F3GqPBNRUDAhvtJmtZwWAz80cL6GJEjcpKThz+fpLTHb0IusfhDU
 xoEBtuK13iS5sR3wdImJYjKg1Wrc1rWhq8iaeaxo2dwwrxHpS9ufXJrPgRzh5sfexkEn64IRw
 /Ce70/EjyzTaoHXqvICLVUiYCbBYhT9xvXg9/APqEjOouNXHIpU04kgqjA7qQnFbvEjwXvujc
 GOiEIyWKcU531gGqazhOHBEQ2JnQ5oCs/kxT0jrKv/L5kF2evx8bFSto4CmTrDo5wyl5dzd+p
 DeqRfjEAxLdy5/ui0Va/HxEE1ufh3V3ChtnhUe9k4O55wltI0vp2dX+WEXaf8uJM/23Sx65mD
 /MT4vFIXj3GLMhBRKJ28j4TC5gnIVeKZUE722JcnsnXvBuwhaJ0D57X5GL+AwUN1Kv9Ma2ndQ
 3WMN/2juvQhIMEnz2n+fBXVuF6r15FideBXS3NMJWCJmp0b/0v4lysWwNAPtvaskhKDPxLaGp
 LIM6xLSBABaw/laSBv177zft4HStM21JbfuYMVPGYP/uw6LAxGBVZZTlzLYSiLvx8OPzgQoG7
 9euEZ4ymMlhHIjnYCh0xU51hwzNy9RtAUwjBS5nJ/y5AhenEScBTkQDuHK4SpYVbpxzwSR4vj
 OwI67f1Pmu7+C4CaIKCR0EeH9Hob1MllqXROkJd5htJ8Cn1e7nETze8ygsSJMp0rEgLc2oiGd
 xuopk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

[sorry for sending this flurry of mails, I just wasn't sure how
consecutively I could work on the `merge-tree` patches, and therefore sent
mails whenever I had to take a break in case I wouldn't be able to get
back to this project for a couple of days.]

On Sun, 5 Jun 2022, Johannes Schindelin wrote:

> On Sat, 4 Jun 2022, Johannes Schindelin wrote:
>
> > On Tue, 17 May 2022, Elijah Newren wrote:
> >
> > > * The previous "output" member of merge_result, containing a strmap
> > > of conflict and informational messages (basically a mapping of
> > > filename -> strbuf) now needs to be replaced by a strmap
> > > "conflicts", which is now a mapping of primary_filename ->
> > > logical_conflicts, and logical_conflicts is an array of
> > > logical_conflict, and logical_conflict has a type, array of paths,
> > > and message.

I massaged this a bit further: since we no longer actually need a `strbuf`
there (we no longer append to the `strbuf` but instead to the list of
logical conflicts), I replaced `struct logical_conflicts` with a
`string_list` where each item contains the conflict message and its `util`
points to a `struct logical_merge_info` that contains the `type` and the
involved paths.

This lets me...

> > >   * Since "output" is no longer part of merge_result, the new
> > > remerge-diff functionality is going to need to be modified since it
> > > used that field, and instead iterate on "conflicts" to get the same
> > > information
> >
> > I punted on that for now, recreating an `output`-style strmap and stor=
ing
> > it as `path_messages` attribute.
>
> I still punted on that because I wanted to see whether I could address t=
he
> test suite failures first (narrator's voice: he could).

... address this issue without resorting to declaring the `logical_merge`
struct in `merge-ort.h` (which would get a bit messy, not only because we
would have to `#include <strvec.h>` in that header because that struct
contains a `struct strvec paths` and therefore must know the storage size
of `strvec`, but also because `merge-ort.h` is not included in `diff.c`,
and it would be a bit iffy to do that).

Since the per-path conflicts are now stored as a `string_list`, and since
we only need the messages in remerge, we can continue to simply pass the
pointer to `strmap conflicts` to the remerge machinery (in the common
case, if pathspecs are involved, we continue to lightly copy-filter that
`strmap`).

> > >   * The new enums and structs I added to merge-ort.c really have to =
be
> > > added to merge-ort.h and become part of the API.  Feels a little
> > > unfortunate since it'll make the API _much_ more involved, but I don=
't
> > > see any other way to solve your usecase.
> >
> > I agree, but I did not do that yet ;-)

As mentioned above, I think the better way is to _not_ declare that enum
and structs in `merge-ort.h` and instead store the per-path conflicts as a
`string_list` whose strings contain the conflict message and whose `util`
contains the type and the list of involved paths.

This simplifies the API rather dramatically, since the current user
(remerge) is only interested in the conflict message, but not in the type
nor in the full list of involved paths.

Should we ever need to access the type or the paths outside of
`merge-ort.c`, it is easy enough to add a simple function to access that
information via the `string_list`'s `util`.

> > Another thing I noticed is that we can probably ensure consistency bet=
ween
> > the `conflict_and_info_types` enum and the `type_short_descriptions` a=
rray
> > by using the same C99 construct we're already using in the
> > `advice_setting` array in advice.c:
> >
> > 	static const char *type_short_descriptions[NB_CONFLICT_TYPES] =3D {
> > 		/*** "Simple" conflicts and informational messages ***/
> > 		[INFO_AUTO_MERGING] =3D "Auto-merging",
> > 		[CONFLICT_CONTENTS] =3D "CONFLICT (contents)",
> > 	[...]
>
> Still haven't done that, either, as it is merely syntactic sugar, really=
,
> and not really an interesting change. I think I'll leave that to a time
> after I managed to modify the remerge-diff machinery to accept the
> new-style `conflicts` map (instead of recreating the old-style `output`
> map, as I am doing for now).

Since I addressed that `output` issue, I now also C99-ified the
`type_short_descriptions` array.

> > It would be great if you could have a quick look over the commits I
> > added on top of your branch, to see whether things make more or less
> > sense to you. But if you're too busy elsewhere, I am one of the best
> > persons to understand that, too.
>
> Hopefully I will get this into a reviewable shape before you get to
> looking at it, so that your time is spent more wisely than what I asked
> for ;-)

I hope to find some time to work on this more tomorrow; If not, I will get
back to the project on Wednesday and push it further.

Ciao,
Dscho
