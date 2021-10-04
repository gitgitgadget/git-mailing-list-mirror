Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFBC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 08:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4676061248
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 08:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJDIWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 04:22:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:60248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhJDIWe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 04:22:34 -0400
Received: (qmail 8725 invoked by uid 109); 4 Oct 2021 08:20:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 08:20:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12192 invoked by uid 111); 4 Oct 2021 08:20:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 04:20:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 04:20:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Andrzej Hunt <andrzej@ahunt.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hash: reduce size of algo member of object ID
Message-ID: <YVq5XCyLDr0SPBzx@coredump.intra.peff.net>
References: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
 <YVq3rqwz82RgpUfl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVq3rqwz82RgpUfl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 04:13:34AM -0400, Jeff King wrote:

> It looks like adding the "algo" field did make a big difference for the
> oid_array case, but changing it to a char doesn't seem to help at all:
> 
>   $ hyperfine -L v none,int,char './git.{v} cat-file --batch-all-objects --batch-check="%(objectname)"'
>   Benchmark #1: ./git.none cat-file --batch-all-objects --batch-check="%(objectname)"
>     Time (mean ± σ):      1.653 s ±  0.009 s    [User: 1.607 s, System: 0.046 s]
>     Range (min … max):    1.640 s …  1.670 s    10 runs
>    
>   Benchmark #2: ./git.int cat-file --batch-all-objects --batch-check="%(objectname)"
>     Time (mean ± σ):      1.067 s ±  0.012 s    [User: 1.017 s, System: 0.050 s]
>     Range (min … max):    1.053 s …  1.089 s    10 runs
>    
>   Benchmark #3: ./git.char cat-file --batch-all-objects --batch-check="%(objectname)"
>     Time (mean ± σ):      1.092 s ±  0.013 s    [User: 1.046 s, System: 0.046 s]
>     Range (min … max):    1.080 s …  1.116 s    10 runs
>    
>   Summary
>     './git.int cat-file --batch-all-objects --batch-check="%(objectname)"' ran
>       1.02 ± 0.02 times faster than './git.char cat-file --batch-all-objects --batch-check="%(objectname)"'
>       1.55 ± 0.02 times faster than './git.none cat-file --batch-all-objects --batch-check="%(objectname)"'
> 
> I'm actually surprised it had this much of an impact. But I guess this
> benchmark really is mostly just memcpy-ing oids into a big array,
> sorting it, and printing the result. If that array is 12% bigger, we'd
> expect at least a 12% speedup. But adding in non-linear elements like
> growing the array (though I guess that is amortized linear) and sorting
> (which picks up an extra log(n) term) make the difference.
> 
> It's _kind of_ silly in a sense, since usually you'd ask for other parts
> of the object, which will make the speed difference relatively smaller.
> But just dumping a bunch of oids is actually not an unreasonable thing
> to do. I suspect it got a lot slower with 32-byte GIT_MAX_RAWSZ, too
> (even when you're using 20-byte sha1), but I don't think there's an easy
> way to get out of that.

Oh wait, I'm reading it totally wrong. Adding in the extra 4 bytes
actually made it _faster_ than not having an algo field. Now I'm
super-confused. I could believe that it gave us some better alignment,
but the original struct was 32 bytes. 36 seems like a strictly worse
number.

-Peff
