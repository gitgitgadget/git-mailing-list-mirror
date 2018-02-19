Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3521F1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932308AbeBSXAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:00:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33392 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932242AbeBSW76 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:58 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4ED6B60D87;
        Mon, 19 Feb 2018 22:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081197;
        bh=7MOViciHibjz93zxE5ffP7NrjbUgVqvCIU/d5orImGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sCE5Ydh5Yhh42w0BrP+Tegv7Qsvyn10e2cEto74Rv+8KLvgo7u/XDdNKCp5P0tOtf
         GqFvfozfota/AskDWgAOweuHx4DJOmLmg9nNAm4RnX8LQgBYTN+tIJTbJ6lkfY2VYZ
         4wVsUmEnepWRokVJGoXYgut4IEYN6Eba29Ag0OBqJbvjfR/epRru8XpidOVOMFV1R2
         eeiz0SsilWE/AM7Bw+K6PE18fD6s8/aVFeZZXLpev8pEk1SWZdgml2eZvuTW6m6+1I
         4KPumjuNgiRH7u6whBogIknMa9E1fhdjFjJYzhoKs5ADDjoH3b8m/Jvz0ErtQ9fK/A
         7hVXf4Me2ULwW9JNWTjVQIYAhTl23CRBwHPTrcrWq7PkL/wm4UyWiAb4uDeBZgO5PG
         e6Lb3cmlA6u8OyAE/TyfUChQljOr1ETIUXh+kcULHiCp9EMNKpwQ78tgSJGvvsKhBV
         oHgka8dm7CChjQQR/607nmOGLPO1L08W4oQNzcK/Uax/UtBfQMh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 23/36] sha1_file: convert retry_bad_packed_offset to struct object_id
Date:   Mon, 19 Feb 2018 22:59:14 +0000
Message-Id: <20180219225927.386065-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 5d07f330c8..bfa6438b4e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1095,13 +1095,13 @@ static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
-	const unsigned char *sha1;
+	struct object_id oid;
 	revidx = find_pack_revindex(p, obj_offset);
 	if (!revidx)
 		return OBJ_BAD;
-	sha1 = nth_packed_object_sha1(p, revidx->nr);
-	mark_bad_packed_object(p, sha1);
-	type = sha1_object_info(sha1, NULL);
+	nth_packed_object_oid(&oid, p, revidx->nr);
+	mark_bad_packed_object(p, oid.hash);
+	type = sha1_object_info(oid.hash, NULL);
 	if (type <= OBJ_NONE)
 		return OBJ_BAD;
 	return type;
