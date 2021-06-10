Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6542CC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514CD613E9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhFJQvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:51:31 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34798 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhFJQvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:51:31 -0400
Received: by mail-wm1-f42.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5079212wmc.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ldt0LejCxBMhp+w3qu5ifMpC0zXe5HoZ+e4xuYMW4cE=;
        b=De6vYkJH2EVmu2aESu3RZsJ4yCEqJYqLx5xDdIfmhF4dxayYj87iK1vBTfcDRqO1eZ
         3rnUJKRlPxOScaSe+SEXlKprUrZtSYCZcEfkUrrHW/hUyi23AkanNx+c8NMCbETiuomu
         4j870Sr9ptFmuQdzmobPY2zi5Bfopp4Y1thi1idQ37OEASizEVx1Q9Mq+6wkgemwpLRE
         Bkzgt8cd45JaLcMC1ZilU/OHZ+4XHGCKzykZta/xnX+UZGvlIu5j7qs35jFyqScZeVym
         i/toXTENx7Nt5/kLynDQFtF8Yu9/2fozV9tszd4R8+6KEYMCjadyZ915cDSnX8vfd+H5
         iRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ldt0LejCxBMhp+w3qu5ifMpC0zXe5HoZ+e4xuYMW4cE=;
        b=ZKPj0/HwOu6jDgTUtpkHP5OLjstV7LERIIganu2wbFsyXz/0e+Mum+qHFaHhrjEIRC
         vNXGYK8PFpWJ/BtLRebJcjKjftcTWmUZM8aOf7GBNCBbOo9liGIsptBBxYmiW/WaAaFd
         p4xaaVqpZDtosjQKG+C1eqR29ZS51lieV5day20ciWM5G6ms3bNfHBmOdCLBiSY6xHUF
         p7dB8Elf4HHWsDSVxe35RKglXQnCYiyDlNXACYR3aEQQCkyObtygbkj4ctcG4zaVNTTc
         SNCvuT7fTSrfVN/KFa3c+Bj3yvqH+ClSOrkx4s+eBqBpA6mNEPsiijOiMoXWzCH0X5BZ
         3cJw==
X-Gm-Message-State: AOAM533KTGxS59Nakl2Cpa7nK8TrDlNlf85RshUL32jrlVtvHvwajupZ
        EEFwrZ/Ekfe2O7JSNp0CfRhjLbb7xb4=
X-Google-Smtp-Source: ABdhPJzqO92mW8YBEtO7FRvAX9Zbhu/oI8JMRS6+gU31Gkb3jou08j98paVS7dwv5vNc3e5n2qroFQ==
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr16309336wmk.64.1623343714216;
        Thu, 10 Jun 2021 09:48:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x125sm3931784wmg.37.2021.06.10.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:48:33 -0700 (PDT)
Message-Id: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 16:48:29 +0000
Subject: [PATCH 0/3] Fix uninitialised reads found with MSAN
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a small number of issues found when running git's
test-suite with MSAN (MemorySanitizer: a clang sanitizer that tries to
detect reads from uninitialised memory [2]). To summarise: I think there's
one real bug, one theoretical bug where compiler nevertheless produce
working code, and one false-positive that we can easily suppress.

Getting the test suite to run under MSAN is a bit trickier than simply
adding SANITIZERS=memory, I've detailed the reasons and the process I'm
using below. Unfortunately this series is also not sufficient to make the
whole test suite pass when building with MSAN:

 * t0005-sigchain and t7006-pager fail with an infinite loop inside MSAN's
   signal handling interceptors. I think this is a bad interaction between
   git's signal handling and MSAN's interceptors, and I suspect it's not
   indicative of a bug in git itself - but I haven't investigated in detail
   yet.
 * t3206-range-diff, t4013-diff-various, t4018-diff-funcname all fail due to
   a change in diff output. I can reproduce this issue when running with
   TSAN (but not ASAN or UBSAN), which suggests a bug or difference in
   behaviour in code shared between MSAN and TSAN - similarly, I haven't
   investigated in all that much detail yet.

(These issues were seen when running with clang-11 - the next step is to
test with clang built from main)

As to the tricky part: MSAN tries to detect reads from uninitialised memory
at runtime. However you need to ensure that all code performing
initialisation is built with the right instrumentation (i.e.
-fsanitize=memory). So you'll immediately run into issues if you link
against libraries provided by your system (with the exception of libc, as
MSAN provides some default interceptors for most of libc). In theory you
should rebuild all dependencies with -fsanitize=memory, although I
discovered that it's sufficient to recompile only zlib + link git against
that copy of zlib (which not a very tricky thing to do). Doing this will
uncover one intentional read from uninitialised memory inside zlib itself.
This can be worked around with an annotation in zlib (which I'm trying to
submit upstream at [1]) - but it's also possible to define an override list
at compile time - I've detailed this in my recipe below).

My recipe for running git tests against MSAN:

 1. Grab zlib sources from zlib.net or github.com/madler/zlib , I used zlib
    1.2.11 (which is also what most systems seem to ship).

 2. Create a sanitizers special cast list (named e.g. ignorelist.txt)
    containing "fun:slide_hash" (this is only needed as long as zlib doesn't
    contain [1]).

 3. Build zlib, installing it into SOME_PREFIX (I happened to use clang, but
    that might not be necessary): CC=clang-11 CFLAGS="-fsanitize=memory
    -fno-sanitize-recover=memory
    -fsanitize-ignorelist=YOUR_IGNORELIST_FROM_STEP_2" ./configure && make
    install prefix=$SOME_PREFIX

 4. Build git and run the tests (again, I'm using clang, but gcc might be OK
    too): make ZLIB_PATH=$SOME_PREFIX CC=clang-11 SANITIZERS=memory test

If you're actively trying to understand and fix issues, I also recommend
adding -fsanitize-memory-track-origins (which points you directly to where
the uninitialised memory comes from), see also further docs at [2].

ATB,

Andrzej

[1] https://github.com/madler/zlib/pull/561

[2] https://clang.llvm.org/docs/MemorySanitizer.html

Andrzej Hunt (3):
  bulk-checkin: make buffer reuse more obvious and safer
  split-index: use oideq instead of memcmp to compare object_id's
  builtin/checkout--worker: memset struct to avoid MSAN complaints

 builtin/checkout--worker.c | 11 +++++++++++
 bulk-checkin.c             |  3 +--
 split-index.c              |  3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)


base-commit: 62a8d224e6203d9d3d2d1d63a01cf5647ec312c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1033%2Fahunt%2Fmsan-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1033/ahunt/msan-v1
Pull-Request: https://github.com/git/git/pull/1033
-- 
gitgitgadget
