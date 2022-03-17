Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FAC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 14:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiCQO44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCQO44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 10:56:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE01DBABC
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 07:55:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h23so7116555wrb.8
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDB4AnXjHcWFqhbsl//haqNWHtUFcjyj+S1fUFUvj7U=;
        b=cx4G6Vel4W2rQiMN5F/tVFfgNcbxrfE/admZeSnFEoB095buNDMEzcm4eAxq6XkG5M
         +lVCx3u+hst0c8K8WlnXpsvjVaPK+1SSLUz7MM72cVOk2cuXsYZcT68/EGytsMZWM8Yp
         Ce1UA8AEctfMdcJ/EX/D7DDh+RxqKSqt/MN5r25rLu4xBqr1M23xHS5f9+AsqHRRBECY
         wQ+/oOc1zHdHrs4n9iQuKbewkxL2n90SyztC348x1FDwAlwP9MuZmcDJfek6hFj2zH1B
         jyjWUrCtHVW1+SnbH3JoaozmujY6If6qlAzvIvINDxn6CbXuAAsXbJilhmn3zZ+nnlRH
         pHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDB4AnXjHcWFqhbsl//haqNWHtUFcjyj+S1fUFUvj7U=;
        b=QBOllKDwHrJx42GDU/KlRMa77nG0LOJqBrFVU66hsRnpT1vCJMgQuMQdwER11tvXaT
         BAjiPCbzyVkmaqW/0lteqjchptmsxLdnSLUZGnD2Uk3UaiuaCJrnzv9Cdc2oeWHetp0w
         j/vHX49auvMFOuKPS/e/yqhsGR1jpbTMmYyim/E+29E6xo9cEeP/32tQ9g2K4JE871Oj
         3+l1jeI1HUt0UN9cEGbw/FYtKBqJw3ZxMv5yhQfdpp1mOHo9heeT+wH84Yvq/Szz3aTO
         OVOi9nc1y04AtvuVLykjv1P4D+d16m8W4R45ZDriBKi16+ArsKNBt/mu5fvyg/HmsM8T
         EPqQ==
X-Gm-Message-State: AOAM531OqGiX/y2rXnGiDvRQm5WzoWxH4MjhRiZOFCpbAVm1Dcx87sE3
        YrrslnuUpvt76CaWCAjkZId3CWWfkQ1oJA==
X-Google-Smtp-Source: ABdhPJxjvSTnYs47jQHD4E0xITuB8HEmTwIz2bnivjoHFrizmD2FmbFJ7Cv+mAP45epiePO1O6VQjQ==
X-Received: by 2002:a05:6000:156a:b0:1f1:f168:69ac with SMTP id 10-20020a056000156a00b001f1f16869acmr4595662wrz.184.1647528937185;
        Thu, 17 Mar 2022 07:55:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b001f0620ecb3csm4340071wrt.40.2022.03.17.07.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 07:55:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] diff.c: fix a recent memory leak regression
Date:   Thu, 17 Mar 2022 15:55:33 +0100
Message-Id: <cover-v2-0.2-00000000000-20220317T144838Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <a5e5cdd4658d457ffbd80f7263e352cbf3141a1a.1647520853.git.git@grubix.eu>
References: <a5e5cdd4658d457ffbd80f7263e352cbf3141a1a.1647520853.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a really dumb think-o in a commit of mine in the recently
landed ccafbbfb4ee (Merge branch 'ab/plug-random-leaks', 2022-03-13),
sorry about that, and thanks a lot to Michael J Gruber for the report.

This "v2" series is re-roll of his addition of a regression test in
the "v1"[1].

As the range-diff shows I took the libertay of adjusting the commit
message a bit, mainly noting the regression, re-wording a bit, and
replacing the (presumably glibc?) output with the better
SANITIZE=address report.

The 2/2 then fixes the issue, and changes the relevant regression
tests to run under SANITIZE=leak (i.e. the "linux-leaks" job).

1. https://lore.kernel.org/git/a5e5cdd4658d457ffbd80f7263e352cbf3141a1a.1647520853.git.git@grubix.eu/

Michael J Gruber (1):
  tests: demonstrate "show --word-diff --color-moved" regression

Ævar Arnfjörð Bjarmason (1):
  diff.c: fix a double-free regression in a18d66cefb

 diff.c                     | 11 +++++++++--
 t/t4015-diff-whitespace.sh | 12 ++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

Range-diff against v1:
1:  f6e7318b418 ! 1:  7f6a6450259 tests: test show --word-diff --color-moved
    @@ Metadata
     Author: Michael J Gruber <git@grubix.eu>
     
      ## Commit message ##
    -    tests: test show --word-diff --color-moved
    +    tests: demonstrate "show --word-diff --color-moved" regression
     
    -    a18d66cefb ("diff.c: free "buf" in diff_words_flush()", 2022-03-04)
    -    introduced a breakage to `show --word-diff --color-moved` which gives
    +    Add a failing test which demonstrates a regression in
    +    a18d66cefb ("diff.c: free "buf" in diff_words_flush()", 2022-03-04),
    +    the regression is discussed in detail in the subsequent commit. With
    +    it running `git show --word-diff --color-moved` with SANITIZE=address
    +    would emit:
     
    -    free(): double free detected in tcache 2
    -    Aborted (core dumped)
    +            ==31191==ERROR: AddressSanitizer: attempting double-free on 0x617000021100 in thread T0:
    +                #0 0x49f0a2 in free (git+0x49f0a2)
    +                #1 0x9b0e4d in diff_words_flush diff.c:2153:3
    +                #2 0x9aed5d in fn_out_consume diff.c:2354:3
    +                #3 0xe092ab in consume_one xdiff-interface.c:43:9
    +                #4 0xe072eb in xdiff_outf xdiff-interface.c:76:10
    +                #5 0xec7014 in xdl_emit_diffrec xdiff/xutils.c:53:6
    +                [...]
     
    -    on every incarnation. This was not caught by the test suite because we
    -    test `diff --word-diff --color-moved` only so far.
    +            0x617000021100 is located 0 bytes inside of 768-byte region [0x617000021100,0x617000021400)
    +            freed by thread T0 here:
    +                #0 0x49f0a2 in free (git+0x49f0a2)
    +                [...(same stacktrace)...]
     
    -    Therefore, add a test for `show`, too.
    +            previously allocated by thread T0 here:
    +                #0 0x49f603 in __interceptor_realloc (git+0x49f603)
    +                #1 0xde4da4 in xrealloc wrapper.c:126:8
    +                #2 0x995dc5 in append_emitted_diff_symbol diff.c:794:2
    +                #3 0x96c44a in emit_diff_symbol diff.c:1527:3
    +                [...]
    +
    +    This was not caught by the test suite because we test `diff
    +    --word-diff --color-moved` only so far.
     
    -    Reverting a18d66cefb makes the test pass, but there might be a better
    -    fix.
    +    Therefore, add a test for `show`, too.
     
         Signed-off-by: Michael J Gruber <git@grubix.eu>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t4015-diff-whitespace.sh ##
     @@ t/t4015-diff-whitespace.sh: test_expect_success 'cmd option assumes configured colored-moved' '
-:  ----------- > 2:  cae11491599 diff.c: fix a double-free regression in a18d66cefb
-- 
2.35.1.1384.g7d2906948a1

