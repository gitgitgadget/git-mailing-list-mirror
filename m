Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A5C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8840C610A6
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhIQQmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:42:25 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:48727 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhIQQmY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 12:42:24 -0400
X-Greylist: delayed 16968 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 12:42:23 EDT
Received: from [84.163.74.149] (helo=[192.168.2.202])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <project@mfriebe.de>)
        id 1mRCV1-0006Wi-Pi
        for git@vger.kernel.org; Fri, 17 Sep 2021 13:57:47 +0200
From:   Martin Friebe <project@mfriebe.de>
Subject: More on fork-point
To:     Git List <git@vger.kernel.org>
Message-ID: <8d74ce27-e3bf-792e-b767-c660a3cfc9e1@mfriebe.de>
Date:   Fri, 17 Sep 2021 13:58:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the current conversation on fork-point, I found 2 
documentation bits that I wanted to bring up for discussion

1)
https://git-scm.com/docs/git-merge-base#_discussion_on_fork_point_mode
> (it includes B0, which is not what you wrote; it is a commit the other 
> side discarded when it moved its tip from B0 to B1).

This sentence makes 2 separate statements
A)  "not what you wrote": You only want to rebase commits you wrote 
yourself, but not commits the other side wrote
B)  "the other side discarded": That can apply to commits written 
originally by the other side, or originally written by you.

In the context of the doc, it is easy to read "B" as "discarded commits, 
that the other side had written".
Leaving it unclear, what would happen if the other side, discard commits 
(from their branch) that you wrote in your branch.

Also the example graph in the doc, shows that the commits discarded by 
the other side, where commits written by the other side.

In the "Potential git bug" thread, this is what happens.
- A commit is made to branch foo
- the other side (branch master) includes that commit (which you wrote)
   git switch master
   git merge foo
- the other side drops/discards this commit
   git reset --hard HEAD^

So now "master" has dropped a commit you wrote.
When you "rebase --fork-point" do you want
a) commits you wrote (and only you wrote)
b) exclude commits discarded by the other side, even though they where 
yours originally?

Should removing/undoing  a merge mean:
- The merge should be prevented in future
- The merge is undone now, and may be done again in future.

Depending on this the behaviour of --fork-point may have to be adjusted.

Also, if the other side "master" was a remote branch. And my work was 
merged and then removed (on the remote), then what will happen?
Will by git repo be aware that the commit was "rejected"? Will it depend 
if I pulled while it was part of the other branch, so that I then had to 
"git reset" my local master to follow the forced push?

------------
Btw, something else I have not tested, but what should happen if:

X -> A -> A1 -> A2 -> A3
        \ -> B1 -> B2 -> A2 -> B3

"A2" was cherry picked into the "B" branch.
The "A" branch is rewritten to be
A1 -> A3

X ->  A1 -> A3
      \ -> A ->  B1 -> B2 -> A2 -> B3

fork-point would mean that B1..B3 will be replayed.
But should A2 be included in a fork-point rebase of B onta A?

This does matter, when reading the "rebase" docs. See the quote below, 
which contains "which commits have been introduced by <branch>."
"A2" was not introduced by my branch.

=====================
2)
https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---no-fork-point
> Use reflog to find a better common ancestor between <upstream> and 
> <branch> when calculating which commits have been introduced by <branch>.
And then, only at the end of the paragraph
> If your branch was based on <upstream> but <upstream> was rewound and 
> your branch contains commits which were dropped, this option can be 
> used with |--keep-base| in order to drop those commits from your branch.

Imho the part that "dropped commits from the other side, will not be 
re-introduced" is the key statement. Maybe that should move up?
But more important, why should this statement be limited to the context 
of keep-base"?
Maybe it should be

     If your branch was based on <upstream> but <upstream> was rewound 
and your branch contains commits which were dropped, this option will 
exclude those commits from being replayed. This
  can be used with |--keep-base| .

I am aware that is basically a summary of the "merge point" 
documentation (and hence a repeat). But the repeat is already in the 
"rebase" documentation.


