Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDCEC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 00:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbhLAAce (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 19:32:34 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:54226 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbhLAAcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 19:32:32 -0500
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id sDUkmByoui2JdsDUlmSxSD; Wed, 01 Dec 2021 00:29:11 +0000
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=f5U2+96M c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=WJ5fosVX2o5eYQUPKkoA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 2/3] diffcore-delta.c: LLP64 compatibility, upcast unity for left shift
Date:   Wed,  1 Dec 2021 00:29:01 +0000
Message-Id: <20211201002902.1042-3-philipoakley@iee.email>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20211201002902.1042-1-philipoakley@iee.email>
References: <20211201002902.1042-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJv0mkEJH6WFtvipohfcVGaGRmyJraCNt0OKuvydpXvsJeDQEsNJGXEdCZxqIqaqoJjbB/2MSVD4Dx+UN17yqf72W//fDTGLFBZ/5W1eiA839JbI+2s/
 y2P+SALAGxBL6TlC4IyHCW58xNDuzxelp2IUHp1Eb/qV/45pDaxPQLEj03iH1zYWlUVBrqVMvt2ZgAjHwrHeKmiOE0qtmdlGhnb2jJqQx0bHPrm48HnmVeMJ
 U6EXWJ2jZ4SzFLf1uKrxjI9YyYWtssucOKszfrBzSbrzD5Yn98XBY5kt2Z6XqzAVWLWiaZKerZetRQo5aEoOpZTheItUqRT4qAWuaaljRz5XU1E9MEBobLLi
 H5C6M19t
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
index 5668ace60d..18d8f766d7 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -133,10 +133,10 @@ static struct spanhash_top *hash_chars(struct repository *r,
 
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(st_add(sizeof(*hash),
-			      st_mult(sizeof(struct spanhash), 1<<i)));
+			      st_mult(sizeof(struct spanhash), (size_t)1 << i)));
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

