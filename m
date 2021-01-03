Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB0EC433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 22:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9051E2078D
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 22:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhACWDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 17:03:31 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:35625 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhACWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 17:03:31 -0500
Received: by mail-ed1-f45.google.com with SMTP id u19so25371584edx.2
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 14:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=28wWApBZcGDoAts7mB6/CqmBJMeiJygDSHHMT3r8c6A=;
        b=B5T5G4I0ynMrCM826mv9hWqpF8+83GlYbqGKJw6ro/Ee8MWme2oBCbzZw2T95Si7ko
         qzpK45GauSJxX/9FR2dwmpxRuG1fH8W7yeiYxrfp9o/Ub1VZpPHRC5cDYTg2+dEYVSwB
         av3OinJtxvt0NJyBFrzMNeTyou84a94SvB3bZBJDqeFDYu+gEzR+spjjUpdeIWh7MCdI
         oyQtNtfMB/nPROw5m+7XiLjvJEAiqPspqLdSe2vrbGalGoKEgxh6b8sHh9a6a0g0y3wN
         G3zos23B27TvjMtVYQILQj9xGQ0JBGq4UpeX5IKaxt+V6SplryVsVkdMDFC80AWqsf7e
         FLkw==
X-Gm-Message-State: AOAM533dv3+S9lh1Ypcs+NLJ8zkPJEgIRV4nyH9KsnAAWVcGVKPRgzyq
        1tgXoNVTJ2Ug2xGFlKfxLbpbxjkpv2Y0L54lPbsD5XIFPBkMIA==
X-Google-Smtp-Source: ABdhPJz6zDa1Z4cm7feu3+8vwL4ebGF93yx8HXouh1WWtXDY9kBjfOzTiTOMd5oHIuZOGVFQ/J4KhnBaFpTc3pF5tp0=
X-Received: by 2002:a05:6402:687:: with SMTP id f7mr15393810edy.314.1609711369007;
 Sun, 03 Jan 2021 14:02:49 -0800 (PST)
MIME-Version: 1.0
From:   Andrew Oates <andrew@andrewoates.com>
Date:   Sun, 3 Jan 2021 17:02:37 -0500
Message-ID: <CAAVLcG5Z0UnKVyBYyvPXdPWU-Q0-jEaUC=f3gDxZoaKqSUKN3g@mail.gmail.com>
Subject: git pull/rebase bug: when "onto" branch has rebasing branch's commits
 in reflog
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've poked at the source code but haven't found exactly what causes
the issue --- but if you do a 'git pull --rebase' or 'git rebase' onto
a tracking branch that has previously pointed to a commit that the
rebasing branch includes, the rebase will be a noop.

In practice I've hit this a few times lately when splitting a topic
branch into two branches after the fact.

Here is a short repro:
```
git init
touch file1
git add file1
git commit -a -m "first commit"
touch file2
git add file2
git commit -a -m "second commit"
touch file3
git add file3
git commit -a -m "third commit"
git checkout -b branch
git branch --set-upstream-to=master
git checkout master
git reset --hard 'HEAD^1'

touch file2.5
git add file2.5
git commit -a -m "second-and-a-half commit"
git --no-pager log --oneline --all --graph

#rm .git/logs/refs/heads/master

git checkout branch
git pull -v --rebase
git --no-pager log --oneline --all --graph
```

This outputs,
* 58432a7 (branch) third commit
| * 0e4f775 (HEAD -> master) second-and-a-half commit
|/
* 37b2e3f second commit
* 5e9f0b7 first commit
...
Successfully rebased and updated refs/heads/branch.
* 0e4f775 (HEAD -> branch, master) second-and-a-half commit
* 37b2e3f second commit
* 5e9f0b7 first commit

showing that "third commit" is lost.  If you execute the "rm ..."
line, then the sequence works as expected, and the final state is,

Successfully rebased and updated refs/heads/branch.
* b636309 (HEAD -> branch) third commit
* 410a5dc (master) second-and-a-half commit
* 41981d0 second commit
* 286398d first commit

My best guess is that there's something odd happening in get_fork_point().

Cheers,
Andrew
