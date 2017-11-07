Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9499B202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 18:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756365AbdKGSyX (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 13:54:23 -0500
Received: from siwi.pair.com ([209.68.5.199]:19143 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbdKGSyW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 13:54:22 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D2CBA844F3;
        Tue,  7 Nov 2017 13:54:21 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 63128844F1;
        Tue,  7 Nov 2017 13:54:21 -0500 (EST)
Subject: Re: [PATCH v2 4/6] list-objects: filter objects in
 traverse_commit_list
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
 <20171102175013.3371-5-git@jeffhostetler.com>
 <20171102123245.0f768968703ec4e35d3d1f81@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f698d5a8-bf31-cea1-a8da-88b755b0b7af@jeffhostetler.com>
Date:   Tue, 7 Nov 2017 13:54:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102123245.0f768968703ec4e35d3d1f81@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/2/2017 3:32 PM, Jonathan Tan wrote:
> On Thu,  2 Nov 2017 17:50:11 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> +		if (skip_prefix(v0, "oid=", &v1)) {
>> +			filter_options->choice = LOFC_SPARSE_OID;
>> +			if (!get_oid_with_context(v1, GET_OID_BLOB,
>> +						  &sparse_oid, &oc)) {
>> +				/*
>> +				 * We successfully converted the <oid-expr>
>> +				 * into an actual OID.  Rewrite the raw_value
>> +				 * in canonoical form with just the OID.
>> +				 * (If we send this request to the server, we
>> +				 * want an absolute expression rather than a
>> +				 * local-ref-relative expression.)
>> +				 */
> 
> I think this would lead to confusing behavior - for example, a fetch
> with "--filter=oid=mybranch:sparseconfig" would have different results
> depending on whether "mybranch" refers to a valid object locally.
> 
> The way I see it, this should either (i) only accept full 40-character
> OIDs or (ii) retain the raw string to be interpreted only when the
> filtering is done. (i) is simpler and safer, but is not so useful. In
> both cases, if the user really wants client-side interpretation, they
> can still use "$(git rev-parse foo)" to make it explicit.

Good point. I'll change it to always pass the original expression
so that it is evaluated wherever the filtering is actually performed.


> 
>> +				free((char *)filter_options->raw_value);
>> +				filter_options->raw_value =
>> +					xstrfmt("sparse:oid=%s",
>> +						oid_to_hex(&sparse_oid));
>> +				filter_options->sparse_oid_value =
>> +					oiddup(&sparse_oid);
>> +			} else {
>> +				/*
>> +				 * We could not turn the <oid-expr> into an
>> +				 * OID.  Leave the raw_value as is in case
>> +				 * the server can parse it.  (It may refer to
>> +				 * a branch, commit, or blob we don't have.)
>> +				 */
>> +			}
>> +			return 0;
>> +		}
>> +
>> +		if (skip_prefix(v0, "path=", &v1)) {
>> +			filter_options->choice = LOFC_SPARSE_PATH;
>> +			filter_options->sparse_path_value = strdup(v1);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	die(_("invalid filter expression '%s'"), arg);
>> +	return 0;
>> +}
> 
> [snip]
> 
>> +void arg_format_list_objects_filter(
>> +	struct argv_array *argv_array,
>> +	const struct list_objects_filter_options *filter_options)
> 
> Is this function used anywhere (in this patch or subsequent patches)?

It is used in upload-pack.c in part 3.  I'll remove it from part 1
and revisit in part 3.
  


>> diff --git a/list-objects-filter.c b/list-objects-filter.c
>> +/* See object.h and revision.h */
>> +#define FILTER_REVISIT (1<<25)
> 
> Looking later in the code, this flag indicates that a tree has been
> SHOWN, so it might be better to just call this FILTER_SHOWN.

I'll amend this. There are already several SHOWN bits that behave
slightly differently.  I'll update and document this better.  Thanks.


> 
> [snip]
> 
>> +struct frame {
>> +	int defval;
> 
> Document this variable?
> 
>> +	int child_prov_omit : 1;
> 
> I think it's clearer if we use "unsigned" here. Also, document this
> (e.g. "1 if any descendant of this tree object was provisionally
> omitted").

got it. thanks.


>> +enum list_objects_filter_type {
>> +	LOFT_BEGIN_TREE,
>> +	LOFT_END_TREE,
>> +	LOFT_BLOB
>> +};
> 
> Optional: probably a better name would be list_objects_filter_situation.

got it. thanks.

  
>> +void traverse_commit_list_filtered(
>> +	struct list_objects_filter_options *filter_options,
>> +	struct rev_info *revs,
>> +	show_commit_fn show_commit,
>> +	show_object_fn show_object,
>> +	void *show_data,
>> +	struct oidset *omitted)
>> +{
>> +	filter_object_fn filter_fn = NULL;
>> +	filter_free_fn filter_free_fn = NULL;
>> +	void *filter_data = NULL;
>> +
>> +	filter_data = list_objects_filter__init(omitted, filter_options,
>> +						&filter_fn, &filter_free_fn);
>> +	do_traverse(revs, show_commit, show_object, show_data,
>> +		    filter_fn, filter_data);
>> +	if (filter_data && filter_free_fn)
>> +		filter_free_fn(filter_data);
>> +}
> 
> This function traverse_commit_list_filtered() is in list-objects.c but
> in list-objects-filter.h, if I'm reading the diff correctly?

oops.  thanks.


> 
> Overall, this looks like a good change. Object traversal was upgraded
> with the behaviors of MARK_SEEN and SHOW independently controllable and
> with the ability to do things post-tree (in addition to pre-tree and
> blob), and this was used to support a few types of filtering, which
> subsequent patches will allow the user to invoke through "--filter=".
> 

thanks
Jeff
