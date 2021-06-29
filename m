Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4CEC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525E361DC2
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhF2LW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:22:28 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:3842 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhF2LW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 07:22:27 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2021 07:22:27 EDT
Received: from [79.233.236.111] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1lyBeD-0003nX-V7
        for git@vger.kernel.org; Tue, 29 Jun 2021 13:11:22 +0200
From:   Martin <git@mfriebe.de>
Subject: feedback/idea about "switch -C" force create
To:     git@vger.kernel.org
Message-ID: <20eb626d-89b4-fe2a-7cf4-c596b634f0f8@mfriebe.de>
Date:   Tue, 29 Jun 2021 13:11:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, my first post, hope it's the correct place.

I've been using the new git switch for some time, and also I have helped 
people new to git.
When people are new to git, I try to avoid introducing them to commands 
that can loose them commits (such as git reset).

"git switch" however has to be on the list of commands that new user 
have to learn early, but unfortunately when used with "-C" it may cause 
the loss of commits.
I am aware, it is a force option. But I still think it may be better if 
it could emit a warning, or even reject the job.

Reasons:
1) Newcomers may not be aware of the extend of such a force at all. 
Newcomers may not expect loss of commits, on such an elementary command.

2) People aware that it is a "force" may not be aware of the extend of 
the force, because there are either up to 2 actions forced.

Action 1)
The move of the branch is forced.
- That means, the info which commit was on the top of the branch before 
will be lost.
- Also the move may affect push-ability without "force"

Action 2)
The commit may be lost (except for the reflog, but many less experienced 
people do not know that).
This loss is dependent on other factors. It may or may not happen.
Because it does not always happen, people may not expect it.

As a result:
- A user could believe the force is for the effect on the branch, and be 
unaware of the loss of commit
- A user (ever experienced) could opt for the force in the good belief 
that their commits are held by other branches, when maybe they are not.

Therefore I believe, it would be best, if   git -C  branch new-location
would give an error, if this will lose commits.

There could be
- a git config to  toggle this
- an additional command line option to extend the force to drop commits


I would like to know if that idea might in general be acceptable at all.
If so, where it could or should be made as a feature request 
(unfortunately I wont be able to provide a patch myself)


On top, I would propose that the documentation of the current behaviour 
should be made more clear.

https://git-scm.com/docs/git-switch about -C / --force-create
>   Similar to --create except that if <new-branch> already exists, it 
> will be reset to <start-point>. This is a convenient shortcut for:
>
>   $ git branch -f <new-branch>
>   $ git switch <new-branch>
While the word "force" is in the option itself, the description does not 
explain what is forced, or what effects this may have.
Instead it only refers the user to study another option.
I believe the documentation should state directly
- commits currently in part of that branch may be lost [under certain 
circumstances]

and maybe, but less important
- the old location of the branch will be lost


