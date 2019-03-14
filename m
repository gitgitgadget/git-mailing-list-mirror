Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01249202BB
	for <e@80x24.org>; Thu, 14 Mar 2019 16:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfCNQEN (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 12:04:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:51192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726157AbfCNQEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 12:04:13 -0400
Received: (qmail 25580 invoked by uid 109); 14 Mar 2019 16:04:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 16:04:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24272 invoked by uid 111); 14 Mar 2019 16:03:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 12:03:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 12:02:56 -0400
Date:   Thu, 14 Mar 2019 12:02:56 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190314160256.GA1573@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190314091254.nescpfp3n6mbjpmh@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 09:12:54AM +0000, Eric Wong wrote:

> > The reason it defaults to off is for on-disk compatibility with JGit.
> 
> Right.  Our documentation seems to indicate JGit just warns (but
> doesn't fall over), so maybe that can be considered separately.

I think it was a hard error in the beginning, but they changed it pretty
soon after we added more flags. So it might be reasonable to just enable
it by default (but it wouldn't hurt to double check the behavior).

I tried running t5310 (which does a back-and-forth with jgit) using this
patch:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a154fc29f6..5264bf055a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -97,7 +97,7 @@ static off_t reuse_packfile_offset;
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
 static int write_bitmap_index;
-static uint16_t write_bitmap_options;
+static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
 static int exclude_promisor_objects;
 

and it seemed happy.

> As far as serving clones and fetches, public-inbox-init has
> always created bare repos with bitmaps enabled, but without
> the hash-cache for compatibility concerns.
> 
> That's a lot of fetches and clones over the years.

The symptom you'd see is that "Compressing objects" during a fetch takes
a long time, and/or produces lousy deltas. But it matters less if:

  - you keep things packed pretty promptly, because we don't bother
    looking for new deltas between objects in the same pack. Just trying
    to clone public-inbox.org/git, it does look like it's mostly packed
    (based on the object counts) but the compression phase still takes
    10+ seconds.

  - how much the names actually help. In your case, I'd think not at
    all, because being based on hashes, they're effectively random. So
    the pack-objects heuristics to try to find deltas between files of
    similar filenames will not help you.

Regarding the second thing, I wondered if the overall packing of your
public-inbox git repo might not be good, so I did a "git repack -adf
--window=1000" on a clone.  Hundreds of CPU minutes later, I was only
able to shave off about 80MB. I'm not sure if that means you
occasionally do very aggressive repacks, or if there simply isn't all
that much delta opportunity (after all, you're not storing many versions
of one file, but rather tons of different emails; I would expect to find
deltas between various versions of a patch, though).

Anyway...

> ---------8<-----------
> Subject: [PATCH] repack: enable bitmaps by default on bare repos
> 
> A typical use case for bare repos is for serving clones and
> fetches to clients.  Enable bitmaps by default on bare repos to
> make it easier for admins to host git repos in a performant way.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> Helped-by: Jeff King <peff@peff.net>

This version looks good to me. If we're going to flip the hash-cache
default, I think that should be a separate patch anyway.

-Peff
