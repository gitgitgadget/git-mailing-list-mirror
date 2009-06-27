From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 4/4] Use die_errno() instead of die() when checking syscalls
Date: Sat, 27 Jun 2009 17:58:47 +0200
Message-ID: <872dc06da0f72fc1f73f3d14e303ccc922504863.1246115205.git.trast@student.ethz.ch>
References: <cover.1244494646.git.trast@student.ethz.ch> <cover.1246115204.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 17:59:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKaJJ-0004Sc-0i
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 17:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbZF0P7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 11:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZF0P7D
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 11:59:03 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16289 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbZF0P65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 11:58:57 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 17:58:49 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 17:58:49 +0200
X-Mailer: git-send-email 1.6.3.3.433.gc91b
In-Reply-To: <cover.1246115204.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 27 Jun 2009 15:58:49.0711 (UTC) FILETIME=[29263FF0:01C9F740]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122372>

Lots of die() calls did not actually report the kind of error, which
can leave the user confused as to the real problem.  Use die_errno()
where we check a system/library call that sets errno on failure, or
one of the following that wrap such calls:

  Function              Passes on error from
  --------              --------------------
  odb_pack_keep         open
  read_ancestry         fopen
  read_in_full          xread
  strbuf_read           xread
  strbuf_read_file      open or strbuf_read_file
  strbuf_readlink       readlink
  write_in_full         xwrite

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 abspath.c               |   12 ++++++------
 builtin-add.c           |    2 +-
 builtin-apply.c         |    6 +++---
 builtin-archive.c       |    4 ++--
 builtin-blame.c         |    8 ++++----
 builtin-clone.c         |   10 +++++-----
 builtin-commit.c        |    5 +++--
 builtin-fast-export.c   |    2 +-
 builtin-fmt-merge-msg.c |    2 +-
 builtin-fsck.c          |    2 +-
 builtin-init-db.c       |   21 +++++++++++----------
 builtin-log.c           |    4 ++--
 builtin-mailsplit.c     |    6 +++---
 builtin-merge.c         |   21 ++++++++++++---------
 builtin-rev-parse.c     |    2 +-
 builtin-revert.c        |    2 +-
 builtin-stripspace.c    |    2 +-
 builtin-tag.c           |    2 +-
 builtin-tar-tree.c      |    2 +-
 combine-diff.c          |    2 +-
 diff.c                  |    6 +++---
 entry.c                 |    2 +-
 fast-import.c           |    4 ++--
 hash-object.c           |    2 +-
 ll-merge.c              |    2 +-
 mktag.c                 |    2 +-
 read-cache.c            |    2 +-
 setup.c                 |   10 +++++-----
 transport.c             |    4 ++--
 unpack-file.c           |    2 +-
 30 files changed, 79 insertions(+), 74 deletions(-)

diff --git a/abspath.c b/abspath.c
index 649f34f..4bee0ba 100644
--- a/abspath.c
+++ b/abspath.c
@@ -41,13 +41,13 @@ int is_directory(const char *path)
 
 		if (*buf) {
 			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
-				die ("Could not get current working directory");
+				die_errno ("Could not get current working directory");
 
 			if (chdir(buf))
-				die ("Could not switch to '%s'", buf);
+				die_errno ("Could not switch to '%s'", buf);
 		}
 		if (!getcwd(buf, PATH_MAX))
-			die ("Could not get current working directory");
+			die_errno ("Could not get current working directory");
 
 		if (last_elem) {
 			int len = strlen(buf);
@@ -63,7 +63,7 @@ int is_directory(const char *path)
 		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
 			len = readlink(buf, next_buf, PATH_MAX);
 			if (len < 0)
-				die ("Invalid symlink: %s", buf);
+				die_errno ("Invalid symlink '%s'", buf);
 			if (PATH_MAX <= len)
 				die("symbolic link too long: %s", buf);
 			next_buf[len] = '\0';
@@ -75,7 +75,7 @@ int is_directory(const char *path)
 	}
 
 	if (*cwd && chdir(cwd))
-		die ("Could not change back to '%s'", cwd);
+		die_errno ("Could not change back to '%s'", cwd);
 
 	return buf;
 }
