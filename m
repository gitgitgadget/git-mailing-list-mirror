Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC378CCA48A
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 02:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbiFHCP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444378AbiFHCK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 22:10:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D036EB10
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 17:11:18 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x11-20020aa79acb000000b0051b9d3136fdso10066701pfp.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 17:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=prbJNbdzAFTwLvHA+5H17C5ZaCmX60WN0ZEb8jJXonM=;
        b=WZmphs22Xwpm20iduKMWSgMMPspF24AlchTK8P2BcQt6NFHvgy7kLMMZLcFuSCfYQU
         HJr5lGkrjtPDTt+8STfpnxbLS6iafA+IrDDRkl1Kr4OB38lG56MtRzX5iyA5bVUa2t4x
         n3es0/jErDnNFlrD1Yy80XwosNUXPJrA4v1d+273RmfiuqnGN27ml+ilBr/9det0ZL4u
         QPuuDtnlqbRBxI06TcRftC+OiDOa0nrvvw1gA+Tl9BHFZZiZ8SXwji9ZyqSahVQguhVC
         XpoezggAgCARWH393j0X7QfvCO0F4D4oHM51cyV8WLctBf8RIu6MPp1jb1h08H51ZKA2
         WyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=prbJNbdzAFTwLvHA+5H17C5ZaCmX60WN0ZEb8jJXonM=;
        b=5CBbwj97rxYq1ELn00QXFEmhFI+dKXYQyBT1znWZ/HurSoYBgQ8aFT+cmwoU7OmU28
         teY+90lEbx1x/cWvRKRxMSMys9bzUftygStEW+eq1Dvr54zRNFbzyza0pe9B11eqXsME
         +vOnSgw7kBMVt8TLMZwHTcPtUjncrRerUos1uSjvpqJ0jXdJvU2zuJEYdhCnqyPLUEgf
         SZwOY7jZragosVkXMOPL+ndA5eNR2l18Yx76MtFXWZ4RtFzjDP5MaHDjL748VHFjNT7w
         KKofhvV5M0hLkRD734wPSv0XcYLxPIVeWctEEP+9k6wcjeAcyjSstb58vnV+XnMrL/98
         dn8Q==
X-Gm-Message-State: AOAM531wFgrp4YzYv4giTlctxudXvBpwncT7uc0jyqP4Fx9snHxgjNo6
        uItFALFdq+knkl8zDLn7l/cPBU5n+Ijf30ZSdQH8cmxy5AcnrsPEAw3rrjCEYrRnWPMyOGZTuSy
        +j/nUSc8+sW2px5SjPrtZjorfvyJY0XugtfxLpSsa56/j42WbHe+gxfOTPg9cKRo=
X-Google-Smtp-Source: ABdhPJz3sjrAlje7jd7mvWAC+jlOrqMwSRTQVc4t/LK13JGd9WVHcoJT4vZpXD1LS4p4eqvxgjgtFNEyfOoCOw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2349:b0:51c:29c0:82f6 with SMTP
 id j9-20020a056a00234900b0051c29c082f6mr9805644pfj.32.1654647077803; Tue, 07
 Jun 2022 17:11:17 -0700 (PDT)
Date:   Tue, 07 Jun 2022 17:11:09 -0700
Message-Id: <kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: Bug in merge-ort (rename detection can have collisions?)
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


(I'm not 100% what the bug _is_, only that there is one.)

= Report

At $DAYJOB, there was a report that "git merge" was failing on certain
branches. Fortunately, the repo is publicly accessible, so I can share
the full reproduction recipe:

  git clone https://android.googlesource.com/platform/external/tensorflow tensorflow &&
  cd tensorflow &&
  git merge origin/upstream-master # HEAD is at origin/master

This gives:

  Performing inexact rename detection: 100% (4371280/4371280), done.
  Performing inexact rename detection: 100% (12529218/12529218), done.
  Assertion failed: (ci->filemask == 2 || ci->filemask == 4), function apply_directory_rename_modifications, file merge-ort.c, line 2410. 

This bug seems specific to merge-ort; "git merge -s recursive
origin/upstream-master" seems to work as expected.

In case the branches have changed since then, here are the commit ids:

  $ git rev-parse origin/master
  68e55281824e8a79fa67e1a3061f39bd4c4b2e57
  $ git rev-parse origin/upstream-master
  0be5bb09aeeff3a6825842326fadc8159a5553ab
  $ git merge-base 68e55281824e8a79fa67e1a3061f39bd4c4b2e57 0be5bb09aeeff3a6825842326fadc8159a5553ab
  8e819019081f39d83df42baba4acfced3abf3f90

= Interesting info

I don't understand the merge-ort code enough to understand what's going
on, but I was able to find some (hopefully helpful) details. I added
this log line just above the offending assert() call:

	trace2_printf("0 %s, 1 %s, 2 %s, fm %d, dm %d", ci->pathnames[0],
    ci->pathnames[1], ci->pathnames[2], ci->filemask, ci->dirmask);

Here are the lines I thought were suspicious:

  0 <path1>, 1 <path1>, 2 <path1>, fm 2, dm 0
  [...]
  0 <path2>, 1 <path1>, 2 <path2>, fm 6, dm 0 # this is the last line

Notice that the last line detected a rename from <path2> to <path1>, but
we already saw <path1> earlier.

IIUC "(ci->filemask == 2 || ci->filemask == 4)" can be read as "the path
either exists on only the left side or only the right side of the
merge", so ci->filemask == 6 should mean "the path exists on both sides
of the merge"?

"-s recursive" seems to handle the rename just fine (it picks <path2>
IIRC).

I also dug into each commit to see which paths were present:

  head="origin/master"
  other="origin/upstream-master"
  merge_base="$(git merge-base origin/master origin/upstream-master)"
  path1="tensorflow/lite/g3doc/convert/metadata_writer_tutorial.ipynb"
  path2="tensorflow/lite/g3doc/models/convert/metadata_writer_tutorial.ipynb"

  git rev-parse "$head:$path1" # (exists)
  git rev-parse "$head:$path2" # (doesn't exist)

  git rev-parse "$other:$path1" # (doesn't exist)
  git rev-parse "$other:$path2" # (exists)

  git rev-parse "$merge_base:$path1" # (doesn't exist)
  git rev-parse "$merge_base:$path2" # (doesn't exist)

i.e. both files are new and are renames of each other. I haven't tried
using this property to create a minimally-reproducing recipe though.
