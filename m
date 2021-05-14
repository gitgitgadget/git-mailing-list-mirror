Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444D0C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133AC61442
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhENS14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:27:56 -0400
Received: from outmail149055.authsmtp.co.uk ([62.13.149.55]:37008 "EHLO
        outmail149055.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231891AbhENS14 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 May 2021 14:27:56 -0400
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 May 2021 14:27:55 EDT
Received: from punt22.authsmtp.com (punt22.authsmtp.com [62.13.128.207])
        by punt15.authsmtp.com. (8.15.2/8.15.2) with ESMTP id 14EIB65d071968
        for <git@vger.kernel.org>; Fri, 14 May 2021 19:11:06 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Received: from mail-c237.authsmtp.com (mail-c237.authsmtp.com [62.13.128.237])
        by punt22.authsmtp.com. (8.15.2/8.15.2) with ESMTP id 14EIB6N6040913
        for <git@vger.kernel.org>; Fri, 14 May 2021 19:11:06 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Received: from [192.168.0.212] (177.30.125.91.dyn.plus.net [91.125.30.177])
        (authenticated bits=0)
        by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPSA id 14EIB43p093699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Fri, 14 May 2021 19:11:05 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
To:     git@vger.kernel.org
From:   Ben Avison <bavison@riscosopen.org>
Subject: Bug in git submodule update --remote
Organization: RISC OS Open Ltd
Message-ID: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
Date:   Fri, 14 May 2021 19:11:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Server-Quench: bfcfc61f-b4df-11eb-ba2e-8434971169dc
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd1YggXA1ZfRRob ESQCJDVBUg4iPRpU DBlFKhFVNlUISSxP PUtAaFleKlsRQRde QTFFWlBLLQw4RmF1 aQtBbAxXY0tEXwAk WUlXQ1BXCgZoHx0G AQEcVxt3aAQIeXoF HDRmXTBbVUd8fE8z Rk1VFiNUMzQ2O2Ye Bl0Kc1cCbQJLK01Y OAF9AW4FZWYDb31h RlFiMzsnFyhQYCVT Cg4MMRoJXEwOGTIh Qx1KAC0jFFEID2B2 NREjLUIRdAAA
X-Authentic-SMTP: 61633632303230.1024:7600
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent-ish change in git 2.27.1, introduced in commit f0a96e8d, has 
also got me wondering about whether some related functionality is 
correct. I'm not sure what the best way to fix things is, so can I 
invite opinions?

The scenario: I have a repository with a submodule. The submodule's 
upstream repository uses a fork workflow, so the submodule has two 
remotes, one for pulling in other people's changes, and one for 
uploading my own pull requests.

$ mkdir myproject
$ cd myproject
$ git init
$ git submodule add https://github.com/acme/library
$ cd library
$ git remote add -f myfork https://github.com/user/library
$ cd ..
$ git add .
$ git commit -m "Initial commit"
$ git remote add origin https://github.com/user/myproject
$ git push -u origin master

Furthermore, assume I forked https://github.com/acme/example some time 
ago, so that the master branches between it and my fork have diverged.

Time passes. People hack away on both projects. I want to fix a bug or 
implement a new feature in the library, so I start by ensuring both are 
up-to-date:

$ git pull
$ git submodule update --remote
$ cd library
$ git checkout -b new-feature
$ # hack away
$ git add .
$ git commit -m "New feature"
$ git push -u myfork new-feature
$ cd ..

Some more time passes, and I want to work on it again. Again, I start by 
ensuring I'm up-to-date. Before git 2.27.1, I could do:

$ git submodule update --remote

Now, I get:

fatal: Needed a single revision
Unable to find current myfork/HEAD revision in submodule path 'library'

What's going on is that within "git submodule update --remote", the sha1 
used is formed by looking up the submodule's ref "<remote>/<branch>". 
The change in git 2.27.1 is that if no remote tracking branch is stated 
in the superproject's .gitmodules file, <branch> defaults to "HEAD" 
rather than "master" as previously. That's fine if <remote> is "origin", 
but in practice, it depends on how the submodule is currently checked out:

* if it's in detached HEAD state, <remote> is set to "origin"
* if its branch is not a tracking branch, "origin" is also used
* but if it's a tracking branch (as I used in my workflow above - not 
uncommon in pull request workflows because you might grant other people 
access to the branch during the review process) then it looks up the 
name of the remote which is being tracked

First observation: a ref called "myfork/HEAD" presumably *could* have 
been created by the "git remote add" command, reflecting that remote's 
default branch. Should it?

In practice, that's not actually what I'd want, though. If I do "git 
submodule update --remote", I personally normally do so as a shortcut 
compared to cloning everything again. I don't expect the behaviour to 
change depending on whether I happen to have left one of the submodules 
checked out on a tracking branch or not: myfork/master is potentially 
quite out of date compared to origin/master.

It also makes very little sense to me that issuing "git submodule update 
--remote" twice in quick succession would leave us in a different state, 
because the first call puts all the submodules into detached HEAD state, 
meaning that the second call always looks up the remote tracking 
branches from the submodule's "origin" remote.

One way this could be fixed is that if <branch> turns out to be "HEAD", 
we could force <remote> to be "origin". However, this doesn't address 
the equivalent problem that arises if the remote tracking branch *is* 
named in .gitmodules.

I'd therefore like to propose that "git submodule update --remote" 
*always* uses the remote named "origin" to form the ref used to check 
out the submodule. However, I'm not sure whether everyone would agree 
that this constitutes a bugfix, or whether I'd need to introduce a new 
switch to enforce this behaviour.

So, what do you think?

Ben
