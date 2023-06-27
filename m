Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E235EB64DD
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 08:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjF0IKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjF0IKD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 04:10:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7DE270B
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 01:09:55 -0700 (PDT)
Received: (qmail 790 invoked by uid 109); 27 Jun 2023 08:09:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 08:09:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14855 invoked by uid 111); 27 Jun 2023 08:09:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 04:09:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 04:09:54 -0400
From:   Jeff King <peff@peff.net>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Determining whether you have a commit locally, in a partial
 clone?
Message-ID: <20230627080954.GF1226768@coredump.intra.peff.net>
References: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
 <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
 <CAPMMpojUpJD21x2i_hshTB96TBFVd-_WRV54KHT2-4R8DUh8=Q@mail.gmail.com>
 <20230621064459.GA607974@coredump.intra.peff.net>
 <CAPMMpoha6rBA-T-7cn3DQT_nbNfknigLTky55x0TEmt4Ay2GRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPMMpoha6rBA-T-7cn3DQT_nbNfknigLTky55x0TEmt4Ay2GRA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 12:10:33PM +0200, Tao Klerks wrote:

> > This is not very efficient, but:
> >
> >   git cat-file --batch-check='%(objectname)' --batch-all-objects --unordered |
> >   grep $some_sha1
> >
> > will tell you whether we have the object locally.
> >
> 
> Thanks so much for your help!
> 
> in Windows (msys or git bash) this is still very slow in my repo with
> 6,500,000 local objects - around 60s - but in linux on the same repo
> it's quite a lot faster, at 5s. A large proportion of my users are on
> Windows though, so I don't think this will be "good enough" for my
> purposes, when I often need to check for the existence of dozens or
> even hundreds of commits.

Yeah, it's just a lot of object names to print, most of which you don't
care about. :)

The more efficient thing would be to open the actual pack .idx files and
look for the names via binary search. I don't think you can convince git
to do that, though I suspect you could write a trivial libgit2 program
that does.

> > I don't work with partial clones often, but it feels like being able to
> > say:
> >
> >   git --no-partial-fetch cat-file ...
> >
> > would be a useful primitive to have.
> 
> It feels that way to me, yes!
> 
> On the other hand, I find very little demand for it when I search "the
> internet" - or I don't know how to search for it.

I think partial clones are still new enough that not many people are
using them heavily. And when they do, not managing the partial state at
a very advanced level; I think tools for pruning locally cached objects
(which you could refetch) is only just being worked on now.

> > It does seem like you might be able to bend it to
> > your will here, though. I think without any patches that:
> >
> >   git rev-list --objects --exclude-promisor-objects $oid
> >
> > will tell you whether we have the object or not (since it turns off
> > fetch_if_missing, and thus will either succeed, printing nothing, or
> > bail if the object can't be found).
> 
> This behaves in a way that I don't understand:
> 
> In the repo that I'm working in, this command runs successfully
> *without fetching*, but it takes a *very* long time - 300+ seconds -
> much longer than even the "inefficient" 'cat-file'-based printing of
> all (6.5M) local object ids that you proposed above. I haven't
> attempted to understand what's going on in there (besides running with
> GIT_TRACE2_PERF, which showed nothing interesting), but the idea that
> git would have to work super-hard to find an object by its ID seems
> counter to everything I know about it. Would there be value in my
> trying to understand & reproduce this in a shareable repo, or is there
> already an explanation as to why this command could/should ever do
> non-trivial work, even in the largest partial repos?

I think it's actually doing the gigantic traversal (and just limiting it
when it sees objects that are not available). You probably want
"--no-walk" at least, but really you don't even want to walk the trees
of any commits you specify (so you'd want to omit "--objects" if you are
asking about a commit, and otherwise include it, which is slightly
awkward).

> > It feels like --missing=error should
> > function similarly, but it seems to still lazy-fetch (I guess since it's
> > the default, the point is to just find truly unavailable objects). Using
> > --missing=print disables the lazy-fetch, but it seems to bail
> > immediately if you ask it about a missing object (I didn't dig, but my
> > guess is that --missing is mostly about objects we traverse, not the
> > initial tips).
> 
> Woah, "--missing=print" seems to work!!!
> 
> The following gives me the commit hash if I have it locally, and an
> error otherwise - consistently across linux and windows, git versions
> 2.41, 2.39, 2.38, and 2.36 - without fetching, and without crazy
> CPU-churning:
> 
> git rev-list --missing=print -1 $oid
> 
> Thank you thank you thank you!

Hmph, I thought I tried that before and it didn't work, but it seems to
work for me now. I guess I was hoping to have it print the missing
object rather than exiting with an error, but if you do one object at a
time then the error is sufficient signal. :)

You might want "--objects" if you're going to ask about non-commits.
Though it might not be necessary. I suspect Git would bail trying to
look up the object in the first place if we don't have it, and if we do
have it then it just becomes a silent noop.

> I feel like I should try to work something into the doc about this,
> but I'm not sure how to express this: "--missing=error is the default,
> but it doesn't actually error out when you're explicitly asking about
> a missing commit, it fetches it instead - but --missing=print actually
> *does* error out if you explicitly ask about a missing commit" seems
> like a strange thing to be saying.

I think we are relying on the side effect that everything except
--missing=error will turn off auto-fetching. I don't know if that's
something we'd want to document. It seems reasonable to me that we might
later change the implementation so that we kick in the --missing
behavior only after parsing the initial list of traversal tips (I mean,
I don't know why we would do that in particular, but it seems like the
kind of thing we'd want to reserve as an implementation detail subject
to change).

I do think in the long run that a big "--do-not-lazy-fetch" flag would
be the right solution to let the user tell us what they want.

> Thanks again for finding me an efficient working strategy here!

I'm glad it worked. I was mostly just thinking out loud. ;)

-Peff
