Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC02C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 09:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C3360F12
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 09:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhHaJgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhHaJgL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 05:36:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC8C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 02:35:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r7so9815552edd.6
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpkPVziD6J9We9RZvcV51Qzs8LXNjBiNDWIVvAtvB6o=;
        b=HJbMoqhJ2Nto9U+5qCb38lupT7gKZ2CwVMIaDMat1k9F0JhL/IfP4nrEnimVRMFwTT
         JLu0/WIamPqVVSedDYwXa5XC8VGe0jbyJvgAmwIkefkoUoJELdBhDVyWliT4k+wrdRjK
         L5FjUZd2ujeWHUbK191SPWtlAJUOiC4VT6C74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpkPVziD6J9We9RZvcV51Qzs8LXNjBiNDWIVvAtvB6o=;
        b=ouBei7LA7RtV+nw+d1dgL6mKf/FLkFGBUX0frrpHKDt3thaQrhhqSdQtn9uUXGqCt1
         9CD30iGjX34lLvtVqYQFhEGevMBlhTydVki7YIOrJkJk+pTzotEwAADejA7Gob4lAxGH
         Hy1z13bbg/tk2lpUNhv2DqN2jBI3VyOdZ1UP6M4VeKMw5OIdZ4yOZq/1FnAcfaB8YsVt
         KrzLx7x6JakQ0LCNNMRRaIr4KW30mXbubqke7qLKBbaYfWH6ufp0sTW4Ui69KjZsHKot
         Nmy//1yOVmnDv1jipPPgeBB/uTW5gEMD1a1d+vUc2G7Juu+suxH4bW2q4vvnRW7a7TM9
         dH0A==
X-Gm-Message-State: AOAM530Aj4z1/KqOC63nKgrSShMlDssAir7oH9xQ1B0M5UB7kw6WaA1Y
        TyYJLcCmI3/B2o9QaeCAtnAVwA==
X-Google-Smtp-Source: ABdhPJzKegGin9pSEuQeFkyw8COKiWlPT6p6sPg1GZyzJnr2RxiB6L3lGDhq/PHWuUpWDeqb0s8aKg==
X-Received: by 2002:a05:6402:3c8:: with SMTP id t8mr30033976edw.150.1630402512876;
        Tue, 31 Aug 2021 02:35:12 -0700 (PDT)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id n15sm9000318edw.70.2021.08.31.02.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:35:12 -0700 (PDT)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        git@vger.kernel.org, ps@pks.im
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v3 0/2] send_ref buffering
Date:   Tue, 31 Aug 2021 11:34:42 +0200
Message-Id: <20210831093444.28199-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <xmqqbl5ic19t.fsf@gitster.g>
References: <xmqqbl5ic19t.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes compared to v2:
- remove setvbuf call
- add packet_fwrite_fmt
- add packet_fflush

Non-changes:
- no ferror calls because those are for reads, not for writes

Thanks for the reactions everyone. I agree that packet_fwrite_fmt
simplifies the patch nicely. Jeff, I hope I have given you credit
in an appropriate way, let me know if you want me to change something
there.

Regarding setvbuf: I have found out that GNU coreutils has a utility
called stdbuf that lets you modify the stdout buffer size at runtime
using some LD_PRELOAD hack so we can use that in Gitaly. I don't
think this is the best outcome for users, we ought to give them a
good default instead of expecting them to invoke git-upload-pack
as 'stdbuf -o 64K git-upload-pack'. But I can't judge the impact
of globally changing the stdout buffer size for Git so I'll settle
for having to use stdbuf.

Jacob Vosmaer (2):
  pkt-line: add packet_fwrite and packet_fwrite_fmt
  upload-pack: use stdio in send_ref callbacks

 cache.h        |  2 ++
 ls-refs.c      |  4 +++-
 pkt-line.c     | 30 ++++++++++++++++++++++++++++++
 pkt-line.h     |  8 ++++++++
 upload-pack.c  |  8 +++++---
 write-or-die.c | 12 ++++++++++++
 6 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.32.0

