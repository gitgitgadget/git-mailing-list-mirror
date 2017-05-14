Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C12201A4
	for <e@80x24.org>; Sun, 14 May 2017 18:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754719AbdENSBG (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 14:01:06 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39946 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751268AbdENSBF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 May 2017 14:01:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 21483280AD;
        Sun, 14 May 2017 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494784864;
        bh=mL51cBiY+T8upt8VIEedADUyeHqR0nBVGPjl1k1+Xec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUhHFTkPfBzFLuMYeWQFONCZzq9ikU4wyavCVBdd6KtcAVlBA+ErGNriNHOokfT/b
         134lHZgg41KCNQI4ZTtKG4Uc7LvYniXtkpmZRBP8CBgYqUenRAPIZMjtTHhGDWQhql
         9Rn4t/4iprSKrOtFtThCLJccTihvTYwvIz+dN5SpXrLnjCuloy4P+Q/LMwBqRVP8b1
         Cm6wKslbbyazLvyWbnge29dqwAoA8jDD9IzYLh+AzZ9MscpK7zLKomWAetto9gAEPY
         rKPkpi4RxiXngxMWULhnHi4JBGn10xNuW+qEkExX96Gc+7lb3gb5jOJrXVu9Sjn1hn
         bFJNKtYKhz5ZBnFwW/Lp+nbPbQXY9Xy1nFpnuF72GtmwPbe9UCu/E+UgaLx2dcHFTW
         rSAmOMpmK7DA/ZBqjHCbGwjLJ4NU502yg9GHlT6xiSwZcDdwov0uUk5yuztp0fB6v7
         0GVhHUmk0dCZdpzfImXLpQeMRxkbBQoU1aMLcbyp1elO3KXPsaN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] builtin/log: honor log.decorate
Date:   Sun, 14 May 2017 18:00:58 +0000
Message-Id: <20170514180058.842315-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277
In-Reply-To: <20170512221221.406645-1-sandals@crustytoothpaste.net>
References: <20170512221221.406645-1-sandals@crustytoothpaste.net>
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

Add a test for this case.  The actual additional config option doesn't
matter, but it needs to be something not already set in the
configuration file.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v2:
* Add a test.  I tested that the config parsing both works with
  additional options and also can be overridden from the command line.

 builtin/log.c  |  4 ++--
 t/t4202-log.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

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
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index f57799071..1c7d6729c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -577,6 +577,18 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
+test_expect_success 'log.decorate config parsing' '
+	git log --oneline --decorate=full >expect.full &&
+	git log --oneline --decorate=short >expect.short &&
+
+	test_config log.decorate full &&
+	test_config log.mailmap true &&
+	git log --oneline >actual &&
+	test_cmp expect.full actual &&
+	git log --oneline --decorate=short >actual &&
+	test_cmp expect.short actual
+'
+
 test_expect_success TTY 'log output on a TTY' '
 	git log --oneline --decorate >expect.short &&
 
