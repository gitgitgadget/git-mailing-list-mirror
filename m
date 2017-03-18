Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B00D2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdCRVWz (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:22:55 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46136 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751133AbdCRVWe (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:22:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 600AC280BC;
        Sat, 18 Mar 2017 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872004;
        bh=tu7e+qixT4jJwyzK9kJ+Lp2NaHWcX4yA+CtgQkcPvnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Zsml6AMU2Hb6kahQiWAMdUfmjK7nZn0NdyIhwdE1FHRcC2I/8tUYnNeyuo6cJJgR
         tPtayRmcIVYCuYky1Ab9G6MULKjYooaHrfUnujgQ7xj+yJbuLiEEUtlP/c5mFmDLxl
         FXCTFMikKz56l3/PivzoZq/3lwiPtyXT4qxevgYM1hmATBRHxLpTFh+2nljDpzBxWC
         mi3qc7K+UklHUJxNG5cY8dVOqWFvhDfEUX7DRya09EI1zxtYruwC9CJXFfwfgfJ3gs
         TUU9wq0VNlZm8fbazlg4Env9ABdRiaLHfF8bGfOj+D8N88ohlJdotffMRAjezD5+Zo
         GJJLEh3jRQzotTiJQL69wVOxcTQ1uT1pCwh6kuvqdBbx7/Zt4PWMRfU7WMIsnOEFtD
         RabHV29LEq6HT7vyldJAeKHu5YeAJ9xROf6eKx4SgvIurvN31vNo4cCAu0vvmarvkg
         pvw42MsMJNoQcP5ljy77oFyj+OqAOe5iqfbvq6xxmht2LFyJbul
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/20] Make sha1_array_append take a struct object_id *
Date:   Sat, 18 Mar 2017 21:19:49 +0000
Message-Id: <20170318211954.564030-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the callers to pass struct object_id by changing the function
declaration and definition and applying the following semantic patch:

@@
expression E1, E2, E3;
@@
- sha1_array_append(E1, E2[E3].hash)
+ sha1_array_append(E1, E2 + E3)

@@
expression E1, E2;
@@
- sha1_array_append(E1, E2.hash)
+ sha1_array_append(E1, &E2)

@@
expression E1, E2;
@@
- sha1_array_append(E1, E2->hash)
+ sha1_array_append(E1, E2)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c                   | 4 ++--
 builtin/cat-file.c         | 4 ++--
 builtin/diff.c             | 2 +-
 builtin/pack-objects.c     | 4 ++--
 builtin/pull.c             | 2 +-
 builtin/receive-pack.c     | 6 +++---
 combine-diff.c             | 2 +-
 connect.c                  | 4 ++--
 fetch-pack.c               | 8 ++++----
 fsck.c                     | 2 +-
 parse-options-cb.c         | 2 +-
 sha1-array.c               | 4 ++--
 sha1-array.h               | 2 +-
 sha1_name.c                | 2 +-
 submodule.c                | 6 +++---
 t/helper/test-sha1-array.c | 2 +-
 transport.c                | 6 ++++--
 17 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/bisect.c b/bisect.c
index ebaf7b05ba..886e630884 100644
--- a/bisect.c
+++ b/bisect.c
@@ -413,9 +413,9 @@ static int register_ref(const char *refname, const struct object_id *oid,
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		oidcpy(current_bad_oid, oid);
 	} else if (starts_with(refname, good_prefix.buf)) {
-		sha1_array_append(&good_revs, oid->hash);
+		sha1_array_append(&good_revs, oid);
 	} else if (starts_with(refname, "skip-")) {
-		sha1_array_append(&skipped_revs, oid->hash);
+		sha1_array_append(&skipped_revs, oid);
 	}
 
 	strbuf_release(&good_prefix);
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8b85cb8cf0..8fbb667170 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -413,7 +413,7 @@ static int batch_loose_object(const struct object_id *oid,
 			      const char *path,
 			      void *data)
 {
-	sha1_array_append(data, oid->hash);
+	sha1_array_append(data, oid);
 	return 0;
 }
 
@@ -422,7 +422,7 @@ static int batch_packed_object(const struct object_id *oid,
 			       uint32_t pos,
 			       void *data)
 {
-	sha1_array_append(data, oid->hash);
+	sha1_array_append(data, oid);
 	return 0;
 }
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 398eee00d5..a5b34eb156 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -193,7 +193,7 @@ static int builtin_diff_combined(struct rev_info *revs,
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	for (i = 1; i < ents; i++)
-		sha1_array_append(&parents, ent[i].item->oid.hash);
+		sha1_array_append(&parents, &ent[i].item->oid);
 	diff_tree_combined(ent[0].item->oid.hash, &parents,
 			   revs->dense_combined_merges, revs);
 	sha1_array_clear(&parents);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 16517f2637..dfeacd5c37 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2739,12 +2739,12 @@ static void record_recent_object(struct object *obj,
 				 const char *name,
 				 void *data)
 {
-	sha1_array_append(&recent_objects, obj->oid.hash);
+	sha1_array_append(&recent_objects, &obj->oid);
 }
 
 static void record_recent_commit(struct commit *commit, void *data)
 {
-	sha1_array_append(&recent_objects, commit->object.oid.hash);
+	sha1_array_append(&recent_objects, &commit->object.oid);
 }
 
 static void get_object_list(int ac, const char **av)
diff --git a/builtin/pull.c b/builtin/pull.c
index c007900ab5..183e377147 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -344,7 +344,7 @@ static void get_merge_heads(struct sha1_array *merge_heads)
 			continue;  /* invalid line: does not start with SHA1 */
 		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge\t"))
 			continue;  /* ref is not-for-merge */
-		sha1_array_append(merge_heads, oid.hash);
+		sha1_array_append(merge_heads, &oid);
 	}
 	fclose(fp);
 	strbuf_release(&sb);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7dfbb5f46b..4b282ac53e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -842,7 +842,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		if (si->used_shallow[i] &&
 		    (si->used_shallow[i][cmd->index / 32] & mask) &&
 		    !delayed_reachability_test(si, i))
-			sha1_array_append(&extra, si->shallow->oid[i].hash);
+			sha1_array_append(&extra, si->shallow->oid + i);
 
 	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
@@ -1550,7 +1550,7 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			if (get_oid_hex(line + 8, &oid))
 				die("protocol error: expected shallow sha, got '%s'",
 				    line + 8);
-			sha1_array_append(shallow, oid.hash);
+			sha1_array_append(shallow, &oid);
 			continue;
 		}
 
