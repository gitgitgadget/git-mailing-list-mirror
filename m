Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E85C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A99D23B6C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 18:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgLRSIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 13:08:41 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:36468 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgLRSIl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 13:08:41 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4CyH0H3Bjgz5tlF;
        Fri, 18 Dec 2020 19:07:59 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6243220C0;
        Fri, 18 Dec 2020 19:07:58 +0100 (CET)
Subject: Re: [PATCH 0/2] git-gui: Auto-rescan on activate
To:     Stefan Haller <lists@haller-berlin.de>,
        Stefan Haller <stefan@haller-berlin.de>
Cc:     me@yadavpratyush.com, git@vger.kernel.org
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <e5f6753b-10b3-1291-1b39-34af63792037@kdbg.org>
 <1271e604-d016-1ddf-8370-49f5d3db44be@haller-berlin.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <dbe7278e-8a2c-e208-e482-435b9194c0d7@kdbg.org>
Date:   Fri, 18 Dec 2020 19:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1271e604-d016-1ddf-8370-49f5d3db44be@haller-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.12.20 um 11:36 schrieb Stefan Haller:
> On 17.12.20 20:45, Johannes Sixt wrote:
>> It is unclear which file is selected automatically when there are
>> unstaged changes. But there is one misbehavior: after I have invoked the
>> merge tool, resolved the conflict, and then switch back to Git GUI, the
>> conflicted file is not selected anymore when it is not the first file in
>> the list. That is *very* annoying.
> 
> I tried to reproduce this, but couldn't. It would be helpful if you
> could post a more detailed reproduction recipe.

I cannot reproduce this on Linux. But I am on Windows most of the time,
where it happens always. Note that you need two conflicted files. For
example (in a temporary git.git worktree):

   git checkout b4100f366c1e~
   git -c rerere.enabled=0 merge b4100f366c1e^2

Select the second conflicted file, invoke the merge tool via the context
menu, resolve the conflict, save and close the merge tool. Notice that
the first conflicted file is now selected.

Note that a rescan happens automatically even without the patch under
discussion when the merge tool (when invoked via the context menu) is
closed. This patch starts a simultaneous rescan. Perhaps it is a timing
problem of some sort.

> Another related aspect: if you select an untracked file and then trigger
> a manual rescan, the file is no longer selected; it selects the first
> tracked, modified file instead. I don't know why it does this, I find
> this annoying. The auto-rescan doesn't have this behavior, it keeps the
> untracked file selected, which I like.

The idea behind the old behavior is that a change is more important than
an untracked file. Also, a conflicted file is more important than a
change; hence, if you have a normal unstaged change selected, and then
rescan, a conflicted file is selected.

>> And then there is the following use-case. While Git GUI is not active
>> (think Git GUI and Gitk side-by-side and Gitk active), I click on a
>> particular file that is not at the top of the list; then Git GUI becomes
>> active and rescans, but also forgets on which file I have clicked. But I
>> expected the clicked-on file to become visible, which it doesn't, and I
>> have to click again. This is mildly annoying.
> 
> Like Pratyush, I can't see why this should happen, and I can't reproduce
> it on my machine (Mac). What system are you on?

I can reproduce this on my Linux box the same way as it happens on
Windows. Just have two files with changes, then activate another window
such that the unstaged file list remains visible, then click on the
unselected file in Git GUI. Notice that it is not selected after Git GUI
becomes active.

-- Hannes
