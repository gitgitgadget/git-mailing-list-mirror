Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62F3C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 14:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhLNOey (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:34:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:51558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhLNOex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 09:34:53 -0500
Received: (qmail 13898 invoked by uid 109); 14 Dec 2021 14:34:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 14:34:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25018 invoked by uid 111); 14 Dec 2021 14:34:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 09:34:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 09:34:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Message-ID: <YbirjNDX2bQPqRPD@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
 <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
 <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
 <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
 <211210.86czm4d3zo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211210.86czm4d3zo.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 01:31:10PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I don't think using ssize_t like that is portable, and that we'd need
> something like intmax_t if we needed this in another context.
> 
> Firstly it's not standard C, it's just in POSIX, intmax_t is standard C
> as of C99, which and we have in-tree code that already depends on it
> (and uintmax_t).
> 
> But more importantly it's not "as big as size_t, just signed" in
> POSIX. size_t is "no greater than the width of type long"[1] and
> LONG_MAX is at least 2^31-1 [2].

Thanks, I didn't know that about ssize_t. I do wonder how often it is
_not_ the case that it is of the same magnitude as size_t. Certainly I
can see how write() could decide to just work in SSIZE_MAX chunks, since
the caller has to be prepared to loop anyway. But it seems like the
obvious implementation is for it to be a signed size_t; I'd be curious
to hear of any platforms that diverge from this (i.e., is this a real
portability concern, or like NULL pointers that aren't all-zeroes, one
that we don't care about in practice).

I do suspect we've already made that assumption elsewhere, though it's
hard to easily see. Grepping for ssize_t turns up lots of reasonable and
legitimate uses. Though some like the one in strbuf_realpath() are
questionable (it's assigning from an int!).

> 3. B.t.w. a thing I ended up ejecting out of this was that I made a
>    "test_commit_bulkier" which is N times faster than "test_commit_bulk",
>    it just makes the same commit N times with the printf-repeating feature
>    and feeds it to fast-import, but the test took so long in any case that
>    I couldn't find a plausible way to get it in-tree).

Yes, I noticed it was rather slow. The main culprit is Git writing out
new blobs and trees for each commit, which is what I assume your
"bulkier" version skipped (the existing "bulk" one is careful not to
use any sub-processes).  You can instruct test_commit_bulk to use
identical content in each commit, which saves a lot of time.

It's also highly non-linear in the number of commits when the tree
changes. That suggests that fast-import's tree-handling could be
improved. Here are the results of the hacky perf script below, showing
both the non-linearity in the "full" case and how much faster the
"quick" (commits-only) case is:

  Test                 this tree        
  --------------------------------------
  1234.2: full 1000    0.35(0.27+0.08)  
  1234.3: full 2000    0.85(0.81+0.04)  
  1234.4: full 4000    3.21(3.09+0.11)  
  1234.5: full 8000    12.13(11.85+0.27)
  1234.6: quick 1000   0.14(0.12+0.02)  
  1234.7: quick 2000   0.20(0.18+0.03)  
  1234.8: quick 4000   0.31(0.28+0.04)  
  1234.9: quick 8000   0.58(0.55+0.03)  

-- >8 --
#!/bin/sh

test_description='foo'
. ./perf-lib.sh

test_expect_success 'empty repo' 'git init'

test_perf 'full 1000' 'test_commit_bulk --id=full 1000'
test_perf 'full 2000' 'test_commit_bulk --id=full 2000'
test_perf 'full 4000' 'test_commit_bulk --id=full 4000'
test_perf 'full 8000' 'test_commit_bulk --id=full 8000'

test_perf 'quick 1000' 'test_commit_bulk --id=quick --filename=foo --contents=bar 1000'
test_perf 'quick 2000' 'test_commit_bulk --id=quick --filename=foo --contents=bar 2000'
test_perf 'quick 4000' 'test_commit_bulk --id=quick --filename=foo --contents=bar 4000'
test_perf 'quick 8000' 'test_commit_bulk --id=quick --filename=foo --contents=bar 8000'

test_done
-- >8 --
