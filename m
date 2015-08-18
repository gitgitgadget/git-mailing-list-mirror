From: brilliantov@inbox.ru
Subject: [PATCH] Use symbolic names for setup file access right
Date: Tue, 18 Aug 2015 16:41:24 +0300
Message-ID: <1439905284-31649-1-git-send-email-brilliantov@inbox.ru>
Cc: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 16:14:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRhel-0007Od-2d
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 16:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbbHROOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 10:14:17 -0400
Received: from mail.byterg.ru ([217.12.248.131]:54483 "EHLO mail.byterg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbbHROOP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 10:14:15 -0400
X-Greylist: delayed 2028 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2015 10:14:14 EDT
Received: from [192.168.10.51] (helo=kirill.byterg.ru)
	 by mail.byterg.ru with esmtp  (envelope-from <brilliantov@inbox.ru>)
	 id 1ZRgJF-0001aZ-Ca ; Tue, 18 Aug 2015 16:48:09 +0400
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276125>

From: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>

Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
---
 archive-tar.c        | 15 +++++++++------
 archive-zip.c        |  7 +++++--
 archive.c            |  3 ++-
 builtin/add.c        |  3 ++-
 builtin/am.c         |  8 +++++---
 builtin/apply.c      |  6 ++++--
 builtin/archive.c    |  4 +++-
 builtin/clone.c      |  7 ++++---
 builtin/config.c     |  4 +++-
 builtin/index-pack.c |  7 +++++--
 builtin/init-db.c    |  5 +++--
 builtin/log.c        |  4 +++-
 builtin/mailsplit.c  |  3 ++-
 builtin/merge.c      |  9 +++++----
 builtin/notes.c      |  4 +++-
 builtin/replace.c    |  3 ++-
 builtin/tag.c        |  3 ++-
 builtin/worktree.c   |  3 ++-
 cache.h              |  6 ++++--
 compat/mingw.c       |  4 ++--
 compat/stat.c        | 21 ++++++++++-----------
 config.c             |  9 +++++++--
 copy.c               |  4 +++-
 diff-no-index.c      |  3 ++-
 entry.c              | 12 +++++++-----
 fast-import.c        |  9 +++++----
 file-access.h        | 27 +++++++++++++++++++++++++++
 http.c               |  8 +++++---
 lockfile.c           |  3 ++-
 merge-recursive.c    |  7 ++++---
 notes-merge.c        |  3 ++-
 refs.c               |  7 ++++---
 rerere.c             |  3 ++-
 sequencer.c          |  5 +++--
 server-info.c        |  3 ++-
 setup.c              |  5 +++--
 sha1_file.c          | 13 +++++++------
 test-delta.c         |  3 ++-
 trace.c              |  4 +++-
 wrapper.c            |  3 ++-
 40 files changed, 172 insertions(+), 88 deletions(-)
 create mode 100644 file-access.h

diff --git a/archive-tar.c b/archive-tar.c
index 0d1e6bd..94caa30 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -6,6 +6,7 @@
 #include "archive.h"
 #include "streaming.h"
 #include "run-command.h"
+#include "file-access.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
@@ -167,7 +168,8 @@ static void prepare_header(struct archiver_args *args,
 			   struct ustar_header *header,
 			   unsigned int mode, unsigned long size)
 {
-	sprintf(header->mode, "%07o", mode & 07777);
+	sprintf(header->mode, "%07o",
+		mode & (S_ISUID | S_ISGID | S_ISVTX | DIRECTORY_RW_ALL));
 	sprintf(header->size, "%011lo", S_ISREG(mode) ? size : 0);
 	sprintf(header->mtime, "%011lo", (unsigned long) args->time);
 
@@ -192,7 +194,7 @@ static int write_extended_header(struct archiver_args *args,
 	unsigned int mode;
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_EXT_HEADER;
-	mode = 0100666;
+	mode = S_IFREG | FILE_RW_ALL;
 	sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
 	prepare_header(args, &header, mode, size);
 	write_blocked(&header, sizeof(header));
@@ -216,13 +218,14 @@ static int write_tar_entry(struct archiver_args *args,
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		*header.typeflag = TYPEFLAG_DIR;
-		mode = (mode | 0777) & ~tar_umask;
+		mode = (mode | DIRECTORY_RW_ALL) & ~tar_umask;
 	} else if (S_ISLNK(mode)) {
 		*header.typeflag = TYPEFLAG_LNK;
-		mode |= 0777;
+		mode |= DIRECTORY_RW_ALL;
 	} else if (S_ISREG(mode)) {
 		*header.typeflag = TYPEFLAG_REG;
-		mode = (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
+		mode = (mode | ((mode & S_IXUSR)
+			? DIRECTORY_RW_ALL : FILE_RW_ALL)) & ~tar_umask;
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)",
 			     mode, sha1_to_hex(sha1));
@@ -300,7 +303,7 @@ static int write_global_extended_header(struct archiver_args *args)
 	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
-	mode = 0100666;
+	mode = S_IFREG | FILE_RW_ALL;
 	strcpy(header.name, "pax_global_header");
 	prepare_header(args, &header, mode, ext_header.len);
 	write_blocked(&header, sizeof(header));
diff --git a/archive-zip.c b/archive-zip.c
index ae3d67f..791c002 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -7,6 +7,7 @@
 #include "utf8.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
+#include "file-access.h"
 
 static int zip_date;
 static int zip_time;
@@ -249,8 +250,10 @@ static int write_zip_entry(struct archiver_args *args,
 		enum object_type type = sha1_object_info(sha1, &size);
 
 		method = 0;
-		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
-			(mode & 0111) ? ((mode) << 16) : 0;
+		attr2 = S_ISLNK(mode)
+			? ((mode | DIRECTORY_RW_ALL) << 16)
+			: (mode & (S_IXUSR | S_IXGRP | S_IXOTH))
+				? ((mode) << 16) : 0;
 		if (S_ISREG(mode) && args->compression_level != 0 && size > 0)
 			method = 8;
 
diff --git a/archive.c b/archive.c
index 01b0899..f248b64 100644
--- a/archive.c
+++ b/archive.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "file-access.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -241,7 +242,7 @@ int write_archive_entries(struct archiver_args *args,
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
 		err = write_entry(args, args->tree->object.sha1, args->base,
-				  len, 040777);
+				  len, S_IFDIR | DIRECTORY_RW_ALL);
 		if (err)
 			return err;
 	}
diff --git a/builtin/add.c b/builtin/add.c
index b2a5c57..e76946b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "bulk-checkin.h"
 #include "argv-array.h"
+#include "file-access.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -200,7 +201,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev.diffopt.use_color = 0;
 	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
-	out = open(file, O_CREAT | O_WRONLY, 0666);
+	out = open(file, O_CREAT | O_WRONLY, FILE_RW_ALL);
 	if (out < 0)
 		die(_("Could not open '%s' for writing."), file);
 	rev.diffopt.file = xfdopen(out, "w");
diff --git a/builtin/am.c b/builtin/am.c
index 1399c8d..006f753 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -26,6 +26,7 @@
 #include "notes-utils.h"
 #include "rerere.h"
 #include "prompt.h"
+#include "file-access.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -391,7 +392,7 @@ static void write_commit_msg(const struct am_state *state)
 	int fd;
 	const char *filename = am_path(state, "final-commit");
 
-	fd = xopen(filename, O_WRONLY | O_CREAT, 0666);
+	fd = xopen(filename, O_WRONLY | O_CREAT, FILE_RW_ALL);
 	if (write_in_full(fd, state->msg, state->msg_len) < 0)
 		die_errno(_("could not write to %s"), filename);
 	close(fd);
@@ -983,7 +984,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		exit(128);
 	}
 
-	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
+	if (mkdir(state->dir, DIRECTORY_RW_ALL) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
 
 	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
@@ -1207,7 +1208,8 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	cp.git_cmd = 1;
 	cp.in = xopen(mail, O_RDONLY, 0);
-	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT, 0777);
+	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT,
+			DIRECTORY_RW_ALL);
 
 	argv_array_push(&cp.args, "mailinfo");
 	argv_array_push(&cp.args, state->utf8 ? "-u" : "-n");
