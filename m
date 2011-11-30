From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: [PATCH 3/3] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 22:30:21 -0800
Message-ID: <1322634621.1728.349.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 07:30:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVdgo-0000jt-SU
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 07:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab1K3Gag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 01:30:36 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43992 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1K3Gad (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 01:30:33 -0500
Received: by iage36 with SMTP id e36so282963iag.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 22:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Jw4G6/DzW2EjlF9dLamwbBFoKyifxM72W2pKMerzGYs=;
        b=gI6dXJmVGD1+yN75jhPjMVr3mZ7x7UHdsWEFxSswih7nKlaNTJ//Zs+iXN1+m4JmJh
         hVQB7L9ByxEL8zpRSNGfJmmZWvTRJkPw6V8hhoa9y7LtsO4sZFlRv77ksCGCxjboZULR
         cqeNm7hFcuwaccbOwtv6/fgEnIvWf6nql7BG0=
Received: by 10.42.161.9 with SMTP id r9mr1023214icx.49.1322634632287;
        Tue, 29 Nov 2011 22:30:32 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id e2sm4099936ibe.0.2011.11.29.22.30.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 22:30:30 -0800 (PST)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186106>

Maintains a database of CRCs of Git objects to allow SHA-1 hash
collisions to be detected with high probability (1 - 1/2^32) and with
little computational overhead.  The CRCs cover the content of Git
objects, but not the header.  For loose objects, these are stored in
subdirectories of GIT_DIRECTORY/objects/crcs, with each subdirectory's
name consisting of the first two hexadecimal digits of the
corresponding object's SHA-1 hash.  For each pack file, FILE.pack, the
CRCs are stored in a FILE.mds, in the same order as the SHA-1 hashes
that appear in FILE.idx.  Checks for hash collisions are made whenever
a new loose object is created.

A new capability, "mds-check" has been added to git-fetch-pack,
git-upload-pack, git-send-pack, and git-receive-pack to allow a CRC to
be used in addition to SHA-1 hash values. For commits, a CRC of the
CRCs of each blob reachable from a commit's tree is also used.  The
result is that hash collisions can be detected during fetch, pull, and
push operations.

A few git commands had additional command-line arguments added:
count-objects, index-pack, and verify-pack.  Please read
Documentation/technical/collision-detect.txt for further details
and the documentation for each command for details on the new
arguments.

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 Makefile                  |   32 +++
 builtin/count-objects.c   |   92 +++++++++-
 builtin/fetch-pack.c      |   42 ++++-
 builtin/index-pack.c      |  140 +++++++++++++--
 builtin/init-db.c         |   17 ++-
 builtin/pack-objects.c    |   57 ++++++-
 builtin/pack-redundant.c  |   14 +-
 builtin/prune-packed.c    |   21 ++-
 builtin/prune.c           |    1 +
 builtin/receive-pack.c    |  120 +++++++++++-
 builtin/send-pack.c       |   45 +++++-
 builtin/verify-pack.c     |   14 ++-
 cache.h                   |   61 ++++++-
 commit.c                  |  109 +++++++++++
 commit.h                  |    8 +
 environment.c             |   57 ++++++-
 fast-import.c             |   74 +++++++-
 git-repack.sh             |   12 +-
 git.c                     |   15 ++-
 hex.c                     |   58 ++++++-
 http.c                    |   19 ++-
 pack-write.c              |   95 +++++++++
 pack.h                    |    3 +
 sha1_file.c               |  461 ++++++++++++++++++++++++++++++++++++++++-----
 t/t0000-basic.sh          |   13 +-
 t/t5300-pack-object.sh    |   17 ++-
 t/t5301-sliding-window.sh |   14 +-
 t/t5302-pack-index.sh     |    6 +-
 t/t5304-prune.sh          |   13 +-
 t/t5500-fetch-pack.sh     |   10 +-
 t/t5510-fetch.sh          |   12 +-
 t/t9300-fast-import.sh    |    8 +-
 upload-pack.c             |   28 +++-
 33 files changed, 1550 insertions(+), 138 deletions(-)

diff --git a/Makefile b/Makefile
index b1c80a6..3dda96b 100644
--- a/Makefile
+++ b/Makefile
@@ -260,6 +260,19 @@ all::
 # dependency rules.
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
+#
+# Define CRCDB to indicate the database type for the DB mapping SHA1
+# values to the CRCs of the objects git stores.  Valid values are 0
+# for storing each local-object crc in its own file, and 1 for storing
+# each local-object crc in its own file and additionally using a
+# GDBM implementation of packdb to store CRCs that are not in their
+# on files as an aid for generating pack mds files.  [more to be added
+# as needed].
+#
+# Note: the values for CRCDB are determined by preprocessor directives
+# defined in crcdb.h
+#
+CRCDB = 0
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -513,6 +526,7 @@ LIB_H += blob.h
 LIB_H += builtin.h
 LIB_H += cache.h
 LIB_H += cache-tree.h
+LIB_H += crcdb.h
 LIB_H += color.h
 LIB_H += commit.h
 LIB_H += compat/bswap.h
@@ -805,6 +819,7 @@ BUILTIN_OBJS += builtin/write-tree.o
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
+
 #
 # Platform specific tweaks
 #
@@ -1662,6 +1677,23 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON=NoThanks
 endif
 
+ifdef CRCDB
+BASIC_CFLAGS += -DBLOB_MDS_CHECK
+endif
+
+ifeq ($(CRCDB), 0)
+BASIC_CFLAGS += -DCRCDB=$(CRCDB)
+CRCDB_SRC = objd-crcdb.c
+LIB_OBJS += objd-crcdb.o
+endif
+
+ifeq ($(CRCDB), 1)
+BASIC_CFLAGS += -DCRCDB=$(CRCDB) -DPACKDB
+CRCDB_SRC = objd-crcdb.c gdbm-packdb.c
+LIB_OBJS += objd-crcdb.o gdbm-packdb.o
+EXTLIBS += -lgdbm
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index c37cb98..898d970 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -8,6 +8,12 @@
 #include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "crcdb.h"
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
+				} else if (crcdb_lookup(NULL, sha1, NULL) > 0) {
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
+			if (crcdb_lookup(NULL, sha1, NULL) > 0) {
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
+	crcdb_open(NULL);
 	for (i = 0; i < 256; i++) {
 		DIR *d;
 		sprintf(path + len, "%02x", i);
@@ -100,10 +126,16 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			      &loose, &loose_size, &packed_loose, &garbage);
 		closedir(d);
 	}
+	crcdb_close(NULL);
 	if (verbose) {
 		struct packed_git *p;
 		unsigned long num_pack = 0;
 		off_t size_pack = 0;
+		unsigned long mds_mismatched = 0;
+		unsigned long missing_mdsfile_count = 0;
+		unsigned long mds_count = 0;
+		int wsize = 0;
+		uint32_t crc;
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
+					  (nth_packed_object_objcrc32(p,
+								      i,
+								      &crc)
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
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c6bc8eb..7472021 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -18,6 +18,8 @@ static int prefer_ofs_delta = 1;
 static int no_done;
 static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
+static int mds_check = 0;
+
 static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
@@ -390,9 +392,38 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	flushes = 0;
 	retval = -1;
 	while ((sha1 = get_rev())) {
-		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
-		if (args.verbose)
-			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		if (mds_check) {
+			uint32_t objcrc;
+			if (has_sha1_file_crc(sha1, &objcrc)) {
+				uint32_t blobs_crc;
+				int has_blobs_crc = !get_blob_mds(sha1,
+								 &blobs_crc);
+				if (has_blobs_crc)
+					packet_buf_write(&req_buf,
+							 "have "
+							 "%s-%8.8x-%8.8x\n",
+							 sha1_to_hex(sha1),
+							 ntohl(objcrc),
+							 ntohl(blobs_crc));
+				else
+					packet_buf_write(&req_buf,
+							 "have "
+							 "%s-%8.8x\n",
+							 sha1_to_hex(sha1),
+							 ntohl(objcrc));
+
+			} else {
+				packet_buf_write(&req_buf, "have %s\n",
+						 sha1_to_hex(sha1));
+			}
+			if (args.verbose)
+				fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		} else {
+			packet_buf_write(&req_buf, "have %s\n",
+					 sha1_to_hex(sha1));
+			if (args.verbose)
+				fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		}
 		in_vain++;
 		if (flush_at <= ++count) {
 			int ack;
@@ -802,6 +833,11 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
+	if (server_supports("mds-check")) {
+		if (args.verbose)
+			fprintf(stderr, "Server supports mds-check\n");
+		mds_check = 1;
+	}
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0945adb..b49f6ee 100644
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
+			uint32_t *objcrc32p)
 {
-	hash_sha1_file(data, size, typename(type), sha1);
+	hash_sha1_file_extended(data, size, typename(type), sha1, objcrc32p);
 	if (has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
@@ -549,7 +559,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
 	sha1_object(result->data, result->size, delta_obj->real_type,
-		    delta_obj->idx.sha1);
+		    delta_obj->idx.sha1, &(delta_obj->idx.objcrc32));
+	delta_obj->idx.has_objcrc32 = 1;
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
+			      &(obj->idx.objcrc32));
+		  obj->idx.has_objcrc32 = 1;
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
+
+	if (stat && deepest_delta)
 		chain_histogram = xcalloc(deepest_delta, sizeof(unsigned long));
 
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
-
-		if (is_delta_type(obj->type))
+		if (chain_histogram && is_delta_type(obj->type))
 			chain_histogram[obj->delta_depth - 1]++;
 		if (stat_only)
 			continue;
@@ -992,12 +1048,40 @@ static void show_pack_info(int stat_only)
 		       typename(obj->real_type), obj->size,
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
+		if (show_mds) {
+			if (mds_file_exists) {
+				uint32_t crc;
+				int has_crc = nth_packed_object_objcrc32
+					(&pg, i, &crc);
+				crc = ntohl(crc);
+				if (has_crc) {
+					printf(" md=0x%8.8x", crc);
+					if (obj->idx.has_objcrc32) {
+						uint32_t ecrc =
+						  ntohl(obj->idx.objcrc32);
+						if (ecrc != crc) {
+							printf(" (should "
+							       "be 0x%x) ",
+							       ecrc);
+
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
@@ -1015,10 +1099,12 @@ static void show_pack_info(int stat_only)
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
@@ -1052,6 +1138,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
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
@@ -1075,6 +1165,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
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
@@ -1108,6 +1202,16 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
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
@@ -1168,24 +1272,34 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
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
diff --git a/builtin/init-db.c b/builtin/init-db.c
index d07554c..9ff2e88 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -7,6 +7,10 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "crcdb.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -308,7 +312,18 @@ static void create_object_directory(void)
 	safe_create_dir(path, 1);
 	strcpy(path+len, "/info");
 	safe_create_dir(path, 1);
-
+#if (CRCDB == 0) || (CRCDB == 1)
+	strcpy(path+len, "/crcs");
+	safe_create_dir(path, 1);
+#endif
+	/*
+	 * In case the call in environent.c failed to initialize
+	 * (missing directory?) or somehow wasn't called at all.
+	 */
+	crcdb_init();
+#ifdef PACKDB
+	packdb_init();
+#endif
 	free(path);
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 824ecee..3ed1e71 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -17,6 +17,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "thread-utils.h"
+#include "crcdb.h"
 
 static const char pack_usage[] =
   "git pack-objects [ -q | --progress | --all-progress ]\n"
@@ -529,6 +530,8 @@ static struct object_entry **compute_write_order(void)
 		objects[i].filled = 0;
 		objects[i].delta_child = NULL;
 		objects[i].delta_sibling = NULL;
+		objects[i].idx.has_objcrc32 = 0;
+		objects[i].idx.objcrc32 = 0;
 	}
 
 	/*
@@ -663,10 +666,13 @@ static void write_pack_file(void)
 		if (!pack_to_stdout) {
 			struct stat st;
 			const char *idx_tmp_name;
+			const char *mds_tmp_name;
 			char tmpname[PATH_MAX];
 
 			idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
 						      &pack_idx_opts, sha1);
+			mds_tmp_name = write_mds_file(NULL, written_list, nr_written,
+						      &pack_idx_opts, sha1);
 
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
 				 base_name, sha1_to_hex(sha1));
@@ -704,7 +710,16 @@ static void write_pack_file(void)
 			if (rename(idx_tmp_name, tmpname))
 				die_errno("unable to rename temporary index file");
 
+			snprintf(tmpname, sizeof(tmpname), "%s-%s.mds",
+				 base_name, sha1_to_hex(sha1));
+			if (adjust_shared_perm(mds_tmp_name))
+				die_errno("unable to make temporary mds file readable");
+			if (rename(mds_tmp_name, tmpname))
+				die_errno("unable to rename temporary mds file");
+
+
 			free((void *) idx_tmp_name);
+			free((void *) mds_tmp_name);
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
@@ -821,6 +836,8 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	off_t found_offset = 0;
 	int ix;
 	unsigned hash = name_hash(name);
+	int hasobjcrc32;
+	uint32_t objcrc32;
 
 	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
 	if (ix >= 0) {
@@ -837,7 +854,10 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		return 0;
 
 	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
+		hasobjcrc32 = 0;
+		objcrc32 = 0;
+		off_t offset = find_pack_entry_one_extended(sha1, p,
+						   &hasobjcrc32, &objcrc32);
 		if (offset) {
 			if (!found_pack) {
 				if (!is_pack_valid(p)) {
@@ -865,7 +885,37 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 
 	entry = objects + nr_objects++;
 	memset(entry, 0, sizeof(*entry));
+	if (hasobjcrc32 == 0) {
+		/*
+		 * We pick up CRCs for local objects (we already checked the
+		 * pack files).  If that doesn't work, we compute it from
+		 * scratch (which should occur rarely if at all).
+		 */
+		crcdb_open(NULL);
+		switch (crcdb_lookup(NULL, sha1, &objcrc32)) {
+		case 1:
+			hasobjcrc32 = 1;
+			break;
+		default:
+			hasobjcrc32 = 0;
+		}
+		crcdb_close(NULL);
+		if (!hasobjcrc32) {
+		  enum object_type type;
+		  unsigned long size;
+		  unsigned char sbuf[20];
+		  void *buf = read_sha1_file(sha1, &type, &size);
+		  if (buf) {
+			const char *stype = typename(type);
+			hash_sha1_file_extended(buf, size, stype, sbuf,
+						&objcrc32);
+			hasobjcrc32 = 1;
+		  }
+		}
+	}
 	hashcpy(entry->idx.sha1, sha1);
+	entry->idx.has_objcrc32 = hasobjcrc32;
+	entry->idx.objcrc32 = objcrc32;
 	entry->hash = hash;
 	if (type)
 		entry->type = type;
@@ -2148,7 +2198,8 @@ struct in_pack {
 
 static void mark_in_pack_object(struct object *object, struct packed_git *p, struct in_pack *in_pack)
 {
-	in_pack->array[in_pack->nr].offset = find_pack_entry_one(object->sha1, p);
+	in_pack->array[in_pack->nr].offset =
+		find_pack_entry_one(object->sha1, p);
 	in_pack->array[in_pack->nr].object = object;
 	in_pack->nr++;
 }
@@ -2220,7 +2271,7 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
 
 	while (p) {
 		if ((!p->pack_local || p->pack_keep) &&
-			find_pack_entry_one(sha1, p)) {
+		     find_pack_entry_one(sha1, p)) {
 			last_found = p;
 			return 1;
 		}
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
index f9463de..5c682dd 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -43,8 +43,11 @@ void prune_packed_objects(int opts)
 {
 	int i;
 	static char pathname[PATH_MAX];
+	static char mds_pathname[PATH_MAX];
 	const char *dir = get_object_directory();
+	const char *mdsdir = get_object_crc_node();
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
index e65690b..e9fbc99 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -154,6 +154,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	}
 	mark_reachable_objects(&revs, 1);
 	prune_object_dir(get_object_directory());
+	prune_object_dir(get_object_crc_node());
 
 	prune_packed_objects(show_only);
 	remove_temporary_files(get_object_directory());
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7ec68a1..a7b6474 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -121,7 +121,8 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 	else
 		packet_write(1, "%s %s%c%s%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k",
+			     " report-status delete-refs side-band-64k"
+			     " mds-check",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
 	return 0;
@@ -712,32 +713,128 @@ static struct command *read_head_info(void)
 		struct command *cmd;
 		char *refname;
 		int len, reflen;
+		int has_old_sha1_crc = 0;
+		int has_new_sha1_crc = 0;
+		int has_old_blob_crc = 0;
+		int has_new_blob_crc = 0;
+		uint32_t old_sha1_crc = 0;
+		uint32_t new_sha1_crc = 0;
+		uint32_t new_blob_crc = 0;
+		uint32_t old_blob_crc = 0;
+		uint32_t objcrc32;
+		int old_hashlen = 40;
+		int new_hashlen = 40;
+		int hashlen = 80;
+		static const int crc_field_len = 9;
 
 		len = packet_read_line(0, line, sizeof(line));
 		if (!len)
 			break;
 		if (line[len-1] == '\n')
 			line[--len] = 0;
-		if (len < 83 ||
-		    line[40] != ' ' ||
-		    line[81] != ' ' ||
-		    get_sha1_hex(line, old_sha1) ||
-		    get_sha1_hex(line + 41, new_sha1))
+		if (len > (old_hashlen + crc_field_len) &&
+		    line[old_hashlen] == '-') {
+			old_hashlen += crc_field_len;
+			hashlen += crc_field_len;
+		}
+		if (len > (old_hashlen + crc_field_len) &&
+		    line[old_hashlen] == '-') {
+			old_hashlen += crc_field_len;
+			hashlen += crc_field_len;
+		}
+		if (len > (hashlen + crc_field_len + 1) &&
+		    line[hashlen+1] == '-') {
+			new_hashlen += crc_field_len;
+			hashlen += crc_field_len;
+		}
+		if (len > (hashlen + crc_field_len + 1) &&
+		    line[hashlen+1] == '-') {
+			new_hashlen += crc_field_len;
+			hashlen += crc_field_len;
+		}
+
+		if (old_hashlen != 40 && old_hashlen != 49
+		    && old_hashlen != 58) {
+			die("protocol error: expected old/new/ref, got '%s'",
+			    line);
+		}
+
+		if (new_hashlen != 40 && new_hashlen != 49 &&
+		    new_hashlen != 58) {
+			die("protocol error: expected old/new/ref, got '%s'",
+			    line);
+		}
+
+		if (len < hashlen + 3 ||
+		    line[old_hashlen] != ' ' ||
+		    line[hashlen + 1] != ' ' ||
+		    get_sha1_hex_crc(line, old_sha1,
+				     &has_old_sha1_crc, &old_sha1_crc,
+				     &has_old_blob_crc,
+				     &old_blob_crc) ||
+		    get_sha1_hex_crc(line + old_hashlen + 1, new_sha1,
+				     &has_new_sha1_crc, &new_sha1_crc,
+				     &has_new_blob_crc,
+				     &new_blob_crc))
 			die("protocol error: expected old/new/ref, got '%s'",
 			    line);
 
-		refname = line + 82;
+		if (has_old_sha1_crc &&
+		    has_sha1_file_crc(old_sha1, &objcrc32)) {
+			if (old_sha1_crc != objcrc32) {
+				die("hash collision for %s",
+				    sha1_to_hex(old_sha1));
+			}
+		}
+
+		if (has_old_sha1_crc && has_old_blob_crc) {
+			uint32_t blobcrc;
+			int has_blob_crc = !get_blob_mds(old_sha1, &blobcrc);
+			if (has_blob_crc) {
+				if (old_blob_crc != blobcrc)
+					die("hash collision for %s",
+					    sha1_to_hex(old_sha1));
+			} else {
+#ifdef BLOB_MDS_CHECK
+				push_mds_check(old_sha1, old_blob_crc);
+#endif
+			}
+		}
+
+		if (has_new_sha1_crc &&
+		    has_sha1_file_crc(new_sha1, &objcrc32)) {
+			if (new_sha1_crc != objcrc32) {
+				die("hash collision for %s",
+				    sha1_to_hex(new_sha1));
+			}
+		}
+
+		if (has_new_sha1_crc && has_new_blob_crc) {
+			uint32_t blobcrc;
+			int has_blob_crc = !get_blob_mds(new_sha1, &blobcrc);
+			if (has_blob_crc) {
+				if (new_blob_crc != blobcrc)
+					die("hash collision for %s",
+					    sha1_to_hex(new_sha1));
+			} else  {
+#ifdef BLOB_MDS_CHECK
+				push_mds_check(new_sha1, new_blob_crc);
+#endif
+			}
+		}
+
+		refname = line + hashlen + 2;
 		reflen = strlen(refname);
-		if (reflen + 82 < len) {
+		if (reflen + hashlen + 2 < len) {
 			if (strstr(refname + reflen + 1, "report-status"))
 				report_status = 1;
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 		}
-		cmd = xcalloc(1, sizeof(struct command) + len - 80);
+		cmd = xcalloc(1, sizeof(struct command) + len - hashlen);
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
-		memcpy(cmd->ref_name, line + 82, len - 81);
+		memcpy(cmd->ref_name, line + hashlen + 2, len - (hashlen +1));
 		*p = cmd;
 		p = &cmd->next;
 	}
@@ -966,6 +1063,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		if (auto_update_server_info)
 			update_server_info(0);
 	}
+#ifdef BLOB_MDS_CHECK
+	process_mds_checks(rp_warning);
+#endif
 	if (use_sideband)
 		packet_flush(1);
 	return 0;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e0b8030..a3ce108 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -250,6 +250,7 @@ int send_pack(struct send_pack_args *args,
 	int allow_deleting_refs = 0;
 	int status_report = 0;
 	int use_sideband = 0;
+	int mds_check = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -263,6 +264,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_ofs_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
+	if (server_supports("mds-check"))
+		mds_check = 1;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -298,8 +301,46 @@ int send_pack(struct send_pack_args *args,
 		if (args->dry_run) {
 			ref->status = REF_STATUS_OK;
 		} else {
-			char *old_hex = sha1_to_hex(ref->old_sha1);
-			char *new_hex = sha1_to_hex(ref->new_sha1);
+			char *old_hex, *new_hex;
+			if (mds_check) {
+				uint32_t objcrc32;
+				uint32_t blobcrc;
+				if (has_sha1_file_crc(ref->old_sha1,
+						      &objcrc32)) {
+					if (get_blob_mds(ref->old_sha1,
+							  &blobcrc)) {
+						old_hex =
+						  sha1_to_hex_crc(ref->old_sha1,
+								  objcrc32);
+					} else {
+						old_hex =
+						  sha1_to_hex_crc2
+						  (ref->old_sha1, objcrc32,
+						   blobcrc);
+					}
+				} else {
+					old_hex = sha1_to_hex(ref->old_sha1);
+				}
+				if (has_sha1_file_crc(ref->new_sha1,
+						      &objcrc32)) {
+					if (get_blob_mds(ref->new_sha1,
+						   &objcrc32)) {
+						new_hex =
+						  sha1_to_hex_crc(ref->new_sha1,
+								  objcrc32);
+					} else {
+						new_hex =
+						  sha1_to_hex_crc2
+						  (ref->new_sha1, objcrc32,
+						   blobcrc);
+					}
+				} else {
+					new_hex = sha1_to_hex(ref->new_sha1);
+				}
+			} else {
+				old_hex = sha1_to_hex(ref->old_sha1);
+				new_hex = sha1_to_hex(ref->new_sha1);
+			}
 
 			if (!cmds_sent && (status_report || use_sideband)) {
 				packet_buf_write(&req_buf, "%s %s %s%c%s%s",
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
 
diff --git a/cache.h b/cache.h
index 2e6ad36..85ecff2 100644
--- a/cache.h
+++ b/cache.h
@@ -433,6 +433,10 @@ extern int is_inside_work_tree(void);
 extern int have_git_dir(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
+extern char *get_object_crc_node(void);
+#ifdef PACKDB
+extern char *get_object_packdb_node(void);
+#endif
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
@@ -541,8 +545,15 @@ extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pa
 
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
-extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
-extern int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags);
+
+#define index_fd(sha1,fd,st,type,path,flags)			\
+	index_fd_extended((sha1), NULL, (fd), (st), (type), (path), (flags))
+extern int index_fd_extended(unsigned char *sha1, uint32_t *objcrc32p, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
+
+#define index_path(sha1, path, st, flags) \
+	index_path_extended((sha1), NULL, (path), (st), (flags))
+extern int index_path_extended(unsigned char *sha1, uint32_t *objcrc32p, const char *path
+, struct stat *st, unsigned flags);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
@@ -669,6 +680,7 @@ extern char *git_path_submodule(const char *path, const char *fmt, ...)
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
+extern char *sha1_pack_mds_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
 
@@ -768,9 +780,18 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
-extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
-extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+
+#define hash_sha1_file(buf,len,type,sha1) \
+	hash_sha1_file_extended((buf), (len), (type), (sha1), NULL)
+extern int hash_sha1_file_extended(const void *buf, unsigned long len, const char *type, unsigned char *sha1, uint32_t *objcrc32p);
+
+#define write_sha1_file(buf,len,type,return_sha1) \
+	write_sha1_file_extended((buf), (len), (type), (return_sha1), NULL)
+extern int write_sha1_file_extended(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1, uint32_t *objcrc32p);
+
+#define pretend_sha1_file(buf,len,type,sha1) \
+	pretend_sha1_file_extended((buf), (len), (type), (sha1), NULL)
+extern int pretend_sha1_file_extended(void *, unsigned long, enum object_type, unsigned char *, uint32_t *objcrc32p);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
@@ -782,13 +803,17 @@ extern int do_check_packed_object_crc;
 /* for development: log offset of pack access */
 extern const char *log_pack_access;
 
-extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
+#define check_sha1_signature(sha1,buf,size,type) \
+	check_sha1_signature_extended((sha1), NULL, (buf), (size), (type))
+extern int check_sha1_signature_extended(const unsigned char *sha1, uint32_t *objcrc32p, void *buf, unsigned long size, const char *type);
 
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
+extern int has_sha1_file_crc(const unsigned char *sha1, uint32_t *objcrc32p);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
+extern int has_loose_object_nonlocal_crc(const unsigned char *sha1, uint32_t *objcrc32p);
 
 extern int has_pack_index(const unsigned char *sha1);
 
@@ -830,8 +855,12 @@ static inline int get_sha1_with_context(const char *str, unsigned char *sha1, st
  * null-terminated string.
  */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
+extern int get_sha1_hex_crc(const char *hex, unsigned char *sha1, int *hascrc, uint32_t *crc, int *hasblobmdsp, uint32_t *blobmdsp);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern char *sha1_to_hex_crc(const unsigned char *sha1, const uint32_t objcrc);	/* static buffer result! */
+extern char *sha1_to_hex_crc2(const unsigned char *sha1, const uint32_t objcrc,
+			      const uint32_t blobcrc);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 
 /*
@@ -974,10 +1003,13 @@ extern struct packed_git {
 	off_t pack_size;
 	const void *index_data;
 	size_t index_size;
+	const void *mds_data; /*objcrc32 table*/
+	size_t mds_size;
 	uint32_t num_objects;
 	uint32_t num_bad_objects;
 	unsigned char *bad_object_sha1;
 	int index_version;
+	int mds_version;
 	time_t mtime;
 	int pack_fd;
 	unsigned pack_local:1,
@@ -992,6 +1024,8 @@ struct pack_entry {
 	off_t offset;
 	unsigned char sha1[20];
 	struct packed_git *p;
+	int has_objcrc32;
+	uint32_t objcrc32;
 };
 
 struct ref {
@@ -1047,6 +1081,11 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 extern void pack_report(void);
 extern int open_pack_index(struct packed_git *);
+extern int open_pack_mds(struct packed_git *p);
+extern int git_open_noatime(const char *name);
+extern size_t required_git_packed_mds_size(const char *path,
+					   void *data, uint32_t nobjects,
+					   size_t actual_size);
 extern void close_pack_index(struct packed_git *);
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
@@ -1055,8 +1094,16 @@ extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
+extern int nth_packed_object_objcrc32(const struct packed_git *p, uint32_t n,
+				      uint32_t *objcrc32p);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
-extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
+
+#define find_pack_entry_one(sha1,p) find_pack_entry_one_extended((sha1),(p), NULL, NULL)
+extern off_t find_pack_entry_one_extended(const unsigned char *,
+					  struct packed_git *,
+					  int *hasojb32crcp,
+					  uint32_t *objcrc32p);
+
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/commit.c b/commit.c
index 73b7e00..815f4a0 100644
--- a/commit.c
+++ b/commit.c
@@ -11,6 +11,115 @@ int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
+struct blob_mds_context {
+  unsigned long missing;
+  uint32_t crc;
+};
+
+static int get_blob_mds_f(const unsigned char *sha1,
+			  const char *basebuf, int baselen,
+			  const char *path, unsigned int mode, int stage,
+			  void *context)
+{
+	struct blob_mds_context *c = (struct blob_mds_context *)context;
+	uint32_t crc;
+	unsigned long size;
+	int type;
+
+	if (!has_sha1_file(sha1)) {
+		c->missing++;
+		return -1;
+	}
+	type = sha1_object_info(sha1, &size);
+	switch(type) {
+	case OBJ_TREE:
+	  return ((mode) == 0040000)? READ_TREE_RECURSIVE: 0;
+	case OBJ_BLOB:
+		if (has_sha1_file_crc(sha1, &crc)) {
+			crc = ntohl(crc);
+			c->crc = crc32(c->crc, (unsigned char *)&crc,
+					 sizeof (uint32_t));
+		} else {
+			c->missing++;
+		}
+		return 0;
+	default:
+		if (type <= OBJ_NONE) {
+		  c->missing++;
+		}
+		return 0;
+	}
+}
+
+/*
+ * Works with a tree or a commit sha1 - recursively traverses the trees
+ * and computes the CRC of each blob's CRC.
+ */
+int get_blob_mds(const unsigned char *sha1, uint32_t *blobcrcp)
+{
+	struct blob_mds_context context;
+	context.crc = crc32(0, NULL, 0);
+	context.missing = 0;
+	struct tree *tree = parse_tree_indirect(sha1);
+	struct pathspec ps;
+	if (tree == NULL) {
+		return -1;
+	} else {
+		init_pathspec(&ps, NULL);
+		parse_tree(tree);
+		read_tree_recursive(tree, "", 0, 0, &ps, get_blob_mds_f,
+				    &context);
+		if (blobcrcp) (*blobcrcp) = htonl(context.crc);
+		return ((context.missing == 0)? 0: -1);
+	}
+}
+
+#ifdef BLOB_MDS_CHECK
+/*
+ * Used to check the values returned by get_mds_blob in cases involving
+ * a transfer protocol where a commit is transferred and processed
+ * before all of the objects associated with it are accessible.
+ */
+
+struct mds_check {
+  struct mds_check *next;
+  unsigned char sha1[20];
+  uint32_t blobcrc;
+} *mds_check_list = NULL;
+
+void push_mds_check(unsigned char *sha1, uint32_t crc) {
+	struct mds_check *ptr = (struct mds_check *)
+	  xmalloc(sizeof (struct mds_check));
+	hashcpy(ptr->sha1, sha1);
+	ptr->blobcrc = crc;
+	ptr->next = mds_check_list;
+	mds_check_list = ptr;
+}
+
+/*
+ * Must be called after the uploaded data is entered in the repository -
+ * otherwise we won't be able to get the CRCs needed by get_blob_mds,
+ * which will result in get_blob_mds returning -1 instead of 0.
+ */
+
+void process_mds_checks(rp_warning_f rp_warning) {
+	while (mds_check_list) {
+		uint32_t sha1_blobcrc;
+		int has_sha1_blobcrc = !get_blob_mds(mds_check_list->sha1,
+						     &sha1_blobcrc);
+		if (has_sha1_blobcrc &&
+		    mds_check_list->blobcrc != sha1_blobcrc) {
+			rp_warning("hash collision for %s",
+				   sha1_to_hex(mds_check_list->sha1));
+		}
+		mds_check_list = mds_check_list->next;
+	}
+}
+
+#endif /* BLOB_MDS_CHECK */
+
+
+
 static struct commit *check_commit(struct object *obj,
 				   const unsigned char *sha1,
 				   int quiet)
diff --git a/commit.h b/commit.h
index 009b113..65f2bd5 100644
--- a/commit.h
+++ b/commit.h
@@ -185,4 +185,12 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
 
+extern int get_blob_mds(const unsigned char *sha1, uint32_t *blobcrcp);
+
+#ifdef BLOB_MDS_CHECK
+extern void push_mds_check(unsigned char *sha1, uint32_t crc);
+typedef void (*rp_warning_f)(const char *err, ...) __attribute__((format (printf, 1, 2))
+);
+extern void process_mds_checks(rp_warning_f rp_warning);
+#endif /* BLOB_MDS_CHECK */
 #endif /* COMMIT_H */
diff --git a/environment.c b/environment.c
index 0bee6a7..8a45c82 100644
--- a/environment.c
+++ b/environment.c
@@ -9,6 +9,10 @@
  */
 #include "cache.h"
 #include "refs.h"
+#include "crcdb.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
@@ -73,7 +77,10 @@ static size_t namespace_len;
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
-
+static char *git_object_crc_node;
+#ifdef PACKDB
+static char *git_object_packdb_node;
+#endif
 /*
  * Repository-local GIT_* environment variables
  * Remember to update local_repo_env_size in cache.h when
@@ -115,6 +122,11 @@ static char *expand_namespace(const char *raw_namespace)
 
 static void setup_git_env(void)
 {
+	static char cwdbuf[PATH_MAX];
+	int ocn_len;
+#ifdef PACKDB
+	int opn_len;
+#endif
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	git_dir = git_dir ? xstrdup(git_dir) : NULL;
 	if (!git_dir) {
@@ -128,6 +140,31 @@ static void setup_git_env(void)
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
 	}
+	ocn_len = strlen(git_object_dir) + 8 + strlen(getcwd(cwdbuf, PATH_MAX));
+	git_object_crc_node = xmalloc(ocn_len);
+	memset(git_object_crc_node, 0, ocn_len);
+	sprintf(git_object_crc_node, "%s/crcs", git_object_dir);
+	if (git_object_crc_node[0] != '/') {
+		int ocn_offset = (git_object_crc_node[0] == '.' &&
+				  git_object_crc_node[1] == '/')? 2:0;
+		memset(git_object_crc_node, 0, ocn_len);
+		sprintf(git_object_crc_node, "%s/%s/crcs",
+			getcwd(cwdbuf, PATH_MAX), git_object_dir + ocn_offset);
+	}
+#ifdef PACKDB
+	opn_len = strlen(git_object_dir)
+		+ 10 + strlen(getcwd(cwdbuf, PATH_MAX));
+	git_object_packdb_node = xmalloc(opn_len);
+	memset(git_object_packdb_node, 0, opn_len);
+	sprintf(git_object_packdb_node, "%s/packdb", git_object_dir);
+	if (git_object_packdb_node[0] != '/') {
+		int opn_offset = (git_object_crc_node[0] == '.' &&
+				  git_object_crc_node[1] == '/')? 2:0;
+		memset(git_object_packdb_node, 0, opn_len);
+		sprintf(git_object_packdb_node, "%s/%s/packdb",
+			getcwd(cwdbuf, PATH_MAX), git_object_dir + opn_offset);
+	}
+#endif
 	git_index_file = getenv(INDEX_ENVIRONMENT);
 	if (!git_index_file) {
 		git_index_file = xmalloc(strlen(git_dir) + 7);
@@ -140,6 +177,10 @@ static void setup_git_env(void)
 		read_replace_refs = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	namespace_len = strlen(namespace);
+	crcdb_init();
+#ifdef PACKDB
+	packdb_init();
+#endif
 }
 
 int is_bare_repository(void)
@@ -207,6 +248,20 @@ char *get_object_directory(void)
 	return git_object_dir;
 }
 
+char *get_object_crc_node(void) {
+	if (!git_object_crc_node)
+		setup_git_env();
+	return git_object_crc_node;
+}
+
+#ifdef PACKDB
+char *get_object_packdb_node(void) {
+	if (!git_object_packdb_node)
+		setup_git_env();
+	return git_object_packdb_node;
+}
+#endif
+
 int odb_mkstemp(char *template, size_t limit, const char *pattern)
 {
 	int fd;
diff --git a/fast-import.c b/fast-import.c
index 8d8ea3c..62a675c 100644
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
+	e->idx.has_objcrc32 = 0;
+	e->idx.objcrc32 = 0;
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
@@ -1021,6 +1063,7 @@ static int store_object(
 	unsigned long hdrlen, deltalen;
 	git_SHA_CTX c;
 	git_zstream s;
+	uint32_t objcrc;
 
 	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
@@ -1028,10 +1071,27 @@ static int store_object(
 	git_SHA1_Update(&c, hdr, hdrlen);
 	git_SHA1_Update(&c, dat->buf, dat->len);
 	git_SHA1_Final(sha1, &c);
+	objcrc = crc32(0, NULL, 0);
+	objcrc = htonl(crc32(objcrc, (unsigned char *)(dat->buf), dat->len));
+
+	if (has_sha1_file(sha1)) {
+		uint32_t oldcrc;
+		if (has_sha1_file_crc(sha1, &oldcrc)) {
+			if (objcrc != oldcrc) {
+				die("hash collision on %s [fast-import]",
+				    sha1_to_hex(sha1));
+			}
+		}
+	}
 	if (sha1out)
 		hashcpy(sha1out, sha1);
 
 	e = insert_object(sha1);
+	e->idx.has_objcrc32 = 1;
+	e->idx.objcrc32 = objcrc;
+#ifdef PACKDB
+	packdb_process(sha1, objcrc);
+#endif
 	if (mark)
 		insert_mark(mark, e);
 	if (e->idx.offset) {
@@ -1163,6 +1223,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	unsigned char *out_buf = xmalloc(out_sz);
 	struct object_entry *e;
 	unsigned char sha1[20];
+	uint32_t objcrc;
 	unsigned long hdrlen;
 	off_t offset;
 	git_SHA_CTX c;
@@ -1186,6 +1247,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		die("impossibly large object header");
 
 	git_SHA1_Init(&c);
+	objcrc = crc32(0, NULL, 0);
 	git_SHA1_Update(&c, out_buf, hdrlen);
 
 	crc32_begin(pack_file);
@@ -1208,6 +1270,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
 
 			git_SHA1_Update(&c, in_buf, n);
+			objcrc = crc32(objcrc, in_buf, n);
 			s.next_in = in_buf;
 			s.avail_in = n;
 			len -= n;
@@ -1234,11 +1297,14 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	}
 	git_deflate_end(&s);
 	git_SHA1_Final(sha1, &c);
+	objcrc = htonl(objcrc);
 
 	if (sha1out)
 		hashcpy(sha1out, sha1);
 
 	e = insert_object(sha1);
+	e->idx.has_objcrc32 = 1;
+	e->idx.objcrc32 = objcrc;
 
 	if (mark)
 		insert_mark(mark, e);
@@ -1837,6 +1903,8 @@ static void read_marks(void)
 			if (type < 0)
 				die("object not found: %s", sha1_to_hex(sha1));
 			e = insert_object(sha1);
+			e->idx.has_objcrc32 =
+				has_sha1_file_crc(sha1, &e->idx.objcrc32);
 			e->type = type;
 			e->pack_id = MAX_PACK_ID;
 			e->idx.offset = 1; /* just not zero! */
@@ -2883,6 +2951,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 			die("object not found: %s", sha1_to_hex(sha1));
 		/* cache it! */
 		oe = insert_object(sha1);
+		oe->idx.has_objcrc32 =
+			has_sha1_file_crc(sha1, &oe->idx.objcrc32);
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
diff --git a/git.c b/git.c
index 8e34903..c6924f0 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,10 @@
 #include "help.h"
 #include "quote.h"
 #include "run-command.h"
-
+#include "crcdb.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
@@ -278,7 +281,15 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	int status, help;
 	struct stat st;
 	const char *prefix;
-
+	static int crcdb_need_atexit = 1;
+
+	if (crcdb_need_atexit) {
+#ifdef PACKDB
+		atexit(packdb_finish);
+#endif
+		atexit(crcdb_finish);
+		crcdb_need_atexit = 0;
+	}
 	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
diff --git a/hex.c b/hex.c
index 9ebc050..73c88fa 100644
--- a/hex.c
+++ b/hex.c
@@ -56,10 +56,50 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 	return 0;
 }
 
+static int get_crc_hex(const char *hex, unsigned char *crc) {
+	int i;
+	for (i = 0; i < 4; i++) {
+		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+		if (val & ~0xff)
+			return -1;
+		*crc++ = val;
+		hex += 2;
+	}
+	return 0;
+}
+
+int get_sha1_hex_crc(const char *hex, unsigned char *sha1, int *hascrc,
+		     uint32_t *crc, int *hasblobmds, uint32_t *blobmds)
+{
+	int result = get_sha1_hex(hex, sha1);
+	if (result) return result;
+	if (hex[20] == '-') {
+		unsigned char *ptr = (unsigned char *)crc;
+		if (!get_crc_hex(hex+21, ptr))
+			return -1;
+		*hascrc = 1;
+		if (hex[25] == '-') {
+			ptr = (unsigned char *)blobmds;
+			if (!get_crc_hex(hex+26, ptr)) {
+				return -1;
+			}
+			*hasblobmds = 1;
+		} else {
+			*hasblobmds = 0;
+		}
+	} else {
+		*hascrc = 0;
+		*hasblobmds = 0;
+		*crc = 0;
+		*blobmds = 0;
+	}
+	return 0;
+}
+
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
-	static char hexbuffer[4][50];
+	static char hexbuffer[4][59];
 	static const char hex[] = "0123456789abcdef";
 	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
 	int i;
@@ -73,3 +113,19 @@ char *sha1_to_hex(const unsigned char *sha1)
 
 	return buffer;
 }
+
+char *sha1_to_hex_crc(const unsigned char *sha1, const uint32_t objcrc32)
+{
+	char *result = sha1_to_hex(sha1);
+	sprintf(result+40, "-%8.8x", ntohl(objcrc32));
+	return result;
+}
+
+char *sha1_to_hex_crc2(const unsigned char *sha1, const uint32_t objcrc32,
+		      const uint32_t blobcrc32)
+{
+	char *result = sha1_to_hex(sha1);
+	sprintf(result+40, "-%8.8x-%8.8x", ntohl(objcrc32),
+		ntohl(blobcrc32));
+	return result;
+}
diff --git a/http.c b/http.c
index e6c7597..a92fd9f 100644
--- a/http.c
+++ b/http.c
@@ -1072,8 +1072,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
 	char *tmp_idx;
+	char *tmp_mds;
 	struct child_process ip;
-	const char *ip_argv[8];
+	const char *ip_argv[10];
 
 	close_pack_index(p);
 
@@ -1087,14 +1088,20 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	*lst = (*lst)->next;
 
 	tmp_idx = xstrdup(preq->tmpfile);
+	tmp_mds = xstrdup(preq->tmpfile);
 	strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp"),
 	       ".idx.temp");
+	strcpy(tmp_mds + strlen(tmp_mds) - strlen(".pack.temp"),
+	       ".mds.temp");
+
 
 	ip_argv[0] = "index-pack";
 	ip_argv[1] = "-o";
 	ip_argv[2] = tmp_idx;
-	ip_argv[3] = preq->tmpfile;
-	ip_argv[4] = NULL;
+	ip_argv[3] = "-m";
+	ip_argv[4] = tmp_mds;
+	ip_argv[5] = preq->tmpfile;
+	ip_argv[6] = NULL;
 
 	memset(&ip, 0, sizeof(ip));
 	ip.argv = ip_argv;
@@ -1105,20 +1112,24 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	if (run_command(&ip)) {
 		unlink(preq->tmpfile);
 		unlink(tmp_idx);
+		unlink(tmp_mds);
 		free(tmp_idx);
+		free(tmp_mds);
 		return -1;
 	}
 
 	unlink(sha1_pack_index_name(p->sha1));
 
 	if (move_temp_to_file(preq->tmpfile, sha1_pack_name(p->sha1))
-	 || move_temp_to_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
+	 || move_temp_to_file(tmp_idx, sha1_pack_index_name(p->sha1))
+	 || move_temp_to_file(tmp_mds, sha1_pack_mds_name(p->sha1))) {
 		free(tmp_idx);
 		return -1;
 	}
 
 	install_packed_git(p);
 	free(tmp_idx);
+	free(tmp_mds);
 	return 0;
 }
 
diff --git a/pack-write.c b/pack-write.c
index 9cd3bfb..1c8fb72 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -178,6 +178,101 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	return index_name;
 }
 
+
+const char *write_mds_file(const char *crc_name,
+			   struct pack_idx_entry **objects,
+			   int nr,
+			   const struct pack_idx_option *opts,
+			   unsigned char *sha1)
+{
+	static unsigned char buffer[20];
+	unsigned char *base = buffer;
+	int i, j, fd;
+	struct sha1file *f;
+
+	if (nr) {
+		/*
+		 * Sort just in case objects not already sorted.
+		 */
+		qsort(objects, nr, sizeof(objects[0]), sha1_compare);
+	}
+
+	if (opts->flags & WRITE_IDX_VERIFY) {
+		assert(crc_name);
+		f = sha1fd_check(crc_name);
+		if (f == NULL) {
+			/*
+			 * For backwards-compatability, assume a missing
+			 * mds file is OK.
+			 */
+			return crc_name;
+		}
+	} else {
+	  if (!crc_name) {
+	    static char tmpfile[PATH_MAX];
+	    fd = odb_mkstemp(tmpfile, sizeof(tmpfile),
+			     "pack/tmp_mds_XXXXXX");
+	    crc_name = xstrdup(tmpfile);
+	  } else {
+	    unlink(crc_name);
+	    fd = open(crc_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+	  }
+	  if (fd < 0)
+	    die_errno("unable to create '%s'", crc_name);
+	  f = sha1fd(fd, crc_name);
+	}
+
+	*(base++) = 'P';
+	*(base++) = 'K';
+	*(base++) = 'M';
+	*(base++) = 'D';
+	*(base++) = 'S';
+	*(base++) = 0;
+	*(base++) = 1; /* version number */
+	*(base++) = 1; /* wsize */
+	sha1write(f, buffer, base - buffer);
+	base = buffer;
+
+	for (i = 0; i < nr; i += 4) {
+		int lim = ((nr-i) > 3)? 4: nr-i;
+		int has[4];
+		uint32_t crc[4];
+		for (j = 0; j < lim; j++) {
+			if (objects[i+j]->has_objcrc32) {
+				has[j] = 1;
+				crc[j] = objects[i+j]->objcrc32;
+			} else {
+				has[j] =
+				  (has_sha1_file_crc(objects[i + j]->sha1,
+						     &crc[j]) == 1);
+			}
+		}
+		for (j = 0; j < 4; j++) {
+			if (j < lim) {
+				*(base)++ = has[j];
+			} else {
+				has[j] = 0;
+				crc[j] = 0;
+				*(base++) = 0;
+			}
+		}
+		for (j = 0; j < 4; j += 1) {
+		  if (j < lim) {
+			*((uint32_t *)base) = has[j]? crc[j]: 0;
+		  } else {
+			*((uint32_t *)base) = 0;
+		  }
+		  base += 4;
+		}
+		sha1write(f, buffer, base - buffer);
+		base = buffer;
+	}
+	sha1write(f, sha1, 20);
+	sha1close(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
+			    ? CSUM_CLOSE : CSUM_FSYNC));
+	return crc_name;
+}
+
 /*
  * Update pack header with object_count and compute new SHA1 for pack data
  * associated to pack_fd, and write that SHA1 at the end.  That new SHA1
diff --git a/pack.h b/pack.h
index 722a54e..62f5d41 100644
--- a/pack.h
+++ b/pack.h
@@ -68,9 +68,12 @@ struct pack_idx_entry {
 	unsigned char sha1[20];
 	uint32_t crc32;
 	off_t offset;
+	int has_objcrc32;
+	uint32_t objcrc32;
 };
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, unsigned char *sha1);
+extern const char *write_mds_file(const char *mds_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *);
diff --git a/sha1_file.c b/sha1_file.c
index 6dcae38..da51b40 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -18,6 +18,10 @@
 #include "refs.h"
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
+#include "crcdb.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -40,6 +44,7 @@ const unsigned char null_sha1[20];
  */
 static struct cached_object {
 	unsigned char sha1[20];
+	uint32_t objcrc32;
 	enum object_type type;
 	void *buf;
 	unsigned long size;
@@ -48,6 +53,7 @@ static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
 	EMPTY_TREE_SHA1_BIN_LITERAL,
+	0u,
 	OBJ_TREE,
 	"",
 	0
@@ -222,11 +228,18 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 	return sha1_get_pack_name(sha1, &name, &base, "idx");
 }
 
+char *sha1_pack_mds_name(const unsigned char *sha1)
+{
+	static char *name, *base;
+
+	return sha1_get_pack_name(sha1, &name, &base, "mds");
+}
+
+
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
 static void read_info_alternates(const char * alternates, int depth);
-static int git_open_noatime(const char *name);
 
 /*
  * Prepare alternate object database registry.
@@ -415,6 +428,7 @@ void prepare_alt_odb(void)
 	link_alt_odb_entries(alt, alt + strlen(alt), PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
+	crcdb_init_alts();
 }
 
 static int has_loose_object_local(const unsigned char *sha1)
@@ -441,6 +455,52 @@ static int has_loose_object(const unsigned char *sha1)
 	       has_loose_object_nonlocal(sha1);
 }
 
+static int has_loose_object_local_crc(const unsigned char *sha1,
+				      uint32_t *objcrc32p)
+{
+	int status;
+	crcdb_open(NULL);
+	status = crcdb_lookup(NULL, sha1, objcrc32p) > 0;
+	crcdb_close(NULL);
+	return status;
+}
+
+int has_loose_object_nonlocal_crc(const unsigned char *sha1,
+				  uint32_t *objcrc32p)
+{
+	struct alternate_object_database *alt;
+	if (objcrc32p == NULL) return 0;
+	/* memset(buffer, 0, PATH_MAX); */
+	prepare_alt_odb();
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		fill_sha1_path(alt->name, sha1);
+		if (!access(alt->base, F_OK)) {
+			uint32_t xcrc;
+			/* Use the crc corresponding to the hash */
+			crcdb_t dbf;
+			int status;
+			dbf = crcdb_open_alt(alt);
+			status = crcdb_lookup(dbf, sha1,
+					      (objcrc32p? objcrc32p: &xcrc));
+			crcdb_close(dbf);
+			switch (status) {
+			case 0: return 0;
+			case 1: return 1;
+			case -1:
+			default:
+				return 0;
+			}
+		}
+	}
+	return 0;
+}
+
+static int has_loose_object_crc(const unsigned char *sha1, uint32_t *objcrc32p)
+{
+	return has_loose_object_local_crc(sha1, objcrc32p) ||
+	       has_loose_object_nonlocal_crc(sha1, objcrc32p);
+}
+
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
@@ -574,6 +634,87 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	return 0;
 }
 
+size_t required_git_packed_mds_size(const char *path, void *data,
+				    uint32_t nobjects,
+				    size_t actual_size) {
+	unsigned char *base;
+	int wsize, version;
+	size_t required_size;
+	if (actual_size < 8) {
+		error("mds/crc file %s is too small", path);
+		return 0;
+	}
+
+	base = data;
+	if ((*(base++) != 'P')
+	    || (*(base++) != 'K')
+	    || (*(base++) != 'M')
+	    || (*(base++) != 'D')
+	    || (*(base++) != 'S')
+	    || (*(base++) != 0)) {
+		error("mds/crc file %s corrupted (bad header)",
+			     path);
+		return 0;
+
+	}
+	if ((version = *(base++)) != 1) {
+		error("mds/crc file %s uses an unrecognized version %d",
+		      path, version);
+		return 0;
+	}
+	wsize = (*(base++)) * 4;
+	if (wsize != 4) {
+		/* other values not defined currently. */
+		error("mds/crc file %s corrupted (bad wsize field)",
+			     path);
+		return 0;
+	}
+	required_size = (size_t)8 +
+	  ((size_t)((nobjects)/4 + (nobjects % 4 != 0))
+	   * (size_t)(4 * (1 + wsize))) + (size_t)(20 * 2);
+	if (required_size != actual_size) {
+		error("mds/crc file %s not the right size: %ld != %ld",
+		      path, (long)actual_size, (long)required_size);
+		return 0;
+	}
+	return required_size;
+}
+
+static int check_packed_git_mds(const char *path, struct packed_git *p)
+{
+	void *mds_map;
+	size_t mds_size, required_size;
+	unsigned char *base;
+	int fd = git_open_noatime(path);
+	int version;
+	struct stat st;
+	if (fd < 0)
+		return -1;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+	mds_size = xsize_t(st.st_size);
+	if (mds_size < 8 + 20 + 20) {
+		close(fd);
+		return error("mds/crc file %s is too small", path);
+	}
+	mds_map = xmmap(NULL, mds_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	base = mds_map;
+	required_size = required_git_packed_mds_size(path, mds_map,
+						     p->num_objects,
+						     mds_size);
+	if (required_size == 0) {
+		munmap(mds_map, mds_size);
+		return -1;
+	}
+	p->mds_data = mds_map;
+	p->mds_size = mds_size;
+	p->mds_version = version;
+	return 0;
+}
+
 int open_pack_index(struct packed_git *p)
 {
 	char *idx_name;
@@ -589,6 +730,20 @@ int open_pack_index(struct packed_git *p)
 	return ret;
 }
 
+int open_pack_mds(struct packed_git *p) {
+	char *crc_name;
+	int ret;
+
+	if (p->mds_data)
+		return 0;
+
+	crc_name = xstrdup(p->pack_name);
+	strcpy(crc_name + strlen(crc_name) - strlen(".pack"), ".mds");
+	ret = check_packed_git_mds(crc_name, p);
+	free(crc_name);
+	return ret;
+}
+
 static void scan_windows(struct packed_git *p,
 	struct packed_git **lru_p,
 	struct pack_window **lru_w,
@@ -690,6 +845,15 @@ void close_pack_index(struct packed_git *p)
 	if (p->index_data) {
 		munmap((void *)p->index_data, p->index_size);
 		p->index_data = NULL;
+		p->index_size = 0;
+	}
+}
+
+void close_pack_mds(struct packed_git *p) {
+	if (p->mds_data) {
+		munmap((void *)p->mds_data, p->mds_size);
+		p->mds_data = NULL;
+		p->mds_size = 0;
 	}
 }
 
@@ -717,6 +881,7 @@ void free_pack_by_name(const char *pack_name)
 				pack_open_fds--;
 			}
 			close_pack_index(p);
+			close_pack_mds(p);
 			free(p->bad_object_sha1);
 			*pp = p->next;
 			free(p);
@@ -740,6 +905,10 @@ static int open_packed_git_1(struct packed_git *p)
 
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
+	/*
+	 * Assume an mds file might not be available - backwards compatibility
+	 */
+	if (!p->mds_data) open_pack_mds(p);
 
 	if (!pack_max_fds) {
 		struct rlimit lim;
@@ -1141,14 +1310,23 @@ static const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 	return NULL;
 }
 
-int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
+int check_sha1_signature_extended(const unsigned char *sha1,
+				  uint32_t *objcrc32p,
+				  void *map, unsigned long size,
+				  const char *type)
 {
 	unsigned char real_sha1[20];
-	hash_sha1_file(map, size, type, real_sha1);
-	return hashcmp(sha1, real_sha1) ? -1 : 0;
+	uint32_t realcrc;
+	hash_sha1_file_extended(map, size, type, real_sha1,
+				((objcrc32p == NULL)? NULL: &realcrc));
+	int ret = hashcmp(sha1, real_sha1) ? -1 : 0;
+	if (objcrc32p && ret == 0) {
+		ret = ((*objcrc32p) - realcrc)? -1 : 0;
+	}
+	return ret;
 }
 
-static int git_open_noatime(const char *name)
+int git_open_noatime(const char *name)
 {
 	static int sha1_file_open_flag = O_NOATIME;
 
@@ -1924,15 +2102,46 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	}
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+int nth_packed_object_objcrc32(const struct packed_git *p, uint32_t n,
+			       uint32_t *objcrc32p)
+{
+	int r;
+	unsigned char *base = (unsigned char *)(p->mds_data);
+	int wsize; /*size in bytes per CRC field, stored as 32-bit words */
+
+	if (base == NULL) return 0;
+
+	base += 7;
+	wsize = (*(base++)) * 4;
+	if (wsize != 4) {
+		/* other values not defined currently. */
+		return -1;
+	}
+	base += (n / 4) * (uint32_t)(4 * (1 + wsize));
+	r = n % 4;
+	if (base[r] == 0) return 0;
+	base += 4;
+	base += wsize * r;
+	*objcrc32p = *(uint32_t *) base;
+	return 1;
+}
+
+
+
+off_t find_pack_entry_one_extended(const unsigned char *sha1,
+				   struct packed_git *p,
+				   int *has_objcrc32p, uint32_t *objcrc32p)
 {
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
+	const unsigned char *mds = p->mds_data;
 	unsigned hi, lo, stride;
 	static int use_lookup = -1;
 	static int debug_lookup = -1;
 
+	if (has_objcrc32p) *has_objcrc32p = 0;
+	if (objcrc32p) *objcrc32p = 0;
+
 	if (debug_lookup < 0)
 		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
 
@@ -1942,6 +2151,11 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		level1_ofs = p->index_data;
 		index = p->index_data;
 	}
+
+	if (!mds) {
+		open_pack_mds(p);
+	}
+
 	if (p->index_version > 1) {
 		level1_ofs += 2;
 		index += 8;
@@ -1977,8 +2191,14 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		if (debug_lookup)
 			printf("lo %u hi %u rg %u mi %u\n",
 			       lo, hi, hi - lo, mi);
-		if (!cmp)
+		if (!cmp) {
+			if (has_objcrc32p && objcrc32p)
+				*(has_objcrc32p) =
+				  (nth_packed_object_objcrc32(p,
+							      mi,
+							      objcrc32p) == 1);
 			return nth_packed_object_offset(p, mi);
+		}
 		if (cmp > 0)
 			hi = mi;
 		else
@@ -2027,7 +2247,9 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 					goto next;
 		}
 
-		offset = find_pack_entry_one(sha1, p);
+		offset = find_pack_entry_one_extended(sha1, p,
+						      &(e->has_objcrc32),
+						      &(e->objcrc32));
 		if (offset) {
 			/*
 			 * We are about to tell the caller where they can
@@ -2173,14 +2395,32 @@ static void *read_packed_sha1(const unsigned char *sha1,
 	return data;
 }
 
-int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
-		      unsigned char *sha1)
+int pretend_sha1_file_extended(void *buf, unsigned long len,
+			       enum object_type type,
+			       unsigned char *sha1, uint32_t *objcrc32p)
 {
-	struct cached_object *co;
+	struct cached_object *co = NULL;
+	uint32_t crc32;
+	int has_crc32 = 0;
 
-	hash_sha1_file(buf, len, typename(type), sha1);
-	if (has_sha1_file(sha1) || find_cached_object(sha1))
+	hash_sha1_file_extended(buf, len, typename(type), sha1, &crc32);
+	if (has_sha1_file(sha1) || (co = find_cached_object(sha1))) {
+		uint32_t oldcrc32;
+		if (!has_sha1_file_crc(sha1, &oldcrc32)) {
+			if (co != NULL) {
+				oldcrc32 = co->objcrc32;
+				has_crc32 = 1;
+			}
+		} else {
+			has_crc32 = 1;
+		}
+		if (has_crc32 && oldcrc32 != crc32) {
+			  die("SHA1 COLLISION FOUND FOR %s "
+			      "(dummy commit when running blame?)",
+			      sha1_to_hex(sha1));
+		}
 		return 0;
+	}
 	if (cached_object_alloc <= cached_object_nr) {
 		cached_object_alloc = alloc_nr(cached_object_alloc);
 		cached_objects = xrealloc(cached_objects,
@@ -2191,8 +2431,10 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	co->size = len;
 	co->type = type;
 	co->buf = xmalloc(len);
+	co->objcrc32 = crc32;
 	memcpy(co->buf, buf, len);
 	hashcpy(co->sha1, sha1);
+	if (objcrc32p) *objcrc32p = crc32;
 	return 0;
 }
 
@@ -2314,8 +2556,9 @@ void *read_object_with_reference(const unsigned char *sha1,
 }
 
 static void write_sha1_file_prepare(const void *buf, unsigned long len,
-                                    const char *type, unsigned char *sha1,
-                                    char *hdr, int *hdrlen)
+				    const char *type, unsigned char *sha1,
+				    uint32_t * objcrc32p,
+				    char *hdr, int *hdrlen)
 {
 	git_SHA_CTX c;
 
@@ -2327,6 +2570,10 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
 	git_SHA1_Update(&c, hdr, *hdrlen);
 	git_SHA1_Update(&c, buf, len);
 	git_SHA1_Final(sha1, &c);
+	if (objcrc32p) {
+		*objcrc32p = crc32(0, NULL, 0);
+		*objcrc32p = htonl(crc32(*objcrc32p, buf, len));
+	}
 }
 
 /*
@@ -2382,12 +2629,13 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-int hash_sha1_file(const void *buf, unsigned long len, const char *type,
-                   unsigned char *sha1)
+int hash_sha1_file_extended(const void *buf, unsigned long len,
+			    const char *type,
+			    unsigned char *sha1, uint32_t *objcrc32p)
 {
 	char hdr[32];
 	int hdrlen;
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, sha1, objcrc32p, hdr, &hdrlen);
 	return 0;
 }
 
@@ -2441,10 +2689,13 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 	return fd;
 }
 
-static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
+
+static int write_loose_object(const unsigned char *sha1, uint32_t *objcrc32p,
+			      char *hdr, int hdrlen,
 			      const void *buf, unsigned long len, time_t mtime)
 {
 	int fd, ret;
+	uint32_t crc;
 	unsigned char compressed[4096];
 	git_zstream stream;
 	git_SHA_CTX c;
@@ -2467,7 +2718,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	stream.next_out = compressed;
 	stream.avail_out = sizeof(compressed);
 	git_SHA1_Init(&c);
-
+	crc = crc32(0, NULL, 0);
 	/* First header.. */
 	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
@@ -2482,11 +2733,13 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 		unsigned char *in0 = stream.next_in;
 		ret = git_deflate(&stream, Z_FINISH);
 		git_SHA1_Update(&c, in0, stream.next_in - in0);
+		crc = crc32(crc, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die("unable to write sha1 file");
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
 	} while (ret == Z_OK);
+	crc = htonl(crc);
 
 	if (ret != Z_STREAM_END)
 		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
@@ -2496,9 +2749,10 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_SHA1_Final(parano_sha1, &c);
 	if (hashcmp(sha1, parano_sha1) != 0)
 		die("confused by unstable object source data for %s", sha1_to_hex(sha1));
-
+	if (objcrc32p && ((*objcrc32p) != crc)) {
+		die("confused by unstable object source data (crc mismatch) for %s", sha1_to_hex(sha1));
+	}
 	close_sha1_file(fd);
-
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
@@ -2508,24 +2762,41 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 				tmpfile, strerror(errno));
 	}
 
-	return move_temp_to_file(tmpfile, filename);
+	ret = move_temp_to_file(tmpfile, filename);
+	if (ret == 0) {
+		crcdb_open(NULL);
+		crcdb_process((crcdb_t)NULL, sha1, crc);
+		crcdb_close(NULL);
+	}
+	return ret;
 }
 
-int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+int write_sha1_file_extended(const void *buf, unsigned long len,
+			     const char *type, unsigned char *returnsha1,
+			     uint32_t *objcrc32p)
 {
 	unsigned char sha1[20];
 	char hdr[32];
 	int hdrlen;
+	uint32_t newcrc;
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, sha1, &newcrc, hdr, &hdrlen);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
+	if (objcrc32p) *objcrc32p = newcrc;
+	if (has_sha1_file(sha1)) {
+		uint32_t oldcrc;
+		if (has_sha1_file_crc(sha1, &oldcrc)) {
+			if (newcrc != oldcrc) {
+				die("hash collision");
+			}
+		}
 		return 0;
-	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+	}
+	return write_loose_object(sha1, &newcrc, hdr, hdrlen, buf, len, 0);
 }
 
 int force_object_loose(const unsigned char *sha1, time_t mtime)
@@ -2536,6 +2807,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	char hdr[32];
 	int hdrlen;
 	int ret;
+	uint32_t * const objcrc32p = NULL;
 
 	if (has_loose_object(sha1))
 		return 0;
@@ -2543,7 +2815,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
-	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(sha1, objcrc32p, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
 	return ret;
@@ -2572,6 +2844,86 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_loose_object(sha1);
 }
 
+int has_sha1_file_crc(const unsigned char *sha1, uint32_t *objcrc32p)
+{
+	struct pack_entry e;
+
+
+	/*
+	 * builtin/send-pack.c uses a null SHA1 (all bytes zero) to
+	 * indicate that a SHA-1 hash does not exist.  We explicitly
+	 * return 0 for this case, for correct behavior even if we
+	 * somehow get that value into the database.
+	 */
+	if (!hashcmp(sha1, null_sha1)) return 0;
+
+	if (find_pack_entry(sha1, &e)) {
+		if (e.has_objcrc32) {
+			if (objcrc32p) *objcrc32p = e.objcrc32;
+			return 1;
+		} else {
+#ifdef PACKDB
+			if (e.p && e.p->pack_local) {
+				/*
+				 * We have a local pack file, but could not
+				 * find the CRC, so we first check if the
+				 * CRC is still stored for loose objects.
+				 * Then we try packdb (separate database for
+				 * packed objects) and if it is not there, we
+				 * compute it from scratch and add it to
+				 * packdb.
+				 */
+				if (has_loose_object_local_crc(sha1,
+							       objcrc32p)) {
+					return 1;
+				} else {
+					int status ;
+					packdb_open();
+					status = (packdb_lookup(sha1,
+								objcrc32p)
+						  == 1);
+					if (status == 0) {
+						unsigned long len;
+						enum object_type type;
+						uint32_t crc;
+						crc = crc32(0, NULL, 0);
+						void *buf = read_sha1_file
+							(sha1, &type, &len);
+						crc = htonl(crc32(crc,
+								  buf, len));
+						switch(packdb_process
+						       (sha1, crc)) {
+						case 0:
+							if (objcrc32p)
+								*objcrc32p
+									= crc;
+							status = 1;
+							break;
+						case 1:
+							error("packdb insert"
+							      " botched");
+							status = 0;
+							break;
+						case -1:
+							error("packdb failed");
+							status = 0;
+							break;
+						}
+					}
+					packdb_close();
+					return status;
+				}
+			} else {
+				return 0;
+			}
+#else
+			return has_loose_object_local_crc(sha1, objcrc32p);
+#endif
+		}
+	}
+	return has_loose_object_crc(sha1, objcrc32p);
+}
+
 static void check_tree(const void *buf, size_t size)
 {
 	struct tree_desc desc;
@@ -2600,7 +2952,8 @@ static void check_tag(const void *buf, size_t size)
 		die("corrupt tag");
 }
 
-static int index_mem(unsigned char *sha1, void *buf, size_t size,
+static int index_mem(unsigned char *sha1, uint32_t *objcrc32p,
+		     void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
@@ -2631,22 +2984,26 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), sha1);
+		ret = write_sha1_file_extended(buf, size, typename(type), sha1,
+					       objcrc32p);
 	else
-		ret = hash_sha1_file(buf, size, typename(type), sha1);
+		ret = hash_sha1_file_extended(buf, size, typename(type), sha1,
+				     objcrc32p);
 	if (re_allocated)
 		free(buf);
 	return ret;
 }
 
-static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
+static int index_pipe(unsigned char *sha1, uint32_t *objcrc32p,
+		      int fd, enum object_type type,
 		      const char *path, unsigned flags)
 {
 	struct strbuf sbuf = STRBUF_INIT;
 	int ret;
 
 	if (strbuf_read(&sbuf, fd, 4096) >= 0)
-		ret = index_mem(sha1, sbuf.buf, sbuf.len, type,	path, flags);
+		ret = index_mem(sha1, objcrc32p, sbuf.buf, sbuf.len, type,
+				path, flags);
 	else
 		ret = -1;
 	strbuf_release(&sbuf);
@@ -2655,24 +3012,26 @@ static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
 
 #define SMALL_FILE_SIZE (32*1024)
 
-static int index_core(unsigned char *sha1, int fd, size_t size,
+static int index_core(unsigned char *sha1, uint32_t *objcrc32p,
+		      int fd, size_t size,
 		      enum object_type type, const char *path,
 		      unsigned flags)
 {
 	int ret;
 
 	if (!size) {
-		ret = index_mem(sha1, NULL, size, type, path, flags);
+		ret = index_mem(sha1, objcrc32p, NULL, size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
-			ret = index_mem(sha1, buf, size, type, path, flags);
+			ret = index_mem(sha1, objcrc32p,
+					buf, size, type, path, flags);
 		else
 			ret = error("short read %s", strerror(errno));
 		free(buf);
 	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(sha1, buf, size, type, path, flags);
+		ret = index_mem(sha1, objcrc32p, buf, size, type, path, flags);
 		munmap(buf, size);
 	}
 	return ret;
@@ -2692,7 +3051,8 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
  * avoid mmaping it in core is to deal with large binary blobs, and
  * by definition they do _not_ want to get any conversion.
  */
-static int index_stream(unsigned char *sha1, int fd, size_t size,
+static int index_stream(unsigned char *sha1, uint32_t *ojbcrc32p,
+			int fd, size_t size,
 			enum object_type type, const char *path,
 			unsigned flags)
 {
@@ -2757,23 +3117,25 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 	return 0;
 }
 
-int index_fd(unsigned char *sha1, int fd, struct stat *st,
-	     enum object_type type, const char *path, unsigned flags)
+int index_fd_extended(unsigned char *sha1, uint32_t *objcrc32p,
+		      int fd, struct stat *st,
+		      enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
 	size_t size = xsize_t(st->st_size);
 
 	if (!S_ISREG(st->st_mode))
-		ret = index_pipe(sha1, fd, type, path, flags);
+		ret = index_pipe(sha1, objcrc32p, fd, type, path, flags);
 	else if (size <= big_file_threshold || type != OBJ_BLOB)
-		ret = index_core(sha1, fd, size, type, path, flags);
+		ret = index_core(sha1, objcrc32p, fd, size, type, path, flags);
 	else
-		ret = index_stream(sha1, fd, size, type, path, flags);
+		ret = index_stream(sha1, objcrc32p,
+				   fd, size, type, path, flags);
 	close(fd);
 	return ret;
 }
 
-int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags)
+int index_path_extended(unsigned char *sha1, uint32_t *objcrc32p, const char *path, struct stat *st, unsigned flags)
 {
 	int fd;
 	struct strbuf sb = STRBUF_INIT;
@@ -2784,7 +3146,8 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 		if (fd < 0)
 			return error("open(\"%s\"): %s", path,
 				     strerror(errno));
-		if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
+		if (index_fd_extended(sha1, objcrc32p, fd, st,
+				      OBJ_BLOB, path, flags) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
@@ -2795,8 +3158,10 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 			             errstr);
 		}
 		if (!(flags & HASH_WRITE_OBJECT))
-			hash_sha1_file(sb.buf, sb.len, blob_type, sha1);
-		else if (write_sha1_file(sb.buf, sb.len, blob_type, sha1))
+			hash_sha1_file_extended(sb.buf, sb.len, blob_type, sha1,
+				       objcrc32p);
+		else if (write_sha1_file_extended(sb.buf, sb.len, blob_type,
+						  sha1, objcrc32p))
 			return error("%s: failed to insert into database",
 				     path);
 		strbuf_release(&sb);
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4e8f43..28c2ba2 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -34,17 +34,18 @@ fi
 # git init has been done in an empty repository.
 # make sure it is empty.
 
-find .git/objects -type f -print >should-be-empty
+find .git/objects -type f -a  ! -name crcs -a ! -name packdb -print >should-be-empty
 test_expect_success \
     '.git/objects should be empty after git init in an empty repo.' \
     'cmp -s /dev/null should-be-empty'
 
-# also it should have 2 subdirectories; no fan-out anymore, pack, and info.
-# 3 is counting "objects" itself
-find .git/objects -type d -print >full-of-directories
+# also it should have 3 subdirectories;
+# no fan-out anymore, pack, and info and crcs.
+# 4 (listed by find) is the result of counting "objects" as well.
+find .git/objects \( -type d -o -name crcs  \) -print >full-of-directories
 test_expect_success \
-    '.git/objects should have 3 subdirectories.' \
-    'test $(wc -l < full-of-directories) = 3'
+    '.git/objects should have 3 subdirectories or files.' \
+    'test $(wc -l < full-of-directories) = 4'
 
 ################################################################
 # Test harness
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 602806d..880b425 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -54,7 +54,7 @@ cd "$TRASH/.git2"
 
 test_expect_success \
     'check unpack without delta' \
-    '(cd ../.git && find objects -type f -print) |
+    '(cd ../.git && find objects -type f  -print) | grep -v crcs |
      while read path
      do
          cmp $path ../.git/$path || {
@@ -84,7 +84,7 @@ unset GIT_OBJECT_DIRECTORY
 cd "$TRASH/.git2"
 test_expect_success \
     'check unpack with REF_DELTA' \
-    '(cd ../.git && find objects -type f -print) |
+    '(cd ../.git && find objects -type f -print) | grep -v crcs |
      while read path
      do
          cmp $path ../.git/$path || {
@@ -114,7 +114,7 @@ unset GIT_OBJECT_DIRECTORY
 cd "$TRASH/.git2"
 test_expect_success \
     'check unpack with OFS_DELTA' \
-    '(cd ../.git && find objects -type f -print) |
+    '(cd ../.git && find objects -type f -print) | grep -v crcs |
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
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index bafcca7..1274c79 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -53,8 +53,8 @@ pull_to_client () {
 			git symbolic-ref HEAD refs/heads/`echo $heads \
 				| sed -e "s/^\(.\).*$/\1/"` &&
 
-			git fsck --full &&
-
+			git fsck --full  &&
+			test -z "`git count-objects -v -M | grep MD`" &&
 			mv .git/objects/pack/pack-* . &&
 			p=`ls -1 pack-*.pack` &&
 			git unpack-objects <$p &&
@@ -142,7 +142,8 @@ test_expect_success 'fsck in shallow repo' '
 test_expect_success 'simple fetch in shallow repo' '
 	(
 		cd shallow &&
-		git fetch
+		git fetch &&
+		test -z "`git count-objects -v -M | grep MD`"
 	)
 '
 
@@ -245,7 +246,8 @@ test_expect_success 'clone shallow object count' '
 		cd shallow &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 52" count.shallow
+	grep "^count: 52" count.shallow  &&
+	test -z "`git count-objects -v -M | grep MD`"
 '
 
 test_done
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e0af4c4..3ce6027 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -14,6 +14,12 @@ test_bundle_object_count () {
 	test "$2" = $(grep '^[0-9a-f]\{40\} ' verify.out | wc -l)
 }
 
+test_bundle_mds_count () {
+	git verify-pack -v -M "$1" >verify.out &&
+	test "$2" = $(grep '^[0-9a-f]\{40\} ' verify.out | grep -v "<no md>" | wc -l)
+}
+
+
 test_expect_success setup '
 	echo >file original &&
 	git add file &&
@@ -215,7 +221,8 @@ test_expect_success 'bundle 1 has only 3 files ' '
 		cat
 	) <bundle1 >bundle.pack &&
 	git index-pack bundle.pack &&
-	test_bundle_object_count bundle.pack 3
+	test_bundle_object_count bundle.pack 3 &&
+	test_bundle_mds_count bundle.pack 3
 '
 
 test_expect_success 'unbundle 2' '
@@ -238,7 +245,8 @@ test_expect_success 'bundle does not prerequisite objects' '
 		cat
 	) <bundle3 >bundle.pack &&
 	git index-pack bundle.pack &&
-	test_bundle_object_count bundle.pack 3
+	test_bundle_object_count bundle.pack 3 &&
+	test_bundle_mds_count bundle.pack 3
 '
 
 test_expect_success 'bundle should be able to create a full history' '
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
diff --git a/upload-pack.c b/upload-pack.c
index 470cffd..9721074 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -320,11 +320,32 @@ static int got_sha1(char *hex, unsigned char *sha1)
 {
 	struct object *o;
 	int we_knew_they_have = 0;
+	int has_sha1_objcrc, has_objcrc32, has_sha1_blobcrc, has_blobcrc;
+	uint32_t sha1_objcrc, objcrc32, sha1_blobcrc, blobcrc;
 
-	if (get_sha1_hex(hex, sha1))
+	if (get_sha1_hex_crc(hex, sha1, &has_sha1_objcrc, &sha1_objcrc,
+			     &has_sha1_blobcrc, &sha1_blobcrc))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
 	if (!has_sha1_file(sha1))
 		return -1;
+	has_sha1_objcrc = has_sha1_file_crc(sha1, &objcrc32);
+	if (has_sha1_objcrc && has_objcrc32 && objcrc32 != sha1_objcrc) {
+		die("git upload-pack: SHA1 collision on MD for %s", hex);
+	}
+	has_blobcrc = !get_blob_mds(sha1, &blobcrc);
+
+	if (has_sha1_blobcrc) {
+		if (has_blobcrc) {
+			if (sha1_blobcrc != blobcrc) {
+				die("git upload-pack: SHA1 collision "
+				    "on blob-MD for %s", hex);
+			}
+		} else {
+#ifdef BLOB_MDS_CHECK
+			push_mds_check(sha1, sha1_blobcrc);
+#endif
+		}
+	}
 
 	o = lookup_object(sha1);
 	if (!(o && o->parsed))
@@ -719,7 +740,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed mds-check";
 	struct object *o = parse_object(sha1);
 	const char *refname_nons = strip_namespace(refname);
 
@@ -775,6 +796,9 @@ static void upload_pack(void)
 	if (want_obj.nr) {
 		get_common_commits();
 		create_pack_file();
+#ifdef BLOB_MDS_CHECK
+		process_mds_checks(die);
+#endif
 	}
 }
 
-- 
1.7.1
