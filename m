Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8566C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 23:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiIVXaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 19:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIVXaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 19:30:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C92CDC8
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:08 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b11-20020a170902d50b00b0017828988079so6983393plg.21
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date;
        bh=97ADIcgiJmQYCEaRRA/E801VeGN35vo6JH11nRseEks=;
        b=dmFSirsDXSHm54D9l0V5tmDKFPcCPVTRV36xykKyDgHL9IrG+6H1ACqD1njldcdXg6
         7cCS+Ll9qaSQIYwMuY6vUcHGgWTwyp+7o3TqU+fxtm7Bp9RVnRKUsZbTs2TIgitYQO84
         axmEgyOEhhv2dUzs7v2uPib03IKG7rmBWgQpkqMq/LVmSo0ovn0JPuaMkUyYpFGppm8o
         IRL+PnSel69VDDpLMYX1DwkMhLD+52tIbPhVO+cnLNCc3abOGEKEXYbbbKxqTuFJNrQO
         Ey81/m8uPf5362a4aCHIj/UVzzp6Ntns6ovgGSucN4n2YuPyeYLycI/CeFYVHaS0vrla
         HwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date;
        bh=97ADIcgiJmQYCEaRRA/E801VeGN35vo6JH11nRseEks=;
        b=niy+Vvo0j7+AUf4GZXa776XOjeDzcmvUAlcY2TDa5oFQsRQnldxJhGOmu/z/G3BWOT
         XD4XiNo8JW0BTQsdyKF0szUMtQPuEbHMkSrVuXU2n20hkXLbMSOCIvuDFtso0CkASe8j
         HrBZ1wQ2pKqVwqW1o/VFDF6Nuacsz9O5qJtbS71ESNgu4uGtJEDDnI1iLaiZjgJ0PkbJ
         ZEOzZnq199s5FsibzEEU1FfLe2RZpgY1K/oBhoEKM6FFibge2Z7/M09E3M3rjgTl74iC
         68OCQWKGtgcqAyT2w5iMECFI/jRq7bZABCdwlNt/B9BhwkrLCXUy5Y6H3toBEw+bSk6b
         t8ww==
X-Gm-Message-State: ACrzQf2fA42F/B5pqfDibayGYqQJyXXFwuBwhE/gLU3eRd0wb9qQkYUg
        CqGeXqzPIGFAXSZnPKMv5+SZ81T/Neqmo9KnGDgnHDnRFPYnGmpvnVJuLZreRbNsDePUWPDRK8H
        jeMUHlEkR7xumX8SAjID6cR/qmgBSiaThY0NDVQHQwktOoYY7KhdxsMeNN88iONxSWg==
X-Google-Smtp-Source: AMsMyM65W/ma8r3RT+m+ODV2xEf/QtUy6I61cmJACugVVoqhdS55wEgXsOLFpCYdEHNHR4U3aFnQ/ubJu1DcQ44=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1a0e:b0:547:1cf9:40e8 with SMTP
 id g14-20020a056a001a0e00b005471cf940e8mr6059765pfv.82.1663889408346; Thu, 22
 Sep 2022 16:30:08 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:29:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922232947.631309-1-calvinwan@google.com>
Subject: [PATCH 0/4] submodule: parallelize status
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git status' in a superproject, git spawns a subprocess in
series to run status for every submodule. For projects with many large
submodules, parallelizing status subprocesses can significantly speed
up the runtime for both cold and warm caches.

Here are some timing tests from running status on the Android Open
Source Project (AOSP). My machine has an SSD and 48 cores.=20
  Warm Cache:
    git 2.37
Time (mean =C2=B1 =CF=83):     17.685 s =C2=B1  2.040 s    [User: 5.041 s, =
System: 22.799 s]
Range (min =E2=80=A6 max):   16.168 s =E2=80=A6 22.804 s    10 runs

    this patch (status.parallelSubmodules=3D1)
Time (mean =C2=B1 =CF=83):     13.102 s =C2=B1  0.500 s    [User: 4.894 s, =
System: 19.533 s]
Range (min =E2=80=A6 max):   12.841 s =E2=80=A6 14.447 s    10 runs

    this patch (status.parallelSubmodules=3D5)
Time (mean =C2=B1 =CF=83):      3.994 s =C2=B1  0.152 s    [User: 4.998 s, =
System: 20.805 s]
Range (min =E2=80=A6 max):    3.744 s =E2=80=A6  4.163 s    10 runs

    this patch (status.parallelSubmodules=3D10)
Time (mean =C2=B1 =CF=83):      3.445 s =C2=B1  0.085 s    [User: 5.151 s, =
System: 20.208 s]
Range (min =E2=80=A6 max):    3.319 s =E2=80=A6  3.586 s    10 runs

    this patch (status.parallelSubmodules=3D20)
Time (mean =C2=B1 =CF=83):      3.626 s =C2=B1  0.109 s    [User: 5.087 s, =
System: 20.366 s]
Range (min =E2=80=A6 max):    3.438 s =E2=80=A6  3.763 s    10 runs

We can see that there are diminishing returns and even slightly worse
performance after a certain number of max processes, but optimally
there is a speed up factor of around 5.

  Cold Cache:
    git 2.37
      mean of 3 runs: 6m32s
    this patch (status.parallelSubmodules=3D1)
      mean of 3 runs: 5m34s
    this patch (status.parallelSubmodules=3D5)
      mean of 3 runs: 2m23s
    this patch (status.parallelSubmodules=3D10)
      mean of 3 runs: 2m45s
    this patch (status.parallelSubmodules=3D20)
      mean of 3 runs: 3m23s

We can witness the same phenomenon as above and optimally there is a
speed up factor of around 2.7.

Patch 1 adds output piping to run_processes_parallel so the output
from each submodule can be parsed. Patches 2 and 3 move preexisting
functionality into separate functions and refactor code to prepare
for patch 4 to implement parallelization.

Future work: The reason why status is much slower on a cold cache vs
warm cache is mainly due to refreshing the index. It is worth
investigating whether this is entirely necessary.

Calvin Wan (4):
  run-command: add pipe_output to run_processes_parallel
  submodule: move status parsing into function
  diff-lib: refactor functions
  diff-lib: parallelize run_diff_files for submodules

 Documentation/config/status.txt |   6 +
 add-interactive.c               |   2 +-
 builtin/add.c                   |   4 +-
 builtin/commit.c                |   6 +
 builtin/diff-files.c            |   2 +-
 builtin/diff.c                  |   2 +-
 builtin/merge.c                 |   2 +-
 builtin/stash.c                 |   2 +-
 builtin/submodule--helper.c     |   4 +-
 diff-lib.c                      | 120 +++++++++++++-----
 diff.h                          |   2 +-
 run-command.c                   |   6 +-
 run-command.h                   |   9 ++
 submodule.c                     | 213 +++++++++++++++++++++++++++-----
 submodule.h                     |   9 ++
 t/helper/test-run-command.c     |  31 ++++-
 t/t0061-run-command.sh          |  26 ++++
 wt-status.c                     |   6 +-
 wt-status.h                     |   1 +
 19 files changed, 372 insertions(+), 81 deletions(-)


base-commit: 5502f77b6944eda8e26813d8f542cffe7d110aea
--=20
2.37.3.998.g577e59143f-goog

