Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505FBC6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 15:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjC0PDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjC0PD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 11:03:29 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FEC59FF
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 08:02:41 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 65377CA1260;
        Mon, 27 Mar 2023 11:02:17 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:948:2c:9be7:96af] (unknown [IPv6:2600:1700:840:e768:948:2c:9be7:96af])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 30934CC8332;
        Mon, 27 Mar 2023 11:02:17 -0400 (EDT)
Message-ID: <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
Date:   Mon, 27 Mar 2023 11:02:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] fsmonitor: handle differences between Windows named pipe
 functions
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
References: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
 <e48e768a-19f3-386a-9bda-8fa8681d1a6c@gmx.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <e48e768a-19f3-386a-9bda-8fa8681d1a6c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/27/23 7:37 AM, Johannes Schindelin wrote:
> Hi Eric,
> 
> On Fri, 24 Mar 2023, Eric DeCosta via GitGitGadget wrote:
> 
>> From: Eric DeCosta <edecosta@mathworks.com>
>>
>> CreateNamedPipeW is perfectly happy accepting pipe names with seemingly
>> embedded escape charcters (e.g. \b), WaitNamedPipeW is not and incorrectly
>> returns ERROR_FILE_NOT_FOUND when clearly a named pipe, succesfully created
>> with CreateNamedPipeW, exists.
>>
>> For example, this network path is problemmatic:
>> \\batfs-sb29-cifs\vmgr\sbs29\my_git_repo
>>
>> In order to work around this issue, rather than using the path to the
>> worktree directly as the name of the pipe, instead use the hash of the
>> worktree path.
> 
> This is a rather large deviation from the other platforms, and it has an
> unwanted side effect: Git for Windows' installer currently enumerates the
> named pipes to figure out which FSMonitor instances need to be stopped
> before upgrading. It has to do that because it would otherwise be unable
> to overwrite the Git executable. And it needs to know the paths [*1*] so
> that it can stop the FSMonitors gracefully (as opposed to terminating them
> and risk interrupting them while they serve a reply to a Git client).
> 
> A much less intrusive change (that would not break Git for Windows'
> installer) would be to replace backslashes by forward slashes in the path.
> 
> Please do that instead.
> 
> Ciao,
> Johannes
> 
> Footnote *1*: If you think that the Git for Windows installer could simply
> enumerate the process IDs of the FSMonitor instances and then look for
> their working directories: That is not a viable option. Not only does the
> Windows-based FSMonitor specifically switch to the parent directory (to
> avoid blocking the removal of a Git directory merely by running the
> process in said directory), even worse: there is no officially-sanctioned
> way to query a running process' current working directory (the only way I
> know of involves injecting a remote thread! Which will of course risk
> being labeled as malware by current anti-malware solutions).

Agreed. Please use forward slashes.

Thanks,
Jeff


