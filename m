Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECAAC43331
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 00:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055452312A
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 00:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393915AbhAMAnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 19:43:15 -0500
Received: from siwi.pair.com ([209.68.5.199]:36543 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392383AbhAMAdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 19:33:21 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EF0A53F40FA;
        Tue, 12 Jan 2021 19:32:39 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BA5803F40F4;
        Tue, 12 Jan 2021 19:32:39 -0500 (EST)
Subject: Re: [PATCH 00/10] [RFC] Simple IPC Mechanism
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <xmqq5z4153gq.fsf@gitster.c.googlers.com>
 <cee527cb-7962-1528-0c70-583ad805e624@jeffhostetler.com>
 <xmqqo8htzoba.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <968235ae-4b31-f06c-149a-c581e64b318b@jeffhostetler.com>
Date:   Tue, 12 Jan 2021 19:32:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8htzoba.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/12/21 7:13 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> On Windows a local named pipe is created by the server side.  It rejects
>> remote connections.  I did not put an ACL, so it should inherit the
>> system default which grants the user RW access (since the daemon is
>> implicitly started by the first foreground client command that needs
>> to talk to it.)  Other users in the user's group and the anonymous
>> user should have R but not W access to it, so they could not be able
>> to connect.  The name pipe is kept in the local Named Pipe File System
>> (NPFS) as `\\.\pipe\<unique-path>` so it is globally visible on the
>> system, but I don't think it is a problem.
> 
> It is not intuitively obvious why globalluy visible thing is OK to
> me, but I'll take your word for it on stuff about Windows.

Sorry, that's a quirk of Windows.  Windows has a funky virtual drive
where named pipes are stored -- kind of like a magic directory in /proc
on Linux.  All local named pipes have the "\\.\pipe\" path prefix.

So they are globally visible as a side-effect of that "namespace"
restriction.

> 
>> On the Unix side, the socket is created inside the .git directory
>> by the daemon.  Potential clients would have to have access to the
>> working directory and the .git directory to connect to the socket,
>> so in normal circumstances they would be able to read everything in
>> the WD anyway.  So again, I don't think it is a problem.
> 
> OK, yes, writability to .git would automatically mean that
> everything is a fair game to those who can talk to the daemon, so
> there is no new issue here, as long as the first process that
> creates the socket is careful not to loosen the permission.
> 
> Thanks.
> 
