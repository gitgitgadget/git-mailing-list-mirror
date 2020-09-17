Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB4C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 12:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2E321582
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 12:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgIQMxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 08:53:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:59834 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgIQMxk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 08:53:40 -0400
Received: (qmail 32749 invoked by uid 109); 17 Sep 2020 12:53:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 12:53:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8126 invoked by uid 111); 17 Sep 2020 12:53:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 08:53:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 08:53:33 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: approximate_object_count_valid never set?
Message-ID: <20200917125333.GA3024501@coredump.intra.peff.net>
References: <4a018cb9-da40-a98f-a1b9-73be30ae79ec@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a018cb9-da40-a98f-a1b9-73be30ae79ec@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 10:20:03AM +0200, Rasmus Villemoes wrote:

> Hi,
> 
> While poking around the code, I noticed that it seems
> ->approximate_object_count_valid is never set to 1, and it never has
> been, not even back when it was a global variable. So perhaps it can
> just be removed and the logic depending on it simplified? Or am I
> missing some preprocessor trickery.
> 
> Nobody seems to have noticed the lack of caching - and actually setting
> it to 1 after the count has been computed might be a little dangerous
> unless one takes care to invalidate the cache anywhere that might be
> relevant.

We should be able to construct a test where it matters. The main cost
that the flag is overcoming is the iteration through the packs. So we'd
want a lot of packs. And the primary place the function would get called
a lot is when abbreviating commits. So doing:

  for i in $(seq 1000); do
    echo blob
    echo 'data <<EOF'
    echo $i
    echo EOF
    echo checkpoint
  done | git -c transfer.unpacklimit=0 fast-import

will get us a lot of packs. I tried that in linux.git. And then this
should get us a baseline for how much it costs to traverse and print out
object names:

  $ time git rev-list --format=%H HEAD >/dev/null
  real	0m6.636s
  user	0m6.492s
  sys	0m0.144s

And now let's see how long it takes with abbreviation:

  $ time git rev-list --format=%h HEAD  >/dev/null
  real	0m34.518s
  user	0m34.253s
  sys	0m0.264s

Yow. That's a lot. But part of the cost is that we have to look up each
abbreviated hash in each pack to see if it's present there, so we'd
expect it to be a lot more expensive. But let's try it with the caching
flag:

diff --git a/packfile.c b/packfile.c
index 9ef27508f2..e69012e7f2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -923,6 +923,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 			count += p->num_objects;
 		}
 		r->objects->approximate_object_count = count;
+		r->objects->approximate_object_count_valid = 1;
 	}
 	return r->objects->approximate_object_count;
 }

  $ time git rev-list --format=%h HEAD  >/dev/null
  real	0m29.411s
  user	0m29.150s
  sys	0m0.260s

Still not great, but caching the count did save us 15%. That seems worth
it to me (1000 packs is more than we'd hope for, but not uncommon in a
poorly maintained repo). The failure to set the flag is just a bug;
looks like mine from 8e3f52d778 (find_unique_abbrev: move logic out of
get_short_sha1(), 2016-10-03).

You're right that caching runs the risk of the cache being invalidated.
But in this case I think we're covered. We'd generally modify packed_git
only via reprepare_packed_git(), prepare_packed_git(), and we do reset
the flag there. Plus count is only meant to be approximate, so even if
it ended up stale within a single process, I don't think it would be
that big a deal.

-Peff
