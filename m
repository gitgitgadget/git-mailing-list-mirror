Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4067D202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932934AbdCISjH (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:39:07 -0500
Received: from siwi.pair.com ([209.68.5.199]:56361 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932932AbdCISjG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:39:06 -0500
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B4026845F1;
        Thu,  9 Mar 2017 13:38:35 -0500 (EST)
Subject: Re: [PATCH 06/10] rev-list: add --allow-partial option to relax
 connectivity checks
To:     Jeff King <peff@peff.net>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-7-git-send-email-jeffhost@microsoft.com>
 <xmqqd1dr38f0.fsf@gitster.mtv.corp.google.com>
 <2cc503b4-f6cf-336a-bc3f-f44b1d187eaf@jeffhostetler.com>
 <20170309075642.jy5o353ann524k7f@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        markbt@efaref.net, benpeart@microsoft.com, jonathantanmy@google.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cb3418b8-8ecf-a38b-67d3-e73dc28d4f69@jeffhostetler.com>
Date:   Thu, 9 Mar 2017 13:38:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170309075642.jy5o353ann524k7f@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/9/2017 2:56 AM, Jeff King wrote:
> On Wed, Mar 08, 2017 at 03:10:54PM -0500, Jeff Hostetler wrote:
>
>>> Even though I do very much like the basic "high level" premise to
>>> omit often useless large blobs that are buried deep in the history
>>> we would not necessarily need from the initial cloning and
>>> subsequent fetches, I find it somewhat disturbing that the code
>>> "Assume"s that any missing blob is due to an previous partial clone.
>>> Adding this option smells like telling the users that they are not
>>> supposed to run "git fsck" because a partially cloned repository is
>>> inherently a corrupt repository.
>>>
>>> Can't we do a bit better?  If we want to make the world safer again,
>>> what additional complexity is required to allow us to tell the
>>> "missing by design" and "corrupt repository" apart?
>>
>> I'm open to suggestions here.  It would be nice to extend the
>> fetch-pack/upload-pack protocol to return a list of the SHAa
>> (and maybe the sizes) of the omitted blobs, so that a partial
>> clone or fetch would still be able to be integrity checked.
>
> Yeah, the early external-odb patches did this. It lets you do a more
> accurate fsck, and it also helps diff avoid faulting in large-object
> cases (because we can mark them as binary for "free" by comparing the
> size to big_file_threshold).
>
> So I think it makes a lot of sense in the large-blob case, where
> transmitting a type/size/sha1 tuple is way more efficient than sending
> the blob itself. But it's less clear for "sparse" cases where just
> enumerating the set of blobs may be prohibitively large.
>
> I have a feeling that the "sparse" thing needs to be handled separately
> from "partial". IOW, the client needs to tell the server "I'm only
> interested in the path foo/bar, so just send that". Then you don't find
> out about the types and sizes outside of that path, but you don't need
> to; the sparse path is stored locally and fsck knows to avoid looking
> into it.
>
> -Peff
>

That makes sense.  I'd like to get both concepts (by-size/special vs
sparse-file) in, but they don't really overlap that much (internally).
So I could see doing this in 2 separate efforts.

Thanks,
Jeff
