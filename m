Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058E920966
	for <e@80x24.org>; Mon,  3 Apr 2017 03:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdDCDNM (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 23:13:12 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35980 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdDCDNL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 23:13:11 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so105322437pge.3
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 20:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=serato.com; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Cj6uzLAjo2186QuQJvpJmNhtd68kjiIGe8++qpH1WF4=;
        b=hMHfeLpibFtsMXF2ItK+6XUbpknK6LBfKUBryWUcbflTuz4Oy+FSNRs27KaE3UxlmZ
         +JHAtVRpdbP5iJ6RDpZ9EYbpSr+W/MTD+qwcFfmv2SCGQ0rj4x7FG4GVbf+uL5Ml9x4N
         RUq+JQRPvGTcinE/PAgNwfZJcb4CQdpAd8yJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Cj6uzLAjo2186QuQJvpJmNhtd68kjiIGe8++qpH1WF4=;
        b=URdhOXN0j7tlje28xF1tVIZ2VWRP4b6Kbm2wpiX3cK+btBQ3pU6vSSFeLV0iSIoqm9
         888FWFl45/C09Fo5cflejW6vDvL5ZCQZVolNmIEdtqY2UK0UdPKarGfGQwhOJy5s1/Kh
         tqXg6OsfFY7MQ6R6V/y/w+VF2br5+IDIoYQg7quM/177NH7IcykBiEGByfRtoTLIeNTs
         KWLD1mJPs+mtBT8nCqtlz7FGLmGiA/qE/j9q4Q3sHVsOCLhJFzvpM7D9tj3hUfFdhmDC
         k2LEbrRSWqm1IZG+RnBoDiFdPrYdSpHyEhGOjCoBBUS7iGIP5sbWZ7dWj4d8TBB5r4Yi
         befg==
X-Gm-Message-State: AFeK/H3BKwaTkB1WEyEUUqnggny4/0kpmSw7qTuA1U3tRM1bSgcx3tGvOkGRxEkI7tGuDjh9
X-Received: by 10.99.120.74 with SMTP id t71mr15536416pgc.184.1491189190870;
        Sun, 02 Apr 2017 20:13:10 -0700 (PDT)
Received: from [10.200.28.236] ([114.23.233.11])
        by smtp.gmail.com with ESMTPSA id c1sm22223906pfk.112.2017.04.02.20.13.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Apr 2017 20:13:10 -0700 (PDT)
To:     git@vger.kernel.org
From:   Maxime Viargues <maxime.viargues@serato.com>
Subject: Bug? git submodule update --reference doesn't use the referenced
 repository
Message-ID: <35343b75-0aa7-3477-888b-3af5024ae7dd@serato.com>
Date:   Mon, 3 Apr 2017 15:13:07 +1200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I have been trying to use the --reference option to clone a big 
repository using a local copy, but I can't manage to make it work using 
sub-module update. I believe this is a bug, unless I missed something.
I am on Windows, Git 2.12.0

So the problem is as follow:
- I have got a repository with multiple sub-modules, say
     main
         lib1
             sub-module1.git
         lib2
             sub-module2.git
- The original repositories are in GitHub, which makes it slow
- I have done a normal git clone of the entire repository (not bare) and 
put it on a file server, say \\fileserver\ref_repo\
(Note that the problem also happens with local copy)

So if I do a clone to get the repo and all the submodules with...
git clone --reference-if-able \\fileserver\ref-repo --recursive 
git@github.com:company/main
...then it all works, all the sub-modules get cloned and the it's fast.

Now in my case I am working with Jenkins jobs and I need to first do a 
clone, and then get the sub-modules, but if I do...
git clone --reference-if-able \\fileserver\ref-repo 
git@github.com:company/main (so non-recursive)
cd main
git submodule update --init --reference \\fileserver\ref-repo
... then this takes ages, as it would normally do without the use of 
--reference. I suspect it's not actually using it.
The git clone documentation mentions that the reference is then passed 
to the sub-module clone commands, so I would expect "git clone 
--recursive" to work the same as "git submodule update", as far as 
--reference is concerned.

I noticed for a single module, doing a...
git submodule update --init --reference 
\\fileserver\ref-repo\lib1\sub-module1 -- lib1/sub-module1
...i.e. adding the sub-module path to the reference path, works. Which 
kind of make sense but then how do you do to apply it to all the 
sub-modules? (without writing a script to do that)

If someone can confirm the problem or explain me what I am dong wrong 
that would be great.

Maxime
