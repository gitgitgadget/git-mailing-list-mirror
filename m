Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA3EEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjIHXMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343515AbjIHXMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:12:20 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537031FE5
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:12:15 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39708)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qeke6-006Mxp-Fj; Fri, 08 Sep 2023 17:12:14 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qeke5-009u13-Hi; Fri, 08 Sep 2023 17:12:14 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:39 -0500
Message-Id: <20230908231049.2035003-22-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qeke5-009u13-Hi;;;mid=<20230908231049.2035003-22-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX199OyHtnthml3Bm7RYHck+AOyBiu60wlsY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 22/32] object-file: Handle compat objects in check_object_signature
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update check_object_signature to find the hash algorithm the exising
signature uses, and to use the same hash algorithm when recomputing it
to check the signature is valid.

This will be useful when teaching git ls-tree to display objects
encoded with the compat hash algorithm.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 object-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index fd420dd303df..d6140ebccaf1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1094,9 +1094,11 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size,
 			   enum object_type type)
 {
+	const struct git_hash_algo *algo =
+		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
 	struct object_id real_oid;
 
-	hash_object_file(r->hash_algo, buf, size, type, &real_oid);
+	hash_object_file(algo, buf, size, type, &real_oid);
 
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
-- 
2.41.0

