From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v0 1/3] index_fd(): turn write_object and format_check
 arguments into one flag
Date: Sun,  8 May 2011 01:47:33 -0700
Message-ID: <1304844455-23570-2-git-send-email-gitster@pobox.com>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 10:47:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIzeZ-0004V0-0Q
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 10:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab1EHIrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 04:47:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab1EHIrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 04:47:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 28FB24DFD
	for <git@vger.kernel.org>; Sun,  8 May 2011 04:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QWt9
	OVScCKFeIUN+bQ1cfHv7yZU=; b=XNwAJr5Bf1Sc+ilBZZChzQjnn2VnrHTteAmf
	GBlYkVJKFPT8colKdxgyVlkHo1EWbLM7NxFdjmY6tGj2OLr9hVTtpbqazurLhL7a
	Oy4WuG4jyVQgljcFK0JtfWeaHXRSdMUr7DqooWYZFF4iVGW2MdQAqBL0gxILAa1C
	UIpWM0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=mCUBUm
	4lgkoljSQ9EYn4qZClnDDy5QeKNqxMVBaM597SV1N5JtXDGPGYAaLNNg/89cD2N6
	tlv22TnOWmuKdtYpji34zRtfTul01aRCvPd/e0rTM5AADG/aVQ8pRELef0AIEySo
	hzoV8hKBIKnNyR0Tz4qLzW84IZZaR2kk2f37c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 261C34DF3
	for <git@vger.kernel.org>; Sun,  8 May 2011 04:49:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16A0C4DF2 for
 <git@vger.kernel.org>; Sun,  8 May 2011 04:49:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.268.gce5bd
In-Reply-To: <1304844455-23570-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1EACE7B0-7950-11E0-A0D4-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173081>

The "format_check" parameter tucked after the existing parameters is too
ugly an afterthought to live in any reasonable API.

Combine it with the other boolean parameter "write_object" into a single
"flags" parameter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c  |    5 ++++-
 builtin/update-index.c |    3 ++-
 cache.h                |    7 +++++--
 notes-merge.c          |    2 +-
 read-cache.c           |    4 ++--
 sha1_file.c            |   29 +++++++++++++----------------
 6 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index b96f46a..33911fd 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -14,8 +14,11 @@ static void hash_fd(int fd, const char *type, int write_object, const char *path
 {
 	struct stat st;
 	unsigned char sha1[20];
+	unsigned flags = (HASH_FORMAT_CHECK |
+			  (write_object ? HASH_WRITE_OBJECT : 0));
+
 	if (fstat(fd, &st) < 0 ||
-	    index_fd(sha1, fd, &st, write_object, type_from_string(type), path, 1))
+	    index_fd(sha1, fd, &st, type_from_string(type), path, flags))
 		die(write_object
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d7850c6..f14bc90 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -99,7 +99,8 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(ce->sha1, path, st, !info_only))
+	if (index_path(ce->sha1, path, st,
+		       info_only ? 0 : HASH_WRITE_OBJECT))
 		return -1;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
diff --git a/cache.h b/cache.h
index 2b34116..2be5333 100644
--- a/cache.h
+++ b/cache.h
@@ -518,8 +518,11 @@ struct pathspec {
 extern int init_pathspec(struct pathspec *, const char **);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec);
-extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path, int format_check);
-extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
+
+#define HASH_WRITE_OBJECT 1
+#define HASH_FORMAT_CHECK 2
+extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
+extern int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
diff --git a/notes-merge.c b/notes-merge.c
index 28046a9..e1aaf43 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -707,7 +707,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		/* write file as blob, and add to partial_tree */
 		if (stat(ent->name, &st))
 			die_errno("Failed to stat '%s'", ent->name);
