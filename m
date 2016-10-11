Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8001F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbcJKVVT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:21:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:56070 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752605AbcJKVVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:21:18 -0400
Received: (qmail 8963 invoked by uid 109); 11 Oct 2016 21:20:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 21:20:18 +0000
Received: (qmail 13247 invoked by uid 111); 11 Oct 2016 21:20:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 17:20:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 17:20:16 -0400
Date:   Tue, 11 Oct 2016 17:20:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] upload-pack: use priority queue in reachable() check
Message-ID: <20161011212016.hnw4dl473puhyax7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like a lot of old commit-traversal code, this keeps a
commit_list in commit-date order, and and inserts parents
into the list. This means each insertion is potentially
linear, and the whole thing is quadratic (though the exact
runtime depends on the relationship between the commit dates
and the parent topology).

These days we have a priority queue, which can do the same
thing with a much better worst-case time.

Signed-off-by: Jeff King <peff@peff.net>
---
This was inspired by a real-world case where several instances of
upload-pack were chewing minutes of CPU, and backtraces in each instance
pointed to this function.  Unfortunately, I only saw the server side of
these requests. I pulled the contents of have_obj and want_obj out of
the process via gdb, but I wasn't able to reproduce the slow fetch.

So I'm not 100% sure that this fixes it, but the problem hasn't happened
again. And it certainly seems like it couldn't _hurt_ to optimize this.

 upload-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 5ec21e6..d9e381f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "argv-array.h"
+#include "prio-queue.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -319,12 +320,12 @@ static int got_sha1(const char *hex, unsigned char *sha1)
 
 static int reachable(struct commit *want)
 {
-	struct commit_list *work = NULL;
+	struct prio_queue work = { compare_commits_by_commit_date };
 
-	commit_list_insert_by_date(want, &work);
-	while (work) {
+	prio_queue_put(&work, want);
+	while (work.nr) {
 		struct commit_list *list;
-		struct commit *commit = pop_commit(&work);
+		struct commit *commit = prio_queue_get(&work);
 
 		if (commit->object.flags & THEY_HAVE) {
 			want->object.flags |= COMMON_KNOWN;
@@ -340,12 +341,12 @@ static int reachable(struct commit *want)
 		for (list = commit->parents; list; list = list->next) {
 			struct commit *parent = list->item;
 			if (!(parent->object.flags & REACHABLE))
-				commit_list_insert_by_date(parent, &work);
+				prio_queue_put(&work, parent);
 		}
 	}
 	want->object.flags |= REACHABLE;
 	clear_commit_marks(want, REACHABLE);
-	free_commit_list(work);
+	clear_prio_queue(&work);
 	return (want->object.flags & COMMON_KNOWN);
 }
 
-- 
2.10.1.572.g142464c
