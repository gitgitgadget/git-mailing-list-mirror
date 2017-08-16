Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E051208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 00:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbdHPAcH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 20:32:07 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33967 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752718AbdHPAcF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 20:32:05 -0400
Received: by mail-pg0-f52.google.com with SMTP id u185so15379468pgb.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyIuYe1L/Pb+MPqMHApRBiZLQFrPo3I8TcFQYz8XJpM=;
        b=QjQRdbYbMDm/fifWJ26F3wu4f3gVHVzQtxH9RPKsr3jed2wK6tOia6ULor8RvR0PnR
         vt0ixaK2qll21ofMlW71IFandz0UzZmSiNosZQ5mr6N9AZKhU9TNgnpMzblxkt9Ud/UC
         Jao3YUquye8n459ph6V9llPLWEE07swga60zBobepL6P/FUpCmaJDFIco7yba2qAS7tP
         nH7/bYcDxcM7fKTkTtAO+I0iuD+PgYBvl9GcFYKTVo9dyj3H/duPYmjFF7jUWNKKV87Q
         5WO2h2aykm/dWta0SVDZ9xv5/yJeFs/Eu8wBhCH8osHjcytJS8Wi6hZlSvm56UdHjBkN
         gHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OyIuYe1L/Pb+MPqMHApRBiZLQFrPo3I8TcFQYz8XJpM=;
        b=MZebWoPUUPgCPpD4etOChq7+mXpHIH7cHixDsJrM+oVZSNLfjVQH6wcKfUrgu06chq
         2AwhiLmFjR8+zcMKDMqlZO704+muxDS9dkeYqKvRaqWA/L0N9KTmtkGwHW96wgVJiYqZ
         oTh/OHIXtzQykxZrMWpglRXgY/AhNe1MfT+BpkmjFItf51NmmY2bldxjnLURJxjGkS6C
         Jnnju8rt/Ug0CCa66kdWH2Ycok+/VsaekQYUlkJ7ghsRdshJHNgDOMO/jZVzZ7cEf+tQ
         Q2INbsriTkuFxDYajIVtOVmkN03zARWtNdVvEk82f3nqe54u8sZ7nFH5QdbGnoPtE9cu
         7HRQ==
X-Gm-Message-State: AHYfb5jDFiIahxe9nN1aICoXNYGWqorOLjbXotc2SxEA56hBR63HOxNf
        ZrIpUOHzFLT6QasDrdmZ8w==
X-Received: by 10.99.55.27 with SMTP id e27mr402052pga.70.1502843524479;
        Tue, 15 Aug 2017 17:32:04 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id x7sm19516543pfa.98.2017.08.15.17.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 17:32:03 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peartben@gmail.com, gitster@pobox.com
Subject: [RFC PATCH] Updated "imported object" design
Date:   Tue, 15 Aug 2017 17:32:00 -0700
Message-Id: <20170816003200.19992-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is based on an updated version of my refactoring of
pack-related functions [1].

This corresponds to patch 1 of my previous series [2]. I'm sending this
patch out (before I update the rest) for 2 reasons:
 * to provide a demonstration of how the feature could be implemented,
   in the hope of restarting the discussion
 * to obtain comments about this patch to see if I'm heading in the
   right direction

In an earlier e-mail [3], I suggested that loose objects can also be
marked as ".imported" (formerly ".remote" - after looking at the code, I
decided to use "imported" throughout, since "remote" can be easily
confused as the opposite of "local", used to represent objects in the
local store as opposed to an alternate store).

However, I have only implemented the imported packed objects part -
imported loose objects can be added later.

It still remains to be discussed whether we should mark the imported
objects or the non-imported objects as the source of promises, but I
still think that we should mark the imported objects. In this way, the
new properties (the provision of promises and the mark) coincide on the
same object, and the same things (locally created objects, fetches from
non-lazy-object-serving remotes) behave in the same way regardless of
whether extensions.lazyObject is set (allowing, for example, a repo to
be converted into a promise-enabled one solely through modifying the
configuration).

Also, let me know if there's a better way to send out these patches for
review. Some of the code here has been reviewed before, for example.

[1] https://public-inbox.org/git/cover.1502241234.git.jonathantanmy@google.com/

[2] https://public-inbox.org/git/ffb734d277132802bcc25baa13e8ede3490af62a.1501532294.git.jonathantanmy@google.com/

[3] https://public-inbox.org/git/20170807161031.7c4eae50@twelve2.svl.corp.google.com/
-- 8< --
environment, fsck: introduce lazyobject extension

