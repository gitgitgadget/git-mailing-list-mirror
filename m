Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394801FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 15:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbdC1PbY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 11:31:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:62781 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbdC1PbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 11:31:23 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C953484673;
        Tue, 28 Mar 2017 11:30:47 -0400 (EDT)
Subject: Re: [PATCH v2 0/2] read-cache: call verify_hdr() in a background
 thread
To:     Jeff King <peff@peff.net>
References: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
 <20170327224505.ngp2gel3yvqcjrhw@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bf02e996-0b4b-f2ed-09b1-c99bb93c800f@jeffhostetler.com>
Date:   Tue, 28 Mar 2017 11:30:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170327224505.ngp2gel3yvqcjrhw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/27/2017 6:45 PM, Jeff King wrote:
> On Mon, Mar 27, 2017 at 09:09:37PM +0000, git@jeffhostetler.com wrote:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Version 2 of this patch series simplifies this to just
>> turn off the hash verification.  Independent comments
>> from Linus and Peff suggested that we could just turn
>> this off and not worry about it.  So I've updated this
>> patch to do that.  I added a global variable to allow
>> the original code path to be used.  I also added a
>> t/helper command to demonstrate the differences.
>>
>> On the Linux repo, the effect is rather trivial:
>>
>>     $ ~/work/gfw/t/helper/test-skip-verify-index -c 3
>>     0.029884 0 [cache_nr 57994]
>>     0.031035 0 [cache_nr 57994]
>>     0.024308 0 [cache_nr 57994]
>>     0.028409 0 avg
>>     0.018359 1 [cache_nr 57994]
>>     0.017025 1 [cache_nr 57994]
>>     0.011087 1 [cache_nr 57994]
>>     0.015490 1 avg
>>
>> On my Windows source tree (450MB index), I'm seeing a
>> savings of 0.6 seconds -- read_index() went from 1.2 to 0.6
>> seconds.
>
> Very satisfying. I assume that was with OpenSSL as the SHA-1
> implementation (sha1dc would have been much slower on 450MB, I think).
>
> -Peff
>

Yes, this was with the OpenSSL SHA-1 code in a GfW build.
I haven't played with the sha1dc code yet.

$ $/work/gh_gfw/t/helper/test-skip-verify-index.exe -c 5
1.276485 0 [cache_nr 3077831]
1.261164 0 [cache_nr 3077831]
1.256012 0 [cache_nr 3077831]
1.261411 0 [cache_nr 3077831]
1.266174 0 [cache_nr 3077831]
1.264249 0 avg
0.672057 1 [cache_nr 3077831]
0.666968 1 [cache_nr 3077831]
0.668725 1 [cache_nr 3077831]
0.675879 1 [cache_nr 3077831]
0.670213 1 [cache_nr 3077831]
0.670768 1 avg

Jeff
