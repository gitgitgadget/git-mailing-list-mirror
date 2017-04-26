Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0900E207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbdDZUUb (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:20:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:58203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754291AbdDZUU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:20:29 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVedf-1dbytD1o35-00YvPF; Wed, 26
 Apr 2017 22:20:24 +0200
Date:   Wed, 26 Apr 2017 22:20:23 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/26] cat-file: fix memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <a1381df96c940f1edf5b7fb0c49abfc7b12b72fa.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Hsus18tiPqd7Hikk+AeOrPi3sU54IiX6lXN8mP2j6w4BYefJcdK
 +QYTJcTtbQgXkZvGashJ/x5ElPcnzWxV+mK90XsClT59YZAKQQbbawTmEDC57zO44hGaD7n
 FjmVvrOp80nOkq1JOMQI1L+gdxsaqzZ3mG838eOJXPRdy0mMfCdp/QesRI+IOwC5gHHah63
 ToX0N91IwZH2INLg5olMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jMUH9pYsB40=:bnApNECizPk720GK3YV50G
 8kXlWSrGAidRx3fKhgvHufgSHwmdfRyXYCOwJwnlwFcnV67fvZ+PM6e67qZVZQB1jI6S4bA7Z
 EczFK9HHnoXE1QY+wxCee4mz448Y09R3m5vRuM4RGiX/viUzTfEClZqg0IokAss3Mc5+Xw/4W
 U4UdVtMXvoXsoH2exuQ2YGx4/SjNqFddqQc4vjY7fYkxPA6s6SPW3u0u4+VhIZ57L3sRZJLLg
 qPxWsYRThjQVBHhxIvM8Vv8BwSiNh7TwdjUfDJqKZav5lGZLiM/56knuQWBKbB/uXQwmplGsN
 aXb6zZBoc4FhNJoUKbYKy1hCmcdY86MwHBSS4h0tJvImXdVWrU7mFPLnD/bi0tEjZjCA12AWR
 C/KzFZB7vB4bXJ1ijV/xpaqVp3s+G6t1HSZ+vOANaYRfpYzm5O/1SFTNmwQDhrbSW+JBUrDkw
 XPjrr0u0oZAyu4SFKfeg3Tm3C+46+AMyhgo+ctT6D6fOE5BKW/sTA5iRQ/kArgCz4C+qpyXAS
 4eyf+WmLEjFEfz2NHqrXiaZTxb+Yl33c+dUJPqj/icMV/ZkqmZ59Rxz6CNBtn1l+wf7mRYHFE
 G149Lr/KB6IbX3FdOYiC7Sa23oxXaL/2pzYcL158tgYC7bJfEdrQidB2nhNmk6Frt0gtYlxkD
 nGnJ1+8Frgmi/jhyX3nXQ4SwGOjWgCRM3lX0SEHbGG7GA0a7nEdYZP/d4aLTrK3nggP0E8QB1
 cJDC2dy7Z/ZMxKLdvgnH6xaw9EvNxnASpY485hxKX5qo8HEapxf/07ctOcrXZtraeemOPjxdM
 5QeNUjr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/cat-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1890d7a6390..9af863e7915 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -165,6 +165,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		die("git cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
+	free(buf);
 	return 0;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


