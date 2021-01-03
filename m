Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D6C433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 22:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039F420776
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbhACWeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 17:34:36 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:56564 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbhACWeg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 17:34:36 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4D8D7k5N77z5tlB;
        Sun,  3 Jan 2021 23:33:54 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 906EF49E0;
        Sun,  3 Jan 2021 23:33:53 +0100 (CET)
Subject: Re: git pull/rebase bug: when "onto" branch has rebasing branch's
 commits in reflog
To:     Andrew Oates <andrew@andrewoates.com>
References: <CAAVLcG5Z0UnKVyBYyvPXdPWU-Q0-jEaUC=f3gDxZoaKqSUKN3g@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4e508192-c3a9-4cac-3255-1324aba347d4@kdbg.org>
Date:   Sun, 3 Jan 2021 23:33:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAAVLcG5Z0UnKVyBYyvPXdPWU-Q0-jEaUC=f3gDxZoaKqSUKN3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.01.21 um 23:02 schrieb Andrew Oates:
> I've poked at the source code but haven't found exactly what causes
> the issue --- but if you do a 'git pull --rebase' or 'git rebase' onto
> a tracking branch that has previously pointed to a commit that the
> rebasing branch includes, the rebase will be a noop.
> 
> In practice I've hit this a few times lately when splitting a topic
> branch into two branches after the fact.
> 
> Here is a short repro:
> ```
> git init
> touch file1
> git add file1
> git commit -a -m "first commit"
> touch file2
> git add file2
> git commit -a -m "second commit"
> touch file3
> git add file3
> git commit -a -m "third commit"
> git checkout -b branch
> git branch --set-upstream-to=master
> git checkout master
> git reset --hard 'HEAD^1'
> 
> touch file2.5
> git add file2.5
> git commit -a -m "second-and-a-half commit"
> git --no-pager log --oneline --all --graph
> 
> #rm .git/logs/refs/heads/master
> 
> git checkout branch
> git pull -v --rebase
> git --no-pager log --oneline --all --graph
> ```
> 
> This outputs,
> * 58432a7 (branch) third commit
> | * 0e4f775 (HEAD -> master) second-and-a-half commit
> |/
> * 37b2e3f second commit
> * 5e9f0b7 first commit
> ...
> Successfully rebased and updated refs/heads/branch.
> * 0e4f775 (HEAD -> branch, master) second-and-a-half commit
> * 37b2e3f second commit
> * 5e9f0b7 first commit
> 
> showing that "third commit" is lost.  If you execute the "rm ..."
> line, then the sequence works as expected, and the final state is,
> 
> Successfully rebased and updated refs/heads/branch.
> * b636309 (HEAD -> branch) third commit
> * 410a5dc (master) second-and-a-half commit
> * 41981d0 second commit
> * 286398d first commit
> 
> My best guess is that there's something odd happening in get_fork_point().

To me, the outcome looks reasonable:

By the time when the branch was created, it had no commits on top of
master. Then master was rewound and grew in a different direction, while
the branch didn't do anything. When you rebase it to its upstream, you
should expect that no commits are rebased.

-- Hannes
