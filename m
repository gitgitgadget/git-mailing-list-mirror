Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58474C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 09:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLEJP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 04:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLEJPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 04:15:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC194A1A5
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 01:15:07 -0800 (PST)
Received: (qmail 7259 invoked by uid 109); 5 Dec 2022 09:15:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Dec 2022 09:15:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2244 invoked by uid 111); 5 Dec 2022 09:15:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 04:15:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 04:15:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Message-ID: <Y422mm4Bcu0BWPZt@coredump.intra.peff.net>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2022 at 02:41:04AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I have similar feelings to you here. Back when cmake support was
> > introduced, I explicitly wanted it to be something for people who cared
> > about it, but that wouldn't bother people who didn't use it:
> >
> >   https://lore.kernel.org/git/20200427200852.GC1728884@coredump.intra.peff.net/
> >
> > I stand by that sentiment, but it seems to have crept up as a required
> > thing to deal with, and that is mostly because of CI. Using cmake in CI
> > is good for telling developers when a change they make has broken cmake.
> > But it also makes cmake their problem, and not the folks interested in
> > cmake.
> 
> That's a bit of a pain, but I don't think the main problem is its
> integration with CI. It's that there doesn't really seem to be an
> interest in its active maintenance & review from its supposed main
> target audience.

Yeah, there are two issues:

  1. People who don't care about cmake having to think about cmake at
     all.

  2. People trying to fix cmake and not getting traction.

My pain has usually been (1), but you were nice enough here to make it
to (2). :)

> > Now maybe attitudes have changed, and I am out of date, and cmake
> > support is considered mature and really important (or maybe nobody even
> > agreed with me back then ;) ). But if not, should we consider softening
> > the CI output so that cmake failures aren't "real" failures? That seems
> > drastic and mean, and I don't like it. But it's the root of the issue,
> > IMHO.
> 
> Yeah, maybe. Maybe if we broke it we'd get people showing up to maintain
> it again :)

By the way, I looked in the archive, and me complaining about cmake has
come up once or twice. Johannes offered some helpful guidance on the
value of running the vsbuild tests and how we might work around them:

  https://lore.kernel.org/git/nycvar.QRO.7.76.6.2008141352430.54@tvgsbejvaqbjf.bet/

> > As a side note, this isn't the only such instance of this problem. Two
> > other things to think about:
> >
> >   - You mentioned darwin fsmonitor code. And it's true that you can
> >     largely ignore it if you don't touch it. But every once in a while
> >     you get bit by it (e.g., enabling a new compiler warning which
> >     triggers in code you don't compile on your platform, and now you
> >     have to guess-and-check the fix with CI). This sucks, but is kind of
> >     inevitable on a cross-platform system. I think the issue with cmake
> >     is that because it's basically duplicating/wrapping the Makefile, it
> >     _feels_ unnecessary to people on platforms with working make, and
> >     triggers more frequently (because changes to the rest of the build
> >     system may break cmake in subtle ways).
> 
> Yeah, we'll always have some cross-platform pain.
> 
> But e.g. "chmod +x" just works in the Makefile, including when we run it
> on Windows. And I've run it on Windows CI. But just upthread of here
> Phillip is reporting that it doesn't work from the context of the CMake
> recipe.
> 
> I've been throwing some things at Windows CI, but I'm pretty stumped as
> to what that might be.
> 
> Some warning on Mac OS X is trivial by comparison :)

That was just an example, of course. :) I have also done this kind of
"guess and check" with the Windows CI. I think Johannes has given
examples in the past of how to actually connect to a running CI instance
and debug interactively, but I've never managed to remember the correct
incantation at the moment I needed it.

> > I'm not necessarily proposing to drop the leaks CI job here. I'm mostly
> > philosophizing about the greater problem. In the early days of Git, the
> > cross-platform testing philosophy was: somebody who cares will test on
> > that platform and write a patch. If they don't, how important could it
> > be? With CI that happens automatically and it becomes everybody's
> > problem, which is a blessing and a curse.
> 
> That's a definitely a bit of an irresistible digression :)
> 
> First, I think we can agree that however frustrating that's been (and
> sorry!) it would be a lot worse if my average response time to the leak
> testing breaking something was measured in months :)

Yes, to be clear, I have no problem with you in terms of responsiveness
as maintaining the leaks system. It's mostly that I have to think of
them _at all_ when working on something unrelated (that is not itself
introducing new leaks).

> I do think that whatever issues we've had with it (and in retrospect I'd
> do some of it differently) that it's a lot more mature these days than
> you might remember.

Yeah, it definitely has been getting better, and I admit my opinion is
based on a longer-term experience of a changing variable. There's
probably some clever name for that kind of bias, but I don't know it
offhand.

-Peff
