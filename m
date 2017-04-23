Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4182E207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046193AbdDWVgg (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:36 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37488 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046111AbdDWVfk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 24BA5280C2;
        Sun, 23 Apr 2017 21:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983334;
        bh=/sBlreZgxoetE8BM3jqnM8StaWuiXw2/dMtcnWYninU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zxs3JPf330OzUsUsNl+LHCF1/2Qkiw+JWZ4D5ZNVnlrKEMnYPsshquo6EDSWqSVNz
         zzIj8UniOFSlZEgjBuQg+/czqmVBubl2u9o1kDxT9IgcjLp/1U74DdPHXLF9IC5UBM
         rhs85RO7gFzbnKdN5vzRr4ypw0dAY5blga2QqGLwAgnG3AZ+NP3xEL0ZliJBW8wdbc
         o/9rWZbJQHuM3UMcD914XJc6YzlvP49s8n9/0vByG6Pu86Kgq2AiS9w09OLRm/wpbh
         evVrqSa8HoM8ntLDIA1QIpi6jKaj/t22yxvrMTwVsWODOUefE9cahqfcgWWeWmexul
         ISVt3NJQ1Pebtv27oMF0TPDTeuuk0EbJM1FkDptd6e9Va5inHOboBROLul6Sb6revn
         BmA3Y5Ht59StpeLDQrbSBlgcJ5kDf3KhifKsBSFrXbZayUHBlZmm0E2Ivxf1GM0sbH
         CjJIkKIuumBe1MHKv2HC5cRGAJ/zcLs74EJpA9TkvQwZUZ+kZOG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/53] shallow: convert shallow registration functions to object_id
Date:   Sun, 23 Apr 2017 21:34:21 +0000
Message-Id: <20170423213453.253425-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert register_shallow and unregister_shallow to take struct
object_id.  register_shallow is a caller of lookup_commit, which we will
convert later.  It doesn't make sense for the registration and
unregistration functions to have incompatible interfaces, so convert
them both.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c |  6 +++---
 builtin/receive-pack.c |  2 +-
 commit.c               |  4 ++--
 commit.h               |  4 ++--
 fetch-pack.c           |  4 ++--
 shallow.c              | 12 ++++++------
 upload-pack.c          |  8 ++++----
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fe35d1b5..477070806 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2777,10 +2777,10 @@ static void get_object_list(int ac, const char **av)
 				continue;
 			}
 			if (starts_with(line, "--shallow ")) {
-				unsigned char sha1[20];
-				if (get_sha1_hex(line + 10, sha1))
+				struct object_id oid;
+				if (get_oid_hex(line + 10, &oid))
 					die("not an SHA-1 '%s'", line + 10);
-				register_shallow(sha1);
+				register_shallow(&oid);
 				use_bitmap_index = 0;
 				continue;
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3cba3fd27..38e5164f6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -859,7 +859,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	 * not lose these new roots..
 	 */
 	for (i = 0; i < extra.nr; i++)
-		register_shallow(extra.oid[i].hash);
+		register_shallow(&extra.oid[i]);
 
 	si->shallow_ref[cmd->index] = 0;
 	oid_array_clear(&extra);
diff --git a/commit.c b/commit.c
index 73c78c2b8..ec41ba5e0 100644
--- a/commit.c
+++ b/commit.c
@@ -216,9 +216,9 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 	return ret;
 }
 
-int unregister_shallow(const unsigned char *sha1)
+int unregister_shallow(const struct object_id *oid)
 {
-	int pos = commit_graft_pos(sha1);
+	int pos = commit_graft_pos(oid->hash);
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < commit_graft_nr)
diff --git a/commit.h b/commit.h
index 7b1986d5c..884177b8f 100644
--- a/commit.h
+++ b/commit.h
@@ -263,8 +263,8 @@ extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n,
 
 struct oid_array;
 struct ref;
-extern int register_shallow(const unsigned char *sha1);
-extern int unregister_shallow(const unsigned char *sha1);
+extern int register_shallow(const struct object_id *oid);
+extern int unregister_shallow(const struct object_id *oid);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
diff --git a/fetch-pack.c b/fetch-pack.c
index 1e6b03b6b..f3aae85d5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -415,7 +415,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (skip_prefix(line, "shallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
 					die(_("invalid shallow line: %s"), line);
-				register_shallow(oid.hash);
+				register_shallow(&oid);
 				continue;
 			}
 			if (skip_prefix(line, "unshallow ", &arg)) {
@@ -426,7 +426,7 @@ static int find_common(struct fetch_pack_args *args,
 				/* make sure that it is parsed as shallow */
 				if (!parse_object(oid.hash))
 					die(_("error in object: %s"), line);
-				if (unregister_shallow(oid.hash))
+				if (unregister_shallow(&oid))
 					die(_("no shallow found: %s"), line);
 				continue;
 			}
diff --git a/shallow.c b/shallow.c
index 25b6db989..c520ae3ae 100644
--- a/shallow.c
+++ b/shallow.c
@@ -27,13 +27,13 @@ void set_alternate_shallow_file(const char *path, int override)
 	alternate_shallow_file = xstrdup_or_null(path);
 }
 
-int register_shallow(const unsigned char *sha1)
+int register_shallow(const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
-	struct commit *commit = lookup_commit(sha1);
+	struct commit *commit = lookup_commit(oid->hash);
 
-	hashcpy(graft->oid.hash, sha1);
+	oidcpy(&graft->oid, oid);
 	graft->nr_parent = -1;
 	if (commit && commit->object.parsed)
 		commit->parents = NULL;
@@ -65,10 +65,10 @@ int is_repository_shallow(void)
 	is_shallow = 1;
 
 	while (fgets(buf, sizeof(buf), fp)) {
-		unsigned char sha1[20];
-		if (get_sha1_hex(buf, sha1))
+		struct object_id oid;
+		if (get_oid_hex(buf, &oid))
 			die("bad shallow line: %s", buf);
-		register_shallow(sha1);
+		register_shallow(&oid);
 	}
 	fclose(fp);
 	return is_shallow;
diff --git a/upload-pack.c b/upload-pack.c
index ffb028d62..20f87cd38 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -642,7 +642,7 @@ static void send_shallow(struct commit_list *result)
 		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
 			packet_write_fmt(1, "shallow %s",
 					 oid_to_hex(&object->oid));
-			register_shallow(object->oid.hash);
+			register_shallow(&object->oid);
 			shallow_nr++;
 		}
 		result = result->next;
@@ -667,7 +667,7 @@ static void send_unshallow(const struct object_array *shallows)
 			 * parse and add the parents to the want list, then
 			 * re-register it.
 			 */
-			unregister_shallow(object->oid.hash);
+			unregister_shallow(&object->oid);
 			object->parsed = 0;
 			parse_commit_or_die((struct commit *)object);
 			parents = ((struct commit *)object)->parents;
@@ -679,7 +679,7 @@ static void send_unshallow(const struct object_array *shallows)
 			add_object_array(object, NULL, &extra_edge_obj);
 		}
 		/* make sure commit traversal conforms to client */
-		register_shallow(object->oid.hash);
+		register_shallow(&object->oid);
 	}
 }
 
@@ -883,7 +883,7 @@ static void receive_needs(void)
 		if (shallows.nr > 0) {
 			int i;
 			for (i = 0; i < shallows.nr; i++)
-				register_shallow(shallows.objects[i].item->oid.hash);
+				register_shallow(&shallows.objects[i].item->oid);
 		}
 
 	shallow_nr += shallows.nr;
