Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74BFC4332F
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 12:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiBGMDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358790AbiBGLOo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 06:14:44 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDDEC0401DD
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 03:14:24 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id b37so22078322uad.12
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 03:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NTQ7XpbnbdODMC8eqeCRRMMZRTbSGsDzAHkJPEAfmjg=;
        b=oE8NEJ5M+KPdkhBZxynbEgHaVzmpkqdVWnPowcfh9LQDiVxlgtA7jK1s/TJE1eR1fh
         FUragkvlo4F49BrDrfC9q2XxmCFPX8Q3UwUFH2YwoFqSCu0ceyzULRKpdrPtoPa/CT8j
         BD9miS/TolF7GCUNGm1HxubddFlYGaBZynfknZMVZjZHkoq3Msz4RuIu0lzAh/+d3oCf
         UXtEAOBQdefW7z5E6N5kCkcw7GNjdtRFnYBSj5dC76TRz62bpZW5ioy1IqKSav+/Iz3k
         9g/IR0Vos+9vAIIowI/3tfijy6K9WgXGVpdOI1BQ9tvNj8nCJNv90rauKhZV6cMOM3dR
         XpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NTQ7XpbnbdODMC8eqeCRRMMZRTbSGsDzAHkJPEAfmjg=;
        b=zwH1eknlhHIBwlSWv101+9tT0rSg9s6PMXb/yemNOeN6Nkr79AuEdgVHONdjMvLJJ4
         rPF0P9oh5V3DCVZi6y8oRA/r17QEYdAHv5AFyr0s+7MyLKmpHdF7zNmEbiPES4pmdFYt
         fVyVj3pSu71BSiqLlv4PEK+WDkD+6TmhnSqmVz5CgTvJQyvtA3nIbM89e5iOd1UPyFX2
         d+UAuBwtlhFlao6i3FQrpQtX3hJ3zksFrX/Yia09K8us/KQ6bqe0M9EQM1PROr4IGSsx
         GnRpFp6TU3pLnbxM3n95W5hjyPLpYiizS3zvI97/XqFJn4N5/wZtW7/t5z6iujZ5f1dp
         /j+A==
X-Gm-Message-State: AOAM533xUE9RBTRQqKu9hMu4EBqx86lGZeWkJsLqtxPSGD88Kt+GN12o
        8bjucleLfxr/YSGUJEk15BFB7uc6fLzvcoowxC20YDWpYwQ=
X-Google-Smtp-Source: ABdhPJybV32/U+2u7dJawVFjfAWNOvd2nrfmANFY+GehwOHmdqWOQxGID8nQctJE0kNxPQZCJEhSKW1WoANzhBmu7mw=
X-Received: by 2002:ab0:604e:: with SMTP id o14mr3133867ual.71.1644232450044;
 Mon, 07 Feb 2022 03:14:10 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Kanavin <alex.kanavin@gmail.com>
Date:   Mon, 7 Feb 2022 12:13:59 +0100
Message-ID: <CANNYZj8L_-hhKGNvNfiSU4T2W0g8ZRJ-gJJ30PgRo=ycCGSObQ@mail.gmail.com>
Subject: [bug] forcing build settings on rhel7 without specific checks is not appropriate
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

there was a recent change where a couple of compiler settings are
forced on rhel7:

# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
ifneq ($(findstring .el7.,$(uname_R)),)
    BASIC_CFLAGS += -std=c99
    NO_UNCOMPRESS2 = YesPlease
endif

I believe this is not the right way to do it: the makefile should
check for the actual compiler and zstd versions and make the decision
based on that. Yocto project uses a much newer (cross)compiler and
zlib for cross-builds, and those settings are not only unnecessary,
but actively harm reproducibility, as cross-binaries built on
rhel7/centos7 are then not the same as binaries built on other
distributions. So we ended up reverting the change:
https://lists.openembedded.org/g/openembedded-core/message/161456

Thanks,
Alex
