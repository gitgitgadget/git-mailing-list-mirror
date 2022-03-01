Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A4C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 21:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiCAVbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 16:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCAVbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 16:31:18 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314081190
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 13:30:36 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 07C6D3F47EF;
        Tue,  1 Mar 2022 16:30:36 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A68C03F4165;
        Tue,  1 Mar 2022 16:30:35 -0500 (EST)
Subject: Re: [PATCH 09/23] fsmonitor-settings: remote repos on macOS are
 incompatible with FSMonitor
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <412fbc45868e7f2a05a03e424584b53ded4842e9.1644940774.git.gitgitgadget@gmail.com>
 <c35cb692-4539-d43e-6df0-6ae5ee911f5a@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <11c3c3b7-82f2-f34c-e79e-5773593c19c2@jeffhostetler.com>
Date:   Tue, 1 Mar 2022 16:30:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c35cb692-4539-d43e-6df0-6ae5ee911f5a@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 10:26 AM, Derrick Stolee wrote:
> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach Git to detect remote working directories on macOS and mark them as
>> incompatible with FSMonitor.
>>
>> With this, `git fsmonitor--daemon run` will error out with a message
>> like it does for bare repos.
>>
>> Client commands, like `git status`, will not attempt to start the daemon.
> 
> ...
> 
>> + * A client machine (such as a laptop) may choose to suspend/resume
>> + * and it is unclear (without lots of testing) whether the watcher can
>> + * resync after a resume.  We might be able to treat this as a normal
>> + * "events were dropped by the kernel" event and do our normal "flush
>> + * and resync" --or-- we might need to close the existing (zombie?)
>> + * notification fd and create a new one.
>> + *
>> + * In theory, the above issues need to be addressed whether we are
>> + * using the Hook or IPC API.
> 
> The only thing I can think about is a case where the filesystem
> monitor is actually running on the remote machine and Git
> communicates with it over the network. This is currently possible
> with the hook, but I am not aware of a hook implementation that
> does this.
> 
> We can find a way to update the hook interface to communicate to
> Git that a remote disk is an appropriate case, but only if there
> is a real need for that.

I'm not saying we can't support remote working directories.
We do get events from SMB for example, but there network
buffer limits and all the usual connectivity issues with a
local daemon reading an event stream from a remote file system.
So out of caution, I want to disable it for now.  We can always
revisit it later.

WRT the builtin IPC-based daemon, I have the socket/named pipe
restricted to local access only.  This prevents a client like
"git status" from talking to a remote daemon, but it also prevents
a remote bad guy from talking our daemon.  But those are secondary
concerns right now -- I'm mainly concerned with correctly getting
all of the (possibly high volume/speed) events to the client.

There's also the possible incompatibilities of vendor X client-side
OS and vendor Y server-side OS and how well notifications are
supported between them....

So I'd just like to shut it off for now.

> 
>> + * For the builtin FSMonitor, we create the Unix domain socket for the
>> + * IPC in the .git directory.  If the working directory is remote,
>> + * then the socket will be created on the remote file system.  This
> 
> The socket is on the remote file system, but the daemon process is still
> local, so I still see this a problem.
> 
>> + * can fail if the remote file system does not support UDS file types
>> + * (e.g. smbfs to a Windows server) or if the remote kernel does not
>> + * allow a non-local process to bind() the socket.  (These problems
>> + * could be fixed by moving the UDS out of the .git directory and to a
>> + * well-known local directory on the client machine, but care should
>> + * be taken to ensure that $HOME is actually local and not a managed
>> + * file share.)
>> + *
>> + * So (for now at least), mark remote working directories as
>> + * incompatible.
>> + */
>> +static enum fsmonitor_reason is_remote(struct repository *r)
>> +{
>> +	struct statfs fs;
>> +
>> +	if (statfs(r->worktree, &fs) == -1) {
>> +		int saved_errno = errno;
>> +		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
>> +				 r->worktree, strerror(saved_errno));
>> +		errno = saved_errno;
>> +		return FSMONITOR_REASON_ZERO;
> 
> So if we fail to inspect the filesystem, we report it as compatible?
> I suppose other things are likely to fail if checks like this are
> fialing, but I wonder if we should preempt that by marking this as
> incompatible due to filesystem errors.

Good point.

> 
>> +	}
>> +
>> +	trace_printf_key(&trace_fsmonitor,
>> +			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
>> +			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
>> +
>> +	if (!(fs.f_flags & MNT_LOCAL))
>> +		return FSMONITOR_REASON_REMOTE;
> 
> I do see that we need a successful response to give this specific
> reason for incompatibility.
> 
>> +	return FSMONITOR_REASON_ZERO;
>> +}
>>   
>>   enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
>>   {
>> +	enum fsmonitor_reason reason;
>> +
>> +	reason = is_remote(r);
>> +	if (reason)
>> +		return reason;
> 
> This organization is looking like you want to short-circuit the
> checks if you find an incompatibility, with the intent of having
> multiple checks in the future.
> 
> But this can be done with simple || operators:
> 
> 	return is_remote() ||
> 	       reason_check_2() ||
> 	       reason_check_3();

True.  That is a little shorter.

Thanks
Jeff
