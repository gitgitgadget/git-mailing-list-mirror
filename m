Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E20C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346007AbiEKSAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345982AbiEKSAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 14:00:09 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2E6FA2E
        for <git@vger.kernel.org>; Wed, 11 May 2022 11:00:07 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l1so2664861qvh.1
        for <git@vger.kernel.org>; Wed, 11 May 2022 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pnQ2y7Zji8HkQBPKd/hZ7p0V+aU5COAa3V87Xvt9coM=;
        b=ExXKLw5lKJ68DCYPNZuIxC+xRZ0PurLzmPB8KUBBEQffX8VaRz/KQi50omBgCEDePG
         HjP86R9Rfs8Blo9eMXhqpCOz20JkGrW18ycMUxQsFLxPSq1HVfxJ6WcHiDPEOrRIOvW/
         fX5GZDyrnih9UmvnYT4a4c3MV2cOKIob7dGXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pnQ2y7Zji8HkQBPKd/hZ7p0V+aU5COAa3V87Xvt9coM=;
        b=W4NPgHIag5LtDLIuwzHqGGzqtsLxBqzDzVuZ8cf1/QAsSBnzPauBOumagqqMbMIiOj
         bjExQ68B9Z3F2X7bNNsFl9+MhYSkZk1pPbXBFGa9P4VB02tElHVuNdQlZ/ResU9DFMvN
         nHnQdOZhTeloZ2vXYMDMFfsLGpmfOxgDBlEfbJDO+q2UQ6RwB1/AcVCB8LuCt60dro5y
         asPxIzizQNLLfB04vOX6ceiUeLi7ASANGw4F3b3Qvpo/hQX5CMIeZLlj0eKrTQttNfcf
         fu1G+vVTcRMCUs45hZsL6UHC0dt6f0+bviBv7tFXScPJ2YCcmzb9SV8m/Pe9zuyngAWb
         Dhjg==
X-Gm-Message-State: AOAM532D5cGNtsZjpSxl4MfB8BPor6CXKJVHLsKE7Cw8ZGcV1icj/9h8
        i/CNKTUpH1DgQR1zSSYqYH7DS5yErtLtVyvmIzM=
X-Google-Smtp-Source: ABdhPJxBPCPOZC0iaoBp3TemYdVqZZ0yeGC0TIZirv9YovimdPCnQtQCq+2pN6hHRVmkB6w/T2xl6A==
X-Received: by 2002:a05:6214:21e1:b0:440:fa7a:493e with SMTP id p1-20020a05621421e100b00440fa7a493emr23165565qvj.55.1652292006546;
        Wed, 11 May 2022 11:00:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fd])
        by smtp.gmail.com with ESMTPSA id 69-20020aed304b000000b002f39b99f66dsm1443237qte.7.2022.05.11.11.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:00:06 -0700 (PDT)
Date:   Wed, 11 May 2022 19:00:04 +0100
From:   Chris Down <chris@chrisdown.name>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, kernel-team@fb.com
Subject: [PATCH v3 0/2] bisect: status improvements when bisect is not fully
 fleshed out
Message-ID: <cover.1652291688.git.chris@chrisdown.name>
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

v3:

- Fix test indentation
- Rename bs to state
- Use `unsigned int' for nr_{good,bad}
- Pass the bisect state struct as an argument into bisect_print_status
- Zero-initialise bisect_state directly, don't use memset()
- Fix multiline comment style in bisect.h
- Use strbuf in bisect_log_printf
- Change `git bisect log' use an output file in tests instead of piping

Chris Down (2):
  bisect: output state before we are ready to compute bisection
  bisect: output bisect setup status in bisect log

 bisect.h                    |  9 +++++
 builtin/bisect--helper.c    | 69 ++++++++++++++++++++++++++++++-------
 t/t6030-bisect-porcelain.sh | 28 +++++++++++++++
 3 files changed, 93 insertions(+), 13 deletions(-)

-- 
2.36.0

