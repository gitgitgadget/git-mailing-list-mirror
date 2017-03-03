Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E332013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdCCCEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:04:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:55710 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbdCCCEu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:04:50 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpwZn-1c7ozZ08EJ-00fg3F; Fri, 03
 Mar 2017 03:04:30 +0100
Date:   Fri, 3 Mar 2017 03:04:28 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 7/9] read_early_config(): avoid .git/config hack when
 unneeded
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <db619060d18df21f3259653a52cd79f704b34566.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p4nAfpuwoC5fUis3S1oq5+OTxd2p55mEWxGIsOYyNuSJidmB5NU
 JcN/cymdQ950WHHq7A9Jdodip3V9rSrHSuo5zMWfJD3CIQIPLZZecgveQ7bVj2yCKs7ND8v
 4uHZtumPuWsnnZ4HQuGCB7kaJmbpdiXWkJ8z7WVy5RsquFHIsD6S/V91enw8OyWedEWDc7A
 VqpzSmfbpF1t20iifVqjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wo6HTqbUBvc=:jh1RDx4avC/M5N7QmMmfvs
 nDzvxWvSyMno62xlAsnyrUK+BIGJbdTs3g3DmU+clcBZp9XSg07H2CxJwV4KcstcXwu0VjQuY
 2TLzUGZMRd2Bubf7UkhHRi/rENuXLE+OZsPfjkaaIgu0RO/s7zzO6qZ7eO2LdDYyZNl1GVEYD
 hOyTja6vGftMQmE9+0Ci/8e/Wzhds4/NRPk4OVQ6rrX44WOyfAiuTx90uAlN6431T0OX8eq3D
 g9c8/sSMCvaGLCIuN0AS5qo6M2IUCosX05h9e0N77k91ZBSq4HhvF8rbYA9fqvXcwDSfBpjJF
 fewgpo8p7KoLjfjvauD/pmI0VacYPt8ooMqg8Os4RRVEctpjsq2RievZ7UiPhhxetbXRsbyZI
 M//LQkyXyW9QGpVZRm780A2NsSmDb7pSOp2I8t9/uflfyOMoAuJGyhwMPEkMnCX1mzquBHrA7
 ZVGZUd6B7fHiPgVEqYgmYRpVeYUVnszDh9C8bi3r7i9PJChkNUg1Ers8GlEYkf7VkJB0pj/RN
 8ZjxBpm+rPQXmwgq1CMTITuO9o7ru9XU12Gr9sNw9MeEn32gqW5+vLfi7JDYwNY7nX7KXh8/q
 tqmGtTFsu2MPV2RarW/VjrS6bxIyqxiJlM/eEBmB0mx3VICVlnLYFNG2UYN6axiCaOVsm8qXi
 Ib580m91hbcfxihPcKFk1cwTTtcGmtZFN7oLGOSjqL9g41ijMhKq2D8JlHSp2T7OTVd59j+Z+
 3O3Q+ypsTmXKV82/r0n7WZfA48GOpZPrRUD0X46GPVC6KccGDBj81xz5BCoHjiixfaMgBGonK
 t2yNwg7
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
 config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 980fcc6ff2e..3ee5e5a15d6 100644
--- a/config.c
+++ b/config.c
@@ -1434,8 +1434,7 @@ void read_early_config(config_fn_t cb, void *data)
 	 * valid repository), and would rarely make things worse (i.e., you do
 	 * not generally have a .git/config file sitting around).
 	 */
-	if (!startup_info->creating_repository &&
-	    !startup_info->have_repository) {
+	if (!startup_info->creating_repository && !have_git_dir()) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
-- 
2.12.0.windows.1.3.g8a117c48243


