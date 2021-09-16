Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BCBC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 03:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E837760F4A
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 03:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhIPDjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 23:39:36 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:20128 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhIPDjg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Sep 2021 23:39:36 -0400
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 23:39:35 EDT
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 419F81BFEE
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 05:29:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 960C71C3DC
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 05:29:24 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FMETbeIrhoDV for <git@vger.kernel.org>;
        Thu, 16 Sep 2021 05:29:24 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id C3C021C445
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 05:29:23 +0200 (CEST)
To:     git@vger.kernel.org
From:   Wesley Schwengle <wesley@schwengle.net>
Subject: Possible git bug
Message-ID: <30651e4d-10fb-8bc7-7f52-8fbabf042f4a@schwengle.net>
Date:   Wed, 15 Sep 2021 23:29:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=U7vs8tju c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=IkcTkHD0fZMA:10 a=7QKq2e-ADPsA:10 a=-POwkhUqAAAA:8
        a=oBQe3svx4sGut2FWm3QA:9 a=QEXdDO2ut3YA:10 a=5NxO59_FqQjEf5CpAN6O:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello,

I'm running into a weird issue with git at the moment and I'm wondering 
if this is a bug. I have a small reproduction path:

$ mkdir reproduction
$ cd reproduction
$ git init .
$ echo "commit a" > file.txt
$ git commit -m "First commit" file.txt
$ echo "commit b" >> file.txt
$ git commit -m "Second commit" file.txt

$ git switch -c foo
$ echo "commit c" >> file.txt"
$ git commit -m "Third commit" file.txt
$ git branch --set-upstream-to=master

$ git status
On branch foo
Your branch is ahead of 'master' by 1 commit.

$ git switch master
$ git merge foo
$ git reset --hard HEAD^
$ git switch foo
Switched to branch 'foo'
Your branch is ahead of 'master' by 1 commit.

$ git log --format='%C(yellow)%h%Creset %Cgreen%s%Creset'
5f427e3 Third commit
03ad791 Second commit
411e6d4 First commit

$ git rebase master
$ git status
On branch foo
Your branch is up to date with 'master'.

$ git log --format='%C(yellow)%h%Creset %Cgreen%s%Creset'
03ad791 Second commit
411e6d4 First commit

I do not expect to lose the commits from foo, it seems the ref of master 
doesn't get updated after a reset.

I didn't lose any work because I pushed my work to a remote and can 
still get it from there (and git reflog would also reach my code). It is 
rather surprising to see this kind of behavior.

I'm running:
$ git --version
git version 2.33.0.363.g4c719308ce

But I also got this behavior with the git shipped with Debian:
$ /usr/bin/git --version
git version 2.32.0

Cheers,
Wesley

-- 
Wesley Schwengle
E: wesley@schwengle.net
