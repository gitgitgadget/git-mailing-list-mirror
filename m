Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE27EEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbjIHXbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345284AbjIHXa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:30:59 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA141FE5
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:30:40 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37242)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdp-00FHIn-IC; Fri, 08 Sep 2023 17:11:57 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdo-009u13-JH; Fri, 08 Sep 2023 17:11:57 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:32 -0500
Message-Id: <20230908231049.2035003-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdo-009u13-JH;;;mid=<20230908231049.2035003-15-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19qsKm9mb9BAhBD2V7I5lbTWl/aQUj34I8=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 15/32] cache: add a function to read an OID of a specific algorithm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Currently, we always read a object ID of the current algorithm with
oidread.  However, once we start converting objects, we'll need to
consider what happens when we want to read an object ID of a specific
algorithm, such as the compatibility algorithm.  To make this easier,
let's define oidread_algop, which specifies which algorithm we should
use for our object ID, and define oidread in terms of it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 hash.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hash.h b/hash.h
index 615ae0691d07..e064807c1733 100644
--- a/hash.h
+++ b/hash.h
@@ -73,10 +73,15 @@ static inline void oidclr(struct object_id *oid)
 	oid->algo = hash_algo_by_ptr(the_hash_algo);
 }
 
+static inline void oidread_algop(struct object_id *oid, const unsigned char *hash, const struct git_hash_algo *algop)
+{
+	memcpy(oid->hash, hash, algop->rawsz);
+	oid->algo = hash_algo_by_ptr(algop);
+}
+
 static inline void oidread(struct object_id *oid, const unsigned char *hash)
 {
-	memcpy(oid->hash, hash, the_hash_algo->rawsz);
-	oid->algo = hash_algo_by_ptr(the_hash_algo);
+	oidread_algop(oid, hash, the_hash_algo);
 }
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
-- 
2.41.0

