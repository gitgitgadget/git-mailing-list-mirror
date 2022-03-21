Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A0C4332F
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 09:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbiCUJiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbiCUJiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 05:38:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4A5FF29
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:36:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h13so17099166ede.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1UQmdbKMd+JpNE+qJI9e8zzP/lkInI5lZWlD3U3+QG4=;
        b=enqYICnqaAevPllVlb6cxkj2bIXgMdpKgrViibxlmLHNk+pYD0L1U95AWvlIGa1+Gx
         6LTEpf0OUntSQN1swlTLftVtUbv/LfiLjhs5X1l1YYbI9nj2ANfbyS6B9TcUymAfAIe4
         zD2g+h7zGNRm0LBNDUxIrrhNXK0G37/uHueMiJ8CSzvh4p257uuxtdicjzloPK7dL0hL
         vacrIJisRIP0XGGNTogr/jcOS1NnCIV7UuRKuCTIs+sajcuPH2THT8lmrZdoOvqPKxdT
         7kJQ1LNqHK4T0l9hR/yrh1RTesZ3o+zDGh5H9vIIa2ByF/Z721nu+ha3kaD22hgaJZO0
         2QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1UQmdbKMd+JpNE+qJI9e8zzP/lkInI5lZWlD3U3+QG4=;
        b=yV8wWPDpLliOqRsEq67oxOzQHGXl4njcUk64W27fu244I73Oq64atkd222B5Ftffcd
         gIQ6nljVOYMdTtTYqxiHJeVdT1VTEiS5xRqXuGsSX6aWwyQVFr6uY3xxCnXm9cWRU7t/
         jkGXFzWILLnxZjEjSkCBCYtuNTxMBX+hGtivK2S0KMnopen/fWJJX3fmIw6SYQcCKdKL
         m0Z/8xTYJg6ntqRGVxcUtxceTk/qHtJzJ5woKfsXu2wwVimoqIuzHxfVR3Wl+081AkVe
         seAlQkGNMDKxSxqaIELodw5qMzVS9PNMs+2oLSQkiFgL5p793vtpdsEmNrmtdiRM/W4f
         zAdA==
X-Gm-Message-State: AOAM530Djd1OktL9td4P1VEAjlbTNDWcQmG+Gp66AZwHWWcd0HbA7lIH
        1lnwV7efFmKv8y9KLAk5DhqqWtcfFOGOp8YE75BVkXdNZYc=
X-Google-Smtp-Source: ABdhPJypq//WJhV3nZrmyPp5+Cek5S4HzwzFqwGsw8iL6/rVpCT9MdOLuahj+MqyX+/mpARDw02eJD3YpkIb86e1ceY=
X-Received: by 2002:a05:6402:1e88:b0:416:9c06:9818 with SMTP id
 f8-20020a0564021e8800b004169c069818mr22144055edf.290.1647855396354; Mon, 21
 Mar 2022 02:36:36 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0JrQuNGA0LjQu9C7INCg0L7RgdC60L7Qu9C40Lk=?= 
        <kirill.roskolii@gmail.com>
Date:   Mon, 21 Mar 2022 22:36:25 +1300
Message-ID: <CAMutOmEVw1Y1XA665EYW+F6tgw5fBdwnCroGakfoOEQ0kbxQJw@mail.gmail.com>
Subject: subtree split fails to remove not relevant commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

What did you do before the bug happened? (Steps to reproduce your issue)

`git subtree split --prefix=${project_path} --branch=${BRANCH}` .
As part of the parent project we developed a couple smaller ones. Now
it was time to release them separately.
Most splitted as expected - first commit in the history was about
creating a sub-directory.
One sub-project has an issue - history wasn't erased, it contained
full parent project history,
and only commits starting from creation of the sub-directory have
"contents" changed.


What did you expect to happen? (Expected behavior)

When I do "git log --oneline -- $path-to-usb-directory" I have 21
commits in the history, so
I expect to receive this history in the resulting, filtered, repository.

What happened instead? (Actual behavior)

Full history of the parent project is visible.
Originally encountered on 2.17.1. Then replicated on 2.25.0 and the one below.

At the  moment the parent repository is not publicly accessible, but I
can share it if this will be useful for debugging. It also has the
script that splits sub-projects.

[System Info]
git version:
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-104-generic #118~18.04.1-Ubuntu SMP Thu Mar 3
13:53:15 UTC 2022 x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.27
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]


-- 
Kirill Roskolii
-----------------------------------------------
Mobile: 021 088 11055
Signal:  021 088 11055
GPG: 0xC675DFFBEE30974D4E478095A96816DD0EC7FEA1
