Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB233FA373D
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 01:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbiJ1BXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 21:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ1BXG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 21:23:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A83CA5724
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 18:23:05 -0700 (PDT)
Received: (qmail 18672 invoked by uid 109); 28 Oct 2022 01:23:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Oct 2022 01:23:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27793 invoked by uid 111); 28 Oct 2022 01:23:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Oct 2022 21:23:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Oct 2022 21:23:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Message-ID: <Y1su99Kc0ex1W7bX@coredump.intra.peff.net>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
 <221026.8635badbz5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221026.8635badbz5.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 01:35:43PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > (I had a similar thought after getting hit on the head by the recent
> > t0450-txt-doc-vs-help.sh).
> 
> Sorry about that. FWIW I've wanted to assert that for a while, and to do
> it by e.g. having the doc *.txt blurbs generated from running "$buildin
> -h" during the build.
> 
> But when I suggested that I gathered That Junio wasn't up for that
> approach, it does have its downsides thorugh. E.g. to build the docs
> you'd now have to compile C code, and e.g. that git-scm.com publisher
> written in Ruby would have to compile the code to generate its docs.

Yes, it would definitely break the git-scm.com importer. It might be
possible to make it work by actually running "make man" (or maybe even
some partial targets) in a local repo. The nightly update job pulls all
of the data using GitHub's API, but it does run in a heroku dyno that
has git and gcc. Doing a shallow clone of the tag to build is probably
more expensive, but the cost of an actual build isn't that important.
99% of the scheduled job runs are noops because there's no new version
of Git to build manpages for; as long as those remain cheap-ish, we're
OK.

I also think in the long run that the site should move to a system that
builds off a local repo, which we can trigger manually or via GitHub
Actions. But that doesn't exist yet, and I don't think anyone's actively
working on it.

I also think it would be nice if the git-scm.com system relied more on
"make man USE_ASCIIDOCTOR=1", possibly by hooking into
asciidoctor-extensions.rb or similar, rather than munging files in an
ad-hoc manner. But that's also a big change that nobody is actively
working on.

All of which is to say that yes, having docs depend on C code will cause
work on the site, but it may be work that takes us in the right
direction.

> Or we could do it the other way around, and scape the *.txt for the *.c
> generation, but then we need to run a new script for building
> builtin/*.o. Also possible, and I think eventually both are better than
> what t0450-txt-doc-vs-help.sh's doing now, but that was a less invasive
> change than both...

I think this particular case is tricky in that direction, because it's a
big set of dependencies that aren't necessarily one-to-one. E.g.,
builtin/log.c needs to depend on git-log.txt, but also on git-show.txt
and git-format-patch.txt.

> >> +# Unfortunately our dependency management of generated headers used
> >> +# from within other headers suck, so we'll need to list every user of
> >> +# fsck.h here, but not too bad...
> >> +FSCK_MSGIDS_H_BUILTINS = fsck index-pack mktag receive-pack unpack-objects
> >> +$(foreach f,$(FSCK_MSGIDS_H_BUILTINS:%=builtin/%),$f.sp $f.s $f.o): fsck-msgids.h
> >> +FSCK_MSGIDS_H_LIBS = fetch-pack fsck
> >> +$(foreach f,$(FSCK_MSGIDS_H_LIBS),$f.sp $f.s $f.o): fsck-msgids.h
> >
> > I don't understand the "used within other headers" part here. Computed
> > dependencies will get this right. It's only the initial build (before we
> > have any computed dependencies) that needs to know that the C files in
> > question depend on the generated file. But that is true whether they do
> > so directly or indirectly.
> 
> I forgot the full story, but luckily I wrote it down in the WIP commits
> :) FWIW if you want to scour that it's mainly:
> 
> 	https://github.com/avar/git/commit/a00f1cb9ea5 # add advice-type.h
> 	https://github.com/avar/git/commit/9e080923a11 # generate 'struct advice

That seems like the same problem to me. It's just that if something is
in cache.h, then it's needed by basically everything, and so the
dependency list is big.

> Anyway, in partial summary, why (and sorry this got so long):
> 
>  * Yes, once we build e.g. fsck.o we have the full dependency tree,
>    yay....
>  * ...but only for gcc & clang, but we support other compilers.
>  * ...for other compilers (or gcc & clang without the dep detection
>    enabled) what should this do:
> 
> 	make file-that-does-not-use-generated-header.o
> 
>    It sucks a bit to have e.g. every *.o depend on command-list.h, when
>    we only use it in 1-2 places, ditto the other headers.

But that is already true of non-generated headers. If your system
doesn't support computed deps, then all objects depend on all headers.
Yes, that sucks for you. But almost nobody actively develops on such a
system, and people building Git to use rarely notice (because they are
doing an initial build, or jumping versions, both of which generally
require recompilation anyway).

That all comes from b8ba629264 (Makefile: fold MISC_H into LIB_H,
2012-06-20).

>  * We also have e.g. "make hdr-check", which works just fine now, but
>    it's becausue we have no *.h file that uses another generated *.h
>    file.

I'm not that surprised. Probably it should depend on $(GENERATED_H), and
possibly even be checking those files too.

>  * I may be wrong (I'm just looking at some old "here be dragons" note
>    of mine), but I think there's also an edge case where the dependency
>    graph of .depend.d/* is correct *once you've always had it*, but if a
>    file now e.g. depends on foo.h, and I make foo.h include a new
>    foo-generated.h things go boom.

That should work because the timestamp on foo.h will have been updated,
causing anything that includes it to rebuild (and thus updating its
computed dependencies to include foo-generated.h).

-Peff
