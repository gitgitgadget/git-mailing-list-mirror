Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04213C433EF
	for <git@archiver.kernel.org>; Sun,  5 Jun 2022 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345647AbiFEPkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jun 2022 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbiFEPkY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jun 2022 11:40:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172A2FE78
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654443615;
        bh=9sfneGScTy2qbvH0INMoqWYLBTIqiL0LLOTSEvmya64=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JjC8vvpJP6RNHrKneGWk6vN2Y7f3QGv8rpBFZQU8lBhUvOI7fbuXuhsrEPKjcY1zK
         F7VguwV/q7A3Pe9v43Ia41GxF3ixi3Non/L00pUrj4VjsfhJNPDHPYLSsZa3Uvspip
         JR4qRJ6l43634yHdG9oAjxTZZ3uA9PS/yobc72Ys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1nwUVw06nL-0038gz; Sun, 05
 Jun 2022 17:40:15 +0200
Date:   Sun, 5 Jun 2022 17:40:13 +0200 (CEST)
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
In-Reply-To: <nycvar.QRO.7.76.6.2206032359210.349@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2206051733040.349@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
 <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com> <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com> <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet>
 <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com> <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet> <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com> <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet> <CABPp-BHQPrun3xhXBhbBnZ9cAy1sV7_r-kGsQhC-YsRMvoERmw@mail.gmail.com> <nycvar.QRO.7.76.6.2206032359210.349@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gh7FSLjVcHHp7/EBgIkoqqNvpDXD2dQfQer8oxaCvjcBwseULZJ
 kdbggfT/zYHGP6ZIbDfw4outbXMi84Bwhs+NfzubrVfjvQOm1orYqcz+D05JJ6vcQDTeSe8
 e3ENrH4eqOrQZ1BaYe3U14GzSm3VgDWDkMDdhD8cC+MisAQleyfpHr6l2HjCV2JNmLlr8Wz
 w+rqY5EstYBXnqgAvKz0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gZzsosRf+e4=:nXzgkyfrEjCv785O6CqeUf
 mUymyZJXTCy9nNQJzJz3ph7VfxRI9kjW9wGWBHBlmlwp3KACmJY4mqt+FVMyKiMNtgNBKcJXI
 /Q2AvqXGdNG1WmPk04lN2uaELJ3uT6nT5yzp2INTqn6vbwgb9O65LBFjYdqfgy+eDMJl+TIcM
 eXwBNSVMGeCsvFVmlXfYYwP3QNBWxlsHk2FKJhL+E16c/8nCkwednMWjZSXwbYxLVr4yRvdbW
 X87o2e4ZZAqSaYv/3uRoa1M3tJvB//LNdgFA++68KKQ33y5J2eYA07lEeFJoxwRPJwXB6Scwm
 wEibMPCiYRWVOOi80DdHOOGbL6DKbzRv1Cf586LZrhXnrhurMX+Ki2UCV7KDoIL9Jz4eIyifd
 SPMTdboby6Bqil8aN+Yq8NPEdXFXKndyNGxpVCp/155hlMukrNVwpYO9lOPv32uyjRayEnvT7
 7eRZTz9uL6O2KOWfKLeSdyFUp4YOFeNA0pm/AkBsnare9i4rT/WCYziLNfcKmSMEgy/icjUXS
 aTS6nz5s7WWTbSSzM9/0Vv0hSWApxPo1BrNqTFgcCDW7/S+lTTIpDS58PTa424jjwwMMKVKEq
 qsu6Bpt2dVD3G2DatpWqpwOBTgTpuqoage81YSmgOcIR92J3OceFu1OPzVo8/219CapToQ8zW
 WWxqVu6aCu/KyROyAWE9N6svGzRP6mh1KFVpFeHjb0RVkaGAcUmaApZiW5rmOeZ1mgbklvuDs
 e0eJm9e3g1QVmOg0A2/admwPTuxfJssAyetmLnhMmAV4YlKq78hAsZS7rIWwQvLhqHzmZQlJr
 vmjsu/g5mrCsVhGWvk9Bh3SvDmxgCd++9v5eJCcfPN49NnZTU7Y6J1yQH4MOcu5fWlav5fn0M
 HuNbpklvZb7l/TN+WJcH5Ka9iLhYXakHqC8R09eRJhp6pGnzN8cXVRs/KOK+GogRK3y3pvLWJ
 tHLUnw1z5yJX7UrxG8+LjHgVcpncSh8Od25h5hhzMKtz5leb2VjVwYRUW9Exz1+TAdAqpbhVf
 Ek+Idatg9iUsLtLrHhS8T/m/zNAU1j7QaZGxFX/HZ3rCaYCRiasv/JqIQakfC1TOV4WDYytX5
 v3Su68RMXTLrm+s/VgNJBTPNHfE0Mh8+LJQCF8/1N95PL9ljJkdb2k+1g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 4 Jun 2022, Johannes Schindelin wrote:

