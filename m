Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063FFC433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 02:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376801AbiD3CZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 22:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiD3CZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 22:25:38 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BB66E546
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 19:22:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 125so11468879iov.10
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 19:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=danielyli-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=vakzOLOHGXw9AOcEV3+M88M/YntzMrtYrRKGxTg0MVs=;
        b=gYEIVOz5IspnyLPGvvngxPROFFR1Dij/xlx3iYOGgz0VnGoE/bHWNjzJFK3HlGtukr
         2aZzt9yl0IiyCYGwvD3QlQms+e5hc0JNL1S5BZoz6nIMNmXYrsRao5Al+xYkLPKJp6Y+
         cz8j9P5Jrhort38QArfFGQeh7HaFtmoezS5uymgo43uKAvFC3Yv+T+DwbxTVNb99SckB
         kJH/Dolp2vkRCkRBuv6hg72sFmA/3RFYhQUwr1e55NfzrT0ej7qiN1/sNZSMe1A7Apd2
         QXaNcPcQI4FL7GRus+BRdorsM13LIwMKBCVzXPfWNuYgULcM/N4PleG0ZT6bfxlHzv8R
         B/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vakzOLOHGXw9AOcEV3+M88M/YntzMrtYrRKGxTg0MVs=;
        b=Wz6cvb1OfF25Gc2cXDv9MRMyEHZRKaGRTl79anVduqeIjQIKGD/7R3ItoRcKYFheKg
         JHVxPkQKdFZyB21IdFovUd+F/bENO8gFtkorKIOR9cKl1oYllNc3lf9/3S0vkw4Sv7jJ
         sqOlO7Wp5sGjmdv4VRaTOJZqWifY0UNdGVtTdrNjnfim0vQodmVl4jB9guWcPHpQfrez
         jIqoiQCL2b9GN8v20P80Mo8GN+i2cn2cn16tUIQdnboU/lv8HTPtFfGR3DukpJsgJJar
         bSSRPDjY/pYnO40YmJJbBejx2jNKO7p170GaKoq/bAxh+KUZzInUyr9yQJsApzbqWt2T
         MAQw==
X-Gm-Message-State: AOAM533xm7SHjHyN4KaLEY+iKUHBzrCsq/ee6FunvQSL5Ny8jO6PM2Vo
        SQdJNr+o5aQVYgJlVrpBTWZCEx6mbx/6+osvj6IDA9nuL7ZdyQ==
X-Google-Smtp-Source: ABdhPJx1m+/oRUfgDTMP0DmRpRxlCZFw1E7Y12gPhyvk+Rw361VqU75YaA8VZik64O8QiqK3WJ+T+zskjkakaG8YyNs=
X-Received: by 2002:a6b:4912:0:b0:654:b214:de9e with SMTP id
 u18-20020a6b4912000000b00654b214de9emr903926iob.182.1651285337671; Fri, 29
 Apr 2022 19:22:17 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Li <dan@danielyli.com>
Date:   Fri, 29 Apr 2022 19:22:06 -0700
Message-ID: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
Subject: Bug: `git show` honors path filters only for the first commit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version: 2.36.0
OS: macOS Monterey 12.2.1
Installed via: homebrew

Bug summary: When `git show` is invoked with more than one commit, it
only respects the `<path>` filters for the first commit.

This is best illustrated with an example. In git's own source repo,
invoke `git show --oneline --name-only ecc7c8841d 961b130d20
d3115660b4` and observe the files these commits touch (the `--oneline
--name-only` arguments are to make this example short; they're not
relevant to the bug):

    $ git show --oneline --numstat ecc7c8841d 961b130d20 d3115660b4
    ecc7c8841d repo_read_index: add config to expect files outside
sparse patterns
    2       0       Documentation/config.txt
    27      0       Documentation/config/sparse.txt
    1       0       cache.h
    14      0       config.c
    1       0       environment.c
    2       1       sparse-index.c
    19      0       t/t1090-sparse-checkout-scope.sh
    961b130d20 branch: add --recurse-submodules option for branch creation
    3       0       Documentation/config/advice.txt
    26      11      Documentation/config/submodule.txt
    18      1       Documentation/git-branch.txt
    1       0       advice.c
    1       0       advice.h
    141     0       branch.c
    29      0       branch.h
    38      6       builtin/branch.c
    38      0       builtin/submodule--helper.c
    61      0       submodule-config.c
    34      0       submodule-config.h
    9       2       submodule.c
    3       0       submodule.h
    292     0       t/t3207-branch-submodule.sh
    d3115660b4 branch: add flags and config to inherit tracking
    2       1       Documentation/config/branch.txt
    17      7       Documentation/git-branch.txt
    1       1       Documentation/git-checkout.txt
    1       1       Documentation/git-switch.txt
    42      7       branch.c
    2       1       branch.h
    4       2       builtin/branch.c
    4       2       builtin/checkout.c
    3       0       config.c
    16      0       parse-options-cb.c
    2       0       parse-options.h
    10      1       t/t2017-checkout-orphan.sh
    23      0       t/t2027-checkout-track.sh
    28      0       t/t2060-switch.sh
    33      0       t/t3200-branch.sh
    17      0       t/t7201-co.sh

