Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFFC27C76
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 01:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAVBUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 20:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVBUr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 20:20:47 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7532448C
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:20:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g10so6639307wmo.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQPme3d+YlbGhauHzK62bi2t0mG++NYYTxokOKhZEDM=;
        b=CgYfzfhVwSPHfJHFjMtL7HxqYjogMBavIpwCOEGvxEiSLb71cqPTEr37gk4DJegNhW
         IJOPULs2am1ebYiGLJ6Jxol0LzWCjb30iGLgzFUPJYQwnW7QGwiMTVLP5eABTExKfC1E
         NbWN6cFOJVCKY7Wa4yLGLOepPayBDT56TrROMApl/AoLcDp97qWfByOvALvYtByRxENW
         rQMNIn9XQTPqfPxIrfzvYDCSpjIG4BRDAfD6jyhtTQS1krukaGSNrUKa6UojbYt0rB+0
         oEbwPVdi/v9x11odool8aLKLv9oSPQH2wQeoc/uRC2YzQ4IKgNAPCOBeQOxKM3B1t3K6
         Lx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQPme3d+YlbGhauHzK62bi2t0mG++NYYTxokOKhZEDM=;
        b=y4w4aBvlJsQFOrcE3zF5oMZZnUMz++gK2oJnZw96XkUJHX13TVK2pa0LROqIhwocw8
         a9PgX9m4k7g4+iL1cViaQauq0ITrDzMcCEvL2PPeiD+06zD4sKbedSCjEoYNdogX1G35
         fE8TMFFyxUkg92yffLPnucJLBLlfjz7+Kjg2Q+Yqrc4UyVFjuX6kY8ddfv9L39/vecZS
         k7TkiiApvQvpoQ7CR302q5x152AH4xlBPDG8Z2dUktdK4Dil2JB6xY4blXyFdd7uSeWw
         GUyeNWDKeb3eS2unmB8fkiFluEP8zugxWXdw8Yn5LquK59rGNAUTYbXIw7q3iweFfYfY
         cHaA==
X-Gm-Message-State: AFqh2kobsDbjkRRekf59vBPQoTZCgU493lyEZCzwFGrbcKyGSXhZ09e/
        wMuMUOi67BYnSQh18+6ua3s=
X-Google-Smtp-Source: AMrXdXu0X0/KZ+UZ55zCOhrMDog6tgxmF0qmIAPT0//jL/Z6hUip7m8qqi7/7oYdRJXmgW5g1GrbPA==
X-Received: by 2002:a05:600c:510b:b0:3db:d3f:a919 with SMTP id o11-20020a05600c510b00b003db0d3fa919mr15616075wms.1.1674350443648;
        Sat, 21 Jan 2023 17:20:43 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003dafb0c8dfbsm7520845wmi.14.2023.01.21.17.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 17:20:43 -0800 (PST)
Subject: [PATCH v2 0/3] fix die_if_checked_out() when ignore_current_worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Date:   Sun, 22 Jan 2023 02:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes:
- The message explains the change as a bug fix.
- Introduced a new helper is_shared_symref() to be used from
  find_shared_symref() and die_if_checked_out().
- Tests for rebase and switch.


Rubén Justo (3):
  branch: fix die_if_checked_out() when ignore_current_worktree
  rebase: refuse to switch to a branch already checked out elsewhere (test)
  switch: reject if the branch is already checked out elsewhere (test)

 branch.c          | 16 +++++++++-----
 t/t2060-switch.sh | 29 +++++++++++++++++++++++++
 t/t3400-rebase.sh | 14 ++++++++++++
 worktree.c        | 54 +++++++++++++++++++++++++----------------------
 worktree.h        |  6 ++++++
 5 files changed, 89 insertions(+), 30 deletions(-)

-- 
2.39.0