@@ -1821,7 +1821,7 @@ static void update_shallow_info(struct command *commands,
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (is_null_oid(&cmd->new_oid))
 			continue;
-		sha1_array_append(ref, cmd->new_oid.hash);
+		sha1_array_append(ref, &cmd->new_oid);
 		cmd->index = ref->nr - 1;
 	}
 	si->ref = ref;
diff --git a/combine-diff.c b/combine-diff.c
index a5b86d7eb9..c92029484c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1535,7 +1535,7 @@ void diff_tree_combined_merge(const struct commit *commit, int dense,
 	struct sha1_array parents = SHA1_ARRAY_INIT;
 
 	while (parent) {
-		sha1_array_append(&parents, parent->item->object.oid.hash);
+		sha1_array_append(&parents, &parent->item->object.oid);
 		parent = parent->next;
 	}
 	diff_tree_combined(commit->object.oid.hash, &parents, dense, rev);
diff --git a/connect.c b/connect.c
index 7d65c1c736..50b503da0d 100644
--- a/connect.c
+++ b/connect.c
@@ -153,7 +153,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				die("protocol error: expected shallow sha-1, got '%s'", arg);
 			if (!shallow_points)
 				die("repository on the other end cannot be shallow");
-			sha1_array_append(shallow_points, old_oid.hash);
+			sha1_array_append(shallow_points, &old_oid);
 			continue;
 		}
 
@@ -169,7 +169,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		}
 
 		if (extra_have && !strcmp(name, ".have")) {
-			sha1_array_append(extra_have, old_oid.hash);
+			sha1_array_append(extra_have, &old_oid);
 			continue;
 		}
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 543e8aa9e1..f4bbd2892a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1042,7 +1042,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
 			if (has_object_file(&oid[i]))
-				sha1_array_append(&extra, oid[i].hash);
+				sha1_array_append(&extra, oid + i);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
 						&alternate_shallow_file,
