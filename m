From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: [PATCH 2/6] Add caching of message digests for objects.
Date: Tue, 20 Dec 2011 23:10:33 -0800
Message-ID: <1324451433.1684.20.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 21 08:10:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdGJw-0008Le-Dr
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 08:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab1LUHKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 02:10:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33183 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1LUHKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 02:10:30 -0500
Received: by iaeh11 with SMTP id h11so11460177iae.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Qzopd4ws6btDfhwoS0O4uGzOANZ7Td7Giu9TIILMbws=;
        b=pIGuOwcdR+0aOVZ+QKTzGnF7/qM0b3/ojqhwc2lr9NhenU7lRdWZVXwNgppcEJhn74
         O+DuQhAz5Lx6U0r3auve7LzLJLVI7+JfZ/3Gj8Rnb5QyaOKx0M5sai4m0nUNtFt497F4
         hRqArf2qqUPCqV7w/irHLgKvT0kT9/lJYaexo=
Received: by 10.50.17.195 with SMTP id q3mr1586934igd.11.1324451429468;
        Tue, 20 Dec 2011 23:10:29 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id t5sm16789361igb.4.2011.12.20.23.10.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 23:10:27 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187552>

Message digests are created when git objects are created.
The digests are stored in either their own files or in
an "mds" file that goes with a pack file's index file.
Most of the changes are in sha1_file.c, with a function
to create an mds file in pack-write.c. Macros in cache.h
allow the previous function calls to be used - some now
take a pointer to a digest as an argument. Hex.c was
modified to print message digests in hexadecimal, and
a test script was modified to account for a new directory
in objects.

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 Makefile          |  121 ++++++++++++
 builtin/init-db.c |   17 ++
 cache.h           |   72 ++++++-
 environment.c     |   57 ++++++
 git.c             |   14 ++-
 hex.c             |  106 ++++++++++-
 pack-write.c      |  120 ++++++++++++
 pack.h            |    3 +
 sha1_file.c       |  560 +++++++++++++++++++++++++++++++++++++++++++++++------
 t/t0000-basic.sh  |   13 +-
 10 files changed, 1012 insertions(+), 71 deletions(-)

diff --git a/Makefile b/Makefile
index 9470a10..759df5c 100644
--- a/Makefile
+++ b/Makefile
@@ -278,6 +278,92 @@ all::
 # dependency rules.
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
+#
+#
+# Set MDSDB to indicate the database type for the DB mapping SHA1
+# values to the MDs (Message Digests) of the objects git stores.
+# Valid values are:
+#
+#   0 for storing each local-object MD in its own file.
+#
+# [more to be added as needed - a legal value is mandatory].
+#
+# Note: the values for MDSDB are determined by preprocessor directives
+# defined in mdsdb.h This constant must be defined so that necessary
+# files are compiled.
+#
+MDSDB = 0
+
+#
+# Define MDIGEST_DEFAULT to set the default type of MD for authentication and
+# hash-collision detection.  Legal values
+# are:
+#      MDIGEST_CRC - use a CRC (used only as a minimal digest for performance
+#                    testing).
+#
+#     MDIGEST_SHA1 - use a SHA-1 digest.
+#
+#   MDIGEST_SHA256 - use a SHA-256 digest.
+#
+#   MDIGEST_SHA512 - use a SHA-512 digest.
+#
+# (additional ones may be added as needed.)
+#
+# Note: the message digests computed are for uncompressed objects, not
+# including the Git object-header.  If not set, a default defined in the
+# file mdigest.h will be used.
+#
+MDIGEST_DEFAULT = MDIGEST_SHA256
+
+#
+# Define PACKDB to use a GDBM-like database for storing message
+# digests compactly when those digests are not available using the
+# normal mechanisms.  As an example, if an alternate object database
+# is used and if it was created using an older version of git, message
+# digests may not be available, and git by design cannot modify an
+# alternate object database, so the message digests cannot be added to
+# it.  If PACKDB is not defined, at certain points (e.g., during a
+# commit, the digest for an object in an alternate object database
+# will be calculated each time.  When PACKDB is defined, the object's
+# digest is calculated once and stored in the packdb database.  GDBM
+# is too slow for use in general, but it is adequate for handling
+# unusual cases.
+#
+# Valid values are:
+#
+#                0 - use GDBM to implement the database.
+#    [not defined] - do nothing.
+#
+# [more can be added as needed].
+#
+PACKDB =
+
+# Define PACKDB_TEST in order to turn on an inefficient
+# test for PACKDB functions.  This code will add an entry to the packdb
+# database during commits when such an entry is not necessary and then
+# will read it back to make sure the data was added correctly. The option
+# has no effect if PACKDB is not defined.
+#
+# NOTE: this option should not be used in a released version of Git.
+#
+PACKDB_TEST =
+
+# Define COMMIT_DIGEST to include a 'digest' header in a commit. The header
+# will contain a 2-character code indicating the digest type, followed
+# immediately by the digest.  We are delaying turning this on by default
+# until the test scripts are updated, as the test scripts include explicit
+# file lengths and SHA-1 values.
+
+COMMIT_DIGEST =
+
+# Define COMMIT_DIGEST_TEST to force get_objects_mds to be called even if
+# COMMIT_DIGEST is not defined (in which case the digest header will not
+# appear in the commit object created).
+#
+# NOTE: this option should not be used in a released version of Git.
+#
+
+COMMIT_DIGEST_TEST =
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -536,7 +622,9 @@ LIB_H += blob.h
 LIB_H += builtin.h
 LIB_H += bulk-checkin.h
 LIB_H += cache.h
+LIB_H += mdigest.h
 LIB_H += cache-tree.h
+LIB_H += mdsdb.h
 LIB_H += color.h
 LIB_H += commit.h
 LIB_H += compat/bswap.h
@@ -711,6 +799,7 @@ LIB_OBJS += sequencer.o
 LIB_OBJS += sha1-array.o
 LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1_file.o
+LIB_OBJS += mdigest.o
 LIB_OBJS += sha1_name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
@@ -836,6 +925,7 @@ BUILTIN_OBJS += builtin/write-tree.o
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
+
 #
 # Platform specific tweaks
 #
@@ -1721,6 +1811,37 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON=NoThanks
 endif
 
