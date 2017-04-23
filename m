Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0A2207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046257AbdDWVht (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:37:49 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37382 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046163AbdDWVgG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B0CBD280D8;
        Sun, 23 Apr 2017 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983341;
        bh=ZCPXiYGxhB+aeSxDhv1QXJS1AviyhdtRhfHRTsJDd80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uN7gROm1u+ZQ9ODRPL/235EvOAt16RSxJy5SN6VwaAkhsgyFNAldhi2hlAistPBDd
         DJBmynbuRIMnFZCLdXNymL7ePAmLUlOINGSqo37YYa9cMVxGZBHrRsv/vy1UHsErjj
         RD70vzdSKx1zlsMQ7SEmPO7eyjwwtFJLp+Y/DeQsjQ3/hBiVk+jbk3jnwSlawaCI30
         Ui89ooo/IeHw/ScgkeA4T2fA7DFN/+CiEoGX6CpeZpfrLtByMykAHECMXL96D0BWLP
         SP6zyn8fQ2AbrQYnUWqZETluyN5Fm3cbhmxCCDztZRf/y/NoQ9FV3VinGl2ZhHwttR
         ePuxTIqWV9wCCBVVqRe1k9/gwjabkz0Dr9NBIK5Mbu+dzCqTuSPgiCLciIliDXiJJN
         qSbRHkcHNdGh/5feI8tL1MGgSyWnh6h2v1ufYu1YI7iYFbK7ryMDiOrsOzIwJxDJgx
         tzV9d2vVFdlNSUUjnBNz7ktXGGBuIMVd733abafmUR40ZRXVK1b
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 43/53] upload-pack: convert remaining parse_object callers to object_id
Date:   Sun, 23 Apr 2017 21:34:43 +0000
Message-Id: <20170423213453.253425-44-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining parse_object callers to struct object_id.  Use
named constants for several hard-coded values.  In addition, rename
got_sha1 to got_oid to reflect the new argument.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 upload-pack.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 20f87cd38..5b9d21089 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -286,19 +286,19 @@ static void create_pack_file(void)
 	die("git upload-pack: %s", abort_msg);
 }
 