Currently, Git does not support repos with very large numbers of objects
or repos that wish to minimize manipulation of certain blobs (for
example, because they are very large) very well, even if the user
operates mostly on part of the repo, because Git is designed on the
assumption that every referenced object is available somewhere in the
repo storage. In such an arrangement, the full set of objects is usually
available in remote storage, ready to be lazily downloaded.

Introduce the concept of promises, objects believed by the local repo to
be downloadable from remote storage. An object is a promise if it is
referred to by an object in a specially marked packfile. Any such
promise can be validly referred to, even if the object itself is not in
the local repo.

This functionality is guarded behind a new repository extension option
`extensions.lazyObject`. The value of `extensions.lazyObject` must be a
string. The meaning of this string will be defined in a subsequent
commit.

Teach fsck about the new state of affairs. In this commit, teach fsck
that promises referenced from the reflog are not an error case; in
future commits, fsck will be taught about other cases.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/repository-version.txt |  8 +++
 builtin/fsck.c                                 | 64 +++++++++++++++++++-
 cache.h                                        |  5 +-
 environment.c                                  |  1 +
 pack.h                                         |  1 +
 packfile.c                                     | 13 +++-
 setup.c                                        |  7 ++-
 t/t0410-lazy-object.sh                         | 84 ++++++++++++++++++++++++++
 8 files changed, 177 insertions(+), 6 deletions(-)
 create mode 100755 t/t0410-lazy-object.sh

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad37986..71cb3bfee 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,11 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`lazyObject`
+~~~~~~~~~~~~~~~~~
+
+When the config key `extensions.lazyObject` is set, Git does not treat
+missing objects as errors. The value of `extensions.lazyObject` must be
+a string. NEEDSWORK: define what this string contains when the
+appropriate functionality is implemented.
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf..25265b1fe 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -15,6 +15,7 @@
 #include "progress.h"
 #include "streaming.h"
 #include "decorate.h"
+#include "oidset.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -43,6 +44,67 @@ static int name_objects;
 #define ERROR_PACK 04
 #define ERROR_REFS 010
 
+/*
+ * Objects that are believed to be loadable by the lazy loader, because
+ * they are referred to by an imported object. If an object that we have
+ * refers to such an object even though we don't have that object, it is
+ * not an error.
+ */
+static struct oidset promises;
+static int promises_prepared;
+
+static int add_promise(const struct object_id *oid, struct packed_git *pack,
+		       uint32_t pos, void *data)
+{
+	struct object *obj = parse_object(oid);
+	if (!obj)
+		/*
+		 * Error messages are given when packs are verified, so
+		 * do not print any here.
+		 */
+		return 0;
+	
+	/*
+	 * If this is a tree, commit, or tag, the objects it refers
+	 * to are promises. (Blobs refer to no objects.)
+	 */
+	if (obj->type == OBJ_TREE) {
+		struct tree *tree = (struct tree *) obj;
+		struct tree_desc desc;
+		struct name_entry entry;
+		if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+			/*
+			 * Error messages are given when packs are
+			 * verified, so do not print any here.
+			 */
+			return 0;
+		while (tree_entry_gently(&desc, &entry))
+			oidset_insert(&promises, entry.oid);
+	} else if (obj->type == OBJ_COMMIT) {
+		struct commit *commit = (struct commit *) obj;
+		struct commit_list *parents = commit->parents;
+
+		oidset_insert(&promises, &commit->tree->object.oid);
+		for (; parents; parents = parents->next)
+			oidset_insert(&promises, &parents->item->object.oid);
+	} else if (obj->type == OBJ_TAG) {
+		struct tag *tag = (struct tag *) obj;
+		oidset_insert(&promises, &tag->tagged->oid);
+	}
+	return 0;
+}
+
+static int is_promise(const struct object_id *oid)
+{
+	if (!promises_prepared) {
+		if (repository_format_lazy_object)
+			for_each_packed_object(add_promise, NULL,
+					       FOR_EACH_OBJECT_IMPORTED_ONLY);
+		promises_prepared = 1;
+	}
+	return oidset_contains(&promises, oid);
+}
+
 static const char *describe_object(struct object *obj)
 {
 	static struct strbuf buf = STRBUF_INIT;
@@ -410,7 +472,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
 			obj->used = 1;
 			mark_object_reachable(obj);
-		} else {
+		} else if (!is_promise(oid)) {
 			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
 		}
