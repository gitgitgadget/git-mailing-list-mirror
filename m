Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32214C433F5
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 06:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiFAG4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiFAG4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 02:56:01 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264EF4BFE7
        for <git@vger.kernel.org>; Tue, 31 May 2022 23:55:58 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s1so674749ilj.0
        for <git@vger.kernel.org>; Tue, 31 May 2022 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=PKKtaegpJz/CT4IxLhNdyAQXEZrrCQmUTKh+vwp7Fpc=;
        b=Foyy4oRQiZ2CkLtbTnyFPDUSpaHkqO9KyLsTeU62iso3lXL1ZWWjhXjFwRlF9441EF
         Mm4MdtBbNMpX2siYPfSaF7v9GgGMNBrtavj6X55R1lyKiOibeFSo/mrAS6lxk4dUyIpz
         k0nFdxi7vIZjrfCPeqL2kUHYLrZgBFayqxqGpr6sv6QGB/2Og6P9nl9aYU1IHAhd4Q0n
         zT00Tl5/hMJV0TByTzizlJdm0vsPdyV7aFerzeZ7lbROJLVnBt5zeGEH2Y9LkzMAqIIk
         YOm/y1dpDTQnFfgL6OLMnfLxokhj6d7DV9UBDA216kU95QV6mVa1sW/bJiATQeua8a5o
         n4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PKKtaegpJz/CT4IxLhNdyAQXEZrrCQmUTKh+vwp7Fpc=;
        b=sRZayF3ARtZJdzYkxXtZHwLlwwPNd5LOBo/+im4kyPt+cklXDjI+D3JwfQPJDIa1uY
         kVYEQO9iBJ8XVARThCD3QUuUk0nErWkdXoWjq3zpeIYZVLiPcuwhdgHhHaBwYxC1hyMi
         2a7Ak33TaSNp22gowBR5S/kXk4xidZf6WEa+gmCJ62VrZRsls5OSrrEEhlnCPPrGMzq0
         90GK9ktkuwJ1bzJ9r/naAvkIGuf+4ZO8khjKuqmQ350eeUNvFdel4k2TBYj2c2Wuf+pP
         e5FS+tBaZJodT0QwiB6EnGCZA0IKOzil6VXYH09vNLCL4DH+yYsgku7sthLypyrL1ioV
         FXMw==
X-Gm-Message-State: AOAM533VuOvoNz2PSPSS2cbSp4xzvOgb3Q19nEHR3+uWofCRwuccIR8a
        VvK9yiJJw4UuhG6YjIWQ0+YewRRTd2JZCTqj87aY/Cp5G0w=
X-Google-Smtp-Source: ABdhPJxQJUWjklviDFIl2lVUi1WnVGDT/KZWRddg4tlOTHyD+8jaQAfyeIsVeQ2G2stJaC9+cSztudm9AVXNc2L/XLI=
X-Received: by 2002:a05:6e02:188f:b0:2d3:c38f:7e9b with SMTP id
 o15-20020a056e02188f00b002d3c38f7e9bmr3446460ilu.151.1654066557482; Tue, 31
 May 2022 23:55:57 -0700 (PDT)
MIME-Version: 1.0
From:   Akos Vandra-Meyer <axos88@gmail.com>
Date:   Wed, 1 Jun 2022 08:55:46 +0200
Message-ID: <CAHHcNoe12h5E9OmkZy03-i7miFg2hLiT04BF3_t9C2bcmduR5Q@mail.gmail.com>
Subject: BUG? git stash and immediate git apply results in conflict
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I believe there might be a bug in how a git stash is calculated with
the -k flag.
I would expect to always be able to stash and pop a set of changes,
but if the working directory contains staged and unstaged changes for
a file, this results in a conflict.

The stashed diff shows the changes from the last commit, rather than
what is in the current working directory, so when the stash is applied
it results in a conflict, because there are staged changes in the
current working directory.

Steps to reproduce:

 mkdir test
 cd test
 git init .
 echo foo > a
 echo bar >> a
 echo baz >> a
 git add a
 git commit -m "initial"
 cat a | sed s/bar/foo2/ > a2; mv a2 a git status
 git add a
 cat a | sed s/foo2/xxx/ > a2; mv a2 a
 git status
 git stash -ku
 git stash pop

Thanks for looking into this,
  Akos Vandra-Meyer
