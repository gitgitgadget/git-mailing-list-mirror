Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABBCB2013A
	for <e@80x24.org>; Tue, 14 Feb 2017 11:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbdBNLdQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 06:33:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:57529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbdBNLci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 06:32:38 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbgWb-1cwVlz2zDx-00J583; Tue, 14
 Feb 2017 12:32:30 +0100
Date:   Tue, 14 Feb 2017 12:32:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] name-hash: specify initial size for istate.dir_hash
 table
In-Reply-To: <cover.1487071883.git.johannes.schindelin@gmx.de>
Message-ID: <b30c0a47b84c063cefb7a8164dd766e251433605.1487071883.git.johannes.schindelin@gmx.de>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Yrz50DqVQ3AFy2/KXltBd55eZlmqfW0TNytlVidhutGHCukQasW
 Mk56pcrDcONn6IOpDQ+uRCSaezrtnhmPIN6tvIEHHTpX0Ve4pylaVBpp1KZyHe1mxAzuIvt
 ZNtgj0QtV77qYms5rHl3Ui2kLp4LnoRz7ColekB41ho6qObpoQOpfmCkn6IAw1GylH3hk/P
 Ok/hkwjfAuvy0vSplFqLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WdFelaxyz2k=:xt+HzGUf+Wgp3KbM23Y3Wv
 DJmY2IHilaVTpXsforYTSQjrFXKPxg7TFOatLNOlkBRW/4kecGxlkCLONIfgV+tyssWvlZdfS
 +WmMtQCtuQivut3phhmZgimgTYWg1H/vsvT4UuDRB2gCWaVEgasTOF4uBu/kvP1G8+aoBIjxD
 HF7uQm1KEefMOz9kMZZX+9AuoTfgrY/zADnPTVDt5ysQ/MQkraALYDmsT8RA6ykwiB/Szw+rY
 119QqFWpBAG1+cGICsKIH3xvL4JtAf1UX+Iin1tmoUPtMbXygSmV1YOEzbNpb8SMNE7HQY899
 tKyyI2eD5dEeS7ggKNtFGmw4XfPU6N8WU2B9vZ1xPDNdOok0n2byiHHCwHlMmiOQymllMw2YU
 F4ideVPdKgv2MHW9OgkiCZJz3/gmqbRcA3XPV0KD8OF/B/h/b6wqX4v/cQwxOKqkAeAeNCe51
 o2vHZ83BD5kII7kUBoSOaLH7/QwyD8C0d/pOzoeBIyjLPihZQpMBtvTQEnRG17/Ot6AgSa5HM
 wJGFvAD3e76sp7ZNQDRpNLS3bU4sT7df2DJJw/mUK5huzZEMQqqcqg9HVjiRambAv0zH/3VWo
 VEymqVXB5st6BVMSC0mazgpdmzgyd+jp/aj1CNrIECKKXw5q1LOYCcxNw5r4Gt4AFGMAFHO2r
 Ss8NAqYZLAFOIa06KY+FNk8olJLBrVjcyUNRr0b7iGGTtF515OdhrN2OP3MOwPclx2Yy5Ssyb
 JE3QRYxHIu7IB8f1eWUMOunx1mo8qaAvgZOkLdw0Ub4oSYFlYsLVtBjhajAaTKfWrEiD9Bu4D
 Wp0BDR9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Specify an initial size for the istate.dir_hash hash map matching the
size of the istate.name_hash.

Previously hashmap_init() was given 0, causing a 64 bucket hashmap to be
created. When working with very large repositories, this would cause
numerous rehash() calls to realloc and rebalance the hashmap. This is
especially true when the worktree is deep, with many directories
containing a only a few files each.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 name-hash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/name-hash.c b/name-hash.c
index 49eb84846df..8f8336cc868 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -143,7 +143,8 @@ static void lazy_init_name_hash(struct index_state *istate)
 		return;
 	hashmap_init(&istate->name_hash, (hashmap_cmp_fn) cache_entry_cmp,
 			istate->cache_nr);
-	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
+	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp,
+			istate->cache_nr);
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized = 1;
-- 
2.11.1.windows.1


