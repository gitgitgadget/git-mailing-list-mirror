Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3468E207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 16:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033195AbdDTQOL (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 12:14:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:36896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033141AbdDTQOI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 12:14:08 -0400
Received: (qmail 16663 invoked by uid 109); 20 Apr 2017 16:14:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:14:01 +0000
Received: (qmail 4602 invoked by uid 111); 20 Apr 2017 16:14:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 12:14:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 12:13:59 -0400
Date:   Thu, 20 Apr 2017 12:13:59 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
Message-ID: <20170420161359.haolllw4ac5jjqx4@sigill.intra.peff.net>
References: <20170418194421.22453-1-git@jeffhostetler.com>
 <20170418194421.22453-2-git@jeffhostetler.com>
 <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
 <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
 <20170419025608.xy5nvso6k6lb5z7g@sigill.intra.peff.net>
 <20170419031839.m2zgwywa2soejiqk@sigill.intra.peff.net>
 <40228c69-7946-3ef1-35de-4cea9b0312e4@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40228c69-7946-3ef1-35de-4cea9b0312e4@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 10:00:04AM -0400, Jeff Hostetler wrote:

> Perhaps the thing to learn from this (and the other ones) is that
> we have lots of places where we are building a sorted list by
> iterating over a sorted list.  The insert routines are general
> purpose and cannot assume this, so they search first.  Perhaps it
> would be clearer to have independent _append and _insert functions
> and have the caller explicitly call the appropriate one.  The mainline
> iterations on the existing index could just call the _append form
> and never have to worry about searching or the negative-integer
> return trick.  Whereas, the random iterations (such as on the
> command's arg list), would always call the _insert form.

Yes. I'd be much happier if your patch was flipping between two
general-purpose insertion functions. And if that same trick was used on
the dst side.

Or even, given that this these functions are called from a single
location that has sorted input, the binary search was just replaced
completely with an append combined with a sort-check.

That's not the minimal change you were going for, but I think the end
result is simpler and more consistent.

E.g., something like this:

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c86b..a5c017198 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -43,26 +43,20 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two)
 }
 
 /*
- * Returns 0 on success, -1 if we found a duplicate.
+ * Returns 0 on success, -1 if we found a duplicate or a sorting problem.
  */
 static int add_rename_dst(struct diff_filespec *two)
 {
-	int first = find_rename_dst(two);
-
-	if (first >= 0)
+	if (rename_dst_nr > 0 &&
+	    strcmp(two->path, rename_dst[rename_dst_nr - 1].two->path) <= 0)
 		return -1;
-	first = -first - 1;
 
-	/* insert to make it at "first" */
 	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
+	rename_dst[rename_dst_nr].two = alloc_filespec(two->path);
+	fill_filespec(rename_dst[rename_dst_nr].two,
+		      two->oid.hash, two->oid_valid, two->mode);
+	rename_dst[rename_dst_nr].pair = NULL;
 	rename_dst_nr++;
-	if (first < rename_dst_nr)
-		memmove(rename_dst + first + 1, rename_dst + first,
-			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
-	rename_dst[first].two = alloc_filespec(two->path);
-	fill_filespec(rename_dst[first].two, two->oid.hash, two->oid_valid,
-		      two->mode);
-	rename_dst[first].pair = NULL;
 	return 0;
 }
 
@@ -73,36 +67,17 @@ static struct diff_rename_src {
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
-static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
+static int register_rename_src(struct diff_filepair *p)
 {
-	int first, last;
-	struct diff_filespec *one = p->one;
-	unsigned short score = p->score;
-
-	first = 0;
-	last = rename_src_nr;
-	while (last > first) {
-		int next = (last + first) >> 1;
-		struct diff_rename_src *src = &(rename_src[next]);
-		int cmp = strcmp(one->path, src->p->one->path);
-		if (!cmp)
-			return src;
-		if (cmp < 0) {
-			last = next;
-			continue;
-		}
-		first = next+1;
-	}
+	if (rename_src_nr > 0 &&
+	    strcmp(p->one->path, rename_src[rename_src_nr - 1].p->one->path) <= 0)
+		return -1;
 
-	/* insert to make it at "first" */
 	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
+	rename_src[rename_src_nr].p = p;
+	rename_src[rename_src_nr].score = p->score;
 	rename_src_nr++;
-	if (first < rename_src_nr)
-		memmove(rename_src + first + 1, rename_src + first,
-			(rename_src_nr - first - 1) * sizeof(*rename_src));
-	rename_src[first].p = p;
-	rename_src[first].score = score;
-	return &(rename_src[first]);
+	return 0;
 }
 
 static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
@@ -468,7 +443,7 @@ void diffcore_rename(struct diff_options *options)
 				continue;
 			else if (add_rename_dst(p->two) < 0) {
 				warning("skipping rename detection, detected"
-					" duplicate destination '%s'",
+					" duplicate or out-of-order destination '%s'",
 					p->two->path);
 				goto cleanup;
 			}
@@ -486,7 +461,12 @@ void diffcore_rename(struct diff_options *options)
 			 */
 			if (p->broken_pair && !p->score)
 				p->one->rename_used++;
-			register_rename_src(p);
+			if (register_rename_src(p) < 0) {
+				warning("skipping rename detection, detected"
+					" duplicate or out-of-order source '%s'",
+					p->one->path);
+				goto cleanup;
+			}
 		}
 		else if (detect_rename == DIFF_DETECT_COPY) {
 			/*
@@ -494,7 +474,12 @@ void diffcore_rename(struct diff_options *options)
 			 * one, to indicate ourselves as a user.
 			 */
 			p->one->rename_used++;
-			register_rename_src(p);
+			if (register_rename_src(p) < 0) {
+				warning("skipping rename detection, detected"
+					" duplicate or out-of-order source '%s'",
+					p->one->path);
+				goto cleanup;
+			}
 		}
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
