Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00452EEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245707AbjIHXLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245588AbjIHXLx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:11:53 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6AA1FFD
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:11:40 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39378)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdY-006MnX-0B; Fri, 08 Sep 2023 17:11:40 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdW-009u13-J3; Fri, 08 Sep 2023 17:11:39 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:24 -0500
Message-Id: <20230908231049.2035003-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdW-009u13-J3;;;mid=<20230908231049.2035003-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/UrenUi31HcNm9AzhjB6F0oB4iJg56YJ4=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 07/32] loose: add a mapping between SHA-1 and SHA-256 for loose objects
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

As part of the transition plan, we'd like to add a file in the .git
directory that maps loose objects between SHA-1 and SHA-256.  Let's
implement the specification in the transition plan and store this data
on a per-repository basis in struct repository.

****
- split repo_object_map between repo_loose_object_map_oid and
  repo_oid_to_algop.
- Verified the loose_map is set in repo_loose_object_map_oid

-- EWB

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 Makefile              |   1 +
 loose.c               | 243 ++++++++++++++++++++++++++++++++++++++++++
 loose.h               |  20 ++++
 object-file-convert.c |  14 ++-
 object-store-ll.h     |   3 +
 object.c              |   2 +
 repository.c          |   6 ++
 7 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 loose.c
 create mode 100644 loose.h

diff --git a/Makefile b/Makefile
index f7e824f25cda..3c18664def9a 100644
--- a/Makefile
+++ b/Makefile
@@ -1053,6 +1053,7 @@ LIB_OBJS += list-objects-filter.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
+LIB_OBJS += loose.o
 LIB_OBJS += ls-refs.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
