Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54AACCA473
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 09:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiGFJN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiGFJNH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 05:13:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA8F24F2F
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 02:11:15 -0700 (PDT)
Received: (qmail 2782 invoked by uid 109); 6 Jul 2022 09:11:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 09:11:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18497 invoked by uid 111); 6 Jul 2022 09:11:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 05:11:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 05:11:07 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: commit-graph overflow generation chicken and egg
Message-ID: <YsVRq82ewvvIyxDT@coredump.intra.peff.net>
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
 <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
 <YqEuE2iAmMVLlUSu@coredump.intra.peff.net>
 <Yr7jY6GjUkOzHNh6@ncase>
 <YsLE+DVa5Hd/NqdD@ncase>
 <a154e109-3f4c-c500-3365-d47879abf30d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a154e109-3f4c-c500-3365-d47879abf30d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 04, 2022 at 02:50:57PM -0600, Derrick Stolee wrote:

> > + GIT_COMMITTER_DATE='1970-01-01T00:00:00 +0100'
> 
> Because of the "+0100" in the time zone, this date
> becomes a negative value. The commit-graph does not
> store dates with more than 34 bits (and Git does
> not handle negative timestamps very well? Peff can
> clarify here).

I don't think we handle them at all. Certainly we'll refuse to parse
any, but here we get tricked by the timezone, and end up with the
underflow. Git writes 2^64 - 3600 into the commit object with this one.

The code in gm_time_t() tries to catch this (as well as overflow), but
this one gets handled by parse_date_basic(), which doesn't. Adding this
causes it barf:

diff --git a/date.c b/date.c
index 68a260c214..07a60fee35 100644
--- a/date.c
+++ b/date.c
@@ -893,8 +893,11 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 		}
 	}
 
-	if (!tm_gmt)
+	if (!tm_gmt) {
+		if (*timestamp < *offset * 60)
+			return -1;
 		*timestamp -= *offset * 60;
+	}
 	return 0; /* success */
 }
 

We should probably check for overflow there, as well, though I think in
practice it would get caught earlier. The timestamp variable comes from
tm_to_time_t(), which already has some limits.

Of course the right fix is for us to handle negative timestamps. I have
some patches working towards that, but...

> The commit-graph could certainly warn better here to
> say we do not have enough date bits to store this
> timestamp (the same would happen with a date beyond
> 2138 or something like that).

Right. By the time it gets to the commit-graph, it's a gigantic positive
time. But either way, yes, it should realize it's not representable and
omit the commit from the graph file.

That's something I haven't looked at for my negative timestamp patches
at all. I think it's OK for the commit-graph to simply punt on them, as
long as it doesn't die or produce wrong answers.

-Peff