-		if (index_path(blob_sha1, ent->name, &st, 1))
+		if (index_path(blob_sha1, ent->name, &st, HASH_WRITE_OBJECT))
 			die("Failed to write blob object from '%s'", ent->name);
 		if (add_note(partial_tree, obj_sha1, blob_sha1, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
diff --git a/read-cache.c b/read-cache.c
index f38471c..4ac9a03 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -92,7 +92,7 @@ static int ce_compare_data(struct cache_entry *ce, struct stat *st)
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, 0, OBJ_BLOB, ce->name, 0))
+		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
 			match = hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
@@ -641,7 +641,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		return 0;
 	}
 	if (!intent_only) {
-		if (index_path(ce->sha1, path, st, 1))
+		if (index_path(ce->sha1, path, st, HASH_WRITE_OBJECT))
 			return error("unable to index file %s", path);
 	} else
 		record_intent_to_add(ce);
diff --git a/sha1_file.c b/sha1_file.c
index 889fe71..17c179c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2581,10 +2581,11 @@ static void check_tag(const void *buf, size_t size)
 }
 
 static int index_mem(unsigned char *sha1, void *buf, size_t size,
-		     int write_object, enum object_type type,
-		     const char *path, int format_check)
+		     enum object_type type,
+		     const char *path, unsigned flags)
 {
 	int ret, re_allocated = 0;
+	int write_object = flags & HASH_WRITE_OBJECT;
 
 	if (!type)
 		type = OBJ_BLOB;
@@ -2600,7 +2601,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 			re_allocated = 1;
 		}
 	}
-	if (format_check) {
+	if (flags & HASH_FORMAT_CHECK) {
 		if (type == OBJ_TREE)
 			check_tree(buf, size);
 		if (type == OBJ_COMMIT)
@@ -2620,8 +2621,8 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 
 #define SMALL_FILE_SIZE (32*1024)
 
-int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
-	     enum object_type type, const char *path, int format_check)
+int index_fd(unsigned char *sha1, int fd, struct stat *st,
+	     enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
 	size_t size = xsize_t(st->st_size);
@@ -2629,33 +2630,29 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	if (!S_ISREG(st->st_mode)) {
 		struct strbuf sbuf = STRBUF_INIT;
 		if (strbuf_read(&sbuf, fd, 4096) >= 0)
-			ret = index_mem(sha1, sbuf.buf, sbuf.len, write_object,
-					type, path, format_check);
+			ret = index_mem(sha1, sbuf.buf, sbuf.len, type,	path, flags);
 		else
 			ret = -1;
 		strbuf_release(&sbuf);
 	} else if (!size) {
-		ret = index_mem(sha1, NULL, size, write_object, type, path,
-				format_check);
+		ret = index_mem(sha1, NULL, size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
-			ret = index_mem(sha1, buf, size, write_object, type,
-					path, format_check);
+			ret = index_mem(sha1, buf, size, type, path, flags);
 		else
 			ret = error("short read %s", strerror(errno));
 		free(buf);
 	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(sha1, buf, size, write_object, type, path,
-				format_check);
+		ret = index_mem(sha1, buf, size, type, path, flags);
 		munmap(buf, size);
 	}
 	close(fd);
 	return ret;
 }
 
-int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object)
+int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags)
 {
 	int fd;
 	struct strbuf sb = STRBUF_INIT;
@@ -2666,7 +2663,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 		if (fd < 0)
 			return error("open(\"%s\"): %s", path,
 				     strerror(errno));
-		if (index_fd(sha1, fd, st, write_object, OBJ_BLOB, path, 0) < 0)
+		if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
@@ -2676,7 +2673,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 			return error("readlink(\"%s\"): %s", path,
 			             errstr);
 		}
-		if (!write_object)
+		if (!(flags & HASH_WRITE_OBJECT))
 			hash_sha1_file(sb.buf, sb.len, blob_type, sha1);
 		else if (write_sha1_file(sb.buf, sb.len, blob_type, sha1))
 			return error("%s: failed to insert into database",
-- 
1.7.5.1.268.gce5bd
