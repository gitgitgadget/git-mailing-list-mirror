Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB192095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdCRVWu (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:22:50 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46156 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751179AbdCRVWf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:22:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5DE2E280BF;
        Sat, 18 Mar 2017 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872005;
        bh=ELeoN2VnYF1IZn/xa+SEHlVtMpiPCajWe4AwEnyMTgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxtMsVH4y6iBnR0XRvJf2422EZjaRywU7tMt4kL2b9qFcun9qiMtzw1xQj8A61TiB
         Y3n09sSgv6mKxjVk4J6QCSihpo7nuaxQRZGCfz9e4R0Lcc9OGoJzYrGQvZz65Fa3bk
         zgN9LgLibnG1ojQTPOliQjpp7cavl8od7PfsqA2WprycuRaTvNYkIL4Z+M1RkKV5Oz
         i4fHUTNDvwrcqvQ/4UCFBamJv1P72kOI50cvLMroO6Xu+R4VpOkXMNBhoORphelKIE
         fueMu6WakDyn1iWyxDrow8a2lxPl6qxtcscarn7Le6FM8F7D6uZ5QR9Lna8hALlxLK
         gXMOdb6GDDo+LRlje9yTPUjMKEx9sllpy5RolUx+f3LSBhz4fV6/L5UriHK7ZnVVBs
         KNS8ClFjgPzmFzQQe70K8ecrzbX059ojY9EJ2lpIMUrNgLrBUjAHXDEtx/7bkRHIT4
         PSMqHCQXN0qQvtmDWwZj+txp1jX3jvr9XFgseMwShzEF1ZMo4Ra
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/20] Convert sha1_array_for_each_unique and for_each_abbrev to object_id
Date:   Sat, 18 Mar 2017 21:19:52 +0000
Message-Id: <20170318211954.564030-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sha1_array_for_each_unique take a callback using struct object_id.
Since one of these callbacks is an argument to for_each_abbrev, convert
those as well.  Rename various functions, replacing "sha1" with "oid".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/cat-file.c         |  4 ++--
 builtin/receive-pack.c     | 12 ++++++------
 builtin/rev-parse.c        |  4 ++--
 cache.h                    |  2 +-
 sha1-array.c               |  4 ++--
 sha1-array.h               |  6 +++---
 sha1_name.c                | 14 ++++++--------
 submodule.c                | 20 ++++++++++----------
 t/helper/test-sha1-array.c |  6 +++---
 9 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8fbb667170..eb0043231d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -401,10 +401,10 @@ struct object_cb_data {
 	struct expand_data *expand;
 };
 
-static int batch_object_cb(const unsigned char sha1[20], void *vdata)
+static int batch_object_cb(const struct object_id *oid, void *vdata)
 {
 	struct object_cb_data *data = vdata;
-	hashcpy(data->expand->oid.hash, sha1);
+	oidcpy(&data->expand->oid, oid);
 	batch_object_write(NULL, data->opt, data->expand);
 	return 0;
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4b282ac53e..88927a8169 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -225,10 +225,10 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static void show_ref(const char *path, const unsigned char *sha1)
+static void show_ref(const char *path, const struct object_id *oid)
 {
 	if (sent_capabilities) {
-		packet_write_fmt(1, "%s %s\n", sha1_to_hex(sha1), path);
+		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), path);
 	} else {
 		struct strbuf cap = STRBUF_INIT;
 
@@ -244,7 +244,7 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			strbuf_addstr(&cap, " push-options");
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write_fmt(1, "%s %s%c%s\n",
-			     sha1_to_hex(sha1), path, 0, cap.buf);
+			     oid_to_hex(oid), path, 0, cap.buf);
 		strbuf_release(&cap);
 		sent_capabilities = 1;
 	}
@@ -271,7 +271,7 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	} else {
 		oidset_insert(seen, oid);
 	}
