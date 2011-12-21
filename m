From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: [PATCH 3/6] Add MD support for packfiles, fast-import, and pruning.
Date: Tue, 20 Dec 2011 23:11:16 -0800
Message-ID: <1324451476.1684.21.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 21 08:11:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdGKf-00007U-VQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 08:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab1LUHLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 02:11:15 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36462 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab1LUHLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 02:11:13 -0500
Received: by iaeh11 with SMTP id h11so11460970iae.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 23:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=p5p8ci2JjVbltVLbm+B8wlobvx6NgEl0w6xoKYFgJlo=;
        b=JNgo5hNO2JJGrIvIP74dazt8I7TPle6vQaUcx2jwj66428di1PYRncR3Kt6n4gkQEH
         O0Jwg6DUw8jJP0uhlQs4yfJHQ8sp5GEmvi6SEYA3K2j0AOToG9CRipfkB/maxuNVUY9s
         hpQMe6dk97DNVosT4ZpYYkXirCNKfSMrmtMd8=
Received: by 10.50.6.233 with SMTP id e9mr1608535iga.17.1324451472797;
        Tue, 20 Dec 2011 23:11:12 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id f32sm10532668ibf.9.2011.12.20.23.11.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 23:11:11 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187553>

The utilities for creating and querying pack files,
for the fast-import of files, and for pruning a
git repository were modified to support message digests
(either in individual files or in 'mds' files that
parallel pack index files).

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 builtin/count-objects.c   |   92 +++++++++++++++++++++++++++++-
 builtin/index-pack.c      |  139 +++++++++++++++++++++++++++++++++++++++++----
 builtin/pack-objects.c    |   81 ++++++++++++++++++++++++++-
 builtin/pack-redundant.c  |   14 ++++-
 builtin/prune-packed.c    |   21 ++++++-
 builtin/prune.c           |    1 +
 builtin/verify-pack.c     |   14 ++++-
 fast-import.c             |   77 ++++++++++++++++++++++++-
 git-repack.sh             |   12 +++-
 t/t5300-pack-object.sh    |   17 +++++-
 t/t5301-sliding-window.sh |   14 ++++-
 t/t5302-pack-index.sh     |    6 +-
 t/t5304-prune.sh          |   13 +++--
 t/t9300-fast-import.sh    |    8 ++-
 14 files changed, 467 insertions(+), 42 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index c37cb98..47135e1 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -8,6 +8,12 @@
 #include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "mdsdb.h"
+
+int mdsmode = 0;
+unsigned long has_loose_mds = 0;
+unsigned long loose_mds_missing = 0;
+
 
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
@@ -53,20 +59,37 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 			continue;
 		}
 		(*loose)++;
-		if (!verbose)
+		if (!verbose) {
+			if (mdsmode) {
+				if (get_sha1_hex(hex, sha1)) {
+					die("internal error");
+				} else if (mdsdb_lookup(NULL, sha1, NULL) > 0) {
+					has_loose_mds++;
+				} else {
+					loose_mds_missing++;
+				}
+			}
 			continue;
+		}
 		memcpy(hex, path+len, 2);
 		memcpy(hex+2, ent->d_name, 38);
 		hex[40] = 0;
 		if (get_sha1_hex(hex, sha1))
 			die("internal error");
+		if (mdsmode) {
+			if (mdsdb_lookup(NULL, sha1, NULL) > 0) {
+				has_loose_mds++;
+			} else {
+				loose_mds_missing++;
+			}
+		}
 		if (has_sha1_pack(sha1))
 			(*packed_loose)++;
 	}
 }
 
 static char const * const count_objects_usage[] = {
-	"git count-objects [-v]",
+	"git count-objects [-v] [-M]",
 	NULL
 };
 
@@ -80,6 +103,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	off_t loose_size = 0;
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT_BOOLEAN('M', "count-md", &mdsmode,
+			    "count MDs (Message Digests)"),
 		OPT_END(),
 	};
 
@@ -90,6 +115,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] != '/')
 		path[len++] = '/';
+	mdsdb_open(NULL);
 	for (i = 0; i < 256; i++) {
 		DIR *d;
 		sprintf(path + len, "%02x", i);
@@ -100,10 +126,16 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			      &loose, &loose_size, &packed_loose, &garbage);
 		closedir(d);
 	}
