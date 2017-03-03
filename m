Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE5720133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdCCRdg (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:33:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:63482 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbdCCRdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:33:32 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9KR0-1caT9930kY-00Cjcp; Fri, 03
 Mar 2017 18:33:25 +0100
Date:   Fri, 3 Mar 2017 18:33:23 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 7/9] read_early_config(): avoid .git/config hack when
 unneeded
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <a6cb213746f455adca3ce006f771f4f77b969da2.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p42re2jPbk2PPjzYdRlxokW0tBLDR7LE8vJwbW9Y7c3mNogvkTR
 sK+62daIZT1RfR1GGmmdqIrpFHpBn66ztOwCA0/9imuJPqYPJBpRuOLzb4Jiqbb7AP3vVwd
 FoUtHHewoQYTHUj4lev0zZwX9rxEPgBzf2b/LuWkL7OrOgeKpahBgWt4iyHs//bvQQKH4tN
 Wn8aJW6yPZJqRfy3/xReA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z+FBaWqZ0Ek=:KJrT7QIHaPRpgD0YeOw25R
 zrNjEv/IjH2W0O0kcPLpglRnGmhpRkE0Dpy8hymAgd3LaDEc8NvFIl5f/aTQZT4GX8Izz6Ut1
 dMyudOG3nnNsMXx3NliwVnx3FMLUwlkYj4eBrxjMum8kSGKJ54ke+zkc3eFVDZEqfuP2isfCx
 BL973OTnSkjCR27ppRwtDLNRhsoQfAot0c0G1R2kHRtWQ79gmhShDQxNYCOTmC5b56T3zurfI
 2kDOmdYAZC2xzVwqpI2QtQPdzju/qv1iXIxUjP5Po0pnKBWyhuTO7Fi+6bf/t5PN3IFxNLjEq
 kLr/AL4KXS36juwDk4eiOqBEO5hJOl18MjuyWCSSbKVqFT4JD82czHmc3HyfVqwYzTIVAJ/3R
 qw1MM5YTv6j9OsIfbDEk9egrpfWRYJos/6RxzW3RD6cj9uJw1JYW7nKx6t0KWVhZZhpd7IcEJ
 dNsUSNBJExG5vhfFzeiRAl7JX5ejNRyBZDCr/ecCZV0eBUmiAjkRNKJtizsgzAlFTUxdW+u2x
 GJRGnwFlQ2hspn5cMrw8YL12g1druMOP3RCD5rG85hbgmKNrPa21G8Gkpr957dWdFbt0O97P1
 LdZ9dNzxgU/8/GO1kE0sCfCCXC+hnQcfaxOFrfzRsOR9rTq/A3is2+WDkZsEgzdiw8PJEAlO9
 6ZBOMj9h3V+H7ywa42ggjEeDmOf8zaYyyS92TFegUvgNdRFiETp1ZU2d+aGaX43+5toq/Y0qQ
 KClDF6S86qWdBMn4WeJkOx76z3bNsHpfrTGWoNF4h19cePk04HDkW9B8xAQTx8HUIhDmW6kLG
 0EH14mF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far, we only look whether the startup_info claims to have seen a
git_dir.

However, do_git_config_sequence() (and consequently the
git_config_with_options() call used by read_early_config() asks the
have_git_dir() function whether we have a .git/ directory, which in turn
also looks at git_dir and at the environment variable GIT_DIR. And when
this is the case, the repository config is handled already, so we do not
have to do that again explicitly.

Let's just use the same function, have_git_dir(), to determine whether we
have to handle .git/config explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 9cfbeafd04c..068fa4dcfa6 100644
--- a/config.c
+++ b/config.c
@@ -1427,14 +1427,15 @@ void read_early_config(config_fn_t cb, void *data)
 	 * core.repositoryformatversion), we'll read whatever is in .git/config
 	 * blindly. Similarly, if we _are_ in a repository, but not at the
 	 * root, we'll fail to find .git/config (because it's really
-	 * ../.git/config, etc). See t7006 for a complete set of failures.
+	 * ../.git/config, etc), unless setup_git_directory() was already called.
+	 * See t7006 for a complete set of failures.
 	 *
 	 * However, we have historically provided this hack because it does
 	 * work some of the time (namely when you are at the top-level of a
 	 * valid repository), and would rarely make things worse (i.e., you do
 	 * not generally have a .git/config file sitting around).
 	 */
-	if (!startup_info->have_repository) {
+	if (!have_git_dir()) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
-- 
2.12.0.windows.1.7.g94dafc3b124


