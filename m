Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A7ED201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 00:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdBTALS (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 19:11:18 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36362 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752014AbdBTAKw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Feb 2017 19:10:52 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 50237280B9;
        Mon, 20 Feb 2017 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487549446;
        bh=06e4PHd1ii+p/H1lNShFufVP7Va/cItw6kp3vAAHsZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrIZgdbBFyUlxp1C7L/3CkvfUN7tUNz2ykbjpWnwGeqiO5L4tXGqNQ6V3DqFxuuob
         QqW9qnOUYYYHh+SAOIdTblYN0MeHJX939xQ2uT19zb6yoyhuAnGZQSmtjrjWlzaGb0
         Z6san4tCFdlErOjcxuaZQRgCRT7I6OJ5HbtiVgS1B/bEe35VhtSqcjepLu2HaEz7nU
         nNRTfGqhCQmllk68UPKIWom50p+IQtNVKmga+NF+igWt7zsami3awLpYvhJcvum8Nz
         8EiTPqKR1/mwzOVSMR/7Ox7oya1dmj3PgaClQatEikN5uCzwcKWVcV8fXBw58clN+u
         5WOISDZqTFUAuhDp4z0ISP4fsWPxgfq6mKmZfacK7tVl3Ai1CorbWffuZpZFUsfZA6
         /qyzHzXLV8bN/45vQqPmraNfNOPuC48Y848Cskk11l4TOIP4RftO7ihOq/CG28PPwC
         va6upSuZNx9T0RNSxo81HKBvjzKdQAlm1if1bcjxDaffGLmP3bB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 12/19] builtin/replace: convert to struct object_id
Date:   Mon, 20 Feb 2017 00:10:24 +0000
Message-Id: <20170220001031.559931-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170220001031.559931-1-sandals@crustytoothpaste.net>
References: <20170220001031.559931-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert various uses of unsigned char [20] to struct object_id.  Rename
replace_object_sha1 to replace_object_oid.  Finally, specify a constant
in terms of GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/replace.c | 112 +++++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b58c714cb8..f7716a5472 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -88,78 +88,78 @@ static int list_replace_refs(const char *pattern, const char *format)
 }
 
 typedef int (*each_replace_name_fn)(const char *name, const char *ref,
-				    const unsigned char *sha1);
+				    const struct object_id *oid);
 
 static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 {
 	const char **p, *full_hex;
 	char ref[PATH_MAX];
 	int had_error = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	for (p = argv; *p; p++) {
-		if (get_sha1(*p, sha1)) {
+		if (get_oid(*p, &oid)) {
 			error("Failed to resolve '%s' as a valid ref.", *p);
 			had_error = 1;
 			continue;
 		}
-		full_hex = sha1_to_hex(sha1);
+		full_hex = oid_to_hex(&oid);
 		snprintf(ref, sizeof(ref), "%s%s", git_replace_ref_base, full_hex);
 		/* read_ref() may reuse the buffer */
 		full_hex = ref + strlen(git_replace_ref_base);
-		if (read_ref(ref, sha1)) {
+		if (read_ref(ref, oid.hash)) {
 			error("replace ref '%s' not found.", full_hex);
 			had_error = 1;
 			continue;
 		}
-		if (fn(full_hex, ref, sha1))
+		if (fn(full_hex, ref, &oid))
 			had_error = 1;
 	}
 	return had_error;
 }
 
 static int delete_replace_ref(const char *name, const char *ref,
-			      const unsigned char *sha1)
+			      const struct object_id *oid)
 {
-	if (delete_ref(ref, sha1, 0))
+	if (delete_ref(ref, oid->hash, 0))
 		return 1;
 	printf("Deleted replace ref '%s'\n", name);
 	return 0;
 }
 
-static void check_ref_valid(unsigned char object[20],
-			    unsigned char prev[20],
+static void check_ref_valid(struct object_id *object,
+			    struct object_id *prev,
 			    char *ref,
 			    int ref_size,
 			    int force)
 {
 	if (snprintf(ref, ref_size,
 		     "%s%s", git_replace_ref_base,
-		     sha1_to_hex(object)) > ref_size - 1)
+		     oid_to_hex(object)) > ref_size - 1)
 		die("replace ref name too long: %.*s...", 50, ref);
 	if (check_refname_format(ref, 0))
 		die("'%s' is not a valid ref name.", ref);
 
-	if (read_ref(ref, prev))
-		hashclr(prev);
+	if (read_ref(ref, prev->hash))
+		oidclr(prev);
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 }
 
