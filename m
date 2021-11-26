Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A3CC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 11:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348544AbhKZLts (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 06:49:48 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:56352 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351088AbhKZLrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 06:47:47 -0500
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id qZWhm5FMyCcoVqZWhmUAfT; Fri, 26 Nov 2021 11:36:24 +0000
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=ebBDgIMH c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10
 a=acTyJGYzDTWRqCFSA_0A:9 a=QEXdDO2ut3YA:10
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 1/4] mergesort.c: LLP64 compatibility, upcast unity for left shift
Date:   Fri, 26 Nov 2021 11:36:11 +0000
Message-Id: <20211126113614.709-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.34.0.windows.1
In-Reply-To: <20211126113614.709-1-philipoakley@iee.email>
References: <20211126113614.709-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLAI0pzwCuBTB7RxS8sMIs7Xd+1OVZrQCBt35fC8S14f2IFJhE6K0f4BbNBgN/GbJUHm4FSBeMOYzoVFl5rHrRVnDR77BGEeA8d1+3YW9OlE1k6oodiZ
 +NkAlvfGBj6Gl9PAjIhlAr9DGvdM/L4gl2ExI1pI3BWLK7SvDmUy8ag1SqlWQbiiMaBI6BCV9YX29hcMOwgH1y2WQvlgxEc+wlbzfKFq+CIpUVy/Bf2IHrsU
 uU8MwzgAqEk2DkZguozuC5XAoKMDn2rZnrf3sdcZRmc1JFo+K1So10LcDI3hvnsmB1N8omDtxrxm62Li7oVzUg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Visual Studio reports C4334 "was 64-bit shift intended" size mismatch
warning because of size miss-match.

Promote unity to the matching type to fit with the `&` operator.

Signed-off-by: Philip Oakley <philipoakley@iee.email>

---
This is the same fix that René Scharfe provided in 42c456ff81
(mergesort: avoid left shift overflow, 2021-11-16)

Use size_t to match n when building the bitmask for checking whether a
rank is occupied, instead of the default signed int.
---
 mergesort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergesort.c b/mergesort.c
index 6216835566..bd9c6ef8ee 100644
--- a/mergesort.c
+++ b/mergesort.c
@@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
 		void *next = get_next_fn(list);
 		if (next)
 			set_next_fn(list, NULL);
-		for (i = 0; n & (1 << i); i++)
+		for (i = 0; n & ((size_t)1 << i); i++)
 			list = llist_merge(ranks[i], list, get_next_fn,
 					   set_next_fn, compare_fn);
 		n++;
-- 
2.34.0.rc1.windows.1.4.ga126985b17

