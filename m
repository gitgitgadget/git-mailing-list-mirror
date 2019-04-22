Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1C91F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 15:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfDVP5T (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 11:57:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:36882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727378AbfDVP5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 11:57:19 -0400
Received: (qmail 31391 invoked by uid 109); 22 Apr 2019 15:57:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 15:57:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32601 invoked by uid 111); 22 Apr 2019 15:57:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 11:57:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 11:57:16 -0400
Date:   Mon, 22 Apr 2019 11:57:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190422155716.GA9680@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <20190420035825.GB3559@sigill.intra.peff.net>
 <874l6tayzz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874l6tayzz.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 20, 2019 at 09:59:12AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > If you don't mind losing the collision-detection, using openssl's sha1
> > might help. The delta resolution should be threaded, too. So in _theory_
> > you're using 66 minutes of CPU time, but that should only take 1-2
> > minutes on your 56-core machine. I don't know at what point you'd run
> > into lock contention, though. The locking there is quite coarse.
> 
> There's also my (been meaning to re-roll)
> https://public-inbox.org/git/20181113201910.11518-1-avarab@gmail.com/
> *that* part of the SHA-1 checking is part of what's going on here. It'll
> help a *tiny* bit, but of course is part of the "trust remote" risk
> management...

I think we're talking about two different collision detections, and your
patch wouldn't help at all here.

Your patch is optionally removing the "woah, we got an object with a
duplicate sha1, let's check that the bytes are the same in both copies"
check. But Martin's problem is a clone, so we wouldn't have any existing
objects to duplicate in the first place.

The problem in his case is literally just that the actual SHA-1 is
expensive, and that can be helped by using the optimized openssl
implementation rather than the sha1dc (which checks not collisions with
objects we _have_, but evidence of somebody trying to exploit weaknesses
in sha1).

One thing we could do to make that easier is a run-time flag to switch
between sha1dc and a faster implementation (either openssl or blk_sha1,
depending on the build). That would let you flip the "trust" bit per
operation, rather than having it baked into your build.

(Note that the oft-discussed "use a faster sha1 implementation for
checksums, but sha1dc for object hashing" idea would not help here,
because these really are object hashes whose time is dominating. We have
to checksum 8GB of raw packfile but 2TB of object data).

> I started to write:
> 
>     I wonder if there's room for some tacit client/server cooperation
>     without such a protocol change.
> 
>     E.g. the server sending over a pack constructed in such a way that
>     everything required for a checkout is at the beginning of the
>     data. Now we implicitly tend to do it mostly the other way around
>     for delta optimization purposes.
> 
>     That would allow a smart client in a hurry to index-pack it as they
>     go along, and as soon as they have enough to check out HEAD return
>     to the client, and continue the rest in the background

Interesting idea. You're not reducing the total client effort, but
you're improving latency of getting the user to a checkout. Of course
that doesn't help if they want to run "git log" as their first
operation. ;)

> But realized I was just starting to describe something like 'clone
> --depth=1' followed by a 'fetch --unshallow' in the background, except
> that would work better (if you did "just the tip" naïvely you'd get
> 'missing object' on e.g. 'git log', with that ad-hoc hack we'd need to
> write out two packs etc...).

Right, that would work. I will note one thing, though: the total time to
do a 1-depth clone followed by an unshallow is probably much higher than
doing the whole clone as one unit, for two reasons:

  1. The server won't use reachability bitmaps when serving the
     follow-up fetch (because shallowness invalidates the reachability
     data they're caching), so it will spend much more time in the
     "Counting objects" phase.

  2. The server has to throw away some deltas. Imagine version X of a
     file in the tip commit is stored as a delta against version Y in
     that commit's parent. The initial clone has to throw away the
     on-disk delta of X and send you the whole object (because you are
     not requesting Y at all). And then in the follow-up fetch, it must
     either send you Y as a base object (wasting bandwidth), or it must
     on-the-fly generate a delta from Y to X (wasting CPU).

> But at this point I'm just starting to describe some shoddy version of
> Documentation/technical/partial-clone.txt :), OTOH there's no "narrow
> clone and fleshen right away" option.

Yes. And partial-clone suffers from the problems above to an even
greater extent. ;)

> On protocol extensions: Just having a way to "wget" the corresponding
> *.idx file from the server would be great, and reduce clone times by a
> lot. There's the risk of trusting the server, but most people's use-case
> is going to be pushing right back to the same server, which'll be doing
> a full validation.

One tricky thing is that the server may be handing you a bespoke .pack
file. There is no matching ".idx" at all, neither in-memory nor on disk.
And you would not want the whole on-disk .pack/.idx pair from a site
like GitHub, where there are objects from many forks.

So in general, I think you'd need some cooperation from the server side
to ask it to generate and send the .idx that matches the .pack it is
sending you. Or even if not the .idx format itself, some stable list of
sha1s that you could use to reproduce it without hashing each
uncompressed byte yourself. This could even be stuffed into the pack
format and stripped out by the receiving index-pack (i.e., each entry is
prefixed with "and by the way, here is my sha1...").

> We could also defer that validation instead of skipping it. E.g. wget
> *.{pack,idx} followed by a 'fsck' in the background. I've sometimes
> wanted that anyway, i.e. "fsck --auto" similar to "gc --auto"
> periodically to detect repository bitflips.
> 
> Or, do some "narrow" validation of such an *.idx file right
> away. E.g. for all the trees/blobs required for the current checkout,
> and background the rest.

The "do we have all of the objects we need" is already separate from
"figure out the sha1 of each object", so I think you'd get that
naturally if you just took in an untrusted .idx (it also demonstrates
that any .idx cost is really focusing on blobs, because the "do we have
all objects" check is going to decompress every commit and tree in the
repo anyway).

-Peff