-	show_ref(path, oid->hash);
+	show_ref(path, oid);
 	return 0;
 }
 
@@ -284,7 +284,7 @@ static void show_one_alternate_ref(const char *refname,
 	if (oidset_insert(seen, oid))
 		return;
 
-	show_ref(".have", oid->hash);
+	show_ref(".have", oid);
 }
 
 static void write_head_info(void)
@@ -295,7 +295,7 @@ static void write_head_info(void)
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
 	if (!sent_capabilities)
-		show_ref("capabilities^{}", null_sha1);
+		show_ref("capabilities^{}", &null_oid);
 
 	advertise_shallow_grafts(1);
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2549643267..24f679bd89 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -205,9 +205,9 @@ static int anti_reference(const char *refname, const struct object_id *oid, int
 	return 0;
 }
 
-static int show_abbrev(const unsigned char *sha1, void *cb_data)
+static int show_abbrev(const struct object_id *oid, void *cb_data)
 {
-	show_rev(NORMAL, sha1, NULL);
+	show_rev(NORMAL, oid->hash, NULL);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 5cdd9cd229..991d82d6f3 100644
--- a/cache.h
+++ b/cache.h
@@ -1343,7 +1343,7 @@ extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char
 
 extern int get_oid(const char *str, struct object_id *oid);
 
-typedef int each_abbrev_fn(const unsigned char *sha1, void *);
+typedef int each_abbrev_fn(const struct object_id *oid, void *);
 extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
 
 extern int set_disambiguate_hint_config(const char *var, const char *value);
diff --git a/sha1-array.c b/sha1-array.c
index 1082b3dc11..82a7f4435c 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -43,7 +43,7 @@ void sha1_array_clear(struct sha1_array *array)
 }
 
 int sha1_array_for_each_unique(struct sha1_array *array,
-				for_each_sha1_fn fn,
+				for_each_oid_fn fn,
 				void *data)
 {
 	int i;
@@ -55,7 +55,7 @@ int sha1_array_for_each_unique(struct sha1_array *array,
 		int ret;
 		if (i > 0 && !oidcmp(array->oid + i, array->oid + i - 1))
 			continue;
-		ret = fn(array->oid[i].hash, data);
+		ret = fn(array->oid + i, data);
 		if (ret)
 			return ret;
 	}
diff --git a/sha1-array.h b/sha1-array.h
index 4cc55b15af..e2bb139efb 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -14,10 +14,10 @@ void sha1_array_append(struct sha1_array *array, const struct object_id *sha1);
 int sha1_array_lookup(struct sha1_array *array, const struct object_id *oid);
 void sha1_array_clear(struct sha1_array *array);
 
-typedef int (*for_each_sha1_fn)(const unsigned char sha1[20],
-				void *data);
+typedef int (*for_each_oid_fn)(const struct object_id *oid,
+			       void *data);
 int sha1_array_for_each_unique(struct sha1_array *array,
-			       for_each_sha1_fn fn,
+			       for_each_oid_fn fn,
 			       void *data);
 
 #endif /* SHA1_ARRAY_H */
diff --git a/sha1_name.c b/sha1_name.c
index 1316832d73..a9501fb964 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -342,34 +342,32 @@ static int init_object_disambiguation(const char *name, int len,
 	return 0;
 }
 
-static int show_ambiguous_object(const unsigned char *sha1, void *data)
+static int show_ambiguous_object(const struct object_id *oid, void *data)
 {
 	const struct disambiguate_state *ds = data;
-	struct object_id oid;
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
 
-	hashcpy(oid.hash, sha1);
-	if (ds->fn && !ds->fn(&oid, ds->cb_data))
+	if (ds->fn && !ds->fn(oid, ds->cb_data))
 		return 0;
 
-	type = sha1_object_info(sha1, NULL);
+	type = sha1_object_info(oid->hash, NULL);
 	if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(sha1);
+		struct commit *commit = lookup_commit(oid->hash);
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
 			format_commit_message(commit, " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(sha1);
+		struct tag *tag = lookup_tag(oid->hash);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
 
 	advise("  %s %s%s",
-	       find_unique_abbrev(sha1, DEFAULT_ABBREV),
+	       find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
 	       typename(type) ? typename(type) : "unknown type",
 	       desc.buf);
 
diff --git a/submodule.c b/submodule.c
index 7912cba4f6..29dd91c793 100644
--- a/submodule.c
+++ b/submodule.c
@@ -551,18 +551,18 @@ static int has_remote(const char *refname, const struct object_id *oid,
 	return 1;
 }
 
-static int append_sha1_to_argv(const unsigned char sha1[20], void *data)
+static int append_oid_to_argv(const struct object_id *oid, void *data)
 {
 	struct argv_array *argv = data;
-	argv_array_push(argv, sha1_to_hex(sha1));
+	argv_array_push(argv, oid_to_hex(oid));
 	return 0;
 }
 
-static int check_has_commit(const unsigned char sha1[20], void *data)
+static int check_has_commit(const struct object_id *oid, void *data)
 {
 	int *has_commit = data;
 
-	if (!lookup_commit_reference(sha1))
+	if (!lookup_commit_reference(oid->hash))
 		*has_commit = 0;
 
 	return 0;
@@ -601,7 +601,7 @@ static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
 		int needs_pushing = 0;
 
 		argv_array_push(&cp.args, "rev-list");
-		sha1_array_for_each_unique(commits, append_sha1_to_argv, &cp.args);
+		sha1_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
 		argv_array_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
 
 		prepare_submodule_repo_env(&cp.env_array);
@@ -687,7 +687,7 @@ int find_unpushed_submodules(struct sha1_array *commits,
 
 	/* argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&argv, "find_unpushed_submodules");
-	sha1_array_for_each_unique(commits, append_sha1_to_argv, &argv);
+	sha1_array_for_each_unique(commits, append_oid_to_argv, &argv);
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
@@ -831,9 +831,9 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	sha1_array_append(&ref_tips_after_fetch, oid);
 }
 
-static int add_sha1_to_argv(const unsigned char sha1[20], void *data)
+static int add_oid_to_argv(const struct object_id *oid, void *data)
 {
-	argv_array_push(data, sha1_to_hex(sha1));
+	argv_array_push(data, oid_to_hex(oid));
 	return 0;
 }
 
@@ -850,10 +850,10 @@ static void calculate_changed_submodule_paths(void)
 	init_revisions(&rev, NULL);
 	argv_array_push(&argv, "--"); /* argv[0] program name */
 	sha1_array_for_each_unique(&ref_tips_after_fetch,
-				   add_sha1_to_argv, &argv);
+				   add_oid_to_argv, &argv);
 	argv_array_push(&argv, "--not");
 	sha1_array_for_each_unique(&ref_tips_before_fetch,
-				   add_sha1_to_argv, &argv);
+				   add_oid_to_argv, &argv);
 	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index 3680511849..2f3d406b63 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -1,9 +1,9 @@
 #include "cache.h"
 #include "sha1-array.h"
 
-static int print_sha1(const unsigned char sha1[20], void *data)
+static int print_oid(const struct object_id *oid, void *data)
 {
-	puts(sha1_to_hex(sha1));
+	puts(oid_to_hex(oid));
 	return 0;
 }
 
@@ -27,7 +27,7 @@ int cmd_main(int argc, const char **argv)
 		} else if (!strcmp(line.buf, "clear"))
 			sha1_array_clear(&array);
 		else if (!strcmp(line.buf, "for_each_unique"))
-			sha1_array_for_each_unique(&array, print_sha1, NULL);
+			sha1_array_for_each_unique(&array, print_oid, NULL);
 		else
 			die("unknown command: %s", line.buf);
 	}
