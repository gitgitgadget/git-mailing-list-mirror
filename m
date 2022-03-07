Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72E9C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbiCGQ2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiCGQ2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:28:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5BB4EF77
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646670470;
        bh=dFNWfLQxr7JT/641NiSh4KocmXjgCZ3vWqS0ew4+ZHU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eO76AWwRXZFWuV63XcSHfvvgnWo4f09hgjZ1d9eXGW1hGoMSSMAVSSwVSgmXQ2PoZ
         zRjKi71sFmJh9U7JgUDQfvAsR2OJMSTiLAQ5bxdVZlQeND6U+HnEdhy1tbI5StAPvw
         cT/VAwVI7lVGhE/4VPPJscBs9xJdEHp8v+JHoWZ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1oCAF941bS-015n20; Mon, 07
 Mar 2022 17:27:50 +0100
Date:   Mon, 7 Mar 2022 17:27:48 +0100 (CET)
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
In-Reply-To: <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com> <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YZPQaYnoNiTuTvNprsDk4U0+hPCOQdXbQkpqOdmjtQ+U0ZjXj/k
 ftlhCL6tF9dU1WfAH7C4WR3184ZEKb9ZfvK9Tes7V2qqaQMZoqN5E3pgp34DhzkMAs5wWWy
 EQTgaXYoohmnN/cxjHAHmimSbDamnPphoiL4CQgbj4QhmS7vz7HNieRZnWD1vAlwvK1713t
 PD0fy1FRANHjivLOn7+bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3w7JW/wy0kY=:uNLPhER9rn18TFYx5d4l8r
 psPTscUfEMAjg8xNLuhcqPqzwshV6OOabNP6hytXeP9YAeRK/yOIXdsxP4SlrXbQNOTiZnYkf
 BH3u8ZMxnY34bEda89O/kkTVxLM2w1WkEPv9xLp7LupqAADNIrqBhpnNnoNHxEUbpfhpVlxQg
 7ivQ1eD0sF+I/wHLRQCXtVh2hv1oPQ+9Ngw585oCPt/yP8gyT8jfoiVDtdY1goUckEedNYFSy
 OmI3CGYL1XiyynI6G8b7eSzC21Y8tjechlOl+Zt75h2CrdYXt4/X1cJB6auYbz2jTxYRyE5+k
 6WaBq38A3b9G1GROB/NfW6Yipu9InArjmIOFxgThmoCUBNRAaoEKtUg10NnspC5g4In/OwAYG
 NsxY7/MeD/keovQQT+8jtZnnKPvWscJHsCLL9mIyil4l5nr2yOIEe7pdWUTc9ao7R7usned30
 pQ0I+G4/84B2EaF3VRzLUUVR7l2uH1LFrue3AfRJt7VwABJ1eRfcGOKavrkTsA9NzG0eLagc8
 NJJ36am6thNO8ailz1q3gSGjW+4e+TLDePDRH8YZMS7ZZyZ/msJCS53eEBu+ifaXMxbBvE2f6
 TBk0GsKYClVMu9P1m9Rm0CrPB1IZrVkCk4oFdSgYCAJsGEitP2s/60rjK6FbOQuJsIxlPZkOl
 G4gca3/4e9L+UDxXKFkMoyQ0ERPa/3cHAooZICJyd5flO7Ku4CsCzXGbGmMqQWIncpzlDZaHx
 VeKLN4q7CrWNmxLJ6e/8orDIDUE6Y36yKt7QQA4Oil99cFQz0foCtstmPXroPJqFsbk+Fw2PG
 zysqq8PP2b1uC/Kcp5v+6u1/cPjNou1VoqtXMAuMqA3IH/ynqKsYOiW4t2GfrJQjHyAqihQA9
 EJv9Cn5t8VGqtsaqGWy8hQ79An64fJfnPRLzofusEK5OoQagTdGrjxyyM75GFKSKtkfW1vYfk
 AhnJc2dpdkcXOg7nosQG81lWbsrlgiiH42HM0NY/5Kbmp8Dbjn+M0xhl9R0g9zcbCabVtmH3Y
 WKRw6ebN476lfJ5B+pjXldwhMFYjer0qOgnaFRLIRNo4yte1AkLACDVr/LOCoHZy54mUrZL03
 /QuWRjsLDQ85V8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 25 Feb 2022, Elijah Newren wrote:

