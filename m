Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68267EE49A4
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjHTT5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjHTT5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 15:57:46 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A68E0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 12:52:48 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56e280cc606so425999eaf.1
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692561167; x=1693165967;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/qYmzAIjv+8SH6mOBo+/AHB2DqAnmMn4grin6Rx4d7w=;
        b=Fy/p4SgUWPxY8uHyZUJaQclnVLk4YwGjcG3Z/UECbM9xNi7VNLLDsYhItoZAbi3wZH
         T+h3fXmQxHbAPdpcpOW5G8vgypTbicYC7ogT2zwlECYWBzabQbWwEXlvqSI1Loik0Jsq
         IgT4SuepjuRLaj6GZVw4l1wEuZCFUKWJk9vdl1O7FEewKxq3GAvnrzkuh2ZJInyG6PnW
         O/ynXBrefFZN6nuWnVCzXu0dlyH5ERcWjhF3fwMmJ4SpPvinbEnzlzQRC3DoNsjrmgyi
         NIhi4RlbAj6am1EEUALVzCkbBs7hBu/0U5FnDA2tDHY7je/qhHMqrrg+mEegoIN1EED3
         Sszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692561167; x=1693165967;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qYmzAIjv+8SH6mOBo+/AHB2DqAnmMn4grin6Rx4d7w=;
        b=HSBXqD+J5rdKOZ+1GXh9sSY2MqxTK178mJSm5JLYXE8oMYVjouVe0KrVAwy0Dms76V
         YWXD5vC06bnMqzQa1eJpLxs7qIxiHm06GX9urYGQjORcT4WRoPY9+6r6pC+VYDOuz6/x
         HlvON66ooyAn1uI5FR72Iaz1f/9btyq4IyH5UliM2xIfNbQhRkIudp7zzN8u/Tt4zhCf
         SuJvmEi2hZg1SNhyUdnAhfx8WOIE0/ZeDCwRWIuwVxHztcEudQiWarLKdEp4dHeq2jzA
         7K5i1XLvIsdwBgL4uBBIAKw4TTaRazv/Zq/DCglupjpMaC7wNDPTUsx4t0Zm9YzG88g5
         4gTg==
X-Gm-Message-State: AOJu0Yyyu4xJelouc7Oowe6tmOGQ87cOg5RjSQp2Vrafrq2/Ak4bdoYV
        +7FLQ2JtuY8ZHRMvwT5ychk58Frchs7SM8u32yLEagEpr4E=
X-Google-Smtp-Source: AGHT+IEUYdNHqGFDYXJiiqIt+UbmtgJQmhzeYhLfzQPzrEPI1NotRBJjqQbpURI2lOVMfZqhKbgb7Tv2z2wljVuBhXc=
X-Received: by 2002:a4a:37c3:0:b0:570:cad0:fce9 with SMTP id
 r186-20020a4a37c3000000b00570cad0fce9mr1017323oor.1.1692561167412; Sun, 20
 Aug 2023 12:52:47 -0700 (PDT)
MIME-Version: 1.0
From:   Romain Chossart <romainchossart@gmail.com>
Date:   Sun, 20 Aug 2023 20:52:36 +0100
Message-ID: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
Subject: "git diff --no-pager --exit-code" errors out but returns zero exit code
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently found out (the hard way :-) ) that running the following
command prints an appropriate error on stderr but returns a zero exit
code:

> $ git diff --no-pager --exit-code
> error: invalid option: --no-pager
> $ echo $?
> 0

I would expect a non-zero exit code to be returned.

Interestingly, running `git diff --no-pager --exit-code HEAD` shows a
usage instead and does return a non-zero exit code as expected.

Thanks,
-- 
Romain Chossart
