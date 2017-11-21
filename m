Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6D82036D
	for <e@80x24.org>; Tue, 21 Nov 2017 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdKUU7G (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 15:59:06 -0500
Received: from siwi.pair.com ([209.68.5.199]:63937 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdKUU7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 15:59:04 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1D98D844F5;
        Tue, 21 Nov 2017 15:59:04 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A223B844E7;
        Tue, 21 Nov 2017 15:59:03 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 1/6] dir: allow exclusions from blob in addition to file
Date:   Tue, 21 Nov 2017 20:58:47 +0000
Message-Id: <20171121205852.15731-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171121205852.15731-1-git@jeffhostetler.com>
References: <20171121205852.15731-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Refactor add_excludes() to separate the reading of the
exclude file into a buffer and the parsing of the buffer
into exclude_list items.

Add add_excludes_from_blob_to_list() to allow an exclude
file be specified with an OID without assuming a local
worktree or index exists.

Refactor read_skip_worktree_file_from_index() and add
do_read_blob() to eliminate duplication of preliminary
processing of blob contents.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 dir.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 dir.h |   3 ++
 2 files changed, 104 insertions(+), 31 deletions(-)

diff --git a/dir.c b/dir.c
index 1d17b80..1962374 100644
--- a/dir.c
+++ b/dir.c
@@ -220,6 +220,57 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
+/*
+ * Read the contents of the blob with the given OID into a buffer.
+ * Append a trailing LF to the end if the last line doesn't have one.
+ *
+ * Returns:
+ *    -1 when the OID is invalid or unknown or does not refer to a blob.
+ *     0 when the blob is empty.
+ *     1 along with { data, size } of the (possibly augmented) buffer
+ *       when successful.
+ *
+ * Optionally updates the given sha1_stat with the given OID (when valid).
+ */
+static int do_read_blob(const struct object_id *oid,
+			struct sha1_stat *sha1_stat,
+			size_t *size_out,
+			char **data_out)
+{
+	enum object_type type;
+	unsigned long sz;
+	char *data;
+
+	*size_out = 0;
+	*data_out = NULL;
+
+	data = read_sha1_file(oid->hash, &type, &sz);
+	if (!data || type != OBJ_BLOB) {
+		free(data);
+		return -1;
+	}
+
+	if (sha1_stat) {
+		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
+		hashcpy(sha1_stat->sha1, oid->hash);
+	}
+
+	if (sz == 0) {
+		free(data);
+		return 0;
+	}
+
+	if (data[sz - 1] != '\n') {
+		data = xrealloc(data, st_add(sz, 1));
+		data[sz++] = '\n';
+	}
+
+	*size_out = xsize_t(sz);
+	*data_out = data;
+
+	return 1;
+}
+
 #define DO_MATCH_EXCLUDE   (1<<0)
 #define DO_MATCH_DIRECTORY (1<<1)
 #define DO_MATCH_SUBMODULE (1<<2)
@@ -600,32 +651,22 @@ void add_exclude(const char *string, const char *base,
 	x->el = el;
 }
 
-static void *read_skip_worktree_file_from_index(const struct index_state *istate,
-						const char *path, size_t *size,
-						struct sha1_stat *sha1_stat)
+static int read_skip_worktree_file_from_index(const struct index_state *istate,
+					      const char *path,
+					      size_t *size_out,
+					      char **data_out,
+					      struct sha1_stat *sha1_stat)
 {
 	int pos, len;
-	unsigned long sz;
-	enum object_type type;
-	void *data;
 
 	len = strlen(path);
 	pos = index_name_pos(istate, path, len);
 	if (pos < 0)
-		return NULL;
+		return -1;
 	if (!ce_skip_worktree(istate->cache[pos]))
-		return NULL;
-	data = read_sha1_file(istate->cache[pos]->oid.hash, &type, &sz);
-	if (!data || type != OBJ_BLOB) {
-		free(data);
-		return NULL;
-	}
-	*size = xsize_t(sz);
-	if (sha1_stat) {
-		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
-		hashcpy(sha1_stat->sha1, istate->cache[pos]->oid.hash);
-	}
-	return data;
+		return -1;
+
+	return do_read_blob(&istate->cache[pos]->oid, sha1_stat, size_out, data_out);
 }
 
 /*
@@ -739,6 +780,10 @@ static void invalidate_directory(struct untracked_cache *uc,
 		dir->dirs[i]->recurse = 0;
 }
 
+static int add_excludes_from_buffer(char *buf, size_t size,
+				    const char *base, int baselen,
+				    struct exclude_list *el);
+
 /*
  * Given a file with name "fname", read it (either from disk, or from
  * an index if 'istate' is non-null), parse it and store the
@@ -754,9 +799,10 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			struct sha1_stat *sha1_stat)
 {
 	struct stat st;
-	int fd, i, lineno = 1;
+	int r;
+	int fd;
 	size_t size = 0;
-	char *buf, *entry;
+	char *buf;
 
 	fd = open(fname, O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0) {
@@ -764,17 +810,13 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			warn_on_fopen_errors(fname);
 		else
 			close(fd);
-		if (!istate ||
-		    (buf = read_skip_worktree_file_from_index(istate, fname, &size, sha1_stat)) == NULL)
+		if (!istate)
 			return -1;
-		if (size == 0) {
-			free(buf);
-			return 0;
-		}
-		if (buf[size-1] != '\n') {
-			buf = xrealloc(buf, st_add(size, 1));
-			buf[size++] = '\n';
-		}
+		r = read_skip_worktree_file_from_index(istate, fname,
+						       &size, &buf,
+						       sha1_stat);
+		if (r != 1)
+			return r;
 	} else {
 		size = xsize_t(st.st_size);
 		if (size == 0) {
@@ -813,6 +855,17 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		}
 	}
 
+	add_excludes_from_buffer(buf, size, base, baselen, el);
+	return 0;
+}
+
+static int add_excludes_from_buffer(char *buf, size_t size,
+				    const char *base, int baselen,
+				    struct exclude_list *el)
+{
+	int i, lineno = 1;
+	char *entry;
+
 	el->filebuf = buf;
 
 	if (skip_utf8_bom(&buf, size))
@@ -841,6 +894,23 @@ int add_excludes_from_file_to_list(const char *fname, const char *base,
 	return add_excludes(fname, base, baselen, el, istate, NULL);
 }
 
+int add_excludes_from_blob_to_list(
+	struct object_id *oid,
+	const char *base, int baselen,
+	struct exclude_list *el)
+{
+	char *buf;
+	size_t size;
+	int r;
+
+	r = do_read_blob(oid, NULL, &size, &buf);
+	if (r != 1)
+		return r;
+
+	add_excludes_from_buffer(buf, size, base, baselen, el);
+	return 0;
+}
+
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
 				      int group_type, const char *src)
 {
diff --git a/dir.h b/dir.h
index e371705..1bcf391 100644
--- a/dir.h
+++ b/dir.h
@@ -256,6 +256,9 @@ extern struct exclude_list *add_exclude_list(struct dir_struct *dir,
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
 					  struct exclude_list *el, struct  index_state *istate);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
+extern int add_excludes_from_blob_to_list(struct object_id *oid,
+					  const char *base, int baselen,
+					  struct exclude_list *el);
 extern void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
-- 
2.9.3

