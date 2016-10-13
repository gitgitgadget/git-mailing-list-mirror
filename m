Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F6C1F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 09:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbcJMJHm (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 05:07:42 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:42157 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbcJMJHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 05:07:40 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u9D94v7v007342
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Oct 2016 09:04:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u9D94uqs004127
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Oct 2016 09:04:57 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u9D94uSs015113;
        Thu, 13 Oct 2016 09:04:56 GMT
Received: from [10.175.172.71] (/10.175.172.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Oct 2016 02:04:55 -0700
Subject: Re: Huge performance bottleneck reading packs
To:     Jeff King <peff@peff.net>
References: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
 <20161012230143.5kxcmtityaasra5j@sigill.intra.peff.net>
 <20161012231807.syockv2emrsjf55r@sigill.intra.peff.net>
 <20161012234753.tbqhuc7qdyklpfzv@sigill.intra.peff.net>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
Date:   Thu, 13 Oct 2016 11:04:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161012234753.tbqhuc7qdyklpfzv@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2016 01:47 AM, Jeff King wrote:
> On Wed, Oct 12, 2016 at 07:18:07PM -0400, Jeff King wrote:
>
>> Also, is it possible to make the repository in question available? I
>> might be able to reproduce based on your description, but it would save
>> time if I could directly run gdb on your example.

I won't be able to make the repository available, sorry.

> I tried this by making a bunch of packs in linux.git (my standard "this
> is pretty big" repo), like so:
>
>   for i in $(seq 1000); do
>     git rev-list --objects HEAD~$((i+1))..HEAD~$i |
>     git pack-objects --delta-base-offset .git/objects/pack/pack
>   done
>
> and then doing a 25,000-object fetch from upstream (no significance to
> the number; that's just how far behind upstream I happened to be).
>
> However, I didn't notice any regression. In fact, it was much _slower_
> than v1.9.0, because that older version didn't have threaded index-pack.
>
> If you can't share the repo directly, can you tell us more about your
> fetch? How many objects are in your repository? How many objects are
> fetched? How many refs are there on the remote side?

The fetch doesn't actually get anything from the remote as everything is
already up to date (that makes the 2m40s times even more frustrating in
a way :-)). Here's count-objects:

$ git count-objects -v
warning: garbage found: .git/objects/pack/tmp_pack_pAZcu4
warning: garbage found: .git/objects/pack/tmp_pack_KhzrrI
warning: garbage found: .git/objects/pack/tmp_pack_mycfro
warning: garbage found: .git/objects/pack/tmp_pack_2kxKOn
count: 51609
size: 288768
in-pack: 23902336
packs: 1044
size-pack: 16588157
prune-packable: 48628
garbage: 4
size-garbage: 84792

There are some 20k refs on the remote, closer to 25k locally.

I'll try to get a profile (without your patch) before doing a gc run.


Vegard
