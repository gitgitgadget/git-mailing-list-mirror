Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29B42021E
	for <e@80x24.org>; Fri, 19 May 2017 12:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbdESMrP (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:47:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:54780 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755430AbdESMrB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:47:01 -0400
Received: (qmail 2050 invoked by uid 109); 19 May 2017 12:46:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:46:53 +0000
Received: (qmail 27630 invoked by uid 111); 19 May 2017 12:47:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:47:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:46:51 -0400
Date:   Fri, 19 May 2017 08:46:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 0/15] retain blob info for git diff HEAD:foo HEAD:bar
Message-ID: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
 <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
 <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net>
 <xmqqshk4z2hv.fsf@gitster.mtv.corp.google.com>
 <20170517020535.qqmw2yncfomd3hfb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170517020535.qqmw2yncfomd3hfb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 10:05:35PM -0400, Jeff King wrote:

> On Wed, May 17, 2017 at 10:38:36AM +0900, Junio C Hamano wrote:
> 
> > > -			add_pending_object(revs, a_obj, this);
> > > -			add_pending_object(revs, b_obj, next);
> > > +			add_pending_object_with_path(revs, a_obj, this,
> > > +						     oc.mode,
> > > +						     oc.path[0] ? oc.path : NULL);
> > > +			add_pending_object_with_path(revs, b_obj, next,
> > > +						     oc2.mode,
> > > +						     oc2.path[0] ? oc2.path : NULL);
> > 
> > The fix is surprisingly simple, and I think it definitely goes in
> > the right direction.
> > 
> > Somehow, it bothers me to be forced to view (a_obj, this, from_sha1,
> > oc) vs (b_obj, next, sha1, oc2) as a sensibly corresponding pair of
> > tuples, but that is not something your introduction of "oc2"
> > started, so I won't complain ;-).
> 
> Yes, in my polishing I switched this out at least "oc_a" and "oc_b" so
> we could be sure they match correctly. I think this whole "dotdot"
> conditional could be pulled out to its own function, and probably
> consistently use "a" and "b" for the endpoints. I'll see what
> refactoring I can do to make it more readable.

The cleanup ended up being a bit bigger than I expected, but I did find
an obscure bug while I was there. And I think the end result looks
pretty decent.

The patches are listed below. There are a few things I didn't do (and
don't plan to in the near future):

  - I didn't pick up Dscho's gitattributes test. The tests in patch 9
    cover that in a much more direct fashion by looking at the diff
    headers. We _could_ still check that they respect gitattributes, but
    there's no reason that they wouldn't; the bug was before we even hit
    the diff machinery at all.

  - There is an interesting related case with attributes that wasn't
    tested by that case. If you do:

       git diff $(git rev-parse HEAD:one) $(git rev-parse HEAD:two)

    then we'll feed those sha1s to the diff machinery as the path (we
    have enough information at that point to know they aren't actually
    paths, but we have to give _something_ to the diff code to display).

    That means we'll also look for .gitattributes files that match those
    names. It would be hard to fix (because the diff machinery doesn't
    have a notion of "this path is for display, but not for attributes).
    And I doubt anybody cares (AIUI, the motivation for the original was
    not that somebody was concerned with reading what is likely to be a
    non-existent attributes file, but rather that looking at names with
    colons produces a bogus warning on Windows).

  - I noticed that the dotdot parser jumps into the middle of the string
    with a strstr(), and never tries to find other dotdots. That means
    things like:

      HEAD@{2..days.ago}...HEAD@{3..days.ago}

    does not parse (we find the first "..", realize that it's not a
    range operator, and then give up looking for more range operators).
    That could be solved by either parsing left-to-right, or by trying
    each ".." in the string in turn. I doubt anybody cares overly much.

    I think we do get the related:

      git show HEAD:foo..bar

    correct, because we see that "HEAD:foo" is not a commit and bail to
    trying the whole thing as a single unit.

I think those are all minor problems that have likely been around for
10+ years, and would take a lot of digging and work to fix. Unless
somebody actually hits one in practice, I'm happy to punt for another
decade.

  [01/15]: handle_revision_arg: reset "dotdot" consistently
  [02/15]: handle_revision_arg: simplify commit reference lookups
  [03/15]: handle_revision_arg: stop using "dotdot" as a generic pointer
  [04/15]: handle_revision_arg: hoist ".." check out of range parsing
  [05/15]: handle_revision_arg: add handle_dotdot() helper
  [06/15]: sha1_name: consistently refer to object_context as "oc"
  [07/15]: get_sha1_with_context: always initialize oc->symlink_path
  [08/15]: get_sha1_with_context: dynamically allocate oc->path
  [09/15]: t4063: add tests of direct blob diffs
  [10/15]: handle_revision_arg: record modes for "a..b" endpoints
  [11/15]: handle_revision_arg: record paths for pending objects
  [12/15]: diff: pass whole pending entry in blobinfo
  [13/15]: diff: use the word "path" instead of "name" for blobs
  [14/15]: diff: use pending "path" if it is available
  [15/15]: diff: use blob path for blob/file diffs

 builtin/cat-file.c    |   4 +-
 builtin/diff.c        |  60 ++++++-------
 builtin/grep.c        |   4 +-
 builtin/log.c         |  10 ++-
 cache.h               |  10 ++-
 revision.c            | 243 +++++++++++++++++++++++++++++---------------------
 sha1_name.c           |  11 ++-
 t/t4063-diff-blobs.sh |  96 ++++++++++++++++++++
 t/t4202-log.sh        |   9 ++
 tree-walk.c           |   1 -
 10 files changed, 301 insertions(+), 147 deletions(-)
 create mode 100755 t/t4063-diff-blobs.sh

-Peff
