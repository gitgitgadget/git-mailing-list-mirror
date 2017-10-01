Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6FF20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbdJAWJB (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54150 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751092AbdJAWI7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4C54260DB3;
        Sun,  1 Oct 2017 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895735;
        bh=Nle15fq2QjboReWlO0XX7XgRLa9/4U3/yi+FhHMLKls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0UljO7G6HXXVtBwsi649MtKkZ/uh8uXztL7JdnFnMbTAZwErDopRo5HkkcmpQ+2f
         RR3amOF8je3acEOeXlq4ShereYYcPfKdq/Ly6ruGcAHBn+PaQyBq/+VRD5b502gAJe
         8+SrMfe5SX8snmtEdmLwHYUxHDSi9eHbfnxiTiNWbUhp4l508XpGMVM3rjeQdSmswp
         +3P0D21jJUk3mcCkb2lYPgRLBoDDpz3AiylHRWg5ainL15iicQK1YI9zYvJTUzA8LQ
         z24PcqWb4S896CW4w7a6NhBV59pqOev/lxcD06rPnLSMafpmC2w3kXI24zMdEkeamw
         f1y2J0EdGIRTY1XVy/0bRuZEAfheuXdwin6VzqLFgePkvODLq3KCdn0WZzE4J5T5FK
         9xE9YUNi0vRsP9eAlo/3XPGqOlL2+tPQqksom/tCbft53/Vw5uGP5RdpdwXqhXDXgF
         6t0/b2+oc4/UBv8jKpjdCn4hXZ8/D/LKRyUKkmiet59QnpCv/nA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 10/24] builtin/reflog: convert remaining unsigned char uses to object_id
Date:   Sun,  1 Oct 2017 22:08:17 +0000
Message-Id: <20171001220831.214705-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining uses of unsigned char [20] to struct object_id.
This conversion is needed for dwim_log.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reflog.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2067cca5b1..302fafbeef 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -42,7 +42,7 @@ struct expire_reflog_policy_cb {
 };
 
 struct collected_reflog {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char reflog[FLEX_ARRAY];
 };
 
@@ -385,7 +385,7 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 	struct collect_reflog_cb *cb = cb_data;
 
 	FLEX_ALLOC_STR(e, reflog, ref);
-	hashcpy(e->sha1, oid->hash);
+	oidcpy(&e->oid, oid);
 	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
 	cb->e[cb->nr++] = e;
 	return 0;
@@ -589,7 +589,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= reflog_expire(e->reflog, e->sha1, flags,
+			status |= reflog_expire(e->reflog, e->oid.hash, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
@@ -601,13 +601,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	for (; i < argc; i++) {
 		char *ref;
-		unsigned char sha1[20];
-		if (!dwim_log(argv[i], strlen(argv[i]), sha1, &ref)) {
+		struct object_id oid;
+		if (!dwim_log(argv[i], strlen(argv[i]), oid.hash, &ref)) {
 			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
-		status |= reflog_expire(ref, sha1, flags,
+		status |= reflog_expire(ref, oid.hash, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
@@ -659,7 +659,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 	for ( ; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
-		unsigned char sha1[20];
+		struct object_id oid;
 		char *ep, *ref;
 		int recno;
 
@@ -668,7 +668,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!dwim_log(argv[i], spec - argv[i], sha1, &ref)) {
+		if (!dwim_log(argv[i], spec - argv[i], oid.hash, &ref)) {
 			status |= error("no reflog for '%s'", argv[i]);
 			continue;
 		}
@@ -683,7 +683,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.cmd.expire_total = 0;
 		}
 
-		status |= reflog_expire(ref, sha1, flags,
+		status |= reflog_expire(ref, oid.hash, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
-- 
2.14.2.822.g60be5d43e6

