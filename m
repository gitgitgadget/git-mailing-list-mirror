Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50789215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 22:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbcJLWbg (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 18:31:36 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:45990 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbcJLWbe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 18:31:34 -0400
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u9CMUuNO024655
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2016 22:30:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.13.8) with ESMTP id u9CMUulC007434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2016 22:30:56 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u9CMUtaN002286;
        Wed, 12 Oct 2016 22:30:55 GMT
Received: from [10.175.246.82] (/10.175.246.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Oct 2016 15:30:55 -0700
From:   Vegard Nossum <vegard.nossum@oracle.com>
Subject: Huge performance bottleneck reading packs
To:     git@vger.kernel.org
Cc:     Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Message-ID: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
Date:   Thu, 13 Oct 2016 00:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I've bisected a performance regression (noticed by Quentin and myself)
which caused a 'git fetch' to go from ~1m30s to ~2m40s:

commit 47bf4b0fc52f3ad5823185a85f5f82325787c84b
Author: Jeff King <peff@peff.net>
Date:   Mon Jun 30 13:04:03 2014 -0400

     prepare_packed_git_one: refactor duplicate-pack check

Reverting this commit from a recent mainline master brings the time back
down from ~2m24s to ~1m19s.

The bisect log:

v2.8.1 -- 2m41s, 2m50s (bad)
v1.9.0 -- 1m39s, 1m46s (good)

2.3.4.312.gea1fd48 -- 2m40s
2.1.0.18.gc285171 -- 2m42s
2.0.0.140.g6753d8a -- 1m27s
2.0.1.480.g60e2f5a -- 1m34s
2.0.2.631.gad25da0 -- 2m39s
2.0.1.565.ge0a064a -- 1m30s
2.0.1.622.g2e42338 -- 2m29s
2.0.0.rc1.32.g5165dd5 -- 1m30s
2.0.1.607.g5418212 -- 1m32s
2.0.1.7.g6dda4e6 -- 1m28s
2.0.1.619.g6e40947 -- 2m25s
2.0.1.9.g47bf4b0 -- 2m18s
2.0.1.8.gd6cd00c -- 1m36.542s

However, the commit found by 'git blame' above appears just fine to me,
I haven't been able to spot a bug in it.

A closer inspection reveals the problem to really be that this is an
extremely hot path with more than -- holy cow -- 4,106,756,451
iterations on the 'packed_git' list for a single 'git fetch' on my
repository. I'm guessing the patch above just made the inner loop
ever so slightly slower.

My .git/objects/pack/ has ~2088 files (1042 idx files, 1042 pack files,
and 4 tmp_pack_* files).

I am convinced that it is not necessary to rescan the entire pack
directory 11,348 times or do all 4 _BILLION_ memcmp() calls for a single
'git fetch', even for a large repository like mine.

I could try to write a patch to reduce the number of times we rescan the
pack directory. However, I've never even looked at the file before
today, so any hints regarding what would need to be done would be
appreciated.

Thanks,

(Cced some people with changes in the area.)


Vegard
