Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F107C77B7C
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjDZUdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZUdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:33:45 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7422121
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:33:43 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 05812CA124E;
        Wed, 26 Apr 2023 16:33:43 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:69d8:c39b:c604:54bf] (unknown [IPv6:2600:1700:840:e768:69d8:c39b:c604:54bf])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CB01ECC83B1;
        Wed, 26 Apr 2023 16:33:42 -0400 (EDT)
Message-ID: <48d44c06-34ba-0a1f-dd0d-7d66bd8dfcb9@jeffhostetler.com>
Date:   Wed, 26 Apr 2023 16:33:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] fsmonitor: handle differences between Windows named
 pipe functions
Content-Language: en-US
To:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
 <pull.1503.v2.git.1681155963011.gitgitgadget@gmail.com>
 <BL0PR05MB557134157C3D08D982DEB338D9619@BL0PR05MB5571.namprd05.prod.outlook.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <BL0PR05MB557134157C3D08D982DEB338D9619@BL0PR05MB5571.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/22/23 4:00 PM, Eric DeCosta wrote:
> 
>> -----Original Message-----
>> From: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
>> Sent: Monday, April 10, 2023 3:46 PM
>> To: git@vger.kernel.org
>> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>; Jeff Hostetler
>> <git@jeffhostetler.com>; Eric DeCosta <edecosta@mathworks.com>; Eric
>> DeCosta <edecosta@mathworks.com>
>> Subject: [PATCH v2] fsmonitor: handle differences between Windows named
>> pipe functions
>>
>> From: Eric DeCosta <edecosta@mathworks.com>
>>
>> The two functions involved with creating and checking for the existance of
>> the local fsmonitor named pipe, CratedNamedPipeW and WaitNamedPipeW
>> appear to handle names with leading slashes or backslashes a bit differently.
>>
>> If a repo resolves to a remote file system with the UNC path of //some-
>> server/some-dir/some-repo, CreateNamedPipeW accepts this name and
>> creates this named pipe: \\.\pipe\some-server\some-dir\some-repo
>>
>> However, when the same UNC path is passed to WaitNamedPipeW, it fails
>> with ERROR_FILE_NOT_FOUND.
>>
>> Skipping the leading slash for UNC paths works for both CreateNamedPipeW
>> and WaitNamedPipeW. Resulting in a named pipe with the same name as
>> above that WaitNamedPipeW is able to correctly find.
>>
>> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
[...]
>>
>>
>> compat/simple-ipc/ipc-win32.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
>> index 997f6144344..632b12e1ab5 100644
>> --- a/compat/simple-ipc/ipc-win32.c
>> +++ b/compat/simple-ipc/ipc-win32.c
>> @@ -19,13 +19,18 @@
>> static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t
>> alloc) { int off = 0;
>> + int real_off = 0;
>> struct strbuf realpath = STRBUF_INIT;
>>
>> if (!strbuf_realpath(&realpath, path, 0)) return -1;
>>
>> + /* UNC Path, skip leading slash */
>> + if (realpath.buf[0] == '/' && realpath.buf[1] == '/') real_off = 1;
>> +
>> off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
>> - if (xutftowcs(wpath + off, realpath.buf, alloc - off) < 0)
>> + if (xutftowcs(wpath + off, realpath.buf + real_off, alloc - off) < 0)
>> return -1;

I haven't had a chance to test this, but this does look
like a minimal solution for the pathname confusion in the
MSFT APIs.

Do you need to test for realpath.buf[0] and [1] being a forward OR
a backslash ?

Should we set real_off to 2 rather than 1 because we already
appended a trailing backslash in the swprintf() ?

You should run one of those NPFS directory listing tools to
confirm the exact spelling of the pipe matches your expectation
here.  Yes, if both functions now work, we should be good, but
it would be good to confirm your real_off choice, right?

If would be good to (at least interactively) test that the
git-for-windows installer can find the path and stop the daemon
on an upgrade or uninstall.  See Johannes' earlier point.

We should state somewhere that we are running the fsmonitor
daemon locally and it is watching a remote file system.

You should run a few stress tests to ensure that the
MAX_RDCW_BUF_FALLBACK throttling works and that the daemon
doesn't fall behind on a very busy remote file system.  (There
are SMB/CIFS wire protocol limits.  See the source.)  (I did
test this between the combination of systems that I had, but
YMMV.)

During the stress test, it would also be good to test that
IO generated by a client process on your local machine to the
remote file system is reported, but also that random IO from
remote processes on the remote system are seen in the event
stream.  Again, I tested the combinations of machines that I
had available at the time.

Hope this helps,
Jeff


>>
>> /* Handle drive prefix */
>>
>> base-commit: f285f68a132109c234d93490671c00218066ace9
>> --
>> gitgitgadget
> 
> Are there any other thoughts about this?
> 
> I believe that this is the simplest change possible that will ensure that
> fsmonitor correctly handles network repos.
> 
> -Eric