+ifdef MDSDB
+BASIC_CFLAGS += -DBLOB_MDS_CHECK
+endif
+
+ifdef COMMIT_DIGEST
+BASIC_CFLAGS += -DCOMMIT_DIGEST
+endif
+
+ifdef COMMIT_DIGEST_TEST
+BASIC_CFLAGS += -DCOMMIT_DIGEST_TEST
+endif
+
+ifdef MDIGEST_DEFAULT
+BASIC_CFLAGS += -DMDIGEST_DEFAULT=$(MDIGEST_DEFAULT)
+endif
+
+ifeq ($(MDSDB), 0)
+BASIC_CFLAGS += -DMDSDB=$(MDSDB)
+LIB_OBJS += objd-mdsdb.o
+endif
+
+ifeq ($(PACKDB), 0)
+BASIC_CFLAGS += -DPACKDB
+LIB_OBJS += gdbm-packdb.o
+EXTLIBS += -lgdbm
+endif
+
+ifdef PACKDB_TEST
+BASIC_CFLAGS += -DPACKDB_TEST
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index d07554c..6d5ec0f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -7,6 +7,10 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "mdsdb.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -309,6 +313,19 @@ static void create_object_directory(void)
 	strcpy(path+len, "/info");
 	safe_create_dir(path, 1);
 
+#if (MDSDB == 0)
+	strcpy(path+len, "/mdsd");
+	safe_create_dir(path, 1);
+#endif
+	/*
+	 * In case the call in environent.c failed to initialize
+	 * (missing directory?) or somehow wasn't called at all.
+	 */
+	mdsdb_init();
+	mdigest_init();
+#ifdef PACKDB
+	packdb_init();
+#endif
 	free(path);
 }
 
diff --git a/cache.h b/cache.h
index 7d93df6..17e3dd4 100644
--- a/cache.h
+++ b/cache.h
@@ -16,6 +16,7 @@
 #define git_SHA1_Final	SHA1_Final
 #endif
 
