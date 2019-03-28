Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C84202BB
	for <e@80x24.org>; Thu, 28 Mar 2019 06:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfC1Gwz (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 02:52:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:38592 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726379AbfC1Gwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 02:52:54 -0400
Received: (qmail 15889 invoked by uid 109); 28 Mar 2019 06:52:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Mar 2019 06:52:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3043 invoked by uid 111); 28 Mar 2019 06:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Mar 2019 02:53:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2019 02:52:52 -0400
Date:   Thu, 28 Mar 2019 02:52:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: batch fetching of missing blobs
Message-ID: <20190328065252.GA1930@sigill.intra.peff.net>
References: <20190326220906.111879-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326220906.111879-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 03:09:06PM -0700, Jonathan Tan wrote:

> When running a command like "git show" or "git diff" in a partial clone,
> batch all missing blobs to be fetched as one request.
> 
> This is similar to c0c578b33c ("unpack-trees: batch fetching of missing
> blobs", 2017-12-08), but for another command.

Sounds like a good idea, and this should make some cases much better
without making any cases worse. Two observations about how we might do
even better, though:

> @@ -6067,6 +6068,32 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
> [...]

At this stage we're looking at actually diffing the contents themselves.
But we'd also potentially need the blobs during rename and break
detection. It's not always the same set of blobs (e.g., unless you've
cranked up the copy-detection flags, renames only look at added/deleted
entries). We could have each phase do its own bulk fetch, which
worst-case gives us probably three fetches. But I wonder if we could
figure out a complete plausible set immediately after the tree diff.

> +	if (repository_format_partial_clone) {
> +		/*
> +		 * Prefetch the diff pairs that are about to be flushed.
> +		 */
> +		struct oid_array to_fetch = OID_ARRAY_INIT;
> +		int fetch_if_missing_store = fetch_if_missing;
> +
> +		fetch_if_missing = 0;
> +		for (i = 0; i < q->nr; i++) {
> +			struct diff_filepair *p = q->queue[i];
> +			if (!check_pair_status(p))
> +				continue;
> +			if (p->one && p->one->oid_valid &&
> +			    !has_object_file(&p->one->oid))
> +				oid_array_append(&to_fetch, &p->one->oid);
> +			if (p->two && p->two->oid_valid &&
> +			    !has_object_file(&p->two->oid))
> +				oid_array_append(&to_fetch, &p->two->oid);
> +		}

These has_object_file() calls may repeatedly re-scan the pack directory,
once per call.  Since it's likely that some may be missing, that may be
a noticeable amount of wasted work for a big diff (still way less than
individually fetching each missing object, so it's a net win, but read
on).

If you use the QUICK flag, that avoids the re-scans, but we may miss
erroneously say "we don't have it" if we race with a repack. For that,
we can either:

  1. Just ignore it. It's relatively rare, and the worst case is that we
     re-fetch an object.

  2. Do a series of QUICK checks, followed by a single
     reprepare_packed_git() if we had any missing, and then another
     series of QUICK checks. Then worst-case we have a single re-scan.

Something like:

  int object_is_missing_cb(const struct object_id *oid, void *data)
  {
	return !has_object_file_with_flags(oid, OBJECT_INFO_QUICK);
  }
  ...

  /* collect all of the possible blobs we need */
  for (i = 0; i < q->nr; i++) {
	...
	oid_array_append(&to_fetch, &p->one->oid);
	oid_array_append(&to_fetch, &p->two->oid);
  }

  /* drop any we already have */
  oid_array_filter(&to_fetch, object_is_missing_cb, NULL);

  /* any missing ones might actually be a race; try again */
  if (to_fetch.nr) {
	  reprepare_packed_git(the_repository);
	  oid_array_filter(&to_fetch, object_is_missing_cb, NULL);
  }

  /* and now anything we have left is definitely not here */
  if (to_fetch.nr)
	fetch_objects(..., to_fetch.oid, to_fetch.nr).

One thing I noticed while writing this: we don't seem to do any
de-duplication of the list (in yours or mine), and it doesn't look like
fetch_objects() does either. I wonder if an oidset would be a better
data structure.

-Peff
