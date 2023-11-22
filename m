Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agYipb+D"
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302EA91
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:08:49 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2839b922c18so125845a91.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680128; x=1701284928; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J0/yL11ZQ5u5NnLPfoeqN3QmRe4G9VS7UD9vHjGs/pE=;
        b=agYipb+DrhcYxP8A69NTvyMkwAxmX2r+Cvd/gpuYYHJ09Ou5loQxW16vQAQyI2y054
         VDoVsoRUvxUrAHXt5oRYZtV5XLDyoZ9igaZoU8NSy7pgSOLgATIa1WqniNy7dMqDaoCG
         STzeEr8vGdIAZGsJ7wHBiOXIXSdE+LQKXibyomy6LSg46TzxNsPwbadKAF5WmpE/YKCh
         cDrebufGNvimyqODYHZXop5Rl63TfwwMb78skr9Gtw2xoosfupl0ekMxpIUkKeesthsg
         bAq2FpX++mHfF6Ey/PAqLcKKracMQ/Q6fzZYesoBsgnrhiBSgX+UgrPY6MtVOANFJkox
         4Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680128; x=1701284928;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0/yL11ZQ5u5NnLPfoeqN3QmRe4G9VS7UD9vHjGs/pE=;
        b=dGAvheK3Eqpot3qhInCFgQ1Z0EUlpenLTjK2rBJ3181gazWZ2Rw0+s+hjhEyScrj0q
         FdWVLOHNxkPOcGz/sPkyugOLGLN4yjY0bsgwmwAkKcmwCxbV1W0s6wqxg21/nfGkT4DK
         k0VsBx0rdg6mWinQPgi7o3YJR0JNVqZnuWGC1o6IoqicuI9fDBu9d7a1L/yKk4ucBn9Z
         6NXbzB/uK+R2ouOsVskF1kwK997qHYuRVmWagIJIozxg0THh5lLnDV2sBaWthtLnfM1e
         nFPcPDnVOZV25vudSu1A1fiac7EXwPYGnaJT/Xl9/oSn60bPI659leFbKJs1L2idMr9Y
         igig==
X-Gm-Message-State: AOJu0Yxhdx+4sqkf1XbMX9S1au0U6MXCvISuAhP8oGIBDxnWsLz4nSgV
	vap2wywburBSbpfbcT5ksoUU4QeHOhi22bpfp300ZLrI2GQ=
X-Google-Smtp-Source: AGHT+IHV7/rUG8IfkFixIM6ZwqVMsJPaXF2Ezozrml6LsyPCxc8XhI+u2EaZMJRwjfSRfa2/6geVW95yz2g61+7jIHA=
X-Received: by 2002:a17:90b:3b52:b0:27e:1ea0:c6fc with SMTP id
 ot18-20020a17090b3b5200b0027e1ea0c6fcmr3667657pjb.6.1700680128026; Wed, 22
 Nov 2023 11:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Willem Verstraeten <willem.verstraeten@gmail.com>
Date: Wed, 22 Nov 2023 20:08:36 +0100
Message-ID: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
Subject: git checkout -B <branch> lets you checkout a branch that is already
 checked out in another worktree Inbox
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

# What did you do before the bug happened? (Steps to reproduce your issue)

Clone a repo
Create an additional worktree for that clone
Use `git checkout -B branch-of-primary-clone ...` to checkout the
branch that is already checked out in the primary clone

For example, with the pathfinder repo on GitHub:

    git clone https://github.com/servo/pathfinder.git primary
    cd primary
    git worktree add -b metal ../secondary origin/metal
    cd ../secondary
    git checkout -b main #reports a fatal error, as expected
    git checkout -f main origin/main #also reports a fatal error, as expect=
ed
    git checkout -B main origin/main # ----> this succeeds, which is
unexpected <----

# What did you expect to happen? (Expected behavior)

I expected a fatal error stating that the branch could not be checked
out since it was already checked out in my primary worktree

In `git checkout --help`, it is documented that `git checkout -B` is
the atomic equivalent of `git branch -f <branch> <commit> ; git
checkout <branch>` :

> If -B is given, <new-branch> is created if it doesn=E2=80=99t exist; othe=
rwise, it is reset. This is the transactional equivalent of
>
>     $ git branch -f <branch> [<start-point>]
>     $ git checkout <branch>

# What happened instead? (Actual behavior)

The branch was checked out in the secondary worktree. If I then work
and make commits in this secondary worktree, the status of my primary
worktree gets clobbered as well.

What's different between what you expected and what actually happened?

The checkout in the secondary worktree is allowed, but it shouldn't be


[System Info]
git version:
git version 2.41.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.6.0 Darwin Kernel Version 22.6.0: Wed Jul  5 22:21:53
PDT 2023; root:xnu-8796.141.3~6/RELEASE_ARM64_T6020 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