@@ -1060,7 +1060,7 @@ static void update_shallow(struct fetch_pack_args *args,
 	if (!si->nr_ours && !si->nr_theirs)
 		return;
 	for (i = 0; i < nr_sought; i++)
-		sha1_array_append(&ref, sought[i]->old_oid.hash);
+		sha1_array_append(&ref, &sought[i]->old_oid);
 	si->ref = &ref;
 
 	if (args->update_shallow) {
@@ -1078,9 +1078,9 @@ static void update_shallow(struct fetch_pack_args *args,
 			return;
 		}
 		for (i = 0; i < si->nr_ours; i++)
-			sha1_array_append(&extra, oid[si->ours[i]].hash);
+			sha1_array_append(&extra, oid + si->ours[i]);
 		for (i = 0; i < si->nr_theirs; i++)
-			sha1_array_append(&extra, oid[si->theirs[i]].hash);
+			sha1_array_append(&extra, oid + si->theirs[i]);
 		setup_alternate_shallow(&shallow_lock,
 					&alternate_shallow_file,
 					&extra);
diff --git a/fsck.c b/fsck.c
index 8f41e692bb..6682de1de5 100644
--- a/fsck.c
+++ b/fsck.c
@@ -156,7 +156,7 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 			break;
 		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n')
 			die("Invalid SHA-1: %s", buffer);
-		sha1_array_append(&skiplist, oid.hash);
+		sha1_array_append(&skiplist, &oid);
 		if (sorted && skiplist.nr > 1 &&
 				oidcmp(&skiplist.oid[skiplist.nr - 2],
 				       &oid) > 0)
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 40ece4d8c2..7baecdc864 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -106,7 +106,7 @@ int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 		return -1;
 	if (get_oid(arg, &oid))
 		return error(_("malformed object name '%s'"), arg);
-	sha1_array_append(opt->value, oid.hash);
+	sha1_array_append(opt->value, &oid);
 	return 0;
 }
 
diff --git a/sha1-array.c b/sha1-array.c
index 093d158003..26e596b264 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -2,10 +2,10 @@
 #include "sha1-array.h"
 #include "sha1-lookup.h"
 
-void sha1_array_append(struct sha1_array *array, const unsigned char *sha1)
+void sha1_array_append(struct sha1_array *array, const struct object_id *oid)
 {
 	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
-	hashcpy(array->oid[array->nr++].hash, sha1);
+	oidcpy(&array->oid[array->nr++], oid);
 	array->sorted = 0;
 }
 
diff --git a/sha1-array.h b/sha1-array.h
index c1f706acba..7b06fbf1c1 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -10,7 +10,7 @@ struct sha1_array {
 
 #define SHA1_ARRAY_INIT { NULL, 0, 0, 0 }
 
-void sha1_array_append(struct sha1_array *array, const unsigned char *sha1);
+void sha1_array_append(struct sha1_array *array, const struct object_id *sha1);
 int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1);
 void sha1_array_clear(struct sha1_array *array);
 
diff --git a/sha1_name.c b/sha1_name.c
index 2e38aedfa5..1316832d73 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -428,7 +428,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 static int collect_ambiguous(const struct object_id *oid, void *data)
 {
-	sha1_array_append(data, oid->hash);
+	sha1_array_append(data, oid);
 	return 0;
 }
 
diff --git a/submodule.c b/submodule.c
index 5c5c18ec3d..7912cba4f6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -650,7 +650,7 @@ static void collect_submodules_from_diff(struct diff_queue_struct *q,
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 		commits = submodule_commits(submodules, p->two->path);
-		sha1_array_append(commits, p->two->oid.hash);
+		sha1_array_append(commits, &p->two->oid);
 	}
 }
 
@@ -817,7 +817,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 static int add_sha1_to_array(const char *ref, const struct object_id *oid,
 			     int flags, void *data)
 {
-	sha1_array_append(data, oid->hash);
+	sha1_array_append(data, oid);
 	return 0;
 }
 
@@ -828,7 +828,7 @@ void check_for_new_submodule_commits(struct object_id *oid)
 		initialized_fetch_ref_tips = 1;
 	}
 
-	sha1_array_append(&ref_tips_after_fetch, oid->hash);
+	sha1_array_append(&ref_tips_after_fetch, oid);
 }
 
 static int add_sha1_to_argv(const unsigned char sha1[20], void *data)
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index b4bb97fccc..181c36e0a5 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -19,7 +19,7 @@ int cmd_main(int argc, const char **argv)
 		if (skip_prefix(line.buf, "append ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
-			sha1_array_append(&array, oid.hash);
+			sha1_array_append(&array, &oid);
 		} else if (skip_prefix(line.buf, "lookup ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
diff --git a/transport.c b/transport.c
index 8a90b0c29b..e492757726 100644
--- a/transport.c
+++ b/transport.c
@@ -1027,7 +1027,8 @@ int transport_push(struct transport *transport,
 
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
-					sha1_array_append(&commits, ref->new_oid.hash);
+					sha1_array_append(&commits,
+							  &ref->new_oid);
 
 			if (!push_unpushed_submodules(&commits,
 						      transport->remote->name,
@@ -1048,7 +1049,8 @@ int transport_push(struct transport *transport,
 
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
-					sha1_array_append(&commits, ref->new_oid.hash);
+					sha1_array_append(&commits,
+							  &ref->new_oid);
 
 			if (find_unpushed_submodules(&commits, transport->remote->name,
 						&needs_pushing)) {
