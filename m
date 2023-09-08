Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A579EEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbjIHXao (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjIHXam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:30:42 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F762109
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:30:33 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37092)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekda-00FHHe-1O; Fri, 08 Sep 2023 17:11:42 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdZ-009u13-27; Fri, 08 Sep 2023 17:11:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:25 -0500
Message-Id: <20230908231049.2035003-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdZ-009u13-27;;;mid=<20230908231049.2035003-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19XaInyDXSvzVDmwkrLv21VeYrPIC9tzp0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 08/32] loose: Compatibilty short name support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update loose_objects_cache when udpating the loose objects map.  This
oidtree is used to discover which oids are possibilities when
resolving short names, and it can support a mixture of sha1
and sha256 oids.

With this any oid recorded objects/loose-objects-idx is usable
for resolving an oid to an object.

To make this maintainable a helper insert_loose_map is factored
out of load_one_loose_object_map and repo_add_loose_object_map,
and then modified to also update the loose_objects_cache.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 loose.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/loose.c b/loose.c
index 8ddb7112a541..81ed0e6b0c1e 100644
--- a/loose.c
+++ b/loose.c
@@ -7,6 +7,7 @@
 #include "gettext.h"
 #include "loose.h"
 #include "lockfile.h"
+#include "oidtree.h"
 
 static const char *loose_object_header = "# loose-object-idx\n";
 
@@ -42,6 +43,21 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
 	return 1;
 }
 
+static int insert_loose_map(struct object_directory *odb,
+			    const struct object_id *oid,
+			    const struct object_id *compat_oid)
+{
+	struct loose_object_map *map = odb->loose_map;
+	int inserted = 0;
+
+	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
+	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
+	if (inserted)
+		oidtree_insert(odb->loose_objects_cache, compat_oid);
+
+	return inserted;
+}
+
 static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
 {
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
@@ -49,15 +65,14 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 
 	if (!dir->loose_map)
 		loose_object_map_init(&dir->loose_map);
+	if (!dir->loose_objects_cache) {
+		ALLOC_ARRAY(dir->loose_objects_cache, 1);
+		oidtree_init(dir->loose_objects_cache);
+	}
 
-	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
-	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_tree, repo->hash_algo->empty_tree);
-
-	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
-	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_blob, repo->hash_algo->empty_blob);
-
-	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
-	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->null_oid, repo->hash_algo->null_oid);
+	insert_loose_map(dir, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
+	insert_loose_map(dir, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
+	insert_loose_map(dir, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
 	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
 	fp = fopen(path.buf, "rb");
@@ -75,8 +90,7 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
 		    p != buf.buf + buf.len)
 			goto err;
-		insert_oid_pair(dir->loose_map->to_compat, &oid, &compat_oid);
-		insert_oid_pair(dir->loose_map->to_storage, &compat_oid, &oid);
+		insert_loose_map(dir, &oid, &compat_oid);
 	}
 
 	strbuf_release(&buf);
@@ -195,8 +209,7 @@ int repo_add_loose_object_map(struct repository *repo, const struct object_id *o
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
-	inserted |= insert_oid_pair(repo->objects->odb->loose_map->to_compat, oid, compat_oid);
-	inserted |= insert_oid_pair(repo->objects->odb->loose_map->to_storage, compat_oid, oid);
+	inserted = insert_loose_map(repo->objects->odb, oid, compat_oid);
 	if (inserted)
 		return write_one_object(repo, oid, compat_oid);
 	return 0;
-- 
2.41.0

