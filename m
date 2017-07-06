Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D757B202AC
	for <e@80x24.org>; Thu,  6 Jul 2017 07:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbdGFHzJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 03:55:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:60678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751741AbdGFHzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 03:55:09 -0400
Received: (qmail 14300 invoked by uid 109); 6 Jul 2017 07:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Jul 2017 07:55:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13353 invoked by uid 111); 6 Jul 2017 07:55:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Jul 2017 03:55:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jul 2017 03:55:06 -0400
Date:   Thu, 6 Jul 2017 03:55:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
Message-ID: <20170706075506.qs7qxpi7uuwz73m2@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
 <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
 <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net>
 <xmqqa84ih5ao.fsf@gitster.mtv.corp.google.com>
 <20170706071606.doxirwm6cqx3duzg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170706071606.doxirwm6cqx3duzg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 06, 2017 at 03:16:06AM -0400, Jeff King wrote:

> If we think it's buggy, we can fix it now. But I'm not convinced that
> sequential iteration is that bad. It's at least _simple_ and easy to
> explain. The only other thing that would make sense to me is sorting the
> entries by date (reflog date, not commit date) and showing them in that
> order. But that gives rise to some funny corner cases.
> 
> What do we do if there's clock skew within the reflog (e.g., somebody
> fixed their skewed clock such that HEAD@{5} is less recent than
> HEAD@{6}). Do we show them out of order then (even if only a single
> reflog is being shown?).
> 
> Or do we try some complicated sort where entries compare sequentially
> within a given reflog, but use date comparisons between different logs?
> I don't think that can work with a normal comparison sort, as it makes
> the comparison non-transitive.
> 
> But maybe we could do a pseudo-list-merge, where we treat the reflogs as
> queues and always pick from the queue with the most recent timestamp.
> 
> That would probably be pretty easy to retrofit on the iteration from the
> current series.

Something like the patch below. Looking over the output, the
interleaving makes it look confusing (especially if you don't use
--date, since then the interleaved numbers have no relation to each
other).

It would help if we actually had a use case where somebody really did
want to show two reflogs from a single command. Then we'd know what they
were expecting and which output would be most useful, at least for that
case. But I can't really think of why you'd want to do so (which is
probably why nobody noticed for years that the current behavior is so
broken).

---
diff --git a/reflog-walk.c b/reflog-walk.c
index a7644d944e..6cdf7bfb0f 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -90,7 +90,7 @@ struct commit_reflog {
 
 struct reflog_walk_info {
 	struct commit_reflog **logs;
-	size_t nr, alloc, cur;
+	size_t nr, alloc;
 	struct string_list complete_reflogs;
 	struct commit_reflog *last_commit_reflog;
 };
@@ -284,26 +284,43 @@ int reflog_walk_empty(struct reflog_walk_info *info)
 	return !info || !info->nr;
 }
 
-struct commit *next_entry_in_log(struct commit_reflog *log)
+static void skip_unusable_entries(struct commit_reflog *log)
 {
 	while (log->recno >= 0) {
-		struct reflog_info *entry = &log->reflogs->items[log->recno--];
+		struct reflog_info *entry = &log->reflogs->items[log->recno];
 		struct object *obj = parse_object(&entry->noid);
 
 		if (obj && obj->type == OBJ_COMMIT)
-			return (struct commit *)obj;
+			return;
+		log->recno--;
 	}
-	return NULL;
+}
+
+static timestamp_t next_timestamp(struct commit_reflog *log)
+{
+	return log->reflogs->items[log->recno].timestamp;
 }
 
 struct commit *next_reflog_entry(struct reflog_walk_info *walk)
 {
-	for (; walk->cur < walk->nr; walk->cur++) {
-		struct commit *ret = next_entry_in_log(walk->logs[walk->cur]);
-		if (ret) {
-			walk->last_commit_reflog = walk->logs[walk->cur];
-			return ret;
-		}
+	struct commit_reflog *best = NULL;
+	size_t i;
+
+	for (i = 0; i < walk->nr; i++) {
+		struct commit_reflog *log = walk->logs[i];
+
+		skip_unusable_entries(log);
+		if (log->recno < 0)
+			continue;
+
+		if (!best || next_timestamp(log) > next_timestamp(best))
+			best = log;
 	}
+
+	if (best) {
+		walk->last_commit_reflog = best;
+		return lookup_commit(&best->reflogs->items[best->recno--].noid);
+	}
+
 	return NULL;
 }

The implementation is fairly naive. It would be O(nr_reflogs *
nr_entries) in the worst case. I wouldn't expect nr_reflogs to get
large. But if we cared, we could fix it by keeping the reflogs in a
heap.

-Peff
