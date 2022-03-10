Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE6C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 15:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbiCJPO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345830AbiCJPNT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 10:13:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEBB18A780
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 07:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646925051;
        bh=FJkefhJigCU1WEapn4moHSFKOKOYof1QkhVVauZUw6s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lnLwyEyAADEIDLU7ZY/7/YxZv+ViNFnC4+Ih0AeSwQ+hsfuHiRg2Aqy5xk0RshTux
         d8Jbaf6PRCkeu/eeYTGmZIyz3S42tzwhYkkKLks3rVVp5dBPq8WgKAoYyoYHhu+wz1
         2MNrX5ef4bLCt/cHwd3FK+hDQuYGISGVbSIfJ1zY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYv3-1oGrr60IAN-00u1PH; Thu, 10
 Mar 2022 16:10:51 +0100
Date:   Thu, 10 Mar 2022 16:10:49 +0100 (CET)
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
In-Reply-To: <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com> <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet> <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GdQMibMpjp8dS2rNlUbzKzHGKSlECbqnrPOEkyLZxl5EotDSTFk
 1/wfa5FYv5bg5LeaNljPw6sENaQJ8td4G/NetHZFU1MDYGrkeNuVnEsbrmIIjJrb0PBflst
 aEtG1d7cP8v8bhkb6LF5K8OWYQxJdsRTG0ij3z2ROds9yzVbtZYGPr4IlUQloBmNa2ytBJN
 XwjuTY8q23xdTu4xtp/aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wYc8npd5OJM=:d0KN5o3LBqJgschOdbLzSS
 u2qmGYqaD7tjbl6vbW1V4K9n46ZH+wsSpbsHVMGBOz50OdZax3FlXsn6y3G+pCn7bDw2k7A7a
 CNrIw0ho/Liuw7kMBesx0Dla9yO+XgG5+aUzmfTIHAWYaOB7FYZR/L0zS6ECbZ3gO/e0jIrkf
 zQ8HiI5Dqf9eLQo9MWO5dEZN4mwDfo4/0v2WPcl2xL5foo+OqAOFrgu6Bj5C2EoITf9ey5Yg6
 8gbyuEFENoRuNBusW0HmXVXzidv29ehZymB0Wm2vYFZDmooLNLWgoW85TDLIWAo2IRipsq2Lw
 iWoO5hecU9cgpDDOX21tBtZSC5viQxjC/MX8tAysj79OoAmkdZOYHuQErurJWnk8kL1CI4UQw
 +Z8MvBAwBkEm4AjAgWvcEDOKUlV/qbsPwig+Wi3h9ikMO/Bnjk/n75SIhWZCy/7KF9vYQqkhP
 3OnLzklwL5LGCZPkpY74BbCfVantBE4zDpH++FHhGPeFnjttb1JfuJTMaZwnoWCoVV1C942G3
 BnMyckHYx77fJRh4nM67F2+zyKuGI8MeCHIvEQbBbK83oCCHU21asgGeSUnrnrGEmPUupfJJX
 bCk1KBAf/6x4LsCxKVwSOD2zIrU7gjgfhxcZhVp9iI7quCQ3diiP3UwNoawfXf4uzwF+FCSaD
 WDR9W4e8WFPNV7prGNglk9oSb88ghvtCVlnuTd0044DLA/ekHXXrtTDBAfT89qepZj1Rgy8dF
 +S72/0LW8/jKHj7yHRhdxqwa7YQ/DdDsmMYoi0BiHUB6NN0JlKGPG1t0OZo3EqIMCn/P5XSsO
 +AB0tA7bdp0T7pViYCfUhL2XCbwYt2Noz6phuIxBxD266txNsBAryz0ivLY0EUAyjt8yFOmoM
 ApHEfEhFYnyOsigDYG4AQzU1/Ijnb8qOddD5Ul+Ki/O0hF+18eWwlkThrcQzgUuJKhXLU2BKJ
 oNwHGUtNoaTG8R9FtCukZxFyA4cwPZ31CR9AzYIMKoDoOoBaJGF5gdzIQ13uPYeJIPYYQPoU/
 v6jqllCl5Sc0dK20UCPZ9390vaJ+LViRpRzXBDkoTgqo6F7p35aOEr91DV4mz/70Eg2dnoSwm
 iLEqbLnl/+te4c=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 8 Mar 2022, Elijah Newren wrote:

