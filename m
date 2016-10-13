Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD64B1F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 09:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbcJMJ5j (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 05:57:39 -0400
Received: from aserp1050.oracle.com ([141.146.126.70]:44133 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbcJMJ5h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 05:57:37 -0400
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
        by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u9D7JLur029392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 13 Oct 2016 07:19:21 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u9D7Hd9s024122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2016 07:17:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id u9D7Hdlk026960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2016 07:17:39 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u9D7Hcfh029936;
        Thu, 13 Oct 2016 07:17:38 GMT
Received: from [10.175.172.71] (/10.175.172.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Oct 2016 00:17:37 -0700
Subject: Re: Huge performance bottleneck reading packs
To:     Junio C Hamano <gitster@pobox.com>
References: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
 <xmqqpon5190s.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <1d5dd36b-7a9e-ac00-352a-d71e0e277002@oracle.com>
Date:   Thu, 13 Oct 2016 09:17:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqpon5190s.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserp1040.oracle.com [141.146.126.69]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2016 12:45 AM, Junio C Hamano wrote:
 > Vegard Nossum <vegard.nossum@oracle.com> writes:
 >
 >> A closer inspection reveals the problem to really be that this is an
 >> extremely hot path with more than -- holy cow -- 4,106,756,451
 >> iterations on the 'packed_git' list for a single 'git fetch' on my
 >> repository. I'm guessing the patch above just made the inner loop
 >> ever so slightly slower.
 >
 > Very plausible, and this ...
 >
 >> My .git/objects/pack/ has ~2088 files (1042 idx files, 1042 pack files,
 >> and 4 tmp_pack_* files).
 >
 > ... may explain why nobody else has seen a difference.
 >
 > Is there a reason why your repository has that many pack files?  Is
 > automatic GC not working for some reason?

Oops. I disabled gc a while ago; one reason I did that is that it takes
a long time to run and it has a tendency to kick in at the worst time. I
guess I should really put it in cron then.

I'm not sure if this is related, but I also had a problem with GitPython
and large pack files in the past (" ValueError: Couldn't obtain fanout
table or warning: packfile ./objects/pack/....pack cannot be accessed")
and I have pack.packSizeLimit set to 512m to fix that.
Although the whole repo is 17G so I guess it shouldn't be necessary to
have that many pack files.

Will try Jeff's patch, then a gc. Thanks!


Vegard
