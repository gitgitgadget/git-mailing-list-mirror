Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660FD202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 16:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbdJSQFf (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 12:05:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:57632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752213AbdJSQFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 12:05:34 -0400
Received: (qmail 25363 invoked by uid 109); 19 Oct 2017 16:05:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:05:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9056 invoked by uid 111); 19 Oct 2017 16:05:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 12:05:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 12:05:32 -0400
Date:   Thu, 19 Oct 2017 12:05:32 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, t.gummerer@gmail.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v1] read_index_from(): Skip verification of the cache
 entry order to speed index loading
Message-ID: <20171019160532.54teojqnhkeo2yfv@sigill.intra.peff.net>
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com>
 <db8da340-f8f5-0114-392d-e415b5564993@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db8da340-f8f5-0114-392d-e415b5564993@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 11:12:03AM -0400, Ben Peart wrote:

> > So, I think I like the direction of getting rid of the order
> > validation in post_read_index_from(), not only during the normal
> > operation but also in fsck.  I think it makes more sense to do so
> > incrementally inside do_read_index() all the time and see how fast
> > we can make it do so.
> 
> Unfortunately, all the cost is in the strcmp() - the other tests are
> negligible so moving it to be done incrementally inside do_read_index()
> won't reduce the cost, it just moves it and makes it harder to identify.

It's plausible that doing the strcmp() closer to where we are otherwise
manipulating the data may show an improvement due to memory cache
effects.

It should be easy enough to check that; the patch below implements it.
I couldn't measure any speedup with it running "git ls-files >/dev/null"
on linux.git (60k files). But nor could I get any by dropping the check
entirely.

This is mostly just a curiosity to me. For the record, I have no real
problem with dropping this kind of on-disk data-structure validation
when it's expensive. After all, we do not check the sort on pack .idx
files on each run (nor pack sha1 checksums, etc) because it's too
expensive to do so.

---
diff --git a/read-cache.c b/read-cache.c
index 65f4fe8375..ac8c8d2e93 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1664,25 +1664,19 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
-static void check_ce_order(struct index_state *istate)
-{
-	unsigned int i;
-
-	for (i = 1; i < istate->cache_nr; i++) {
-		struct cache_entry *ce = istate->cache[i - 1];
-		struct cache_entry *next_ce = istate->cache[i];
-		int name_compare = strcmp(ce->name, next_ce->name);
-
-		if (0 < name_compare)
-			die("unordered stage entries in index");
-		if (!name_compare) {
-			if (!ce_stage(ce))
-				die("multiple stage entries for merged file '%s'",
-				    ce->name);
-			if (ce_stage(ce) > ce_stage(next_ce))
-				die("unordered stage entries for '%s'",
-				    ce->name);
-		}
+static void check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce)
+{
+	int name_compare = strcmp(ce->name, next_ce->name);
+
+	if (0 < name_compare)
+		die("unordered stage entries in index");
+	if (!name_compare) {
+		if (!ce_stage(ce))
+			die("multiple stage entries for merged file '%s'",
+			    ce->name);
+		if (ce_stage(ce) > ce_stage(next_ce))
+			die("unordered stage entries for '%s'",
+			    ce->name);
 	}
 }
 
@@ -1720,7 +1714,6 @@ static void tweak_split_index(struct index_state *istate)
 
 static void post_read_index_from(struct index_state *istate)
 {
-	check_ce_order(istate);
 	tweak_untracked_cache(istate);
 	tweak_split_index(istate);
 }
@@ -1784,6 +1777,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
+		if (i > 0)
+			check_ce_order(istate->cache[i - 1], ce);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;
