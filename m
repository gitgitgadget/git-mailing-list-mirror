Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6F71F463
	for <e@80x24.org>; Sat, 14 Sep 2019 03:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390557AbfINDaT (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 23:30:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:50056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731113AbfINDaT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 23:30:19 -0400
Received: (qmail 8063 invoked by uid 109); 14 Sep 2019 03:30:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Sep 2019 03:30:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22280 invoked by uid 111); 14 Sep 2019 03:32:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2019 23:32:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Sep 2019 23:30:17 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: diff.renames not working?
Message-ID: <20190914033017.GA30458@sigill.intra.peff.net>
References: <CAHd499BT35jvPtsuD9gfJB0HJ=NxtzyQOaiD7-=sHJbFYhphpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499BT35jvPtsuD9gfJB0HJ=NxtzyQOaiD7-=sHJbFYhphpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 03:24:06PM -0500, Robert Dailey wrote:

> Now my goal is to diff `ZPayClient.hpp` and see the changes to the
> moved-out portion of code as it relates to the original state of that
> code in `JniPaymentManager.hpp`. To do this, I tried this command:
> 
> ```
> $ git diff master...topic -- ZPay/ZPayClient.hpp
> ```
> 
> The unified diff header I got back is:
> 
> ```
> diff --git ZPay/ZPayClient.hpp ZPay/ZPayClient.hpp
> new file mode 100644
> index 00000000..6ebc2a9a
> --- /dev/null
> +++ ZPay/ZPayClient.hpp
> ```
> 
> Hmm, it's treating it as a new file. Even though I have `diff.renames`
> set to `copies`? Even though `diff --name-status` acknowledges the
> relationship with the original file for the code on `master`? This is
> confusing...

This is due to the way that rename detection works. When looking for
renames, the tree diff gives us a series of candidate "sources" that
were deleted and candidates "dests" that were added. And then we try to
match them up.

Copy detection differs in that it uses any file touched in the diff as a
source, not just deletions.

And then "--find-copies-harder" uses even unmodified files as sources
(but see below).

So here's a simplified setup:

  git init repo
  cd repo

  seq 100 >a
  git add a
  git commit -m a

  cp a b
  seq 99 >a
  git add a b
  git commit -m b

and then we can try these commands:

  # this won't find a rename, because "a" was not deleted
  git diff-tree --name-status -M HEAD^ HEAD

  # this will find the copy, because now we consider "a" a source
  git diff-tree --name-status -C HEAD^ HEAD

  # this _won't_ find the copy, because we limited our tree diff to
  # just look at "b"; hence we don't even consider "a" a source
  git diff-tree --name-status -C HEAD^ HEAD -- b

And that last one is the one that confused you. Naively it seems like
doing this would work (two "-C" are the same as "--find-copies-harder"):

  git diff-tree --name-status -C -C HEAD^ HEAD -- b

but it doesn't. That's because we're still using the tree diff to find
sources, and just adding unmodified entries to the source list. But our
pathspec prevents the diff from even considering "a". While this might
seem useless at first, you can imagine something like:

  git diff-tree -C -C HEAD^ HEAD -- subdir/

which would consider all files in subdir as sources, but not those
outside (which may be especially important for performance).

But there's no (clean) way to expand the set of paths that we consider
as sources without also showing them in the output. There are two
useful variants I could imagine, though:

  - a way to consider _all_ paths in the repository, not just those in
    the pathspec, as sources, but show only the entries from the
    pathspec. This could probably be a "harder" version of
    "--find-copies-harder", something like "-C -C -C <revs> -- b".
    Naturally this would be even more expensive in a big repo.

  - a way to independently specify the source pathspec and the
    output-limiting pathspec. This is a cheaper version of the one
    above, where you could look at a subset of the tree a sources, but
    limit the set of shown paths even further. It's not conceptually
    that difficult, but syntactically it gets weird since you have two
    lists of pathspecs on the command-line.

I think the first one wouldn't be _too_ hard if somebody is interested
in getting their feet wet with the diffcore-rename.c code. The second is
probably not worth the effort.

> Out of curiosity, I thought I'd try this command:
> 
> ```
> git diff --follow master...topic -- ZPay/ZPayClient.hpp
> ```

So yes, that does work, and is why I added the "(clean)" qualifier
above. It behaves like the "-C -C -C" I proposed. But the fact that it
does so is entirely accidental. What happens is this:

  - we're a little sloppy about what constitutes a traversal option and
    what is a diff option. Many diff commands rely on setup_revisions(),
    which parses both. So "diff --follow" probably _should_ be flagged
    as an error, but isn't.

  - the implementation of "--follow" works by doing a separate,
    from-scratch tree-level diff on each commit (it _has_ to ignore your
    pathspec, since by definition it allows only a single file to be in
    the pathspec). And then rather than throwing away that result, it
    feeds it to the rest of the diff pipeline, which then shows the
    output you expected.

So it does do what you want, but only for the single-file case. And
certainly it was never intended to, and that might change in the future.

> Now this looks more like it. I can actually see a useful diff here,
> instead of everything looking like a new file. But there is a lot of
> confusion here:
> 
> 1. `diff --follow` is not a documented[1] option. Why does it work?

Accident. :) See above.

> 2. `diff -M` doesn't actually work either. It should, though. In fact,
> I expected it to work as `--follow` does. But it doesn't.

It doesn't work because this is a copy, not a rename.

> 3. The `diff.renames` config doesn't seem to be working here, when it should.

It does, but the pathspec prevents it from finding a source candidate.

-Peff
