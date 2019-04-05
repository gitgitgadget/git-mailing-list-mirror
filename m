Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCF320248
	for <e@80x24.org>; Fri,  5 Apr 2019 22:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDEWMS (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 18:12:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49252 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726387AbfDEWMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 18:12:17 -0400
Received: (qmail 19410 invoked by uid 109); 5 Apr 2019 22:12:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 22:12:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30662 invoked by uid 111); 5 Apr 2019 22:12:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 18:12:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 18:12:15 -0400
Date:   Fri, 5 Apr 2019 18:12:15 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 0/2] Batch fetching of missing blobs in diff and show
Message-ID: <20190405221214.GB10312@sigill.intra.peff.net>
References: <20190326220906.111879-1-jonathantanmy@google.com>
 <cover.1553895166.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1553895166.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 02:39:26PM -0700, Jonathan Tan wrote:

> Thanks, everyone for the review.
> 
> Changes from v1:
>  - used test_when_finished (Szeder)
>  - used flag to inhibit fetching of missing objects (Dscho)
>  - moved the prefetch so that it also works if we request rename
>    detection, and included a test demonstrating that (not sure if that
>    was what Peff meant)

Yes, putting it in diffcore_std() is probably OK. There may be one or
two code paths that don't use that, but arguably they should, and this
will flush them out.

You could possibly get away with fetching less at that stage, since
renames would only need to see deleted/added files. But getting the
minimal set gets ugly quickly, as you have to take into account copy
settings, or even which ones we found exact matches for (where we might
not even show a content diff at all).

I think it's OK for this to be an approximation, and if anybody feels
like trying to narrow it down later, they can.

> Peff also suggested that I use an oidset instead of an oidarray in order
> to eliminate duplicates, but that makes it difficult to interface with
> fetch_objects(), which takes a pointer and a length (which is
> convenient, because if we want to fetch a single object, we can just
> point to it and use a length of 1). Maybe the best idea is to have
> oidset maintain its own OID array, and have each hash entry store an
> index instead of an OID. For now I added a NEEDSWORK.

This is probably OK. There are two reasons to deduplicate:

  1. If we expect a _lot_ of duplicates, it can be faster to de-dup as
     we go, rather than building up a giant list full of redundant
     entries (even if we later sort and de-dup it).

     But I don't think that's the case here. We'd expect relatively few
     duplicates in a single diff.

  2. If the thing we feed the result to does not handle duplicates well.
     I'm not sure how fetch_objects() does with duplicates.

If we just care about (2), then an easy fix is to just ask oid-array to
dedup. It's only mechanism right now is a for_each_unique() method,
which is not used by fetch_objects(). But it would be easy to teach it
to de-dup in place, like (completely untested):

diff --git a/sha1-array.c b/sha1-array.c
index d922e94e3f..aaea02e51e 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -78,6 +78,23 @@ int oid_array_for_each_unique(struct oid_array *array,
 	return 0;
 }
 
+int oid_array_dedup(struct oid_array *array)
+{
+	int i, j;
+
+	if (!array->sorted)
+		oid_array_sort(array);
+
+	for (i = 0; i < array->nr; i++) {
+		if (i > 0 && oideq(array->oid + i, array->oid + i - 1))
+			continue;
+		if (i == j)
+			j++;
+		else
+			array->oid[j++] = i;
+	}
+}
+
 void oid_array_filter(struct oid_array *array,
 		      for_each_oid_fn want,
 		      void *cb_data)

That could also be built on oid_array_for_each_unique(), but dealing
with the callbacks is probably worse than just reimplementing the few
lines of logic.

-Peff
