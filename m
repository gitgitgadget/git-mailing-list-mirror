Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959A41FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 08:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCOIwC (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 04:52:02 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.110]:25711 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCOIvs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 04:51:48 -0400
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1ewOc7-0004g5-B2; Thu, 15 Mar 2018 09:51:55 +0100
Subject: Re: [PATCH v2 1/2] stash push: avoid printing errors
To:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20180310111215.GA14732@hank>
 <20180314214642.22185-1-t.gummerer@gmail.com>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <d9588594-10fd-1080-abda-aeeb12948b2c@syntevo.com>
Date:   Thu, 15 Mar 2018 09:51:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314214642.22185-1-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.03.2018 22:46, Thomas Gummerer wrote:
> Currently 'git stash push -u -- <pathspec>' prints the following errors
> if <pathspec> only matches untracked files:
> 
>      fatal: pathspec 'untracked' did not match any files
>      error: unrecognized input
> 
> This is because we first clean up the untracked files using 'git clean
> <pathspec>', and then use a command chain involving 'git add -u
> <pathspec>' and 'git apply' to clear the changes to files that are in
> the index and were stashed.
> 
> As the <pathspec> only includes untracked files that were already
> removed by 'git clean', the 'git add' call will barf, and so will 'git
> apply', as there are no changes that need to be applied.
> 
> Fix this by making sure to only call this command chain if there are
> still files that match <pathspec> after the call to 'git clean'.
> 
> Reported-by: Marc Strapetz <marc.strapetz@syntevo.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> 
>> Either way I'll try to address this as soon as I can get some
>> time to look at it.
> 
> I finally got around to do this.  The fix (in the second patch) turns
> out to be fairly simple, I just forgot to pass the pathspec along to
> one function whene originally introducing the pathspec feature in git
> stash push (more explanation in the commit message for the patch
> itself).  Thanks Marc for reporting the two breakages!

Thanks, I confirm that both issues are resolved. There is another issue 
now which seems to be a regression. When *successfully* stashing an 
untracked file, local modifications of other files are cleared, too.

$ git init
$ touch file1
$ git add file1
$ git commit -m "initial import"
$ echo "a" > file1
$ touch file2
$ git status --porcelain
  M file1
?? file2
$ git stash push -u -- file2
Saved working directory and index state WIP on master: 25352d7 initial 
import
$ git status
On branch master
nothing to commit, working tree clean

Hence, by stashing just "file2" the local modification of "file1" became 
reset.

-Marc




