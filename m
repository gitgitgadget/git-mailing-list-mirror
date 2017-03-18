Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E192095B
	for <e@80x24.org>; Sat, 18 Mar 2017 23:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdCRXPK (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 19:15:10 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46252 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751306AbdCRXPI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 19:15:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 43014280B2;
        Sat, 18 Mar 2017 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872001;
        bh=VDRzm9rDcpMlVKT9VzC+P7AfyyS/Gd+ScXtF/5hft98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHL4Ne7y1mUiqA3m7VqpiNbEr4kDmMpTRQ5HK7/LvS3pupHfoefIdSvIaeIgDIC7s
         cLKXLH3Qj4QJayP+v7lY7T7DlTESDSW/vVYITTzZ/PgmuZ0SetejWwaZP79dtg+IwW
         VcUWVyD3sNJ9L0AioeXBSslInUggPodIu6m7hMTosqfYk3N8SAaasG46WS4xDdG5PC
         CY3+MQ6WyhL1usPO1AZwFB81gl+AGHmSn2+zMU5aH9lPMWkwal9PjYjUQiiupnoc5t
         +Qjz9ayJe3pKMHy+Q/KS82sZHpHVJFcI/dHwxF2Uj9O5KU8KOS//PBKdTX9kH9m8Ca
         ZJ0zQU+fY5BZ1ThzrxmVLb/qDTy1oC0IU8u7ciyD6EJWBmW1ob9R3WI35sDDuNBQLZ
         rBPlRpEQqeHcjRCOkS0+L8T9qtGlbdV2C2OH3BHQMyinBxIStvZIa5fzp1yW/2Xk0P
         07RwJIkwdISTgjK/9WfewYuoHslHk69jtN1pZqDl1qf21ulwrE8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/20] builtin/pull: convert portions to struct object_id
Date:   Sat, 18 Mar 2017 21:19:39 +0000
Message-Id: <20170318211954.564030-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
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
