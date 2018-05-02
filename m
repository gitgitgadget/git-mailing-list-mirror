Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF88C21847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeEBA0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37642 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753343AbeEBA01 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 08BE0609A1;
        Wed,  2 May 2018 00:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220786;
        bh=t9+FzphLzpklprZq9bUa56pZJMjNUnmBNVFkEUTOziM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=eVS/+a9vPn753Dy1uE5YXodRKzZCVyMRbNtD/EGkGhddYjI76dKOI3DUSaDTT3lx5
         rZDROZMJ9Cq0XKHygJAbQIek5wnpEOYKYR98DTNcS0JLoewvrNehUQUW0CRb07Z2oG
         iVKOK6HziOiwTqnUVSy3CGjhiYlsjpfPgJdLXKxybQJ+0EPg7jao9P5gaz5DNUPKBF
         4GW7izzypAxZdT9GYPJZMd2Ef0l6MBiZ820vwSZ/m6oPG1YzR6OCgC2N//+bBkl/t4
         cU0OkZIEYHenGP4Q1bLsCLRnekGzt0Ur2Xv5jS9ySmgHsrQcJOcVYKUrsro0rIpnrj
         VaPPudc08W/QUpJMVePjugm0U09Tpg1+RVGrbKzJb1hxh4CDVmhq/97Ilg95X3LDYt
         dAhgsfyi7t1a7E4MeVLa/6oRodpo43kAX3jlkHLV+zS49btLr1EPBh9xufBt+1phxP
         dnCio5Z0rNcPVaK+pqcq3SFXADTtjHaFGVhXXKxbLfHQouBgXct
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 07/42] packfile: convert find_pack_entry to object_id
Date:   Wed,  2 May 2018 00:25:35 +0000
Message-Id: <20180502002610.915892-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert find_pack_entry and the static function fill_pack_entry to take
pointers to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 packfile.c  | 12 ++++++------
 packfile.h  |  2 +-
 sha1-file.c |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index e65f943664..84acd405e0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1805,7 +1805,7 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 }
 
-static int fill_pack_entry(const unsigned char *sha1,
+static int fill_pack_entry(const struct object_id *oid,
 			   struct pack_entry *e,
 			   struct packed_git *p)
 {
@@ -1814,11 +1814,11 @@ static int fill_pack_entry(const unsigned char *sha1,
 	if (p->num_bad_objects) {
 		unsigned i;
 		for (i = 0; i < p->num_bad_objects; i++)
-			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+			if (!hashcmp(oid->hash, p->bad_object_sha1 + 20 * i))
 				return 0;
 	}
 
-	offset = find_pack_entry_one(sha1, p);
+	offset = find_pack_entry_one(oid->hash, p);
 	if (!offset)
 		return 0;
 
@@ -1836,7 +1836,7 @@ static int fill_pack_entry(const unsigned char *sha1,
 	return 1;
 }
 
-int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
 	struct list_head *pos;
 
@@ -1846,7 +1846,7 @@ int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		if (fill_pack_entry(sha1, e, p)) {
+		if (fill_pack_entry(oid, e, p)) {
 			list_move(&p->mru, &r->objects->packed_git_mru);
 			return 1;
 		}
@@ -1857,7 +1857,7 @@ int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack
 int has_object_pack(const struct object_id *oid)
 {
 	struct pack_entry e;
-	return find_pack_entry(the_repository, oid->hash, &e);
+	return find_pack_entry(the_repository, oid, &e);
 }
 
 int has_pack_index(const unsigned char *sha1)
diff --git a/packfile.h b/packfile.h
index 14ca34bcbd..782029ed07 100644
--- a/packfile.h
+++ b/packfile.h
@@ -134,7 +134,7 @@ extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-extern int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
+extern int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
 
 extern int has_object_pack(const struct object_id *oid);
 
diff --git a/sha1-file.c b/sha1-file.c
index 1617e25495..4328c61285 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1268,7 +1268,7 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 	}
 
 	while (1) {
-		if (find_pack_entry(the_repository, real->hash, &e))
+		if (find_pack_entry(the_repository, real, &e))
 			break;
 
 		if (flags & OBJECT_INFO_IGNORE_LOOSE)
@@ -1281,7 +1281,7 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
 			reprepare_packed_git(the_repository);
-			if (find_pack_entry(the_repository, real->hash, &e))
+			if (find_pack_entry(the_repository, real, &e))
 				break;
 		}
 
@@ -1669,7 +1669,7 @@ static int freshen_loose_object(const struct object_id *oid)
 static int freshen_packed_object(const struct object_id *oid)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(the_repository, oid->hash, &e))
+	if (!find_pack_entry(the_repository, oid, &e))
 		return 0;
 	if (e.p->freshened)
 		return 1;
