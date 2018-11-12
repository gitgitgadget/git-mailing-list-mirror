Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50861F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeKLWwA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:52:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:35434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726693AbeKLWwA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:52:00 -0500
Received: (qmail 25086 invoked by uid 109); 12 Nov 2018 12:58:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:58:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10370 invoked by uid 111); 12 Nov 2018 12:58:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:58:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:58:48 -0500
Date:   Mon, 12 Nov 2018 07:58:48 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/10] fast-export: add --always-show-modify-after-rename
Message-ID: <20181112125847.GI3956@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-11-newren@gmail.com>
 <20181111072356.GJ30850@sigill.intra.peff.net>
 <CABPp-BGREOAvF-6DBymdwsUL2LpyPNqy8dCw0RuUKZf2Da6cJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGREOAvF-6DBymdwsUL2LpyPNqy8dCw0RuUKZf2Da6cJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 12:42:58AM -0800, Elijah Newren wrote:

> > > fast-export output is traditionally used as an input to a fast-import
> > > program, but it is also useful to help gather statistics about the
> > > history of a repository (particularly when --no-data is also passed).
> > > For example, two of the types of information we may want to collect
> > > could include:
> > >   1) general information about renames that have occurred
> > >   2) what the biggest objects in a repository are and what names
> > >      they appear under.
> > >
> > > The first bit of information can be gathered by just passing -M to
> > > fast-export.  The second piece of information can partially be gotten
> > > from running
> > >     git cat-file --batch-check --batch-all-objects
> > > However, that only shows what the biggest objects in the repository are
> > > and their sizes, not what names those objects appear as or what commits
> > > they were introduced in.  We can get that information from fast-export,
> > > but when we only see
> > >     R oldname newname
> > > instead of
> > >     R oldname newname
> > >     M 100644 $SHA1 newname
> > > then it makes the job more difficult.  Add an option which allows us to
> > > force the latter output even when commits have exact renames of files.
> >
> > fast-export seems like a funny tool to look up paths. What about "git
> > log --find-object=$SHA1" ?
> 
> Eek, and give me O(N*M) behavior, where N is the number of commits in
> the repository and M is the number of renames that occur in its
> history?  Also, that's the inverse of the lookup I need anyway (I have
> the commit and filename, but am missing the SHA).

Maybe I don't understand what you're trying to accomplish. I was
thinking specifically of your "cat-file can tell you the large objects,
but you don't know their names/commits" from above.

I would do:

   git log --raw $(
     git cat-file --batch-check='%(objectsize:disk) %(objectname)' --batch-all-objects |
     sort -rn | head -3 |
     awk '{print "--find-object=" $2 }'
   )

I'm not sure how renames enter into it at all.

> One of the problems with filter-branch that people often run into is
> they know what they want at a high-level (e.g. extract the history of
> this directory for a new repository, or rewrite the history of this
> repo to appear at a subdirectory so it can be merged into a bigger
> repo and people passing filenames to log will still get the history of
> those files, or I want to remove some of the big stuff in my history),
> but often times that's not quite enough.  They need help finding big
> objects, or may be unaware that the subset of files they want used to
> be known by alternative names.
> 
> I want a simple --analyze mode that can report on all files that have
> been renamed (so users don't just say "all I care about is these N
> files, give me a rewritten history just including those" -- we can
> point out to them whether those N files used to be known by other
> names), as well as reporting on all big files and if they've been
> deleted, and aggregations of the "big files" information across
> directories and file extensions.

So this seems like a separate problem than what the commit message talks
about.

There I think you'd want to assemble the list with something like "git
log --follow --name-only paths-of-interest" except that --follow sucks
too much to handle more than one path at a time.

But if you wanted to do it manually, then:

  git log --diff-filter=R --name-only

would be enough to let you track it down, wouldn't it?

-Peff
