Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D378EEB57A
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 00:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbjIIAkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 20:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345811AbjIIAjv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:51 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742432D44
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 17:39:16 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37192)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdl-00FHIL-1z; Fri, 08 Sep 2023 17:11:53 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdk-009u13-3N; Fri, 08 Sep 2023 17:11:52 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:30 -0500
Message-Id: <20230908231049.2035003-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdk-009u13-3N;;;mid=<20230908231049.2035003-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18UggUqgxl2MkhJFTn5zai+9uiPM0Ud96E=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 13/32] object-file: Add a compat_oid_in parameter to write_object_file_flags
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To create the proper signatures for commit objects both versions of
the commit object need to be generated and signed.  After that it is
a waste to throw away the work of generating the compatibility hash
so update write_object_file_flags to take a compatibility hash input
parameter that it can use to skip the work of generating the
compatability hash.

Update the places that don't generate the compatability hash to
pass NULL so it is easy to tell write_object_file_flags should
not attempt to use their compatability hash.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 cache-tree.c      | 2 +-
 object-file.c     | 6 ++++--
 object-store-ll.h | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 641427ed410a..ddc7d3d86959 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -448,7 +448,7 @@ static int update_one(struct cache_tree *it,
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &it->oid);
 	} else if (write_object_file_flags(buffer.buf, buffer.len, OBJ_TREE,
-					   &it->oid, flags & WRITE_TREE_SILENT
+					   &it->oid, NULL, flags & WRITE_TREE_SILENT
 					   ? HASH_SILENT : 0)) {
 		strbuf_release(&buffer);
 		return -1;
diff --git a/object-file.c b/object-file.c
index 6cc4ae1fd957..fd420dd303df 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2317,7 +2317,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 
 int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
-			    unsigned flags)
+			    struct object_id *compat_oid_in, unsigned flags)
 {
 	struct repository *repo = the_repository;
 	const struct git_hash_algo *algo = repo->hash_algo;
@@ -2328,7 +2328,9 @@ int write_object_file_flags(const void *buf, unsigned long len,
 
 	/* Generate compat_oid */
 	if (compat) {
-		if (type == OBJ_BLOB)
+		if (compat_oid_in)
+			oidcpy(&compat_oid, compat_oid_in);
+		else if (type == OBJ_BLOB)
 			hash_object_file(compat, buf, len, type, &compat_oid);
 		else {
 			struct strbuf converted = STRBUF_INIT;
diff --git a/object-store-ll.h b/object-store-ll.h
index bc76d6bec80d..c5f2bb2fc2fe 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -255,11 +255,11 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 
 int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
-			    unsigned flags);
+			    struct object_id *comapt_oid_in, unsigned flags);
 static inline int write_object_file(const void *buf, unsigned long len,
 				    enum object_type type, struct object_id *oid)
 {
-	return write_object_file_flags(buf, len, type, oid, 0);
+	return write_object_file_flags(buf, len, type, oid, NULL, 0);
 }
 
 int write_object_file_literally(const void *buf, unsigned long len,
-- 
2.41.0

