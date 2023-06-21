Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9090EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 23:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFUXp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 19:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUXp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 19:45:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C910C1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 16:45:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9896216338cso208353766b.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 16:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slack-corp.com; s=google; t=1687391155; x=1689983155;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ/izSG95CtTP88Awg8ep7GKvaZjV2N8OvycvNP3xCY=;
        b=EO5uLTmYMCMEVMTg87cAV6XY7zFy/M4EImVi0UhBV+N+oQCyzqp4jHsSF80PLdc++z
         xOXOepVdIKWpbideKjBrZ3uSvN4BlhYr7mUYrg+v2pq5FOYgx2X6IM8EhpOuRSXl1vui
         tIziwWbU3KtS14hESgiqvST21ssbdVb64w/98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687391155; x=1689983155;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ/izSG95CtTP88Awg8ep7GKvaZjV2N8OvycvNP3xCY=;
        b=ig+s6eoXKIt3BJmHUtnV/fS5hy/X6uHvxf6hyfSzHcpwLbvlcEDAcIWvIbB34T6No1
         vGwSTk3ZqYi3I24fAtZcO/RCwxl22H6rmPnjw57sV7GxpPcT+cmI5ivEYhD1aEYaT350
         07WWXzYs3eHoxEmt3zB4Cc4BZNjZ+zReHEasHKMI/jSWtFnWu75/6y20QCL32R+UNfyj
         YYdJT9Y/cNHa00qrZYWl8MzajSr9hXIJ9ljHdob7siTymMn3Mrng6cmlHS0BekjnfM7Y
         h088ylYGHeTXvPIo7hjzlEXIRKlrBTCG2JrqzWvmFaeOr1MQRWBi5KQ8BOhSQzk3m2uj
         m73g==
X-Gm-Message-State: AC+VfDyRihLWREPmq6O1TPMBPv/ITGCavl6VhEnj+EBlN/Px/5TSfY46
        jN+GsHfvpHR/7mh/5ExUi53KqdLRUvvbJnONw1n0twAb2aDsbONpPbs=
X-Google-Smtp-Source: ACHHUZ6xGzhPTbA5KaJqdhKPKgVWKJ7EHs15HvnjAK1fpYNtoSKEkTMKh0tFgGUlHJkIepr/4J+j7FIsK32/U0LAhOM=
X-Received: by 2002:a17:906:6a25:b0:989:40a9:505d with SMTP id
 qw37-20020a1709066a2500b0098940a9505dmr5741315ejc.0.1687391155368; Wed, 21
 Jun 2023 16:45:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: jkasky@slack-corp.com
From:   Jesse Kasky <jkasky@slack-corp.com>
Date:   Wed, 21 Jun 2023 16:45:44 -0700
Message-ID: <CAJSLrw6qhHj8Kxrqhp7xN=imTHgg79QB9Fxa9XpdZYFnBKhkvA@mail.gmail.com>
Subject: BUG: config.c:129: kvi should not be set while parsing a config source
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git clone --no-checkout --sparse --filter=blob:none --depth=1 <repo> <dir>
cd <dir>
git sparse-checkout add <dir1> <dir2>
git fetch --depth=1 origin <commit>

What did you expect to happen? (Expected behavior)

Expected the fetch to complete

What happened instead? (Actual behavior)

Received the following error:

BUG: config.c:129: kvi should not be set while parsing a config source
[1]    5842 abort      /opt/homebrew/bin/git fetch --depth=1 origin

What's different between what you expected and what actually happened?

Did not expect to encounter an abort.

Anything else you want to add:

Two items I came across while trying to troubleshoot:
https://github.com/git/git/commit/9828453ff00b330c57daa3a8b672cbb5f0cdce34
https://github.com/Homebrew/homebrew-cask-fonts/issues/7718

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.41.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Mon Apr 24 20:52:24
PDT 2023; root:xnu-8796.121.2~5/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
