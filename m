Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE5E202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933769AbdKPRX7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:23:59 -0500
Received: from siwi.pair.com ([209.68.5.199]:31927 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdKPRX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:23:58 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4F815844D5;
        Thu, 16 Nov 2017 12:23:57 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B6017844CB;
        Thu, 16 Nov 2017 12:23:56 -0500 (EST)
Subject: Re: [PATCH v3 4/6] list-objects: filter objects in
 traverse_commit_list
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171107193546.10017-1-git@jeffhostetler.com>
 <20171107193546.10017-5-git@jeffhostetler.com>
 <20171107152034.47686f6ece72ea3d43005b12@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <61855872-221b-0e97-abaa-24a011ad899e@jeffhostetler.com>
Date:   Thu, 16 Nov 2017 12:23:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171107152034.47686f6ece72ea3d43005b12@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/7/2017 6:20 PM, Jonathan Tan wrote:
> On Tue,  7 Nov 2017 19:35:44 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> +/*
>> + * Reject the arg if it contains any characters that might
>> + * require quoting or escaping when handing to a sub-command.
>> + */
>> +static int reject_injection_chars(const char *arg)
>> +{
> [snip]
>> +}
> 
> Someone pointed me to quote.{c,h}, which is probably sufficient to
> ensure shell safety if we do invoke subcommands through the shell. If
> that is so, we probably don't need a blacklist.
> 
> Having said that, though, it might be safer to still introduce one, and
> relax it later if necessary - it is much easier to relax a constraint
> than to increase one.

I couldn't use quote.[ch] because it is more concerned with
quoting pathnames because of LF and CR characters within
them -- rather than semicolons and quotes and the like which
I was concerned about.

Anyway, in my next patch series I've replaced all of the
injection code from my last series with something a little
stronger and not restricting.

> 
>> +	} else if (skip_prefix(arg, "sparse:", &v0)) {
>> +
>> +		if (skip_prefix(v0, "oid=", &v1)) {
>> +			struct object_context oc;
>> +			struct object_id sparse_oid;
>> +			filter_options->choice = LOFC_SPARSE_OID;
>> +			if (!get_oid_with_context(v1, GET_OID_BLOB,
>> +						  &sparse_oid, &oc))
>> +				filter_options->sparse_oid_value =
>> +					oiddup(&sparse_oid);
>> +			return 0;
>> +		}
> 
> In your recent e-mail [1], you said that you will change it to always pass
> the original expression - is that still the plan?
> 
> [1] https://public-inbox.org/git/f698d5a8-bf31-cea1-a8da-88b755b0b7af@jeffhostetler.com/

yes.  I always pass filter_options.raw_value over the wire.
The code above tries to parse it and put it in an OID for
private use by the current process -- just like the size limit
value in the blob:limit filter.

>> +/* Remember to update object flag allocation in object.h */
> 
> You probably can delete this line.

Every other place that defined flag bits included this comment,
so I did too.  (It really made it easier to find the other
random places that define bits, actually.)

> 
>> +/*
>> + * FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects
>> + * that have been shown, but should be revisited if they appear
>> + * in the traversal (until we mark it SEEN).  This is a way to
>> + * let us silently de-dup calls to show() in the caller.
> 
> This is unclear to me at first reading. Maybe something like:
> 
>    FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects that have
>    been shown, but should not be skipped over if they reappear in the
>    traversal. This ensures that the tree's descendants are re-processed
>    if the tree reappears subsequently, and that the tree is not shown
>    twice.
> 
>> + * This
>> + * is subtly different from the "revision.h:SHOWN" and the
>> + * "sha1_name.c:ONELINE_SEEN" bits.  And also different from
>> + * the non-de-dup usage in pack-bitmap.c
>> + */
> 
> Optional: I'm not sure if this comparison is useful. (Maybe it is useful
> to others, though.)

I was thinking the first comment about my FILTER_SHOWN field
would be to ask why I wasn't just using the existing SHOWN bit.
There are subtle differences between the bits and I wanted to
point out that I was not just duplicating the usage of an existing
bit.
  
> 
>> +/*
>> + * A filter driven by a sparse-checkout specification to only
>> + * include blobs that a sparse checkout would populate.
>> + *
>> + * The sparse-checkout spec can be loaded from a blob with the
>> + * given OID or from a local pathname.  We allow an OID because
>> + * the repo may be bare or we may be doing the filtering on the
>> + * server.
>> + */
>> +struct frame {
>> +	/*
>> +	 * defval is the usual default include/exclude value that
>> +	 * should be inherited as we recurse into directories based
>> +	 * upon pattern matching of the directory itself or of a
>> +	 * containing directory.
>> +	 */
>> +	int defval;
> 
> Can this be an "unsigned defval : 1" as well? In the function below, I
> see that you assign to an "int val" first (which can take -1, 0, and 1)
> before assigning to this, so that is fine.
> 
> Also, maybe a better name would be "exclude", with the documentation:
> 
>    1 if the directory is excluded, 0 otherwise. Excluded directories will
>    still be recursed through, because an "include" rule for an object
>    might override an "exclude" rule for one of its ancestors.
> 

The name "defval" is used unpack-trees.c during the clear_ce_flags()
recursion while looking at the exclusion list.  I was just trying to
match that behavior.

Thanks
Jeff
