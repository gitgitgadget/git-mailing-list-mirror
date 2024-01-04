Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9591EB2B
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Squj5cD4"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so2427551fa.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 22:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704351475; x=1704956275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUL+2N5HwKZflGEk5B8WefpCBHIzZkTj3eo6mRNkm1E=;
        b=Squj5cD48j6bdTCs0jBYF4cxbq2f9qexAA0vZ0l8cdv0At7ruMx9aaF7gKagfjHW2a
         ZOevHjdKSprIbzRINwrqSbWS/dJWr2oDRKQwm3IJrzwcrDE4PWFql8zu7PJMiQJsBYP8
         /9I9CHtc+zKZ4dm0qvDOZAAejVVgSor6q61TFE1SqtUsKzi8C5WiTKPXraBP8Xsdc+Ve
         bNnRhkZ6OdugjPsgm5bfdwYuebsCyWF9kq1cFNhEDS5u1BVglPMJnKd7EPfeMt5+i2Ue
         XwZECoFRqLZuJ63QjLE05Ky66b7aY33rx8qxxiIl82ksv9p51Q0n6DdA4gLQroSbMZdw
         4+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704351475; x=1704956275;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUL+2N5HwKZflGEk5B8WefpCBHIzZkTj3eo6mRNkm1E=;
        b=tlo4P6t4FAgRxnGqUT4wC6QU+6lwKspWpC5nZ3R5CdTovSMvLAm1sTO5Lxv8K/7vdH
         59QS3qJ+i22+3x9J/tRdIbajLw5frzq3NVhNagxxXqFBudkGCe9vLmaXWkRTU2fqxvy/
         rqDqcSzN6ViQlLWjpl4dyn9wRF9iyaekfygZCvF2t3Qmq8cj7CqwEoMnIId1/ovdBDPy
         i8x5dGCrRzMf4wp1gHr+XkX4zpsu64FtgU5onNsgF+8bIfktEQ/RVbIfdPd1p2Z0YXJP
         w76/zkNNtA9JlgphhNsgkkZ7ArHH4H3F9A2GSzCr7gl5oxr8mceNtrmPjZgwfinZsrRX
         82ng==
X-Gm-Message-State: AOJu0YwTspxKQTzhKR8tw1Tnmlk/6ipToD0KzY/8gYsftG62sKfO1sMd
	8FPUaf4RjS8+pv4/KzuV9IEQQJlfm/KjqflZ5/zLn7jcIbU=
X-Google-Smtp-Source: AGHT+IFZwV9UeQnstA97d0PB+dd814MVFy9zJJ2OnzFrGnsNULMHID51p1g1O6VCRtIug4XB1ZS6KqblBMHe/kkeRXw=
X-Received: by 2002:a2e:8758:0:b0:2cd:24db:4faf with SMTP id
 q24-20020a2e8758000000b002cd24db4fafmr67959ljj.58.1704351474565; Wed, 03 Jan
 2024 22:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brian Lyles <brianmlyles@gmail.com>
Date: Thu, 4 Jan 2024 00:57:18 -0600
Message-ID: <CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com>
Subject: Does extending `--empty` to git-cherry-pick make sense?
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The `--empty=(keep|drop|ask)` option added to git-rebase in
e98c4269c86019bfe057a91b4305f784365b6f0b seems like it would be
applicable to git-cherry-pick (and maybe git-revert for completeness?).
While the shared sequencer code likely would already handle this fairly
well (at a cursory glance from someone with very little knowledge of C
or git's codebase, admittedly), it's only exposed via git-rebase.

The use case in which this came up involves a semi-automated workflow
for moving commits between branches. At a high level, a tool is:

- Identifying commits to be picked based on a specific trailer value
- Using git-cherry-pick with `-x` to pick those commits
- Relying on the presence of the `(cherry picked from commit ...)`
  trailer to avoid re-picking commits that have already been picked

If the picked commits are then rewritten in the upstream such that there
are squashes or fixups, that trailer can end up missing in the upstream.
The next time the tool runs, it will end up trying to re-pick commits
that are already represented there. As a result, those commits become
empty upon being picked a second time and the cherry-pick ends up
breaking for the user to resolve:

    $ git cherry-pick main
    On branch feature
    You are currently cherry-picking commit cfd7cd9.
      (all conflicts fixed: run "git cherry-pick --continue")
      (use "git cherry-pick --skip" to skip this patch)
      (use "git cherry-pick --abort" to cancel the cherry-pick operation)

    nothing to commit, working tree clean
    The previous cherry-pick is now empty, possibly due to conflict resolution.
    If you wish to commit it anyway, use:

        git commit --allow-empty

    Otherwise, please use 'git cherry-pick --skip'

I'll spare the details, but we do expect this to happen with enough
frequency that we'd really like to be able to prevent it. The
`--empty=drop` option sounds like exactly what we want here:

    --empty=(drop|keep|ask)
    How to handle commits that are not empty to start and are not
    clean cherry-picks of any upstream commit, but which become
    empty after rebasing (because they contain a subset of already
    upstream changes). With drop (the default), commits that become
    empty are dropped.

Is there any real barrier to exposing that option to git-cherry-pick as
well? Was this an oversight, or intentionally left out? The
corresponding commit message doesn't seem to indicate any specific
reason for limiting it to git-rebase.

Thanks,
-Brian Lyles
