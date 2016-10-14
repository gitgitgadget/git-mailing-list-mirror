Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91691F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 19:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbcJNTAs (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 15:00:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:57593 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752516AbcJNTAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 15:00:45 -0400
Received: (qmail 22240 invoked by uid 109); 14 Oct 2016 18:59:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 18:59:55 +0000
Received: (qmail 8074 invoked by uid 111); 14 Oct 2016 19:00:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 15:00:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2016 14:59:53 -0400
Date:   Fri, 14 Oct 2016 14:59:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fetch: use "quick" has_sha1_file for tag following
Message-ID: <20161014185953.k4b5xwihlgvxurjc@sigill.intra.peff.net>
References: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
 <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
 <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
 <20161013165344.jv7hyj74q33yb4ip@sigill.intra.peff.net>
 <20161013170443.43slna3zvcvrse5r@sigill.intra.peff.net>
 <20161013200644.lnustevmpvufbg5y@sigill.intra.peff.net>
 <xmqqfunyzv6f.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfunyzv6f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 10:39:52AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So it's certainly better. But 7500 packs is just silly, and squeezing
> > out ~400ms there is hardly worth it. If you repack this same case into a
> > single pack, the command drops to 5ms. So yes, there's close to an order
> > of magnitude speedup here, but you get that _and_ another order of
> > magnitude just by repacking.
> 
> "7500 is silly" equally applies to the "quick" (and sloppy, if I am
> reading your "Failing in this direction doesn't make me feel great."
> correctly) approach, I think, which argues for not taking either
> change X-<.

I wouldn't quite agree that they're the same. 7500 packs is silly
because a bunch of _other_ things are going to get equally or more slow
before the prepare_packed_git() slowdown is noticeable. And it's in your
power to clean up, and we should encourage users to do so.

Whereas having a bunch of unfetched tags is a state that may linger
indefinitely, and be outside the user's control.

I _am_ open to the argument that calling reprepare_packed_git() over and
over doesn't really matter much if you have a sane number of packs. If
you tweak my perf test like so:

diff --git a/t/perf/p5550-fetch-tags.sh b/t/perf/p5550-fetch-tags.sh
index a5dc39f..7e7ae24 100755
--- a/t/perf/p5550-fetch-tags.sh
+++ b/t/perf/p5550-fetch-tags.sh
@@ -86,7 +86,7 @@ test_expect_success 'create child packs' '
 		cd child &&
 		git config gc.auto 0 &&
 		git config gc.autopacklimit 0 &&
-		create_packs 500
+		create_packs 10
 	)
 '
 

you get:

Test            origin            quick                 
--------------------------------------------------------
5550.4: fetch   0.06(0.02+0.02)   0.02(0.01+0.00) -66.7%

Still an impressive speedup as a percentage, but negligible in absolute
terms. But that's on a local filesystem on a Linux machine. I'd worry
much more about a system with a slow readdir(), e.g., due to NFS.
Somebody's real-world NFS case[1] was what prompted us to do 0eeb077
(index-pack: avoid excessive re-reading of pack directory, 2015-06-09).

It looks like I _did_ look into optimizing this into a single stat()
call in the thread at [1]. I completely forgot about that. I did find
there that naively using stat_validity() on a directory is racy, though
I wonder if we could do something clever with gettimeofday() instead.
IOW, the patches there only bothered to re-read when they saw the mtime
on the directory jump, which suffers from 1-second precision problems.
But if we instead compared the mtime to the current time, we could err
in favor of re-reading the packs, and get false positives for at most 1
second.

[1] http://public-inbox.org/git/7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com/

> I agree that the fallout from the inaccuracy of "quick" approach is
> probably acceptable and the next "fetch" will correct it anyway, so
> let's do the "quick but inaccurate" for now and perhaps cook it in
> 'next' for a bit longer than other topics?

I doubt that cooking in 'next' for longer will turn up anything useful.
The case we care about is the race between a repack and a fetch. We
lived with the "quick" version of has_sha1_file() everywhere for 8
years. I only noticed the race on a hosting cluster which puts through
millions of operations per day (I could in theory test the patch on that
same cluster, but we actually don't do very many fetches).

-Peff
