Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CB1C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFBg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiLFBg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:36:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE3C1FFA1
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:36:24 -0800 (PST)
Received: (qmail 11290 invoked by uid 109); 6 Dec 2022 01:36:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Dec 2022 01:36:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16033 invoked by uid 111); 6 Dec 2022 01:36:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 20:36:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 20:36:23 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Message-ID: <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
 <Y45/8WnuUnP9gOMo@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y45/8WnuUnP9gOMo@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 06:34:09PM -0500, Taylor Blau wrote:

> I think CI *is* the problem here. The CMake bits are basically a black
> box to me (and I suspect a large number of other contributors, too). But
> when it breaks, the only reason we as a project end up noticing it is
> because it has fallout in CI.
> 
> I would not be sad to make CI failures that are derived from CMake
> "soft" failures in the sense that they don't make the build red. But I
> think it's masking over a couple of bigger issues:
> 
>   - Why do we "support" two build systems in CI if one is supposed to
>     only be here for those that care about it? IOW, even if we say that
>     CMake support is nominally an opt-in thing, in reality it isn't
>     because of the dependency via CI.

I think part of the reason cmake rose in importance via CI is that it's
the de facto way to build for vscode. Before that CI job switched to
cmake, there was some other alternate build system (vcxproj).

So two things I'd consider here:

  - how important is it for us to do the vscode build as part of regular
    CI (as opposed to folks who are interested in it running it
    themselves). Dscho gave some real data in the thread I linked to
    earlier (which indicates that yes, it helps, but not that often).

  - what's the status of cmake versus vcxproj? My impression (though I
    admit based on my half-paying-attention-to of the topic) is that
    cmake should replace vcxproj, and nobody would ever want to work on
    vcxproj anymore. But if that's not right, then does vcxproj cause
    headaches for non-Windows devs less often? I don't really remember
    dealing with it much, but I may have just been lucky.

>   - Why do we only *notice* these failures in CI? I found during my time
>     as interim-maintainer the task of tracking down CI failures to quite
>     frustrating. It is often quite difficult to reproduce CI failures
>     locally (especially with exotic build and test configurations[^1]).

I think that's just the normal platform issues. You don't use it on your
system, so you don't notice until it runs in CI. If people don't run CI
themselves, then it falls to the maintainer's CI run, which is a pain
for them. But that's as true of other operating systems, exotic test
flags, etc, as it is of cmake.

> It would be nice to be able to more easily see these failures locally
> before they hit CI. E.g., is it possible that I would work on a feature
> which somehow breaks the CMake build, and fail to notice it if I use
> "make" locally?

That seems like going in the opposite direction from what you're saying
above: doubling down that if cmake is broken by a change, it is the
responsibility of the dev who made the change to find and fix it.

I do like that Ævar is trying to make it easier to run cmake from Linux
in order to find that without using CI. But that does seem orthogonal to
me to the notion of "who is responsible for finding and fixing cmake
problems". To me, that decision is really rooted in "is cmake something
the Git project supports, or is it a side-thing that some folks
volunteer to keep working?".

> Personally, I would not be sad to see CMake removed from the tree
> entirely because it has not seen enough maintenance and seems to be
> quite a headache.

I don't mind having it in-tree if I can ignore it (assuming the project
attitude is the "it's a side thing" from above). It's the CI failures
that make it hard to ignore.

-Peff
