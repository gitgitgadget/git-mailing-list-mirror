Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2A01F462
	for <e@80x24.org>; Fri, 31 May 2019 19:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEaTS7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 15:18:59 -0400
Received: from mail-gateway-shared10.cyon.net ([194.126.200.61]:48110 "EHLO
        mail-gateway-shared10.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727187AbfEaTS7 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 15:18:59 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared10.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1hWn3F-0003k2-Eb
        for git@vger.kernel.org; Fri, 31 May 2019 21:18:56 +0200
Received: from [10.20.10.233] (port=59130 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1hWn3E-005HX1-8R; Fri, 31 May 2019 21:18:52 +0200
Subject: Re: Severe Regression in Git 1.21.0 -- not receiving any data
To:     David <courrier@david-kremer.fr>, git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <04a82e31-2292-ef73-98c5-b9a5ff28e000@david-kremer.fr>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <a6a0e1be-8450-e61c-fe1c-911831004f66@drbeat.li>
Date:   Fri, 31 May 2019 21:18:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <04a82e31-2292-ef73-98c5-b9a5ff28e000@david-kremer.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31.05.19 13:31, David wrote:
> # Summary
> 
> I was trying to clone the AOSP source tree (Android Open Source Project)
> and I finally was able to formally identify what seems to be a severe
> regression (one that is blocking usage) in the last version of git
> (2.21.0).
> 
> # Steps to reproduce
> 
> The AOSP projects recommend to use ubuntu 14.04 as its build platform.
> The git version for this distro is :
> 
> ```
> root@eb57f366840e:/android# git --version
> git version 1.9.1
> ```
> 
> In a docker image for this OS, I am able to execute:
> 
> ```
> root@eb57f366840e:~# git clone
> https://android.googlesource.com/platform/manifest
> Cloning into 'manifest'...
> remote: Sending approximately 39.94 MiB ...
> remote: Counting objects: 852, done
> remote: Finding sources: 100% (27/27)
> remote: Total 16017 (delta 4968), reused 16017 (delta 4968)
> Receiving objects: 100% (16017/16017), 39.65 MiB | 9.04 MiB/s, done.
> Resolving deltas: 100% (4968/4968), done.
> Checking connectivity... done.
> ```
> 
> Now, on my local Archlinux Box, the git version is 2.21.0 (latest).
> 
> The same command:
> 
> ```
> 
> git clone https://android.googlesource.com/platform/manifest
> ```
> 
> Is launching a single thread that uses 100% of one CPU core FOREVER,
> until a timeout arises after like 40 minutes (the remote hung up
> unexpectedly). Someone on the #git channel (irc.freenode.net) was able
> to reproduce the exact same behaviour.
> 
> I must add that this of course arises only with the repo I mention in
> this email (github repositories are just fine). So probably a mismatch
> in protocol between git server/client ? Anyways, I'm far from having the
> skills to fix that thing.
> 
> I hope this report is useful, and in any case, I would like to know
> about the possible outcomes of this report.
> 
> I would be actually very surprised if someone did not notice that
> before, given that the latest git version is from february, but I can
> try anyway :)
> 
> Cheers,
> 
> David

Can you try

    GIT_TRACE_PACKET=/tmp/packet.txt GIT_TRACE=/tmp/trace.txt git clone
https://android.googlesource.com/platform/manifest

?

The new files in /tmp help you see where the operation stalls.

Warning: the output will be large!


Beat