@@ -109,7 +109,7 @@ int is_directory(const char *path)
 	} else {
 		const char *cwd = get_pwd_cwd();
 		if (!cwd)
-			die("Cannot determine the current working directory");
+			die_errno("Cannot determine the current working directory");
 		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path) >= PATH_MAX)
 			die("Too long path: %.*s", 60, path);
 	}
diff --git a/builtin-add.c b/builtin-add.c
index 4e44148..78989da 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -220,7 +220,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	launch_editor(file, NULL, NULL);
 
 	if (stat(file, &st))
-		die("Could not stat '%s'", file);
+		die_errno("Could not stat '%s'", file);
 	if (!st.st_size)
 		die("Empty patch. Aborted.");
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 2df2cb9..dc0ff5e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2823,8 +2823,8 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned 
 	} else {
 		if (!cached) {
 			if (lstat(path, &st) < 0)
-				die("unable to stat newly created file %s",
-				    path);
+				die_errno("unable to stat newly created file '%s'",
+					  path);
 			fill_stat_cache_info(ce, &st);
 		}
 		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
@@ -2913,7 +2913,7 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 			++nr;
 		}
 	}
-	die("unable to write file %s mode %o", path, mode);
+	die_errno("unable to write file '%s' mode %o", path, mode);
 }
 
 static void create_file(struct patch *patch)
diff --git a/builtin-archive.c b/builtin-archive.c
index 3c5a5a7..f9a4bea 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -13,10 +13,10 @@ static void create_output_file(const char *output_file)
 {
 	int output_fd = open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	if (output_fd < 0)
-		die("could not create archive file: %s ", output_file);
+		die_errno("could not create archive file '%s'", output_file);
 	if (output_fd != 1) {
 		if (dup2(output_fd, 1) < 0)
-			die("could not redirect output");
+			die_errno("could not redirect output");
 		else
 			close(output_fd);
 	}
diff --git a/builtin-blame.c b/builtin-blame.c
index 7d8fbd5..fd6ca51 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2008,23 +2008,23 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 
 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
-				die("Cannot stat %s", contents_from);
+				die_errno("Cannot stat '%s'", contents_from);
 			read_from = contents_from;
 		}
 		else {
 			if (lstat(path, &st) < 0)
-				die("Cannot lstat %s", path);
+				die_errno("Cannot lstat '%s'", path);
 			read_from = path;
 		}
 		mode = canon_mode(st.st_mode);
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
-				die("cannot open or read %s", read_from);
+				die_errno("cannot open or read '%s'", read_from);
 			break;
 		case S_IFLNK:
 			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
-				die("cannot readlink %s", read_from);
+				die_errno("cannot readlink '%s'", read_from);
 			break;
 		default:
 			die("unsupported file type %s", read_from);
diff --git a/builtin-clone.c b/builtin-clone.c
index ccb0480..32dea74 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -220,13 +220,13 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 
 	dir = opendir(src->buf);
 	if (!dir)
-		die("failed to open %s", src->buf);
+		die_errno("failed to open '%s'", src->buf);
 
 	if (mkdir(dest->buf, 0777)) {
 		if (errno != EEXIST)
-			die("failed to create directory %s", dest->buf);
+			die_errno("failed to create directory '%s'", dest->buf);
 		else if (stat(dest->buf, &buf))
-			die("failed to stat %s", dest->buf);
+			die_errno("failed to stat '%s'", dest->buf);
 		else if (!S_ISDIR(buf.st_mode))
 			die("%s exists and is not a directory", dest->buf);
 	}
@@ -257,11 +257,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 			if (!link(src->buf, dest->buf))
 				continue;
 			if (option_local)
-				die("failed to create link %s", dest->buf);
+				die_errno("failed to create link '%s'", dest->buf);
 			option_no_hardlinks = 1;
 		}
 		if (copy_file(dest->buf, src->buf, 0666))
-			die("failed to copy file to %s", dest->buf);
+			die_errno("failed to copy file to '%s'", dest->buf);
 	}
 	closedir(dir);
 }
diff --git a/builtin-commit.c b/builtin-commit.c
index 88c51bd..4bcce06 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -434,7 +434,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		if (isatty(0))
 			fprintf(stderr, "(reading log message from standard input)\n");
 		if (strbuf_read(&sb, 0, 0) < 0)
-			die("could not read log from standard input");
+			die_errno("could not read log from standard input");
 		hook_arg1 = "message";
 	} else if (logfile) {
 		if (strbuf_read_file(&sb, logfile, 0) < 0)
@@ -964,8 +964,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	/* Finally, get the commit message */
 	strbuf_reset(&sb);
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
+		int saved_errno = errno;
 		rollback_index_files();
-		die("could not read commit message");
+		die("could not read commit message: %s", strerror(saved_errno));
 	}
 
 	/* Truncate the message just before the diff, if any. */
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 333d438..9a8a6fc 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -119,7 +119,7 @@ static void handle_object(const unsigned char *sha1)
 
 	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
-		die ("Could not write blob %s", sha1_to_hex(sha1));
+		die_errno ("Could not write blob '%s'", sha1_to_hex(sha1));
 	printf("\n");
 
 	show_progress();
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 1248d5e..9d52400 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -368,7 +368,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
 		if (!in)
-			die("cannot open %s", inpath);
+			die_errno("cannot open '%s'", inpath);
 	}
 
 	if (strbuf_read(&input, fileno(in), 0) < 0)
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 32a1e41..b3d38fa 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -217,7 +217,7 @@ static void check_unreachable_object(struct object *obj)
 				return;
 			}
 			if (!(f = fopen(filename, "w")))
-				die("Could not open %s", filename);
+				die_errno("Could not open '%s'", filename);
 			if (obj->type == OBJ_BLOB) {
 				enum object_type type;
 				unsigned long size;
diff --git a/builtin-init-db.c b/builtin-init-db.c
index d1fa12a..4a56006 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -61,20 +61,20 @@ static void copy_templates_1(char *path, int baselen,
 		memcpy(template + template_baselen, de->d_name, namelen+1);
 		if (lstat(path, &st_git)) {
 			if (errno != ENOENT)
-				die("cannot stat %s", path);
+				die_errno("cannot stat '%s'", path);
 		}
 		else
 			exists = 1;
 
 		if (lstat(template, &st_template))
-			die("cannot stat template %s", template);
+			die_errno("cannot stat template '%s'", template);
 
 		if (S_ISDIR(st_template.st_mode)) {
 			DIR *subdir = opendir(template);
 			int baselen_sub = baselen + namelen;
 			int template_baselen_sub = template_baselen + namelen;
 			if (!subdir)
-				die("cannot opendir %s", template);
+				die_errno("cannot opendir '%s'", template);
 			path[baselen_sub++] =
 				template[template_baselen_sub++] = '/';
 			path[baselen_sub] =
@@ -91,16 +91,17 @@ static void copy_templates_1(char *path, int baselen,
 			int len;
 			len = readlink(template, lnk, sizeof(lnk));
 			if (len < 0)
-				die("cannot readlink %s", template);
+				die_errno("cannot readlink '%s'", template);
 			if (sizeof(lnk) <= len)
 				die("insanely long symlink %s", template);
 			lnk[len] = 0;
 			if (symlink(lnk, path))
-				die("cannot symlink %s %s", lnk, path);
+				die_errno("cannot symlink '%s' '%s'", lnk, path);
 		}
 		else if (S_ISREG(st_template.st_mode)) {
 			if (copy_file(path, template, st_template.st_mode))
-				die("cannot copy %s to %s", template, path);
+				die_errno("cannot copy '%s' to '%s'", template,
+					  path);
 		}
 		else
 			error("ignoring template %s", template);
@@ -350,7 +351,7 @@ static int guess_repository_type(const char *git_dir)
 	if (!strcmp(".", git_dir))
 		return 1;
 	if (!getcwd(cwd, sizeof(cwd)))
-		die("cannot tell cwd");
+		die_errno("cannot tell cwd");
 	if (!strcmp(git_dir, cwd))
 		return 1;
 	/*
@@ -440,11 +441,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		if (!git_work_tree_cfg) {
 			git_work_tree_cfg = xcalloc(PATH_MAX, 1);
 			if (!getcwd(git_work_tree_cfg, PATH_MAX))
-				die ("Cannot access current working directory.");
+				die_errno ("Cannot access current working directory");
 		}
 		if (access(get_git_work_tree(), X_OK))
-			die ("Cannot access work tree '%s'",
-			     get_git_work_tree());
+			die_errno ("Cannot access work tree '%s'",
+				   get_git_work_tree());
 	}
 
 	set_git_dir(make_absolute_path(git_dir));
diff --git a/builtin-log.c b/builtin-log.c
index 44f9a27..0c2fa0a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1013,8 +1013,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (use_stdout)
 			die("standard output, or directory, which one?");
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
-			die("Could not create directory %s",
-			    output_directory);
+			die_errno("Could not create directory '%s'",
+				  output_directory);
 	}
 
 	if (rev.pending.nr == 1) {
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 71f3b3b..ad5f6b5 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -81,7 +81,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 
 	fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	if (fd < 0)
-		die("cannot open output file %s", name);
+		die_errno("cannot open output file '%s'", name);
 	output = fdopen(fd, "w");
 
 	/* Copy it out, while searching for a line that begins with
@@ -91,7 +91,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 		int is_partial = len && buf[len-1] != '\n';
 
 		if (fwrite(buf, 1, len, output) != len)
-			die("cannot write output");
+			die_errno("cannot write output");
 
 		len = read_line_with_nul(buf, sizeof(buf), mbox);
 		if (len == 0) {
@@ -99,7 +99,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 				status = 1;
 				break;
 			}
-			die("cannot read mbox");
+			die_errno("cannot read mbox");
 		}
 		if (!is_partial && !is_bare && is_from_line(buf, len))
 			break; /* done with one message */
diff --git a/builtin-merge.c b/builtin-merge.c
index 5ad2188..82b5466 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -268,7 +268,7 @@ static void squash_message(void)
 	printf("Squash commit -- not updating HEAD\n");
 	fd = open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
-		die("Could not write to %s", git_path("SQUASH_MSG"));
+		die_errno("Could not write to '%s'", git_path("SQUASH_MSG"));
 
 	init_revisions(&rev, NULL);
 	rev.ignore_merges = 1;
@@ -764,7 +764,8 @@ static int suggest_conflicts(void)
 
 	fp = fopen(git_path("MERGE_MSG"), "a");
 	if (!fp)
-		die("Could not open %s for writing", git_path("MERGE_MSG"));
+		die_errno("Could not open '%s' for writing",
+			  git_path("MERGE_MSG"));
 	fprintf(fp, "\nConflicts:\n");
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
@@ -1189,27 +1190,29 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				sha1_to_hex(j->item->object.sha1));
 		fd = open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
 		if (fd < 0)
-			die("Could open %s for writing",
-				git_path("MERGE_HEAD"));
+			die_errno("Could not open '%s' for writing",
+				  git_path("MERGE_HEAD"));
 		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-			die("Could not write to %s", git_path("MERGE_HEAD"));
+			die_errno("Could not write to '%s'", git_path("MERGE_HEAD"));
 		close(fd);
 		strbuf_addch(&merge_msg, '\n');
 		fd = open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
 		if (fd < 0)
-			die("Could open %s for writing", git_path("MERGE_MSG"));
+			die_errno("Could not open '%s' for writing",
+				  git_path("MERGE_MSG"));
 		if (write_in_full(fd, merge_msg.buf, merge_msg.len) !=
 			merge_msg.len)
-			die("Could not write to %s", git_path("MERGE_MSG"));
+			die_errno("Could not write to '%s'", git_path("MERGE_MSG"));
 		close(fd);
 		fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 0666);
 		if (fd < 0)
-			die("Could open %s for writing", git_path("MERGE_MODE"));
+			die_errno("Could not open '%s' for writing",
+				  git_path("MERGE_MODE"));
 		strbuf_reset(&buf);
 		if (!allow_fast_forward)
 			strbuf_addf(&buf, "no-ff");
 		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-			die("Could not write to %s", git_path("MERGE_MODE"));
+			die_errno("Could not write to '%s'", git_path("MERGE_MODE"));
 		close(fd);
 	}
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 112d622..da26dbc 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -592,7 +592,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					continue;
 				}
 				if (!getcwd(cwd, PATH_MAX))
-					die("unable to get current working directory");
+					die_errno("unable to get current working directory");
 				printf("%s/.git\n", cwd);
 				continue;
 			}
diff --git a/builtin-revert.c b/builtin-revert.c
index c87115a..151aa6a 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -135,7 +135,7 @@ static void add_to_msg(const char *string)
 {
 	int len = strlen(string);
 	if (write_in_full(msg_fd, string, len) < 0)
-		die ("Could not write to MERGE_MSG");
+		die_errno ("Could not write to MERGE_MSG");
 }
 
 static void add_message_to_msg(const char *message)
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index d6e3896..1fd2205 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -78,7 +78,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		strip_comments = 1;
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
-		die("could not read the input");
+		die_errno("could not read the input");
 
 	stripspace(&buf, strip_comments);
 
diff --git a/builtin-tag.c b/builtin-tag.c
index 4f6e414..a51a6d1 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -442,7 +442,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		else {
 			if (!strcmp(msgfile, "-")) {
 				if (strbuf_read(&buf, 0, 1024) < 0)
-					die("cannot read %s", msgfile);
+					die_errno("cannot read '%s'", msgfile);
 			} else {
 				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
 					die_errno("could not open or read '%s'",
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f88e721..8b3a35e 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -91,7 +91,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 
 	n = write_in_full(1, content + 11, 41);
 	if (n < 41)
-		die("git get-tar-commit-id: write error");
+		die_errno("git get-tar-commit-id: write error");
 
 	return 0;
 }
diff --git a/combine-diff.c b/combine-diff.c
index 60d0367..bbf74fc 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -746,7 +746,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 			done = read_in_full(fd, result, len);
 			if (done < 0)
-				die("read error '%s'", elem->path);
+				die_errno("read error '%s'", elem->path);
 			else if (done < len)
 				die("early EOF '%s'", elem->path);
 
diff --git a/diff.c b/diff.c
index 79aea7f..0a020ff 100644
--- a/diff.c
+++ b/diff.c
@@ -1982,7 +1982,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		size = buf.len;
 	}
 	if (write_in_full(fd, blob, size) != size)
-		die("unable to write temp-file");
+		die_errno("unable to write temp-file");
 	close(fd);
 	temp->name = temp->tmp_path;
 	strcpy(temp->hex, sha1_to_hex(sha1));
@@ -2026,7 +2026,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		if (S_ISLNK(st.st_mode)) {
 			struct strbuf sb = STRBUF_INIT;
 			if (strbuf_readlink(&sb, name, st.st_size) < 0)
-				die("readlink(%s)", name);
+				die_errno("readlink(%s)", name);
 			prep_temp_blob(name, temp, sb.buf, sb.len,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
@@ -2219,7 +2219,7 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 				return;
 			}
 			if (lstat(one->path, &st) < 0)
-				die("stat %s", one->path);
+				die_errno("stat '%s'", one->path);
 			if (index_path(one->sha1, one->path, &st, 0))
 				die("cannot hash %s", one->path);
 		}
diff --git a/entry.c b/entry.c
index 8ec880b..d3e86c7 100644
--- a/entry.c
+++ b/entry.c
@@ -37,7 +37,7 @@ static void create_directories(const char *path, int path_len,
 			if (errno == EEXIST && state->force &&
 			    !unlink_or_warn(buf) && !mkdir(buf, 0777))
 				continue;
-			die("cannot create directory at %s", buf);
+			die_errno("cannot create directory at '%s'", buf);
 		}
 	}
 	free(buf);
diff --git a/fast-import.c b/fast-import.c
index d31a4e8..7ef9865 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -905,10 +905,10 @@ static int oecmp (const void *a_, const void *b_)
 
 	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
 	if (keep_fd < 0)
-		die("cannot create keep file");
+		die_errno("cannot create keep file");
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
 	if (close(keep_fd))
-		die("failed to write keep file");
+		die_errno("failed to write keep file");
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
diff --git a/hash-object.c b/hash-object.c
index 47cf43c..9455dd0 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -29,7 +29,7 @@ static void hash_object(const char *path, const char *type, int write_object,
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
-		die("Cannot open %s", path);
+		die_errno("Cannot open '%s'", path);
 	hash_fd(fd, type, write_object, vpath);
 }
 
diff --git a/ll-merge.c b/ll-merge.c
index 9168958..dad795a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -152,7 +152,7 @@ static void create_temp(mmfile_t *src, char *path)
 	strcpy(path, ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
 	if (write_in_full(fd, src->ptr, src->size) != src->size)
-		die("unable to write temp-file");
+		die_errno("unable to write temp-file");
 	close(fd);
 }
 
diff --git a/mktag.c b/mktag.c
index 99a356e..a609e3e 100644
--- a/mktag.c
+++ b/mktag.c
@@ -165,7 +165,7 @@ int main(int argc, char **argv)
 	setup_git_directory();
 
 	if (strbuf_read(&buf, 0, 4096) < 0) {
-		die("could not read from stdin");
+		die_errno("could not read from stdin");
 	}
 
 	/* Verify it for some basic sanity: it needs to start with
diff --git a/read-cache.c b/read-cache.c
index f76b5bb..4e3e272 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1265,7 +1265,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (mmap == MAP_FAILED)
-		die("unable to map index file");
+		die_errno("unable to map index file");
 
 	hdr = mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
diff --git a/setup.c b/setup.c
index 4d27f28..e3781b6 100644
--- a/setup.c
+++ b/setup.c
@@ -327,7 +327,7 @@ static int check_repository_format_gently(int *nongit_ok)
 				return NULL;
 			set_git_dir(make_absolute_path(gitdirenv));
 			if (chdir(work_tree_env) < 0)
-				die ("Could not chdir to %s", work_tree_env);
+				die_errno ("Could not chdir to '%s'", work_tree_env);
 			strcat(buffer, "/");
 			return retval;
 		}
@@ -339,7 +339,7 @@ static int check_repository_format_gently(int *nongit_ok)
 	}
 
 	if (!getcwd(cwd, sizeof(cwd)-1))
-		die("Unable to read current working directory");
+		die_errno("Unable to read current working directory");
 
 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
 	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
@@ -382,7 +382,7 @@ static int check_repository_format_gently(int *nongit_ok)
 		if (offset <= ceil_offset) {
 			if (nongit_ok) {
 				if (chdir(cwd))
-					die("Cannot come back to cwd");
+					die_errno("Cannot come back to cwd");
 				*nongit_ok = 1;
 				return NULL;
 			}
@@ -493,10 +493,10 @@ int check_repository_format(void)
 		static char buffer[PATH_MAX + 1];
 		char *rel;
 		if (retval && chdir(retval))
-			die ("Could not jump back into original cwd");
+			die_errno ("Could not jump back into original cwd");
 		rel = get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
 		if (rel && *rel && chdir(get_git_work_tree()))
-			die ("Could not jump to working directory");
+			die_errno ("Could not jump to working directory");
 		return rel && *rel ? strcat(rel, "/") : NULL;
 	}
 
diff --git a/transport.c b/transport.c
index 501a77b..ccf788d 100644
--- a/transport.c
+++ b/transport.c
@@ -158,7 +158,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 
 	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
 	if (!mkdtemp(temp_dir.buf))
-		die ("Could not make temporary directory");
+		die_errno ("Could not make temporary directory");
 	temp_dir_len = temp_dir.len;
 
 	strbuf_addstr(&buf, rsync_url(transport->url));
@@ -321,7 +321,7 @@ static int rsync_transport_push(struct transport *transport,
 
 	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
 	if (!mkdtemp(temp_dir.buf))
-		die ("Could not make temporary directory");
+		die_errno ("Could not make temporary directory");
 	strbuf_addch(&temp_dir, '/');
 
 	if (flags & TRANSPORT_PUSH_ALL) {
diff --git a/unpack-file.c b/unpack-file.c
index 75cd2f1..ac9cbf7 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -17,7 +17,7 @@
 	strcpy(path, ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
 	if (write_in_full(fd, buf, size) != size)
-		die("unable to write temp-file");
+		die_errno("unable to write temp-file");
 	close(fd);
 	return path;
 }
-- 
1.6.3.3.433.gc91b