+	mdsdb_close(NULL);
 	if (verbose) {
 		struct packed_git *p;
 		unsigned long num_pack = 0;
 		off_t size_pack = 0;
+		unsigned long mds_mismatched = 0;
+		unsigned long missing_mdsfile_count = 0;
+		unsigned long mds_count = 0;
+		int wsize = 0;
+		mdigest_t digest;
 		if (!packed_git)
 			prepare_packed_git();
 		for (p = packed_git; p; p = p->next) {
@@ -114,6 +146,40 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			packed += p->num_objects;
 			size_pack += p->pack_size + p->index_size;
 			num_pack++;
+			if (!mdsmode)
+				continue;
+			if (open_pack_mds(p)) {
+				missing_mdsfile_count++;
+				continue;
+			}
+			/*
+			 * Assume mds version 1 for now. We check that
+			 * the mds file has the right size and record if it
+			 * doesn't.  If it is the right size, we go through
+			 * all the entries and count the number of sha1 hashes
+			 * for which there is a recorded CRC.  We do not
+			 * check if the CRC is the right one for the
+			 * corresponding object: run git pack-verify to do
+			 * that.
+			 */
+			if (p->mds_size > 7) {
+			  wsize = ((unsigned char *)(p->mds_data))[7] * 4;
+			}
+			if (p->mds_size == (size_t)8 +
+			    (((size_t)
+			      ((p->num_objects)/4 + (p->num_objects % 4 != 0))
+			      * (size_t)4 * (size_t)(1 + wsize)) +
+			     (size_t)(20 * 2))) {
+				for (i = 0; i < p->num_objects; i++) {
+					mds_count +=
+					  (nth_packed_object_mdigest(p,
+								      i,
+								      &digest)
+					   == 1);
+				}
+			} else {
+			  mds_mismatched++;
+			}
 		}
 		printf("count: %lu\n", loose);
 		printf("size: %lu\n", (unsigned long) (loose_size / 1024));
@@ -122,9 +188,31 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		printf("size-pack: %lu\n", (unsigned long) (size_pack / 1024));
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
+		if (mdsmode) {
+			if (missing_mdsfile_count) {
+				printf("missing MD (Message Digest) "
+				       "files: %lu\n",
+					missing_mdsfile_count);
+			}
+			if (mds_mismatched)
+				printf("MD (Message Digest) files with"
+				       " wrong size: %lu "
+				       "(file extension = .mds)\n",
+					mds_mismatched);
+			if (packed != mds_count) {
+				printf("missing MD (Message Digest)"
+				       " count: %lu\n",
+				       packed - mds_count);
+			}
+		}
 	}
 	else
 		printf("%lu objects, %lu kilobytes\n",
 		       loose, (unsigned long) (loose_size / 1024));
+	if (mdsmode && loose_mds_missing) {
+		assert(loose == (loose_mds_missing + has_loose_mds));
+		printf("%lu loose objects with no MD (Message Digest)\n",
+		       loose_mds_missing);
+	}
 	return 0;
 }
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 98025da..127f879 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,3 +1,4 @@
+#include <unistd.h>
 #include "builtin.h"
 #include "delta.h"
 #include "pack.h"
@@ -23,6 +24,14 @@ struct object_entry {
 	int base_object_no;
 };
 
+static int sha1_compare(const void *_a, const void *_b)
+{
+	struct object_entry *a = (struct object_entry *)_a;
+	struct object_entry *b = (struct object_entry *)_b;
+	return hashcmp(a->idx.sha1, b->idx.sha1);
+}
+
+
 union delta_base {
 	unsigned char sha1[20];
 	off_t offset;
@@ -447,9 +456,10 @@ static void find_delta_children(const union delta_base *base,
 }
 
 static void sha1_object(const void *data, unsigned long size,
-			enum object_type type, unsigned char *sha1)
+			enum object_type type, unsigned char *sha1,
+			mdigest_t *digestp)
 {
-	hash_sha1_file(data, size, typename(type), sha1);
+	hash_sha1_file_extended(data, size, typename(type), sha1, digestp);
 	if (has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
@@ -549,7 +559,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
 	sha1_object(result->data, result->size, delta_obj->real_type,
-		    delta_obj->idx.sha1);
+		    delta_obj->idx.sha1, &(delta_obj->idx.digest));
+	delta_obj->idx.has_digest = 1;
 	nr_resolved_deltas++;
 }
 
@@ -643,8 +654,12 @@ static void parse_pack_objects(unsigned char *sha1)
 			nr_deltas++;
 			delta->obj_no = i;
 			delta++;
-		} else
-			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
+		} else {
+		  sha1_object(data, obj->size, obj->type, obj->idx.sha1,
+			      &(obj->idx.digest));
+		  obj->idx.has_digest = 1;
+		}
+
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -804,6 +819,7 @@ static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolved)
 
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
+		  const char *final_mds_name, const char *curr_mds_name,
 		  const char *keep_name, const char *keep_msg,
 		  unsigned char *sha1)
 {
@@ -866,6 +882,18 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	} else
 		chmod(final_index_name, 0444);
 
+	if (final_mds_name != curr_mds_name) {
+		if (!final_mds_name) {
+			snprintf(name, sizeof(name), "%s/pack/pack-%s.mds",
+				 get_object_directory(), sha1_to_hex(sha1));
+			final_mds_name = name;
+		}
+		if (move_temp_to_file(curr_mds_name, final_mds_name))
+			die("cannot store mds file");
+	} else
+		chmod(final_mds_name, 0444);
+
+
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));
 	} else {
@@ -972,18 +1000,46 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 	free(p);
 }
 
