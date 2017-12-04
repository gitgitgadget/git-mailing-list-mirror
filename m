Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1543F20954
	for <e@80x24.org>; Mon,  4 Dec 2017 15:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbdLDPxe (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 10:53:34 -0500
Received: from siwi.pair.com ([209.68.5.199]:61291 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbdLDPxe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 10:53:34 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 94F08844E3;
        Mon,  4 Dec 2017 10:53:33 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 59AD0844E2;
        Mon,  4 Dec 2017 10:53:33 -0500 (EST)
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Vitaly Arbuzov <vit@uber.com>, Git List <git@vger.kernel.org>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
 <0e851e08-0dcc-da3b-b2c4-42afcdbf6ca4@jeffhostetler.com>
 <20171201182446.GB18220@aiede.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b277ecb7-addc-f494-cf30-b48a794abdce@jeffhostetler.com>
Date:   Mon, 4 Dec 2017 10:53:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171201182446.GB18220@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/1/2017 1:24 PM, Jonathan Nieder wrote:
> Jeff Hostetler wrote:
>> On 11/30/2017 6:43 PM, Philip Oakley wrote:
> 
>>> The 'companies' problem is that it tends to force a client-server, always-on
>>> on-line mentality. I'm also wanting the original DVCS off-line capability to
>>> still be available, with _user_ control, in a generic sense, of what they
>>> have locally available (including files/directories they have not yet looked
>>> at, but expect to have. IIUC Jeff's work is that on-line view, without the
>>> off-line capability.
>>>
>>> I'd commented early in the series at [1,2,3].
>>
>> Yes, this does tend to lead towards an always-online mentality.
>> However, there are 2 parts:
>> [a] dynamic object fetching for missing objects, such as during a
>>      random command like diff or blame or merge.  We need this
>>      regardless of usage -- because we can't always predict (or
>>      dry-run) every command the user might run in advance.
>> [b] batch fetch mode, such as using partial-fetch to match your
>>      sparse-checkout so that you always have the blobs of interest
>>      to you.  And assuming you don't wander outside of this subset
>>      of the tree, you should be able to work offline as usual.
>> If you can work within the confines of [b], you wouldn't need to
>> always be online.
> 
> Just to amplify this: for our internal use we care a lot about
> disconnected usage working.  So it is not like we have forgotten about
> this use case.
> 
>> We might also add a part [c] with explicit commands to back-fill or
>> alter your incomplete view of the ODB
> 
> Agreed, this will be a nice thing to add.
> 
> [...]
>>> At its core, my idea was to use the object store to hold markers for the
>>> 'not yet fetched' objects (mainly trees and blobs). These would be in a
>>> known fixed format, and have the same effect (conceptually) as the
>>> sub-module markers - they _confirm_ the oid, yet say 'not here, try
>>> elsewhere'.
>>
>> We do have something like this.  Jonathan can explain better than I, but
>> basically, we denote possibly incomplete packfiles from partial clones
>> and fetches as "promisor" and have special rules in the code to assert
>> that a missing blob referenced from a "promisor" packfile is OK and can
>> be fetched later if necessary from the "promising" remote.
>>
>> The main problem with markers or other lists of missing objects is
>> that it has scale problems for large repos.
> 
> Any chance that we can get a design doc in Documentation/technical/
> giving an overview of the design, with a brief "alternatives
> considered" section describing this kind of thing?

Yeah, I'll start one.  I have notes within the individual protocol
docs and man-pages, but no summary doc.  Thanks!

> 
> E.g. some of the earlier descriptions like
>   https://public-inbox.org/git/20170915134343.3814dc38@twelve2.svl.corp.google.com/
>   https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/
>   https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
> may help as a starting point.
> 
> Thanks,
> Jonathan
> 
