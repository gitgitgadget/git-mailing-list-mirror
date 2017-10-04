Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE3A20281
	for <e@80x24.org>; Wed,  4 Oct 2017 08:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbdJDIXm (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 04:23:42 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.101]:29192 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdJDIXk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 04:23:40 -0400
X-Greylist: delayed 1590 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Oct 2017 04:23:40 EDT
Received: from [91.113.179.170] (helo=[192.168.92.24])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1dzeYF-0006Uo-N3; Wed, 04 Oct 2017 09:57:07 +0200
Subject: Re: Git for Windows: mingw.c's strange usage of creation time as
 ctime?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        git-for-windows@googlegroups.com
References: <08983090-07d2-cfe4-dd90-ab4887b83893@syntevo.com>
 <20171004022352.GJ19555@aiede.mtv.corp.google.com>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <6e1afdc2-2edb-8060-87b0-7d2ced201e02@syntevo.com>
Date:   Wed, 4 Oct 2017 09:57:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171004022352.GJ19555@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jonathan,

On 04.10.2017 04:23, Jonathan Nieder wrote:
> +git-for-windows
> Hi Marc,
> 
> Marc Strapetz wrote:
> 
>> compat/mingw.c assigns the Windows file creation time [1] to Git's
>> ctime fields at line 591 and at line 705:
>>
>> buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
>>
>> ftCreationTime > ftLastWriteTime is actually possible after copying
>> a file, so it makes sense to include this timestamp somehow in the
>> Index, but I think it would be better to use the maximum of
>> ftLastWriteTime and ftCreationTime here which is less confusing and
>> closer to Unix's ctime:
>>
>> buf->st_ctime = max(buf->st_mtime,
>>                      filetime_to_time_t(&(fdata.ftCreationTime));
> 
> Can you say more about the practical effect?  Is this causing a bug in
> practice, is it a bug waiting to happen, or is it making the code
> difficult to understand without any ill effect expected at run time?

It's mainly about understanding: as a Windows guy it is quite tempting 
to read "ctime" as "creationTime" and getting this confirmed in code 
above. (I guess) based on this understanding I wrote wrong Java code 8 
years ago for all platforms. My bad of course that I was not digging 
into Unix sources here.

In practice, .git/index timestamps will become more similar to Linux, 
getting rid of "strange" old ctime values.

Drawback will be that after such a code update every Index entry will 
appear as outdated and the initial "git status" will have to compare all 
file contents. If this is not acceptable, a comment for the two 
offending lines would make sense.

> By the way, do you have core.trustctime set to true or false?

It seems to be set to true by default on Windows and usually I'm not 
changing it.

-Marc



