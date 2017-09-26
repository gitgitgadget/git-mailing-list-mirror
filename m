Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F397220281
	for <e@80x24.org>; Tue, 26 Sep 2017 14:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969571AbdIZOZS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 10:25:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:46605 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969497AbdIZOZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 10:25:17 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BE874845A9;
        Tue, 26 Sep 2017 10:25:16 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7F6618458E;
        Tue, 26 Sep 2017 10:25:16 -0400 (EDT)
Subject: Re: RFC: Design and code of partial clones (now, missing commits and
 trees OK) (part 3)
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
 <af717446-95bf-c5a5-cd27-aaf20531db0f@jeffhostetler.com>
 <20170921160416.1c4c6e2c@twelve2.svl.corp.google.com>
 <7977bab0-09c3-0e43-4d6f-f2bf87a3fd9e@jeffhostetler.com>
 <20170922155802.ab79717818578a23cc31f6fe@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e05a7978-c312-9e26-79a2-fca3ae44f59a@jeffhostetler.com>
Date:   Tue, 26 Sep 2017 10:25:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922155802.ab79717818578a23cc31f6fe@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/22/2017 6:58 PM, Jonathan Tan wrote:
> On Fri, 22 Sep 2017 17:32:00 -0400
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> I guess I'm afraid that the first call to is_promised() is going
>> cause a very long pause as it loads up a very large hash of objects.
> 
> Yes, the first call will cause a long pause. (I think fsck and gc can
> tolerate this, but a better solution is appreciated.)
> 
>> Perhaps you could augment the OID lookup to remember where the object
>> was found (essentially a .promisor bit set).  Then you wouldn't need
>> to touch them all.
> 
> Sorry - I don't understand this. Are you saying that missing promisor
> objects should go into the global object hashtable, so that we can set a
> flag on them?

I just meant could we add a bit to "struct object_info" to indicate
that the object was found in a .promisor packfile ?  This could
be set in sha1_object_info_extended().

Then the is_promised() calls in fsck and gc would just test that bit.

Given that that bit will be set on promisOR objects (and we won't
have object_info for missing objects), you may need to adjust the
iterator in the fsck/gc code slightly.

This is a bit of a handwave, but could something like that eliminate
the need to build this oidset?


> 
>>> The oidset will deduplicate OIDs.
>>
>> Right, but you still have an entry for each object.  For a repo the
>> size of Windows, you may have 25M+ objects your copy of the ODB.
> 
> We have entries only for the "frontier" objects (the objects directly
> referenced by any promisor object). For the Windows repo, for example, I
> foresee that many of the blobs, trees, and commits will be "hiding"
> behind objects that the repository user did not download into their
> repo.
> 
