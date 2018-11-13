Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B261F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 14:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbeKNAoY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 19:44:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:37128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387625AbeKNAoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 19:44:23 -0500
Received: (qmail 18472 invoked by uid 109); 13 Nov 2018 14:45:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Nov 2018 14:45:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19823 invoked by uid 111); 13 Nov 2018 14:45:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Nov 2018 09:45:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2018 09:45:54 -0500
Date:   Tue, 13 Nov 2018 09:45:54 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/10] fast-export: add --always-show-modify-after-rename
Message-ID: <20181113144554.GB17454@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-11-newren@gmail.com>
 <20181111072356.GJ30850@sigill.intra.peff.net>
 <CABPp-BGREOAvF-6DBymdwsUL2LpyPNqy8dCw0RuUKZf2Da6cJA@mail.gmail.com>
 <20181112125847.GI3956@sigill.intra.peff.net>
 <CABPp-BHjPq-2JoeXur+FMs+T==arqvMaAW1uLKMSHKBKBS60rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHjPq-2JoeXur+FMs+T==arqvMaAW1uLKMSHKBKBS60rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 10:08:10AM -0800, Elijah Newren wrote:

> > I would do:
> >
> >    git log --raw $(
> >      git cat-file --batch-check='%(objectsize:disk) %(objectname)' --batch-all-objects |
> >      sort -rn | head -3 |
> >      awk '{print "--find-object=" $2 }'
> >    )
> >
> > I'm not sure how renames enter into it at all.
> 
> How did I miss objectsize:disk??  Especially since it is right next to
> objectsize in the manpage to boot?  That's awesome, thanks for that
> pointer.
> 
> I do have a separate cat-file --batch-check --batch-all-objects
> process already, since I can't get sizes out of either log or
> fast-export.  However, I wouldn't use your 'head -3' since I'm not
> looking for the N biggest, but reporting on _all_ objects (in reverse
> size order) and letting the user look over the report and deciding
> where to stop reading.  So, this is a big and expensive log command.
> Granted, we will need a big and expensive log command, but let's keep
> in mind that we have this one.

It is an expensive log command, but it's the same expense as running
fast-export, no? And I think maybe that is the disconnect.

I am looking at this problem as "how do you answer question X in a
repository". And I think you are looking at as "I am receiving a
fast-export stream, and I need to answer question X on the fly".

And that would explain why you want to get extra annotations into the
fast-export stream. Is that right?

> > There I think you'd want to assemble the list with something like "git
> > log --follow --name-only paths-of-interest" except that --follow sucks
> > too much to handle more than one path at a time.
> >
> > But if you wanted to do it manually, then:
> >
> >   git log --diff-filter=R --name-only
> >
> > would be enough to let you track it down, wouldn't it?
> 
> Without a -M you'd only catch 100% renames, right?  Those aren't the
> only ones I'd want to catch, so I'd need to add -M.  You are right
> that we could get basic renames this way, but it doesn't cover
> everything I need.  Let's use this as a starting point, though, and
> build up to what I need...

No, renames are on by default these days, and that includes inexact
renames. That said, if you're scripting you probably ought to be doing:

  git rev-list HEAD | git diff-tree --stdin

and there yes, you'd have to enable "-M" yourself (you touched on
scripting and formatting below; diff-tree can accept the format options
you'd want).

> I also want to know when files were deleted.  I've generally found
> that people are more okay with purging parts of history [corresponding
> to large ojbects] that were deleted longer ago than more recent stuff,
> for a variety of reasons.  So we could either run yet another log, or
> modify the command to:
> 
>   git log -M --diff-filter=RD --name-status
> 
> However, I don't just want to know when files were deleted, I'd like
> to know when directories are deleted.  I only knew how to derive that
> from knowing what files existed within those directories, so that
> would take me to:
> 
>   git log -M --diff-filter=RAD --name-status
> 
> [Edit: I just saw your other email and for the first time learned
> about the -t rev-list option which might simplify this a little,
> although "need to worry about deleted files being reinstated" below
> might require the 'A' anyway.]

Yeah, I think "-t" would help your tree deletion problem.

> At this point, let's remember that we had another full git-log
> invocation for mapping object sizes to filenames.  We might as well
> coalesce the two log commands into one, by extending this latest one
> to:
> 
>   git log -M --diff-filter=RAMD --no-abbrev --raw

What is there besides RAMD? :)

> I could potentially switch to using this and drop patch 10/10.

So I'm still not _entirely_ clear on what you're trying to do with
10/10. I think maybe the "disconnect" part I wrote above explains it. If
that's correct, then I think framing it in terms of the operations that
you'd be able to perform _without running a separate traverse_ would
make it more obvious.

> Anyway, I hope it makes a little more sense why I created this patch.
> Does it, or have I just made things even more confusing?

Some of both, I think.

> ...and if you've read this far, I'm impressed.  Thanks for reading.

I'll admit I skimmed near the end. ;)

-Peff
