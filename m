Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF655C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiAYW3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiAYW3W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:29:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A1C061747
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:29:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k18so22479901wrg.11
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=w0fDbK48nIPvcH88MAwGrd5AUtHcLEuy2RRbXOXhv6k=;
        b=loTsKzlHyjxXdtDC26bQeVeZPA6KuBFoe+zjG0Su2xh5S8LVbYXbyKq+GSrIlU/1A2
         uVSecvxYTbpBQJ99UdwUp7R73BorFQXHqWu3qZJCSfAcXNepeyT+NZ+0vdAXHYfN+Lds
         NZ1mzvsylD09biJDO6SS59sKij+ncw/dkVS7LtBcOYlz654YMjqSplXJ7TPPqGc9oFR5
         +EcpWNvlSd94uVW6fh3kU/Recgb04bDFpITgrYsU3cVGSDuhWqliySkJYWzuMNv9pjK1
         3A2PKzOtolNOqh/4QxSnbDmXDYoads8vZb0XG9CmQHygCcdr+ez6yGkITUt00IRbZOAO
         9lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w0fDbK48nIPvcH88MAwGrd5AUtHcLEuy2RRbXOXhv6k=;
        b=lgGzZou+c2TuTkf0UxMecIyKjnwVTL1cVM+d3B2ynXNbsevXc44+PscpOoOnOAwKlx
         m8i69ASU+ZH8wZ6sb+xf2X7ZlZ5LyMe4XriIgoP+7TX1qj5MY09AKc7l0ksGLJw9LrGA
         /ODLN0qJXMN32B8Xaxoo5X+TtCVW6t7LkEU/6rUXpXeWmHHuKaHKOu4m+f6NK1POHgi8
         6aMeJnprKwCE8KFXh4mQnU0qwQC0ElmEz+kpsSJp/kCiVristu1fichB6+Wm+uqhRQQP
         IpCpNutopncZcDzDanX8qIWxsYfroM1MnmyCtDIM5rfQ1bUEqpyKkc+ksaMMWvKPyK5e
         8yYQ==
X-Gm-Message-State: AOAM530evGPuz47jzDpBItq28u/Ec+S8su6+xZ61elFDNYfCR5RqGzOr
        kYfIPW+0/GeXb3Cc2OylvjB14dStjEg=
X-Google-Smtp-Source: ABdhPJznw85QIUUEdVv8692bWgHwBL9wPEUPLni4pk1mHd2EgSArtp4F93BABmCsJtP+uhusTKaBXw==
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr8179456wry.486.1643149760559;
        Tue, 25 Jan 2022 14:29:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm22696008wry.36.2022.01.25.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:29:20 -0800 (PST)
Message-Id: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Jan 2022 22:29:17 +0000
Subject: [PATCH 0/2] Fix two --diff-filter bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A colleague noticed that git diff --diff-filter=Dr behaved in an unexpected
way. The expectation was that the command shows only deleted files, but not
renamed ones.

Turns out that Git's code is incorrect and turns on all diff-filter flags
because the argument contains a lower-case letter. But since it starts with
an upper-case letter, we should actually not turn all those flags on.

While working on the fix, I realized that the documentation of the
--diff-filter flag was not updated when intent-to-add files were no longer
shown as modified by git diff, but as added.

Johannes Schindelin (2):
  docs(diff): lose incorrect claim about `diff-files --diff-filter=A`
  diff-filter: be more careful when looking for negative bits

 Documentation/diff-options.txt | 7 ++-----
 diff.c                         | 8 +++-----
 t/t4202-log.sh                 | 8 ++++++++
 3 files changed, 13 insertions(+), 10 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1127%2Fdscho%2Fdiff-filter-buglets-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1127/dscho/diff-filter-buglets-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1127
-- 
gitgitgadget