-static void show_pack_info(int stat_only)
+static void show_pack_info(int stat, int stat_only, int show_mds,
+			   int mds_file_exists, const char *path)
 {
 	int i, baseobjects = nr_objects - nr_deltas;
 	unsigned long *chain_histogram = NULL;
+	void *data = NULL;
+	size_t mds_size = 0;
+	struct packed_git pg;
+
+	if (mds_file_exists) {
+		int fd = git_open_noatime(path);
+		size_t required_size = 0;
+		struct stat st;
+		if (fd >= 0) {
+			if (fstat(fd, &st)) {
+				close(fd);
+			} else {
+				mds_size = xsize_t(st.st_size);
+				data = xmmap(NULL, mds_size,
+						PROT_READ, MAP_PRIVATE, fd, 0);
+				close(fd);
+				required_size = required_git_packed_mds_size
+					(path, data, nr_objects, mds_size);
+				if (required_size == 0) {
+					munmap(data, mds_size);
+					data = NULL;
+				}
+			}
+		}
+		if (data == NULL) mds_file_exists = 0;
+		pg.mds_data = data;
+	}
 
-	if (deepest_delta)
+	if (stat && deepest_delta)
 		chain_histogram = xcalloc(deepest_delta, sizeof(unsigned long));
 
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 
-		if (is_delta_type(obj->type))
+		if (chain_histogram && is_delta_type(obj->type))
 			chain_histogram[obj->delta_depth - 1]++;
 		if (stat_only)
 			continue;
@@ -992,12 +1048,41 @@ static void show_pack_info(int stat_only)
 		       typename(obj->real_type), obj->size,
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
+		if (show_mds) {
+			if (mds_file_exists) {
+				mdigest_t digest;
+				int has_digest = nth_packed_object_mdigest
+					(&pg, i, &digest);
+				if (has_digest) {
+					printf(" md=%s",
+					       mdigest_to_external_hex
+					       (&digest));
+					if (obj->idx.has_digest) {
+						if (mdigest_tst
+						    (&digest,
+						     &(obj->idx.digest))) {
+							printf
+							(" (should be %s) ",
+							 mdigest_to_external_hex
+							 (&(obj->idx.digest)));
+						}
+					}
+				} else {
+					printf(" <no md>      ");
+				}
+			} else {
+				printf(" <no md>      ");
+			}
+		}
 		if (is_delta_type(obj->type)) {
 			struct object_entry *bobj = &objects[obj->base_object_no];
 			printf(" %u %s", obj->delta_depth, sha1_to_hex(bobj->idx.sha1));
 		}
 		putchar('\n');
 	}
+	if (data) munmap(data, mds_size);
+	if (!stat)
+		return;
 
 	if (baseobjects)
 		printf("non delta: %d object%s\n",
@@ -1015,10 +1100,12 @@ static void show_pack_info(int stat_only)
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, stat = 0;
-	const char *curr_pack, *curr_index;
-	const char *index_name = NULL, *pack_name = NULL;
+	int show_mds = 0;
+	const char *curr_pack, *curr_index, *curr_mds;
+	const char *index_name = NULL, *pack_name = NULL, *mds_name = NULL;;
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
+	char *mds_name_buf = NULL;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
@@ -1052,6 +1139,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				verify = 1;
 				stat = 1;
 				stat_only = 1;
+			} else if (!strcmp(arg, "-M") ||
+				   !strcmp(arg, "--show-mds")) {
+				verify = 1;
+				show_mds = 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg = "";
 			} else if (!prefixcmp(arg, "--keep=")) {
@@ -1075,6 +1166,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				if (index_name || (i+1) >= argc)
 					usage(index_pack_usage);
 				index_name = argv[++i];
+			} else if (!strcmp(arg, "-m")) {
+				if (mds_name || (i+1) >= argc)
+					usage(index_pack_usage);
+				mds_name = argv[++i];
 			} else if (!prefixcmp(arg, "--index-version=")) {
 				char *c;
 				opts.version = strtoul(arg + 16, &c, 10);
@@ -1108,6 +1203,16 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		strcpy(index_name_buf + len - 5, ".idx");
 		index_name = index_name_buf;
 	}
+	if (!mds_name && pack_name) {
+		int len = strlen(pack_name);
+		if (!has_extension(pack_name, ".pack"))
+			die("packfile name '%s' does not end with '.pack'",
+			    pack_name);
+		mds_name_buf = xmalloc(len);
+		memcpy(mds_name_buf, pack_name, len - 5);
+		strcpy(mds_name_buf + len - 5, ".mds");
+		mds_name = mds_name_buf;
+	}
 	if (keep_msg && !keep_name && pack_name) {
 		int len = strlen(pack_name);
 		if (!has_extension(pack_name, ".pack"))
@@ -1170,24 +1275,34 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (strict)
 		check_objects();
 
-	if (stat)
-		show_pack_info(stat_only);
+	if (stat || show_mds) {
+		int mds_file_exists = !access(mds_name, R_OK);
+		if (mds_file_exists && show_mds) {
+		  qsort (objects, nr_objects, sizeof (struct object_entry),
+			 sha1_compare);
+		}
+		show_pack_info(stat, stat_only, show_mds, mds_file_exists,
+			       mds_name);
+	}
 
 	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
 	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_sha1);
