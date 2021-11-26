Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC205C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 11:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348679AbhKZLtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 06:49:50 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:51224 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351099AbhKZLrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 06:47:48 -0500
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id qZWhm5FMyCcoVqZWimUAfh; Fri, 26 Nov 2021 11:36:24 +0000
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=ebBDgIMH c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=WJ5fosVX2o5eYQUPKkoA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 3/4] diffcore-delta.c: LLP64 compatibility, upcast unity for left shift
Date:   Fri, 26 Nov 2021 11:36:13 +0000
Message-Id: <20211126113614.709-4-philipoakley@iee.email>
X-Mailer: git-send-email 2.34.0.windows.1
In-Reply-To: <20211126113614.709-1-philipoakley@iee.email>
References: <20211126113614.709-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLAI0pzwCuBTB7RxS8sMIs7Xd+1OVZrQCBt35fC8S14f2IFJhE6K0f4BbNBgN/GbJUHm4FSBeMOYzoVFl5rHrRVnDR77BGEeA8d1+3YW9OlE1k6oodiZ
 +NkAlvfGBj6Gl9PAjIhlAr9DGvdM/L4gl2ExI1pI3BWLK7SvDmUy8ag1SqlWQbiiMaBI6BCV9YX29hcMOwgH1y2WQvlgxEc+wlbzfKFq+CIpUVy/Bf2IHrsU
 uU8MwzgAqEk2DkZguozuC5XAoKMDn2rZnrf3sdcZRmc1JFo+K1So10LcDI3hvnsmB1N8omDtxrxm62Li7oVzUg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Visual Studio reports C4334 "was 64-bit shift intended" warning
because of size miss-match.

Promote unity to the matching type to fit with its subsequent operation.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 diffcore-delta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 5668ace60d..a4e86dfa38 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -133,10 +133,10 @@ static struct spanhash_top *hash_chars(struct repository *r,
 
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(st_add(sizeof(*hash),
-			      st_mult(sizeof(struct spanhash), 1<<i)));
+			      st_mult(sizeof(struct spanhash), (size_t)1<<i)));
 	hash->alloc_log2 = i;
 	hash->free = INITIAL_FREE(i);
-	memset(hash->data, 0, sizeof(struct spanhash) * (1<<i));
+	memset(hash->data, 0, sizeof(struct spanhash) * ((size_t)1 << i));
 
 	n = 0;
 	accum1 = accum2 = 0;
@@ -159,7 +159,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
 		n = 0;
 		accum1 = accum2 = 0;
 	}
-	QSORT(hash->data, 1ul << hash->alloc_log2, spanhash_cmp);
+	QSORT(hash->data, (size_t)1ul << hash->alloc_log2, spanhash_cmp);
 	return hash;
 }
 
-- 
2.34.0.rc1.windows.1.4.ga126985b17

