Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4717BC77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 23:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDNXwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjDNXwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 19:52:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D2A13A
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 16:52:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8b1b51dbdso1048711fa.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681516247; x=1684108247;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckqLZZ3UvZTZQRJpuF7l0JPiZyTnoxkde+3QdJqLx8k=;
        b=XYJ35OpHIILBMOnoLF+0dEjtMR74otz/b7SwFGODA1aJxvbrshdyDUQ23x5dO+WQXJ
         p5lqkiCj2IzPPk87P//OA37/yqghHYoR/ihtATJ4/nP6vUf+wjFMFBtWihtG+b6YSx5A
         qKXzZg7Wf81P9UM5m33gRYulzQM/W9k/Ds8frBBCoFL6Z4Q3XQoXZw6wCpgKzgqt2RVH
         ajdpv8uNM9DQlcQo1hAmnCgI0hZXfK03/vNCI5M5kdhOWYbFipiC/TJ7clkSAtoGPwMQ
         mbR2QpYkttknQKIJ8QWPZoZtB0812d1jCRZ6o2a4a7QKX7EqV6Wa2Zdlpxb1IWj4hi0P
         ahFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681516247; x=1684108247;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckqLZZ3UvZTZQRJpuF7l0JPiZyTnoxkde+3QdJqLx8k=;
        b=bIILyRsYLzKuG4g5qM2KcdAwXEd0v3PQ1SqtozCUC3H4OPGoLw496m/0bl2uswZq8c
         AjzK+3q1fmfldo4hYDPo8YxDZDHBDzc9R7RroXdaDLA07GaIWHeGE35JS2i9ZKTKyCv8
         6kaja3tMof9ZkPnGNw5pfrFz9oerfE6xci/OvwPxUmPTMGvZop65GfL46JsTg2oBuoe8
         dy9uoQo1N51VC0nfpTK9sOvBcG4Hr8UfE0hfR7rvYYvrSe9w+0CYAt2Cyc/jgfHgB4T/
         yUzKeawysa9UJ636NW5NtySNp5oxRaczi1ml/sRz+bPi7pvt2UnGFfUC6XdaNWfel82F
         wD4A==
X-Gm-Message-State: AAQBX9d0/+guirNRXY83FcAoZvH7D+8mxy1ma3A9VS1u4+KdmWlhqGEg
        Gz9PDzpSPvIy03xBWaFo7UHe+XmG3lac25Gfhp0l6+gaXMI=
X-Google-Smtp-Source: AKy350Z6tHr3n+baKifkFv7zBbZLn1figDPZZsAJLy4sQGfFQV9R72Fn+VLW1Q8wJJZqjGzvRtw2Ptj3QdAZnBZz5MU=
X-Received: by 2002:ac2:518a:0:b0:4db:1999:67a3 with SMTP id
 u10-20020ac2518a000000b004db199967a3mr158039lfi.13.1681516247309; Fri, 14 Apr
 2023 16:50:47 -0700 (PDT)
MIME-Version: 1.0
From:   Nikita Kniazev <nok.raven@gmail.com>
Date:   Sat, 15 Apr 2023 02:50:35 +0300
Message-ID: <CAPFiOxax-=PRUBCSOPH=9=UpERQLEJw+pO1Pg+JndM63JyGDAw@mail.gmail.com>
Subject: `submodule update --remote` fetches default branch instead of `submodule.*.branch`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When I do

  git clone -j10 --depth=1 --branch=develop --no-tags --single-branch
--recurse-submodules --shallow-submodules --remote-submodules
https://github.com/boostorg/boost.git .

Or

  git clone --depth=1 --shallow-submodules --branch=develop
https://github.com/boostorg/boost.git .
  git submodule update --init --remote --checkout --recommend-shallow
--recursive --single-branch --jobs 10 --depth 1

I get the error:

  fatal: Unable to find current origin/develop revision in submodule
path 'libs/callable_traits'

In the trace I see that git clone is called without the
`--branch=develop` even though `git branch` reports `develop` and
`.gitmodules` sets 'branch = .' on every submodule.

  trace: built-in: git submodule--helper clone --require-init --path
libs/callable_traits --name callable_traits --url
https://github.com/boostorg/callable_traits.git --depth=1
--single-branch
  trace: built-in: git clone --no-checkout --depth 1
--separate-git-dir /home/nick/boost-repo/.git/modules/callable_traits
--single-branch -- https://github.com/boostorg/callable_traits.git
/home/nick/boost-repo/libs/callable_traits

I tried different versions:

  git version 2.34.1
  git version 2.39.2.windows.1
  git version 2.40.0.windows.1