diff --git a/loose.c b/loose.c
new file mode 100644
index 000000000000..8ddb7112a541
--- /dev/null
+++ b/loose.c
@@ -0,0 +1,243 @@
+#include "git-compat-util.h"
+#include "hash.h"
+#include "path.h"
+#include "object-store.h"
+#include "hex.h"
+#include "wrapper.h"
+#include "gettext.h"
+#include "loose.h"
+#include "lockfile.h"
+
+static const char *loose_object_header = "# loose-object-idx\n";
+
+static inline int should_use_loose_object_map(struct repository *repo)
+{
+	return repo->compat_hash_algo && repo->gitdir;
+}
+
+void loose_object_map_init(struct loose_object_map **map)
+{
+	struct loose_object_map *m;
+	m = xmalloc(sizeof(**map));
+	m->to_compat = kh_init_oid_map();
+	m->to_storage = kh_init_oid_map();
+	*map = m;
+}
+
+static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const struct object_id *value)
+{
+	khiter_t pos;
+	int ret;
+	struct object_id *stored;
+
+	pos = kh_put_oid_map(map, *key, &ret);
+
+	/* This item already exists in the map. */
+	if (ret == 0)
+		return 0;
+
+	stored = xmalloc(sizeof(*stored));
+	oidcpy(stored, value);
+	kh_value(map, pos) = stored;
+	return 1;
+}
+
+static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
+{
+	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
+	FILE *fp;
+
+	if (!dir->loose_map)
+		loose_object_map_init(&dir->loose_map);
+
+	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
+	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_tree, repo->hash_algo->empty_tree);
+
+	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
+	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_blob, repo->hash_algo->empty_blob);
+
+	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
+	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->null_oid, repo->hash_algo->null_oid);
+
+	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	fp = fopen(path.buf, "rb");
+	if (!fp)
+		return 0;
+
+	errno = 0;
+	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header))
+		goto err;
+	while (!strbuf_getline_lf(&buf, fp)) {
+		const char *p;
+		struct object_id oid, compat_oid;
+		if (parse_oid_hex_algop(buf.buf, &oid, &p, repo->hash_algo) ||
+		    *p++ != ' ' ||
+		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
+		    p != buf.buf + buf.len)
+			goto err;
+		insert_oid_pair(dir->loose_map->to_compat, &oid, &compat_oid);
+		insert_oid_pair(dir->loose_map->to_storage, &compat_oid, &oid);
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return errno ? -1 : 0;
+err:
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return -1;
+}
+
+int repo_read_loose_object_map(struct repository *repo)
+{
+	struct object_directory *dir;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	prepare_alt_odb(repo);
+
+	for (dir = repo->objects->odb; dir; dir = dir->next) {
+		if (load_one_loose_object_map(repo, dir) < 0) {
+			return -1;
+		}
+	}
+	return 0;
+}
+
+int repo_write_loose_object_map(struct repository *repo)
+{
+	kh_oid_map_t *map = repo->objects->odb->loose_map->to_compat;
+	struct lock_file lock;
+	int fd;
+	khiter_t iter;
+	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
+	iter = kh_begin(map);
+	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
+		goto errout;
+
+	for (; iter != kh_end(map); iter++) {
+		if (kh_exist(map, iter)) {
+			if (oideq(&kh_key(map, iter), the_hash_algo->empty_tree) ||
+			    oideq(&kh_key(map, iter), the_hash_algo->empty_blob))
+				continue;
+			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
+			if (write_in_full(fd, buf.buf, buf.len) < 0)
+				goto errout;
+			strbuf_reset(&buf);
+		}
+	}
+	strbuf_release(&buf);
+	if (commit_lock_file(&lock) < 0) {
+		error_errno(_("could not write loose object index %s"), path.buf);
+		strbuf_release(&path);
+		return -1;
+	}
+	strbuf_release(&path);
+	return 0;
+errout:
+	rollback_lock_file(&lock);
+	strbuf_release(&buf);
+	error_errno(_("failed to write loose object index %s\n"), path.buf);
+	strbuf_release(&path);
+	return -1;
+}
+
+static int write_one_object(struct repository *repo, const struct object_id *oid,
+			    const struct object_id *compat_oid)
+{
+	struct lock_file lock;
+	int fd;
+	struct stat st;
+	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
+
+	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
+
+	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
+	if (fd < 0)
+		goto errout;
+	if (fstat(fd, &st) < 0)
+		goto errout;
+	if (!st.st_size && write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
+		goto errout;
+
+	strbuf_addf(&buf, "%s %s\n", oid_to_hex(oid), oid_to_hex(compat_oid));
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		goto errout;
+	if (close(fd))
+		goto errout;
+	adjust_shared_perm(path.buf);
+	rollback_lock_file(&lock);
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return 0;
+errout:
+	error_errno(_("failed to write loose object index %s\n"), path.buf);
+	close(fd);
+	rollback_lock_file(&lock);
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return -1;
+}
+
+int repo_add_loose_object_map(struct repository *repo, const struct object_id *oid,
+			      const struct object_id *compat_oid)
+{
+	int inserted = 0;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	inserted |= insert_oid_pair(repo->objects->odb->loose_map->to_compat, oid, compat_oid);
+	inserted |= insert_oid_pair(repo->objects->odb->loose_map->to_storage, compat_oid, oid);
+	if (inserted)
+		return write_one_object(repo, oid, compat_oid);
+	return 0;
+}
+
+int repo_loose_object_map_oid(struct repository *repo, struct object_id *dest,
+			      const struct git_hash_algo *to,
+			      const struct object_id *src)
+{
+	struct object_directory *dir;
+	kh_oid_map_t *map;
+	khiter_t pos;
+
+	for (dir = repo->objects->odb; dir; dir = dir->next) {
+		struct loose_object_map *loose_map = dir->loose_map;
+		if (!loose_map)
+			continue;
+		map = (to == repo->compat_hash_algo) ?
+			loose_map->to_compat :
+			loose_map->to_storage;
+		pos = kh_get_oid_map(map, *src);
+		if (pos < kh_end(map)) {
+			oidcpy(dest, kh_value(map, pos));
+			return 0;
+		}
+	}
+	return -1;
+}
+
+void loose_object_map_clear(struct loose_object_map **map)
+{
+	struct loose_object_map *m = *map;
+	struct object_id *oid;
+
+	if (!m)
+		return;
+
+	kh_foreach_value(m->to_compat, oid, free(oid));
+	kh_foreach_value(m->to_storage, oid, free(oid));
+	kh_destroy_oid_map(m->to_compat);
+	kh_destroy_oid_map(m->to_storage);
+	free(m);
+	*map = NULL;
+}
diff --git a/loose.h b/loose.h
new file mode 100644
index 000000000000..061c6937aead
--- /dev/null
+++ b/loose.h
@@ -0,0 +1,20 @@
+#ifndef LOOSE_H
+#define LOOSE_H
+
+#include "khash.h"
+
+struct loose_object_map {
+	kh_oid_map_t *to_compat;
+	kh_oid_map_t *to_storage;
+};
+
+void loose_object_map_init(struct loose_object_map **map);
+void loose_object_map_clear(struct loose_object_map **map);
+int repo_loose_object_map_oid(struct repository *repo, struct object_id *dest,
+	const struct git_hash_algo *dest_algo, const struct object_id *src);
+int repo_add_loose_object_map(struct repository *repo, const struct object_id *oid,
+			      const struct object_id *compat_oid);
+int repo_read_loose_object_map(struct repository *repo);
+int repo_write_loose_object_map(struct repository *repo);
+
+#endif
diff --git a/object-file-convert.c b/object-file-convert.c
index 9f4d5b354f5f..e7c62434016d 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -4,6 +4,7 @@
 #include "repository.h"
 #include "hash-ll.h"
 #include "object.h"
+#include "loose.h"
 #include "object-file-convert.h"
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
@@ -21,7 +22,18 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 			oidcpy(dest, src);
 		return 0;
 	}
