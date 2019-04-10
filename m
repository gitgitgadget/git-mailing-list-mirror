Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A49F20305
	for <e@80x24.org>; Wed, 10 Apr 2019 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfDJW50 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 18:57:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:54318 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725982AbfDJW50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 18:57:26 -0400
Received: (qmail 31686 invoked by uid 109); 10 Apr 2019 22:57:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Apr 2019 22:57:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21436 invoked by uid 111); 10 Apr 2019 22:57:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Apr 2019 18:57:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2019 18:57:21 -0400
Date:   Wed, 10 Apr 2019 18:57:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190410225721.GA32262@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhoz8b9o.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 09, 2019 at 05:10:43PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I've found a case where turning bitmaps on does horrible things for
> bitmap "push" performance.
> [...]
> I can't share the repo, but I had a report where just a "git push" of a
> topic branch that was 2/58 ahead/behind took ~2 minutes just in
> "Enumerating objects", but ~500ms without bitmaps.

That's pretty bad, though I'm not terribly surprised. The worst cases
are ones where we have to traverse a lot to fill in the bitmap. So
either there are a lot of commits newer than the bitmapped pack, or
we've done a bad job of picking old commits to bitmap, requiring us to
walk back to find all of the reachable objects (until we find something
that does have a bitmap).

And "bad" here is somewhat subjective. The other side told us some
"have" lines, and those are what we have to walk back from. _Usually_
those would correspond to ref tips, and the bitmap code tries to put a
bitmap at each ref tip. But if you have tons of refs, it can't always do
so.

> I.e. almost all the time is in get_object_list_from_bitmap() and around
> 1m30s in just this in pack-bitmap.c:
> 
>     haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
> 
> And then another ~20s in:
> 
>     wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);

Yeah, that's where I'd expect the time to go. Inside find_objects()
we'll call traverse_commit_list() to do the actual walk.

The first walk for "haves" is looking mostly at old commits. Stuff that
is mentioned in the pack, but for which we have to walk to find the
bitmap.

The second walk for wants is probably mostly looking at new commits.
Things that don't have a bitmap yet, and for which we have to walk
(though it's interesting that it's so much more expensive than the
non-bitmap walk, which has to fully enumerate those trees itself; that
implies that some of the "haves" are recent, too, with respect to the
last pack).

> This is with 10 packs and where only the largest (initial clone pack)
> had a *.bitmap, but I can also reproduce with a 'git repack -A -d -b',
> i.e. with only one pack with a *.bitmap, although that makes it a bit
> better for the first bit, and almost completely cuts down on the time
> spent in the second phase:

Yeah, that makes sense. By repacking you've taken all those new commits
and included them in on-disk bitmaps. So I'd expect the "wants" to get
much shorter, but the "haves" phase staying long means we could do a
better job of picking commits to have on-disk bitmaps.

So two avenues for exploration I think:

  1. I've long suspected that the bitmap selection code isn't ideal.
     Both in terms of what it picks, but also in its runtime (I think it
     ends up walking the same slices of history multiple times in some
     cases).

  2. The answer we get from a bitmap versus a regular traversal are not
     apples-to-apples equivalent. The regular traversal walks down to
     the UNINTERESTING commits, marks the boundaries trees and blobs as
     UNINTERESTING, and then adds in all the interesting trees and blobs
     minus the UNINTERESTING parts. So it can sometimes give the wrong
     answer, claiming something is interesting when it is not.

     Whereas with bitmaps we fill in the trees and blobs as we walk, and
     you get the true answer. But it means we may open up a lot more
     trees than the equivalent traversal would.

     So one thing I've never really experimented with (and indeed, never
     really thought about until writing this email) is that the bitmaps
     could try to do that looser style of traversal, knowing that we
     might err on the side of calling things interesting in a few cases.
     But hopefully spending a lot less time opening trees.

     I'm not even 100% sure what that would look like in code, but just
     thinking about it from a high level, I don't there's a particular
     mathematical reason it couldn't work.

-Peff
