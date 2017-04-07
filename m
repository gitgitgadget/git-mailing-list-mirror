Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F6620966
	for <e@80x24.org>; Fri,  7 Apr 2017 19:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934091AbdDGTYN (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 15:24:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34096 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbdDGTYF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 15:24:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so17420566pga.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7PJYqzkB+yV5ji1TsDjKKgwQ//pybGToz70fSgltIrg=;
        b=oBSYI8bu6E8I0/wLuyNovvisdGAROuRz/EALRzvVgAoVwpTiU6m2Gi6OlayQjY37mk
         2WBiwr1iq7/WT5TKmNag6LAY/ooCzCLNh4aLnaUMphs587chAVSnNkN4j0SOYYJQGCST
         opg4is2jCIUuwSOFjJ7LtezhzWCA2/yk1jiB55Q6MeKNIW10uCcIY7IdHzIHzbbHpwCQ
         VY1mWGQKHF8uDeoftaqNTVb3TWgUf/CctsdjjUAYql+j7DLCGxkpjZbteeoOKdeuZny1
         e7gxurC50c8r3IMarfhE8wMCdIpxFzmlR3CIpcYtvBxKoPfTMQLM5jPS/LSiAFTLEHC4
         KNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7PJYqzkB+yV5ji1TsDjKKgwQ//pybGToz70fSgltIrg=;
        b=jZDUMPQjhk0u2ovLT8nKIc4LUUnXxyP777xggCgN1Rig6HFLmyYtI4E4RHhm/c96mn
         qAOZ+QaEAgOY5bRnipOjpSHhb21G4YBdfaEyAYpVZvaKcKhtN+EVMcAjq1UiG4YNBZdt
         bo8XpMKk7Q0iSHQFhyxSrcDdcSK8KGIId3ceclrhXU5WoIMGMOWfHzlUfQxsIo8PwbEd
         4rNlTK+W6FR/Ge7PiRtbqLNULFiJZbIACZeYZOHSv9oTaAiT0xTsbJcQRtah1Lm2zCYN
         3oWqwEIJ2B/eK844Qw/oZv57jldiVcQ5u5XnpFtMB9RwD7UhAzQVaYevl0iBYHCwLkto
         QZfA==
X-Gm-Message-State: AFeK/H1lfOqRYSbGsOiKTfRx4u5htKf5vpAoc8gr9vQ65dVlPdAu27IeiDF/qwdvUZdh5w==
X-Received: by 10.99.124.26 with SMTP id x26mr42507675pgc.81.1491593044053;
        Fri, 07 Apr 2017 12:24:04 -0700 (PDT)
Received: from kewillf-git.redmond.corp.microsoft.com ([2001:4898:80e8:9::3b6])
        by smtp.gmail.com with ESMTPSA id u29sm11018797pfa.123.2017.04.07.12.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 12:24:03 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 2/3] apply.c: do not checkout file when skip-worktree bit set
Date:   Fri,  7 Apr 2017 12:23:56 -0700
Message-Id: <20170407192357.948-3-kewillf@microsoft.com>
X-Mailer: git-send-email 2.12.2.windows.2
In-Reply-To: <20170407192357.948-1-kewillf@microsoft.com>
References: <20170407192357.948-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the sparse-checkout feature git should not write to
the working directory for files with the skip-worktree bit on.
With the skip-worktree bit on the file may or may not be in
the working directory and if it is not we don't want or need to
create it by calling checkout_entry.

There are two callers of checkout_target.  Both of which check
that the file does not exist before calling checkout_target.
load_current which make a call to lstat right before calling checkout_target
and check_preimage which will only run checkout_taret it stat_ret
is less than zero.  It sets stat_ret to zero and only if
!stat->cached will it lstat the file and set stat_ret to
something other than zero.

This patch checks if skip-worktree bit is on in checkout_target
and just returns so that the entry doesn't not end up in the
working directory.  This is so that apply will not create a file
in the working directory, then update the index but not keep the
working directory up to date with the changes that happened in the index.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 apply.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/apply.c b/apply.c
index 0e2caeab9c..0da5d0b7c9 100644
--- a/apply.c
+++ b/apply.c
@@ -3327,6 +3327,24 @@ static int checkout_target(struct index_state *istate,
 {
 	struct checkout costate = CHECKOUT_INIT;
 
+	/*
+	 * Do not checkout the entry if the skipworktree bit is set
+	 *
+	 * Both callers of this method (check_preimage and load_current)
+	 * check for the existance of the file before calling this
+	 * method so we know that the file doesn't exist at this point
+	 * and we don't need to perform that check again here.
+	 * We just need to check the skip-worktree and return.
+	 *
+	 * This is to prevent git from creating a file in the
+	 * working directory that has the skip-worktree bit on,
+	 * then updating the index from the patch and not keeping
+	 * the working directory version up to date with what it
+	 * changed the index version to be.
+	 */
+	if (ce_skip_worktree(ce))
+		return 0;
+
 	costate.refresh_cache = 1;
 	costate.istate = istate;
 	if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
-- 
2.12.2.windows.2.1.g7df5db8d31

