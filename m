Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F92C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDLGZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDLGZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:25:23 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6B9AC
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:25:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e10so1602238ybp.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681280721; x=1683872721;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q90P43pBpRp17YLBYxv0fu1owls1fP+SBetNvWXAvI0=;
        b=dwCuguiCarsAYoh9kOtdwAre8ivUEXXIm37iBuJ0asphDRz1CCDeMJXGYdjWdjDIz+
         qrjDI+bpSOVWVhCxbM+azCYBIFLcwu6s/bskuJjK7ktdUUhFYBClFBtB9ljqzcAsoZWY
         u6rbyPxLVT5rY5UwyfzLApQJcjt96O5CsfXLZmXbibhDRREuYAhtyJ4BZkTYgLrMNJFZ
         oOk7p1/H3IzS8xqFUrHk4+C1U0/GSwCGaaDvh7XxDCJkp4K0kS/R/A4kxqM44gJYjtPC
         ElwTf6YH2Ao3tsZ4CR1QZ29YXkLPw53OZJHqnccnOn9Q8wzkv7zNP/6D8991I+jUrYcE
         Ielg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681280721; x=1683872721;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q90P43pBpRp17YLBYxv0fu1owls1fP+SBetNvWXAvI0=;
        b=IftwIbsfrdEQNrC5Z1AybBmGGDIYV8m4X7eqsaAn2ryANUnVHyP3gUR6Cd+T2WmawV
         inbZavDAGcqBtCz011oim23g5IgIyjlB5hL5lwVftewQA4sqJUujuBZ4VrjMbPOEZ+Cj
         evli2jjUKKWXj0RT25uQmaf7ZkPmApwDSNMjvYeqbSXgUxLdnVj+RwTa44mDvoahG106
         d2o9dChZspJAMu8NKT/s06aO/YRf8uqabH+t5Sls9tuwybIO7U1yNfr2YMekZiNM1Hmf
         UqqXe45h5FxA69Ihuawvsu3iUaxCtNCImYb8XMqqLAVTqp9fLKFd3pfHr3Al/5BKq/qE
         tjtw==
X-Gm-Message-State: AAQBX9euz28BhkQZv8daQinJTw5QEdIK+bFyu40T0daeyN2IF6DtQQwF
        IQyzp9bF8ZeQx6sY45D+XIAsZ2UtlvsdjQgfcMCRGfoxF9TrF+2h
X-Google-Smtp-Source: AKy350apGtBMSJi4F64oIoIXbUHHy8Mj1Mlz6AwEbvSK4Vutr4w19cxOiAXRTG2QuGNbLXhN3Nu8e7GuaTYYYxFDrOM=
X-Received: by 2002:a25:df8c:0:b0:b73:caa7:f06f with SMTP id
 w134-20020a25df8c000000b00b73caa7f06fmr3323666ybg.5.1681280721240; Tue, 11
 Apr 2023 23:25:21 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 12 Apr 2023 14:25:30 +0800
Message-ID: <CAOLTT8Tg_Gkj6jid-sH_A=-xajN=rd=Vgh-nqHY5NcJ4-VExbg@mail.gmail.com>
Subject: [QUESTION] How does Git ref backend work
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. I noticed that normally refs transactions use the refs files-backend,
looking at the reference transaction of refs files-backend alone:
First, it opens a transaction in memory, then multiple update items
are added in memory, and finally, when the reference transaction
is committed, it creates a ref.lock for each update item, renames it
to the real address of the ref.

but there seems to be some packed-backend logic coupled inside of
files-backend. This makes me wonder why these ref backends are not
independent?

2. Is the reftable backend in a usable state? How can I enable it?
I couldn't find any clues on https://www.git-scm.com/docs/reftable.
3. Will future git refs backend possibly support external storage media
e.g. Redis?

Thanks,
--
ZheNing Hu
