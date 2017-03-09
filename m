Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B717F202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbdCIWZJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:25:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:58685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbdCIWZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:25:07 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjrDd-1cEhgD39hJ-00bt5N; Thu, 09
 Mar 2017 23:25:00 +0100
Date:   Thu, 9 Mar 2017 23:24:59 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 07/11] read_early_config(): avoid .git/config hack when
 unneeded
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <2bd62f5bfab404b672b148e18502d00bf94d9e59.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PW7ay7UGkodp4ptEJd8ArMdbBwv8QaEay/36MQCe1/jU/baId5K
 Wl+jGid/yeSJ5/9lcxmxVyKZ583bJE75gxA0H1sG9XHJxWAwl3ef3oW5/ZcHi/NbagCqmKW
 FG7MLFr78MMhal6Mhw2P60lLxP1OYr+f01bVxnPlkUEqc64DVmQfbNOa6uGDX6R/H5Iofhz
 VZc0QFhSNhws0SGNFa91Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vITlpa1M+BU=:MCn9SFZkIsfc8l/yG1Vj9m
 Hn9ZQevCu8AtwvStf+3b5zt4Z4eFS/G/8g2rY6zha+0531PJ2qBU5qMc2jUB3wwbHfMFgjQIJ
 u8p5lKMTuKoiLVxuRL4vL98wfRSJm1EVRTzm76RbwBrrqEGkqBl10dhspIBvIE1rX+t6NH0nP
 0g52ae/eu3Ws6fAkQ/hIOxSjbmBfG2HyWaVfD/LmqSriqIsJJJWz4/y+83wVaKxliWwtgJD8E
 8z2KqKYrNMk5Mhmf0jJpJlr3CTMn8KTrYj6ArikBsiOxhgKqBv2+t8SCF2Sk6Me7uaI2VTD8c
 cavTCH/tXZRc8L8rRAhfalqCoPpZ3cqZp0ewRImwqaAzKNeOyAEAxGRpMXI/UF/dvmK8shGie
 okkW4riMWCyo+wYbuIE5tpqatc+rT2grXoxNmD5YGwaXzgovG8qcrDTRIO6H5yBr8Holy7tqw
 +AuD+T9d8rSRPBAyn9k/tUPGQAT2VtfarUnt30N2KbuuEJFrsfwCZJWEa4FNAsPbkCjOqwBeo
 tWUY5zjljfpN5wMNrAAAOt9Yk/m7Qq2SMemPWaJm6M/ajWaKbeDsEoJjuVUu/rU5nBOAx1b1N
 yLfWRfybN7ASc20cLP+BKLueshkAKfv0EAy2uHxpE0sns9Klw8Ul4c6ggrHioEOkm09wrJVGi
 deQ9sz65Sp65Hauqy5lSBuNcdPd0k15BbC+itsLk/jiW0iwPGSM65s9c4q7Kd12oaWjr9lDDW
 ADoLDsmTnx6XgV5jD66rfe7DZqAvmOUJVilfLbjtuKLfPtCS9jSser2sCEn4Z+CQCnn34ruqX
 xnqL+UR
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


