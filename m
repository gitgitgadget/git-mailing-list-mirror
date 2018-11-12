Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2FD1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeKLWqw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:46:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:35418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726717AbeKLWqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:46:52 -0500
Received: (qmail 24885 invoked by uid 109); 12 Nov 2018 12:53:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:53:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10345 invoked by uid 111); 12 Nov 2018 12:53:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:53:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:53:41 -0500
Date:   Mon, 12 Nov 2018 07:53:41 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/10] fast-export: add a --show-original-ids option to
 show original names
Message-ID: <20181112125341.GH3956@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-10-newren@gmail.com>
 <20181111072007.GI30850@sigill.intra.peff.net>
 <CABPp-BGNt0FcqiT=OqctjOEvY9ewNUJZ-Rs_aVEihjbQt3K8tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGNt0FcqiT=OqctjOEvY9ewNUJZ-Rs_aVEihjbQt3K8tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 12:32:22AM -0800, Elijah Newren wrote:

> > >  Documentation/git-fast-export.txt |  7 +++++++
> > >  builtin/fast-export.c             | 20 +++++++++++++++-----
> > >  fast-import.c                     | 17 +++++++++++++++++
> > >  t/t9350-fast-export.sh            | 17 +++++++++++++++++
> > >  4 files changed, 56 insertions(+), 5 deletions(-)
> >
> > The fast-import format is documented in Documentation/git-fast-import.txt.
> > It might need an update to cover the new format.
> 
> We document the format in both fast-import.c and
> Documentation/git-fast-import.txt?  Maybe we should delete the long
> comments in fast-import.c so this isn't duplicated?

Yes, that is probably worth doing (see the comment at the top of
fast-import.c). Some information might need to be migrated.

If we're going to have just one spot, I think it needs to be the
user-facing documentation. This is a public interface that other people
are building compatible implementations for (including your new tool).

> > > +--show-original-ids::
> > > +     Add an extra directive to the output for commits and blobs,
> > > +     `originally <SHA1SUM>`.  While such directives will likely be
> > > +     ignored by importers such as git-fast-import, it may be useful
> > > +     for intermediary filters (e.g. for rewriting commit messages
> > > +     which refer to older commits, or for stripping blobs by id).
> >
> > I'm not quite sure how a blob ends up being rewritten by fast-export (I
> > get that commits may change due to dropping parents).
> 
> It doesn't get rewritten by fast-export; it gets rewritten by other
> intermediary filters, e.g. in something like this:
> 
>    git fast-export --show-original-ids --all | intermediary_filter |
> git fast-import
> 
> The intermediary_filter program may want to strip out blobs by id, or
> remove filemodify and filedelete directives unless they touch certain
> paths, etc.

OK, that matches my understanding. So why does fast-export need to print
the blob ids? If the intermediary is rewriting blobs, it can then
produce the "originally" line itself, can't it?

The more interesting case I guess is your "strip out blobs by id"
example. There the intermediary _could_ do so itself, but it would
require recomputing the object id of each blob.

If you use "--no-data", then this just works (we specify tree entries by
object id, rather than by mark). But I can see how it would be useful to
have the information even without "--no-data" (i.e., if you are doing
multiple kinds of rewrites on a single stream).

I think the thing that confused me is that this "originally" is doing
two things:

  - mentioning blob ids as an optimization / convenience for the reader

  - mentioning rewritten commit (and presumably tag?) ids that were
    rewritten as part of a partial history export. I suppose even trees
    could be rewritten that way, too, but fast-import doesn't generally
    consider trees to be a first-class item.

So I'm OK with it, but I wonder if there is an easier way to explain it.

-Peff
