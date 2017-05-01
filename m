Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6F41F790
	for <e@80x24.org>; Mon,  1 May 2017 10:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S378681AbdEAKGZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 06:06:25 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:28940 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S378678AbdEAKGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 06:06:23 -0400
Received: from [192.168.2.201] ([92.22.34.197])
        by smtp.talktalk.net with SMTP
        id 58DkdS78y9tMz58DkdIMhh; Mon, 01 May 2017 11:06:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1493633181; bh=D0Ji6oghG1hpWOKgg2Wo/Vi8/m+UF1wQMngaI+UXggs=;
        h=Reply-To:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=WCKiMl7xt20+HsS7pq5AOZKAVr0R89Sbr6hoGQ9gkSMmDl2jfq7azgAPhSo4igTPK
         vSbt9HKOupYcKpeNuTdMMQbsFLvFGT87yu3bPdazHFAQiKrFd9j+v1uwWbdntSu2Al
         eoNHeuFYL15Kt20miLAtMs7eguKRwEGTQ+GuXHGQ=
X-Originating-IP: [92.22.34.197]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=hA2HGApHRYQPBHGSl800fg==:117
 a=hA2HGApHRYQPBHGSl800fg==:17 a=IkcTkHD0fZMA:10 a=Kv9d0ukAiKx9rihItDgA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via rebase--helper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
 <cover.1493207864.git.johannes.schindelin@gmx.de>
 <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
 <8c1f3519-0768-69d9-4d15-782da0be8390@talktalk.net>
 <alpine.DEB.2.20.1704282059100.3480@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Message-ID: <42892d55-965d-af9d-fb80-518797d590c0@talktalk.net>
Date:   Mon, 1 May 2017 11:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1704282059100.3480@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOXDkwAYTFVESfaZYMnUBd71B0nrx8BgI6PpkEcx/hOp5XsYvrUhKmin34wT/1A7ftT9oBiWedIzcRfWcEKugvWMrJjkCZscwAAgmbcu7ed7FCdcVpk6
 zZV5Y82b4UwIcll510TZhL1Na+rOC3Svo2MxacxFRj+LAeZnuwwv5c7Gbnas/FJ7wruOCS3f9XfFe19ztdFXwdvSAcmfyKOLjlo7ayI8fKiWxje6XbWdXOdp
 nxU4c+tbCIgJe0oxBt785s2ic03RP0xMoFRwMoILGXRUIbsvihkYt63+DuX+BJx+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/04/17 20:22, Johannes Schindelin wrote:
> Hi Philip,
> 
> On Fri, 28 Apr 2017, Phillip Wood wrote:
> 
>> On 26/04/17 12:59, Johannes Schindelin wrote:
>>
>>> The first step of an interactive rebase is to generate the so-called
>>> "todo script", to be stored in the state directory as
>>> "git-rebase-todo" and to be edited by the user.
>>>
>>> Originally, we adjusted the output of `git log <options>` using a
>>> simple sed script. Over the course of the years, the code became more
>>> complicated. We now use shell scripting to edit the output of `git
>>> log` conditionally, depending whether to keep "empty" commits (i.e.
>>> commits that do not change any files).
>>>
>>> On platforms where shell scripting is not native, this can be a
>>> serious drag. And it opens the door for incompatibilities between
>>> platforms when it comes to shell scripting or to Unix-y commands.
>>>
>>> Let's just re-implement the todo script generation in plain C, using
>>> the revision machinery directly.
>>>
>>> This is substantially faster, improving the speed relative to the
>>> shell script version of the interactive rebase from 2x to 3x on
>>> Windows.
>>
>> This changes the behaviour of git -c rebase.instructionFormat= rebase -i
>> The shell version treats the rebase.instructionFormat being unset or set
>> to the empty string as equivalent. This version generates a todo list
>> with lines like 'pick <abbrev sha1>' rather than 'pick <abbrev sha1>
>> <subject>'
>>
>> I only picked this up because I have a script that does 'git -c
>> rebase.instructionFormat= rebase -i' with a custom sequence editor. I
>> can easily add '%s' in the appropriate place but I thought I'd point it
>> out in case other people are affected by the change.
> 
> While I would argue that the C version is more correct, it would be
> backwards-incompatible.

I was going to make a point about resetting config variables to their
default value on the command line but Junio beat me to it.

> So I changed it.

That's great, thanks

> BTW in the future you could help me a *lot* by providing a patch that adds
> a test case to our test suite that not only demonstrates what exactly goes
> wrong, but also will help prevent future regressions.

I'll bear that in mind, it does assume that reporters have a good
understanding of the test suite layout and helper functions though. Is
there a particular reason you put the test case in the autosquash tests?
I wouldn't have thought of doing that.

Thanks again

Phillip

