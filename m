Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE3C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 21:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbjEOVvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjEOVvD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 17:51:03 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B71E720
        for <git@vger.kernel.org>; Mon, 15 May 2023 14:51:00 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 082F2CA1269;
        Mon, 15 May 2023 17:51:00 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:74fe:31ef:2cf4:c0f5] (unknown [IPv6:2600:1700:840:e768:74fe:31ef:2cf4:c0f5])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C9CD2CC83B0;
        Mon, 15 May 2023 17:50:59 -0400 (EDT)
Message-ID: <9cb47e80-6000-8d1b-3132-35f1b4566e5e@jeffhostetler.com>
Date:   Mon, 15 May 2023 17:50:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] fsmonitor: handle differences between Windows named
 pipe functions
To:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
 <pull.1503.v2.git.1681155963011.gitgitgadget@gmail.com>
 <BL0PR05MB557134157C3D08D982DEB338D9619@BL0PR05MB5571.namprd05.prod.outlook.com>
 <48d44c06-34ba-0a1f-dd0d-7d66bd8dfcb9@jeffhostetler.com>
 <BL0PR05MB5571DD75B080F2790FC82534D9719@BL0PR05MB5571.namprd05.prod.outlook.com>
Content-Language: en-US
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <BL0PR05MB5571DD75B080F2790FC82534D9719@BL0PR05MB5571.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Sorry this got lost in my inbox.

