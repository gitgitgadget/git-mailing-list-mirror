Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6A61F462
	for <e@80x24.org>; Fri, 24 May 2019 21:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391771AbfEXVBU (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 17:01:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:10890 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391738AbfEXVBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 17:01:19 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 313F93F4090;
        Fri, 24 May 2019 17:01:17 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:a930:ecfb:793f:8fff] (unknown [IPv6:2001:4898:a800:1012:5a64:ecfb:793f:8fff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A062A3F408A;
        Fri, 24 May 2019 17:01:16 -0400 (EDT)
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
To:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Cc:     matvore@comcast.net
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
Date:   Fri, 24 May 2019 17:01:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/21/2019 8:21 PM, Matthew DeVore wrote:
> Allow combining filters such that only objects accepted by all filters
> are shown. The motivation for this is to allow getting directory
> listings without also fetching blobs. This can be done by combining
> blob:none with tree:<depth>. There are massive repositories that have
> larger-than-expected trees - even if you include only a single commit.
> 
> The current usage requires passing the filter to rev-list, or sending
> it over the wire, as:
> 
> 	combine:<FILTER1>+<FILTER2>

I must admit I'm not a fan of this syntax and the URL-encoding
that it requires.  I see that this was already discussed in the
RFC version [1] last week, but I'll repeat it here.

I like the repeated used of the "--filter=<f_k>" command line option.


In the RFC version, there was discussion [2] of the wire format
and the need to be backwards compatible with existing servers and
so use the "combine:" syntax so that we only have a single filter
line on the wire.  Would it be better to have compliant servers
advertise a "filters" (plural) capability in addition to the
existing "filter" (singular) capability?  Then the client would
know that it could send a series of filter lines using the existing
syntax.  Likewise, if the "filters" capability was omitted, the
client could error out without the extra round-trip.


[1] https://public-inbox.org/git/xmqqwoip3gp0.fsf@gitster-ct.c.googlers.com/
[2] 
https://public-inbox.org/git/1E174CAA-BD57-400B-A83B-4AABFAFBC04B@comcast.net/


[...]
>   standard input when --stdin is used). <depth>=1 will include only the
>   tree and blobs which are referenced directly by a commit reachable from
>   <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
>   while also including trees and blobs one more level removed from an
>   explicitly-given commit or tree.
> ++
> +The form '--filter=combine:<filter1>+<filter2>+...<filterN>' combines
> +several filters.

We are allowing an unlimited number of filters in the composition.
In the code, the compose filter data has space for a LHS and RHS, so
I'm assuming we're mapping

     --filter=f1 --filter=f2 --filter=f3 --filter=f4
or  --filter=combine:f1+f2+f3+f4
into basically
     (compose f1 (compose f2 (compose (f3 f4)))

I wonder if it would be easier to understand if we just built an array
or linked list, but I'll read on.

>                    Only objects which are accepted by every filter are
> +included. Filters are joined by '{plus}' and individual filters are %-encoded
> +(i.e. URL-encoded). Besides the '{plus}' and '%' characters, the following
> +characters are reserved and also must be encoded:
> +`~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+ as well as all characters with ASCII code
> +&lt;= `0x20`, which includes space and newline.
[...]


> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index 8e8616b9b8..b97277a46f 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -453,34 +453,148 @@ static void filter_sparse_path__init(
>   
>   	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
>   	d->array_frame[d->nr].defval = 0; /* default to include */
>   	d->array_frame[d->nr].child_prov_omit = 0;
>   
>   	ctx->filter_fn = filter_sparse;
>   	ctx->free_fn = filter_sparse_free;
>   	ctx->data = d;
>   }
>   
> +struct filter_combine_data {
> +	/* sub[0] corresponds to lhs, sub[1] to rhs. */
> +	struct {
> +		struct filter_context ctx;
> +		struct oidset seen;
> +		struct object_id skip_tree;
> +		unsigned is_skipping_tree : 1;
> +	} sub[2];
> +
> +	struct oidset rhs_omits;
> +};
> +
> +static void add_all(struct oidset *dest, struct oidset *src) {
> +	struct oidset_iter iter;
> +	struct object_id *src_oid;
> +
> +	oidset_iter_init(src, &iter);
> +	while ((src_oid = oidset_iter_next(&iter)) != NULL)
> +		oidset_insert(dest, src_oid);
> +}
> +
> +static void filter_combine_free(void *filter_data)
> +{
> +	struct filter_combine_data *d = filter_data;
> +	int i;
> +
> +	/* Anything omitted by rhs should be added to the overall omits set. */
> +	if (d->sub[0].ctx.omits)
> +		add_all(d->sub[0].ctx.omits, d->sub[1].ctx.omits);
> +
> +	for (i = 0; i < 2; i++) {
> +		list_objects_filter__release(&d->sub[i].ctx);
> +		oidset_clear(&d->sub[i].seen);
> +	}
> +	oidset_clear(&d->rhs_omits);
> +	free(d);
> +}
> +
> +static int should_delegate(enum list_objects_filter_situation filter_situation,
> +			   struct object *obj,
> +			   struct filter_combine_data *d,
> +			   int side)
> +{
> +	if (!d->sub[side].is_skipping_tree)
> +		return 1;
> +	if (filter_situation == LOFS_END_TREE &&
> +		oideq(&obj->oid, &d->sub[side].skip_tree)) {
> +		d->sub[side].is_skipping_tree = 0;
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static enum list_objects_filter_result filter_combine(
> +	struct repository *r,
> +	enum list_objects_filter_situation filter_situation,
> +	struct object *obj,
> +	const char *pathname,
> +	const char *filename,
> +	struct filter_context *ctx)
> +{
> +	struct filter_combine_data *d = ctx->data;
> +	enum list_objects_filter_result result[2];
> +	enum list_objects_filter_result combined_result = LOFR_ZERO;
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
> +		if (oidset_contains(&d->sub[i].seen, &obj->oid) ||
> +			!should_delegate(filter_situation, obj, d, i)) {

Should we swap the order of the terms in the || so that we always
clear the d->sub[i].is_skipping_tree on LOFS_END_TREE ?


> +			result[i] = LOFR_ZERO;
> +			continue;
> +		}
> +
> +		result[i] = d->sub[i].ctx.filter_fn(
> +			r, filter_situation, obj, pathname, filename,
> +			&d->sub[i].ctx);
> +
> +		if (result[i] & LOFR_MARK_SEEN)
> +			oidset_insert(&d->sub[i].seen, &obj->oid);

So filter[i] has said it never wants to show this object (hard omit).
And the guard at the top of the loop will prevent future invocations
from checking it again if the object is revisited.

> +
> +		if (result[i] & LOFR_SKIP_TREE) {
> +			d->sub[i].is_skipping_tree = 1;
> +			d->sub[i].skip_tree = obj->oid;

So this marks the tree object at the top of the skip as far as
filter[i] is concerned.

> +		}
> +	}
> +
> +	if ((result[0] & LOFR_DO_SHOW) && (result[1] & LOFR_DO_SHOW))
> +		combined_result |= LOFR_DO_SHOW;
> +	if (d->sub[0].is_skipping_tree && d->sub[1].is_skipping_tree)
> +		combined_result |= LOFR_SKIP_TREE;

Something about the above bothers me, but I can't quite say what
it is.

Do we need to do:
     if ((result[0] & LOFR_MARK_SEEN) && (result[1] & LOFR_MARK_SEEN))
         combined_result |= LOFR_MARK_SEEN;


> +
> +	return combined_result;
> +}
[...]


I'm out of time now, will pick this up again next week.

Thanks
Jeff

