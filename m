Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E39D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbeDWXlX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60688 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932776AbeDWXkk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 121FD609A2;
        Mon, 23 Apr 2018 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526839;
        bh=f44NXOZA6rTGWVl9afVAzJVYUTyi6ohbBRxeRXJ2mj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=F9qrirtnvMCj/sGuPbcZbfK5yB2cdymaxRVyUDBHdgKi1k63rJxk7qAy6yhhISsBn
         ZoiBd9LwgJ+A9HYa2qydhUOT0gGwwaau8yFL5kCnlU65MH0HlSFiKiF6Uj3riGBidi
         JrbYJrZWq0gyv/mT4V2Du1PZYf7y6WDGjvhQKacKqHJ2hRNBZore0B+ZZ9/vEnPd/g
         NlofMhME0+DvEW/9uDTjr000IN8KyXNynRcfypyXnayMyJY4KGVxmeUwFDTGziZ/il
         uQxTcHbQl6rBXfiNnhoKFCj3nZrE0/vh2CeNaBBwHo8aE2MNM9plpNAbsinkhV6pUr
         tPxY6EAC7+LJb+u+vtN8LQKEKvhauK0vptPC/CcjJ9wwzaxYWsYh2VnCdXHeTqR8sB
         TDlqPoA7h2yEtlGLAW35R9HPC7BqXAS1Vyzh2+ds6Ui/+fJXtGIlL2ZnrcKUYry1Pe
         OT+w6Zta9Lvxc2FKN1i0futURVtMDOM0pzmro66zp5TiCD7ASY6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 31/41] wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
Date:   Mon, 23 Apr 2018 23:39:41 +0000
Message-Id: <20180423233951.276447-32-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert two uses of EMPTY_TREE_SHA1_HEX to use oid_to_hex_r and
the_hash_algo to avoid a dependency on a given hash algorithm.  Use
oid_to_hex_r in preference to oid_to_hex because the buffer needs to
last through several function calls which might exhaust the limit of
four static buffers.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 wt-status.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 50815e5faf..857724bd60 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -600,10 +600,11 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	char hex[GIT_MAX_HEXSZ + 1];
 
 	init_revisions(&rev, NULL);
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
+	opt.def = s->is_initial ? oid_to_hex_r(hex, the_hash_algo->empty_tree) : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.flags.override_submodule_config = 1;
@@ -975,13 +976,14 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	struct setup_revision_opt opt;
 	int dirty_submodules;
 	const char *c = color(WT_STATUS_HEADER, s);
+	char hex[GIT_MAX_HEXSZ + 1];
 
 	init_revisions(&rev, NULL);
 	rev.diffopt.flags.allow_textconv = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
+	opt.def = s->is_initial ? oid_to_hex_r(hex, the_hash_algo->empty_tree) : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