> On Fri, Feb 25, 2022 at 8:31 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 22 Feb 2022, Elijah Newren wrote:
> >
> > > On Mon, Feb 21, 2022 at 2:46 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > Concretely: while I am not currently aware of any web UI that allo=
ws
> > > > to resolve simple rename/rename conflicts, it is easily conceivabl=
e
> > > > how to implement such a thing. When that happens, we will need to =
be
> > > > able to teach the server-side code to discern between the cases th=
at
> > > > can be handled in the web UI (trivial merge conflicts, trivial
> > > > rename/rename conflicts) as compared to scenarios where the confli=
cts
> > > > are just too complex.
> > >
> > > Um, I'm really worried about attempting to make the conflict notices
> > > machine parseable.  I don't like that idea at all, and I even tried =
to
> > > rule that out already with my wording:
> > > """
> > > In all cases, the
> > > <Informational messages> section has the necessary info, though it i=
s
> > > not designed to be machine parseable.
> > > """
> > > though maybe I should have been even more explicit.  The restriction=
s
> > > that those messages be stable is too rigid, I think.  I also think
> > > they're a poor way to communicate information to a higher level tool=
.
> > > I would much rather us add some kind of additional return data
> > > structures from merge ort and use them if we want extra info.
> >
> > Okay.
> >
> > I thought that we could keep the `CONFLICT (<type>)` constant enough t=
o
> > serve as such a machine-parseable thing.
>
> That _probably_ is, but I thought you wanted to parse all N paths
> embedded in the message after that part as well?

Actually, no, sorry for being unclear. My main aim with the
machine-parseable messages was to detect whether a given failed merge
contains _only_ conflicts of the sort that a particular UI can handle.

In that respect, I would not even need to parse the file names, I'd just
require them not to contain line feed characters ;-)

> > And then presenting
> > `<path>NUL<message>NUL` could have served my use case well...
>
> Would it?  Wouldn't you need something more like
>
> <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-des=
cription>NUL<message>NUL
>  ?

Probably, you're right.

> I mean, if rename/rename is what you want to handle, there are three
> paths in that message.  And you need to know all three paths in order
> to combine the relevant parts of the <Conflicted File Info> section
> together.
>
> (Also, while we're at it, I decided to throw a stable short-type
> description string (e.g. "CONFLICT (rename/rename)") in there, which
> will _probably_ be the first part of the message string but still
> allow us to change the message string later if we want.)

Yes, I very much like that idea to keep the prefix in a format that we can
guarantee to be stable enough for applications (or server backends) to
rely on.

> Also, we'd want those parsing this information to keep in mind that:
>   * Any given conflict can affect multiple paths
>   * Any path can be part of multiple conflicts
>   * (The above two items imply a potentially many-to-many relationship
> between paths and conflicts)
>   * Paths listed in these logical conflicts may not correspond to a
> file in the index (they could be a directory, or file that was in a
> previous version)
>   * Some of these "logical conflicts" are not actually conflicts but
> just notices (e.g. "auto-merging" or "submodule updated" or "WARNING"
> or "<submodules are weird>" messages)
>
> and we'd have to do some work to make sure the paths in the given
> messages lined up with the files actually recorded in the index (e.g.
> with distinct types we rename both files to avoid the collision, but
> print the conflict notice for the original path rather than the new
> paths)
>
> [...]
> > > But I'm going to reserve the right in merge-ort to modify, add, or
> > > delete any of those messages passed to path_msg(), which might wreak
> > > havoc on your attempts to parse those strings.  I think they're a ba=
d
> > > form for communicating information to a script or program, and tryin=
g
> > > to transform them into such risks making them suboptimal at
> > > communicating info to humans.  These messages should optimize the
> > > latter, and if we want something for the former, it should probably =
be
> > > a new independent bit of info.
> >
> > Makes sense.
> >
> > So we need something in addition to those messages.
>
> Yes.  Does the proposal above sound like it'd cover your needs?  If
> so, we'd probably need to go through all the callers to path_msg() and
> either add an immediate call to another function immediately
> afterwards that stores this additional information or somehow change
> the path_msg() call itself to somehow take an additional arbitrary
> list of arguments representing the paths and short-desc we want to
> store somewhere.

Yes, you're right, the proper thing to do is to go through the callers to
`path_msg()` so that we can provide that stable output you proposed. A
couple of thoughts about this:

* These are not informal messages, i.e. I think we would need another flag
  that would then trigger another double-`NUL`-separated section to be
  shown, probably between the conflicted file info and the informational
  messages.

* Instead of _adding_ the calls, we could look into refactoring the
  existing `path_msg()` calls, introducing yet another function that would
  call `path_msg()` but also optionally generate that machine-parseable
  conflict info.

* None of this needs to hold up `en/merge-tree`. I am sorry that I am the
  blocker (unintentionally so, I guarantee you that!).

Ciao,
Dscho
