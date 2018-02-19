Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C0E1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbeBSXB1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:01:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932261AbeBSW7q (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:46 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B4CFD609E7;
        Mon, 19 Feb 2018 22:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081185;
        bh=EKdbCCsiKJxi25/N8sI2PC1hHz5VBqrxvJBU8Z/ASCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1EAGboho1V+9MjLEbuK9MjHTh5/CyaWqzl9WvzPDd4BKv+ZXM6EdvjGXNZUNaplrT
         BDA6+JGJoHJUYO9UUtqG5WzTKwEgkin4ezFyrbOt0fsbzcncLl+dIQBDVArKoVIHhR
         TiYACjNZmIpEnbxKk+6fNyZiqS/+mWiiALhkJ+0f2dIavavo6mFFbf9oos4idhb1um
         h4Y4Re0mUjdSdV+iA1I1olBA3VZD2dZooRn8yUAaHefaQOkwf/P4Zz27mPSFKbcYFQ
         TP9qNw/kFLXHhqsgo8YyEqc1Yt4uHLMfDAOKkOMm21qWebUZBUB4I687XvurW6Zanf
         9M3a+jsgds+ANNO1lAR9zwHOjuhB9mVsVoNbqtVDd56FAfTnQh1TXu1TVwTb+MDEmK
         rxzwftMSOCWmZxxETKtfU/RtRWynwaEFz/awH5sVxQZH1x4v+s8fOeFahhcWdV7t69
         Wi5/5RdAuq7HlUZCQC0XrV5J0OfpIiNeX9YzGal5yIHHwFvdScc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/36] http-walker: convert struct object_request to use struct object_id
Date:   Mon, 19 Feb 2018 22:59:02 +0000
Message-Id: <20180219225927.386065-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct object_request to use struct object_id by updating the
definition and applying the following semantic patch, plus the standard
object_id transforms:

@@
struct object_request E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct object_request *E1;
@@
- E1->sha1
+ E1->oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-walker.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 07c2b1af82..f506f394ac 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -22,7 +22,7 @@ enum object_request_state {
 
 struct object_request {
 	struct walker *walker;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct alt_base *repo;
 	enum object_request_state state;
 	struct http_object_request *req;
@@ -56,7 +56,7 @@ static void start_object_request(struct walker *walker,
 	struct active_request_slot *slot;
 	struct http_object_request *req;
 
-	req = new_http_object_request(obj_req->repo->base, obj_req->sha1);
+	req = new_http_object_request(obj_req->repo->base, obj_req->oid.hash);
 	if (req == NULL) {
 		obj_req->state = ABORTED;
 		return;
@@ -82,7 +82,7 @@ static void finish_object_request(struct object_request *obj_req)
 		return;
 
 	if (obj_req->req->rename == 0)
-		walker_say(obj_req->walker, "got %s\n", sha1_to_hex(obj_req->sha1));
+		walker_say(obj_req->walker, "got %s\n", oid_to_hex(&obj_req->oid));
 }
 
 static void process_object_response(void *callback_data)
@@ -129,7 +129,7 @@ static int fill_active_slot(struct walker *walker)
 	list_for_each_safe(pos, tmp, head) {
 		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
-			if (has_sha1_file(obj_req->sha1))
+			if (has_sha1_file(obj_req->oid.hash))
 				obj_req->state = COMPLETE;
 			else {
 				start_object_request(walker, obj_req);
@@ -148,7 +148,7 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 
 	newreq = xmalloc(sizeof(*newreq));
 	newreq->walker = walker;
-	hashcpy(newreq->sha1, sha1);
+	hashcpy(newreq->oid.hash, sha1);
 	newreq->repo = data->alt;
 	newreq->state = WAITING;
 	newreq->req = NULL;
@@ -481,13 +481,13 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 
 	list_for_each(pos, head) {
 		obj_req = list_entry(pos, struct object_request, node);
-		if (!hashcmp(obj_req->sha1, sha1))
+		if (!hashcmp(obj_req->oid.hash, sha1))
 			break;
 	}
 	if (obj_req == NULL)
 		return error("Couldn't find request for %s in the queue", hex);
 
-	if (has_sha1_file(obj_req->sha1)) {
+	if (has_sha1_file(obj_req->oid.hash)) {
 		if (obj_req->req != NULL)
 			abort_http_object_request(obj_req->req);
 		abort_object_request(obj_req);
@@ -541,7 +541,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 	} else if (req->zret != Z_STREAM_END) {
 		walker->corrupt_object_found++;
 		ret = error("File %s (%s) corrupt", hex, req->url);
-	} else if (hashcmp(obj_req->sha1, req->real_sha1)) {
+	} else if (hashcmp(obj_req->oid.hash, req->real_sha1)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
