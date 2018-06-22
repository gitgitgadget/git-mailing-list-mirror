Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3962E1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 20:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754245AbeFVUpu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 16:45:50 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:29230 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbeFVUpt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 16:45:49 -0400
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1fWSwE-0007f6-I5; Fri, 22 Jun 2018 22:45:46 +0200
Subject: Re: Unexpected ignorecase=false behavior on Windows
References: <c5abdd45-a919-96f6-8560-5fd943069f5e@syntevo.com>
 <1c7e338e-157b-fd2f-5eb1-01373f627acd@kdbg.org>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <2cf2d884-de1a-7b9b-5aca-1f396ad205a2@syntevo.com>
Date:   Fri, 22 Jun 2018 22:45:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1c7e338e-157b-fd2f-5eb1-01373f627acd@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.06.2018 19:36, Johannes Sixt wrote:
> Am 22.06.2018 um 14:04 schrieb Marc Strapetz:
>> On Windows, when creating following repository:
>>
>> $ git init
>> $ echo "1" > file.txt
>> $ git add .
>> $ git commit -m "initial import"
>> $ ren file.txt File.txt
>> $ git config core.ignorecase false
> 
> This is a user error. core.ignorecase is *not* an instruction as in 
> "hey, Git, do not ignore the case of file names". It is better regarded 
> as an internal value, with which Git remembers how it should treat the 
> names of files that it receives when it traverses the directories on the 
> disk.
> 
> Git could probe the file system capabilities each time it runs. But that 
> would be wasteful. Hence, this probe happens only once when the 
> repository is initialized, and the result is recorded in this 
> configuration value. You should not change it.

Sorry, it looks like my example was misleading. I'm actually questioning 
current behavior in case of Windows repositories with core.ignorecase 
initialized to false, like in following setup:

$ git init
$ git config core.ignorecase false

The repository is now set up to be case-sensitive on Windows. From this 
point on, core.ignorecase won't change anymore and the repository will 
be filled:

$ echo "1" > file.txt
$ git add .
$ git commit -m "initial import"
$ ren file.txt File.txt

Still, status results are:

$ git status --porcelain
?? File.txt

With the same setup sequence on Unix, it's:

$ git status --porcelain
   D file.txt
?? File.txt

Is this difference, which is depending on the platform, intended? Why 
not report missing file.txt as well?

The drawback of the current behavior is that a subsequent "git add ." 
will result in two file names in the .git/index which are only differing 
in case. This will break the repository on Windows, because only one of 
both files can be checked out in the working tree. Also, it makes 
case-only renames harder to be performed.

-Marc
