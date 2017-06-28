Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DCB1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 17:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdF1RNZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 13:13:25 -0400
Received: from siwi.pair.com ([209.68.5.199]:14116 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbdF1RNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 13:13:25 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CD9AA84564;
        Wed, 28 Jun 2017 13:13:23 -0400 (EDT)
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7C83C84562;
        Wed, 28 Jun 2017 13:13:23 -0400 (EDT)
Subject: Re: [PATCH 1/3] list-objects: add filter_blob to traverse_commit_list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <20170622203615.34135-1-git@jeffhostetler.com>
 <20170622203615.34135-2-git@jeffhostetler.com>
 <xmqqy3scw06y.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e2216ab8-5af7-4edd-16aa-f84a45e0cbd7@jeffhostetler.com>
Date:   Wed, 28 Jun 2017 13:13:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3scw06y.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/28/2017 12:23 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> diff --git a/list-objects.c b/list-objects.c
>> index f3ca6aa..c9ca81c 100644
>> --- a/list-objects.c
>> +++ b/list-objects.c
>> @@ -24,11 +25,28 @@ static void process_blob(struct rev_info *revs,
>>   		die("bad blob object");
>>   	if (obj->flags & (UNINTERESTING | SEEN))
>>   		return;
>> -	obj->flags |= SEEN;
>>   
>>   	pathlen = path->len;
>>   	strbuf_addstr(path, name);
>> -	show(obj, path->buf, cb_data);
>> +	if (!filter_blob) {
>> +		/*
>> +		 * Normal processing is to imediately dedup blobs
>> +		 * during commit traversal, regardless of how many
>> +		 * times it appears in a single or multiple commits,
>> +		 * so we always set SEEN.
>> +		 */
>> +		obj->flags |= SEEN;
>> +		show(obj, path->buf, cb_data);
>> +	} else {
>> +		/*
>> +		 * Use the filter-proc to decide whether to show
>> +		 * the blob.  We only set SEEN if requested.  For
>> +		 * example, this could be used to omit a specific
>> +		 * blob until it appears with a ".git*" entryname.
>> +		 */
>> +		if (filter_blob(obj, path->buf, &path->buf[pathlen], cb_data))
>> +			obj->flags |= SEEN;
>> +	}
> 
> This somehow looks a bit surprising organization and division of
> responsibility.  I would have expected
> 
> 	if (!filter_blob ||
> 	    filter_blob(obj, path->buf, &path->buf[pathlen], cb_data) {
> 		obj->flags |= SEEN;
> 		show(obj, path->buf, cb_data);
> 	}
> 
> i.e. making the filter function responsible for only making a
> decision to include or exclude, not giving it a chance to decide to
> "show" anything different.

Yes, my logic was a little confusing there.  Jonathan Tan said
something similar the other day.  I have a new version that I'm
working on now that looks like this:

	list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_SHOW;
	...
	if (filter)
		r = filter(obj, path->buf, ...
	if (r & LOFR_MARK_SEEN)
		obj->flags |= SEEN;
	if (r & LOFR_SHOW)
		show(obj, path->buf, cb_data);

I'm generalizing it a little to let the filter return 2 flags:
() SEEN to indicate that the filter doesn't want to see it again
() SHOW to include the object in the result.
These let filters do "hard" and "provisional" omits.  (This will
make more sense later when I get my patch cleaned up.)


>> @@ -67,6 +85,7 @@ static void process_gitlink(struct rev_info *revs,
>>   static void process_tree(struct rev_info *revs,
>>   			 struct tree *tree,
>>   			 show_object_fn show,
>> +			 filter_blob_fn filter_blob,
>>   			 struct strbuf *base,
>>   			 const char *name,
>>   			 void *cb_data)
>> @@ -111,7 +130,7 @@ static void process_tree(struct rev_info *revs,
>>   		if (S_ISDIR(entry.mode))
>>   			process_tree(revs,
>>   				     lookup_tree(entry.oid->hash),
>> -				     show, base, entry.path,
>> +				     show, filter_blob, base, entry.path,
>>   				     cb_data);
>>   		else if (S_ISGITLINK(entry.mode))
>>   			process_gitlink(revs, entry.oid->hash,
> 
> I wonder if we'll need filter_tree_fn in the future in this
> codepath.  When somebody wants to do a "narrow fetch/clone", would
> the approach taken by this series, i.e. decide not to show certain
> objects during the "rev-list --objects" traversal, a good precedent
> to follow?  Would this approach be a good foundation to build on
> such a future?

Yes, I'm including similar logic inside process_tree() to allow that
and let the filter know about entering and leaving each tree.  So we
only need one filter-proc to handle a particular strategy and it will
handle both tree and blob objects.

I want to be able to use this mechanism to do narrow clone/fetch
using such a filter-proc and a sparse-checkout-like spec.

Thanks,
Jeff