-static int replace_object_sha1(const char *object_ref,
-			       unsigned char object[20],
+static int replace_object_oid(const char *object_ref,
+			       struct object_id *object,
 			       const char *replace_ref,
-			       unsigned char repl[20],
+			       struct object_id *repl,
 			       int force)
 {
-	unsigned char prev[20];
+	struct object_id prev;
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	obj_type = sha1_object_info(object, NULL);
-	repl_type = sha1_object_info(repl, NULL);
+	obj_type = sha1_object_info(object->hash, NULL);
+	repl_type = sha1_object_info(repl->hash, NULL);
 	if (!force && obj_type != repl_type)
 		die("Objects must be of the same type.\n"
 		    "'%s' points to a replaced object of type '%s'\n"
@@ -167,11 +167,11 @@ static int replace_object_sha1(const char *object_ref,
 		    object_ref, typename(obj_type),
 		    replace_ref, typename(repl_type));
 
-	check_ref_valid(object, prev, ref, sizeof(ref), force);
+	check_ref_valid(object, &prev, ref, sizeof(ref), force);
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, repl, prev,
+	    ref_transaction_update(transaction, ref, repl->hash, prev.hash,
 				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
@@ -182,14 +182,14 @@ static int replace_object_sha1(const char *object_ref,
 
 static int replace_object(const char *object_ref, const char *replace_ref, int force)
 {
-	unsigned char object[20], repl[20];
+	struct object_id object, repl;
 
-	if (get_sha1(object_ref, object))
+	if (get_oid(object_ref, &object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
-	if (get_sha1(replace_ref, repl))
+	if (get_oid(replace_ref, &repl))
 		die("Failed to resolve '%s' as a valid ref.", replace_ref);
 
-	return replace_object_sha1(object_ref, object, replace_ref, repl, force);
+	return replace_object_oid(object_ref, &object, replace_ref, &repl, force);
 }
 
 /*
@@ -197,7 +197,7 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
  * If "raw" is true, then the object's raw contents are printed according to
  * "type". Otherwise, we pretty-print the contents for human editing.
  */
-static void export_object(const unsigned char *sha1, enum object_type type,
+static void export_object(const struct object_id *oid, enum object_type type,
 			  int raw, const char *filename)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -213,7 +213,7 @@ static void export_object(const unsigned char *sha1, enum object_type type,
 		argv_array_push(&cmd.args, typename(type));
 	else
 		argv_array_push(&cmd.args, "-p");
-	argv_array_push(&cmd.args, sha1_to_hex(sha1));
+	argv_array_push(&cmd.args, oid_to_hex(oid));
 	cmd.git_cmd = 1;
 	cmd.out = fd;
 
@@ -226,7 +226,7 @@ static void export_object(const unsigned char *sha1, enum object_type type,
  * interpreting it as "type", and writing the result to the object database.
  * The sha1 of the written object is returned via sha1.
  */
-static void import_object(unsigned char *sha1, enum object_type type,
+static void import_object(struct object_id *oid, enum object_type type,
 			  int raw, const char *filename)
 {
 	int fd;
@@ -254,7 +254,7 @@ static void import_object(unsigned char *sha1, enum object_type type,
 
 		if (finish_command(&cmd))
 			die("mktree reported failure");
-		if (get_sha1_hex(result.buf, sha1) < 0)
+		if (get_oid_hex(result.buf, oid) < 0)
 			die("mktree did not return an object name");
 
 		strbuf_release(&result);
@@ -264,7 +264,7 @@ static void import_object(unsigned char *sha1, enum object_type type,
 
 		if (fstat(fd, &st) < 0)
 			die_errno("unable to fstat %s", filename);
-		if (index_fd(sha1, fd, &st, type, NULL, flags) < 0)
+		if (index_fd(oid->hash, fd, &st, type, NULL, flags) < 0)
 			die("unable to write object to database");
 		/* index_fd close()s fd for us */
 	}
@@ -279,29 +279,29 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 {
 	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
 	enum object_type type;
-	unsigned char old[20], new[20], prev[20];
+	struct object_id old, new, prev;
 	char ref[PATH_MAX];
 
-	if (get_sha1(object_ref, old) < 0)
+	if (get_oid(object_ref, &old) < 0)
 		die("Not a valid object name: '%s'", object_ref);
 
-	type = sha1_object_info(old, NULL);
+	type = sha1_object_info(old.hash, NULL);
 	if (type < 0)
-		die("unable to get object type for %s", sha1_to_hex(old));
+		die("unable to get object type for %s", oid_to_hex(&old));
 
-	check_ref_valid(old, prev, ref, sizeof(ref), force);
+	check_ref_valid(&old, &prev, ref, sizeof(ref), force);
 
-	export_object(old, type, raw, tmpfile);
+	export_object(&old, type, raw, tmpfile);
 	if (launch_editor(tmpfile, NULL, NULL) < 0)
 		die("editing object file failed");
-	import_object(new, type, raw, tmpfile);
+	import_object(&new, type, raw, tmpfile);
 
 	free(tmpfile);
 
-	if (!hashcmp(old, new))
-		return error("new object is the same as the old one: '%s'", sha1_to_hex(old));
+	if (!oidcmp(&old, &new))
+		return error("new object is the same as the old one: '%s'", oid_to_hex(&old));
 
-	return replace_object_sha1(object_ref, old, "replacement", new, force);
+	return replace_object_oid(object_ref, &old, "replacement", &new, force);
 }
 
 static void replace_parents(struct strbuf *buf, int argc, const char **argv)
@@ -312,7 +312,7 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 
 	/* find existing parents */
 	parent_start = buf->buf;
-	parent_start += 46; /* "tree " + "hex sha1" + "\n" */
+	parent_start += GIT_SHA1_HEXSZ + 6; /* "tree " + "hex sha1" + "\n" */
 	parent_end = parent_start;
 
 	while (starts_with(parent_end, "parent "))
@@ -320,11 +320,11 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 
 	/* prepare new parents */
 	for (i = 0; i < argc; i++) {
-		unsigned char sha1[20];
-		if (get_sha1(argv[i], sha1) < 0)
+		struct object_id oid;
+		if (get_oid(argv[i], &oid) < 0)
 			die(_("Not a valid object name: '%s'"), argv[i]);
-		lookup_commit_or_die(sha1, argv[i]);
-		strbuf_addf(&new_parents, "parent %s\n", sha1_to_hex(sha1));
+		lookup_commit_or_die(oid.hash, argv[i]);
+		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
 	}
 
 	/* replace existing parents with new ones */
@@ -345,12 +345,12 @@ static void check_one_mergetag(struct commit *commit,
 {
 	struct check_mergetag_data *mergetag_data = (struct check_mergetag_data *)data;
 	const char *ref = mergetag_data->argv[0];
-	unsigned char tag_sha1[20];
+	struct object_id tag_oid;
 	struct tag *tag;
 	int i;
 
-	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), tag_sha1);
-	tag = lookup_tag(tag_sha1);
+	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), tag_oid.hash);
+	tag = lookup_tag(tag_oid.hash);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
@@ -366,7 +366,7 @@ static void check_one_mergetag(struct commit *commit,
 	}
 
 	die(_("original commit '%s' contains mergetag '%s' that is discarded; "
-	      "use --edit instead of --graft"), ref, sha1_to_hex(tag_sha1));
+	      "use --edit instead of --graft"), ref, oid_to_hex(&tag_oid));
 }
 
 static void check_mergetags(struct commit *commit, int argc, const char **argv)
@@ -380,16 +380,16 @@ static void check_mergetags(struct commit *commit, int argc, const char **argv)
 
 static int create_graft(int argc, const char **argv, int force)
 {
-	unsigned char old[20], new[20];
+	struct object_id old, new;
 	const char *old_ref = argv[0];
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *buffer;
 	unsigned long size;
 
-	if (get_sha1(old_ref, old) < 0)
+	if (get_oid(old_ref, &old) < 0)
 		die(_("Not a valid object name: '%s'"), old_ref);
-	commit = lookup_commit_or_die(old, old_ref);
+	commit = lookup_commit_or_die(old.hash, old_ref);
 
 	buffer = get_commit_buffer(commit, &size);
 	strbuf_add(&buf, buffer, size);
@@ -404,15 +404,15 @@ static int create_graft(int argc, const char **argv, int force)
 
 	check_mergetags(commit, argc, argv);
 
-	if (write_sha1_file(buf.buf, buf.len, commit_type, new))
+	if (write_sha1_file(buf.buf, buf.len, commit_type, new.hash))
 		die(_("could not write replacement commit for: '%s'"), old_ref);
 
 	strbuf_release(&buf);
 
-	if (!hashcmp(old, new))
-		return error("new commit is the same as the old one: '%s'", sha1_to_hex(old));
+	if (!oidcmp(&old, &new))
+		return error("new commit is the same as the old one: '%s'", oid_to_hex(&old));
 
-	return replace_object_sha1(old_ref, old, "replacement", new, force);
+	return replace_object_oid(old_ref, &old, "replacement", &new, force);
 }
 
 int cmd_replace(int argc, const char **argv, const char *prefix)
-- 
2.11.0

