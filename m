Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034261F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFCVvb (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:51:31 -0400
Received: from siwi.pair.com ([209.68.5.199]:49977 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfFCVva (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:51:30 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EDE1C3F4024;
        Mon,  3 Jun 2019 17:51:29 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:59ab:b3d9:a0d9:493a] (unknown [IPv6:2001:4898:a800:1012:adf:b3d9:a0d9:493a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 46EC83F4019;
        Mon,  3 Jun 2019 17:51:29 -0400 (EDT)
Subject: Re: [PATCH v2 4/9] list-objects-filter: implement composite filters
To:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com
Cc:     matvore@comcast.net, Junio C Hamano <gitster@pobox.com>
References: <20190601003603.90794-1-matvore@google.com>
 <20190601003603.90794-5-matvore@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0005347e-ceed-ac9e-ad0d-b7b11bc55d38@jeffhostetler.com>
Date:   Mon, 3 Jun 2019 17:51:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190601003603.90794-5-matvore@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/31/2019 8:35 PM, Matthew DeVore wrote:
> Allow combining filters such that only objects accepted by all filters
> are shown. The motivation for this is to allow getting directory
> listings without also fetching blobs. This can be done by combining
> blob:none with tree:<depth>. There are massive repositories that have
> larger-than-expected trees - even if you include only a single commit.
> 
> The current usage requires passing the filter to rev-list in the
> following form:
> 
> 	--filter=<FILTER1> --filter=<FILTER2> ...
> 
> Such usage is currently an error, so giving it a meaning is backwards-
> compatible.
> 
> The URL-encoding method is being implemented before the repeated flag
> logic, and the user-facing documentation for URL-encoding is being
> withheld until the repeated flag feature is implemented. The
> URL-encoding is in general not meant to be used directly by the user,
> and it is better to describe the URL-encoding feature in terms of the
> repeated flag.
> 
> Helped-by: Emily Shaffer <emilyshaffer@google.com>
> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>   list-objects-filter-options.c       | 135 ++++++++++++++++++++++-
>   list-objects-filter-options.h       |  17 ++-
>   list-objects-filter.c               | 159 +++++++++++++++++++++++++++
>   t/t6112-rev-list-filters-objects.sh | 163 +++++++++++++++++++++++++++-
>   4 files changed, 468 insertions(+), 6 deletions(-)
> 

[...]

> +static enum list_objects_filter_result filter_combine(
> +	struct repository *r,
> +	enum list_objects_filter_situation filter_situation,
> +	struct object *obj,
> +	const char *pathname,
> +	const char *filename,
> +	struct oidset *omits,
> +	void *filter_data)
> +{
> +	struct combine_filter_data *d = filter_data;
> +	enum list_objects_filter_result combined_result =
> +		LOFR_DO_SHOW | LOFR_MARK_SEEN | LOFR_SKIP_TREE;
> +	size_t sub;
> +
> +	for (sub = 0; sub < d->nr; sub++) {
> +		enum list_objects_filter_result sub_result = process_subfilter(
> +			r, filter_situation, obj, pathname, filename,
> +			&d->sub[sub]);
> +		if (!(sub_result & LOFR_DO_SHOW))
> +			combined_result &= ~LOFR_DO_SHOW;
> +		if (!(sub_result & LOFR_MARK_SEEN))
> +			combined_result &= ~LOFR_MARK_SEEN;
> +		if (!d->sub[sub].is_skipping_tree)
> +			combined_result &= ~LOFR_SKIP_TREE;
> +	}
> +
> +	return combined_result;
> +}

This may be too subtle a point for this phase, so feel free to ignore
this.

Since we are assuming 'compose' is an AND operation, there may be an
opportunity to short-cut some of this loop for blobs.  That is, if the
object is a blob and any filter rejects it, it is omitted, so we don't
need to keep looping for that object.  (Tree objects cannot be short-cut
this way because a tree may appear at different depths or in different
sparse "cones" and may have to be reconsidered.)

So you could add an "affects blobs only" bit to the per-filter data
and try this out.  For example a "compose:blob:none+sparse:foo" should
perform better than "compose:sparse:foo+blob:none" but give the same
results.

Again, this might be premature, so feel free to disregard.
Jeff

