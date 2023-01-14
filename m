Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B66DC46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 17:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjANRt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 12:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjANRtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 12:49:24 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C96BB96
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 09:49:23 -0800 (PST)
Received: from 88-110-98-79.dynamic.dsl.as9105.com ([88.110.98.79] helo=[192.168.1.23])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pGkee-000AU6-BH;
        Sat, 14 Jan 2023 17:49:21 +0000
Message-ID: <8355f48b-dbf9-7cfe-c85c-0d6ca5926c8c@iee.email>
Date:   Sat, 14 Jan 2023 17:49:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: test_pause giving '__git_ps1: not found' warning
Content-Language: en-US
To:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <bce6ac3a-17a6-beed-43ef-5a1e0dd92a5d@iee.email>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <bce6ac3a-17a6-beed-43ef-5a1e0dd92a5d@iee.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/01/2023 14:54, Philip Oakley wrote:
> I was trying to refine a test_expect_failure test [1] and tried 
> inserting a `test_pause &&` test line [2].
>
> I then found, when it paused, I was repeatedly given the warning line
>     /bin/sh: 1: __git_ps1: not found
> in the terminal until I expected the test shell.
>
> my PS1 is working normally in the terminal, but not here.  Is this 
> expected, or do I need to set up anything else?
>
> Normally I'm on Git for Windows, but this was on my old laptop (Acer 
> 7741 i5 4GB ram..) converted to Ubuntu 20.04, which I use when away.
>
> The basic sequence was
>
> ~$ cd repos/git
> ~/repos/git (doctrunc *)$ cd t
> ~/repos/git/t (doctrunc *)$ ./t4205-log-pretty-formats.sh  -i -x -v
> Initialized empty Git repository in /home/philip/repos/git/t/trash 
> directory.t4205-log-pretty-formats/.git/
>
> [... ...]
>
> + git log --format=%<(5,mtrunc)%s -4
> + test_pause
> + PAUSE_TERM=dumb
> + PAUSE_SHELL=/bin/sh
> + PAUSE_HOME=/home/philip/repos/git/t/trash 
> directory.t4205-log-pretty-formats
> + test 0 != 0
> + TERM=dumb HOME=/home/philip/repos/git/t/trash 
> directory.t4205-log-pretty-formats /bin/sh

I think the 'gotcha' is here in the setting of HOME within the 
test_pause which in some ways conflicts with the setting of the 
__git_ps1 instructions [3].

My local .bashrc has

     . /home/philip/git-completion.bash
     . ~/git-prompt.sh
     export GIT_PS1_SHOWDIRTYSTATE=1
     export PS1='\w$(__git_ps1 " (%s)")\$ '

Not sure why I have a relative and an absolute path but... ,  so I'll 
try updating the git-prompt.sh to an absolute path, and if that works, 
maybe think about adding an extra comment to the `test-lib-functions.sh` 
to note the change of HOME and potential '__git_ps1' problem

[3] 
https://git-scm.com/book/uz/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash

> /bin/sh: 1: __git_ps1: not found
> \w$ git status
> On branch source-b
> [...]
> nothing added to commit but untracked files present (use "git add" to 
> track)
> /bin/sh: 1: __git_ps1: not found
>
> I added the gits status to see when/where the warning was emitted.
>
> [1] 
> https://github.com/PhilipOakley/git/blob/doctrunc/t/t4205-log-pretty-formats.sh#L1021-L1046
> [2] 
> https://github.com/git/git/blob/master/t/test-lib-functions.sh#L137-L188
>
>
> Any suggestions as to how to set this up correctly to avoid the warning?
> -- 
> Philip

