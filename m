Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85CB16423
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8RBYWqd"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-593f182f263so46391eaf.0
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 03:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702985428; x=1703590228; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:user-agent:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXqyayZgiuVr6XVojc+D2LueQpfDYl5jbYTPX3i9uBM=;
        b=l8RBYWqdQIv+qpLDnnSlH33DSznq9Y1+650mWh4xRwdGHMzjSpAroHRDWLX1la382r
         GEWkPZiOAVtqsC8MMVcNq+yHxmjlqQ18oYhdfupXtt2LHIrTp7Qc5XyGMlLCT4Ox18mq
         57dhpreTOBhuL/PWlSvgRrRYZ6GmEabOR0MWFCEFO93wnqwitJPQdKWVNbULsOQDF1q6
         82Y0+1d3UhM1o6vN/D6rAxi/zcmF+32oJV5OIitGAnt7dRDjHkkCQRqV4byVNPKs0JAc
         KcutlZP12lL0FKSYU2h+SMVYU1GkEjt2EdZgPVhHfnoSfwsQGgGhpWNqEvG+G4IvWkQP
         GK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702985428; x=1703590228;
        h=mime-version:message-id:date:subject:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXqyayZgiuVr6XVojc+D2LueQpfDYl5jbYTPX3i9uBM=;
        b=suf24B6jG6ytZnmf6cQajAKYpVbCdk4ByAfAbTgeKmNmTnQywFlNbdtV9mXDcFvSj8
         1e5F9XbhDJZiEQXF2GrRG+rceLg4ExNJfGaVnb4b0hABTiI8kTJEbunbJB6gk1PYljtW
         olUZ4NnLjS5AIn+Z/c1pGkNvo5NWXukg4HIWrxiS+Ya0rEcv84jGhtl53uFlrDyfgva/
         wWoRbRrWYT+bfyGOh1AYuGiO/jLrS7a3T8ufQi6nuJfN1L6miyZ0Rvn0VwqoxwFf02bm
         THWkGMwyy4BUTxzHZTuA6EicoTfhl7aTPbBJrUizOPVBpQsL5OCw0D7ttXk4OqiCGxFo
         lxZA==
X-Gm-Message-State: AOJu0YwiY6wZLx32Xwntxp7e99zhd+3xSi0pO3kuNmYxfsWqrSkzUt0U
	TQ6AC/Rz8qyDhNelAWKLpT99kIvmeug=
X-Google-Smtp-Source: AGHT+IE/Onc/YnzzaJwjM+WOc9FDXKqaqDrhjTFm1gqY4aBunsiXX6xq67FQylMbCG7C9+ashLn9lA==
X-Received: by 2002:a05:6820:2d44:b0:58d:be0d:6f7b with SMTP id dz4-20020a0568202d4400b0058dbe0d6f7bmr28342528oob.1.1702985428513;
        Tue, 19 Dec 2023 03:30:28 -0800 (PST)
Received: from epic96565.epic.com ([2620:72:0:6480::3e])
        by smtp.gmail.com with ESMTPSA id q23-20020a4a6c17000000b0058e200a9065sm5597346ooc.29.2023.12.19.03.30.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 03:30:28 -0800 (PST)
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: git <git@vger.kernel.org>
Subject: [BUG] `git add -p` seems to corrupt a sparse index
Date: Tue, 19 Dec 2023 05:20:03 -0600
Message-ID: <m01qbia0q5.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


What did you do before the bug happened? (Steps to reproduce your issue)

    git init
    for dir in a b c; do mkdir $dir && seq 1 20 > $dir/file; done
    git add -A && git commit -m'Some content'

    git sparse-checkout set --sparse-index b
    seq 1 20 > b/file-2
    git add -N b/file-2
    git add -p b/file-2
    git status

What did you expect to happen? (Expected behavior)

  I expected to be dropped into the interactive-add workflow / see my
  changes in git-status.

What happened instead? (Actual behavior)

  git-add reports 'No changes' and git-status reports nothing at all
  (empty output).

  The original internal report also was able reproduce messaging like

      fatal: cache entry out of order
      warning: die() called many times. Recursion error or racy threaded death!
      fatal: cache entry out of order
      fatal: cache entry out of order
      fatal: cache entry out of order

  though I've not been able to reproduce that myself. It seems relevant
  / worth noting that core.fsmonitor would be set to 'true' in that
  repository.

What's different between what you expected and what actually happened?

  git-status appears to silently crash in the error case.

  Compare the broken workflow with any of the following variants (all of
  which work as expected):

  - don't use `--intent-to-add`:

      git init
      for dir in a b c; do mkdir $dir && seq 1 20 > $dir/file; done
      git add -A && git commit -m'Some content'
      git sparse-checkout set --sparse-index b
      seq 1 20 > b/file-2
      git add b/file-2
      git status

  - don't use `sparse-checkout` at all:

      git init
      for dir in a b c; do mkdir $dir && seq 1 20 > $dir/file; done
      git add -A && git commit -m'Some content'
      seq 1 20 > b/file-2
      git add -N b/file-2
      git add -p b/file-2
      git status

  - don't use `--sparse-index` specifically:

      git init
      for dir in a b c; do mkdir $dir && seq 1 20 > $dir/file; done
      git add -A && git commit -m'Some content'
      git sparse-checkout set b
      seq 1 20 > b/file-2
      git add -N b/file-2
      git add -p b/file-2
      git status

Anything else you want to add:

  Seems very related to the use of sparse-index.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.0.windows.1
cpu: x86_64
built from commit: 4b968f3ea3b32a7bc50846bab49f3f381841d297
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]


--
Sean Allred
