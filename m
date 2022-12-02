Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC0C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 23:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiLBXK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 18:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLBXKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 18:10:25 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D6F1182B
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 15:10:23 -0800 (PST)
Received: (qmail 29686 invoked by uid 109); 2 Dec 2022 23:10:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Dec 2022 23:10:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9102 invoked by uid 111); 2 Dec 2022 23:10:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Dec 2022 18:10:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Dec 2022 18:10:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Message-ID: <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2022 at 05:40:34PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > [1] While our CI helps the MSVC job runs CMake manually, performs an
> > in-tree build and does not use ctest. In contrast a user running the 
> > MSVC GUI does not run CMake themselves, ends up with an out-of-tree
> > build and runs the tests with ctest.
> 
> I don't run Windows by choice, and I'm not interested in running a
> propriterary IDE (VS) either.
> 
> The main reason I'm working on this series is that while we as a project
> are happy to support proprietary OS's, it hasn't been a requirement for
> participation that you need to buy a copy of Windows, OSX, AIX, HP/UX or
> whatever to submit patches.
> 
> Of course we have platform-specific code. but this CMake component is
> unique in how invasive it is.
> 
> It's easy to e.g. stay away from the OSX-specific code in
> compat/fsmonitor/*darwin*.[ch], or generally speaking the
> Windows-specific C code.
> 
> But for CMake it's become a hard requirenment for many changes, even
> though it's a contrib/ component.

I have similar feelings to you here. Back when cmake support was
introduced, I explicitly wanted it to be something for people who cared
about it, but that wouldn't bother people who didn't use it:

  https://lore.kernel.org/git/20200427200852.GC1728884@coredump.intra.peff.net/

I stand by that sentiment, but it seems to have crept up as a required
thing to deal with, and that is mostly because of CI. Using cmake in CI
is good for telling developers when a change they make has broken cmake.
But it also makes cmake their problem, and not the folks interested in
cmake.

Now maybe attitudes have changed, and I am out of date, and cmake
support is considered mature and really important (or maybe nobody even
agreed with me back then ;) ). But if not, should we consider softening
the CI output so that cmake failures aren't "real" failures? That seems
drastic and mean, and I don't like it. But it's the root of the issue,
IMHO.

As a side note, this isn't the only such instance of this problem. Two
other things to think about:

  - You mentioned darwin fsmonitor code. And it's true that you can
    largely ignore it if you don't touch it. But every once in a while
    you get bit by it (e.g., enabling a new compiler warning which
    triggers in code you don't compile on your platform, and now you
    have to guess-and-check the fix with CI). This sucks, but is kind of
    inevitable on a cross-platform system. I think the issue with cmake
    is that because it's basically duplicating/wrapping the Makefile, it
    _feels_ unnecessary to people on platforms with working make, and
    triggers more frequently (because changes to the rest of the build
    system may break cmake in subtle ways).

  - I'd actually put the leak-checking CI in the same boat. It's a good
    goal, and one I hope we work towards. But it feels like the current
    state is not very mature, and people often end up wrestling with CI
    to deal with failures that they didn't even introduce (e.g., adding
    a new test that happens to run a Git program that has an existing
    leak, and now you are on the hook for figuring out why the existing
    "passes leaks" annotation is wrong).

    My original hope is that we would introduce leak-checking tooling
    that people interested in leaks could use, and other people could
    ignore until we reached a leak-free state. Because it's in CI it
    means that people get notified of new leaks in code they write
    (which is good, and helps people interested in leaks), but it also
    means they have to deal with the immature state.

I'm not necessarily proposing to drop the leaks CI job here. I'm mostly
philosophizing about the greater problem. In the early days of Git, the
cross-platform testing philosophy was: somebody who cares will test on
that platform and write a patch. If they don't, how important could it
be? With CI that happens automatically and it becomes everybody's
problem, which is a blessing and a curse.

-Peff
