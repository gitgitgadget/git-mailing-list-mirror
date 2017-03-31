Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B00020966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935139AbdCaBk6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59226 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935048AbdCaBkJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:09 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B19D6280B2;
        Fri, 31 Mar 2017 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924407;
        bh=VDRzm9rDcpMlVKT9VzC+P7AfyyS/Gd+ScXtF/5hft98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ufa2KJkv1MAu/2xQPqz9P5Cn2UP0L/Drex5zLxktlr7aGdLAMDYnnrF+sbRfih85d
         gI3cvDVpYMLKCOfwuWIRTjbcZVBcuhUoJH24IQZUBTM9gx0IiKmr2WNTtiJ7i1mbhO
         HdF8skfjwcpY5dGQ1to8u8Q5uDKYoYWSpxEstdune+83vKiqxjENmNY/5yPr5gIpPH
         p5iRp+Y6kQp6kK+QHypm+I/cocXaFPRaYvVhAlk/SvldZ2fArxRebKPBmq2XMDduBq
         osqFV2dcU2bnaWGHKQAZnJgL17TIBP3oSK6n/M6/+4rwBkzfCUmeavxV++Rin9tYTp
         i5ha1Le0tiAbwEqw3TM+Gfb0IGSBegsaFHgI6X5FKaem7Z6LXoO/ltT74VVHheMUGE
         KouHX9nM8/GCz19w3rGdO4hoQCdJ9m5vDZFJytc6N24xezWErATBFHNPYevvlErmfu
         R/9/gDWEeqckRuBWzOV+PIh88v8TKO2yV86fd70SDP4sjM1+gSZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/20] builtin/pull: convert portions to struct object_id
Date:   Fri, 31 Mar 2017 01:39:46 +0000
Message-Id: <20170331014001.953484-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the caller of sha1_array_append to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3ecb881b0b..a9f7553f30 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -335,16 +335,16 @@ static void get_merge_heads(struct sha1_array *merge_heads)
 	const char *filename = git_path("FETCH_HEAD");
 	FILE *fp;
 	struct strbuf sb = STRBUF_INIT;
-	unsigned char sha1[GIT_SHA1_RAWSZ];
+	struct object_id oid;
 
 	if (!(fp = fopen(filename, "r")))
 		die_errno(_("could not open '%s' for reading"), filename);
 	while (strbuf_getline_lf(&sb, fp) != EOF) {
-		if (get_sha1_hex(sb.buf, sha1))
+		if (get_oid_hex(sb.buf, &oid))
 			continue;  /* invalid line: does not start with SHA1 */
 		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge\t"))
 			continue;  /* ref is not-for-merge */
-		sha1_array_append(merge_heads, sha1);
+		sha1_array_append(merge_heads, oid.hash);
 	}
 	fclose(fp);
 	strbuf_release(&sb);
