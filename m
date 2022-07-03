Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F382FC433EF
	for <git@archiver.kernel.org>; Sun,  3 Jul 2022 12:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiGCMMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jul 2022 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCML7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jul 2022 08:11:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44FF65AC
        for <git@vger.kernel.org>; Sun,  3 Jul 2022 05:11:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fz10so693308pjb.2
        for <git@vger.kernel.org>; Sun, 03 Jul 2022 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=YT9boOpTK1PcOTlBX7NGUK6BIw3peFYcF0YiWLtKEmY=;
        b=lgE/c7XUHCb0P1iBsjRUkcYPslu49wmpnE6bz1HhjrMtar1gy/eVjPf6i91epFG1+o
         JEXJepKiTecAl3R8evwFzAqRNaKj1/p9SLk8fWxIevVewtYxDh/xVEIER4q/j/vJ8V2l
         RYPWypIojBsTVoYRERG9PWWTBQ5vk2T4k6XsCT93vGqM8IXGJ56t7fuGNqqscAc42KO3
         ZZrHwCh5R+V2vD9ahuc9P/mRbedZDmZaKARTdPviykoMsU+chWm5vr1/Mx+xUVpwnvNA
         xGGuuuNCIHVPKW32VL2iyED1e0zMwXxD+Y+Qm9Jm4Kq+6TqYlvVJJTiCfYQAGFlNmbCd
         lwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YT9boOpTK1PcOTlBX7NGUK6BIw3peFYcF0YiWLtKEmY=;
        b=iI0TGUx81XY6UkAvfxoFzp9Y79AKT/bGcFKDs+MUn54/VdI0IZxBLSqIAMF1Qs3UPj
         M0Rwbbj13ocIeFFOPnVW3wYJpCdDLpYIGRvNRP5y/P3T59GT5tJ8NIaU0yzZIM/iS2KQ
         W/ZVw1ZVmfdBVRy7wmsqHzmeaNdcYRdld3cQ76WyM2m9T6S9aDHcWsy62GwinMDqVQHJ
         Gjpn/i9Rb+jNi18iBastHTmPreaXPZyxbQpFegoflGv0yDaSRYlrK5Cmhe2rSzq5HbQg
         LBje9Ek1hIY4T4uJoGhPQKIaYyC82sBU8yvQNBwxZ37mKrsa5rcRTYYw4ef57t9VwIC9
         bPZw==
X-Gm-Message-State: AJIora8nl0+F0vJFauip3G5m9WAWLPa7QR0WJBq2wyqGgdtKpDJOB3Md
        SsYpWJRznuTrfeKIAeOgyuvCIpBtrplhpeUclHiDNZEys7Ce
X-Google-Smtp-Source: AGRyM1uB0Ow3R5DveGqnxFYMH21NDbkeP+svD91FMpTCj2A+xnVPNEhhlIegF91SsNVXWk9vqLXP3EoZoasNiqnYBJM=
X-Received: by 2002:a17:903:1207:b0:16a:7e87:dad3 with SMTP id
 l7-20020a170903120700b0016a7e87dad3mr29890395plh.99.1656850317963; Sun, 03
 Jul 2022 05:11:57 -0700 (PDT)
MIME-Version: 1.0
From:   Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date:   Sun, 3 Jul 2022 15:11:46 +0300
Message-ID: <CAMhVC3Z92hBsK0FbE4E_LV1CSxjR1zmu+MO8=iwR02BKqnwgUA@mail.gmail.com>
Subject: Why `git am -3` apply patches that don't normally apply?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

From what I can see w/o `-3` `git am` follows the `patch`'es behavior.
And the `patch`'es behavior is if there are lines in a patch that
doesn't match the lines in the source file, it fails. For example, a
source file:

11
2
3

A patch:

 1
 2
-3
+33

But `git am -3` will apply such a patch. That is, `patch` sees that
the first line changed and that prevents it from applying the patch,
but `git am -3` decides that it's okay. Why is that?

A script that reproduces the issue:

    set -eux

    mkdir a
    (cd a
    git init
    echo '1
    2
    3' > a
    git add a
    git commit -m 1,2,3
    sed -Ei 's/3/33/' a
    git add a
    git commit -m '3 -> 33'
    git format-patch -1 HEAD)

    mkdir b
    (cd b
    git init
    echo '11
    2
    3' > a
    git add a
    git commit -m 11,2,3

    git remote add a ../a
    git fetch a

    cat a
    cat ../a/0001-3-33.patch
    git --no-pager log --oneline --graph --all
    git am "$@" ../a/0001-3-33.patch  # try it w/ and w/o -3
    git --no-pager log --oneline --graph --all)

A couple of links, just in case, which have more information and show
where it comes from:

https://stackoverflow.com/a/25847019/52499
https://gist.github.com/x-yuri/9907d5b9cbf29e84d510902a776741df
https://gist.github.com/x-yuri/57d08f6afb10a89856d6e6a62abe30d4

Regards,
Yuri
