Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3751F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfHRUYz (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:24:55 -0400
Received: from mail-gateway-shared11.cyon.net ([194.126.200.64]:59338 "EHLO
        mail-gateway-shared11.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbfHRUYz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:24:55 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Aug 2019 16:24:55 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared11.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1hzRcS-0008Cr-TF
        for git@vger.kernel.org; Sun, 18 Aug 2019 22:17:52 +0200
Received: from [10.20.10.231] (port=46394 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <bb@drbeat.li>)
        id 1hzRcQ-0005GV-B6; Sun, 18 Aug 2019 22:17:38 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 5D87A1800F9; Sun, 18 Aug 2019 22:17:34 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] grep: under --debug, show whether PCRE JIT is enabled
Date:   Sun, 18 Aug 2019 22:17:27 +0200
Message-Id: <20190818201727.31505-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This information is useful and not visible anywhere else, so show it.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---
This applies on top of 'ab/pcre-jit-fixes', currently in pu.

 grep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/grep.c b/grep.c
index 9bc589720b..96272b3cfc 100644
--- a/grep.c
+++ b/grep.c
@@ -433,6 +433,8 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
 #ifdef GIT_PCRE1_USE_JIT
 	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
+	if (opt->debug)
+		fprintf(stderr, "pcre1_jit_on=%d\n", p->pcre1_jit_on);
 #endif
 }
 
@@ -534,6 +536,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 
 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
+	if (opt->debug)
+		fprintf(stderr, "pcre2_jit_on=%d\n", p->pcre2_jit_on);
 	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
@@ -559,6 +563,9 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			BUG("pcre2_pattern_info() failed: %d", patinforet);
 		if (jitsizearg == 0) {
 			p->pcre2_jit_on = 0;
+			if (opt->debug)
+				fprintf(stderr, "pcre2_jit_on=%d: (*NO_JIT) in regex\n",
+					p->pcre2_jit_on);
 			return;
 		}
 	}
-- 
2.21.0.1020.gf2820cf01a

