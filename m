Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32AD9208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 17:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbdIERHe (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 13:07:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:29669 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbdIERHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 13:07:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CDCC9845CC;
        Tue,  5 Sep 2017 13:07:33 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 88B16845CA;
        Tue,  5 Sep 2017 13:07:33 -0400 (EDT)
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
To:     Jeff King <peff@peff.net>
Cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
 <20170902080535.j7dommmxowpbk2no@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <77c206f8-43f6-4468-3289-096e37b9fead@jeffhostetler.com>
Date:   Tue, 5 Sep 2017 13:07:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170902080535.j7dommmxowpbk2no@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/2/2017 4:05 AM, Jeff King wrote:
> On Wed, Aug 30, 2017 at 06:59:22PM +0000, Jeff Hostetler wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> This is to address concerns raised by ThreadSanitizer on the
>> mailing list about threaded unprotected R/W access to map.size with my previous
>> "disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).  See:
>> https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/
>>
>> Add API to hashmap to disable item counting and to disable automatic rehashing.
>> Also include APIs to re-enable item counting and automatica rehashing.
> 
> It may be worth summarizing the discussion at that thread here.
> 
> At first glance, it looks like this is woefully inadequate for allowing
> multi-threaded access. But after digging, the issue is that we're really
> trying to accommodate one specific callers which is doing its own
> per-bucket locking, and which needs the internals of the hashmap to be
> truly read-only.
> 
> I suspect the code might be easier to follow if that pattern were pushed
> into its own threaded_hashmap that disabled the size and handled the
> mod-n locking, but I don't insist on that as a blocker to this fix.

Agreed.  It would be better and easier to understand to produce
a thread-safe version of the hashmap code -- there are other uses
of the code that are currently doing their own locking that might
benefit, but I'm not looking to gratuitously refactor things.

The other issue was that we are multi-threaded during the
lazy-init phase, but the main status-or-whatever code that then
uses the hashmap is not.  So we only pay for the locking during
the multi-threaded usage.

Thanks,
Jeff
