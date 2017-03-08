Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4E7202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbdCHUbv (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:31:51 -0500
Received: from siwi.pair.com ([209.68.5.199]:13086 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754573AbdCHUbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:31:49 -0500
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4E9D88464B;
        Wed,  8 Mar 2017 15:21:12 -0500 (EST)
Subject: Re: [PATCH 02/10] pack-objects: add --partial-by-size=n
 --partial-special
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
 <xmqqh93338s2.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1c38ffbc-e4a2-32e5-d324-506c2111043e@jeffhostetler.com>
Date:   Wed, 8 Mar 2017 15:21:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqh93338s2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/8/2017 1:47 PM, Junio C Hamano wrote:
> Jeff Hostetler <jeffhost@microsoft.com> writes:
>
>> From: Jeff Hostetler <git@jeffhostetler.com>
>>
>> Teach pack-objects to omit blobs from the generated packfile.
>>
>> When the --partial-by-size=n[kmg] argument is used, only blobs
>> smaller than the requested size are included.  When n is zero,
>> no blobs are included.
>
> Does this interact with a more traditional way of feeding output of
> an external "rev-list --objects" to pack-objects via its standard
> input, and if so, should it (and if not, shouldn't it)?
>
> It is perfectly OK if the answer is "this applies only to the case
> where we generate the list of objects with internal traversal." but
> that needs to be documented and discussed in the proposed log
> message.
>

Let me study that and see.  I'm still thinking thru ways and
options for doing the sparse-checkout like filtering.


>> When the --partial-special argument is used, git special files,
>> such as ".gitattributes" and ".gitignores" are included.
>
> And not ."gitmodules"?
>
> What happens when we later add ".gitsomethingelse"?
>
> Do we have to worry about the case where the set of git "special
> files" (can we have a better name for them please, by the way?)
> understood by the sending side and the receiving end is different?
>
> I have a feeling that a mode that makes anything whose name begins
> with ".git" excempt from the size based cutoff may generally be
> easier to handle.

I forgot about ".gitmodules".  The more I think about it, maybe
we should always include them (or anything starting with ".git*")
and ignore the size, since they are important for correct behavior.


> I am not sure how "back-filling" of a resulting narrow clone would
> safely be done and how this impacts "git fsck" at this point, but if
> they are solved within this effort, that would be a very welcome
> change.
>
> Thanks.
>
