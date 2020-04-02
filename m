Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3527C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8973F206E9
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 20:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x+9wytqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgDBUI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:08:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58475 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgDBUI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 16:08:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A647CCE52;
        Thu,  2 Apr 2020 16:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UKFjqK0jvPqf5j7yWdqmSaqyda4=; b=x+9wyt
        qHHOXoD1YvYFFBPT+Sncd4s3w9M8sKE0NdKwD/QJfR5YvZVT6ULCYvO6eqhr41n4
        TWcDUVGmNPJpSuH++IT9U56jPeazPUUjxElrQ/QcsNb9XQ+4G07oQA3kpqyzNo5o
        ROksLbnj7qXywmOyjVKSojxig+RzSGer+gd/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MCQ2C/Pa09hMruRTKivw9XkID7laM95T
        j51pK8+r6wq7qaLaENLrRrnUcCPHdMnX1bJqxtvrZNwAeDTq227kI0cVgziHpWlN
        hy/nMNQUg5KNyW4BHKAZStbhrVz/cbmeO/SE+86qIGsHvKgmq26ogAojcjsCWKWh
        SJZm+n3ee60=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8272DCCE51;
        Thu,  2 Apr 2020 16:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C58C7CCE50;
        Thu,  2 Apr 2020 16:08:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] diff: restrict when prefetching occurs
References: <20200331020418.55640-1-jonathantanmy@google.com>
        <cover.1585854639.git.jonathantanmy@google.com>
        <a3322cdedf019126305fcead5918d523a1b2dfbc.1585854639.git.jonathantanmy@google.com>
Date:   Thu, 02 Apr 2020 13:08:51 -0700
In-Reply-To: <a3322cdedf019126305fcead5918d523a1b2dfbc.1585854639.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 2 Apr 2020 12:19:17 -0700")
Message-ID: <xmqq7dyx3b1o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C63746BA-751D-11EA-B5A7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +	int prefetched = 0;
> +	int output_formats_to_prefetch = DIFF_FORMAT_DIFFSTAT |
> +		DIFF_FORMAT_NUMSTAT |
> +		DIFF_FORMAT_PATCH |
> +		DIFF_FORMAT_SHORTSTAT |
> +		DIFF_FORMAT_DIRSTAT;

Would this want to be a "const int" (or even #define), I wonder.  I
do not care too much between the two, but leaving it as a variable
makes me a bit nervous.

> +	/*
> +	 * Check if the user requested a blob-data-requiring diff output and/or
> +	 * break-rewrite detection (which requires blob data). If yes, prefetch
> +	 * the diff pairs.
> +	 *
> +	 * If no prefetching occurs, diffcore_rename() will prefetch if it
> +	 * decides that it needs inexact rename detection.
> +	 */

Name-only etc. that Derrick mentioned in the other thread would be
relevant only when rename detection is active, and you'd do that in
diffcore_rename().  Good.

> +	if (options->repo == the_repository && has_promisor_remote() &&
> +	    (options->output_format & output_formats_to_prefetch ||
> +	     (!options->found_follow && options->break_opt != -1))) {
>  		int i;
>  		struct diff_queue_struct *q = &diff_queued_diff;
>  		struct oid_array to_fetch = OID_ARRAY_INIT;
>  
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			add_if_missing(options->repo, &to_fetch, p->one);
> -			add_if_missing(options->repo, &to_fetch, p->two);
> +			diff_add_if_missing(options->repo, &to_fetch, p->one);
> +			diff_add_if_missing(options->repo, &to_fetch, p->two);
>  		}
> +
> +		prefetched = 1;
> +

Wouldn't it logically make more sense to do this after calling
promisor_remote_get_direct() and if to_fetch.nr is not 0, ...

>  		/*
>  		 * NEEDSWORK: Consider deduplicating the OIDs sent.
>  		 */
>  		promisor_remote_get_direct(options->repo,
>  					   to_fetch.oid, to_fetch.nr);
> +

... namely, here?

When (q->nr != 0), to_fetch.nr may not be zero, I suspect, but the
original code before [1/2] protected against to_fetch.nr==0 case, so
...?

>  		oid_array_clear(&to_fetch);
>  	}
>  
> @@ -6537,7 +6555,7 @@ void diffcore_std(struct diff_options *options)
>  			diffcore_break(options->repo,
>  				       options->break_opt);
>  		if (options->detect_rename)
> -			diffcore_rename(options);
> +			diffcore_rename(options, prefetched);
>  		if (options->break_opt != -1)
>  			diffcore_merge_broken();
>  	}
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index e189f407af..79ac1b4bee 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -7,6 +7,7 @@
>  #include "object-store.h"
>  #include "hashmap.h"
>  #include "progress.h"
> +#include "promisor-remote.h"
>  
>  /* Table of rename/copy destinations */
>  
> @@ -448,7 +449,7 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
>  	return count;
>  }
>  
> -void diffcore_rename(struct diff_options *options)
> +void diffcore_rename(struct diff_options *options, int prefetched)
>  {
>  	int detect_rename = options->detect_rename;
>  	int minimum_score = options->rename_score;
> @@ -538,6 +539,40 @@ void diffcore_rename(struct diff_options *options)
>  		break;
>  	}
>  
> +	if (!prefetched) {
> +		/*
> +		 * At this point we know there's actual work to do: we have rename
> +		 * destinations that didn't find an exact match, and we have potential
> +		 * sources. So we'll have to do inexact rename detection, which
> +		 * requires looking at the blobs.
> +		 *
> +		 * If we haven't already prefetched, it's worth pre-fetching
> +		 * them as a group now.
> +		 */

This comment makes me wonder if it would be even better to

 - prepare an empty to_fetch OID array in the caller,

 - if the output format is one of the ones that wants prefetch, add
   object names to to_fetch in the caller, BUT not fetch there.

 - pass &to_fetch by the caller to this function, and this code here
   may add even more objects,

 - then do the prefetch here (so a single promisor interaction will
   grab objects the caller would have fetched before calling us and
   the ones we want here), and then clear the to_fetch array.

 - the caller, after seeing this function returns, checks to_fetch
   and if it is not empty, fetches (i.e. the caller prepared list of
   objects based on the output type, we ended up not calling this
   helper, and then finally the caller does the prefetch).

That way, the "unless we have already prefetched" logic can go, and
we can lose one indentation level, no?


> +		int i;
> +		struct oid_array to_fetch = OID_ARRAY_INIT;
> +
> +		for (i = 0; i < rename_dst_nr; i++) {
> +			if (rename_dst[i].pair)
> +				continue; /* already found exact match */
> +			diff_add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
> +		}
> +		for (i = 0; i < rename_src_nr; i++) {
> +			if (skip_unmodified &&
> +			    diff_unmodified_pair(rename_src[i].p))
> +				/*
> +				 * The "for" loop below will not need these
> +				 * blobs, so skip prefetching.
> +				 */
> +				continue;
> +			diff_add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);
> +		}
> +		if (to_fetch.nr)
> +			promisor_remote_get_direct(options->repo,
> +						   to_fetch.oid, to_fetch.nr);

You no longer need the if(), no?

> +		oid_array_clear(&to_fetch);
> +	}
