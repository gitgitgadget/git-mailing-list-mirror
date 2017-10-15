Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BEB20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdJOWHi (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54984 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751235AbdJOWHg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 57D4260449;
        Sun, 15 Oct 2017 22:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105255;
        bh=JB2Y7TdL7tGwdZxXG6NNmucBDX09D1aBHeqEV9Sfqj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Kr9AKhBPF8aqPUvq+a81SJzfl5owWZKH5CmcGObwzggHAvLSOGG99Un6d0iH+m/Fj
         hYl5JUejHRsYxI2YXRVsW4WMfW/vDmzqklvvRNhbvyDIeOXIzP7QrEHTsQTA/8hFrV
         MdeLPXAe08SeU/H92K9+/JXNzbGWWmAp4ESKQug039FWWCZSOZF8WDAYNZUlNWLxM+
         d9uM9UAXqBUHyhoXkGpkOwPsy9GDAhS/kU4LEBgo5uHzh/J7vwQnPBtr5Oh0d0mUE4
         KM+uCAgxAr/YnE63GiM2zHWrEDy2eMvsCp2ZewpqYFeknxiUWm4gFY9dqx+J5LiGE7
         29t64aVUVc81TTMNaNrOHghDMsuwkzghHNPt/9OcSpQ+Z+8eaEbmCbl5pdbWQg8b9L
         QiQtKCt6Txx8EB4/cUHJyg8FOUWv4NGznpdbqnDn5fwbg/8RlkWuarYhcBaVujuole
         pfgwbgXnVSwkmxXSKgYUfhMWx+rhcIeAmeu1pTI+ePBurz9a7AN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 01/25] walker: convert to struct object_id
Date:   Sun, 15 Oct 2017 22:06:48 +0000
Message-Id: <20171015220712.97308-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 walker.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/walker.c b/walker.c
index 274f1a4935..2d83254bc0 100644
--- a/walker.c
+++ b/walker.c
@@ -7,7 +7,7 @@
 #include "blob.h"
 #include "refs.h"
 
-static unsigned char current_commit_sha1[20];
+static struct object_id current_commit_oid;
 
 void walker_say(struct walker *walker, const char *fmt, ...)
 {
@@ -24,9 +24,9 @@ static void report_missing(const struct object *obj)
 	fprintf(stderr, "Cannot obtain needed %s %s\n",
 		obj->type ? typename(obj->type): "object",
 		oid_to_hex(&obj->oid));
-	if (!is_null_sha1(current_commit_sha1))
+	if (!is_null_oid(&current_commit_oid))
 		fprintf(stderr, "while processing commit %s.\n",
-			sha1_to_hex(current_commit_sha1));
+			oid_to_hex(&current_commit_oid));
 }
 
 static int process(struct walker *walker, struct object *obj);
@@ -82,7 +82,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 	if (commit->object.flags & COMPLETE)
 		return 0;
 
-	hashcpy(current_commit_sha1, commit->object.oid.hash);
+	oidcpy(&current_commit_oid, &commit->object.oid);
 
 	walker_say(walker, "walk %s\n", oid_to_hex(&commit->object.oid));
 
@@ -187,14 +187,14 @@ static int loop(struct walker *walker)
 	return 0;
 }
 
-static int interpret_target(struct walker *walker, char *target, unsigned char *sha1)
+static int interpret_target(struct walker *walker, char *target, struct object_id *oid)
 {
-	if (!get_sha1_hex(target, sha1))
+	if (!get_oid_hex(target, oid))
 		return 0;
 	if (!check_refname_format(target, 0)) {
 		struct ref *ref = alloc_ref(target);
 		if (!walker->fetch_ref(walker, ref)) {
-			hashcpy(sha1, ref->old_oid.hash);
+			oidcpy(oid, &ref->old_oid);
 			free(ref);
 			return 0;
 		}
@@ -259,7 +259,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	struct strbuf refname = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction = NULL;
-	unsigned char *sha1 = xmalloc(targets * 20);
+	struct object_id *oids = xmalloc(targets * sizeof(struct object_id));
 	char *msg = NULL;
 	int i, ret = -1;
 
@@ -279,11 +279,11 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	}
 
 	for (i = 0; i < targets; i++) {
-		if (interpret_target(walker, target[i], &sha1[20 * i])) {
+		if (interpret_target(walker, target[i], oids + i)) {
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
 			goto done;
 		}
-		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
+		if (process(walker, lookup_unknown_object(oids[i].hash)))
 			goto done;
 	}
 
@@ -304,7 +304,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, refname.buf,
-					   &sha1[20 * i], NULL, 0,
+					   oids[i].hash, NULL, 0,
 					   msg ? msg : "fetch (unknown)",
 					   &err)) {
 			error("%s", err.buf);
@@ -321,7 +321,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 done:
 	ref_transaction_free(transaction);
 	free(msg);
-	free(sha1);
+	free(oids);
 	strbuf_release(&err);
 	strbuf_release(&refname);
 	return ret;
-- 
2.15.0.rc0.271.g36b669edcc

