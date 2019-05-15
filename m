Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30BB21F461
	for <e@80x24.org>; Wed, 15 May 2019 17:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfEOR7w (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 13:59:52 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:44969 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEOR7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 13:59:51 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 4542Px4NWzz5tl9;
        Wed, 15 May 2019 19:59:49 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 32B9020BA;
        Wed, 15 May 2019 19:59:49 +0200 (CEST)
Subject: Re: Closing fds twice when using remote helpers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
 <87bm04vt81.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b6ff2486-a1c2-4e89-4338-9e4e56d528bc@kdbg.org>
Date:   Wed, 15 May 2019 19:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm04vt81.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.05.19 um 13:43 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Wed, May 15 2019, Mike Hommey wrote:
> 
>> Hi,
>>
>> I started getting a weird error message during some test case involving
>> git-cinnabar, which is a remote-helper to access mercurial
>> repositories.
>>
>> The error says:
>> fatal: mmap failed: Bad file descriptor
>>
>> ... which was not making much sense. Some debugging later, and it turns
>> out this is what happens:
>>
>> - start_command is called for fast-import

I guess, you request fast_import->out = -1.

>> - start_command is called again for git-remote-hg, passing the
>>   fast_import->out as cmd->in.

OK.

>> - in start_command, we end up on the line of code that does
>>   close(cmd->in), so fast_import->out/cmd->in is now closed

Yes. That's how the interface is specified.

>> - much later, in disconnect_helper, we call close(data->helper->out),
>>   where data->helper is the cmd for fast-import, and that fd was already
>> closed above.

That must is wrong. Passing a fd to start_command() relinquishes
responsibility.

>> - Except, well, fds being what they are, we in fact just closed a fd
>>   from a packed_git->pack_fd. So, when use_pack is later called, and
>>   tries to mmap data from that pack, it fails because the file
>>   descriptor was closed.

Either dup() the file descriptor, or mmap() before you call the
consuming start_command().

>> I'm not entirely sure how to address this... Any ideas?
>>
>> Relatedly, use_pack calls xmmap, which does its own error handling and
>> die()s in case of error, but then goes on to do its own check with a
>> different error message (which, in fact, could be more useful in other
>> cases). It seems like it should call xmmap_gently instead.
> 
> The "obvious" hacky fix is to pass in some "I own it, don't close it"
> new flag in the child_process struct.
> 
> In fact we used to have such a thing in the code, see e72ae28895
> ("start_command(), .in/.out/.err = -1: Callers must close the file
> descriptor", 2008-02-16).

That's a different thing. -1 tells that a pipe end should be passed back
to the caller. Of course, it must not be closed by start_command.

But if the caller passes their own fd *into* start_command/run_command,
then the caller must not close it.

> So we could bring it back, but I wonder if a better long-term solution
> is to refactor the API to have explicit start_command() ->
> free_command() steps, even if the free() is something that happens
> implicitly unless some "gutsy" function is called.

*Shrug* I'd use C++ to make the interface a no-brainer.

-- Hannes
