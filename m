Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4571F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeKNRQz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:16:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:38630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726927AbeKNRQy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:16:54 -0500
Received: (qmail 2710 invoked by uid 109); 14 Nov 2018 07:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 07:14:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31371 invoked by uid 111); 14 Nov 2018 07:14:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 02:14:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 02:14:55 -0500
Date:   Wed, 14 Nov 2018 02:14:55 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/10] fast-export: add --always-show-modify-after-rename
Message-ID: <20181114071454.GB19904@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-11-newren@gmail.com>
 <20181111072356.GJ30850@sigill.intra.peff.net>
 <CABPp-BGREOAvF-6DBymdwsUL2LpyPNqy8dCw0RuUKZf2Da6cJA@mail.gmail.com>
 <20181112125847.GI3956@sigill.intra.peff.net>
 <CABPp-BHjPq-2JoeXur+FMs+T==arqvMaAW1uLKMSHKBKBS60rA@mail.gmail.com>
 <20181113144554.GB17454@sigill.intra.peff.net>
 <CABPp-BFbtusiT30_gU7SgmmMg25NCdgNTSEEJJysoT-1MwSnkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFbtusiT30_gU7SgmmMg25NCdgNTSEEJJysoT-1MwSnkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 09:10:36AM -0800, Elijah Newren wrote:

> > I am looking at this problem as "how do you answer question X in a
> > repository". And I think you are looking at as "I am receiving a
> > fast-export stream, and I need to answer question X on the fly".
> >
> > And that would explain why you want to get extra annotations into the
> > fast-export stream. Is that right?
> 
> I'm not trying to get information on the fly during a rewrite or
> anything like that.  This is an optional pre-rewrite step (from a
> separate invocation of the tool) where I have multiple questions I
> want to answer.  I'd like to answer them all relatively quickly, if
> possible, and I think all of them should be answerable with a single
> history traversal (plus a cat-file --batch-all-objects call to get
> object sizes, since I don't know of another way to get those).  I'd be
> fine with switching from fast-export to log or something else if it
> met the needs better.

Ah, OK. Yes, if we're just trying to query, then I think you should be
able to do what you want with the existing traversal and diff tools. And
if not, we should think about a new feature there, and not try to
shoe-horn it into fast-export.

> As far as I can tell, you're trying to split each question apart and
> do a history traversal for each, and I don't see why that's better.
> Simpler, perhaps, but it seems worse for performance.  Am I missing
> something?

I was only trying to address each possible query individually. I agree
that if you are querying both things, you should be able to do it in a
single traversal (and that is strictly better). It may require a little
more parsing of the output (e.g., `--find-object` is easy to implement
yourself looking at --raw output).

> Ah, I didn't know renames were on by default; I somehow missed that.
> Also, the rev-list to diff-tree pipe is nice, but I also need parent
> and commit timestamp information.

diff-tree will format the commit info as well (before git-log was a C
builtin, it was just a rev-list/diff-tree pipeline in a shell script).
So you can do:

  git rev-list ... |
  git diff-tree --stdin --format='%h %ct %p' --raw -r -M

and get dump very similar to what fast-export would give you.

> > >   git log -M --diff-filter=RAMD --no-abbrev --raw
> >
> > What is there besides RAMD? :)
> 
> Well, as you pointed out above, log detects renames by default,
> whereas it didn't used to.
> So, if someone had written some similar-ish history walking/parsing
> tool years ago that didn't depend need renames and was based on log
> output, there's a good chance their tool might start failing when
> rename detection was turned on by default, because instead of getting
> both a 'D' and an 'M' change, they'd get an unexpected 'R'.

Mostly I just meant: your diff-filter includes basically everything, so
why bother filtering? You're going to have to parse the result anyway,
and you can throw away uninteresting bits there.

> For my case, do I have to worry about similar future changes?  Will
> copy detection ('C') or break detection ('B') become the default in
> the future?  Do I have to worry about typechanges ('T")?  Will new
> change types be added?  I mean, the fast-export output could maybe
> change too, but it seems much less likely than with log.

If you use diff-tree, then it won't ever enable copy or break detection
without you explicitly asking for it.

> Let me try to put it as briefly as I can.  With as few traversals as
> possible, I want to:
>   * Get all blob sizes
>   * Map blob shas to filename(s) they appeared under in the history
>   * Find when files and directories were deleted (and whether they
> were later reinstated, since that means they aren't actually gone)
>   * Find sets of filenames referring to the same logical 'file'. (e.g.
> foo->bar in commit A and bar->baz in commit B mean that {foo,bar,baz}
> refer to the same 'file' so that a user has an easy report to look at
> to find out that if they just want to "keep baz and its history" then
> they need foo & bar & baz.  I need to know about things like another
> foo or bar being introduced after the rename though, since that breaks
> the connection between filenames)
>   * Do a few aggregations on the above data as well (e.g. all copies
> of postgres.exe add up to 20M -- why were those checked in anyway?,
> *.webm files in aggregate are .5G, your long-deleted src/video-server/
> directory from that aborted experimental project years ago takes up 2G
> of your history, etc.)
> 
> Right now, my best solution for this combination of questions is
> 'cat-file --batch-all-objects' plus fast-export, if I get patch 10/10
> in place.  I'm totally open to better solutions, including ones that
> don't use fast-export.

OK, I think I understand your problem better now. I don't think there's
anything fast-export can show that log/diff-tree could not, aside from
actual blob contents. But I don't think you want them (and if you did,
you can use "cat-file --batch" to selectively request them).

I think there's a general problem with any serialized output (log or
fast-export) that things like rename tracking depend on the topology. If
I rename "foo" to "bar" on one branch, and "bar" to "baz" on another
branch, without reconstructing the parent graph you don't realize that
those two things were on parallel branches, and not a sequence.  But
with the parent ids, you can delve as deep as you like in your analysis
script.

-Peff
