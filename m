Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E0FC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 11:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349697AbiDZLye (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 07:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349682AbiDZLyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 07:54:33 -0400
X-Greylist: delayed 2258 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Apr 2022 04:51:23 PDT
Received: from host02.zombieandprude.com (host02.zombieandprude.com [80.82.119.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D171E33E0A
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 04:51:23 -0700 (PDT)
Received: from hashpling.plus.com ([212.159.69.125]:52070 helo=[192.168.76.62])
        by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <cb@hashpling.org>)
        id 1njJ5J-0002TH-HH; Tue, 26 Apr 2022 12:10:21 +0100
Message-ID: <9463ee27-148d-e1c4-3120-e7d6f3c8ae14@hashpling.org>
Date:   Tue, 26 Apr 2022 12:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Too-loose checks for applying safe.directory rules?
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Matheus Valadares <me@m28.io>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <YlZJGbcNzSp5yNN1@nand.local> <YlZe766xu9mHWNdy@google.com>
From:   CB Bailey <cb@hashpling.org>
In-Reply-To: <YlZe766xu9mHWNdy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/04/2022 06:26, Jonathan Nieder wrote:
> (+cc: git@vger, git-security -> bcc)
> Hi,
> 
> Taylor Blau wrote:
> 
>> Hi all,
>>
>> I was skimming the Hacker News comments on my blog post covering the
>> latest pair of CVEs, and this[1] comment stuck out to me.
>>
>> Looking at 8959555cee (setup_git_directory(): add an owner check for the
>> top-level directory, 2022-03-02), I wonder why the `safe_directory_cb()`
>> callback doesn't bother to check that `key` is `safe.directory`.
>>
>> Indeed, our checks seem too loose here. Initializing a repository as
>> root:
>>
>>      $ su
>>      # git init repo
>>
>> Then trying to run "git status" inside of that repo as my normal user
>> gives the expected error:
>>
>>      $ git status
>>      fatal: unsafe repository ('/home/repo' is owned by someone else)
>>      To add an exception for this directory, call:
>>
>>        git config --global --add safe.directory /home/repo
>>
>> But doing the following:
>>
>>      $ git config --global --add foo.bar /home/repo
>>
>> tricks Git into thinking that _any_ value which looks like a path in the
>> "early config" scope can be interpreted as if the key were
>> safe.directory, even when it is not:
>>
>>      $ git status
>>      On branch master
>>
>>      No commits yet
>>
>>      nothing to commit (create/copy files and use "git add" to track)

I just wanted to send a belated "thank you for fixing this" as the other 
aspect of this is that if you had any configuration variable configured 
to an empty string (in my case 'http.proxy'), then any 'safe.directory' 
which happended to be parsed before this was ignored. This bug was the 
cause of me running git in a debugger in production for the first time 
in a very long time as we tried to work out why 'safe.directory' was not 
working.

CB