+	curr_mds = write_mds_file(mds_name, idx_objects, nr_objects, &opts,pack_sha1);
 	free(idx_objects);
 
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
+		      mds_name, curr_mds,
 		      keep_name, keep_msg,
 		      pack_sha1);
 	else
 		close(input_fd);
 	free(objects);
 	free(index_name_buf);
+	free(mds_name_buf);
 	free(keep_name_buf);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 96c1680..ccfe824 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -17,6 +17,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "thread-utils.h"
+#include "mdsdb.h"
 
 static const char pack_usage[] =
   "git pack-objects [ -q | --progress | --all-progress ]\n"
@@ -560,6 +561,8 @@ static struct object_entry **compute_write_order(void)
 		objects[i].filled = 0;
 		objects[i].delta_child = NULL;
 		objects[i].delta_sibling = NULL;
+		objects[i].idx.has_digest = 0;
+		mdigest_clear(&objects[i].idx.digest);
 	}
 
 	/*
@@ -684,8 +687,28 @@ static void write_pack_file(void)
 
 		if (!pack_to_stdout) {
 			struct stat st;
+#if 1
 			char tmpname[PATH_MAX];
 
+#else
+			const char *idx_tmp_name;
+			const char *mds_tmp_name;
+			char tmpname[PATH_MAX];
+
+			idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
+						      &pack_idx_opts, sha1);
+			mds_tmp_name = write_mds_file(NULL, written_list, nr_written,
+						      &pack_idx_opts, sha1);
+
+			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
+				 base_name, sha1_to_hex(sha1));
+			free_pack_by_name(tmpname);
+			if (adjust_shared_perm(pack_tmp_name))
+				die_errno("unable to make temporary pack file readable");
+			if (rename(pack_tmp_name, tmpname))
+				die_errno("unable to rename temporary pack file");
+#endif
+
 			/*
 			 * Packs are runtime accessed in their mtime
 			 * order since newer packs are more likely to contain
@@ -707,6 +730,7 @@ static void write_pack_file(void)
 						tmpname, strerror(errno));
 			}
 
+#if 1
 			/* Enough space for "-<sha-1>.pack"? */
 			if (sizeof(tmpname) <= strlen(base_name) + 50)
 				die("pack base name '%s' too long", base_name);
@@ -714,6 +738,25 @@ static void write_pack_file(void)
 			finish_tmp_packfile(tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, sha1);
+#else
+			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
+				 base_name, sha1_to_hex(sha1));
+			if (adjust_shared_perm(idx_tmp_name))
+				die_errno("unable to make temporary index file readable");
+			if (rename(idx_tmp_name, tmpname))
+				die_errno("unable to rename temporary index file");
+
+			snprintf(tmpname, sizeof(tmpname), "%s-%s.mds",
+				 base_name, sha1_to_hex(sha1));
+			if (adjust_shared_perm(mds_tmp_name))
+				die_errno("unable to make temporary mds file readable");
+			if (rename(mds_tmp_name, tmpname))
+				die_errno("unable to rename temporary mds file");
+
+
+			free((void *) idx_tmp_name);
+			free((void *) mds_tmp_name);
+#endif
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
@@ -830,6 +873,8 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	off_t found_offset = 0;
 	int ix;
 	unsigned hash = name_hash(name);
