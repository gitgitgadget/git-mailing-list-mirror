Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A8EEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbjIHXMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbjIHXMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:12:19 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0BF133
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:12:09 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39650)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qeke0-006MqE-NR; Fri, 08 Sep 2023 17:12:08 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdz-009u13-S0; Fri, 08 Sep 2023 17:12:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:37 -0500
Message-Id: <20230908231049.2035003-20-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdz-009u13-S0;;;mid=<20230908231049.2035003-20-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+RJWlS2GgRzOCq66q0KRWdzt652tQUF2c=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 20/32] builtin/cat-file:  Let the oid determine the output algorithm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use GET_OID_UNTRANSLATED when calling get_oid_with_context.  This
implements the semi-obvious behaviour that specifying a sha1 oid shows
the output for a sha1 encoded object, and specifying a sha256 oid
shows the output for a sha256 encoded object.

This is useful for testing the the conversion of an object to an
equivalent object encoded with a different hash function.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/cat-file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 694c8538df2f..7c9600292376 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -107,7 +107,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
-	unsigned get_oid_flags = GET_OID_RECORD_PATH | GET_OID_ONLY_TO_DIE;
+	unsigned get_oid_flags =
+		GET_OID_RECORD_PATH |
+		GET_OID_ONLY_TO_DIE |
+		GET_OID_UNTRANSLATED;
 	const char *path = force_path;
 	const int opt_cw = (opt == 'c' || opt == 'w');
 	if (!path && opt_cw)
@@ -223,7 +226,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 								     &size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
-				    get_oid_hex(target, &blob_oid))
+				    get_oid_hex_algop(target, &blob_oid,
+						      &hash_algos[oid.algo]))
 					die("%s not a valid tag", oid_to_hex(&oid));
 				free(buffer);
 			} else
-- 
2.41.0

