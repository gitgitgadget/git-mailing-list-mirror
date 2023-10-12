Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405FECDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 18:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjJLS26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379577AbjJLS2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 14:28:53 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569BCA
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 11:28:50 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S5ynn3Mjrz9slX
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 20:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kircheis.it; s=MBO0001;
        t=1697135325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rgpLOfbNVhaxITcfNAO0lio92TWaOrfUv4eJKOTCQy8=;
        b=rIVJzlqqbGY6uR9dFdB9Fxvt5zjsMqQPyqsJkEMwydjYI9tOZH4cKYbFS/kWjSk0ge8FN6
        YEQSeVXx8lwXLnkpcqVdaiMcvGqBIWI6SvvLKVWoqd5v63UBnfPmgT2sYBcbz9SZZpDLEo
        7fUxF58aTjHt511UduuT9aQhzS/v4BgcCFr3MPNGStanhyne8e/zZIztcdCQGajpz6jCkw
        sz9tIx3ynVkqCZ1qzJwqAR8v0xR0AGIDIK7XQZRJ/rvpmZN9ZUbN7T7W66v/ES4nXljDBN
        9VOVrBqGrpYmlYoJsaWyLWBEyn/GNE0rToBLm8r3Wu7h1jnIBcMkeZ4B8XXrsQ==
Message-ID: <88905bf2-480b-4aa7-bd1d-a13efa31d8d8@kircheis.it>
Date:   Thu, 12 Oct 2023 20:28:44 +0200
MIME-Version: 1.0
To:     git@vger.kernel.org
From:   Federico Kircheis <federico@kircheis.it>
Subject: git and multiple processes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4S5ynn3Mjrz9slX
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I wanted to know if concurrent command can "break" a repository, ie put 
it in an inconsistent state.

I suppose that as long all commands are only querying the status (log, 
reflog, status, ....) then such a thing will not happen.

I guess that if only one command changes the status (add, commit, pull, 
fetch, push, ...) then the output might be "wrong", but the command that 
queries the status does not interfere with the others.

But what if two commands that change the status?
For example a git fetch and git add or git commit at the same time?


A use-case I had recently was me doing "git commit -p" from one console, 
and noticing a change I wanted to undo.
I skipped the change, and while "git commit -p" showed me the next diff, 
I opened another console.
 From there, I did a "git checkout", and reverted the change I just skipped.

Is such use-case supported?

Everything worked as I expected, but it would be nice to know that I did 
not "risk" anything.

The use-cases I am most interested in is when working with worktrees.

What if I add a worktree, and "work concurrently" in two worktrees?
For example while git is switching branches in one worktree, doing a 
commit in another worktree (assuming I'm not switching to the branch 
where I am committing)
What if I am doing an automated "git bisect" in a worktree.
Can I work in another one (doing commits, fetch, rebase, reflog, stash, 
...)?
What if I have a cron job that executes  "git fetch" in one worktree.
Is it problematic if I happen to execute git fetch at the same time from 
another worktree?
If those use-cases are not problematic, as all repositories are linked 
together, what are possible issues (ignoring bugs).

Common sense tells me that those operations are supported, but I could 
not find any reference, or if there are some guarantees that git wants 
to hold, no matter what the current status is.

Best

Federico
