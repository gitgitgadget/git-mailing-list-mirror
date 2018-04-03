Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6A01F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDCTFD (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:05:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752240AbeDCTFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 15:05:02 -0400
Received: (qmail 13563 invoked by uid 109); 3 Apr 2018 19:05:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 19:05:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31018 invoked by uid 111); 3 Apr 2018 19:06:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 15:06:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 15:05:00 -0400
Date:   Tue, 3 Apr 2018 15:05:00 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
Message-ID: <20180403190500.GA10930@sigill.intra.peff.net>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403180336.GA100220@google.com>
 <f8e171f9-0936-1412-81f9-1149fd2c5a23@gmail.com>
 <20180403184727.GC8377@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403184727.GC8377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 02:47:27PM -0400, Jeff King wrote:

> On Tue, Apr 03, 2018 at 02:29:01PM -0400, Derrick Stolee wrote:
> 
> > If we have generic "can X reach Y?" queries, then we can also use generation
> > numbers there to great effect (by not walking commits Z with gen(Z) <=
> > gen(Y)). Perhaps I should look at that "git branch --contains" thread for
> > ideas.
> 
> I think the gist of it is the patch below. Which I hastily adapted from
> the patch we run at GitHub that uses timestamps as a proxy. So it's
> possible I completely flubbed the logic. I'm assuming unavailable
> generation numbers are set to 0; the logic is actually a bit simpler if
> they end up as (uint32_t)-1.

Oh indeed, that is already the value of your UNDEF. So the patch is more
like this:

diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216a..b147b1d0ee 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1584,7 +1584,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
  */
 static enum contains_result contains_test(struct commit *candidate,
 					  const struct commit_list *want,
-					  struct contains_cache *cache)
+					  struct contains_cache *cache,
+					  uint32_t cutoff)
 {
 	enum contains_result *cached = contains_cache_at(cache, candidate);
 
@@ -1598,8 +1599,11 @@ static enum contains_result contains_test(struct commit *candidate,
 		return CONTAINS_YES;
 	}
 
-	/* Otherwise, we don't know; prepare to recurse */
 	parse_commit_or_die(candidate);
+
+	if (candidate->generation < cutoff)
+		return CONTAINS_NO;
+
 	return CONTAINS_UNKNOWN;
 }
 
@@ -1615,8 +1619,20 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 					      struct contains_cache *cache)
 {
 	struct contains_stack contains_stack = { 0, 0, NULL };
-	enum contains_result result = contains_test(candidate, want, cache);
+	enum contains_result result;
+	uint32_t cutoff = GENERATION_NUMBER_UNDEF;
+	const struct commit_list *p;
+
+	for (p = want; p; p = p->next) {
+		struct commit *c = p->item;
+		parse_commit_or_die(c);
+		if (c->generation < cutoff)
+			cutoff = c->generation;
+	}
+	if (cutoff == GENERATION_NUMBER_UNDEF)
+		cutoff = GENERATION_NUMBER_NONE;
 
+	result = contains_test(candidate, want, cache, cutoff);
 	if (result != CONTAINS_UNKNOWN)
 		return result;
 
@@ -1634,7 +1650,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		 * If we just popped the stack, parents->item has been marked,
 		 * therefore contains_test will return a meaningful yes/no.
 		 */
-		else switch (contains_test(parents->item, want, cache)) {
+		else switch (contains_test(parents->item, want, cache, cutoff)) {
 		case CONTAINS_YES:
 			*contains_cache_at(cache, commit) = CONTAINS_YES;
 			contains_stack.nr--;
@@ -1648,7 +1664,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		}
 	}
 	free(contains_stack.contains_stack);
-	return contains_test(candidate, want, cache);
+	return contains_test(candidate, want, cache, cutoff);
 }
 
 static int commit_contains(struct ref_filter *filter, struct commit *commit,
