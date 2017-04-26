Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A71207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936400AbdDZUVD (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:60044 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936392AbdDZUVC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:02 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mdrph-1dSaxl3WrV-00PbwQ; Wed, 26
 Apr 2017 22:20:53 +0200
Date:   Wed, 26 Apr 2017 22:20:52 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/26] setup_discovered_git_dir(): fix memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <ee39206e8165171c12ab8c5da9e29429b3aa166d.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+GACT8ZRf7z8fpz/sVJ2sW+Tlh9GmUjyppAMRdV8US9l07zRfv0
 fmvm00aWV0zd2m/xqv8Pg5OAgxcsM7dwV+IbTz4iCKeE2XdVMXyZqobiAWE9uDp/0ckMemc
 S02hy6TnOZzcIQWXB0xkAbgWmEjivBP6/8Pl3Db1v0EVU8dFB67yzOcKudds84bvEDGGz03
 VQPs9t1A1VVokHI26b6sA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AN6j7CmBF88=:Amgf2D5EA/Rv/h77uYshbu
 6VCmkPKwLXMC6EwSFZ/QRIIeGqtOuzJS4LWBIsHQzKzlsESnKDDidrG6MlNNUTnm2WS2ceGWz
 CQYzLCLt+LI4gasRFm7op+4qO3rfT2kTGZZTOajv/fTy7oh8jtineZrTHzEj/+dQ3S1C2dF9n
 fL0d3oZ3UJlifgRzoeCvASfXAv2Ay3+K6AnyPeg7osJPASx3ecoP+rf2P7RzoeKCzjfJ0w4as
 kRjqqY7d8Ucg5ljHmNzEHneKQBiOHVOHR9njnviA4Qjiv7tbtF7y5+M+LSE+26uB/msGzQUmA
 KaOAWk7xkT2ogBcOO4MXEhDwh7jJbULl3qbxPL5FYBOl1OaTi9L9yyOdBWEHMuCgUB16eBglf
 VnCy0QskER/67iYr79sCZDDyUIGCYEGlj38NF0Uaqa+x0R5aOIjKHHKhDTuefhAgNVWQpRaoV
 QRU75D+Q8PpWFAX1qeiAcGVvqWNfr/HnaIG7UEA3hgwBR3IS5PH9axQId9YbHq2UPUBx7vQaY
 YTLGlrq8kijjP2h/olVlpj27ImPNa5Q27XKRHtn3Qjrgyf/3SesDvY6g7vTNv+sbQVs0SeCAY
 qW0/47Ypq5frYNGroiSb1e+Mw16bBFsFrxGPK6D3E2IImmPJrgawXcGh0NlbLoOdRwwXz17b2
 aa8+qLwnwJvKGgP/8OCJIGpL71I4SLA4bIa7Tz023KBPSFihLjGyHGVnNjBm0/TNMOzORQTtf
 yNxeyzdXCN4+h7t79hMwyl0aQpvD0vzBJyOWVuqOW9XR7InQ4ORy+WUMCk41WEMILlhhzNY5X
 bWtXwqt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Identified by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 0320a9ad14c..12efca85a41 100644
--- a/setup.c
+++ b/setup.c
@@ -703,11 +703,16 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+		char *p = NULL;
+		const char *ret;
+
 		if (offset != cwd->len && !is_absolute_path(gitdir))
-			gitdir = real_pathdup(gitdir, 1);
+			gitdir = p = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		ret = setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		free(p);
+		return ret;
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
-- 
2.12.2.windows.2.800.gede8f145e06


