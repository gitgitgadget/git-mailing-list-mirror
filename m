Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F14AC56202
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D9222201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgKLWKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:10:38 -0500
Received: from siwi.pair.com ([209.68.5.199]:13860 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgKLWKh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:10:37 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BE8AB3F5FD2;
        Thu, 12 Nov 2020 17:10:36 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8DF353F5FCC;
        Thu, 12 Nov 2020 17:10:36 -0500 (EST)
Subject: Re: [PATCH v2 01/11] docs: new capability to advertise trace2 SIDs
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604355792.git.steadmon@google.com>
 <xmqq5z6mqg60.fsf@gitster.c.googlers.com>
 <634cf106-7bc2-e8fa-5745-5e2d26b50e14@jeffhostetler.com>
 <87d00ihdqf.fsf@evledraar.gmail.com>
 <xmqqo8k2jxa2.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1b044820-2616-36f4-9d0b-368a74b9d125@jeffhostetler.com>
Date:   Thu, 12 Nov 2020 17:10:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8k2jxa2.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/12/20 12:32 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> AFAICT the way it's documented now is the "is the session-id[...]"
>> paragraph in api-trace2.txt.
>>
>> I'd like to see us document the implementation a bit better and
>> explicitly support the "hack" of setting GIT_TRACE2_PARENT_SID=hello.

I've occasionally used that hack for control/experiment-type
testing, but not that often.

I was more pointing out that I had to use that environment
inheritance mechanism so that child processes can be associated
with their Git process ancestry.  And so it is possible for someone
to abuse that mechanism for other purposes (and introduce injections
into what Josh is proposing).

>>
>> I.e. maybe I've missed something but we just say "session-id is
>> prepended with the session-id of the parent" but don't mention that we
>> separate them with slashes, so you can split on that to get the depth &
>> individual ID's.
>>
>> My reading of the updated doc patch in v3 is that not allowing
>> "non-printable or whitespace" allows you to e.g. have slashes in those
>> custom session IDs, which would be quite inconvenient since it would
>> break that property.
> 
> A few things I want to see stakeholders agree on:
> 
>   - In "a/b/c", what's the "session ID" of the leaf child process?
>     "a/b/c"?  or "c"?  If the former (which is what I am guessing),
>     do we have name to refer to "b" or "c" alone (if not, we should
>     have one)?

I consider a process' SID to be the complete "a/b/c" string.
But I do know that when I look at my logging data, that I will
also find data for a process with SID of "a" and data for another
process with SID "a/b".

So perhaps we should have names for:

     [1] "a/b/c"  -- my process' complete SID name
     [2] "c"      -- my process' SID component name
     [3] "a/b"    -- my parent's complete SID name

> 
>   - Do we encourage/force other implementations of Git protocol to
>     adopt a similar "slash-separated non-whitespace ASCII printable"
>     structure?  I do not think such a structure is too limiting but
>     others may feel differently.  Or is a "session ID" supposed to be
>     an opaque token without any structure, and upon seeing "a/b/c"
>     the recipient should not read anything into its slash, or any
>     relation  with another session whose ID is "a/b/d"?

When analyzing Git perf data, there are times when you basically want
to "SELECT * where SID startswith 'a/b/' ..." and summarize over the
child processes of "a/b".  So data from "a/b/c" and "a/b/d" would be
aggregated.  (I do have some of that data in the "child_exit" events
reported for the "a/b" process, but sometimes you need to actually
see the records for the child processes.)

So I guess I'm saying that the hierarchy has been useful and we should
try to keep it as is.

> 
>> And we should explicitly support the GIT_TRACE2_PARENT_SID=* setting
>> from an external process, and make the SID definition loose enough to
>> allow for SIDs that don't look like Git's in that chain. I.e. a useful
>> property (and one I've seen in the wild) is to have some external
>> programt that already has SIDs/UUID run IDs spawn git, setting
>> GIT_TRACE2_PARENT_SID=<that program's SID> makes things convenient for
>> the purposes of logging.n

Yes, it can be useful for external tools that drive Git to be able to
set a SID prefix to help track that into Git process.

Likewise, it would be nice to add code to some of the Git shell script
commands (such as git-mergetool and git-prompt) to augment the SID
being passed to child Git commands to help track why they are being
invoked.

Jeff