-	return -1;
+	if (repo_loose_object_map_oid(repo, dest, to, src)) {
+		/*
+		 * We may have loaded the object map at repo initialization but
+		 * another process (perhaps upstream of a pipe from us) may have
+		 * written a new object into the map.  If the object is missing,
+		 * let's reload the map to see if the object has appeared.
+		 */
+		repo_read_loose_object_map(repo);
+		if (repo_loose_object_map_oid(repo, dest, to, src))
+			return -1;
+	}
+	return 0;
 }
 
 int convert_object_file(struct strbuf *outbuf,
diff --git a/object-store-ll.h b/object-store-ll.h
index 26a3895c821c..bc76d6bec80d 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -26,6 +26,9 @@ struct object_directory {
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oidtree *loose_objects_cache;
 
+	/* Map between object IDs for loose objects. */
+	struct loose_object_map *loose_map;
+
 	/*
 	 * This is a temporary object store created by the tmp_objdir
 	 * facility. Disable ref updates since the objects in the store
diff --git a/object.c b/object.c
index 2c61e4c86217..186a0a47c0fb 100644
--- a/object.c
+++ b/object.c
@@ -13,6 +13,7 @@
 #include "alloc.h"
 #include "packfile.h"
 #include "commit-graph.h"
+#include "loose.h"
 
 unsigned int get_max_object_index(void)
 {
@@ -540,6 +541,7 @@ void free_object_directory(struct object_directory *odb)
 {
 	free(odb->path);
 	odb_clear_loose_cache(odb);
+	loose_object_map_clear(&odb->loose_map);
 	free(odb);
 }
 
diff --git a/repository.c b/repository.c
index de620d82bfc6..4ab44d3b0344 100644
--- a/repository.c
+++ b/repository.c
@@ -14,6 +14,7 @@
 #include "read-cache-ll.h"
 #include "remote.h"
 #include "setup.h"
+#include "loose.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
 #include "trace2.h"
@@ -112,6 +113,8 @@ void repo_enable_compat_map(struct repository *repo, int enable_compat)
 			GIT_HASH_SHA1];
 
 	repo->compat_hash_algo = enable_compat ? other_algo : NULL;
+	if (enable_compat)
+		repo_read_loose_object_map(repo);
 }
 
 /*
@@ -204,6 +207,9 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	if (repo->compat_hash_algo)
+		repo_read_loose_object_map(repo);
+
 	clear_repository_format(&format);
 	return 0;
 
-- 
2.41.0

