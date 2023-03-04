Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAEFC61DA4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 01:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCDBzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 20:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCDBzw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 20:55:52 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4F3A848
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 17:55:50 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id d10so2523779pgt.12
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 17:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677894950;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INIptvOMCJu7URZmkDuAKSNELyQ5XDfwEmHC3Yh8EJw=;
        b=PIR5sB2++CoJYOzaMO92yiSF53BoQhguXUwYcAd6OF4/tv/8kw6nm2FrabZsw+kszY
         1qMpOmrzDquu5aNuPx4SLPRGAp1CCq4+isD+csK74b68QZl/S6pLhv3T5f6X8zJzz8DR
         9bjj/micg8/kQuB3ylNEC0y78CeZRYuq73n9SYwqVNWEG4fKP23dcS6dU1DY7Nweya8F
         cAHfPQQ5XUfU6veUJG9QHllUr+jL1G4UFJg/QoC/9NzrqD1dXLUlHXFnwV85tIOrXdrh
         T2DXKgeKpN7zBalpBXgNEqoeLJQIloWiSt0ScYuvpUo6cAEAK0G8Ds7IFAYYF/k/jGIp
         bU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677894950;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INIptvOMCJu7URZmkDuAKSNELyQ5XDfwEmHC3Yh8EJw=;
        b=CdPE+8pkpjKVcaoKogmmmNp0o9lp9EP8cdz4zCUHyTWvNpywCdIjz83WyKM+TvKP1X
         AUbChuP0vSy4EZqssjpEkAsDbAIW1xcWrJtrEiRlNineCiZDs0TtsM8dVlb/itLhTPXE
         aN8KHJRDMSWjDde1HjUEHnfkL0YkbEIs795U8WkFxxg5ono7CKVeugefARwNaSIUn2K5
         cD1H2xApNBhnryTi29FMGhsfLq4mp5dXnPKvjnwCNN08wFXx97u4v92vhLVD7jK0aa93
         hN2Z52IgVdOsUKSapuM6DigapAXAiiFfkzw2AXnLbdgGrylbCU1RlTIBrW6IjYbfFOmN
         teUQ==
X-Gm-Message-State: AO0yUKWEiRKY7/eyqVNLu8aTj2GmnDpUlZhczyyJ0x4V0ouvHhBo/OPS
        r39sT6LX5RADtPUZH5YYx7Zc1FhJmjBNM1//6NCaEkeL1+xfzg==
X-Google-Smtp-Source: AK7set/znwCRy3TK5E7+73p7DTyqMpRDXhNsmiBH8Q9Jf4L3bJzx9NIY7iTo5MoMD4fSPRC0215y2c2CJCXZCBOCniw=
X-Received: by 2002:a62:ce49:0:b0:5a8:ac30:80bf with SMTP id
 y70-20020a62ce49000000b005a8ac3080bfmr1720549pfg.6.1677894949832; Fri, 03 Mar
 2023 17:55:49 -0800 (PST)
MIME-Version: 1.0
From:   Josh Smeaton <josh.smeaton@gmail.com>
Date:   Sat, 4 Mar 2023 12:55:13 +1100
Message-ID: <CAPbDM0d5Xe=KTLECDCJYtpzmBt2wqzZrMWVcbiisM+abopenig@mail.gmail.com>
Subject: Bug: diff-index reports unrelated files as deleted when fsmonitor is enabled
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git write-tree and then git diff-index reports thousands of files as `deleted`
when core.fsmonitor is true, even though the files are still present on the
file system.

What did you do before the bug happened? (Steps to reproduce your issue)

```
git config core.fsmonitor true
touch new-file.txt
git add new-file.txt
git diff-index --ignore-submodules --exit-code --no-color
--no-ext-diff $(git write-tree) --
```

What did you expect to happen? (Expected behavior)

I expected that no files would be reported as having changes.

What happened instead? (Actual behavior)

Thousands of unrelated files were reported as `deleted`.

```
git diff-index --ignore-submodules --exit-code --no-color
--no-ext-diff $(git write-tree) --
:100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
0000000000000000000000000000000000000000 D src/tests/__init__.py
:100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
0000000000000000000000000000000000000000 D src/tests/site/__init__.py
:100644 000000 d8edaad92120781998e811277f966551b12fc823
0000000000000000000000000000000000000000 D
src/tests/site/test_models.py

 ... thousands of other files
```

What's different between what you expected and what actually happened?

Thousands of unrelated files were reported as having been deleted.


Anything else you want to add:

Myself and a few co-workers all ran into this issue in the last few days. It
presented itself when pre-commit hooks were run (specifically with the
pre-commit
tool from github pre-commit).

When committing changes, the pre-commit tool runs the equivalent of:

`git diff-index --ignore-submodules --exit-code --no-color
--no-ext-diff $(git write-tree) --`

It then stashes and unstashes those changes, causing the files to be
removed from
the working tree.


```
$ git config core.fsmonitor true
$ git checkout -b test-branch
Switched to a new branch 'test-branch'

$ echo "test 3" >> newfile.txt
$ git add .
$ git status
On branch test-branch
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
new file:   newfile.txt

$ git commit -a -m "will it fail?"
[WARNING] Unstaged files detected.
[INFO] Stashing unstaged files to
/Users/josh/.cache/pre-commit/patch1677888420-10129.
trim trailing whitespace.................................................Passed
check python ast.....................................(no files to check)Skipped
check for case conflicts.................................................Passed
[INFO] Restored changes from
/Users/josh/.cache/pre-commit/patch1677888420-10129.
[test-branch 7c899582c19] will it fail?
 1 file changed, 1 insertion(+)
 create mode 100644 newfile.txt

$ git status
On branch test-branch
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
deleted:    src/tests/__init__.py
deleted:    src/tests/site/__init__.py
deleted:    src/tests/site/test_models.py
        ... lots more files ...

no changes added to commit (use "git add" and/or "git commit -a")

$ git status | wc -l
   15298

$ git restore .

$ git status

On branch test-branch
nothing to commit, working tree clean
```

It can be reproduced, in our repo, without using pre-commit at all:

```

git diff-index --ignore-submodules --exit-code --no-color
--no-ext-diff $(git write-tree) --
:100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
0000000000000000000000000000000000000000 D src/tests/__init__.py
:100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
0000000000000000000000000000000000000000 D src/tests/site/__init__.py
:100644 000000 d8edaad92120781998e811277f966551b12fc823
0000000000000000000000000000000000000000 D
src/tests/site/test_models.py

 ... thousands of other files
```

Using `update-index` with the `--no-fsmonitor` flag prior to diff-index does the
correct thing:

```
$ git update-index --really-refresh --no-fsmonitor
warning: core.fsmonitor is set; remove it if you really want to
disable fsmonitor

$ git diff-index --ignore-submodules --exit-code --no-color
--no-ext-diff $(git write-tree) --
> no output
```

The problem persists when running `update-index` without disabling fsmonitor.

I have reported this issue to the pre-commit project, but it looks like an issue
with fsmonitor + write-tree.

See: pre-commit issues on github #2795



[System Info]
git version:
git version 2.39.2 (others reproduced with 2.39.1)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.3.0 Darwin Kernel Version 22.3.0: Mon Jan 30 20:38:37
PST 2023; root:xnu-8792.81.3~2/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit
