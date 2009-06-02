From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] add strerror(errno) to die() calls where applicable
Date: Tue,  2 Jun 2009 23:34:33 +0200
Message-ID: <8df45fb3586160fa5c47af39d2a7eb2b8d405a3c.1243978065.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 23:34:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBbdG-0000q6-LU
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 23:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZFBVeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbZFBVeg
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 17:34:36 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:1302 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbZFBVee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 17:34:34 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Jun 2009 23:34:22 +0200
Received: from localhost.localdomain ([84.75.150.195]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Jun 2009 23:34:34 +0200
X-Mailer: git-send-email 1.6.3.1.325.g02d91
X-OriginalArrivalTime: 02 Jun 2009 21:34:34.0993 (UTC) FILETIME=[EC589610:01C9E3C9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120549>

Lots of die() calls did not actually report the kind of error, which
can leave the user confused as to the real problem.  Add a
strerror(errno) where the die() is immediately preceded by a
system/library call that sets errno on failure, or by one of the
following that wrap such calls:

  odb_pack_keep
  read_ancestry
  read_in_full
  strbuf_read
  strbuf_read_file
  strbuf_readlink
  write_buffer
  write_in_full

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 abspath.c               |   17 +++++++++++------
 builtin-add.c           |    2 +-
 builtin-apply.c         |    8 ++++----
 builtin-archive.c       |    5 +++--
 builtin-blame.c         |   16 ++++++++++------
 builtin-clone.c         |   16 ++++++++++------
 builtin-commit.c        |   15 +++++++++------
 builtin-fast-export.c   |    5 +++--
 builtin-fmt-merge-msg.c |    2 +-
 builtin-fsck.c          |    7 ++++---
 builtin-init-db.c       |   27 +++++++++++++++++----------
 builtin-log.c           |    4 ++--
 builtin-mailsplit.c     |    7 ++++---
 builtin-merge.c         |   25 ++++++++++++++++---------
 builtin-rev-parse.c     |    3 ++-
 builtin-revert.c        |    2 +-
 builtin-stripspace.c    |    2 +-
 builtin-tag.c           |    3 ++-
 builtin-tar-tree.c      |    2 +-
 combine-diff.c          |    3 ++-
 diff.c                  |    6 +++---
 entry.c                 |    3 ++-
 fast-import.c           |    4 ++--
 hash-object.c           |    2 +-
 ll-merge.c              |    2 +-
 mktag.c                 |    2 +-
 read-cache.c            |    2 +-
 setup.c                 |   15 ++++++++++-----
 sha1_file.c             |    2 +-
 transport.c             |    6 ++++--
 unpack-file.c           |    2 +-
 31 files changed, 131 insertions(+), 86 deletions(-)

diff --git a/abspath.c b/abspath.c
index 649f34f..7fff78f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -41,13 +41,16 @@ int is_directory(const char *path)
 
 		if (*buf) {
 			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
-				die ("Could not get current working directory");
+				die ("Could not get current working directory: %s",
+				     strerror(errno));
 
 			if (chdir(buf))
-				die ("Could not switch to '%s'", buf);
+				die ("Could not switch to '%s': %s", buf,
+				     strerror(errno));
 		}
 		if (!getcwd(buf, PATH_MAX))
-			die ("Could not get current working directory");
+			die ("Could not get current working directory: %s",
+			     strerror(errno));
 
 		if (last_elem) {
 			int len = strlen(buf);
@@ -63,7 +66,8 @@ int is_directory(const char *path)
 		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
 			len = readlink(buf, next_buf, PATH_MAX);
 			if (len < 0)
-				die ("Invalid symlink: %s", buf);
+				die ("Invalid symlink '%s': %s", buf,
+				     strerror(errno));
 			if (PATH_MAX <= len)
 				die("symbolic link too long: %s", buf);
 			next_buf[len] = '\0';
@@ -75,7 +79,7 @@ int is_directory(const char *path)
 	}
 
 	if (*cwd && chdir(cwd))
-		die ("Could not change back to '%s'", cwd);
+		die ("Could not change back to '%s': %s", cwd, strerror(errno));
 
 	return buf;
 }
@@ -109,7 +113,8 @@ int is_directory(const char *path)
 	} else {
 		const char *cwd = get_pwd_cwd();
 		if (!cwd)
-			die("Cannot determine the current working directory");
+			die("Cannot determine the current working directory",
+			    strerror(errno));
 		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path) >= PATH_MAX)
 			die("Too long path: %.*s", 60, path);
 	}
diff --git a/builtin-add.c b/builtin-add.c
index c1b229a..88c6672 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -220,7 +220,7 @@ int edit_patch(int argc, const char **argv, const char *prefix)
 	launch_editor(file, NULL, NULL);
 
 	if (stat(file, &st))
-		die("Could not stat '%s'", file);
+		die("Could not stat '%s': %s", file, strerror(errno));
 	if (!st.st_size)
 		die("Empty patch. Aborted.");
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 94ba2bd..1ea5113 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2823,8 +2823,8 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned 
 	} else {
 		if (!cached) {
 			if (lstat(path, &st) < 0)
-				die("unable to stat newly created file %s",
-				    path);
+				die("unable to stat newly created file '%s': %s",
+				    path, strerror(errno));
 			fill_stat_cache_info(ce, &st);
 		}
 		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
@@ -2864,7 +2864,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0)
-		die("closing file %s: %s", path, strerror(errno));
+		die("closing file '%s': %s", path, strerror(errno));
 	return 0;
 }
 
@@ -2913,7 +2913,7 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 			++nr;
 		}
 	}
-	die("unable to write file %s mode %o", path, mode);
+	die("unable to write file '%s' mode %o: %s", path, mode, strerror(errno));
 }
 
 static void create_file(struct patch *patch)
diff --git a/builtin-archive.c b/builtin-archive.c
index 3c5a5a7..10877ef 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -13,10 +13,11 @@ static void create_output_file(const char *output_file)
 {
 	int output_fd = open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	if (output_fd < 0)
-		die("could not create archive file: %s ", output_file);
+		die("could not create archive file '%s': %s", output_file,
+		    strerror(errno));
 	if (output_fd != 1) {
 		if (dup2(output_fd, 1) < 0)
-			die("could not redirect output");
+			die("could not redirect output: %s", strerror(errno));
 		else
 			close(output_fd);
 	}
diff --git a/builtin-blame.c b/builtin-blame.c
index 9dc3335..e5b465e 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1998,23 +1998,27 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 
 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
-				die("Cannot stat %s", contents_from);
+				die("Cannot stat '%s': %s", contents_from,
+				    strerror(errno));
 			read_from = contents_from;
 		}
 		else {
 			if (lstat(path, &st) < 0)
-				die("Cannot lstat %s", path);
+				die("Cannot lstat '%s': %s", path,
+				    strerror(errno));
 			read_from = path;
 		}
 		mode = canon_mode(st.st_mode);
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
-				die("cannot open or read %s", read_from);
+				die("cannot open or read '%s': %s", read_from,
+				    strerror(errno));
 			break;
 		case S_IFLNK:
 			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
-				die("cannot readlink %s", read_from);
+				die("cannot readlink '%s': %s", read_from,
+				    strerror(errno));
 			break;
 		default:
 			die("unsupported file type %s", read_from);
@@ -2251,7 +2255,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	argc = parse_options_end(&ctx);
 
 	if (revs_file && read_ancestry(revs_file))
-		die("reading graft file %s failed: %s",
+		die("reading graft file '%s' failed: %s",
 		    revs_file, strerror(errno));
 
 	if (cmd_is_annotate) {
@@ -2340,7 +2344,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 		setup_work_tree();
 		if (!has_string_in_work_tree(path))
-			die("cannot stat path %s: %s", path, strerror(errno));
+			die("cannot stat path '%s': %s", path, strerror(errno));
 	}
 
 	setup_revisions(argc, argv, &revs, NULL);
diff --git a/builtin-clone.c b/builtin-clone.c
index 5c46496..a175ed1 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -220,13 +220,15 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 
 	dir = opendir(src->buf);
 	if (!dir)
-		die("failed to open %s", src->buf);
+		die("failed to open '%s': %s", src->buf, strerror(errno));
 
 	if (mkdir(dest->buf, 0777)) {
 		if (errno != EEXIST)
-			die("failed to create directory %s", dest->buf);
+			die("failed to create directory '%s': %s", dest->buf,
+			    strerror(errno));
 		else if (stat(dest->buf, &buf))
-			die("failed to stat %s", dest->buf);
+			die("failed to stat '%s': %s", dest->buf,
+			    strerror(errno));
 		else if (!S_ISDIR(buf.st_mode))
 			die("%s exists and is not a directory", dest->buf);
 	}
@@ -252,17 +254,19 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 		}
 
 		if (unlink(dest->buf) && errno != ENOENT)
-			die("failed to unlink %s: %s",
+			die("failed to unlink '%s': %s",
 			    dest->buf, strerror(errno));
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
 			if (option_local)
-				die("failed to create link %s", dest->buf);
+				die("failed to create link '%s': %s", dest->buf,
+				    strerror(errno));
 			option_no_hardlinks = 1;
 		}
 		if (copy_file(dest->buf, src->buf, 0666))
-			die("failed to copy file to %s", dest->buf);
+			die("failed to copy file to '%s': %s", dest->buf,
+			    strerror(errno));
 	}
 	closedir(dir);
 }
diff --git a/builtin-commit.c b/builtin-commit.c
index 41e222d..c21c16b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -434,7 +434,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		if (isatty(0))
 			fprintf(stderr, "(reading log message from standard input)\n");
 		if (strbuf_read(&sb, 0, 0) < 0)
-			die("could not read log from standard input");
+			die("could not read log from standard input: %s",
+			    strerror(errno));
 		hook_arg1 = "message";
 	} else if (logfile) {
 		if (strbuf_read_file(&sb, logfile, 0) < 0)
@@ -458,7 +459,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		hook_arg1 = "squash";
 	} else if (template_file && !stat(template_file, &statbuf)) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
-			die("could not read %s: %s",
+			die("could not read '%s': %s",
 			    template_file, strerror(errno));
 		hook_arg1 = "template";
 	}
@@ -472,7 +473,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 
 	fp = fopen(git_path(commit_editmsg), "w");
 	if (fp == NULL)
-		die("could not open %s: %s",
+		die("could not open '%s': %s",
 		    git_path(commit_editmsg), strerror(errno));
 
 	if (cleanup_mode != CLEANUP_NONE)
@@ -968,7 +969,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&sb);
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
-		die("could not read commit message");
+		die("could not read commit message: %s", strerror(errno));
 	}
 
 	/* Truncate the message just before the diff, if any. */
@@ -1021,8 +1022,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (commit_index_files())
 		die ("Repository has been updated, but unable to write\n"
-		     "new_index file. Check that disk is not full or quota is\n"
-		     "not exceeded, and then \"git reset HEAD\" to recover.");
+		     "new_index file: %s.\n"
+		     "Check that disk is not full or quota is not exceeded,\n"
+		     "and then \"git reset HEAD\" to recover.",
+		     strerror(errno));
 
 	rerere();
 	run_hook(get_index_file(), "post-commit", NULL);
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 6cef810..45a3ec8 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -119,7 +119,8 @@ static void handle_object(const unsigned char *sha1)
 
 	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
-		die ("Could not write blob %s", sha1_to_hex(sha1));
+		die ("Could not write blob '%s': %s", sha1_to_hex(sha1),
+		     strerror(errno));
 	printf("\n");
 
 	show_progress();
@@ -451,7 +452,7 @@ static void import_marks(char *input_file)
 	char line[512];
 	FILE *f = fopen(input_file, "r");
 	if (!f)
-		die("cannot read %s: %s", input_file, strerror(errno));
+		die("cannot read '%s': %s", input_file, strerror(errno));
 
 	while (fgets(line, sizeof(line), f)) {
 		uint32_t mark;
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index fbf9582..051f4a4 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -368,7 +368,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
 		if (!in)
-			die("cannot open %s", inpath);
+			die("cannot open '%s': %s", inpath, strerror(errno));
 	}
 
 	if (strbuf_read(&input, fileno(in), 0) < 0)
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 7da706c..e22f1a4 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -217,7 +217,8 @@ static void check_unreachable_object(struct object *obj)
 				return;
 			}
 			if (!(f = fopen(filename, "w")))
-				die("Could not open %s", filename);
+				die("Could not open '%s': %s", filename,
+				    strerror(errno));
 			if (obj->type == OBJ_BLOB) {
 				enum object_type type;
 				unsigned long size;
@@ -225,14 +226,14 @@ static void check_unreachable_object(struct object *obj)
 						&type, &size);
 				if (buf) {
 					if (fwrite(buf, size, 1, f) != 1)
-						die("Could not write %s: %s",
+						die("Could not write '%s': %s",
 						    filename, strerror(errno));
 					free(buf);
 				}
 			} else
 				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
 			if (fclose(f))
-				die("Could not finish %s: %s",
+				die("Could not finish '%s': %s",
 				    filename, strerror(errno));
 		}
 		return;
diff --git a/builtin-init-db.c b/builtin-init-db.c
index d1fa12a..4cdeb21 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -61,20 +61,23 @@ static void copy_templates_1(char *path, int baselen,
 		memcpy(template + template_baselen, de->d_name, namelen+1);
 		if (lstat(path, &st_git)) {
 			if (errno != ENOENT)
-				die("cannot stat %s", path);
+				die("cannot stat '%s': %s", path,
+				    strerror(errno));
 		}
 		else
 			exists = 1;
 
 		if (lstat(template, &st_template))
-			die("cannot stat template %s", template);
+			die("cannot stat template '%s': %s", template,
+			    strerror(errno));
 
 		if (S_ISDIR(st_template.st_mode)) {
 			DIR *subdir = opendir(template);
 			int baselen_sub = baselen + namelen;
 			int template_baselen_sub = template_baselen + namelen;
 			if (!subdir)
-				die("cannot opendir %s", template);
+				die("cannot opendir '%s': %s", template,
+				    strerror(errno));
 			path[baselen_sub++] =
 				template[template_baselen_sub++] = '/';
 			path[baselen_sub] =
@@ -91,16 +94,19 @@ static void copy_templates_1(char *path, int baselen,
 			int len;
 			len = readlink(template, lnk, sizeof(lnk));
 			if (len < 0)
-				die("cannot readlink %s", template);
+				die("cannot readlink '%s': %s", template,
+				    strerror(errno));
 			if (sizeof(lnk) <= len)
 				die("insanely long symlink %s", template);
 			lnk[len] = 0;
 			if (symlink(lnk, path))
-				die("cannot symlink %s %s", lnk, path);
+				die("cannot symlink '%s' '%s': %s", lnk, path,
+				    strerror(errno));
 		}
 		else if (S_ISREG(st_template.st_mode)) {
 			if (copy_file(path, template, st_template.st_mode))
-				die("cannot copy %s to %s", template, path);
+				die("cannot copy '%s' to '%s': %s", template,
+				    path, strerror(errno));
 		}
 		else
 			error("ignoring template %s", template);
@@ -350,7 +356,7 @@ static int guess_repository_type(const char *git_dir)
 	if (!strcmp(".", git_dir))
 		return 1;
 	if (!getcwd(cwd, sizeof(cwd)))
-		die("cannot tell cwd");
+		die("cannot tell cwd: %s", strerror(errno));
 	if (!strcmp(git_dir, cwd))
 		return 1;
 	/*
@@ -440,11 +446,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		if (!git_work_tree_cfg) {
 			git_work_tree_cfg = xcalloc(PATH_MAX, 1);
 			if (!getcwd(git_work_tree_cfg, PATH_MAX))
-				die ("Cannot access current working directory.");
+				die ("Cannot access current working directory: %s",
+				     strerror(errno));
 		}
 		if (access(get_git_work_tree(), X_OK))
-			die ("Cannot access work tree '%s'",
-			     get_git_work_tree());
+			die ("Cannot access work tree '%s': %s",
+			     get_git_work_tree(), strerror(errno));
 	}
 
 	set_git_dir(make_absolute_path(git_dir));
diff --git a/builtin-log.c b/builtin-log.c
index 0d34050..76cb3e2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1013,8 +1013,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (use_stdout)
 			die("standard output, or directory, which one?");
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
-			die("Could not create directory %s",
-			    output_directory);
+			die("Could not create directory '%s': %s",
+			    output_directory, strerror(errno));
 	}
 
 	if (rev.pending.nr == 1) {
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 71f3b3b..30c4e6f 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -81,7 +81,8 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 
 	fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	if (fd < 0)
-		die("cannot open output file %s", name);
+		die("cannot open output file '%s': %s", name,
+		    strerror(errno));
 	output = fdopen(fd, "w");
 
 	/* Copy it out, while searching for a line that begins with
@@ -91,7 +92,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 		int is_partial = len && buf[len-1] != '\n';
 
 		if (fwrite(buf, 1, len, output) != len)
-			die("cannot write output");
+			die("cannot write output: %s", strerror(errno));
 
 		len = read_line_with_nul(buf, sizeof(buf), mbox);
 		if (len == 0) {
@@ -99,7 +100,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 				status = 1;
 				break;
 			}
-			die("cannot read mbox");
+			die("cannot read mbox: %s", strerror(errno));
 		}
 		if (!is_partial && !is_bare && is_from_line(buf, len))
 			break; /* done with one message */
diff --git a/builtin-merge.c b/builtin-merge.c
index 8d101ef..4bac88e 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -268,7 +268,8 @@ static void squash_message(void)
 	printf("Squash commit -- not updating HEAD\n");
 	fd = open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
-		die("Could not write to %s", git_path("SQUASH_MSG"));
+		die("Could not write to '%s': %s", git_path("SQUASH_MSG"),
+		    strerror(errno));
 
 	init_revisions(&rev, NULL);
 	rev.ignore_merges = 1;
@@ -764,7 +765,8 @@ static int suggest_conflicts(void)
 
 	fp = fopen(git_path("MERGE_MSG"), "a");
 	if (!fp)
-		die("Could not open %s for writing", git_path("MERGE_MSG"));
+		die("Could not open '%s' for writing: %s", git_path("MERGE_MSG"),
+		    strerror(errno));
 	fprintf(fp, "\nConflicts:\n");
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
@@ -1186,27 +1188,32 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				sha1_to_hex(j->item->object.sha1));
 		fd = open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
 		if (fd < 0)
-			die("Could open %s for writing",
-				git_path("MERGE_HEAD"));
+			die("Could not open '%s' for writing: %s",
+			    git_path("MERGE_HEAD"), strerror(errno));
 		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-			die("Could not write to %s", git_path("MERGE_HEAD"));
+			die("Could not write to '%s': %s",
+			    git_path("MERGE_HEAD"), strerror(errno));
 		close(fd);
 		strbuf_addch(&merge_msg, '\n');
 		fd = open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
 		if (fd < 0)
-			die("Could open %s for writing", git_path("MERGE_MSG"));
+			die("Could not open '%s' for writing: %s",
+			    git_path("MERGE_MSG"), strerror(errno));
 		if (write_in_full(fd, merge_msg.buf, merge_msg.len) !=
 			merge_msg.len)
-			die("Could not write to %s", git_path("MERGE_MSG"));
+			die("Could not write to '%s': %s",
+			    git_path("MERGE_MSG"), strerror(errno));
 		close(fd);
 		fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 0666);
 		if (fd < 0)
-			die("Could open %s for writing", git_path("MERGE_MODE"));
+			die("Could not open '%s' for writing",
+			    git_path("MERGE_MODE"), strerror(errno));
 		strbuf_reset(&buf);
 		if (!allow_fast_forward)
 			strbuf_addf(&buf, "no-ff");
 		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-			die("Could not write to %s", git_path("MERGE_MODE"));
+			die("Could not write to '%s': %s",
+			    git_path("MERGE_MODE"), strerror(errno));
 		close(fd);
 	}
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 112d622..bbc21f8 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -592,7 +592,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					continue;
 				}
 				if (!getcwd(cwd, PATH_MAX))
-					die("unable to get current working directory");
+					die("unable to get current working directory: %s",
+					    strerror(errno));
 				printf("%s/.git\n", cwd);
 				continue;
 			}
diff --git a/builtin-revert.c b/builtin-revert.c
index c87115a..a82c4b8 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -135,7 +135,7 @@ static void add_to_msg(const char *string)
 {
 	int len = strlen(string);
 	if (write_in_full(msg_fd, string, len) < 0)
-		die ("Could not write to MERGE_MSG");
+		die ("Could not write to MERGE_MSG: %s", strerror(errno));
 }
 
 static void add_message_to_msg(const char *message)
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index d6e3896..7444f3f 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -78,7 +78,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		strip_comments = 1;
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
-		die("could not read the input");
+		die("could not read the input: %s", strerror(errno));
 
 	stripspace(&buf, strip_comments);
 
diff --git a/builtin-tag.c b/builtin-tag.c
index dc3db62..e509888 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -443,7 +443,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		else {
 			if (!strcmp(msgfile, "-")) {
 				if (strbuf_read(&buf, 0, 1024) < 0)
-					die("cannot read %s", msgfile);
+					die("cannot read '%s': %s", msgfile,
+					    strerror(errno));
 			} else {
 				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
 					die("could not open or read '%s': %s",
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f88e721..066887f 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -91,7 +91,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 
 	n = write_in_full(1, content + 11, 41);
 	if (n < 41)
-		die("git get-tar-commit-id: write error");
+		die("git get-tar-commit-id: write error: %s", strerror(errno));
 
 	return 0;
 }
diff --git a/combine-diff.c b/combine-diff.c
index 60d0367..540e877 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -746,7 +746,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 			done = read_in_full(fd, result, len);
 			if (done < 0)
-				die("read error '%s'", elem->path);
+				die("read error '%s': %s", elem->path,
+				    strerror(errno));
 			else if (done < len)
 				die("early EOF '%s'", elem->path);
 
diff --git a/diff.c b/diff.c
index dcfbcb0..6c0ba41 100644
--- a/diff.c
+++ b/diff.c
@@ -1974,7 +1974,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		size = buf.len;
 	}
 	if (write_in_full(fd, blob, size) != size)
-		die("unable to write temp-file");
+		die("unable to write temp-file: %s", strerror(errno));
 	close(fd);
 	temp->name = temp->tmp_path;
 	strcpy(temp->hex, sha1_to_hex(sha1));
@@ -2016,7 +2016,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		if (S_ISLNK(st.st_mode)) {
 			struct strbuf sb = STRBUF_INIT;
 			if (strbuf_readlink(&sb, name, st.st_size) < 0)
-				die("readlink(%s)", name);
+				die("readlink(%s): %s", name, strerror(errno));
 			prep_temp_blob(name, temp, sb.buf, sb.len,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
@@ -2209,7 +2209,7 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 				return;
 			}
 			if (lstat(one->path, &st) < 0)
-				die("stat %s", one->path);
+				die("stat '%s': %s", one->path, strerror(errno));
 			if (index_path(one->sha1, one->path, &st, 0))
 				die("cannot hash %s", one->path);
 		}
diff --git a/entry.c b/entry.c
index cc841ed..0dde848 100644
--- a/entry.c
+++ b/entry.c
@@ -37,7 +37,8 @@ static void create_directories(const char *path, int path_len,
 			if (errno == EEXIST && state->force &&
 			    !unlink_or_warn(buf) && !mkdir(buf, 0777))
 				continue;
-			die("cannot create directory at %s", buf);
+			die("cannot create directory at '%s': %s", buf,
+			    strerror(errno));
 		}
 	}
 	free(buf);
diff --git a/fast-import.c b/fast-import.c
index a2a2458..686cafc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -905,10 +905,10 @@ static int oecmp (const void *a_, const void *b_)
 
 	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
 	if (keep_fd < 0)
-		die("cannot create keep file");
+		die("cannot create keep file: %s", strerror(errno));
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
 	if (close(keep_fd))
-		die("failed to write keep file");
+		die("failed to write keep file: %s", strerror(errno));
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
diff --git a/hash-object.c b/hash-object.c
index 47cf43c..778dabe 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -29,7 +29,7 @@ static void hash_object(const char *path, const char *type, int write_object,
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
-		die("Cannot open %s", path);
+		die("Cannot open '%s': %s", path, strerror(errno));
 	hash_fd(fd, type, write_object, vpath);
 }
 
diff --git a/ll-merge.c b/ll-merge.c
index 81c02ad..681f3a0 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -152,7 +152,7 @@ static void create_temp(mmfile_t *src, char *path)
 	strcpy(path, ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
 	if (write_in_full(fd, src->ptr, src->size) != src->size)
-		die("unable to write temp-file");
+		die("unable to write temp-file: %s", strerror(errno));
 	close(fd);
 }
 
diff --git a/mktag.c b/mktag.c
index 99a356e..238269a 100644
--- a/mktag.c
+++ b/mktag.c
@@ -165,7 +165,7 @@ int main(int argc, char **argv)
 	setup_git_directory();
 
 	if (strbuf_read(&buf, 0, 4096) < 0) {
-		die("could not read from stdin");
+		die("could not read from stdin: %s", strerror(errno));
 	}
 
 	/* Verify it for some basic sanity: it needs to start with
diff --git a/read-cache.c b/read-cache.c
index 3f58711..2bb142c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1265,7 +1265,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (mmap == MAP_FAILED)
-		die("unable to map index file");
+		die("unable to map index file: %s", strerror(errno));
 
 	hdr = mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
diff --git a/setup.c b/setup.c
index ebd60de..8548801 100644
--- a/setup.c
+++ b/setup.c
@@ -327,7 +327,8 @@ static int check_repository_format_gently(int *nongit_ok)
 				return NULL;
 			set_git_dir(make_absolute_path(gitdirenv));
 			if (chdir(work_tree_env) < 0)
-				die ("Could not chdir to %s", work_tree_env);
+				die ("Could not chdir to %s: %s", work_tree_env,
+				     strerror(errno));
 			strcat(buffer, "/");
 			return retval;
 		}
@@ -339,7 +340,8 @@ static int check_repository_format_gently(int *nongit_ok)
 	}
 
 	if (!getcwd(cwd, sizeof(cwd)-1))
-		die("Unable to read current working directory");
+		die("Unable to read current working directory: %s",
+		    strerror(errno));
 
 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
 	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
@@ -382,7 +384,8 @@ static int check_repository_format_gently(int *nongit_ok)
 		if (offset <= ceil_offset) {
 			if (nongit_ok) {
 				if (chdir(cwd))
-					die("Cannot come back to cwd");
+					die("Cannot come back to cwd: %s",
+					    strerror(errno));
 				*nongit_ok = 1;
 				return NULL;
 			}
@@ -493,10 +496,12 @@ int check_repository_format(void)
 		static char buffer[PATH_MAX + 1];
 		char *rel;
 		if (retval && chdir(retval))
-			die ("Could not jump back into original cwd");
+			die ("Could not jump back into original cwd: %s",
+			     strerror(errno));
 		rel = get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
 		if (rel && *rel && chdir(get_git_work_tree()))
-			die ("Could not jump to working directory");
+			die ("Could not jump to working directory: %s",
+			     strerror(errno));
 		return rel && *rel ? strcat(rel, "/") : NULL;
 	}
 
diff --git a/sha1_file.c b/sha1_file.c
index e73cd4f..f6fc256 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2382,7 +2382,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	size = stream.total_out;
 
 	if (write_buffer(fd, compressed, size) < 0)
-		die("unable to write sha1 file");
+		die("unable to write sha1 file: %s", strerror(errno));
 	close_sha1_file(fd);
 	free(compressed);
 
diff --git a/transport.c b/transport.c
index 17891d5..93cc9a6 100644
--- a/transport.c
+++ b/transport.c
@@ -158,7 +158,8 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 
 	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
 	if (!mkdtemp(temp_dir.buf))
-		die ("Could not make temporary directory");
+		die ("Could not make temporary directory: %s",
+		     strerror(errno));
 	temp_dir_len = temp_dir.len;
 
 	strbuf_addstr(&buf, rsync_url(transport->url));
@@ -321,7 +322,8 @@ static int rsync_transport_push(struct transport *transport,
 
 	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
 	if (!mkdtemp(temp_dir.buf))
-		die ("Could not make temporary directory");
+		die ("Could not make temporary directory: %s",
+		     strerror(errno));
 	strbuf_addch(&temp_dir, '/');
 
 	if (flags & TRANSPORT_PUSH_ALL) {
diff --git a/unpack-file.c b/unpack-file.c
index 75cd2f1..af9afc8 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -17,7 +17,7 @@
 	strcpy(path, ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
 	if (write_in_full(fd, buf, size) != size)
-		die("unable to write temp-file");
+		die("unable to write temp-file: %s", strerror(errno));
 	close(fd);
 	return path;
 }
-- 
1.6.3.1.325.g02d91
