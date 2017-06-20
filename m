Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6CD20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbdFTH5M (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33152 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdFTH5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:57:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id f90so21272829wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssxkIdIApnjK2t0aiNpijoYUtOnNXFaqhBgqpjCSHiY=;
        b=uUq8gyskGPKw/ncbwz8zgRChRbQ9bBw5yexkiKZ65yOLN/ClYMPDsmt5ftZD/k8L2M
         q5rOuXdiO7Y5ZxDdTYSHEvRI4rphzKpopXf2DdRcHycqn0gHcdPN1u2ExHrFGX2Gz1NW
         wRqAqHguPCu8EXLUDjKp5+OuOPRyhQzY6V87j1GsoiHx+BBmC6kjB0h8CVyrilLq3jov
         V29BZ4n18LDH8yL+i/jkhStfMFawfe0oPvFGxCsYjzv2cKaZf+S9+IouUU73PaQaozlW
         jYhZTUuJjljzYQ6Qk6pbMXP2mV0OfcreRkTMH9+Y21/eR4pODMeSx8vwtf+ZV3hgwvrD
         A+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssxkIdIApnjK2t0aiNpijoYUtOnNXFaqhBgqpjCSHiY=;
        b=cokH8HrjXrhQSUG1CQjtFCNGYKFUN7+e1IB5R0h4XxP4R1b6MfsHEHIQLd7QAInXlU
         dQhUWFtV0AXkzQl2LR9jNIMgbqCrO9pn9DRJrZDJv7wibuTb4PpjDwiyNrNaQaStQEtV
         XgGCGWnQYUmncsc6EYackRrIKuyVTFsx/Rle2hc53AFeihB7k5fe7yZmuXrt3NLaFY7P
         ERiccB3qWA3oDg+W9OUE22YHP56guiuwmi0Ys49py1Ez7CUdml4+jl8LN6PcshUupygB
         p8Dt1XVAAz5jKDd/gFeKbFALREUz9vkdZApHUCB+D86VZAf/AzrURjLR+exnfCztQDjV
         q1iQ==
X-Gm-Message-State: AKS2vOxzfjTc4zwdGyiW6KXpfKEiN0OumyKTvkJy97+/nI6SR/52iauK
        wdrnnH9iwHe1vCYt
X-Received: by 10.28.182.10 with SMTP id g10mr1672912wmf.115.1497945413236;
        Tue, 20 Jun 2017 00:56:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 47/49] clone: disable external odb before initial clone
Date:   Tue, 20 Jun 2017 09:55:21 +0200
Message-Id: <20170620075523.26961-48-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index dda0ad360b..a0d7b2bd2f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -933,6 +933,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	struct refspec *initial_refspecs;
 	int is_initial;
+	int saved_use_external_odb;
 
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
@@ -1078,6 +1079,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	/* Temporarily disable external ODB before initial clone */
+	saved_use_external_odb = use_external_odb;
+	use_external_odb = 0;
+
 	if (option_bare) {
 		if (option_mirror)
 			src_ref_prefix = "refs/";
@@ -1161,6 +1166,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		fetch_initial_refs(transport, refs, initial_refspecs,
 				   branch_top.buf, reflog_msg.buf, is_local);
 
+		use_external_odb = saved_use_external_odb;
+
 		mapped_refs = wanted_peer_refs(refs, refspec);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
@@ -1202,6 +1209,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					option_branch, option_origin);
 
 		warning(_("You appear to have cloned an empty repository."));
+
+		use_external_odb = saved_use_external_odb;
+
 		mapped_refs = NULL;
 		our_head_points_at = NULL;
 		remote_head_points_at = NULL;
-- 
2.13.1.565.gbfcd7a9048

