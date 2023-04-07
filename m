Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F1C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 20:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDGUzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 16:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDGUzm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 16:55:42 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDE7692
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 13:55:40 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A37DBCA1238;
        Fri,  7 Apr 2023 16:55:39 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:c0ae:551b:c33d:5901] (unknown [IPv6:2600:1700:840:e768:c0ae:551b:c33d:5901])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6F1D8CC843A;
        Fri,  7 Apr 2023 16:55:39 -0400 (EDT)
Message-ID: <dcd66846-8992-7016-c711-09397384c18c@jeffhostetler.com>
Date:   Fri, 7 Apr 2023 16:55:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] fsmonitor: handle differences between Windows named pipe
 functions
Content-Language: en-US
To:     Eric DeCosta <edecosta@mathworks.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
 <e48e768a-19f3-386a-9bda-8fa8681d1a6c@gmx.de>
 <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
 <BL0PR05MB55713A00DEB97375BDC6D1DAD9919@BL0PR05MB5571.namprd05.prod.outlook.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <BL0PR05MB55713A00DEB97375BDC6D1DAD9919@BL0PR05MB5571.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/23 3:08 PM, Eric DeCosta wrote:
> 
> 
>> -----Original Message-----
>> From: Jeff Hostetler <git@jeffhostetler.com>
>> Sent: Monday, March 27, 2023 11:02 AM
>> To: Johannes Schindelin <Johannes.Schindelin@gmx.de>; Eric DeCosta via
>> GitGitGadget <gitgitgadget@gmail.com>
>> Cc: git@vger.kernel.org; Eric DeCosta <edecosta@mathworks.com>
>> Subject: Re: [PATCH] fsmonitor: handle differences between Windows
>> named pipe functions
>>
>>
>>
>> On 3/27/23 7:37 AM, Johannes Schindelin wrote:
>>> Hi Eric,
>>>
>>> On Fri, 24 Mar 2023, Eric DeCosta via GitGitGadget wrote:
>>>
>>>> From: Eric DeCosta <edecosta@mathworks.com>
>>>>
>>>> CreateNamedPipeW is perfectly happy accepting pipe names with
>>>> seemingly embedded escape charcters (e.g. \b), WaitNamedPipeW is not
>>>> and incorrectly returns ERROR_FILE_NOT_FOUND when clearly a named
>>>> pipe, succesfully created with CreateNamedPipeW, exists.
>>>>
>>>> For example, this network path is problemmatic:
>>>> \\batfs-sb29-cifs\vmgr\sbs29\my_git_repo
>>>>
>>>> In order to work around this issue, rather than using the path to the
>>>> worktree directly as the name of the pipe, instead use the hash of
>>>> the worktree path.
>>>
>>> This is a rather large deviation from the other platforms, and it has
>>> an unwanted side effect: Git for Windows' installer currently
>>> enumerates the named pipes to figure out which FSMonitor instances
>>> need to be stopped before upgrading. It has to do that because it
>>> would otherwise be unable to overwrite the Git executable. And it
>>> needs to know the paths [*1*] so that it can stop the FSMonitors
>>> gracefully (as opposed to terminating them and risk interrupting them
>> while they serve a reply to a Git client).
>>>
>>> A much less intrusive change (that would not break Git for Windows'
>>> installer) would be to replace backslashes by forward slashes in the path.
>>>
>>> Please do that instead.
>>>
>>> Ciao,
>>> Johannes
>>>
>>> Footnote *1*: If you think that the Git for Windows installer could
>>> simply enumerate the process IDs of the FSMonitor instances and then
>>> look for their working directories: That is not a viable option. Not
>>> only does the Windows-based FSMonitor specifically switch to the
>>> parent directory (to avoid blocking the removal of a Git directory
>>> merely by running the process in said directory), even worse: there is
>>> no officially-sanctioned way to query a running process' current
>>> working directory (the only way I know of involves injecting a remote
>>> thread! Which will of course risk being labeled as malware by current anti-
>> malware solutions).
>>
>> Agreed. Please use forward slashes.
>>
>> Thanks,
>> Jeff
>>
> 
> I have misdiagnosed the problem. Here are my most recent findings:
> 
> The problem is the leading double-slashes for repos that resolve to remote filesystems. i.e. if S:\myrepo resolves to \\some-server\some-dir\myrepo then the path passed to initialize_pipe_name is //some-server/some-dir/myrepo
> 
> Regardless of what type or how many slashes appear after \\.\pipe\ the pipe name, as reported from PowerShell, is always \\.\\pipe\\some-server\some-dir\myrepo and WaitNamedPipeW returns ERROR_FILE_NOT_FOUND
> 
> If I skip over the first leading slash an use /some-server/some-dir/myrepo I get the same pipe name as before, WaitNamedPipeW is happy and commands like git fsmonitor--daemon status correctly report that the daemon is watching the repo.
> 
> -Eric

The named pipe file system (NPFS) is a little "special".  It is a flat
namespace and not hierarchical and not subject to the usual Win32
and/or NTFS limitations/quirks (such as restricted characters or legacy
filename suffixes).  It is a single level dictionary, in a sense.

The local form is "\\.\pipe\<name>" and according to [1], the only
restriction is that <name> portion may not contain backslashes[1],
but I'm seeing lots of named pipes of the form "\\.\pipe\Winsock2\..."
on my Windows 10 system, so that restriction may have been lifted
since the documentation was last updated.

[1] 
https://learn.microsoft.com/en-us/windows/win32/api/namedpipeapi/nf-namedpipeapi-createnamedpipew

Forward slashes (and now it seems backslashes) are not directory
separators -- they are just another character in the allowed char[256].
We tend to think of them as directory separators, but that is an
illusion.  For example, in a CMD prompt:

     dir \\.\pipe\\ /b

shows a simple list of all the named pipes on the system, including
some "Winsock2\CatalogChangeListener..." ones.  However, any attempt
to list the contents of the "Winsock2" directory:

     dir \\.\pipe\\Winsock2\\ /b

fails with a file not found error.

However, a simple wildcard lists them:

     dir \\.\pipe\\Winsock2* /b


 From PowerShell, we can see a complete list of pipes with:

     (get-childitem \\.\pipe\).FullName

But we get a path does not exist with:

     (get-childitem \\.\pipe\Winsock2\).FullName

However "get-childitem" is confused and reports "Winsock2" as
a directory multiple times, each with one item, when we do:

     (get-childitem \\.\pipe)


(BTW There's also the "Pipelist" tool from SysInternals that shows
them as a simple list of names (some with the embedded backslashes).


In [1], it also says that CreateNamedPipeW() can only create a local
"\\.\pipe\<something>" pipe, so I wonder if CreateNamedPipeW() is
silently prefixing "\\.\pipe\" if necessary...  I haven't had time
to try this.


Then WaitNamedPipeW() and/or CreateFileW() allows fully general
"\\<host>\<share>\<pathnames>", so the OS cannot do any implicit
fixup -- and these calls actually try to access the (intended)
network file.


I'm guessing here that this is the problem you've found.
If that is the case, we need to think about how to fix it
mainly because of what Johannes said about the installer
needing to properly shutdown running daemons during an upgrade.
Or rather, we will need to coordinate with the GFW installer.

Please let me know if any of this makes sense.

Thanks,
Jeff



