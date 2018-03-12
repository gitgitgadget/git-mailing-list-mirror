Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2685A1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeCLC2m (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932577AbeCLC2k (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF21A610D6;
        Mon, 12 Mar 2018 02:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821719;
        bh=sgr1ulVHLdL/4X0VuLu0At54njfx0o/qVWQ8ZZzKIhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VlhkuJzB8Z7rkEisKaXD+i01UufDRlXbnoTsCGa6w6ZVzDGxiLtiMmGrsaNjwykXq
         VA1whi4mnWMyl4O9+Rw/6yMVH1YQJQ+Z27kbHn5jRCgqg/tyHZ6tBbVEDgx+bHhtfF
         qlrfF1CWlWokE1hEDAdgHo4irs+XAGVr6zDiJe8S7b3M5U0+wPzPGHrUg7t+Q8yuqq
         n0MSDDJ2c3bAS+mziD6qZPiLBQqKB2B45PUxgSDCQrRei18tZUsBfRw9+xxTyLNTPs
         rX07dFggqCpQABQmW/Rs3gGZXtKKaInRXf4voBOX3qr4hqDkNk9n3cjEwmKBX0hN9S
         +x39pCeYp51UivthtZMrPH8rfw0FLnaAJz5lgqd4zPOJVyskII6X0Oav9O+HsK5Ehc
         8Rbrrjo4tJxyc86OWQos/ZhjXnV5+IG/D8HrxnfQAiUPcBBOKbbqNiqScvm70C/8Mo
         0zvGlvlXgsjDI7/5CYdWh0lZ0l5nZvuvy7XCOcNNwt0ZNRmHknR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 23/36] sha1_file: convert retry_bad_packed_offset to struct object_id
Date:   Mon, 12 Mar 2018 02:27:43 +0000
Message-Id: <20180312022756.483934-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
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
index 7c1a2519fc..5f08aa0a14 100644
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