diff --git a/builtin/apply.c b/builtin/apply.c
index 54aba4e..db8e572 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -20,6 +20,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "rerere.h"
+#include "file-access.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -4102,7 +4103,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 		struct stat st;
 		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
 			return 0;
-		return mkdir(path, 0777);
+		return mkdir(path, DIRECTORY_RW_ALL);
 	}
 
 	if (has_symlinks && S_ISLNK(mode))
@@ -4111,7 +4112,8 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 		 */
 		return symlink(buf, path);
 
-	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
+	fd = open(path, O_CREAT | O_EXCL | O_WRONLY,
+			(mode & S_IXUSR) ? DIRECTORY_RW_ALL : FILE_RW_ALL);
 	if (fd < 0)
 		return -1;
 
diff --git a/builtin/archive.c b/builtin/archive.c
index a1e3b94..2f4109a 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -9,10 +9,12 @@
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "file-access.h"
 
 static void create_output_file(const char *output_file)
 {
-	int output_fd = open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+	int output_fd = open(output_file, O_CREAT | O_WRONLY | O_TRUNC,
+				FILE_RW_ALL);
 	if (output_fd < 0)
 		die_errno(_("could not create archive file '%s'"), output_file);
 	if (output_fd != 1) {
diff --git a/builtin/clone.c b/builtin/clone.c
index 303a3a7..681fa71 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -24,6 +24,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
+#include "file-access.h"
 
 /*
  * Overall FIXMEs:
@@ -305,7 +306,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	if (!dir)
 		die_errno(_("failed to open '%s'"), src->buf);
 
-	if (mkdir(dest->buf, 0777)) {
+	if (mkdir(dest->buf, DIRECTORY_RW_ALL)) {
 		if (errno != EEXIST)
 			die_errno(_("failed to create directory '%s'"), dest->buf);
 		else if (stat(dest->buf, &buf))
@@ -350,7 +351,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				die_errno(_("failed to create link '%s'"), dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file_with_time(dest->buf, src->buf, 0666))
+		if (copy_file_with_time(dest->buf, src->buf, FILE_RW_ALL))
 			die_errno(_("failed to copy file to '%s'"), dest->buf);
 	}
 	closedir(dir);
@@ -844,7 +845,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (safe_create_leading_directories_const(work_tree) < 0)
 			die_errno(_("could not create leading directories of '%s'"),
 				  work_tree);
-		if (!dest_exists && mkdir(work_tree, 0777))
+		if (!dest_exists && mkdir(work_tree, DIRECTORY_RW_ALL))
 			die_errno(_("could not create work tree dir '%s'"),
 				  work_tree);
 		junk_work_tree = work_tree;
diff --git a/builtin/config.c b/builtin/config.c
index 7188405..e918bdf 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -3,6 +3,7 @@
 #include "color.h"
 #include "parse-options.h"
 #include "urlmatch.h"
+#include "file-access.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
@@ -576,7 +577,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_file = xstrdup(given_config_source.file ?
 				      given_config_source.file : git_path("config"));
 		if (use_global_config) {
-			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
+			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY,
+					FILE_RW_ALL);
 			if (fd) {
 				char *content = default_user_config();
 				write_str_in_full(fd, content);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3f10840..833b39d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,6 +11,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "file-access.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -308,7 +309,8 @@ static const char *open_pack_file(const char *pack_name)
 						"pack/tmp_pack_XXXXXX");
 			pack_name = xstrdup(tmp_file);
 		} else
-			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
+			output_fd = open(pack_name, O_CREAT | O_EXCL | O_RDWR,
+					FILE_RW_USER);
 		if (output_fd < 0)
 			die_errno(_("unable to create '%s'"), pack_name);
 		nothread_data.pack_fd = output_fd;
@@ -1397,7 +1399,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (!keep_name)
 			keep_fd = odb_pack_keep(name, sizeof(name), sha1);
 		else
-			keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+			keep_fd = open(keep_name, O_RDWR | O_CREAT | O_EXCL,
+					FILE_RW_USER);
 
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 49df78d..e3e5c35 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "file-access.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -26,7 +27,7 @@ static const char *git_link;
 
 static void safe_create_dir(const char *dir, int share)
 {
-	if (mkdir(dir, 0777) < 0) {
+	if (mkdir(dir, DIRECTORY_RW_ALL) < 0) {
 		if (errno != EEXIST) {
 			perror(dir);
 			exit(1);
@@ -542,7 +543,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 					break;
 				}
 				shared_repository = saved;
-				if (mkdir(argv[0], 0777) < 0)
+				if (mkdir(argv[0], DIRECTORY_RW_ALL) < 0)
 					die_errno(_("cannot mkdir %s"), argv[0]);
 				mkdir_tried = 1;
 				goto retry;
diff --git a/builtin/log.c b/builtin/log.c
index b50ef75..832343d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -26,6 +26,7 @@
 #include "version.h"
 #include "mailmap.h"
 #include "gpg-interface.h"
+#include "file-access.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -1387,7 +1388,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (output_directory) {
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
-		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
+		if (mkdir(output_directory, DIRECTORY_RW_ALL) < 0 &&
+			errno != EEXIST)
 			die_errno(_("Could not create directory '%s'"),
 				  output_directory);
 	}
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 8e02ea1..3818860 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "string-list.h"
 #include "strbuf.h"
+#include "file-access.h"
 
 static const char git_mailsplit_usage[] =
 "git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
@@ -62,7 +63,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 		fprintf(stderr, "corrupt mailbox\n");
 		exit(1);
 	}
-	fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	fd = open(name, O_WRONLY | O_CREAT | O_EXCL, FILE_RW_ALL);
 	if (fd < 0)
 		die_errno("cannot open output file '%s'", name);
 	output = xfdopen(fd, "w");
diff --git a/builtin/merge.c b/builtin/merge.c
index 85c54dc..1a3a28e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -30,6 +30,7 @@
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
 #include "sequencer.h"
+#include "file-access.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -339,7 +340,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 
 	printf(_("Squash commit -- not updating HEAD\n"));
 	filename = git_path("SQUASH_MSG");
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
+	fd = open(filename, O_WRONLY | O_CREAT, FILE_RW_ALL);
 	if (fd < 0)
 		die_errno(_("Could not write to '%s'"), filename);
 
@@ -755,7 +756,7 @@ static void add_strategies(const char *string, unsigned attr)
 static void write_merge_msg(struct strbuf *msg)
 {
 	const char *filename = git_path("MERGE_MSG");
-	int fd = open(filename, O_WRONLY | O_CREAT, 0666);
+	int fd = open(filename, O_WRONLY | O_CREAT, FILE_RW_ALL);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"),
 			  filename);
@@ -968,7 +969,7 @@ static void write_merge_state(struct commit_list *remoteheads)
 		strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
 	}
 	filename = git_path("MERGE_HEAD");
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
+	fd = open(filename, O_WRONLY | O_CREAT, FILE_RW_ALL);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
@@ -978,7 +979,7 @@ static void write_merge_state(struct commit_list *remoteheads)
 	write_merge_msg(&merge_msg);
 
 	filename = git_path("MERGE_MODE");
-	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, FILE_RW_ALL);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
 	strbuf_reset(&buf);
diff --git a/builtin/notes.c b/builtin/notes.c
index 63f95fc..3119336 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -19,6 +19,7 @@
 #include "string-list.h"
 #include "notes-merge.h"
 #include "notes-utils.h"
+#include "file-access.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
@@ -168,7 +169,8 @@ static void prepare_note_data(const unsigned char *object, struct note_data *d,
 
 		/* write the template message before editing: */
 		d->edit_path = git_pathdup("NOTES_EDITMSG");
-		fd = open(d->edit_path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		fd = open(d->edit_path, O_CREAT | O_TRUNC | O_WRONLY,
+				FILE_RW_USER);
 		if (fd < 0)
 			die_errno(_("could not create file '%s'"), d->edit_path);
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 6b3c469..70fe7b9 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -14,6 +14,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "tag.h"
+#include "file-access.h"
 
 static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
@@ -203,7 +204,7 @@ static void export_object(const unsigned char *sha1, enum object_type type,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int fd;
 
-	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, FILE_RW_ALL);
 	if (fd < 0)
 		die_errno("unable to open %s for writing", filename);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index cccca99..c489ad1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -17,6 +17,7 @@
 #include "gpg-interface.h"
 #include "sha1-array.h"
 #include "column.h"
+#include "file-access.h"
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
@@ -472,7 +473,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 		/* write the template message before editing: */
 		path = git_pathdup("TAG_EDITMSG");
-		fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, FILE_RW_USER);
 		if (fd < 0)
 			die_errno(_("could not create file '%s'"), path);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 430b51e..c53d837 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -8,6 +8,7 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "refs.h"
+#include "file-access.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> <branch>"),
@@ -228,7 +229,7 @@ static int add_worktree(const char *path, const char *refname,
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
-	if (mkdir(sb_repo.buf, 0777))
+	if (mkdir(sb_repo.buf, DIRECTORY_RW_ALL))
 		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
 	junk_git_dir = xstrdup(sb_repo.buf);
 	is_junk = 1;
diff --git a/cache.h b/cache.h
index 6bb7119..99e88e1 100644
--- a/cache.h
+++ b/cache.h
@@ -9,6 +9,7 @@
 #include "convert.h"
 #include "trace.h"
 #include "string-list.h"
+#include "file-access.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -242,7 +243,8 @@ static inline unsigned create_ce_flags(unsigned stage)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
 
-#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
+#define ce_permissions(mode) \
+	(((mode) & S_IXUSR) ? DIRECTORY_RW_USER_R_ALL : FILE_RW_USER_R_ALL)
 static inline unsigned int create_ce_mode(unsigned int mode)
 {
 	if (S_ISLNK(mode))
@@ -261,7 +263,7 @@ static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
 	if (!trust_executable_bit && S_ISREG(mode)) {
 		if (ce && S_ISREG(ce->ce_mode))
 			return ce->ce_mode;
-		return create_ce_mode(0666);
+		return create_ce_mode(FILE_RW_ALL);
 	}
 	return create_ce_mode(mode);
 }
diff --git a/compat/mingw.c b/compat/mingw.c
index 496e6f8..55e2aef 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -208,7 +208,7 @@ int mingw_unlink(const char *pathname)
 		return -1;
 
 	/* read-only files cannot be removed */
-	_wchmod(wpathname, 0666);
+	_wchmod(wpathname, FILE_RW_ALL);
 	while ((ret = _wunlink(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
 		if (!is_file_in_use_error(GetLastError()))
 			break;
@@ -650,7 +650,7 @@ int mkstemp(char *template)
 	char *filename = mktemp(template);
 	if (filename == NULL)
 		return -1;
-	return open(filename, O_RDWR | O_CREAT, 0600);
+	return open(filename, O_RDWR | O_CREAT, FILE_RW_USER);
 }
 
 int gettimeofday(struct timeval *tv, void *tz)
diff --git a/compat/stat.c b/compat/stat.c
index a2d3931..f040b25 100644
--- a/compat/stat.c
+++ b/compat/stat.c
@@ -1,24 +1,23 @@
-#define _POSIX_C_SOURCE 200112L
-#include <sys/stat.h>  /* *stat, S_IS* */
-#include <sys/types.h> /* mode_t       */
+#include "../file-access.h"
 
 static inline mode_t mode_native_to_git(mode_t native_mode)
 {
-	mode_t perm_bits = native_mode & 07777;
+	mode_t perm_bits =
+		native_mode & (S_ISUID | S_ISGID | S_ISVTX | DIRECTORY_RW_ALL);
 	if (S_ISREG(native_mode))
-		return 0100000 | perm_bits;
+		return S_IFREG | perm_bits;
 	if (S_ISDIR(native_mode))
-		return 0040000 | perm_bits;
+		return S_IFDIR | perm_bits;
 	if (S_ISLNK(native_mode))
-		return 0120000 | perm_bits;
+		return S_IFLNK | perm_bits;
 	if (S_ISBLK(native_mode))
-		return 0060000 | perm_bits;
+		return S_IFBLK | perm_bits;
 	if (S_ISCHR(native_mode))
-		return 0020000 | perm_bits;
+		return S_IFCHR | perm_bits;
 	if (S_ISFIFO(native_mode))
-		return 0010000 | perm_bits;
+		return S_IFIFO | perm_bits;
 	if (S_ISSOCK(native_mode))
-		return 0140000 | perm_bits;
+		return S_IFSOCK | perm_bits;
 	/* Non-standard type bits were given. */
 	return perm_bits;
 }
diff --git a/config.c b/config.c
index 9fd275f..1f01eb5 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "file-access.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -2066,7 +2067,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		}
 		close(in_fd);
 
-		if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
+		if (chmod(lock->filename.buf,
+			st.st_mode &
+			(S_ISUID | S_ISGID | S_ISVTX | DIRECTORY_RW_ALL)) < 0) {
 			error("chmod on %s failed: %s",
 				lock->filename.buf, strerror(errno));
 			ret = CONFIG_NO_WRITE;
@@ -2252,7 +2255,9 @@ int git_config_rename_section_in_file(const char *config_filename,
 
 	fstat(fileno(config_file), &st);
 
-	if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
+	if (chmod(lock->filename.buf,
+		st.st_mode &
+		(S_ISUID | S_ISGID | S_ISVTX | DIRECTORY_RW_ALL)) < 0) {
 		ret = error("chmod on %s failed: %s",
 				lock->filename.buf, strerror(errno));
 		goto out;
diff --git a/copy.c b/copy.c
index 574fa1f..c2116b9 100644
--- a/copy.c
+++ b/copy.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "file-access.h"
 
 int copy_fd(int ifd, int ofd)
 {
@@ -32,7 +33,8 @@ int copy_file(const char *dst, const char *src, int mode)
 {
 	int fdi, fdo, status;
 
-	mode = (mode & 0111) ? 0777 : 0666;
+	mode = (mode & (S_IXUSR | S_IXGRP | S_IXOTH))
+		? DIRECTORY_RW_ALL : FILE_RW_ALL;
 	if ((fdi = open(src, O_RDONLY)) < 0)
 		return fdi;
 	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
diff --git a/diff-no-index.c b/diff-no-index.c
index 0320605..0f30018 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,6 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
 #include "dir.h"
+#include "file-access.h"
 
 static int read_directory_contents(const char *path, struct string_list *list)
 {
@@ -51,7 +52,7 @@ static int get_mode(const char *path, int *mode)
 		*mode = 0;
 #endif
 	else if (path == file_from_standard_input)
-		*mode = create_ce_mode(0666);
+		*mode = create_ce_mode(FILE_RW_ALL);
 	else if (lstat(path, &st))
 		return error("Could not access '%s'", path);
 	else
diff --git a/entry.c b/entry.c
index 1eda8e9..f8359f1 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "file-access.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -34,9 +35,10 @@ static void create_directories(const char *path, int path_len,
 		 * there, therefore we then try to unlink it and try
 		 * one more time to create the directory.
 		 */
-		if (mkdir(buf, 0777)) {
+		if (mkdir(buf, DIRECTORY_RW_ALL)) {
 			if (errno == EEXIST && state->force &&
-			    !unlink_or_warn(buf) && !mkdir(buf, 0777))
+			    !unlink_or_warn(buf) &&
+			    !mkdir(buf, DIRECTORY_RW_ALL))
 				continue;
 			die_errno("cannot create directory at '%s'", buf);
 		}
@@ -75,7 +77,7 @@ static void remove_subtree(struct strbuf *path)
 
 static int create_file(const char *path, unsigned int mode)
 {
-	mode = (mode & 0100) ? 0777 : 0666;
+	mode = (mode & S_IXUSR) ? DIRECTORY_RW_ALL : FILE_RW_ALL;
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
@@ -100,7 +102,7 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
 		       ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
 		return mkstemp(path);
 	} else {
-		return create_file(path, !symlink ? ce->ce_mode : 0666);
+		return create_file(path, !symlink ? ce->ce_mode : FILE_RW_ALL);
 	}
 }
 
@@ -201,7 +203,7 @@ static int write_entry(struct cache_entry *ce,
 	case S_IFGITLINK:
 		if (to_tempfile)
 			return error("cannot create temporary submodule %s", path);
-		if (mkdir(path, 0777) < 0)
+		if (mkdir(path, DIRECTORY_RW_ALL) < 0)
 			return error("cannot create submodule directory %s", path);
 		break;
 	default:
diff --git a/fast-import.c b/fast-import.c
index 2ad4fee..b082b46 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -166,6 +166,7 @@ Format of STDIN stream:
 #include "quote.h"
 #include "exec_cmd.h"
 #include "dir.h"
+#include "file-access.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2303,11 +2304,11 @@ static void file_change_m(const char *p, struct branch *b)
 	if (!p)
 		die("Corrupt mode: %s", command_buf.buf);
 	switch (mode) {
-	case 0644:
-	case 0755:
+	case FILE_RW_USER_R_ALL:
+	case DIRECTORY_RW_USER_R_ALL:
 		mode |= S_IFREG;
-	case S_IFREG | 0644:
-	case S_IFREG | 0755:
+	case S_IFREG | FILE_RW_USER_R_ALL:
+	case S_IFREG | DIRECTORY_RW_USER_R_ALL:
 	case S_IFLNK:
 	case S_IFDIR:
 	case S_IFGITLINK:
diff --git a/file-access.h b/file-access.h
new file mode 100644
index 0000000..ef5585e
--- /dev/null
+++ b/file-access.h
@@ -0,0 +1,27 @@
+#ifndef FILE_ACCESS_H
+#define FILE_ACCESS_H
+
+#include <sys/stat.h>
+
+/* rwxr-xr-x (0755) */
+#define DIRECTORY_RW_USER_R_ALL \
+	(S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH)
+
+/* rwxrwxrwx (0777) */
+#define DIRECTORY_RW_ALL (S_IRWXU | S_IRWXG | S_IRWXO)
+
+/* rw------- (0600) */
+#define FILE_RW_USER (S_IRUSR | S_IWUSR)
+
+/* rw-r--r-- (0644) */
+#define FILE_RW_USER_R_ALL (FILE_RW_USER | S_IRGRP | S_IROTH)
+
+/* r--r--r-- (0444) */
+#define FILE_R_ALL (S_IRUSR | S_IRGRP | S_IROTH)
+
+/* rw-rw-rw- (0666) */
+#define FILE_RW_ALL (FILE_RW_USER | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH)
+
+#endif /* FILE_ACCESS_H */
+
+/* vim: set ts=8 sw=8 noet */
diff --git a/http.c b/http.c
index e9c6fdd..ef0dc2b 100644
--- a/http.c
+++ b/http.c
@@ -9,6 +9,7 @@
 #include "version.h"
 #include "pkt-line.h"
 #include "gettext.h"
+#include "file-access.h"
 
 int active_requests;
 int http_is_verbose;
@@ -1643,7 +1644,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	if (freq->localfile != -1)
 		error("fd leakage in start: %d", freq->localfile);
 	freq->localfile = open(freq->tmpfile,
-			       O_WRONLY | O_CREAT | O_EXCL, 0666);
+			       O_WRONLY | O_CREAT | O_EXCL, FILE_RW_ALL);
 	/*
 	 * This could have failed due to the "lazy directory creation";
 	 * try to mkdir the last path component.
@@ -1652,11 +1653,12 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		char *dir = strrchr(freq->tmpfile, '/');
 		if (dir) {
 			*dir = 0;
-			mkdir(freq->tmpfile, 0777);
+			mkdir(freq->tmpfile, DIRECTORY_RW_ALL);
 			*dir = '/';
 		}
 		freq->localfile = open(freq->tmpfile,
-				       O_WRONLY | O_CREAT | O_EXCL, 0666);
+					O_WRONLY | O_CREAT | O_EXCL,
+					FILE_RW_ALL);
 	}
 
 	if (freq->localfile < 0) {
diff --git a/lockfile.c b/lockfile.c
index 993bb82..5abd046 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "lockfile.h"
 #include "sigchain.h"
+#include "file-access.h"
 
 static struct lock_file *volatile lock_file_list;
 
@@ -140,7 +141,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	}
 
 	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
-	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, FILE_RW_ALL);
 	if (lk->fd < 0) {
 		strbuf_reset(&lk->filename);
 		return -1;
diff --git a/merge-recursive.c b/merge-recursive.c
index 44d85be..60e355e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -22,6 +22,7 @@
 #include "merge-recursive.h"
 #include "dir.h"
 #include "submodule.h"
+#include "file-access.h"
 
 static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 				      const char *subtree_shift)
@@ -779,10 +780,10 @@ static void update_file_flags(struct merge_options *o,
 		}
 		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
-			if (mode & 0100)
-				mode = 0777;
+			if (mode & S_IXUSR)
+				mode = DIRECTORY_RW_ALL;
 			else
-				mode = 0666;
+				mode = FILE_RW_ALL;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0)
 				die_errno(_("failed to open '%s'"), path);
diff --git a/notes-merge.c b/notes-merge.c
index 0b2b82c..014d14c 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -10,6 +10,7 @@
 #include "notes-merge.h"
 #include "strbuf.h"
 #include "notes-utils.h"
+#include "file-access.h"
 
 struct notes_merge_pair {
 	unsigned char obj[20], base[20], local[20], remote[20];
@@ -301,7 +302,7 @@ static void write_buf_to_worktree(const unsigned char *obj,
 	if (file_exists(path))
 		die("found existing file at '%s'", path);
 
-	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, 0666);
+	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, FILE_RW_ALL);
 	if (fd < 0)
 		die_errno("failed to open '%s'", path);
 
diff --git a/refs.c b/refs.c
index 2db2975..294d521 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #include "tag.h"
 #include "dir.h"
 #include "string-list.h"
+#include "file-access.h"
 
 struct ref_lock {
 	char *ref_name;
@@ -3163,7 +3164,7 @@ static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct
 		oflags |= O_CREAT;
 	}
 
-	logfd = open(logfile, oflags, 0666);
+	logfd = open(logfile, oflags, FILE_RW_ALL);
 	if (logfd < 0) {
 		if (!(oflags & O_CREAT) && (errno == ENOENT || errno == EISDIR))
 			return 0;
@@ -3174,7 +3175,7 @@ static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct
 					    "'%s'", logfile);
 				return -1;
 			}
-			logfd = open(logfile, oflags, 0666);
+			logfd = open(logfile, oflags, FILE_RW_ALL);
 		}
 
 		if (logfd < 0) {
@@ -3406,7 +3407,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 		goto error_free_return;
 	}
 	lockpath = mkpath("%s.lock", git_HEAD);
-	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, FILE_RW_ALL);
 	if (fd < 0) {
 		error("Unable to open %s for writing", lockpath);
 		goto error_free_return;
diff --git a/rerere.c b/rerere.c
index 94aea9a..af225c0 100644
--- a/rerere.c
+++ b/rerere.c
@@ -8,6 +8,7 @@
 #include "ll-merge.h"
 #include "attr.h"
 #include "pathspec.h"
+#include "file-access.h"
 
 #define RESOLVED 0
 #define PUNTED 1
@@ -559,7 +560,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 			continue;
 
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-		copy_file(rerere_path(name, "postimage"), path, 0666);
+		copy_file(rerere_path(name, "postimage"), path, FILE_RW_ALL);
 	mark_resolved:
 		rr->items[i].util = NULL;
 	}
diff --git a/sequencer.c b/sequencer.c
index c4f4b7d..375c032 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -15,6 +15,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "file-access.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -167,7 +168,7 @@ static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
 
 	filename = git_path("%s", pseudoref);
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
+	fd = open(filename, O_WRONLY | O_CREAT, FILE_RW_ALL);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
@@ -843,7 +844,7 @@ static int create_seq_dir(void)
 		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
 		return -1;
 	}
-	else if (mkdir(seq_dir, 0777) < 0)
+	else if (mkdir(seq_dir, DIRECTORY_RW_ALL) < 0)
 		die_errno(_("Could not create sequencer directory %s"), seq_dir);
 	return 0;
 }
diff --git a/server-info.c b/server-info.c
index c82e9ee..86d13bf 100644
--- a/server-info.c
+++ b/server-info.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
+#include "file-access.h"
 
 /*
  * Create the file "path" by writing to a temporary file and renaming
@@ -17,7 +18,7 @@ static int update_info_file(char *path, int (*generate)(FILE *))
 	FILE *fp = NULL;
 
 	safe_create_leading_directories(path);
-	fd = git_mkstemp_mode(tmp, 0666);
+	fd = git_mkstemp_mode(tmp, FILE_RW_ALL);
 	if (fd < 0)
 		goto out;
 	fp = fdopen(fd, "w");
diff --git a/setup.c b/setup.c
index 5f9f07d..ac1c6ea 100644
--- a/setup.c
+++ b/setup.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "string-list.h"
+#include "file-access.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -915,7 +916,7 @@ int git_config_perm(const char *var, const char *value)
 
 	/* A filemode value was given: 0xxx */
 
-	if ((i & 0600) != 0600)
+	if ((i & FILE_RW_USER) != FILE_RW_USER)
 		die("Problem with core.sharedRepository filemode value "
 		    "(0%.3o).\nThe owner of files must always have "
 		    "read and write permissions.", i);
@@ -924,7 +925,7 @@ int git_config_perm(const char *var, const char *value)
 	 * Mask filemode value. Others can not get write permission.
 	 * x flags for directories are handled separately.
 	 */
-	return -(i & 0666);
+	return -(i & FILE_RW_ALL);
 }
 
 int check_repository_format_version(const char *var, const char *value, void *cb)
diff --git a/sha1_file.c b/sha1_file.c
index 1cee438..db4052d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,7 @@
 #include "bulk-checkin.h"
 #include "streaming.h"
 #include "dir.h"
+#include "file-access.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -82,7 +83,7 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 
 int mkdir_in_gitdir(const char *path)
 {
-	if (mkdir(path, 0777)) {
+	if (mkdir(path, DIRECTORY_RW_ALL)) {
 		int saved_errno = errno;
 		struct stat st;
 		struct strbuf sb = STRBUF_INIT;
@@ -99,7 +100,7 @@ int mkdir_in_gitdir(const char *path)
 		if (lstat(path, &st) || !S_ISLNK(st.st_mode) ||
 		    strbuf_readlink(&sb, path, st.st_size) ||
 		    !is_absolute_path(sb.buf) ||
-		    mkdir(sb.buf, 0777)) {
+		    mkdir(sb.buf, DIRECTORY_RW_ALL)) {
 			strbuf_release(&sb);
 			errno = saved_errno;
 			return -1;
@@ -136,7 +137,7 @@ enum scld_error safe_create_leading_directories(char *path)
 			/* path exists */
 			if (!S_ISDIR(st.st_mode))
 				ret = SCLD_EXISTS;
-		} else if (mkdir(path, 0777)) {
+		} else if (mkdir(path, DIRECTORY_RW_ALL)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
 				; /* somebody created it since we checked */
@@ -3003,19 +3004,19 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 	}
 	memcpy(buffer, filename, dirlen);
 	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
-	fd = git_mkstemp_mode(buffer, 0444);
+	fd = git_mkstemp_mode(buffer, FILE_R_ALL);
 	if (fd < 0 && dirlen && errno == ENOENT) {
 		/* Make sure the directory exists */
 		memcpy(buffer, filename, dirlen);
 		buffer[dirlen-1] = 0;
-		if (mkdir(buffer, 0777) && errno != EEXIST)
+		if (mkdir(buffer, DIRECTORY_RW_ALL) && errno != EEXIST)
 			return -1;
 		if (adjust_shared_perm(buffer))
 			return -1;
 
 		/* Try again */
 		strcpy(buffer + dirlen - 1, "/tmp_obj_XXXXXX");
-		fd = git_mkstemp_mode(buffer, 0444);
+		fd = git_mkstemp_mode(buffer, FILE_R_ALL);
 	}
 	return fd;
 }
diff --git a/test-delta.c b/test-delta.c
index 4595cd6..faf1d67 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -11,6 +11,7 @@
 #include "git-compat-util.h"
 #include "delta.h"
 #include "cache.h"
+#include "file-access.h"
 
 static const char usage_str[] =
 	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
@@ -68,7 +69,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
+	fd = open (argv[4], O_WRONLY | O_CREAT | O_TRUNC, FILE_RW_ALL);
 	if (fd < 0 || write_in_full(fd, out_buf, out_size) != out_size) {
 		perror(argv[4]);
 		return 1;
diff --git a/trace.c b/trace.c
index 7393926..da312a5 100644
--- a/trace.c
+++ b/trace.c
@@ -24,6 +24,7 @@
 
 #include "cache.h"
 #include "quote.h"
+#include "file-access.h"
 
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
@@ -49,7 +50,8 @@ static int get_trace_fd(struct trace_key *key)
 	else if (strlen(trace) == 1 && isdigit(*trace))
 		key->fd = atoi(trace);
 	else if (is_absolute_path(trace)) {
-		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
+		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT,
+				FILE_RW_ALL);
 		if (fd == -1) {
 			fprintf(stderr,
 				"Could not open '%s' for tracing: %s\n"
diff --git a/wrapper.c b/wrapper.c
index e451463..33c394b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -2,6 +2,7 @@
  * Various trivial helper wrappers around standard functions
  */
 #include "cache.h"
+#include "file-access.h"
 
 static void do_nothing(size_t size)
 {
@@ -625,7 +626,7 @@ int write_file(const char *path, int fatal, const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
 	va_list params;
-	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, FILE_RW_ALL);
 	if (fd < 0) {
 		if (fatal)
 			die_errno(_("could not open %s for writing"), path);
-- 
2.1.4