+#include "mdigest.h"
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
@@ -433,6 +434,10 @@ extern int is_inside_work_tree(void);
 extern int have_git_dir(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
+extern char *get_object_mds_directory(void);
+#ifdef PACKDB
+extern char *get_object_packdb_node(void);
+#endif
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
@@ -541,8 +546,15 @@ extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pa
 
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
-extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
-extern int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags);
+
+#define index_fd(sha1,fd,st,type,path,flags)			\
+	index_fd_extended((sha1), NULL, (fd), (st), (type), (path), (flags))
+extern int index_fd_extended(unsigned char *sha1, mdigest_t *mdigestp, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
+
+#define index_path(sha1, path, st, flags) \
+	index_path_extended((sha1), NULL, (path), (st), (flags))
+extern int index_path_extended(unsigned char *sha1, mdigest_t *mdigestp, const char *path
+, struct stat *st, unsigned flags);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
@@ -670,6 +682,7 @@ extern char *git_path_submodule(const char *path, const char *fmt, ...)
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
+extern char *sha1_pack_mds_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
 
@@ -769,9 +782,18 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
-extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
-extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+
+#define hash_sha1_file(buf,len,type,sha1) \
+	hash_sha1_file_extended((buf), (len), (type), (sha1), NULL)
+extern int hash_sha1_file_extended(const void *buf, unsigned long len, const char *type, unsigned char *sha1, mdigest_t *mdigestp);
+
+#define write_sha1_file(buf,len,type,return_sha1) \
+	write_sha1_file_extended((buf), (len), (type), (return_sha1), NULL)
+extern int write_sha1_file_extended(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1, mdigest_t *mdigestp);
+
+#define pretend_sha1_file(buf,len,type,sha1) \
+	pretend_sha1_file_extended((buf), (len), (type), (sha1), NULL)
+extern int pretend_sha1_file_extended(void *, unsigned long, enum object_type, unsigned char *, mdigest_t *mdigestp);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
@@ -783,13 +805,18 @@ extern int do_check_packed_object_crc;
 /* for development: log offset of pack access */
 extern const char *log_pack_access;
 
-extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
+#define check_sha1_signature(sha1,buf,size,type) \
+	check_sha1_signature_extended((sha1), NULL, (buf), (size), (type))
+extern int check_sha1_signature_extended(const unsigned char *sha1, mdigest_t *mdigestp, void *buf, unsigned long size, const char *type);
 
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
+extern int has_sha1_file_digest(const unsigned char *sha1, mdigest_t *mdigestp);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
+extern int has_loose_object_nonlocal_digest(const unsigned char *sha1,
+					    mdigest_t *mdigestp);
 
 extern int has_pack_index(const unsigned char *sha1);
 
@@ -831,8 +858,19 @@ static inline int get_sha1_with_context(const char *str, unsigned char *sha1, st
  * null-terminated string.
  */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
-
+extern int get_sha1_hex_digest(const char *hex, unsigned char *sha1,
+			       int *has_digest, mdigest_t *digestp);
+/*
+ * get_mdigest_from_external_hex assumes hex is terminated by something that is
+ * not alphanumeric, so the string does not have to be null terminated.
+ */
+extern int get_mdigest_from_external_hex(mdigest_t *digestp, const char *hex);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern char *sha1_to_hex_digest(const unsigned char *sha1,
+				const mdigest_t *digestp); /* static buffer result! */
+
+extern int get_hex_field_size(char *hex);
+
 extern int read_ref_full(const char *filename, unsigned char *sha1,
 			 int reading, int *flags);
 extern int read_ref(const char *filename, unsigned char *sha1);
@@ -978,10 +1016,13 @@ extern struct packed_git {
 	off_t pack_size;
 	const void *index_data;
 	size_t index_size;
+	const void *mds_data;
+	size_t mds_size;
 	uint32_t num_objects;
 	uint32_t num_bad_objects;
 	unsigned char *bad_object_sha1;
 	int index_version;
+	int mds_version;
 	time_t mtime;
 	int pack_fd;
 	unsigned pack_local:1,
@@ -996,6 +1037,8 @@ struct pack_entry {
 	off_t offset;
 	unsigned char sha1[20];
 	struct packed_git *p;
+	int has_mdigest;
+	mdigest_t mdigest;
 };
 
 struct ref {
@@ -1050,6 +1093,11 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
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
@@ -1058,8 +1106,16 @@ extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
+extern int nth_packed_object_mdigest(const struct packed_git *p, uint32_t n,
+				      mdigest_t *mdigestp);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
-extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
+
+#define find_pack_entry_one(sha1,p) find_pack_entry_one_extended((sha1),(p), NULL, NULL)
+extern off_t find_pack_entry_one_extended(const unsigned char *,
+					  struct packed_git *,
+					  int *has_mdigestp,
+					  mdigest_t *mdigestp);
+
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/environment.c b/environment.c
index c93b8f4..5ced2e2 100644
--- a/environment.c
+++ b/environment.c
@@ -10,6 +10,10 @@
 #include "cache.h"
 #include "refs.h"
 #include "fmt-merge-msg.h"
+#include "mdsdb.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
@@ -77,6 +81,10 @@ static size_t namespace_len;
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
 
+static char *git_object_mds_dir;
+#ifdef PACKDB
+static char *git_object_packdb_node;
+#endif
 /*
  * Repository-local GIT_* environment variables
  * Remember to update local_repo_env_size in cache.h when
@@ -118,6 +126,11 @@ static char *expand_namespace(const char *raw_namespace)
 
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
@@ -131,6 +144,31 @@ static void setup_git_env(void)
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
 	}
+	ocn_len = strlen(git_object_dir) + 8 + strlen(getcwd(cwdbuf, PATH_MAX));
+	git_object_mds_dir = xmalloc(ocn_len);
+	memset(git_object_mds_dir, 0, ocn_len);
+	sprintf(git_object_mds_dir, "%s/mdsd", git_object_dir);
+	if (git_object_mds_dir[0] != '/') {
+		int ocn_offset = (git_object_mds_dir[0] == '.' &&
+				  git_object_mds_dir[1] == '/')? 2:0;
+		memset(git_object_mds_dir, 0, ocn_len);
+		sprintf(git_object_mds_dir, "%s/%s/mdsd",
+			getcwd(cwdbuf, PATH_MAX), git_object_dir + ocn_offset);
+	}
+#ifdef PACKDB
+	opn_len = strlen(git_object_dir)
+		+ 10 + strlen(getcwd(cwdbuf, PATH_MAX));
+	git_object_packdb_node = xmalloc(opn_len);
+	memset(git_object_packdb_node, 0, opn_len);
+	sprintf(git_object_packdb_node, "%s/packdb", git_object_dir);
+	if (git_object_packdb_node[0] != '/') {
+		int opn_offset = (git_object_mds_dir[0] == '.' &&
+				  git_object_mds_dir[1] == '/')? 2:0;
+		memset(git_object_packdb_node, 0, opn_len);
+		sprintf(git_object_packdb_node, "%s/%s/packdb",
+			getcwd(cwdbuf, PATH_MAX), git_object_dir + opn_offset);
+	}
+#endif
 	git_index_file = getenv(INDEX_ENVIRONMENT);
 	if (!git_index_file) {
 		git_index_file = xmalloc(strlen(git_dir) + 7);
@@ -143,6 +181,11 @@ static void setup_git_env(void)
 		read_replace_refs = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	namespace_len = strlen(namespace);
+	mdsdb_init();
+	mdigest_init();
+#ifdef PACKDB
+	packdb_init();
+#endif
 }
 
 int is_bare_repository(void)
@@ -210,6 +253,20 @@ char *get_object_directory(void)
 	return git_object_dir;
 }
 
+char *get_object_mds_directory(void) {
+	if (!git_object_mds_dir)
+		setup_git_env();
+	return git_object_mds_dir;
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
diff --git a/git.c b/git.c
index fb9029c..f43328f 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,10 @@
 #include "help.h"
 #include "quote.h"
 #include "run-command.h"
-
+#include "mdsdb.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
@@ -279,6 +282,15 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	struct stat st;
 	const char *prefix;
 
+	static int mdsdb_need_atexit = 1;
+
+	if (mdsdb_need_atexit) {
+#ifdef PACKDB
+		atexit(packdb_finish);
+#endif
+		atexit(mdsdb_finish);
+		mdsdb_need_atexit = 0;
+	}
 	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
diff --git a/hex.c b/hex.c
index 9ebc050..46c8b8b 100644
--- a/hex.c
+++ b/hex.c
@@ -1,3 +1,4 @@
+#include <ctype.h>
 #include "cache.h"
 
 const signed char hexval_table[256] = {
@@ -56,10 +57,55 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 	return 0;
 }
 
+int get_mdigest_from_external_hex(mdigest_t *digestp, const char *hex)
+{
+	int max = 0;
+	int wcode = 0, blen;
+	const char *ptr = hex;
+	char ch1, ch2;
+	unsigned char *out = digestp->buffer.buffer;
+
+	if (isalnum((ch1 = *(ptr++))) && isalnum((ch2 = *(ptr++)))) {
+		unsigned int val = (hexval(ch1) << 4) | hexval(ch2);
+		if (val & ~0xff)
+			return -1;
+		wcode = (int) val;
+	}
+	blen = get_mdigest_required_len(wcode);
+
+	while (isalnum((ch1 = *(ptr++))) && isalnum((ch2 = *(ptr++)))) {
+		unsigned int val = (hexval(ch1) << 4) | hexval(ch2);
+		if (val & ~0xff)
+			return -1;
+		*(out++) = val;
+		max += 2;
+	}
+	if (max != 2 * blen) return -1;
+	mdigest_load(digestp, wcode, NULL);
+	return max + 2;		/* add the 2 chars for wcode */
+}
+
+int get_sha1_hex_digest(const char *hex, unsigned char *sha1,
+			int *has_digest, mdigest_t *digestp)
+{
+	int result = get_sha1_hex(hex, sha1);
+	if (result) return result;
+	if (hex[40] == '-') {
+		int cnt = get_mdigest_from_external_hex(digestp, hex+41 );
+		*has_digest = (cnt > 0);
+		if (!*has_digest) return -1;
+	} else {
+		*has_digest = 0;
+		mdigest_clear(digestp);
+	}
+	return 0;
+}
+
+
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
-	static char hexbuffer[4][50];
+	static char hexbuffer[4][50 + 2 + (MAX_DIGEST_LENGTH * 4)];
 	static const char hex[] = "0123456789abcdef";
 	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
 	int i;
@@ -73,3 +119,61 @@ char *sha1_to_hex(const unsigned char *sha1)
 
 	return buffer;
 }
+
+char *mdigest_to_hex(const mdigest_t *digestp) {
+	static int bufno;
+	static char hexbuffer[4][(MAX_DIGEST_LENGTH *2) + 1];
+	static const char hex[] = "0123456789abcdef";
+	const unsigned char *inbuf = get_mdigest_buffer(digestp);
+	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
+	int i;
+	int len = get_mdigest_len(digestp);
+
+	for (i = 0; i < len; i++) {
+		unsigned int val = *inbuf++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+	*buf = '\0';
+
+	return buffer;
+
+}
+
+char *mdigest_to_external_hex(const mdigest_t *digestp) {
+	static int bufno;
+	static char hexbuffer[4][((MAX_DIGEST_LENGTH + 1) * 2) + 1];
+	static const char hex[] = "0123456789abcdef";
+	const unsigned char *inbuf = get_mdigest_buffer(digestp);
+	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
+	int i;
+	int len = get_mdigest_len(digestp);
+	int wcode = get_mdigest_wcode(digestp);
+	unsigned int wval = wcode & 0xff;
+	*buf++ = hex[wval >> 4];
+	*buf++ = hex[wval & 0xf];
+	for (i = 0; i < len; i++) {
+		unsigned int val = *inbuf++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+	*buf = '\0';
+
+	return buffer;
+
+}
+
+char *sha1_to_hex_digest(const unsigned char *sha1, const mdigest_t *digestp)
+{
+	char *result = sha1_to_hex(sha1);
+	sprintf(result+40, "-%s", mdigest_to_external_hex(digestp));
+	return result;
+}
+
+int get_hex_field_size(char *hex) {
+	int tmp;
+	if (!isalnum(hex[0]) || !isalnum(hex[1])) return -1;
+	unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+	tmp = get_mdigest_required_len((int) (val & 0xff));
+	return (tmp < 0)? tmp: 2 * (tmp + 1);
+}
diff --git a/pack-write.c b/pack-write.c
index de2bd01..fe461a5 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -194,6 +194,117 @@ off_t write_pack_header(struct sha1file *f, uint32_t nr_entries)
 	return sizeof(hdr);
 }
 
+const char *write_mds_file(const char *crc_name,
+			   struct pack_idx_entry **objects,
+			   int nr,
+			   const struct pack_idx_option *opts,
+			   unsigned char *sha1)
+{
+	static unsigned char buffer[4 + 4 * MAX_DIGEST_LENGTH];
+	unsigned char *base = buffer;
+	int i, j, fd;
+	struct sha1file *f;
+	int wsize = get_mdigest_wsize_by_type(MDIGEST_DEFAULT);
+	int wbsize = wsize * 4;
+
+	for (i = 0; i < nr; i += 4) {
+		if (objects[i]->has_digest) {
+			int ws = get_mdigest_wsize(&(objects[i]->digest));
+			if (wsize < ws) wsize = ws;
+		}
+	}
+	wbsize = wsize * 4;
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
+		if (!crc_name) {
+			static char tmpfile[PATH_MAX];
+			fd = odb_mkstemp(tmpfile, sizeof(tmpfile),
+					 "pack/tmp_mds_XXXXXX");
+			crc_name = xstrdup(tmpfile);
+		} else {
+			unlink(crc_name);
+			fd = open(crc_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+		}
+		if (fd < 0)
+			die_errno("unable to create '%s'", crc_name);
+		f = sha1fd(fd, crc_name);
+	}
+
+	*(base++) = 'P';
+	*(base++) = 'K';
+	*(base++) = 'M';
+	*(base++) = 'D';
+	*(base++) = 'S';
+	*(base++) = 0;
+	*(base++) = 1; /* version number */
+	*(base++) = (unsigned char) wsize; /* wcode */
+	sha1write(f, buffer, base - buffer);
+	base = buffer;
+
+	for (i = 0; i < nr; i += 4) {
+		int lim = ((nr-i) > 3)? 4: nr-i;
+		int has[4];
+		mdigest_t crc[4];
+		for (j = 0; j < lim; j++) {
+			if (objects[i+j]->has_digest) {
+				has[j] = get_mdigest_wcode
+					(&(objects[i+j]->digest));
+				crc[j] = objects[i+j]->digest;
+			} else {
+				has[j] =
+				  (has_sha1_file_digest(objects[i + j]->sha1,
+							&crc[j]) == 1);
+				if (has[j]) {
+					has[j] = get_mdigest_wcode(&crc[j]);
+				}
+			}
+		}
+		for (j = 0; j < 4; j++) {
+			if (j < lim) {
+				*(base)++ = has[j];
+			} else {
+				has[j] = 0;
+				mdigest_clear(&crc[j]);
+				*(base++) = 0;
+			}
+		}
+		for (j = 0; j < 4; j += 1) {
+			if (j < lim) {
+				if (has[j])
+					mdigest_to_buffer(base, &crc[j],
+							  wbsize);
+				else
+					memset(base, 0, wbsize);
+			} else {
+				memset(base, 0, wbsize);
+			}
+			base += wbsize;
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
@@ -351,6 +462,7 @@ void finish_tmp_packfile(char *name_buffer,
 			 unsigned char sha1[])
 {
 	const char *idx_tmp_name;
+	const char *mds_tmp_name;
 	char *end_of_name_prefix = strrchr(name_buffer, 0);
 
 	if (adjust_shared_perm(pack_tmp_name))
@@ -358,8 +470,12 @@ void finish_tmp_packfile(char *name_buffer,
 
 	idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
 				      pack_idx_opts, sha1);
+	mds_tmp_name = write_mds_file(NULL, written_list, nr_written,
+				      pack_idx_opts, sha1);
 	if (adjust_shared_perm(idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
+	if (adjust_shared_perm(mds_tmp_name))
+		die_errno("unable to make temporary index file readable");
 
 	sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
 	free_pack_by_name(name_buffer);
@@ -370,6 +486,10 @@ void finish_tmp_packfile(char *name_buffer,
 	sprintf(end_of_name_prefix, "%s.idx", sha1_to_hex(sha1));
 	if (rename(idx_tmp_name, name_buffer))
 		die_errno("unable to rename temporary index file");
+	sprintf(end_of_name_prefix, "%s.mds", sha1_to_hex(sha1));
+	if (rename(mds_tmp_name, name_buffer))
+		die_errno("unable to rename temporary mds file");
 
 	free((void *)idx_tmp_name);
+	free((void *)mds_tmp_name);
 }
diff --git a/pack.h b/pack.h
index aa6ee7d..759d2f4 100644
--- a/pack.h
+++ b/pack.h
@@ -70,6 +70,8 @@ struct pack_idx_entry {
 	unsigned char sha1[20];
 	uint32_t crc32;
 	off_t offset;
+	int has_digest;
+	mdigest_t digest;
 };
 

@@ -77,6 +79,7 @@ struct progress;
 typedef int (*verify_fn)(const unsigned char*, enum object_type, unsigned long, void*, int*);
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, unsigned char *sha1);
+extern const char *write_mds_file(const char *mds_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *, verify_fn fn, struct progress *, uint32_t);
diff --git a/sha1_file.c b/sha1_file.c
index f291f3f..e176d53 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -19,6 +19,10 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
+#include "mdsdb.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -41,6 +45,7 @@ const unsigned char null_sha1[20];
  */
 static struct cached_object {
 	unsigned char sha1[20];
+	unsigned char md_as_array[sizeof (mdigest_t)];
 	enum object_type type;
 	void *buf;
 	unsigned long size;
@@ -49,6 +54,7 @@ static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
 	EMPTY_TREE_SHA1_BIN_LITERAL,
+	{0,},
 	OBJ_TREE,
 	"",
 	0
@@ -223,11 +229,18 @@ char *sha1_pack_index_name(const unsigned char *sha1)
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
@@ -416,6 +429,7 @@ void prepare_alt_odb(void)
 	link_alt_odb_entries(alt, alt + strlen(alt), PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
+	mdsdb_init_alts();
 }
 
 static int has_loose_object_local(const unsigned char *sha1)
@@ -442,6 +456,53 @@ static int has_loose_object(const unsigned char *sha1)
 	       has_loose_object_nonlocal(sha1);
 }
 
+static int has_loose_object_local_digest(const unsigned char *sha1,
+				      mdigest_t *digestp)
+{
+	int status;
+	mdsdb_open(NULL);
+	status = mdsdb_lookup(NULL, sha1, digestp) > 0;
+	mdsdb_close(NULL);
+	return status;
+}
+
+int has_loose_object_nonlocal_digest(const unsigned char *sha1,
+				  mdigest_t *digestp)
+{
+	struct alternate_object_database *alt;
+
+	if (digestp == NULL) return 0;
+	prepare_alt_odb();
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		fill_sha1_path(alt->name, sha1);
+		if (!access(alt->base, F_OK)) {
+			mdigest_t xdigest;
+			/* Use the crc corresponding to the hash */
+			mdsdb_t dbf;
+			int status;
+			dbf = mdsdb_open_alt(alt);
+			status = mdsdb_lookup(dbf, sha1,
+					      (digestp? digestp: &xdigest));
+			mdsdb_close(dbf);
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
+static int has_loose_object_digest(const unsigned char *sha1,
+				   mdigest_t *digestp)
+{
+	return has_loose_object_local_digest(sha1, digestp) ||
+	       has_loose_object_nonlocal_digest(sha1, digestp);
+}
+
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
@@ -575,6 +636,87 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	return 0;
 }
 
+size_t required_git_packed_mds_size(const char *path, void *data,
+				    uint32_t nobjects,
+				    size_t actual_size) {
+	unsigned char *base;
+	int wsize, version;
+	size_t required_size;
+	if (actual_size < 8) {
+		error("mds file %s is too small", path);
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
+		error("mds file %s corrupted (bad header)",
+			     path);
+		return 0;
+
+	}
+	if ((version = *(base++)) != 1) {
+		error("mds file %s uses an unrecognized version %d",
+		      path, version);
+		return 0;
+	}
+	wsize = (*(base++)) * 4;
+	if (wsize == 0) {
+		/* must be positive and a multiple of 4 */
+		error("mds file %s corrupted (bad wsize field)",
+			     path);
+		return 0;
+	}
+	required_size = (size_t)8 +
+	  ((size_t)((nobjects)/4 + (nobjects % 4 != 0))
+	   * (size_t)(4 * (1 + wsize))) + (size_t)(20 * 2);
+	if (required_size != actual_size) {
+		error("mds file %s not the right size: %ld != %ld",
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
+		return error("mds file %s is too small", path);
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
@@ -590,6 +732,20 @@ int open_pack_index(struct packed_git *p)
 	return ret;
 }
 
+int open_pack_mds(struct packed_git *p) {
+	char *mds_name;
+	int ret;
+
+	if (p->mds_data)
+		return 0;
+
+	mds_name = xstrdup(p->pack_name);
+	strcpy(mds_name + strlen(mds_name) - strlen(".pack"), ".mds");
+	ret = check_packed_git_mds(mds_name, p);
+	free(mds_name);
+	return ret;
+}
+
 static void scan_windows(struct packed_git *p,
 	struct packed_git **lru_p,
 	struct pack_window **lru_w,
@@ -691,6 +847,15 @@ void close_pack_index(struct packed_git *p)
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
 
@@ -718,6 +883,7 @@ void free_pack_by_name(const char *pack_name)
 				pack_open_fds--;
 			}
 			close_pack_index(p);
+			close_pack_mds(p);
 			free(p->bad_object_sha1);
 			*pp = p->next;
 			free(p);
@@ -741,6 +907,10 @@ static int open_packed_git_1(struct packed_git *p)
 
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
+	/*
+	 * Assume an mds file might not be available - backwards compatibility
+	 */
+	if (!p->mds_data) open_pack_mds(p);
 
 	if (!pack_max_fds) {
 		struct rlimit lim;
@@ -1142,14 +1312,23 @@ static const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 	return NULL;
 }
 
-int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
+int check_sha1_signature_extended(const unsigned char *sha1,
+				  mdigest_t *digestp,
+				  void *map, unsigned long size,
+				  const char *type)
 {
 	unsigned char real_sha1[20];
-	hash_sha1_file(map, size, type, real_sha1);
-	return hashcmp(sha1, real_sha1) ? -1 : 0;
+	mdigest_t rdigest;
+	hash_sha1_file_extended(map, size, type, real_sha1,
+				((digestp == NULL)? NULL: &rdigest));
+	int ret = hashcmp(sha1, real_sha1) ? -1 : 0;
+	if (digestp && ret == 0) {
+		ret = mdigest_tst(digestp, &rdigest);
+	}
+	return ret;
 }
 
-static int git_open_noatime(const char *name)
+int git_open_noatime(const char *name)
 {
 	static int sha1_file_open_flag = O_NOATIME;
 
@@ -1926,15 +2105,48 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	}
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+int nth_packed_object_mdigest(const struct packed_git *p, uint32_t n,
+			       mdigest_t *digestp)
+{
+	int r;
+	unsigned char *base = (unsigned char *)(p->mds_data);
+	int wsize; /*size in bytes per MDS field, stored as 32-bit words */
+	int wcode;
+
+	if (base == NULL) return 0;
+
+	base += 7;
+	wsize = (*(base++)) * 4;
+	if (wsize == 0) {
+		/* must be positive to store a digest */
+		return -1;
+	}
+	base += (n / 4) * (uint32_t)(4 * (1 + wsize));
+	r = n % 4;
+	wcode = base[r];
+	if (wcode == 0) return 0;
+	base += 4;
+	base += wsize * r;
+	mdigest_load(digestp, wcode, base);
+	return 1;
+}
+
+
+
+off_t find_pack_entry_one_extended(const unsigned char *sha1,
+				   struct packed_git *p,
+				   int *has_digestp, mdigest_t *digestp)
 {
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
+	const unsigned char *mds = p->mds_data;
 	unsigned hi, lo, stride;
 	static int use_lookup = -1;
 	static int debug_lookup = -1;
 
+	if (has_digestp) *has_digestp = 0;
+	if (digestp) mdigest_clear(digestp);
+
 	if (debug_lookup < 0)
 		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
 
@@ -1944,6 +2156,11 @@ off_t find_pack_entry_one(const unsigned char *sha1,
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
@@ -1979,8 +2196,14 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		if (debug_lookup)
 			printf("lo %u hi %u rg %u mi %u\n",
 			       lo, hi, hi - lo, mi);
-		if (!cmp)
+		if (!cmp) {
+			if (has_digestp && digestp)
+				*(has_digestp) =
+				  (nth_packed_object_mdigest(p,
+							     mi,
+							     digestp) == 1);
 			return nth_packed_object_offset(p, mi);
+		}
 		if (cmp > 0)
 			hi = mi;
 		else
@@ -2029,7 +2252,9 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 					goto next;
 		}
 
-		offset = find_pack_entry_one(sha1, p);
+		offset = find_pack_entry_one_extended(sha1, p,
+						      &(e->has_mdigest),
+						      &(e->mdigest));
 		if (offset) {
 			/*
 			 * We are about to tell the caller where they can
@@ -2175,14 +2400,33 @@ static void *read_packed_sha1(const unsigned char *sha1,
 	return data;
 }
 
-int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
-		      unsigned char *sha1)
+int pretend_sha1_file_extended(void *buf, unsigned long len,
+			       enum object_type type,
+			       unsigned char *sha1, mdigest_t *digestp)
 {
-	struct cached_object *co;
+	struct cached_object *co = NULL;
+	mdigest_t dgst;
+	int has_dgst = 0;
 
-	hash_sha1_file(buf, len, typename(type), sha1);
-	if (has_sha1_file(sha1) || find_cached_object(sha1))
+	hash_sha1_file_extended(buf, len, typename(type), sha1, &dgst);
+	if (has_sha1_file(sha1) || (co = find_cached_object(sha1))) {
+		mdigest_t old_dgst;
+		if (!has_sha1_file_digest(sha1, &old_dgst)) {
+			if (co != NULL) {
+				memcpy(&old_dgst,co->md_as_array,
+				       sizeof (mdigest_t));
+				has_dgst = 1;
+			}
+		} else {
+			has_dgst = 1;
+		}
+		if (has_dgst && mdigest_tst(&old_dgst, &dgst)) {
+			  die("SHA1 COLLISION FOUND FOR %s "
+			      "(dummy commit when running blame?)",
+			      sha1_to_hex(sha1));
+		}
 		return 0;
+	}
 	if (cached_object_alloc <= cached_object_nr) {
 		cached_object_alloc = alloc_nr(cached_object_alloc);
 		cached_objects = xrealloc(cached_objects,
@@ -2193,8 +2437,10 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	co->size = len;
 	co->type = type;
 	co->buf = xmalloc(len);
+	memcpy(co->md_as_array, &dgst, sizeof (mdigest_t));
 	memcpy(co->buf, buf, len);
 	hashcpy(co->sha1, sha1);
+	if (digestp) *digestp = dgst;
 	return 0;
 }
 
@@ -2316,11 +2562,11 @@ void *read_object_with_reference(const unsigned char *sha1,
 }
 
 static void write_sha1_file_prepare(const void *buf, unsigned long len,
-                                    const char *type, unsigned char *sha1,
-                                    char *hdr, int *hdrlen)
+				    const char *type, unsigned char *sha1,
+				    mdigest_t *digestp,
+				    char *hdr, int *hdrlen)
 {
 	git_SHA_CTX c;
-
 	/* Generate the header */
 	*hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
 
@@ -2329,6 +2575,12 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
 	git_SHA1_Update(&c, hdr, *hdrlen);
 	git_SHA1_Update(&c, buf, len);
 	git_SHA1_Final(sha1, &c);
+	if (digestp) {
+		mdigest_context_t mdc;
+		mdigest_Init(&mdc, MDIGEST_DEFAULT);
+		mdigest_Update(&mdc, buf, len);
+		mdigest_Final(digestp, &mdc);
+	}
 }
 
 /*
@@ -2384,12 +2636,13 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-int hash_sha1_file(const void *buf, unsigned long len, const char *type,
-                   unsigned char *sha1)
+int hash_sha1_file_extended(const void *buf, unsigned long len,
+			    const char *type,
+			    unsigned char *sha1, mdigest_t *digestp)
 {
 	char hdr[32];
 	int hdrlen;
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, sha1, digestp, hdr, &hdrlen);
 	return 0;
 }
 
@@ -2443,10 +2696,14 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 	return fd;
 }
 
-static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
+
+static int write_loose_object(const unsigned char *sha1, mdigest_t *digestp,
+			      char *hdr, int hdrlen,
 			      const void *buf, unsigned long len, time_t mtime)
 {
 	int fd, ret;
+	mdigest_t digest;
+	mdigest_context_t mdc;
 	unsigned char compressed[4096];
 	git_zstream stream;
 	git_SHA_CTX c;
@@ -2469,7 +2726,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	stream.next_out = compressed;
 	stream.avail_out = sizeof(compressed);
 	git_SHA1_Init(&c);
-
+	mdigest_Init(&mdc, MDIGEST_DEFAULT);
 	/* First header.. */
 	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
@@ -2484,23 +2741,30 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 		unsigned char *in0 = stream.next_in;
 		ret = git_deflate(&stream, Z_FINISH);
 		git_SHA1_Update(&c, in0, stream.next_in - in0);
+		mdigest_Update(&mdc, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die("unable to write sha1 file");
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
 	} while (ret == Z_OK);
+	mdigest_Final(&digest, &mdc);
 
 	if (ret != Z_STREAM_END)
-		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
+		die("unable to deflate new object %s (%d)",
+		    sha1_to_hex(sha1), ret);
 	ret = git_deflate_end_gently(&stream);
 	if (ret != Z_OK)
-		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
+		die("deflateEnd on object %s failed (%d)",
+		    sha1_to_hex(sha1), ret);
 	git_SHA1_Final(parano_sha1, &c);
 	if (hashcmp(sha1, parano_sha1) != 0)
-		die("confused by unstable object source data for %s", sha1_to_hex(sha1));
-
+		die("confused by unstable object source data for %s",
+		    sha1_to_hex(sha1));
+	if (digestp && mdigest_tst(digestp, &digest)) {
+		die("confused by unstable object source data "
+		    "(digest mismatch) for %s", sha1_to_hex(sha1));
+	}
 	close_sha1_file(fd);
-
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
@@ -2510,24 +2774,41 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 				tmpfile, strerror(errno));
 	}
 
-	return move_temp_to_file(tmpfile, filename);
+	ret = move_temp_to_file(tmpfile, filename);
+	if (ret == 0) {
+		mdsdb_open(NULL);
+		mdsdb_process((mdsdb_t)NULL, sha1, &digest);
+		mdsdb_close(NULL);
+	}
+	return ret;
 }
 
-int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+int write_sha1_file_extended(const void *buf, unsigned long len,
+			     const char *type, unsigned char *returnsha1,
+			     mdigest_t *digestp)
 {
 	unsigned char sha1[20];
 	char hdr[32];
 	int hdrlen;
+	mdigest_t newdigest;
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, sha1, &newdigest, hdr, &hdrlen);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
+	if (digestp) *digestp = newdigest;
+	if (has_sha1_file(sha1)) {
+		mdigest_t old_digest;
+		if (has_sha1_file_digest(sha1, &old_digest)) {
+			if (mdigest_tst(&newdigest, &old_digest)) {
+				die("hash collision");
+			}
+		}
 		return 0;
-	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+	}
+	return write_loose_object(sha1, &newdigest, hdr, hdrlen, buf, len, 0);
 }
 
 int force_object_loose(const unsigned char *sha1, time_t mtime)
@@ -2538,6 +2819,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	char hdr[32];
 	int hdrlen;
 	int ret;
+	mdigest_t * const digestp = NULL;
 
 	if (has_loose_object(sha1))
 		return 0;
@@ -2545,7 +2827,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
-	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(sha1, digestp, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
 	return ret;
@@ -2574,6 +2856,85 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_loose_object(sha1);
 }
 
+int has_sha1_file_digest(const unsigned char *sha1, mdigest_t *digestp)
+{
+	struct pack_entry e;
+	/*
+	 * builtin/send-pack.c uses a null SHA1 (all bytes zero) to
+	 * indicate that a SHA-1 hash does not exist.  We explicitly
+	 * return 0 for this case, for correct behavior even if we
+	 * somehow get that value into the database.
+	 */
+	if (!hashcmp(sha1, null_sha1)) return 0;
+	if (find_pack_entry(sha1, &e)) {
+		if (e.has_mdigest) {
+			if (digestp) *digestp = e.mdigest;
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
+				if (has_loose_object_local_digest(sha1,
+							       digestp)) {
+					return 1;
+				} else {
+					int status ;
+					packdb_open();
+					status = (packdb_lookup(sha1,
+								digestp)
+						  == 1);
+					if (status == 0) {
+						unsigned long len;
+						enum object_type type;
+						mdigest_t digest;
+						mdigest_context_t mdc;
+						mdigest_Init(&mdc,
+							     MDIGEST_DEFAULT);
+						void *buf = read_sha1_file
+							(sha1, &type, &len);
+						mdigest_Update(&mdc, buf, len);
+						mdigest_Final(&digest, &mdc);
+						switch(packdb_process
+						       (sha1, &digest)) {
+						case 0:
+							if (digestp)
+								*digestp
+								 = digest;
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
+			return has_loose_object_local_digest(sha1, digestp);
+#endif
+		}
+	}
+	return has_loose_object_digest(sha1, digestp);
+}
+
 static void check_tree(const void *buf, size_t size)
 {
 	struct tree_desc desc;
@@ -2602,7 +2963,8 @@ static void check_tag(const void *buf, size_t size)
 		die("corrupt tag");
 }
 
-static int index_mem(unsigned char *sha1, void *buf, size_t size,
+static int index_mem(unsigned char *sha1, mdigest_t *digestp,
+		     void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
@@ -2631,24 +2993,27 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 		if (type == OBJ_TAG)
 			check_tag(buf, size);
 	}
-
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), sha1);
+		ret = write_sha1_file_extended(buf, size, typename(type), sha1,
+					       digestp);
 	else
-		ret = hash_sha1_file(buf, size, typename(type), sha1);
+		ret = hash_sha1_file_extended(buf, size, typename(type), sha1,
+				     digestp);
 	if (re_allocated)
 		free(buf);
 	return ret;
 }
 
-static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
+static int index_pipe(unsigned char *sha1, mdigest_t *digestp,
+		      int fd, enum object_type type,
 		      const char *path, unsigned flags)
 {
 	struct strbuf sbuf = STRBUF_INIT;
 	int ret;
 
 	if (strbuf_read(&sbuf, fd, 4096) >= 0)
-		ret = index_mem(sha1, sbuf.buf, sbuf.len, type,	path, flags);
+		ret = index_mem(sha1, digestp, sbuf.buf, sbuf.len, type,
+				path, flags);
 	else
 		ret = -1;
 	strbuf_release(&sbuf);
@@ -2657,24 +3022,26 @@ static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
 
 #define SMALL_FILE_SIZE (32*1024)
 
-static int index_core(unsigned char *sha1, int fd, size_t size,
+static int index_core(unsigned char *sha1, mdigest_t *digestp,
+		      int fd, size_t size,
 		      enum object_type type, const char *path,
 		      unsigned flags)
 {
 	int ret;
 
 	if (!size) {
-		ret = index_mem(sha1, NULL, size, type, path, flags);
+		ret = index_mem(sha1, digestp, NULL, size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
-			ret = index_mem(sha1, buf, size, type, path, flags);
+			ret = index_mem(sha1, digestp,
+					buf, size, type, path, flags);
 		else
 			ret = error("short read %s", strerror(errno));
 		free(buf);
 	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(sha1, buf, size, type, path, flags);
+		ret = index_mem(sha1, digestp, buf, size, type, path, flags);
 		munmap(buf, size);
 	}
 	return ret;
@@ -2692,41 +3059,122 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
  * avoid mmaping it in core is to deal with large binary blobs, and
  * by definition they do _not_ want to get any conversion.
  */
-static int index_stream(unsigned char *sha1, int fd, size_t size,
+static int index_stream(unsigned char *sha1, mdigest_t *digestp,
+			int fd, size_t size,
 			enum object_type type, const char *path,
 			unsigned flags)
 {
-	return index_bulk_checkin(sha1, fd, size, type, path, flags);
+#if 1
+	int result = index_bulk_checkin(sha1, fd, size, type, path, flags);
+	if (digestp) {
+		if (result || !has_sha1_file_digest(sha1, digestp)) {
+			mdigest_clear(digestp);
+		}
+	}
+	return result;
+#else
+	struct child_process fast_import;
+	char export_marks[512];
+	const char *argv[] = { "fast-import", "--quiet", export_marks, NULL };
+	char tmpfile[512];
+	char fast_import_cmd[512];
+	char buf[512];
+	int len, tmpfd;
+
+	strcpy(tmpfile, git_path("hashstream_XXXXXX"));
+	tmpfd = git_mkstemp_mode(tmpfile, 0600);
+	if (tmpfd < 0)
+		die_errno("cannot create tempfile: %s", tmpfile);
+	if (close(tmpfd))
+		die_errno("cannot close tempfile: %s", tmpfile);
+	sprintf(export_marks, "--export-marks=%s", tmpfile);
+
+	memset(&fast_import, 0, sizeof(fast_import));
+	fast_import.in = -1;
+	fast_import.argv = argv;
+	fast_import.git_cmd = 1;
+	if (start_command(&fast_import))
+		die_errno("index-stream: git fast-import failed");
+
+	len = sprintf(fast_import_cmd, "blob\nmark :1\ndata %lu\n",
+		      (unsigned long) size);
+	write_or_whine(fast_import.in, fast_import_cmd, len,
+		       "index-stream: feeding fast-import");
+	while (size) {
+		char buf[10240];
+		size_t sz = size < sizeof(buf) ? size : sizeof(buf);
+		ssize_t actual;
+
+		actual = read_in_full(fd, buf, sz);
+		if (actual < 0)
+			die_errno("index-stream: reading input");
+		if (write_in_full(fast_import.in, buf, actual) != actual)
+			die_errno("index-stream: feeding fast-import");
+		size -= actual;
+	}
+	if (close(fast_import.in))
+		die_errno("index-stream: closing fast-import");
+	if (finish_command(&fast_import))
+		die_errno("index-stream: finishing fast-import");
+
+	tmpfd = open(tmpfile, O_RDONLY);
+	if (tmpfd < 0)
+		die_errno("index-stream: cannot open fast-import mark");
+	len = read(tmpfd, buf, sizeof(buf));
+	if (len < 0)
+		die_errno("index-stream: reading fast-import mark");
+	if (close(tmpfd) < 0)
+		die_errno("index-stream: closing fast-import mark");
+	if (unlink(tmpfile))
+		die_errno("index-stream: unlinking fast-import mark");
+	if (len != 44 ||
+	    memcmp(":1 ", buf, 3) ||
+	    get_sha1_hex(buf + 3, sha1))
+		die_errno("index-stream: unexpected fast-import mark: <%s>", buf);
+	/*
+	 * since we got a sha1 value from fast-import, an mds file was
+	 * created, so we can just look up the digest.  Just in case, we
+	 * clear the digest if the lookup failed.
+	 */
+	if (digestp) {
+		if (!has_sha1_file_digest(sha1, digestp)) {
+			mdigest_clear(digestp);
+		}
+	}
+	return 0;
+#endif
 }
 
-int index_fd(unsigned char *sha1, int fd, struct stat *st,
-	     enum object_type type, const char *path, unsigned flags)
+int index_fd_extended(unsigned char *sha1, mdigest_t *digestp,
+		      int fd, struct stat *st,
+		      enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
 	size_t size = xsize_t(st->st_size);
 
 	if (!S_ISREG(st->st_mode))
-		ret = index_pipe(sha1, fd, type, path, flags);
+		ret = index_pipe(sha1, digestp, fd, type, path, flags);
 	else if (size <= big_file_threshold || type != OBJ_BLOB)
-		ret = index_core(sha1, fd, size, type, path, flags);
+		ret = index_core(sha1, digestp, fd, size, type, path, flags);
 	else
-		ret = index_stream(sha1, fd, size, type, path, flags);
+		ret = index_stream(sha1, digestp,
+				   fd, size, type, path, flags);
 	close(fd);
 	return ret;
 }
 
-int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags)
+int index_path_extended(unsigned char *sha1, mdigest_t *digestp, const char *path, struct stat *st, unsigned flags)
 {
 	int fd;
 	struct strbuf sb = STRBUF_INIT;
-
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error("open(\"%s\"): %s", path,
 				     strerror(errno));
-		if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
+		if (index_fd_extended(sha1, digestp, fd, st,
+				      OBJ_BLOB, path, flags) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
@@ -2737,8 +3185,10 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 			             errstr);
 		}
 		if (!(flags & HASH_WRITE_OBJECT))
-			hash_sha1_file(sb.buf, sb.len, blob_type, sha1);
-		else if (write_sha1_file(sb.buf, sb.len, blob_type, sha1))
+			hash_sha1_file_extended(sb.buf, sb.len, blob_type, sha1,
+				       digestp);
+		else if (write_sha1_file_extended(sb.buf, sb.len, blob_type,
+						  sha1, digestp))
 			return error("%s: failed to insert into database",
 				     path);
 		strbuf_release(&sb);
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4e8f43..53e1b7d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -34,17 +34,18 @@ fi
 # git init has been done in an empty repository.
 # make sure it is empty.
 
-find .git/objects -type f -print >should-be-empty
+find .git/objects -type f -a  ! -name mdsd -a ! -name packdb -print >should-be-empty
 test_expect_success \
     '.git/objects should be empty after git init in an empty repo.' \
     'cmp -s /dev/null should-be-empty'
 
-# also it should have 2 subdirectories; no fan-out anymore, pack, and info.
-# 3 is counting "objects" itself
-find .git/objects -type d -print >full-of-directories
+# also it should have 3 subdirectories;
+# no fan-out anymore, pack, and info and mdsd.
+# 4 (listed by find) is the result of counting "objects" as well.
+find .git/objects \( -type d -o -name mdsd  \) -print >full-of-directories
 test_expect_success \
-    '.git/objects should have 3 subdirectories.' \
-    'test $(wc -l < full-of-directories) = 3'
+    '.git/objects should have 3 subdirectories or files.' \
+    'test $(wc -l < full-of-directories) = 4'
 
 ################################################################
 # Test harness
-- 
1.7.1