Now invoke the same command but filtered on files under the
`Documentation/` directory. Observe that this path is only respected
for the first commit:

    $ git show --oneline --numstat ecc7c8841d 961b130d20 d3115660b4 --
Documentation
    ecc7c8841d repo_read_index: add config to expect files outside
sparse patterns
    2       0       Documentation/config.txt
    27      0       Documentation/config/sparse.txt
    961b130d20 branch: add --recurse-submodules option for branch creation
    3       0       Documentation/config/advice.txt
    26      11      Documentation/config/submodule.txt
    18      1       Documentation/git-branch.txt
    1       0       advice.c
    1       0       advice.h
    141     0       branch.c
    29      0       branch.h
    38      6       builtin/branch.c
    38      0       builtin/submodule--helper.c
    61      0       submodule-config.c
    34      0       submodule-config.h
    9       2       submodule.c
    3       0       submodule.h
    292     0       t/t3207-branch-submodule.sh
    d3115660b4 branch: add flags and config to inherit tracking
    2       1       Documentation/config/branch.txt
    17      7       Documentation/git-branch.txt
    1       1       Documentation/git-checkout.txt
    1       1       Documentation/git-switch.txt
    42      7       branch.c
    2       1       branch.h
    4       2       builtin/branch.c
    4       2       builtin/checkout.c
    3       0       config.c
    16      0       parse-options-cb.c
    2       0       parse-options.h
    10      1       t/t2017-checkout-orphan.sh
    23      0       t/t2027-checkout-track.sh
    28      0       t/t2060-switch.sh
    33      0       t/t3200-branch.sh
    17      0       t/t7201-co.sh

The expected output should be:

    $ git show --oneline --numstat ecc7c8841d 961b130d20 d3115660b4 --
Documentation
    ecc7c8841d repo_read_index: add config to expect files outside
sparse patterns
    2       0       Documentation/config.txt
    27      0       Documentation/config/sparse.txt
    961b130d20 branch: add --recurse-submodules option for branch creation
    3       0       Documentation/config/advice.txt
    26      11      Documentation/config/submodule.txt
    18      1       Documentation/git-branch.txt
    d3115660b4 branch: add flags and config to inherit tracking
    2       1       Documentation/config/branch.txt
    17      7       Documentation/git-branch.txt
    1       1       Documentation/git-checkout.txt
    1       1       Documentation/git-switch.txt

Bonus: Surprisingly, the `<path>` *is* respected for commits that
don't have any files satisfying the `<path>`. For example, the
following command correctly excludes commit `f36d4f8316` from the
output because it doesn't contain any files under `Documentation/`:

    $ git show --oneline --numstat ecc7c8841d f36d4f8316 961b130d20
d3115660b4 -- Documentation
    ecc7c8841d repo_read_index: add config to expect files outside
sparse patterns
    2       0       Documentation/config.txt
    27      0       Documentation/config/sparse.txt
    961b130d20 branch: add --recurse-submodules option for branch creation
    3       0       Documentation/config/advice.txt
    26      11      Documentation/config/submodule.txt
    18      1       Documentation/git-branch.txt
    1       0       advice.c
    1       0       advice.h
    141     0       branch.c
    29      0       branch.h
    38      6       builtin/branch.c
    38      0       builtin/submodule--helper.c
    61      0       submodule-config.c
    34      0       submodule-config.h
    9       2       submodule.c
    3       0       submodule.h
    292     0       t/t3207-branch-submodule.sh
    d3115660b4 branch: add flags and config to inherit tracking
    2       1       Documentation/config/branch.txt
    17      7       Documentation/git-branch.txt
    1       1       Documentation/git-checkout.txt
    1       1       Documentation/git-switch.txt
    42      7       branch.c
    2       1       branch.h
    4       2       builtin/branch.c
    4       2       builtin/checkout.c
    3       0       config.c
    16      0       parse-options-cb.c
    2       0       parse-options.h
    10      1       t/t2017-checkout-orphan.sh
    23      0       t/t2027-checkout-track.sh
    28      0       t/t2060-switch.sh
    33      0       t/t3200-branch.sh
    17      0       t/t7201-co.sh

Cheers,

Dan Li

--

Daniel Li
dan@danielyli.com