+	int hasdigest;
+	mdigest_t digest;
 
 	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
 	if (ix >= 0) {
@@ -846,7 +891,11 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		return 0;
 
 	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
+		off_t offset;
+		hasdigest = 0;
+		mdigest_clear(&digest);
+		offset = find_pack_entry_one_extended(sha1, p,
+						   &hasdigest, &digest);
 		if (offset) {
 			if (!found_pack) {
 				if (!is_pack_valid(p)) {
@@ -874,7 +923,37 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 
 	entry = objects + nr_objects++;
 	memset(entry, 0, sizeof(*entry));
+	if (hasdigest == 0) {
+		/*
+		 * We pick up MDs for local objects (we already checked the
+		 * pack files).  If that doesn't work, we compute it from
+		 * scratch (which should occur rarely if at all).
+		 */
+		mdsdb_open(NULL);
+		switch (mdsdb_lookup(NULL, sha1, &digest)) {
+		case 1:
+			hasdigest = 1;
+			break;
+		default:
+			hasdigest = 0;
+		}
+		mdsdb_close(NULL);
+		if (!hasdigest) {
+		  enum object_type type;
+		  unsigned long size;
+		  unsigned char sbuf[20];
+		  void *buf = read_sha1_file(sha1, &type, &size);
+		  if (buf) {
+			const char *stype = typename(type);
+			hash_sha1_file_extended(buf, size, stype, sbuf,
+						&digest);
+			hasdigest = 1;
+		  }
+		}
+	}
 	hashcpy(entry->idx.sha1, sha1);
+	entry->idx.has_digest = hasdigest;
+	entry->idx.digest = digest;
 	entry->hash = hash;
 	if (type)
 		entry->type = type;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index f5c6afc..c09397c 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -6,6 +6,7 @@
 *
 */
 
+#include <unistd.h>
 #include "builtin.h"
 
 #define BLKSIZE 512
@@ -682,9 +683,16 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	}
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
-		printf("%s\n%s\n",
-		       sha1_pack_index_name(pl->pack->sha1),
-		       pl->pack->pack_name);
+		char *mdsfile = sha1_pack_mds_name(pl->pack->sha1);
+		if (!access(mdsfile, F_OK)) {
+		  printf("%s\n%s\n%s\n", mdsfile,
+			       sha1_pack_index_name(pl->pack->sha1),
+			       pl->pack->pack_name);
+		} else {
+			printf("%s\n%s\n",
+			       sha1_pack_index_name(pl->pack->sha1),
+			       pl->pack->pack_name);
+		}
 		pl = pl->next;
 	}
 	if (verbose)
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index f9463de..ec5dfe8 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -43,8 +43,11 @@ void prune_packed_objects(int opts)
 {
 	int i;
 	static char pathname[PATH_MAX];
+	static char mds_pathname[PATH_MAX];
 	const char *dir = get_object_directory();
+	const char *mdsdir = get_object_mds_directory();
 	int len = strlen(dir);
+	int mdslen = strlen(mdsdir);
 
 	if (opts == VERBOSE)
 		progress = start_progress_delay("Removing duplicate objects",
@@ -55,16 +58,26 @@ void prune_packed_objects(int opts)
 	memcpy(pathname, dir, len);
 	if (len && pathname[len-1] != '/')
 		pathname[len++] = '/';
+	memcpy(mds_pathname, mdsdir, mdslen);
+	if (mdslen && mds_pathname[mdslen-1] != '/')
+		mds_pathname[mdslen++] = '/';
 	for (i = 0; i < 256; i++) {
 		DIR *d;
+		DIR *mds_d;
 
 		display_progress(progress, i + 1);
 		sprintf(pathname + len, "%02x/", i);
 		d = opendir(pathname);
-		if (!d)
-			continue;
-		prune_dir(i, d, pathname, len + 3, opts);
-		closedir(d);
+		sprintf(mds_pathname + len, "%02x/", i);
+		mds_d = opendir(mds_pathname);
+		if (d) {
+			prune_dir(i, d, pathname, len + 3, opts);
+			closedir(d);
+		}
+		if (mds_d) {
+			prune_dir(i, mds_d, mds_pathname, mdslen + 3, opts);
+			closedir(mds_d);
+		}
 	}
 	stop_progress(&progress);
 }
diff --git a/builtin/prune.c b/builtin/prune.c
index 58d7cb8..25dde51 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -165,6 +165,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	mark_reachable_objects(&revs, 1, progress);
 	stop_progress(&progress);
 	prune_object_dir(get_object_directory());
+	prune_object_dir(get_object_mds_directory());
 
 	prune_packed_objects(show_only);
 	remove_temporary_files(get_object_directory());
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index e841b4a..b94a11e 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -5,14 +5,16 @@
 
 #define VERIFY_PACK_VERBOSE 01
 #define VERIFY_PACK_STAT_ONLY 02
+#define SHOW_MDS 04
 
 static int verify_one_pack(const char *path, unsigned int flags)
 {
 	struct child_process index_pack;
-	const char *argv[] = {"index-pack", NULL, NULL, NULL };
+	const char *argv[] = {"index-pack", NULL, NULL, NULL, NULL };
 	struct strbuf arg = STRBUF_INIT;
 	int verbose = flags & VERIFY_PACK_VERBOSE;
 	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
+	int show_mds = ((flags & SHOW_MDS) != 0)  && !stat_only;
 	int err;
 
 	if (stat_only)
@@ -22,6 +24,8 @@ static int verify_one_pack(const char *path, unsigned int flags)
 	else
 		argv[1] = "--verify";
 
+	if (show_mds) argv[2] = "-M";
+
 	/*
 	 * In addition to "foo.pack" we accept "foo.idx" and "foo";
 	 * normalize these forms to "foo.pack" for "index-pack --verify".
@@ -31,7 +35,7 @@ static int verify_one_pack(const char *path, unsigned int flags)
 		strbuf_splice(&arg, arg.len - 3, 3, "pack", 4);
 	else if (!has_extension(arg.buf, ".pack"))
 		strbuf_add(&arg, ".pack", 5);
-	argv[2] = arg.buf;
+	argv[2 + show_mds] = arg.buf;
 
 	memset(&index_pack, 0, sizeof(index_pack));
 	index_pack.argv = argv;
@@ -46,6 +50,10 @@ static int verify_one_pack(const char *path, unsigned int flags)
 			if (!stat_only)
 				printf("%s: ok\n", arg.buf);
 		}
+	} else if (show_mds) {
+		printf("%s: listed (%s)\n-----------------\n", arg.buf,
+		       (err? "bad": "ok"));
+
 	}
 	strbuf_release(&arg);
 
@@ -67,6 +75,8 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 			VERIFY_PACK_VERBOSE),
 		OPT_BIT('s', "stat-only", &flags, "show statistics only",
 			VERIFY_PACK_STAT_ONLY),
+		OPT_BIT('M', "show-mds", &flags, "show message digests / CRCs",
+			SHOW_MDS),
 		OPT_END()
 	};
 
diff --git a/fast-import.c b/fast-import.c
index 4b9c4b7..f672a76 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -165,6 +165,11 @@ Format of STDIN stream:
 #include "exec_cmd.h"
 #include "dir.h"
 
+#ifdef PACKDB
+#include "packdb.h"
+#endif
+
+
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
 #define DEPTH_BITS 13
@@ -558,6 +563,8 @@ static struct object_entry *new_object(unsigned char *sha1)
 
 	e = blocks->next_free++;
 	hashcpy(e->idx.sha1, sha1);
+	e->idx.has_digest = 0;
+	mdigest_clear(&e->idx.digest);
 	return e;
 }
 
@@ -904,9 +911,34 @@ static const char *create_index(void)
 	return tmpfile;
 }
 
-static char *keep_pack(const char *curr_index_name)
+static const char *create_mds(void)
+{
+	const char *tmpfile;
+	struct pack_idx_entry **mds, **c, **last;
+	struct object_entry *e;
+	struct object_entry_pool *o;
+
+	/* Build the table of object IDs. */
+	mds = xmalloc(object_count * sizeof(*mds));
+	c = mds;
+	for (o = blocks; o; o = o->next_pool)
+		for (e = o->next_free; e-- != o->entries;)
+			if (pack_id == e->pack_id)
+				*c++ = &e->idx;
+	last = mds + object_count;
+	if (c != last)
+		die("internal consistency error creating the mds file");
+
+	tmpfile = write_mds_file(NULL, mds, object_count, &pack_idx_opts, pack_data->sha1);
+	free(mds);
+	return tmpfile;
+}
+
+
+static char *keep_pack(const char *curr_index_name, const char *curr_mds_name)
 {
 	static char name[PATH_MAX];
+	static char rname[PATH_MAX];
 	static const char *keep_msg = "fast-import";
 	int keep_fd;
 
@@ -927,6 +959,13 @@ static char *keep_pack(const char *curr_index_name)
 	if (move_temp_to_file(curr_index_name, name))
 		die("cannot store index file");
 	free((void *)curr_index_name);
+
+	snprintf(rname, sizeof(rname), "%s/pack/pack-%s.mds",
+		 get_object_directory(), sha1_to_hex(pack_data->sha1));
+	if (move_temp_to_file(curr_mds_name, rname))
+		die("cannot store index file");
+	free((void *)curr_mds_name);
+
 	return name;
 }
 
@@ -951,6 +990,7 @@ static void end_packfile(void)
 	if (object_count) {
 		unsigned char cur_pack_sha1[20];
 		char *idx_name;
+		const char *n1, *n2;
 		int i;
 		struct branch *b;
 		struct tag *t;
@@ -961,7 +1001,9 @@ static void end_packfile(void)
 				    pack_data->pack_name, object_count,
 				    cur_pack_sha1, pack_size);
 		close(pack_data->pack_fd);
-		idx_name = keep_pack(create_index());
+		n1 = create_index();
+		n2 = create_mds();
+		idx_name = keep_pack(n1, n2);
 
 		/* Register the packfile with core git's machinery. */
 		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
@@ -1021,6 +1063,8 @@ static int store_object(
 	unsigned long hdrlen, deltalen;
 	git_SHA_CTX c;
 	git_zstream s;
+	mdigest_t digest;
+	mdigest_context_t mdc;
 
 	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
@@ -1028,10 +1072,28 @@ static int store_object(
 	git_SHA1_Update(&c, hdr, hdrlen);
 	git_SHA1_Update(&c, dat->buf, dat->len);
 	git_SHA1_Final(sha1, &c);
+	mdigest_Init(&mdc, MDIGEST_DEFAULT);
+	mdigest_Update(&mdc, (unsigned char *)(dat->buf), dat->len);
+	mdigest_Final(&digest, &mdc);
+
+	if (has_sha1_file(sha1)) {
+		mdigest_t old_digest;
+		if (has_sha1_file_digest(sha1, &old_digest)) {
+		  if (mdigest_tst(&digest,&old_digest)) {
+				die("hash collision on %s [fast-import]",
+				    sha1_to_hex(sha1));
+			}
+		}
+	}
 	if (sha1out)
 		hashcpy(sha1out, sha1);
 
 	e = insert_object(sha1);
+	e->idx.has_digest = 1;
+	e->idx.digest = digest;
+#ifdef PACKDB
+	packdb_process(sha1, &digest);
+#endif
 	if (mark)
 		insert_mark(mark, e);
 	if (e->idx.offset) {
@@ -1157,6 +1219,8 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	unsigned char *out_buf = xmalloc(out_sz);
 	struct object_entry *e;
 	unsigned char sha1[20];
+	mdigest_t digest;
+	mdigest_context_t mdc;
 	unsigned long hdrlen;
 	off_t offset;
 	git_SHA_CTX c;
@@ -1177,6 +1241,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		die("impossibly large object header");
 
 	git_SHA1_Init(&c);
+	mdigest_Init(&mdc, MDIGEST_DEFAULT);
 	git_SHA1_Update(&c, out_buf, hdrlen);
 
 	crc32_begin(pack_file);
@@ -1199,6 +1264,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
 
 			git_SHA1_Update(&c, in_buf, n);
+			mdigest_Update(&mdc, in_buf, n);
 			s.next_in = in_buf;
 			s.avail_in = n;
 			len -= n;
@@ -1225,11 +1291,14 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	}
 	git_deflate_end(&s);
 	git_SHA1_Final(sha1, &c);
+	mdigest_Final(&digest, &mdc);
 
 	if (sha1out)
 		hashcpy(sha1out, sha1);
 
 	e = insert_object(sha1);
+	e->idx.has_digest = 1;
+	e->idx.digest =  digest;
 
 	if (mark)
 		insert_mark(mark, e);
@@ -1828,6 +1897,8 @@ static void read_marks(void)
 			if (type < 0)
 				die("object not found: %s", sha1_to_hex(sha1));
 			e = insert_object(sha1);
+			e->idx.has_digest =
+				has_sha1_file_digest(sha1, &e->idx.digest);
 			e->type = type;
 			e->pack_id = MAX_PACK_ID;
 			e->idx.offset = 1; /* just not zero! */
@@ -2896,6 +2967,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 			die("object not found: %s", sha1_to_hex(sha1));
 		/* cache it! */
 		oe = insert_object(sha1);
+		oe->idx.has_digest =
+			has_sha1_file_digest(sha1, &oe->idx.digest);
 		oe->type = type;
 		oe->pack_id = MAX_PACK_ID;
 		oe->idx.offset = 1;
diff --git a/git-repack.sh b/git-repack.sh
index 624feec..7602853 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -91,6 +91,7 @@ if [ -z "$names" ]; then
 	say Nothing new to pack.
 fi
 
+
 # Ok we have prepared all new packfiles.
 
 # First see if there are packs of the same name and if so
@@ -100,7 +101,7 @@ rollback=
 failed=
 for name in $names
 do
-	for sfx in pack idx
+	for sfx in pack idx mds
 	do
 		file=pack-$name.$sfx
 		test -f "$PACKDIR/$file" || continue
@@ -148,15 +149,22 @@ do
 	fullbases="$fullbases pack-$name"
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
+	(chmod a-w "$PACKTMP-$name.mds" 2>/dev/null || exit 0 )
 	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
 	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" ||
 	exit
+	if test -f "$PACKTMP-$name.mds"
+	then
+		mv -f "$PACKTMP-$name.mds"  "$PACKDIR/pack-$name.mds" \
+		    2>/dev/null || exit
+	fi
 done
 
 # Remove the "old-" files
 for name in $names
 do
 	rm -f "$PACKDIR/old-pack-$name.idx"
+	rm -f "$PACKDIR/old-pack-$name.mds"
 	rm -f "$PACKDIR/old-pack-$name.pack"
 done
 
@@ -172,7 +180,7 @@ then
 		  do
 			case " $fullbases " in
 			*" $e "*) ;;
-			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
+			*)	rm -f "$e.pack" "$e.idx" "$e.mds" "$e.keep" ;;
 			esac
 		  done
 		)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 602806d..1b72d46 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -54,7 +54,7 @@ cd "$TRASH/.git2"
 
 test_expect_success \
     'check unpack without delta' \
-    '(cd ../.git && find objects -type f -print) |
+    '(cd ../.git && find objects -type f  -print) | grep -v mdsd | grep -v packdb |
      while read path
      do
          cmp $path ../.git/$path || {
@@ -84,7 +84,7 @@ unset GIT_OBJECT_DIRECTORY
 cd "$TRASH/.git2"
 test_expect_success \
     'check unpack with REF_DELTA' \
-    '(cd ../.git && find objects -type f -print) |
+    '(cd ../.git && find objects -type f -print) | grep -v mdsd | grep -v packdb |
      while read path
      do
          cmp $path ../.git/$path || {
@@ -114,7 +114,7 @@ unset GIT_OBJECT_DIRECTORY
 cd "$TRASH/.git2"
 test_expect_success \
     'check unpack with OFS_DELTA' \
-    '(cd ../.git && find objects -type f -print) |
+    '(cd ../.git && find objects -type f -print) | grep -v mdsd | grep -v packdb |
      while read path
      do
          cmp $path ../.git/$path || {
@@ -211,6 +211,17 @@ test_expect_success \
 			test-3-${packname_3}.idx'
 
 test_expect_success \
+    'verify pack -v -M' \
+    'test -z "`git verify-pack -v -M test-1-${packname_1}.idx \
+			test-2-${packname_2}.idx \
+			test-3-${packname_3}.idx | grep \<no\ md\>`" &&
+     test 0 != `git verify-pack -v -M test-1-${packname_1}.idx | grep md= | wc -l` &&
+     test -z "`git verify-pack -v -M test-1-${packname_1}.idx | grep "should be"`" &&
+     (x=`git verify-pack -v -M test-1-${packname_1}.idx | wc -l`
+     y=`git verify-pack -v -M test-1-${packname_1}.idx |grep -v \<no\ md\> | wc -l`
+     test $x = $y)'
+
+test_expect_success \
     'verify-pack catches mismatched .idx and .pack files' \
     'cat test-1-${packname_1}.idx >test-3.idx &&
      cat test-2-${packname_2}.pack >test-3.pack &&
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 2fc5af6..ec0d72f 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -22,13 +22,19 @@ test_expect_success \
      git repack -a -d &&
      test "`git count-objects`" = "0 objects, 0 kilobytes" &&
      pack1=`ls .git/objects/pack/*.pack` &&
-     test -f "$pack1"'
+     test -f "$pack1"  &&
+     test -z "`git count-objects -v -M | grep MD`"'
 
 test_expect_success \
     'verify-pack -v, defaults' \
     'git verify-pack -v "$pack1"'
 
 test_expect_success \
+    'verify-pack -v -M, defaults' \
+    'git verify-pack -v -M "$pack1" | grep "<no md>" > tmp
+     test -z "`cat tmp`"'
+
+test_expect_success \
     'verify-pack -v, packedGitWindowSize == 1 page' \
     'git config core.packedGitWindowSize 512 &&
      git verify-pack -v "$pack1"'
@@ -49,12 +55,14 @@ test_expect_success \
      test "`git count-objects`" = "0 objects, 0 kilobytes" &&
      pack2=`ls .git/objects/pack/*.pack` &&
      test -f "$pack2" &&
-     test "$pack1" \!= "$pack2"'
+     test "$pack1" \!= "$pack2" &&
+     test -z "`git count-objects -v -M | grep MD`"'
 
 test_expect_success \
     'verify-pack -v, defaults' \
     'git config --unset core.packedGitWindowSize &&
      git config --unset core.packedGitLimit &&
-     git verify-pack -v "$pack2"'
+     git verify-pack -v "$pack2" &&
+     test -z "`git count-objects -v -M | grep MD`"'
 
 test_done
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index f8fa924..da10200 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -37,12 +37,14 @@ test_expect_success \
 test_expect_success \
     'pack-objects with index version 1' \
     'pack1=$(git pack-objects --index-version=1 test-1 <obj-list) &&
-     git verify-pack -v "test-1-${pack1}.pack"'
+     git verify-pack -v "test-1-${pack1}.pack" &&
+     test -z "`git count-objects -v -M | grep MD`"'
 
 test_expect_success \
     'pack-objects with index version 2' \
     'pack2=$(git pack-objects --index-version=2 test-2 <obj-list) &&
-     git verify-pack -v "test-2-${pack2}.pack"'
+     git verify-pack -v "test-2-${pack2}.pack" &&
+     test -z "`git count-objects -v -M | grep MD`"'
 
 test_expect_success \
     'both packs should be identical' \
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index d645328..86075a7 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -37,7 +37,8 @@ test_expect_success 'prune stale packs' '
 	git prune --expire 1.day &&
 	test -f $orig_pack &&
 	test -f .git/objects/tmp_2.pack &&
-	! test -f .git/objects/tmp_1.pack
+	! test -f .git/objects/tmp_1.pack  &&
+	test -z "`git count-objects -v -M | grep MD`"
 
 '
 
@@ -50,7 +51,8 @@ test_expect_success 'prune --expire' '
 	test-chmtime =-86500 $BLOB_FILE &&
 	git prune --expire 1.day &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
-	! test -f $BLOB_FILE
+	! test -f $BLOB_FILE  &&
+	test -z "`git count-objects -v -M | grep MD`"
 
 '
 
@@ -64,7 +66,8 @@ test_expect_success 'gc: implicit prune --expire' '
 	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
 	git gc &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
-	! test -f $BLOB_FILE
+	! test -f $BLOB_FILE  &&
+	test -z "`git count-objects -v -M | grep MD`"
 
 '
 
@@ -78,8 +81,8 @@ test_expect_success 'gc: refuse to start with invalid gc.pruneExpire' '
 test_expect_success 'gc: start with ok gc.pruneExpire' '
 
 	git config gc.pruneExpire 2.days.ago &&
-	git gc
-
+	git gc &&
+	test -z "`git count-objects -v -M | grep MD`"
 '
 
 test_expect_success 'prune: prune nonsense parameters' '
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 438aaf6..63b4a13 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -109,6 +109,12 @@ test_expect_success \
 	'A: verify pack' \
 	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
 
+test_expect_success \
+	'A: verify pack -v -M --- all objects have CRCs' \
+	'for p in .git/objects/pack/*.pack;
+	do git verify-pack -v -M $p | grep "<no md>" > tmp;
+	   test -z "`cat tmp`" || exit; done'
+
 cat >expect <<EOF
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1504,7 +1510,7 @@ INPUT_END
 test_expect_success \
 	'O: blank lines not necessary after other commands' \
 	'git fast-import <input &&
-	 test 8 = `find .git/objects/pack -type f | wc -l` &&
+	 test 8 = `find .git/objects/pack -type f | grep -v .mds | wc -l` &&
 	 test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
 	 git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
 	 test_cmp expect actual'
-- 
1.7.1
