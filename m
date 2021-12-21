Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15FFC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbhLUOvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhLUOvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:51:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB87C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:51:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so3414713pjb.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=nx+qR3YaRTGzlMnENm1K0IPMyndzfVNoRe1nIY06dTU=;
        b=aVWhIeymMs8LcAKP39FSFb/idMlfgtJOLpBKLHpjvmb0s41ACvyv39TyMeqDt2JIMK
         6HBRWBiEiGJ+GXqGyJCeyDwymrjbzoqVVOHAosQtwaTxrSwdcBsOF3wXpSIhJYxv14Zk
         SQ+1CW13Zttaz7nunAJVYJOJk2BruMLwX4RMdSiDkCURAlpZJxoUyUWWik+by0N9SVIB
         uc1bxiME1dhFiZPs2WVIgJNziyBkBLxdcEM3P2+fMcstGAqhFf/jjoDzVj4a8MeCqP7y
         J3OtKdjGv/7R14xtQjGEoR3JC8ZPT2XE71FLWK3NpZRXVdQzinr+yd8ILtc9nD6M1pTB
         pTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nx+qR3YaRTGzlMnENm1K0IPMyndzfVNoRe1nIY06dTU=;
        b=d0cvMS3A2K2VLcU/4EkyQEsdIhdswRqDq1EXcN6EhLtQAJiNVfb8vuusp0xq+r8AZj
         8rLtUctiqLQPiniPTsUMN3KNM53LR+9uVkKiYqJWXc2Gw1upR3MYbSw8lTRitZQ2nNa7
         BWkqqE3ERe7wKJyRyK0WC0PljGChS7anXsuOKLnFDqQIbE8RT3X2l7yLIesIsdevN1Fl
         6dpbl0o+p5BDm3DFwIgu7JXVlwUp+hK6NsY6g9F76OC/LyL6rMAq0A42FaWfSWxjgPMY
         YWotQnmGFzAcHuNG9M2YGsvs/8l/FixFSCXvqT6r9CzHelnkOFza7Ci6xfVQfs2wWCEG
         eZ8w==
X-Gm-Message-State: AOAM532DnJfewyDoRk7+RyhV26YpO4oci9omC81MT7w5n+i4TP9eCPEG
        ia6DV6o6f+B2o1M2wtHFA+Y9VwdJ5BTZIoKThcOukPbV
X-Google-Smtp-Source: ABdhPJz7uZzh0lhlMjVbm2nHSRw0i5STv0/Zgf1WUHf2gGhsc+Ep0xAGbfDNVHbG53jjxtRKjsuvX1U+7KDRI2nTitU=
X-Received: by 2002:a17:902:ec85:b0:148:a8d2:91c0 with SMTP id
 x5-20020a170902ec8500b00148a8d291c0mr3662989plg.94.1640098265710; Tue, 21 Dec
 2021 06:51:05 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Vicarel <shundra8820@gmail.com>
Date:   Tue, 21 Dec 2021 09:50:56 -0500
Message-ID: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
Subject: Why does "merge --continue" expect no arguments?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several git commands that take a "--continue"
option...`merge`, `rebase`, `cherry-pick`, etc. From looking through
the source though, only `merge --continue` seems to expect no other
arguments. Suppose that you have just resolved some merge conflicts,
and then want to run `git merge --continue --no-edit` to accept the
default merge commit message. Having to open/close the configured text
editor still is mildly annoying. I'm interested in submitting a patch
to "fix" this `merge` behavior, but I wanted to check if this was
really the intended behavior first, and if so why.

Thanks,
Dan Vicarel (he/him)
