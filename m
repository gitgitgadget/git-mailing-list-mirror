Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D53202F2
	for <e@80x24.org>; Sun, 19 Nov 2017 11:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdKSLTz (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 06:19:55 -0500
Received: from dogben.com ([172.104.80.166]:60934 "EHLO dogben.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbdKSLTy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 06:19:54 -0500
X-Greylist: delayed 1089 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Nov 2017 06:19:54 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dogben.com;
         s=main; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ck+x7NH4CLcOeNEuNChxyukEb0F4wbOs/Aii4Y7eFYw=; b=Jrqj2y/EhNl3bIF2V7Hc0Kpq4V
        zZGx4PSPoNesu2FHuqFV6aJIeCXeqMhmvmeFSTocSefTkPxkX15p4Vizbhr+BYn5LcGbJgh3+pnf8
        IueBG78jS/NChXYaEIrU20tEcR9RUno96BsRsjlUa0zvQsyOOjjhjwgU9a/XWRQ5Q58eRs+6L2Xju
        1f0R47rg+Mku2iUp1aQrktg6d8FZUhteKYvDzbR0bgVcICzG/n8DFpXshIEOoTfFrux7ICl0fG7Te
        5F9J9kDlEUPURPSoZIScqrT47ovSLZALl42fpDxXBYvrC5xD7+09BRdIDfgaSo0UzjD71HUViVfim
        ZqWZ7Iug==;
Received: from home.dogben.com ([2400:8902:e001:30:e221:c60b:10c8:13bd] helo=debian-dorm)
        by dogben.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <wsy@dogben.com>)
        id 1eGNM6-0000QW-6L; Sun, 19 Nov 2017 11:01:42 +0000
Date:   Sun, 19 Nov 2017 19:01:32 +0800
From:   Shuyu Wei <wsy@dogben.com>
To:     git@vger.kernel.org
Cc:     pyokagan@gmail.com, gitster@pobox.com
Subject: [PATCH] git-pull: Pass -4/-6 option to git-fetch
Message-ID: <20171119110132.folfzddhdorb6wqd@debian-dorm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -4/-6 option should be passed through to git-fetch
to be consistent with the git-pull man page.

Signed-off-by: Wei Shuyu <wsy@dogben.com>
---
 builtin/pull.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index f7e2c4f2e..166b777ed 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -113,6 +113,8 @@ static char *opt_depth;
 static char *opt_unshallow;
 static char *opt_update_shallow;
 static char *opt_refmap;
+static char *opt_ipv4;
+static char *opt_ipv6;
 
 static struct option pull_options[] = {
 	/* Shared options */
@@ -218,6 +220,12 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "refmap", &opt_refmap, N_("refmap"),
 		N_("specify fetch refmap"),
 		PARSE_OPT_NONEG),
+	OPT_PASSTHRU('4',  "ipv4", &opt_ipv4, NULL,
+		N_("use IPv4 addresses only"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
+		N_("use IPv6 addresses only"),
+		PARSE_OPT_NOARG),
 
 	OPT_END()
 };
@@ -522,6 +530,10 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, opt_update_shallow);
 	if (opt_refmap)
 		argv_array_push(&args, opt_refmap);
+	if (opt_ipv4)
+		argv_array_push(&args, opt_ipv4);
+	if (opt_ipv6)
+		argv_array_push(&args, opt_ipv6);
 
 	if (repo) {
 		argv_array_push(&args, repo);
-- 
2.15.0