> On Mon, Mar 7, 2022 at 8:27 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 25 Feb 2022, Elijah Newren wrote:
> >
> > > On Fri, Feb 25, 2022 at 8:31 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Tue, 22 Feb 2022, Elijah Newren wrote:
> > > >
> > > > > On Mon, Feb 21, 2022 at 2:46 AM Johannes Schindelin
> > > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > > >
> > > > > > Concretely: while I am not currently aware of any web UI that
> > > > > > allows to resolve simple rename/rename conflicts, it is easily
> > > > > > conceivable how to implement such a thing. When that happens,
> > > > > > we will need to be able to teach the server-side code to
> > > > > > discern between the cases that can be handled in the web UI
> > > > > > (trivial merge conflicts, trivial rename/rename conflicts) as
> > > > > > compared to scenarios where the conflicts are just too
> > > > > > complex.
> > > > >
> > > > > Um, I'm really worried about attempting to make the conflict
> > > > > notices machine parseable.  I don't like that idea at all, and I
> > > > > even tried to rule that out already with my wording: """ In all
> > > > > cases, the <Informational messages> section has the necessary
> > > > > info, though it is not designed to be machine parseable. """
> > > > > though maybe I should have been even more explicit.  The
> > > > > restrictions that those messages be stable is too rigid, I
> > > > > think.  I also think they're a poor way to communicate
> > > > > information to a higher level tool. I would much rather us add
> > > > > some kind of additional return data structures from merge ort
> > > > > and use them if we want extra info.
> > > >
> > > > Okay.
> > > >
> > > > I thought that we could keep the `CONFLICT (<type>)` constant
> > > > enough to serve as such a machine-parseable thing.
> > >
> > > That _probably_ is, but I thought you wanted to parse all N paths
> > > embedded in the message after that part as well?
> >
> > Actually, no, sorry for being unclear. My main aim with the
> > machine-parseable messages was to detect whether a given failed merge
> > contains _only_ conflicts of the sort that a particular UI can handle.
>
> ...and in order to do that, you'd need to parse all the filenames to
> determine whether files were involved in multiple conflict types, since
> you earlier suggested you would just bail on such conflicts (at
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202211059430.26495@tvgsbe=
jvaqbjf.bet/).

