Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84B820958
	for <e@80x24.org>; Wed, 29 Mar 2017 18:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbdC2SiA (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 14:38:00 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32911 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbdC2Sh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 14:37:59 -0400
Received: by mail-pg0-f44.google.com with SMTP id x125so15192697pgb.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fm7SD2Tm4zIN4IdDgNEEfr/m6bzQFENnpcEHtN4dheU=;
        b=VYrBPBrrm5sJuR/PzcLZC9jN5nNzTpAosgAjoz0WiljyJYO0uksaAph5GflpkFdYw6
         sMJuQ1egTld2+vYfztQXD7NOH+weeqCpT5Gin+xrDrKsotVXrVyNblrdXSDxLvMRDLyq
         xG9S4/wFuqmbuLGk3bZTBOSPzjyalpVB2WkhdfA+MhxpMhj0K9p/vhDCGiQVgGm8z3Yg
         T66vfNz4m/CpSgegcL3g3wKxiIO7tkbaycSCitktNsTXM3gRkVgWb93/athi6JLOxcPz
         hNZwXn+/28ZkXDGURpWCrNI02/T1DMbX2MrHiACyxncHEhkpme1cFq3JALejzQ7fiozl
         hqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fm7SD2Tm4zIN4IdDgNEEfr/m6bzQFENnpcEHtN4dheU=;
        b=IKJ7mMn+9aZlqcAAhYTScHzyKe+Pzj4VuRZMv676anfXNDjEcDLRAfDEQZB+RSbrkj
         ZT94U9ENhn6SMNEDAoPSE04+z38QqLRMM3kKI002STie2W7LK2JgEcJmlAZ4RZc2VZna
         Mo9kZ1k4tWNq1XaI0SwbZkoiNUaQVfAtwQ3pCwpRwTUOGy97qvnZCX9aS5bu4gNp3llF
         hpwxAqnDJrsOquN/SvYj4dhfk1wy67SKq2uZq9ONrLeNBTsuxnJDr48HNdTX5IKKo8cb
         cP7UdcrW8LcNa9oyxzXEgaT1pbGnngfeqjPShJJAshjBVPvt5yjVUJiHt91yYud1YQWm
         TSoQ==
X-Gm-Message-State: AFeK/H2FH5nQqSj8pdzC9ydec9wtuaL8s4waBVp8Nu3exvjduhYVAdfYLXCwlUnghigH849W
X-Received: by 10.98.66.155 with SMTP id h27mr1968956pfd.182.1490812678390;
        Wed, 29 Mar 2017 11:37:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id b70sm14890238pfc.100.2017.03.29.11.37.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 11:37:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] entry.c: submodule recursing: respect force flag correctly
Date:   Wed, 29 Mar 2017 11:37:42 -0700
Message-Id: <20170329183743.27506-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.517.ga53e110413
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case of a non-forced worktree update, the submodule movement is tested
in a dry run first, such that it doesn't matter if the actual update is
done via the force flag. However for correctness, we want to give the
flag is specified by the user.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index d2b512da90..645121f828 100644
--- a/entry.c
+++ b/entry.c
@@ -287,7 +287,7 @@ int checkout_entry(struct cache_entry *ce,
 			} else
 				return submodule_move_head(ce->name,
 					"HEAD", oid_to_hex(&ce->oid),
-					SUBMODULE_MOVE_HEAD_FORCE);
+					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		}
 
 		if (!changed)
-- 
2.12.0.rc1.52.g2de7d24de9.dirty