-static int got_sha1(const char *hex, unsigned char *sha1)
+static int got_oid(const char *hex, struct object_id *oid)
 {
 	struct object *o;
 	int we_knew_they_have = 0;
 
-	if (get_sha1_hex(hex, sha1))
+	if (get_oid_hex(hex, oid))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
-	if (!has_sha1_file(sha1))
+	if (!has_object_file(oid))
 		return -1;
 
-	o = parse_object(sha1);
+	o = parse_object(oid->hash);
 	if (!o)
-		die("oops (%s)", sha1_to_hex(sha1));
+		die("oops (%s)", oid_to_hex(oid));
 	if (o->type == OBJ_COMMIT) {
 		struct commit_list *parents;
 		struct commit *commit = (struct commit *)o;
@@ -382,8 +382,8 @@ static int ok_to_give_up(void)
 
 static int get_common_commits(void)
 {
-	unsigned char sha1[20];
-	char last_hex[41];
+	struct object_id oid;
+	char last_hex[GIT_MAX_HEXSZ + 1];
 	int got_common = 0;
 	int got_other = 0;
 	int sent_ready = 0;
@@ -416,11 +416,11 @@ static int get_common_commits(void)
 			continue;
 		}
 		if (skip_prefix(line, "have ", &arg)) {
-			switch (got_sha1(arg, sha1)) {
+			switch (got_oid(arg, &oid)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
 				if (multi_ack && ok_to_give_up()) {
-					const char *hex = sha1_to_hex(sha1);
+					const char *hex = oid_to_hex(&oid);
 					if (multi_ack == 2) {
 						sent_ready = 1;
 						packet_write_fmt(1, "ACK %s ready\n", hex);
@@ -430,7 +430,7 @@ static int get_common_commits(void)
 				break;
 			default:
 				got_common = 1;
-				memcpy(last_hex, sha1_to_hex(sha1), 41);
+				memcpy(last_hex, oid_to_hex(&oid), 41);
 				if (multi_ack == 2)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (multi_ack)
@@ -492,7 +492,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 		goto error;
 
 	namebuf[0] = '^';
-	namebuf[41] = '\n';
+	namebuf[GIT_SHA1_HEXSZ + 1] = '\n';
 	for (i = get_max_object_index(); 0 < i; ) {
 		o = get_indexed_object(--i);
 		if (!o)
@@ -502,10 +502,10 @@ static int do_reachable_revlist(struct child_process *cmd,
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd->in, namebuf, 42) < 0)
+		if (write_in_full(cmd->in, namebuf, GIT_SHA1_HEXSZ + 2) < 0)
 			goto error;
 	}
-	namebuf[40] = '\n';
+	namebuf[GIT_SHA1_HEXSZ] = '\n';
 	for (i = 0; i < src->nr; i++) {
 		o = src->objects[i].item;
 		if (is_our_ref(o)) {
@@ -516,7 +516,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 		if (reachable && o->type == OBJ_COMMIT)
 			o->flags |= TMP_MARK;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd->in, namebuf, 41) < 0)
+		if (write_in_full(cmd->in, namebuf, GIT_SHA1_HEXSZ + 1) < 0)
 			goto error;
 	}
 	close(cmd->in);
@@ -742,7 +742,7 @@ static void receive_needs(void)
 	for (;;) {
 		struct object *o;
 		const char *features;
-		unsigned char sha1_buf[20];
+		struct object_id oid_buf;
 		char *line = packet_read_line(0, NULL);
 		const char *arg;
 
@@ -751,15 +751,15 @@ static void receive_needs(void)
 			break;
 
 		if (skip_prefix(line, "shallow ", &arg)) {
-			unsigned char sha1[20];
+			struct object_id oid;
 			struct object *object;
-			if (get_sha1_hex(arg, sha1))
+			if (get_oid_hex(arg, &oid))
 				die("invalid shallow line: %s", line);
-			object = parse_object(sha1);
+			object = parse_object(oid.hash);
 			if (!object)
 				continue;
 			if (object->type != OBJ_COMMIT)
-				die("invalid shallow object %s", sha1_to_hex(sha1));
+				die("invalid shallow object %s", oid_to_hex(&oid));
 			if (!(object->flags & CLIENT_SHALLOW)) {
 				object->flags |= CLIENT_SHALLOW;
 				add_object_array(object, NULL, &shallows);
@@ -785,8 +785,8 @@ static void receive_needs(void)
 		}
 		if (skip_prefix(line, "deepen-not ", &arg)) {
 			char *ref = NULL;
-			unsigned char sha1[20];
-			if (expand_ref(arg, strlen(arg), sha1, &ref) != 1)
+			struct object_id oid;
+			if (expand_ref(arg, strlen(arg), oid.hash, &ref) != 1)
 				die("git upload-pack: ambiguous deepen-not: %s", line);
 			string_list_append(&deepen_not, ref);
 			free(ref);
@@ -794,7 +794,7 @@ static void receive_needs(void)
 			continue;
 		}
 		if (!skip_prefix(line, "want ", &arg) ||
-		    get_sha1_hex(arg, sha1_buf))
+		    get_oid_hex(arg, &oid_buf))
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
 
@@ -821,13 +821,13 @@ static void receive_needs(void)
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
 
-		o = parse_object(sha1_buf);
+		o = parse_object(oid_buf.hash);
 		if (!o) {
 			packet_write_fmt(1,
 					 "ERR upload-pack: not our ref %s",
-					 sha1_to_hex(sha1_buf));
+					 oid_to_hex(&oid_buf));
 			die("git upload-pack: not our ref %s",
-			    sha1_to_hex(sha1_buf));
+			    oid_to_hex(&oid_buf));
 		}
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
