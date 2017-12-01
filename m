Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256B720954
	for <e@80x24.org>; Fri,  1 Dec 2017 16:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbdLAQDJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 11:03:09 -0500
Received: from siwi.pair.com ([209.68.5.199]:14329 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbdLAQDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 11:03:09 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8BC7784557;
        Fri,  1 Dec 2017 11:03:08 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2D8278452F;
        Fri,  1 Dec 2017 11:03:08 -0500 (EST)
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Jonathan Nieder <jrnieder@gmail.com>, Vitaly Arbuzov <vit@uber.com>
Cc:     git@vger.kernel.org, Konstantin Khomoutov <kostix@bswap.ru>,
        git-users@googlegroups.com, jonathantanmy@google.com,
        Christian Couder <christian.couder@gmail.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <20171130200341.GA20640@aiede.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e93127b9-d6d6-dcf2-3d58-dc83d68d5d20@jeffhostetler.com>
Date:   Fri, 1 Dec 2017 11:03:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171130200341.GA20640@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/30/2017 3:03 PM, Jonathan Nieder wrote:
> Hi Vitaly,
> 
> Vitaly Arbuzov wrote:
> 
>> Found some details here: https://github.com/jeffhostetler/git/pull/3
>>
>> Looking at commits I see that you've done a lot of work already,
>> including packing, filtering, fetching, cloning etc.
>> What are some areas that aren't complete yet? Do you need any help
>> with implementation?
> 
> That's a great question!  I've filed https://crbug.com/git/2 to track
> this project.  Feel free to star it to get updates there, or to add
> updates of your own.

Thanks!

> 
> As described at https://crbug.com/git/2#c1, currently there are three
> patch series for which review would be very welcome.  Building on top
> of them is welcome as well.  Please make sure to coordinate with
> jeffhost@microsoft.com and jonathantanmy@google.com (e.g. through the
> bug tracker or email).
> 
> One piece of missing functionality that looks intereseting to me: that
> series batches fetches of the missing blobs involved in a "git
> checkout" command:
> 
>   https://public-inbox.org/git/20171121211528.21891-14-git@jeffhostetler.com/
> 
> But if doesn't batch fetches of the missing blobs involved in a "git
> diff <commit> <commit>" command.  That might be a good place to get
> your hands dirty. :)

Jonathan Tan added code in unpack-trees to bulk fetch missing blobs
before a checkout.  This is limited to the missing blobs needed for
the target commit.  We need this to make checkout seamless, but it
does mean that checkout may need online access.

I've also talked about a pre-fetch capability to bulk fetch missing
blobs in advance of some operation.  You could speed up the above
diff command or back-fill all the blobs I might need before going
offline for a while.

You can use the options that were added to rev-list to help with this.
For example:
     git rev-list --objects [--filter=<fs>] --missing=print <commit1>
     git rev-list --objects [--filter=<fs>] --missing=print <c1>..<c2>
And then pipe that into a "git fetch-pack --stdin".

You might experiment with this.


> 
> Thanks,
> Jonathan
> 

Thanks,
Jeff

