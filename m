Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6E3201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbdELWM3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:12:29 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39468 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932089AbdELWM2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 May 2017 18:12:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B752F280AD;
        Fri, 12 May 2017 22:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494627147;
        bh=xJpBWrChjptpp44a+27giQ+J/V3TS0EQtr1hKKWGF+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VacRyfPro2CqvY5uUcmFfiOEL22pUbCXcOX7nkYK9SapyJFwpxquwGgHglOBrGL9L
         BCyPgQxletaMQ//BWDhiWPDYCpIdYH4nooWas6d4K5spaOzCM38pTWx4aBF7/t+3Jk
         /X2q6dLzfKcxEHReXki+v/MdmhX/63c81tvZkG9WutZK45pghFdnrSzXIaP58/hgw5
         OJ20YiDLMGXpxLiQa4xL9vOMLxod1fnpbii/hf7mekcfO2wwae7mEksPjMNDkKlCTY
         kXU1zdEYvXP5q0T0L0QQRXVJLdhq+SLrbF0N/GpwVis7BRfF37+Irbqo7vhLcAh64v
         SdTRpSJ0xx9z7bqHbC6iX8+QTAT2/jflw35vdQffh15LgSL2HM0kEi0sWs0E+xr4/0
         he/pfQIUJggHSFhogQ6W22PO8HGzLUouP0t+koCmntDcbxtaMxpB3OTOnrCcimFL54
         LMVhkJi2aKc80pEc2jSPFKGAV+4F45feh29gmVTZ7XcEzfP5Mzy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] builtin/log: honor log.decorate
Date:   Fri, 12 May 2017 22:12:21 +0000
Message-Id: <20170512221221.406645-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277
In-Reply-To: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
References: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent change that introduced autodecorating of refs accidentally
broke the ability of users to set log.decorate = false to override it.
When the git_log_config was traversed a second time with an option other
than log.decorate, the decoration style would be set to the automatic
style, even if the user had already overridden it.  Instead of setting
the option in config parsing, set it in init_log_defaults instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b3b10cc1e..ec3258368 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -110,6 +110,8 @@ static void init_log_defaults(void)
 {
 	init_grep_defaults();
 	init_diff_ui_defaults();
+
+	decoration_style = auto_decoration_style();
 }
 
 static void cmd_log_init_defaults(struct rev_info *rev)
@@ -410,8 +412,6 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		if (decoration_style < 0)
 			decoration_style = 0; /* maybe warn? */
 		return 0;
-	} else {
-		decoration_style = auto_decoration_style();
 	}
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
