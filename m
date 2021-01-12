Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CA3C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 23:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B6A2312F
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 23:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbhALX0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 18:26:03 -0500
Received: from siwi.pair.com ([209.68.5.199]:30716 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbhALX0C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 18:26:02 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 003933F40FA;
        Tue, 12 Jan 2021 18:25:21 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C98133F40F5;
        Tue, 12 Jan 2021 18:25:20 -0500 (EST)
Subject: Re: [PATCH 00/10] [RFC] Simple IPC Mechanism
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <xmqq5z4153gq.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cee527cb-7962-1528-0c70-583ad805e624@jeffhostetler.com>
Date:   Tue, 12 Jan 2021 18:25:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z4153gq.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/12/21 3:01 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series introduces a multi-threaded IPC mechanism called "Simple IPC".
>> This is a library-layer feature to make it easy to create very long running
>> daemon/service applications and for unrelated Git commands to communicate
>> with them. Communication uses pkt-line messaging over a Windows named pipe
>> or Unix domain socket.
>>
>> On the server side, Simple IPC implements a (platform-specific) connection
>> listener and worker thread-pool to accept and handle a series of client
>> connections. The server functionality is completely hidden behind the
>> ipc_server_run() and ipc_server_run_async() APIs. The daemon/service
>> application only needs to define an application-specific callback to handle
>> client requests.
>>
>> Note that Simple IPC is completely unrelated to the long running process
>> feature (described in sub-process.h) where the lifetime of a "sub-process"
>> child is bound to that of the invoking parent process and communication
>> occurs over the child's stdin/stdout.
>>
>> Simple IPC will serve as a basis for a future builtin FSMonitor daemon
>> feature.
> 
> What kind of security implications does this bring into the system?
> 
> Can a Simple IPC daemon be connected by any client?  How does the
> daemon know that the other side is authorized to make requests?
> When a git binary acting as client connect to whatever happens to be
> listening to the well-known location, how does it know if the other
> side is the daemon it wanted to talk to and not a malicious MITM or
> other impersonator?
> 
> Or is this to be only used for "this is meant to be used to give
> read-only access to data that is public anyway" kind of daemon,
> e.g. "git://" transport that serves clones and fetches?
> 
> Or is this meant to be used on client machines where all the
> processes are assumed to be working for the end user, so it is OK to
> declare that anything will go (good old DOS mental model?)
> 
> I know at the Mechanism level we do not yet know how it will be
> used, but we cannot retrofit sufficient security, so it would be
> necessary to know answers to these questions.
> 
> Thanks.
> 

Good questions.

Yes, this is a local-only mechanism.  A local-only named pipe on
Windows and a Unix domain socket on Unix.  In both cases the daemon
creates the pipe/socket as the foreground user (since the daemon
process will be implicitly started by the first Git command that
needs to talk to it).  Later client process try to open the pipe/socket
with RW access if they can.

On Windows a local named pipe is created by the server side.  It rejects
remote connections.  I did not put an ACL, so it should inherit the
system default which grants the user RW access (since the daemon is
implicitly started by the first foreground client command that needs
to talk to it.)  Other users in the user's group and the anonymous
user should have R but not W access to it, so they could not be able
to connect.  The name pipe is kept in the local Named Pipe File System
(NPFS) as `\\.\pipe\<unique-path>` so it is globally visible on the 
system, but I don't think it is a problem.

On the Unix side, the socket is created inside the .git directory
by the daemon.  Potential clients would have to have access to the
working directory and the .git directory to connect to the socket,
so in normal circumstances they would be able to read everything in
the WD anyway.  So again, I don't think it is a problem.


Alternatively, if a malicious server is started and holds the named
pipe or socket:  the client might be able to talk to it (assuming
that bad server grants access or impersonates the rightful user).
The client might not be able to tell they've been tricked, but at
that point the system is already compromised.

So unless I'm missing something, I think we're OK either way.

Jeff
