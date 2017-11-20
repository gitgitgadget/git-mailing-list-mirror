Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969DC202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbdKTU6r (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:58:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:35102 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752749AbdKTU6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:58:45 -0500
Received: (qmail 5097 invoked by uid 109); 20 Nov 2017 20:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 20:58:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16240 invoked by uid 111); 20 Nov 2017 20:59:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 15:59:00 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 15:58:43 -0500
Date:   Mon, 20 Nov 2017 15:58:43 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
Message-ID: <20171120205843.chcpp5qryhta4ctt@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
 <CAGZ79kZWJhZ-6-1MZiWK4O-uWJG+T5QU29a5fRnw6R26J4fuCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZWJhZ-6-1MZiWK4O-uWJG+T5QU29a5fRnw6R26J4fuCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 12:47:53PM -0800, Stefan Beller wrote:

> > This is the minimal fix that addresses the performance issues.
> > I'd actually have no problem at all declaring that looking up a null
> > sha1 is insane, and having the object-lookup routines simply return "no
> > such object" without even doing the loose/pack lookup first.
> >
> > I'm also fine with going down the BUG() route and fixing the
> > higher-level callers, but it's a big enough task (with little enough
> > real-world impact) that I think it would be worth applying this in the
> > meantime.
> 
> It would have a lot of impact in the future, when new developers
> are hindered mis-using the API. The (unwritten) series with introducing
> BUG() would help a lot in 'holding it right' and I would expect fewer
> performance
> regressions over time.

Yeah, I agree the BUG() route is the nicest. I started trying to hunt
down every code path causing a test failure, though, and soon got
overwhelmed.

I actually think it's not the worst thing in the world to say "it's OK
to look up the null sha1; the result is well-defined, and it does not
exist". It's perhaps philosophically a little ugly, but I think it's
quite practical.

> The patch is impressively small for such a performance gain.
> Personally I think (1) (which essentially means "making null sha1
> work like a regular sha1") is quite an endeavor at this point in time
> for this code base.

Yeah, it would be a crazy amount of effort to try to support that, for
very little gain. If we did want to just declare that the null sha1 does
not exist (even if you happen to have objects/00/00... in your
repository), the patch is similarly easy:

diff --git a/sha1_file.c b/sha1_file.c
index 8a7c6b7eba..754fe7f03e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1152,6 +1152,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 				    lookup_replace_object(sha1) :
 				    sha1;
 
+	if (is_null_sha1(sha1))
+		return -1;
+
 	if (!oi)
 		oi = &blank_oi;
 

> As a tangent, a similar but solved problem in the diff code is how
> NUL in user data is treated in xdiff for example, as there we kept
> being careful since the beginning (though I think we don't have tests
> for it, so it might be broken)

There I think it's nice if we can be tolerant of NULs, because they're a
thing that might actually happen in user input. A real null sha1 has a
2^-160 chance of happening, and the design of sha1 is such that it's
hard for somebody to do it intentionally.

You might be able to get up to some mischief with replace objects,
though.

-Peff