diff --git a/cache.h b/cache.h
index b15645672..f529096c8 100644
--- a/cache.h
+++ b/cache.h
@@ -853,10 +853,12 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
+extern char *repository_format_lazy_object;
 
 struct repository_format {
 	int version;
 	int precious_objects;
+	char *lazy_object;
 	int is_bare;
 	char *work_tree;
 	struct string_list unknown_extensions;
@@ -1584,7 +1586,8 @@ extern struct packed_git {
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 freshened:1,
-		 do_not_close:1;
+		 do_not_close:1,
+		 pack_imported:1;
 	unsigned char sha1[20];
 	struct revindex_entry *revindex;
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/environment.c b/environment.c
index 3fd4b1084..cd8ef2897 100644
--- a/environment.c
+++ b/environment.c
@@ -27,6 +27,7 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
+char *repository_format_lazy_object;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/pack.h b/pack.h
index 6aae1a7c3..7c196c6cd 100644
--- a/pack.h
+++ b/pack.h
@@ -229,6 +229,7 @@ extern int has_pack_index(const unsigned char *sha1);
  * repository and any alternates repositories (unless the
  * FOR_EACH_OBJECT_LOCAL_ONLY flag, defined in cache.h, is set).
  */
+#define FOR_EACH_OBJECT_IMPORTED_ONLY 2
 typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
diff --git a/packfile.c b/packfile.c
index 2f008ede7..90028f9af 100644
--- a/packfile.c
+++ b/packfile.c
@@ -637,10 +637,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 		return NULL;
 
 	/*
-	 * ".pack" is long enough to hold any suffix we're adding (and
+	 * ".imported" is long enough to hold any suffix we're adding (and
 	 * the use xsnprintf double-checks that)
 	 */
-	alloc = st_add3(path_len, strlen(".pack"), 1);
+	alloc = st_add3(path_len, strlen(".imported"), 1);
 	p = alloc_packed_git(alloc);
 	memcpy(p->pack_name, path, path_len);
 
@@ -648,6 +648,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;
 
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".imported");
+	if (!access(p->pack_name, F_OK))
+		p->pack_imported = 1;
+
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
@@ -775,7 +779,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (ends_with(de->d_name, ".idx") ||
 		    ends_with(de->d_name, ".pack") ||
 		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep"))
+		    ends_with(de->d_name, ".keep") ||
+		    ends_with(de->d_name, ".imported"))
 			string_list_append(&garbage, path.buf);
 		else
 			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
@@ -1893,6 +1898,8 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	for (p = packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
+		if ((flags & FOR_EACH_OBJECT_IMPORTED_ONLY) && !p->pack_imported)
+			continue;
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;
diff --git a/setup.c b/setup.c
index 860507e1f..94cfde3cc 100644
--- a/setup.c
+++ b/setup.c
@@ -425,7 +425,11 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
-		else
+		else if (!strcmp(ext, "lazyobject")) {
+			if (!value)
+				return config_error_nonbool(var);
+			data->lazy_object = xstrdup(value);
+		} else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
 		data->is_bare = git_config_bool(var, value);
@@ -468,6 +472,7 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	}
 
 	repository_format_precious_objects = candidate.precious_objects;
+	repository_format_lazy_object = candidate.lazy_object;
 	string_list_clear(&candidate.unknown_extensions, 0);
 	if (!has_common) {
 		if (candidate.is_bare != -1) {
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
new file mode 100755
index 000000000..2368150d4
--- /dev/null
+++ b/t/t0410-lazy-object.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='lazy object'
+
+. ./test-lib.sh
+
+delete_object () {
+	rm $1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40)
+}
+
+pack_imported_object() {
+	printf "%s" "$1" | git -C repo pack-objects .git/objects/pack/pack &&
+	(
+		cd repo/.git/objects/pack &&
+		>$(basename --suffix=.pack *.pack).imported
+	)
+}
+
+test_expect_success 'missing reflog object referred to by imported commit passes fsck' '
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	C=$(git -C repo commit-tree -m c -p $A HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	# Designate $C, which refers to $A, as an imported object
+	pack_imported_object "$C\n" &&
+
+	# Normally, it fails
+	test_must_fail git -C repo fsck &&
+
+	# But with the extension, it succeeds
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_expect_success 'missing reflog object referred to by imported tag passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	git -C repo tag -a -m d my_tag_name $A &&
+	T=$(git -C repo rev-parse my_tag_name) &&
+	git -C repo tag -d my_tag_name &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	# Designate $T, which refers to $A, as an imported object
+	pack_imported_object "$T\n" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_expect_success 'missing reflog object alone fails fsck, even with extension set' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	test_must_fail git -C repo fsck
+'
+
+test_done
-- 
2.14.1.480.gb18f417b89-goog

