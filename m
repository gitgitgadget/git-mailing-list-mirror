Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9884EC43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733E520700
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 10:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfLNKjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 05:39:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38874 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfLNKjW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 05:39:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so1478821wrh.5
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 02:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Od6W5ZZ6ZOfUExs72yvQ+wmAdjMCafBhqXTNqKLRa0I=;
        b=e/Ch7WzD54Sj8Rn2I9dfz9vqdu9zumDjivmFKEGSRBEVi2EthFt5eUgZTMbcpdMwce
         qLRsqUMJhZ0T34Vss0MT5SSdYNC8EtrfWaS8+VSSZmKs22kp6tn7rEZ5ulqXrviGZaMP
         y2K2YBLr9KfQoPPH+dmw+IWq6G5WaY4KMIv1bWtA8Jg7GDGeg1m+oAP29MVBR/UGNVDT
         moRVufDCT6BrRRvWDb50Rk9ZUowR3YCXNBxC+VAbBrOPRXSDm7yGzsxGZrK6/TTcxi+w
         a/0pbWwYQ3ewyH2oab8XCZFUloskjNONlnNqpBuTRaxsllquxJLcDwyhB218GjB5Rjkt
         nO4w==
X-Gm-Message-State: APjAAAW6vhyUzaKSkVfMff519LL/TCC8xds2eOoWJDUfe9JkzuAeeL7H
        Dgesz7kMQ9hD7C3aWJV38Cf5JYxx07kc28+cLLkxYl6ZDFU=
X-Google-Smtp-Source: APXvYqymAsL46YNCxwbuWHt89JPmIOLN0GcPxnzJEfOCB/6CBioi0pDlJtQxnMwCIGHdG6WYlIL/Cm0aR8Wi0+tqT4w=
X-Received: by 2002:a5d:428c:: with SMTP id k12mr18130457wrq.57.1576319960489;
 Sat, 14 Dec 2019 02:39:20 -0800 (PST)
MIME-Version: 1.0
From:   Mikael Simonsson <m@mikaelsimonsson.com>
Date:   Sat, 14 Dec 2019 10:39:09 +0000
Message-ID: <CA+PLxnUR2skor9CGfDKfEEm8XTmoHwM2cDf5Kpgt-ppo=4zhbQ@mail.gmail.com>
Subject: Bug? git commit fileA tries to delete fileB and other oddities
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have the following problems with a local repository:

* git commit fileA tries to delete fileX (fileX still exists).

* git restore --staged fileX doesn't work, the file remains staged.

* A commit from a few days back deleted 2 random files that I haven't
touched or staged in months and pulled in staged changes I didn't ask
for.

git version: 2.24.0 and 2.24.1 (OS: FreeBSD 12)

How can this happen? The repository has a local remote (on the same
filesystem) that is pushed to only. I tarred the project and copied it
to a Mac with git 2.23.0 and the problem persists.

For example (I've only changed the filenames):

% git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   fileA
        modified:   fileB
        modified:   fileC

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        ...


% git commit fileA

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes to be committed:
#       deleted:    fileX
#       modified:   fileA
#
# Changes not staged for commit:


% git stash
Saved working directory and index state WIP on master: 488e7081 ...


% git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    fileX

Untracked files:


% git restore --staged fileX


% git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    fileX

Untracked files:
  (use "git add <file>..." to include in what will be committed)


Thanks,
Mikael
