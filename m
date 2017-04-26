Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4D7207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966775AbdDZUUx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:20:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:64175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966731AbdDZUUv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:20:51 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcEPJ-1dmTIV0ebF-00jZCt; Wed, 26
 Apr 2017 22:20:42 +0200
Date:   Wed, 26 Apr 2017 22:20:27 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/26] checkout: fix memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <be7ff5f9b303bb42f0d2a6c8f144bcc8342450cc.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EKLpvIBx0HkXCoUXmC1hvE+hKRJrhGzTb68IJYnaB1J+b30pId3
 QTO65kHjJ6vD8njecaeoBH6i62BsvFHA4liISK1DF0u2o/Ny3i9pKX1lt11uInrTs9l/pD5
 HxbsY2NzU24eGMWNmDmWLytZ75djPb51IBxTPHyU24Wmq1JMapqj3nzN/HuCK7HrSZRFHRB
 qIWl7RnveS2TdWQ33YumQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n2+d2E9dVrM=:CtcnClsEse1EgvHw+cu3gI
 xJkh6W+XBwGKjXuNckwB+pRsOucBL5Od1d1xa1BQeFOQ+O+upVRpf9YTec5N3bwp23n7L4UTV
 qG1tQH591R8DfwMsgcss+Xh6ldaalHVfT5V8nqdP/AIFpq4w/Sj2HIF6npedIkimBJ7Q/jbsr
 UGXlaLDRLAx2QTaZ0FyiLHcOA8qQzLgef4HVmLmR6+HBxMKw8WBR30DznUYC4pLup/iqGe0Yu
 VWYAJj8ilFMfgEZLfOjOL/IwOffYZFwE3nPSlULgIOBSvB5Bdn8O6uNpP8eL4c/UtGLM/6lfO
 ZXPUfJadMY7KOhfn8dpBoh8PM1ElqYk2UAWqGOCexk0tyFrfOswI6e50lX1uOpV+W1f9WCCFp
 KTJmR34aKSBluz62e6fKhmK+MTg1ep+nR4gtGqp5c7zxppgMxzviID3ukCebCIA6CP5jAGzI6
 f//flJ2QJcL4t4A9CEDY3EDcHUahtkCUacqKyH5nwOl9C4IzHGfQqHm3xPrrF+7JjwBcvW98L
 7Jyk2mGah+vKZ8Q6FM/D6CLBIqzKvErLnJpB8FxgI58pjUocF0lQTlbstzOfo15QRHard0oJ6
 HASVM96MmPjnjIZPb2zepgIW46rJ+K+veMYLEg4LtZvLymxHfbI9ubGlaIsj317we5ZG9a/hc
 +KJm+64M8FjRsulp28JiG0w9KuXvBBjQ30BJFgxGEujsIfivk+o0bvcCVonFQG6lhWrbBV+nO
 uuA5qFi7jksDin5YTy6kAWyINmD5h07GE3Hv+RQ7vzPklxkIBBb6BP5hYQynJEB9ML25OcfGm
 0UH3zhH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discovered via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f335..98f98256608 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
+	free(ce);
 	return status;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


