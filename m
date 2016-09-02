Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C1C1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 17:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbcIBRPr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 13:15:47 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34537 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbcIBRPp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 13:15:45 -0400
Received: by mail-pa0-f46.google.com with SMTP id to9so3743238pac.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nFLwKpG+Lzdh8AQ+JRcfLoR4HU4hTA2YW+j3NbX0ecQ=;
        b=Ao+MeHgcKJceo5+LqQeV/xP4gOhPjdQ8aC7xT5FlEAgSbrDjEBZ91nTOYxrP+RUpgQ
         hdcSJ4nNOblTJdMtGapWoWiqetRjKc39ZFJiAZwx0exAYBKVj8Km6tS9SJu4MJ5H8dbG
         PaRePjnOXVb9pYdl8RL3CpngZFkmMct0got5bTpbysPloQex9s6p9TCoJBI1yPqbATKP
         Civi1iK8UZlo1Yok2bOmaRs2xB01J0Y8pDlaKd9vhn474lPMG+TWfkYHLtnrRj0nMomV
         SaS/BmA8MvF1x2dOTz2ausj6sUIJU86GK7uTLRlLLmwmyzYl8qJ0rRQTabxd4Jq5Ien2
         7HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nFLwKpG+Lzdh8AQ+JRcfLoR4HU4hTA2YW+j3NbX0ecQ=;
        b=Ac6jBDyAOexY0/w9oL4tIu1/Ozsq3F5hqaHfCdiY0bHw8lHcXXF8Mve49tVwFkyzM8
         ESbZjWCWQnzmQ4KoWeMmDu1GslxgzddN/Aa2EPjHgasD1sOCsAsMueglm10H67Wo3Hng
         JmjmzlpQPBb2JVqZcoz9qXN9WBXjoj1/uGBSHgcAlTl+UR1le0zGujb8HGIIIe4c6qFu
         WdNrCIt8aiHxyXSa7y2uNlQAyhAJTW99aBG1bbd8oUWrSkG6SRQULqy6UBlCAHwca1IG
         /qUyx3QUERTSWQjihXdY4aeh5ZAacvqajTVB6Ls40bssTwMm9avZAeetY92aEFXCut25
         48nw==
X-Gm-Message-State: AE9vXwMPxv8jxovRfcj9NYbUOPK+t1vYprwkJZxxDIXSTMzSB0BfNjWuhkx3rIsX9sXrfv7o
X-Received: by 10.66.183.206 with SMTP id eo14mr777728pac.146.1472836544460;
        Fri, 02 Sep 2016 10:15:44 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id v16sm13914710pfd.32.2016.09.02.10.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 10:15:42 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/2] handle empty spec-compliant remote repos correctly
Date:   Fri,  2 Sep 2016 10:15:37 -0700
Message-Id: <cover.1472836026.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This issue was noticed when trying to clone an empty repository served by a
server that uses the JGit library.

Reference Discovery in Documentation/technical/pack-protocol.txt dictates that
servers should send a zero ID when there are no refs in the queried repository,
and implementations like JGit do, but the C client does not handle them
correctly (treating them as an actual ref and subsequently returning incorrect
responses or errors).

These patches fix those while maintaining backwards compatibility with existing
implementations that do not send the zero ID in such a case.

Jonathan Tan (2):
  tests: move test_lazy_prereq JGIT to test-lib.sh
  connect: know that zero-ID is not a ref

 connect.c               |  7 +++++++
 t/t5310-pack-bitmaps.sh |  4 ----
 t/t5512-ls-remote.sh    | 22 ++++++++++++++++++++++
 t/test-lib.sh           |  4 ++++
 4 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

