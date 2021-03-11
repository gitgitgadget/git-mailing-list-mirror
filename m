Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F2FC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B6C64F9C
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCKRy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:54:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:60660 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhCKRyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:54:40 -0500
Received: (qmail 16204 invoked by uid 109); 11 Mar 2021 17:54:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Mar 2021 17:54:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12095 invoked by uid 111); 11 Mar 2021 17:54:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 12:54:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 12:54:38 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <YEpZXjPxT3npyhhv@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <YEk8iiDf/FMxzhIF@coredump.intra.peff.net>
 <YEorU+rkX4sgMtKi@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEorU+rkX4sgMtKi@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 03:38:11PM +0100, Patrick Steinhardt wrote:

> > Those produce very different answers. I guess because in the first one,
> > you still have a bunch of tree objects, too. You'd do much better to get
> > the actual types from cat-file, and filter on that. That also lets you
> > use bitmaps for the traversal portion. E.g.:
> 
> They do provide different answers, and you're right that `--batch-check`
> would have helped to filter by type. Your idea doesn't really work in my
> usecase though to identify LFS pointers, at least not without additional
> tooling on top of what you've provided. There'd at least need to be two
> git-cat-file(1) processes: one to do the `--batch-check` thing to
> actually filter by object type, and one to then read the actual LFS
> pointer candidates from disk in order to see whether they are LFS
> pointers or not.
> 
> Actually, we currently are doing something similar to that at GitLab: we
> list all potential candidates via git-rev-list(1), write the output into
> `git-cat-file --batch-check`, and anything that is a blob then gets
> forwarded into `git-cat-file --batch`.

You'd need that final cat-file with your patch, too, though. So I think
it makes sense to think about "generate the list of blobs" as the
primary action.

You can of course do the type and content dump as a single cat-file, but
in my experience that is much slower (because we waste time dumping
object content that the caller ultimately won't care about).

Thinking in the opposite direction, if we are filtering by type via
cat-file, we could do the size filter there, too. So:

  git rev-list --use-bitmap-index --objects --all |
  git cat-file --batch-check='%(objecttype) %(objectsize) %(objectname)' |
  perl -lne 'print $2 if /^blob (\d+) (.*)/ && $1 < 200'

which produces the same answer as my earlier:

> >   $ time git rev-list --use-bitmap-index --objects --filter=blob:limit=200 --all |
> >          git cat-file --buffer --batch-check='%(objecttype) %(objectname)' |
> > 	 perl -lne 'print $1 if /^blob (.*)/' | wc -l

but takes about twice as long. Which is really just a roundabout way of
saying that yes, shoving things into "rev-list" can provide substantial
speedups. :)

> > which is faster than what you showed above (this is on linux.git, but my
> > result is different; maybe you have more refs than me?). But we should
> > be able to do better purely internally, so I suspect my computer is just
> > faster (or maybe your extra refs just aren't well-covered by bitmaps).
> > Running with your patches I get:
> 
> I've got quite a beefy machine with a Ryzen 3 5800X, and I did do a `git
> repack -Adfb` right before doig benchmarks. I do have the stable kernel
> repository added though, which accounts for quite a lot of additional
> references (3938) and objects (9.3M).

Yeah, I wondered if it was something like that. Mine is just
torvalds/linux.git. Fetching stable/linux.git from kernel.org, running
"git repack -adb" on the result, and then repeating my timings gets me
numbers close to yours.

> > which is indeed faster. It's quite curious that the answer is not the
> > same, though! I think yours has some bugs. If I sort and diff the
> > results, I see some commits mentioned in the output. Perhaps this is
> > --filter-provided not working, as they all seem to be ref tips.
> 
> I noticed it, too, and couldn't yet find an answer why that is.
> Honestly, I found the NOT_USER_GIVEN flag quite confusing and I'm not at
> all sure whether I've got all cases covered correctly. The previous was
> how this was handled (`USER_GIVEN` instead of `NOT_USER_GIVEN`) would've
> been easier to figure out for this specific usecase. But I guess it was
> converted due to specific reasons.
> 
> I'll invest some more time to figure out what's happening here.

Thanks. I also scratched my head at NOT_USER_GIVEN. I haven't looked at
this part of the filter code very much, but it seems like that is a
recipe for accidentally marking a commit as NOT_USER_GIVEN if we
traverse to it (even if it was originally _also_ given by the user).

-Peff

> > That's probably reasonable, especially because it lets us use bitmaps. I
> > do have a dream that we'll eventually be able to support more extensive
> > formatting via log/rev-list, which would allow:
> > 
> >   git rev-list --use-bitmap-index --objects --all \
> >                --format=%(objecttype) %(objectname) |
> >   perl -ne 'print $1 if /^blob (.*)/'
> > 
> > That should be faster than the separate cat-file (which has to re-lookup
> > each object, in addition to the extra pipe overhead), but I expect the
> > --filter solution should always be faster still, as it can very quickly
> > eliminate the majority of the objects at the bitmap level.
> 
> That'd be nice, even though it wouldn't help in my particular usecase: I
> need to read each candidate blob to see whether it's an LFS pointer or
> not anyway.

I think it works out roughly the same as the --filter solution, in the
sense that both generate a list of candidate blobs that you'd read with
"cat-file --batch" (but of course it's still slower).

-Peff
