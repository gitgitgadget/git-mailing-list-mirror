Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BF3C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 11:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348295AbhKZLts (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 06:49:48 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:48544 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhKZLrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 06:47:47 -0500
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id qZWhm5FMyCcoVqZWimUAfo; Fri, 26 Nov 2021 11:36:24 +0000
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=ebBDgIMH c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10
 a=qW9_nJxYNLE7NW8Q08AA:9 a=QEXdDO2ut3YA:10
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 4/4] object-file.c: LLP64 compatibility, upcast unity for left shift
Date:   Fri, 26 Nov 2021 11:36:14 +0000
Message-Id: <20211126113614.709-5-philipoakley@iee.email>
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

Visual Studio reports C4334 "was 64-bit shift intended" warning because
of size miss-match.

Promote unity to the matching type to fit with the assignment.

Signed-off-by: Philip Oakley <philipoakley@iee.email>

---

This cannot be applied to the maint-2.32 branch as the earlier René Scharfe
patch had been, because the original sha1-file.c, to which the backport
would apply, has been renamed in e5afd4449d (object-file.c: rename
from sha1-file.c, 2020-12-31) which was merged in 8b327f1784
(Merge branch 'ma/sha1-is-a-hash', 2021-01-15)
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index c3d866a287..da8821cb91 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2425,7 +2425,7 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 	struct strbuf buf = STRBUF_INIT;
 	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
-	size_t mask = 1u << (subdir_nr % word_bits);
+	size_t mask = (size_t)1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-- 
2.34.0.rc1.windows.1.4.ga126985b17