> On Tue, 17 May 2022, Elijah Newren wrote:
>
> > I think I got a fair amount of this implemented about a month or so
> > ago.  I just pushed up what I have to the wip-for-in-core-merge-tree
> > branch of newren/git.
>
> Thank you so much!
>
> I worked a few hours on this and pushed up my changes under the same
> branch name to dscho/git.

And I worked on it some more, and pushed up the result (which passes the
CI build except for some problem caused by changes outside of Git's source
code) ;-)

> > Some notes:
> >
> >   * A big "WIP" commit that needs to be broken up
>
> I did not yet start on that.

Still no start on that yet.

> >   * The previous "output" member of merge_result, containing a strmap
> > of conflict and informational messages (basically a mapping of
> > filename -> strbuf) now needs to be replaced by a strmap "conflicts",
> > which is now a mapping of primary_filename -> logical_conflicts, and
> > logical_conflicts is an array of logical_conflict, and
> > logical_conflict has a type, array of paths, and message.
> >   * Since "output" is no longer part of merge_result, the new
> > remerge-diff functionality is going to need to be modified since it
> > used that field, and instead iterate on "conflicts" to get the same
> > information
>
> I punted on that for now, recreating an `output`-style strmap and storin=
g
> it as `path_messages` attribute.

I still punted on that because I wanted to see whether I could address the
test suite failures first (narrator's voice: he could).

> >   * I have some FIXME comments in a couple places where I need to
> > figure out how I want to pass the variable number of arguments (in a
> > function already accepting a variable number of arguments for other
> > reasons, making the function in a way have to variable length lists of
> > arguments)
>
> In my WIP fixups, I refactored this into a version that takes varargs an=
d
> another version that takes a string_list.
>
> However, after getting all this to compile and t4301 to pass, I think we
> actually only need a version that takes up to two "other" paths, and a
> version that takes a string_list with those "other" paths, where the
> former constructs a temporary string_list and then calls the latter.

I ended up refactoring the refactor. The `path_msg()` function now takes
the "other paths" in two different forms: it accepts two (optional) `const
char*` parameters and an (also optional) `struct string_list *`. Either of
them, if non-NULL, will be added to the `struct strvec` field.

This looks _slightly_ ugly to me, but from an implementation point is the
cleanest solution.

> >   * The new enums and structs I added to merge-ort.c really have to be
> > added to merge-ort.h and become part of the API.  Feels a little
> > unfortunate since it'll make the API _much_ more involved, but I don't
> > see any other way to solve your usecase.
>
> I agree, but I did not do that yet ;-)
>
> Another thing I noticed is that we can probably ensure consistency betwe=
en
> the `conflict_and_info_types` enum and the `type_short_descriptions` arr=
ay
> by using the same C99 construct we're already using in the
> `advice_setting` array in advice.c:
>
> 	static const char *type_short_descriptions[NB_CONFLICT_TYPES] =3D {
> 		/*** "Simple" conflicts and informational messages ***/
> 		[INFO_AUTO_MERGING] =3D "Auto-merging",
> 		[CONFLICT_CONTENTS] =3D "CONFLICT (contents)",
> 	[...]

Still haven't done that, either, as it is merely syntactic sugar, really,
and not really an interesting change. I think I'll leave that to a time
after I managed to modify the remerge-diff machinery to accept the
new-style `conflicts` map (instead of recreating the old-style `output`
map, as I am doing for now).

> It would be great if you could have a quick look over the commits I
> added on top of your branch, to see whether things make more or less
> sense to you. But if you're too busy elsewhere, I am one of the best
> persons to understand that, too.

Hopefully I will get this into a reviewable shape before you get to
looking at it, so that your time is spent more wisely than what I asked
for ;-)

Ciao,
Dscho
