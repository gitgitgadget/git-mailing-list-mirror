Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD0AC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 14:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjAROKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 09:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjAROJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 09:09:44 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8BA267
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 05:50:51 -0800 (PST)
Received: from 88-110-98-79.dynamic.dsl.as9105.com ([88.110.98.79] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pI8px-0001a2-Fe;
        Wed, 18 Jan 2023 13:50:49 +0000
Message-ID: <3cc61b40-6493-ead3-37fb-0af97213122c@iee.email>
Date:   Wed, 18 Jan 2023 13:50:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: test_pause giving '__git_ps1: not found' warning
Content-Language: en-GB
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <bce6ac3a-17a6-beed-43ef-5a1e0dd92a5d@iee.email>
 <8355f48b-dbf9-7cfe-c85c-0d6ca5926c8c@iee.email>
 <Y8WLmmjL2HH2szGs@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Y8WLmmjL2HH2szGs@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/01/2023 17:38, Jeff King wrote:
> On Sat, Jan 14, 2023 at 05:49:15PM +0000, Philip Oakley wrote:
>
>> On 14/01/2023 14:54, Philip Oakley wrote:
>>> I was trying to refine a test_expect_failure test [1] and tried
>>> inserting a `test_pause &&` test line [2].
>>>
>>> I then found, when it paused, I was repeatedly given the warning line
>>>     /bin/sh: 1: __git_ps1: not found
>>> in the terminal until I expected the test shell.
>>>
>>> my PS1 is working normally in the terminal, but not here.  Is this
>>> expected, or do I need to set up anything else?
>>>
>>> Normally I'm on Git for Windows, but this was on my old laptop (Acer
>>> 7741 i5 4GB ram..) converted to Ubuntu 20.04, which I use when away.
> On Ubuntu, your /bin/sh is likely to be dash. And unless you've set
> TEST_SHELL_PATH, that's what test_pause will use.

Thanks. Some of these little tidbits passed me by.

I wasactually  trying to understand why  $(printf "\145\314\201") wasn't
working as expected (or the hex equivalent) depending on which machine
(Ubuntu / Windows) I was on (when running in a test as part of
t/t4205-log-pretty-formats.sh). I.e. sometimes the results looked like
the unicode was being recognised, and others as if part were just ascii
characters, ignoring the octal/hex escaping)
 
>
>> My local .bashrc has
>>
>>     . /home/philip/git-completion.bash
>>     . ~/git-prompt.sh
>>     export GIT_PS1_SHOWDIRTYSTATE=1
>>     export PS1='\w$(__git_ps1 " (%s)")\$ '
> It's unusual to export PS1. Only the shell needs it. 

It's the default setting described in the git-scm book's Appendix A "Git
in Bash" [1].

Not sure if extra clarification is needed, or where that advice
originated from. It (export'ing) is not currently part of contrib's
git-prompt.sh comments [2].

> But by exporting
> it, the child "dash" will see it, but of course doesn't have the
> __git_ps1() function defined. And thus the complaint.
>
> If you stop exporting it, then you'd see dash's regular prompt. Which
> fixes the "whoops, __git_ps1() is not defined" problem, but probably is
> not quite what you want, if you really wanted a nice prompt.
>
>> Not sure why I have a relative and an absolute path but... ,  so I'll try
>> updating the git-prompt.sh to an absolute path, and if that works, maybe
>> think about adding an extra comment to the `test-lib-functions.sh` to note
>> the change of HOME and potential '__git_ps1' problem
> It looks like test_pause() has various options for retaining shell,
> term, home, etc, and includes documentation. I haven't played with them
> myself, though. 

> Usually I just use "-i" to stop the test, and then
> investigate the result in one of my regular shells (and in the rare case
> of "oops, it succeeds when I expect it to fail, 

> I insert "false &&" as
> appropriate).

That's a neat alternative.
>
> -Peff
--
Philip
[1]
https://git-scm.com/book/uz/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash
[2] https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