That's a good point. I had somehow still in my mind that the `CONFLICT
(<type>)` prefix would already give me enough data to decide whether to
bail out or not, but that prefix would only tell me about a single
`rename/rename` conflict, not about multiple such conflicts involving the
_same_ file.

> In particular, I think the "mod6" and "rrdd" and "rad" cases kind of
> triggered those comments, and rename/rename is involved in two of those.
>
> Further, even if you could assume there'd only be simple conflicts such
> as the simple rename/rename case, you'd still need the files so that you
> know _which_ of the modes/oids in the <Conflicted file info> section
> relate to the message you are looking at.  (As mentioned previously,
> sorting the <Conflicted file info> to attempt to put them together is
> not feasible and is a no-go.)

True.

> > > > And then presenting `<path>NUL<message>NUL` could have served my
> > > > use case well...
> > >
> > > Would it?  Wouldn't you need something more like
> > >
> > > <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type=
-description>NUL<message>NUL
> > > ?
> >
> > Probably, you're right.
> >
> > > I mean, if rename/rename is what you want to handle, there are three
> > > paths in that message.  And you need to know all three paths in
> > > order to combine the relevant parts of the <Conflicted File Info>
> > > section together.
> > >
> > > (Also, while we're at it, I decided to throw a stable short-type
> > > description string (e.g. "CONFLICT (rename/rename)") in there, which
> > > will _probably_ be the first part of the message string but still
> > > allow us to change the message string later if we want.)
> >
> > Yes, I very much like that idea to keep the prefix in a format that we
> > can guarantee to be stable enough for applications (or server
> > backends) to rely on.
>
> Um, I explicitly avoided saying the prefix would be stable by
> introducing a separate short string just so that we could change the
> prefix later if wanted.  The short string is _probably_ the current
> prefix or something close to it, but that stable string wouldn't
> necessarily remain the prefix of the message string, since the entire
> message string would be allowed to change.

Okay.

> > [T]he proper thing to do is to go through the callers to `path_msg()`
> > so that we can provide that stable output you proposed. A couple of
> > thoughts about this:
> >
> > * These are not informal messages, i.e. I think we would need another =
flag
> >   that would then trigger another double-`NUL`-separated section to be
> >   shown, probably between the conflicted file info and the information=
al
> >   messages.
>
> Why would that be a separate section, though?

I thought you wanted to keep the informal messages human-readable, so
naturally I thought that the machine-readable part should be in a separate
section.

> While we don't want machines parsing the informal messages and trying to
> determine the components of that message, they definitely should be able
> to tell which informal messages are associated with which paths
> (otherwise how can you group the <Conflict message info> as per your
> needs and how do you know which message to show the user when dealing
> with that particular conflict?).  That requirement suggests the informal
> messages should be part of the same section.  Thus my suggestion to just
> make it be the <message> part at the end of my earlier suggestion of
>
> <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-des=
cription>NUL<message>NUL

Oh, okay.

Should this format be the one with `-z`, and the current format remain the
one being shown without `-z`?

> > * Instead of _adding_ the calls, we could look into refactoring the
> >   existing `path_msg()` calls, introducing yet another function that w=
ould
> >   call `path_msg()` but also optionally generate that machine-parseabl=
e
> >   conflict info.
>
> So of the two alternatives I suggested above, it sounds like you're in
> favor of the "or somehow change the path_msg() call itself to somehow
> take an additional arbitrary list of arguments representing the paths
> and short-desc we want to store somewhere" option I suggested.  I
> think I prefer that one too.

Yes!

> > * None of this needs to hold up `en/merge-tree`. I am sorry that I am =
the
> >   blocker (unintentionally so, I guarantee you that!).
>
> Sometimes I find it frustrating that changes don't merge down for
> months, particularly when the topic was already finished weeks and
> weeks (if not months) ago and/or when there's a follow-on series
> depending on it.  But in this case I have no follow-on series ready to
> send, and this topic has been under (very!) active discussion
> essentially the whole time.  And, perhaps even more importantly, I'd
> like to avoid solidifying the "machine parseable output format"
> prematurely and making it harder to work around later.  I think
> addressing this issue you bring up requires fundamentally redoing the
> informational messages section as per my proposal, and it makes me
> wonder what should even be shown without the -z option (thoughts
> welcome).

My suggestion is above: without `-z`, the messages should be identical to
what is shown now.

> So, this is one series where even if everyone else says to merge it
> already, I'd like to wait a bit longer on it until I feel confident we
> have a solution that handles at least the current usecases.

Fair enough, you're in charge of this series, and I really like what you
came up with.

My thinking was driven more by the users' side, as I am relatively eager
to integrate this into production, but am loathe to do that with an early
iteration of `en/merge-tree` that might be substantially revamped, still.

It can bog me down quite well if I have to adjust local (or not-so-local)
patch series to refactorings in core Git. For example, the other day, I
was blocked from more interesting work until I could resolve all kinds of
conflicts where core Git renaming `hash_object_file_literally()` to
`write_object_file_literally()` completely intersected with
actually-interesting `unsigned long` to `size_t` changes in Git for
Windows. And let me tell you, once you have to deal with such conflicts a
couple of times, being prevented from doing work that is actually fun, it
is relatively easy to become frustrated and think about those refactorings
as pointless and as useless churn, no matter how well-intended they may
be.

So my prodding is kind of selfish, as an `en/merge-tree` cherry-picked
from `next` would provide somewhat of a promise that I do _not_ have to
spend _so_ much time adjusting my code in case a new iteration with
substantial changes shows up ;-)

But you're right, let's tread wisely and only call this patch series done
only when we are reasonably certain that the machine-parseable output is
stable.

Speaking of which: Would you like me to give that `path_msg()` refactoring
a try, or are you already busy with it? (I cannot make any promises, but I
also do not want to lean on you, to leave you alone with that work, I
would feel really bad about that.)

Ciao,
Dscho