On 5/8/23 4:30 PM, Eric DeCosta wrote:
> 
>> -----Original Message-----
>> From: Jeff Hostetler <git@jeffhostetler.com>
>> Sent: Wednesday, April 26, 2023 4:34 PM
>> To: Eric DeCosta <edecosta@mathworks.com>; Eric DeCosta via GitGitGadget
>> <gitgitgadget@gmail.com>; git@vger.kernel.org
>> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Subject: Re: [PATCH v2] fsmonitor: handle differences between Windows
>> named pipe functions
>>
>>
>>
>> On 4/22/23 4:00 PM, Eric DeCosta wrote:
>>>
>>>> -----Original Message-----
>>>> From: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
>>>> Sent: Monday, April 10, 2023 3:46 PM
>>>> To: git@vger.kernel.org
>>>> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>; Jeff Hostetler
>>>> <git@jeffhostetler.com>; Eric DeCosta <edecosta@mathworks.com>; Eric
>>>> DeCosta <edecosta@mathworks.com>
>>>> Subject: [PATCH v2] fsmonitor: handle differences between Windows
>> named
>>>> pipe functions
>>>>
>>>> From: Eric DeCosta <edecosta@mathworks.com>
>>>>
>>>> The two functions involved with creating and checking for the existance of
>>>> the local fsmonitor named pipe, CratedNamedPipeW and
>> WaitNamedPipeW
>>>> appear to handle names with leading slashes or backslashes a bit
>> differently.
>>>>
>>>> If a repo resolves to a remote file system with the UNC path of //some-
>>>> server/some-dir/some-repo, CreateNamedPipeW accepts this name and
>>>> creates this named pipe: \\.\pipe\some-server\some-dir\some-repo
>>>>
>>>> However, when the same UNC path is passed to WaitNamedPipeW, it fails
>>>> with ERROR_FILE_NOT_FOUND.
>>>>
>>>> Skipping the leading slash for UNC paths works for both
>> CreateNamedPipeW
>>>> and WaitNamedPipeW. Resulting in a named pipe with the same name as
>>>> above that WaitNamedPipeW is able to correctly find.
>>>>
>>>> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
>> [...]
>>>>
>>>>
>>>> compat/simple-ipc/ipc-win32.c | 7 ++++++-
>>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-
>> win32.c
>>>> index 997f6144344..632b12e1ab5 100644
>>>> --- a/compat/simple-ipc/ipc-win32.c
>>>> +++ b/compat/simple-ipc/ipc-win32.c
>>>> @@ -19,13 +19,18 @@
>>>> static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t
>>>> alloc) { int off = 0;
>>>> + int real_off = 0;
>>>> struct strbuf realpath = STRBUF_INIT;
>>>>
>>>> if (!strbuf_realpath(&realpath, path, 0)) return -1;
>>>>
>>>> + /* UNC Path, skip leading slash */
>>>> + if (realpath.buf[0] == '/' && realpath.buf[1] == '/') real_off = 1;
>>>> +
>>>> off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
>>>> - if (xutftowcs(wpath + off, realpath.buf, alloc - off) < 0)
>>>> + if (xutftowcs(wpath + off, realpath.buf + real_off, alloc - off) < 0)
>>>> return -1;
>>
>> I haven't had a chance to test this, but this does look
>> like a minimal solution for the pathname confusion in the
>> MSFT APIs.
>>
>> Do you need to test for realpath.buf[0] and [1] being a forward OR
>> a backslash ?
>>
>> Should we set real_off to 2 rather than 1 because we already
>> appended a trailing backslash in the swprintf() ?
>>
> Attempts to add additional backslashes after \\.\pipe\\ are apparently
> ignored. The name of the local pipe always ends up looking like this:
> 
> for UNC paths:
>    \\.\pipe\\some-server\some-dir\some-repo
>    
> and for local paths:
>   \\.\pipe\\C_\some-dir\some-repo
>    
> Thus for a UNC path of //some-server/some-dir/some-repo the simplest thing to
> do is to skip the first slash.

Ok thanks. Just being paranoid...

> 
>> You should run one of those NPFS directory listing tools to
>> confirm the exact spelling of the pipe matches your expectation
>> here.  Yes, if both functions now work, we should be good, but
>> it would be good to confirm your real_off choice, right?
>>
> I have used both PowerShell and Process Explorer and see similar results.
> 

good. thanks.

>> If would be good to (at least interactively) test that the
>> git-for-windows installer can find the path and stop the daemon
>> on an upgrade or uninstall.  See Johannes' earlier point.
>>
> In regards to the GfW installer, if the daemon is running against
> a network mounted repo it reports the following:
> 
> Could not stop FSMonitor daemon in some-server\some-dir\some-repo
> (output: , errors: fatal cannot change to 'some-server\some-dir\some-repo':
> No such file or directory)
> 
> It looks like the installer may have to do something like:
> look for "<drive letter>_" immediately after "\\.\pipe\\" and if it does not
> find it, assume a UNC path.
> 

ok. perhaps you could log an issue on github.com/git-for-windows/git.git
to describe this.

>> We should state somewhere that we are running the fsmonitor
>> daemon locally and it is watching a remote file system.
>>
>> You should run a few stress tests to ensure that the
>> MAX_RDCW_BUF_FALLBACK throttling works and that the daemon
>> doesn't fall behind on a very busy remote file system.  (There
>> are SMB/CIFS wire protocol limits.  See the source.)  (I did
>> test this between the combination of systems that I had, but
>> YMMV.)
>>
>> During the stress test, it would also be good to test that
>> IO generated by a client process on your local machine to the
>> remote file system is reported, but also that random IO from
>> remote processes on the remote system are seen in the event
>> stream.  Again, I tested the combinations of machines that I
>> had available at the time.
>>
> I hear what you are saying, however reporting that information increases
> the scope of this change. As this stands right now the advertised feature
> of allowing fsmonitor to work on network-mounted sandboxes for Windows
> is not working as expected.

understood.  my only concern was that remotely mounted file systems
didn't get a lot of testing.  it worked, but i didn't have resources
to really stress it.  but then again, it if falls behind it will
force a resync, so you *shouldn't* get a wrong answer.

Thanks for all your work (and patience with me) on this.
Jeff


> 
> -Eric
> 
>> Hope this helps,
>> Jeff
>>
>>
>>>>
>>>> /* Handle drive prefix */
>>>>
>>>> base-commit: f285f68a132109c234d93490671c00218066ace9
>>>> --
>>>> gitgitgadget
>>>
>>> Are there any other thoughts about this?
>>>
>>> I believe that this is the simplest change possible that will ensure that
>>> fsmonitor correctly handles network repos.
>>>
>>> -Eric
> 
