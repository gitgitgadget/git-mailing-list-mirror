Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D312047F
	for <e@80x24.org>; Wed, 27 Sep 2017 14:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbdI0OrQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 10:47:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:64849 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbdI0OrP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 10:47:15 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9EB81845E3;
        Wed, 27 Sep 2017 10:47:14 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 59212845E2;
        Wed, 27 Sep 2017 10:47:14 -0400 (EDT)
Subject: Re: [PATCH 02/13] oidset2: create oidset subclass with object length
 and pathname
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
References: <20170922202632.53714-1-git@jeffhostetler.com>
 <20170922202632.53714-3-git@jeffhostetler.com>
 <20170926152022.67d3d6bcc93d862aa1066207@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5f028dc4-ce57-d628-19a3-006df7aa5bea@jeffhostetler.com>
Date:   Wed, 27 Sep 2017 10:47:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170926152022.67d3d6bcc93d862aa1066207@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/26/2017 6:20 PM, Jonathan Tan wrote:
> On Fri, 22 Sep 2017 20:26:21 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create subclass of oidset where each entry has a
>> field to store the length of the object's content
>> and an optional pathname.
>>
>> This will be used in a future commit to build a
>> manifest of omitted objects in a partial/narrow
>> clone/fetch.
> 
> As Brandon mentioned, I think "oidmap" should be the new data structure
> of choice (with "oidset" modified to use it).

I'll take a look at that. I'm not exactly happy with
my oidset2, but it works and it minimized touching other
things.  But yes, it may clear up a few things.


>> +struct oidset2_entry {
>> +	struct hashmap_entry hash;
>> +	struct object_id oid;
>> +
>> +	enum object_type type;
>> +	int64_t object_length;	/* This is SIGNED. Use -1 when unknown. */
>> +	char *pathname;
>> +};
> 
> object_length is defined to be "unsigned long" in Git code, I think.
> When is object_length not known, and in those cases, would it be better
> to use a separate data structure to store what we need?

Yeah, I struggled with that one.  Git currently treats file size as
a 32-bit unsigned value throughout the code.  I assume eventually there
will be a round of changes to support 64-bit values, so this anticipates
that.

I could change it to be an unknown flag, rather assuming -1, but in an
earlier draft I was printing -1 in the rev-list output.  I can change this.

WRT a separate structure, the SET I create will contain entries for items
where we may or may not know the size and that depends on the context.
When building a list of already-missing blobs (with the --filter-print-missing)
we never know the size.  But when building a list of to-be-omitted blobs
(from the current set of filter options), we may or may not know.  I'm
not sure we need 2 _entry definitions right now.

