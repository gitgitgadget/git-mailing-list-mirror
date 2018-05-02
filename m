Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCFF21847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeEBA04 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37674 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753393AbeEBA0b (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8EBA8609A1;
        Wed,  2 May 2018 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220790;
        bh=+Xmb/Hl91GQhU/zP7WH3DcYrIXR6H1VJSK6wBIyHKmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QU2SkbAYhXjPMpP755V5bmT1SHkCaCzdUGVmQpjs3A30bmpowQZ8OJAH/xwZLV/vr
         CTrrlBiGMYyvaLPmRI9CJCIeo0scTKIGyfE25Sg0uBDzNEZzlfBANoFRSmR8NW3kzI
         6o+7OtcN2fBgTliKNhI4ECCXghnOSIor7o5g+L/p/pNSAJ0BMQd7p1m3nByJhOJTsX
         0jzfAc2HXLlwk5QMRD94nOYszMHkjzd+PVDvPf8lzra9JllNyRWRjQtc6/nwS8WEQT
         g2ay50Y6wYDl0TuLwJQEt+ivJLgXtlYFO81TTzOqr7yoeYMKQ/C12SteFOrt9COYDm
         941IpiokLm7XxXT/vkPOB+os+dpstUFYF6hhLfPp1b8xpVm+sPC0Ygtgj+/1DM7Xy4
         TtdHhBYvh+PC7AriSgdkCjdax/Q7gpB/hryD7LGcGoCiD1qmN+TufMUEqyhPJrLIMJ
         6gNtgyjlV9mHldmXfyK8gqeXFocYoOzfxVHDA8zmIApYKZF0uLE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 10/42] pack-redundant: abstract away hash algorithm
Date:   Wed,  2 May 2018 00:25:38 +0000
Message-Id: <20180502002610.915892-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using hard-coded instances of the constant 20, use
the_hash_algo to look up the correct constant.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-redundant.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 354478a127..0fe1ff3cb7 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -252,13 +252,14 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 	unsigned long p1_off = 0, p2_off = 0, p1_step, p2_step;
 	const unsigned char *p1_base, *p2_base;
 	struct llist_item *p1_hint = NULL, *p2_hint = NULL;
+	const unsigned int hashsz = the_hash_algo->rawsz;
 
 	p1_base = p1->pack->index_data;
 	p2_base = p2->pack->index_data;
 	p1_base += 256 * 4 + ((p1->pack->index_version < 2) ? 4 : 8);
 	p2_base += 256 * 4 + ((p2->pack->index_version < 2) ? 4 : 8);
-	p1_step = (p1->pack->index_version < 2) ? 24 : 20;
-	p2_step = (p2->pack->index_version < 2) ? 24 : 20;
+	p1_step = hashsz + ((p1->pack->index_version < 2) ? 4 : 0);
+	p2_step = hashsz + ((p2->pack->index_version < 2) ? 4 : 0);
 
 	while (p1_off < p1->pack->num_objects * p1_step &&
 	       p2_off < p2->pack->num_objects * p2_step)
@@ -359,13 +360,14 @@ static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
 	size_t ret = 0;
 	unsigned long p1_off = 0, p2_off = 0, p1_step, p2_step;
 	const unsigned char *p1_base, *p2_base;
+	const unsigned int hashsz = the_hash_algo->rawsz;
 
 	p1_base = p1->index_data;
 	p2_base = p2->index_data;
 	p1_base += 256 * 4 + ((p1->index_version < 2) ? 4 : 8);
 	p2_base += 256 * 4 + ((p2->index_version < 2) ? 4 : 8);
-	p1_step = (p1->index_version < 2) ? 24 : 20;
-	p2_step = (p2->index_version < 2) ? 24 : 20;
+	p1_step = hashsz + ((p1->index_version < 2) ? 4 : 0);
+	p2_step = hashsz + ((p2->index_version < 2) ? 4 : 0);
 
 	while (p1_off < p1->num_objects * p1_step &&
 	       p2_off < p2->num_objects * p2_step)
@@ -558,7 +560,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 
 	base = p->index_data;
 	base += 256 * 4 + ((p->index_version < 2) ? 4 : 8);
-	step = (p->index_version < 2) ? 24 : 20;
+	step = the_hash_algo->rawsz + ((p->index_version < 2) ? 4 : 0);
 	while (off < p->num_objects * step) {
 		llist_insert_back(l.all_objects, base + off);
 		off += step;
