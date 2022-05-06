Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7413EC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 00:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385016AbiEFA42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 20:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387682AbiEFA4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 20:56:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C531EEEA
        for <git@vger.kernel.org>; Thu,  5 May 2022 17:52:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m62so3572797wme.5
        for <git@vger.kernel.org>; Thu, 05 May 2022 17:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8YFR/gavfI3lmCKRomiwlxra/HU6ebsjxaDYW5zTWD8=;
        b=Dq4es0VKAW41Kj8KyxmNYnkDQGK3Q0ocuAb2BokQbZsHDnfWcQV0jUKi4l2V4K1Hnr
         OvBtiwzPPBMSvttqYyUCnRrzT2wM7dGiJPjPvOUGoJossm/8FbLl19rABHR9PnkqU9MP
         D3m/B7impbM8rWrzWDBCTE1VAFwqTRpFYVOg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8YFR/gavfI3lmCKRomiwlxra/HU6ebsjxaDYW5zTWD8=;
        b=CR79BWTpZBTVcBreS6LoQs/XwaAIP0/4xXFUlNnkUbExxgLa5QbDWWnuq5hqRSQySj
         jwlwGABzRI9WYZmiXhWab/Dsw8PSM0dPfe64f66KGKPfHrsFJD9IUEUu9is80cKVv8Xs
         K5zFZxWzJouvXtu/ep+O+cbrkHzP4tFjLYrTIMcTiS/U7u0Lmf+RBuUKJ8fcUvaTR64P
         R+hCHNM6XYjvWM8he9p+olTJBffcup4mQRHJTIKffyBX1EV0p8J5iv5Ic+ds7auq0vJ0
         n/iyO+fSB60NDfgZhICVOYaiK630tE5y6l1m3ztY71Yryd2uOF2CKwki1/EytWSfjmi1
         2GlA==
X-Gm-Message-State: AOAM532vXc42ZirTC2A/ZLAi3TfVWc94Ne3KuE//bpb8iOe7XeNt4hLT
        Hyv8Ou+K26QTnDA9l7pKn9nxqyRVPtON5QnNk5U=
X-Google-Smtp-Source: ABdhPJzYcxmyTEZzS8hqEiTpSG3HUpbW79Xj60ZJO0QIgfTI/Qlw11s0ZbW2EURIyxrZ8gs6L+JKPw==
X-Received: by 2002:a05:600c:4e93:b0:394:e58:c446 with SMTP id f19-20020a05600c4e9300b003940e58c446mr761000wmq.21.1651798359286;
        Thu, 05 May 2022 17:52:39 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id n11-20020a056000170b00b0020c5253d8c7sm2250139wrc.19.2022.05.05.17.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 17:52:38 -0700 (PDT)
Date:   Fri, 6 May 2022 01:52:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: [PATCH v2 0/2] bisect: status improvements when bisect is not fully
 fleshed out
Message-ID: <cover.1651796862.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When bisecting, we currently don't output anything before bisection
starts in earnest, which can result in some confusion. For example, in
the case illustrated in the first commit in this patch series, it's
trivial to accidentally misspell a tag or branch and accidentally end up
in an unintended state with no clear indication about what happened.

This patch series makes it so that we give information about bisect
state even before the bisect is ready to begin. We also store these
changes in state to the bisect log.

v2:

- Move to improve bisect output overall, instead of just warning for the
  specific unintended pathspec case.

Chris Down (2):
  bisect: output state before we are ready to compute bisection
  bisect: output bisect setup status in bisect log

 bisect.h                    |  6 ++++
 builtin/bisect--helper.c    | 69 ++++++++++++++++++++++++++++++-------
 t/t6030-bisect-porcelain.sh | 23 +++++++++++++
 3 files changed, 85 insertions(+), 13 deletions(-)


base-commit: f5aaf72f1b5aeb3b77bccabce014ea2590e823e2
-- 
2.36.0

