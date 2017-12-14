Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D523B1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 20:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbdLNUqc (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 15:46:32 -0500
Received: from siwi.pair.com ([209.68.5.199]:63111 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752153AbdLNUqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 15:46:31 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C01CA8450D;
        Thu, 14 Dec 2017 15:46:30 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6A284844EB;
        Thu, 14 Dec 2017 15:46:30 -0500 (EST)
Subject: Re: [PATCH] partial-clone: design doc
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171208192636.13678-1-git@jeffhostetler.com>
 <20171208192636.13678-2-git@jeffhostetler.com>
 <46D2661C19CD4ADE81699FE7E99712EE@PhilipOakley>
 <xmqqlgi7xzwq.fsf@gitster.mtv.corp.google.com>
 <2078863B63F54322A0C9455C8BC98C9D@PhilipOakley>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <40a141bb-65e7-f1c5-7ada-f65670141b5e@jeffhostetler.com>
Date:   Thu, 14 Dec 2017 15:46:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <2078863B63F54322A0C9455C8BC98C9D@PhilipOakley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/13/2017 8:17 AM, Philip Oakley wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>>> +  These filtered packfiles are incomplete in the traditional sense
>>>> because
>>>> +  they may contain trees that reference blobs that the client does
>>>> not have.
>>>
>>> Is a comment needed here noting that currently, IIUC, the complete
>>> trees are fetched in the packfiles, it's just the un-necessary blobs
>>> that are omitted ?
>>
>> I probably am misreading what you meant to say, but the above
>> statement with "currently" taken literally to mean the system
>> without JeffH's changes, is false.
> 
> I was meaning the current JeffH's V6 series, rather than the last Git release.
> 
> In one of the previous discussions Jeff had noted that (at that time) his partial design would provide a full set of trees for the selected commits (excluding the trees already available locally), but only a few of the file blobs (based on the filter spec).
> 
> So yes, I should have been clearer to avoid talking at cross purposes.

Right, we build upon the existing thin-pack capabilities such that a
fetch following a clone gets a packfile that assumes the client already
has all of the objects in the "edge".  So a fetch would not need to
receive trees and blobs that are already present in the edge commits.

What we are adding here is a way to filter/restrict even further the
set of objects sent to the client.

> 
>>
>> When the receiver says it has commit A and the sender wants to send
>> a commit B (because the receiver said it does not have it, and it
>> wants it), trees in A are not sent in the pack the sender sends to
>> give objects sufficient to complete B, which the receiver wanted to
>> have, even if B also has those trees.  If you fetch from me twice
>> and between that time Documentation/ directory did not change, the
>> second fetch will not have the tree object that corresponds to that
>> hierarchy (and of course no blobs and sub trees inside it).
> 
> Though, after the fetch has completed (v2.15 Git), the receiver will have the 'full set of trees and blobs'. In Jeff's design (V6) the reciever would still have a full set of trees, but only a partial set of the blobs. So my viewpoint was not of the pack file but of the receiver's object store after the fetch.

Currently (with our changes) the receiver will have all of the trees
and only some of the blobs.  If we later add another filter that can
filter trees, the client will also have missing but referenced trees too.

  
>>
>> So "the complete trees are fetched" is not true.  What is true (and
>> what matters more in JeffH's document) is that fetching is done in
>> such a way that objects resulting in the receiving repository are
>> complete in the current system that does not allow promised objects.
>> If some objects resulting in the receiving repository are incomplete,
>> the current system considers that we corrupted the repository.
>>
>> The promise mechanism says that it is fine for the receiving end to
>> lack blobs, trees or commits, as long as the promisor repository
>> tells it that these "missing" objects can be obtained from it later.
> 
> True. (though I'm not sure exactly how Jeff decides about commits - I thought theye were not part of this optimisation)

I've not talked about commit filtering -- mainly because we already
have such machinery in shallow-clone -- and I did not want to mess
with the haves/wants computations.

But it will work with missing commits, because of the way object lookup
happens a missing commit will trigger the fetch-object code just like it
does for missing blobs.  The ODB layer doesn't really care what type of
object it is -- just that it is missing and needs to be dynamically fetched.
  
Thanks
Jeff
