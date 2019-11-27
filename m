Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE2C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 23:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6620F215F2
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 23:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="MUTj/Q7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfK0Xfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:35:32 -0500
Received: from aibo.runbox.com ([91.220.196.211]:48290 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfK0Xfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 18:35:32 -0500
X-Greylist: delayed 3072 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2019 18:35:31 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date;
         bh=Sj9ia0A9RZZgkzTrfqFtu2wgszoGs2ciGP9EZYNuZEI=; b=MUTj/Q7fTWxsnOIsQjxLY7fbh
        03t2RCjnCmXxy/726YVaqii/6R4NFLio7oowQ2uq3Qe9peddz14tsrph5+aTj1UeDxB0LqAYb3Q31
        LkaNxJHxuu0hf0baB5pUOknZuAvk+/nhuyXGLVi/p/VV0wemUjuLQb7pEtAvWW6p+aib7ced+YY1q
        FHse6ZdoHB3gq03eWgULMPsrWRkKfOKAPbAEVxtiyKO9LFN3+CiTj1yzGnHPM038FnyOiU3pMqVcS
        2VwJYy/VRQ/PA8XsIr+XIMW7tp1gOLwuQoAEX4tBASNTt8R6z4i6FT30nuPEZJH0AtXyH38gViSkK
        PLy2t17qw==;
Received: from [10.9.9.203] (helo=mailfront21.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <cstolley@runbox.com>)
        id 1ia62k-0008B5-OM
        for git@vger.kernel.org; Wed, 27 Nov 2019 23:44:18 +0100
Received: by mailfront21.runbox with esmtpsa  [Authenticated alias (602527)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1ia5k0-00066Y-B6
        for git@vger.kernel.org; Wed, 27 Nov 2019 23:24:56 +0100
Date:   Wed, 27 Nov 2019 16:24:53 -0600
From:   Colin Stolley <cstolley@runbox.com>
To:     git@vger.kernel.org
Subject: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191127222453.GA3765@owl.colinstolley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When loading packfiles on start-up, we traverse the internal packfile
list once per file to avoid reloading packfiles that have already
been loaded. This check runs in quadratic time, so for poorly
maintained repos with a large number of packfiles, it can be pretty
slow.

Add a hashmap containing the packfile names as we load them so that
the average runtime cost of checking for already-loaded packs becomes
constant.

Add a perf test to p5303 to show speed-up.

The existing p5303 test runtimes are dominated by other factors and do
not show an appreciable speed-up. The new test in p5303 clearly exposes
a speed-up in bad cases. In this test we create 10,000 packfiles and
measure the start-up time of git rev-parse, which does little else
besides load in the packs.

Here are the numbers for the new p5303 test:

Test                         HEAD^             HEAD
---------------------------------------------------------------------
5303.12: load 10,000 packs   1.03(0.92+0.10)   0.12(0.02+0.09) -88.3%

Thanks-to: Jeff King <peff@peff.net>
Signed-off-by: Colin Stolley <cstolley@runbox.com>
---
 object-store.h             | 21 +++++++++++++++++++++
 object.c                   |  3 +++
 packfile.c                 | 21 +++++++++++----------
 t/perf/p5303-many-packs.sh | 18 ++++++++++++++++++
 4 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/object-store.h b/object-store.h
index 7f7b3cdd80..55ee639350 100644
--- a/object-store.h
+++ b/object-store.h
@@ -60,6 +60,7 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 void odb_clear_loose_cache(struct object_directory *odb);
 
 struct packed_git {
+	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
 	struct list_head mru;
 	struct pack_window *windows;
@@ -88,6 +89,20 @@ struct packed_git {
 
 struct multi_pack_index;
 
+static inline int pack_map_entry_cmp(const void *unused_cmp_data,
+				     const struct hashmap_entry *entry,
+				     const struct hashmap_entry *entry2,
+				     const void *keydata)
+{
+	const char *key = keydata;
+	const struct packed_git *pg1, *pg2;
+
+	pg1 = container_of(entry, const struct packed_git, packmap_ent);
+	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
+
+	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
+}
+
 struct raw_object_store {
 	/*
 	 * Set of all object directories; the main directory is first (and
@@ -131,6 +146,12 @@ struct raw_object_store {
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
+	/*
+	 * A map of packfiles to packed_git structs for tracking which
+	 * packs have been loaded already.
+	 */
+	struct hashmap pack_map;
+
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
diff --git a/object.c b/object.c
index 3b8b8c55c9..142ef69399 100644
--- a/object.c
+++ b/object.c
@@ -479,6 +479,7 @@ struct raw_object_store *raw_object_store_new(void)
 
 	memset(o, 0, sizeof(*o));
 	INIT_LIST_HEAD(&o->packed_git_mru);
+	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	return o;
 }
 
@@ -518,6 +519,8 @@ void raw_object_store_clear(struct raw_object_store *o)
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
 	o->packed_git = NULL;
+
+	hashmap_free(&o->pack_map);
 }
 
 void parsed_object_pool_clear(struct parsed_object_pool *o)
diff --git a/packfile.c b/packfile.c
index 355066de17..253559fa87 100644
--- a/packfile.c
+++ b/packfile.c
@@ -856,20 +856,21 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
 	    !(data->m && midx_contains_pack(data->m, file_name))) {
-		/* Don't reopen a pack we already have. */
-		for (p = data->r->objects->packed_git; p; p = p->next) {
-			size_t len;
-			if (strip_suffix(p->pack_name, ".pack", &len) &&
-			    len == base_len &&
-			    !memcmp(p->pack_name, full_name, len))
-				break;
-		}
+		struct hashmap_entry hent;
+		char *pack_name = xstrfmt("%.*s.pack", (int)base_len, full_name);
+		unsigned int hash = strhash(pack_name);
+		hashmap_entry_init(&hent, hash);
 
-		if (!p) {
+		/* Don't reopen a pack we already have. */
+		if (!hashmap_get(&data->r->objects->pack_map, &hent, pack_name)) {
 			p = add_packed_git(full_name, full_name_len, data->local);
-			if (p)
+			if (p) {
+				hashmap_entry_init(&p->packmap_ent, hash);
+				hashmap_add(&data->r->objects->pack_map, &p->packmap_ent);
 				install_packed_git(data->r, p);
+			}
 		}
+		free(pack_name);
 	}
 
 	if (!report_garbage)
diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index 3779851941..ede78e19e2 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -84,4 +84,22 @@ do
 	'
 done
 
+# Measure pack loading with 10,000 packs.
+test_expect_success 'generate lots of packs' '
+	for i in $(test_seq 10000); do
+		echo "blob"
+		echo "data <<EOF"
+		echo "blob $i"
+		echo "EOF"
+		echo "checkpoint"
+	done |
+	git -c fastimport.unpackLimit=0 fast-import
+'
+
+# The purpose of this test is to evaluate load time for a large number
+# of packs while doing as little other work as possible.
+test_perf "load 10,000 packs" '
+	git rev-parse --verify "HEAD^{commit}"
+'
+
 test_done
-- 
2.23.0

