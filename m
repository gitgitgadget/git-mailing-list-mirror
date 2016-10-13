Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1871F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 07:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbcJMHVv (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 03:21:51 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:45238 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbcJMHVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 03:21:50 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u9D7KBLU027319
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Oct 2016 07:20:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u9D7KAEh001641
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Oct 2016 07:20:11 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u9D7KA9U005587;
        Thu, 13 Oct 2016 07:20:10 GMT
Received: from [10.175.172.71] (/10.175.172.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Oct 2016 00:20:10 -0700
Subject: Re: Huge performance bottleneck reading packs
To:     Jeff King <peff@peff.net>
References: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
 <20161012230143.5kxcmtityaasra5j@sigill.intra.peff.net>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
Date:   Thu, 13 Oct 2016 09:20:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161012230143.5kxcmtityaasra5j@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2016 01:01 AM, Jeff King wrote:
> On Thu, Oct 13, 2016 at 12:30:52AM +0200, Vegard Nossum wrote:
>
>> However, the commit found by 'git blame' above appears just fine to me,
>> I haven't been able to spot a bug in it.
>>
>> A closer inspection reveals the problem to really be that this is an
>> extremely hot path with more than -- holy cow -- 4,106,756,451
>> iterations on the 'packed_git' list for a single 'git fetch' on my
>> repository. I'm guessing the patch above just made the inner loop
>> ever so slightly slower.
>>
>> My .git/objects/pack/ has ~2088 files (1042 idx files, 1042 pack files,
>> and 4 tmp_pack_* files).
>
> Yeah. I agree that the commit you found makes the check a little more
> expensive, but I think the root of the problem is calling
> prepare_packed_git_one many times. This _should_ happen once for each
> pack at program startup, and possibly again if we need to re-scan the
> pack directory to account for racing with a simultaneous repack.
>
> The latter is generally triggered when we fail to look up an object we
> expect to exist. So I'd suspect 45e8a74 (has_sha1_file: re-check pack
> directory before giving up, 2013-08-30) is playing a part. We dealt with
> that to some degree in 0eeb077 (index-pack: avoid excessive re-reading
> of pack directory, 2015-06-09), but it would not surprise me if there is
> another spot that needs similar treatment.
>
> Does the patch below help?

Yes, ~2m10s -> ~1m25s when I test a git fetch this morning (the other
variation in time may be due to different CPU usage by other programs,
but I ran with/without the patch multiple times and the difference is
consistent).

Thanks,


Vegard
