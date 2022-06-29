Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9117DC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 19:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiF2TLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiF2TLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 15:11:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989FB2FFE8
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 12:11:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by38so20122692ljb.10
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=DsVPGIsEyT5cOarn9Kh2A+RSaoBSJBowppHgJYf6+Q8=;
        b=d+EQR4PfsvKFqqRebmDn3seBXIEKMs6eRS3onQzXvYte/q9XW2Rdu+bA81FXjobHG1
         JqQHSS0Sdw61NmOR8+OREVsbozDjqKWJrmGapi/L5hCPNIRgCD2z6TLmclixlGvb0uDO
         Tei808cOl9SPyNK7oeUUAm+FHApw+m+HawSmVhxMOjziVKcLfbm1TBvjs+Pn+gqohNDt
         YuxQDlwyCuf+z6IzpN18n43cFQcE2BLuz9v61ERrHzzZkmsbFx9GYBymyRPBihm37aa+
         cVXiYB3zxZLIfnWdgPkAabLlbpMssX6qAq63V4XrB4JtUgMjsuIPvdaOdAG/RiC9kQjl
         pJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DsVPGIsEyT5cOarn9Kh2A+RSaoBSJBowppHgJYf6+Q8=;
        b=rN+4TVXyYAsVAw5Ny1x2UHrFXxahBlvNj6gdelOQ/kwHSnGgmybU1gcT/d4OK7MIrX
         ybjJTjh5hpIVJ/5GUzztkaI0yE3p3eEZIstnLNvkmhEr3b4PeEjsDUAyOGj7kM4WqUoX
         3316Ecs1pZ88ierJl26Evjab++nciQuxSBKj8Rro8xsQy5r9VEcS0n/Y+WCZI/sDm7Lr
         Nb75EWmW3MVRYKhCYCQs4HfKK7EnuL6Q5KiK3hLtm60zVGQQtGicQ7fOwQ07nZ5nLYLa
         c2ibhs3DcCGRqbnE3FzH0T1li4Xh0rGZF2NPVHBq7KgfzyWdDZloxAirF+2Zxm1FUqL4
         fiHw==
X-Gm-Message-State: AJIora96FikQJoYrdPH5AHB/4CHYAQmcX8ll1rnGxFHIrYnsVUUxI9x5
        RuC3ZdMJ1/iZEg+yESsE8wBzpDoCkncNnwJjLdKq5CB6n7Y=
X-Google-Smtp-Source: AGRyM1uRJi/3kU3TI86pU2bDiV8d6Jeen+a2016zXzlwqFpsAHaABdxXc8t1wKWaFc+pL65jlDi5fFO10pKYNvWGEnM=
X-Received: by 2002:a2e:551:0:b0:25a:6d36:2706 with SMTP id
 78-20020a2e0551000000b0025a6d362706mr2679764ljf.499.1656529902444; Wed, 29
 Jun 2022 12:11:42 -0700 (PDT)
MIME-Version: 1.0
From:   Dian Xu <dianxudev@gmail.com>
Date:   Wed, 29 Jun 2022 15:11:31 -0400
Message-ID: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
Subject: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git developers,

Reporting Issue:
              'git add' hangs in a large repo which has
sparse-checkout file with large number of patterns in it

Found in:
              Git 2.34.3. Issue occurs after 'audit for interaction
with sparse-index' was introduced in add.c

Reproduction steps:
              1. Clone a repo which has e.g. 2 million plus files
              2. Enable sparse checkout by: git config core.sparsecheckout true
              3. Create a .git/info/sparse-checkout file with a large
number of patterns, e.g. 16k plus lines
              4. Run 'git add', which will hang

Investigations:
              1. Stack trace:
                       add.c: cmd_add
                  -> add.c: prune_directory
                  -> pathspec.c: add_pathspec_matches_against_index
                  -> dir.c: path_in_sparse_checkout_1
              2. In Git 2.33.3, the loop at pathspec.c line 42 runs
fast, even when istate->cache_nr is at 2 million
              3. Since Git 2.34.3, the newly introduced 'audit for
interaction with sparse-index' (dir.c line 1459:
path_in_sparse_checkout_1) decides to loop through 2 million files and
match each one of them against the sparse-checkout patterns
              4. This hits the O(n^2) problem thus causes 'git add' to
hang (or ~1.5 hours to finish)

Please help us take a look at this issue and let us know if you need
more information.

Thanks,

Dian Xu
Mathworks, Inc
1 Lakeside Campus Drive, Natick, MA 01760
508-647-3583
