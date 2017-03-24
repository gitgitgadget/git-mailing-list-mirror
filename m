Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4D31FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936698AbdCXPt2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:49:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:65321 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936588AbdCXPqR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:46:17 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B2AF784610;
        Fri, 24 Mar 2017 11:46:15 -0400 (EDT)
Subject: Re: [PATCH] read-cache: call verify_hdr() in a background thread
To:     Jeff King <peff@peff.net>
References: <1490362071-46932-1-git-send-email-git@jeffhostetler.com>
 <1490362071-46932-2-git-send-email-git@jeffhostetler.com>
 <20170324153617.smmzju5mygqt5vux@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1743d048-8d6b-c14e-161b-351e6d79fb95@jeffhostetler.com>
Date:   Fri, 24 Mar 2017 11:46:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170324153617.smmzju5mygqt5vux@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/24/2017 11:36 AM, Jeff King wrote:
> On Fri, Mar 24, 2017 at 01:27:51PM +0000, git@jeffhostetler.com wrote:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teash do_read_index() in read-cache.c to call verify_hdr()
>> in a background thread while the forground thread parses
>> the index and builds the_index.
>>
>> This is a performance optimization to reduce the overall
>> time required to get the index into memory.
>>
>> Testing on Windows (using the OpenSSL SHA1 routine) showed
>> that parsing the index and computing the SHA1 take almost
>> equal time, so this patch effectively reduces the startup
>> time by 1/2.
>
> Have you considered just skipping the sha1 check on read (possibly with
> an option)?
>
> Its purpose is to detect disk bit-rot. Checking it for every single
> operation may be a bit excessive, especially because it gets rewritten a
> lot. Nobody really cared until now because they don't have index files
> that are hundreds of megabytes.

Yes, we have done that in a version of the client customized
for the virtual file system effort and have been using it
internally without incident for quite a while.

And we can get a patch for that instead (or include it with
this one) if there's interest.

I tried to limit my proposal here to increasing performance while
preserving the existing behavior.

Jeff
