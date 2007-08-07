From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] cygwin: added fopen "b" and open O_BINARY to support cygwin's textmode
Date: Wed,  8 Aug 2007 00:49:06 +0200
Message-ID: <11865269472595-git-send-email-prohaska@zib.de>
References: <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 08 00:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIXsv-0004QK-EK
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 00:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbXHGWuB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 18:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933219AbXHGWuA
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 18:50:00 -0400
Received: from mailer.zib.de ([130.73.108.11]:32776 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935314AbXHGWt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 18:49:57 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l77Mn79t023715;
	Wed, 8 Aug 2007 00:49:08 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l77Mn7cj001225;
	Wed, 8 Aug 2007 00:49:07 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55282>

O_BINARY = 0 is provided by the Makefile for all architectures
except Cygwin.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile                |    5 +++++
 attr.c                  |    2 +-
 builtin-apply.c         |    8 ++++----
 builtin-blame.c         |    4 ++--
 builtin-bundle.c        |    4 ++--
 builtin-fetch--tool.c   |    4 ++--
 builtin-fmt-merge-msg.c |    2 +-
 builtin-fsck.c          |    2 +-
 builtin-grep.c          |    4 ++--
 builtin-init-db.c       |    4 ++--
 builtin-mailinfo.c      |    4 ++--
 builtin-mailsplit.c     |    6 +++---
 builtin-reflog.c        |    2 +-
 builtin-rerere.c        |   12 ++++++------
 combine-diff.c          |    2 +-
 commit.c                |    2 +-
 config.c                |    4 ++--
 daemon.c                |    4 ++--
 diff.c                  |    2 +-
 diffcore-order.c        |    2 +-
 dir.c                   |    2 +-
 entry.c                 |    2 +-
 fast-import.c           |    6 +++---
 hash-object.c           |    2 +-
 http-fetch.c            |    6 +++---
 http-push.c             |    6 +++---
 imap-send.c             |    2 +-
 index-pack.c            |    6 +++---
 local-fetch.c           |    6 +++---
 lockfile.c              |    2 +-
 mailmap.c               |    2 +-
 merge-recursive.c       |    4 ++--
 pack-write.c            |    2 +-
 path.c                  |    4 ++--
 read-cache.c            |    4 ++--
 refs.c                  |   14 +++++++-------
 remote.c                |    4 ++--
 run-command.c           |    2 +-
 server-info.c           |    6 +++---
 sha1_file.c             |   14 +++++++-------
 shallow.c               |    2 +-
 test-delta.c            |    6 +++---
 trace.c                 |    2 +-
 43 files changed, 95 insertions(+), 90 deletions(-)

I took a more radical approach and used a small script to add
"b" to all calls to fopen and O_BINARY to all calls to open.
I don't think we need to differentiate between binary and
textfiles. 

    Steffen

diff --git a/Makefile b/Makefile
index 2f3b9b2..0959032 100644
--- a/Makefile
+++ b/Makefile
@@ -427,6 +427,7 @@ ifeq ($(uname_O),Cygwin)
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
+	NO_O_BINARY = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
@@ -495,6 +496,10 @@ ifeq ($(uname_S),Darwin)
 	endif
 endif
 
+ifndef NO_O_BINARY
+BASIC_CFLAGS += -DO_BINARY=0
+endif
+
 ifdef NO_R_TO_GCC_LINKER
 	# Some gcc does not accept and pass -R to the linker to specify
 	# the runtime dynamic library path.
diff --git a/attr.c b/attr.c
index a071254..442e2a6 100644
--- a/attr.c
+++ b/attr.c
@@ -315,7 +315,7 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	int lineno = 0;
 
 	res = xcalloc(1, sizeof(*res));
-	fp = fopen(path, "r");
+	fp = fopen(path, "rb");
 	if (!fp)
 		return res;
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 0a0b4a9..5eecb7f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1467,7 +1467,7 @@ static int read_old_data(struct stat *st, const char *path, char **buf_p, unsign
 	case S_IFLNK:
 		return readlink(path, buf, size) != size;
 	case S_IFREG:
-		fd = open(path, O_RDONLY);
+		fd = open(path, O_BINARY | O_RDONLY);
 		if (fd < 0)
 			return error("unable to open %s", path);
 		got = 0;
@@ -2404,7 +2404,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 		 */
 		return symlink(buf, path);
 
-	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
+	fd = open(path, O_CREAT | O_EXCL | O_BINARY | O_WRONLY, (mode & 0100) ? 0777 : 0666);
 	if (fd < 0)
 		return -1;
 
@@ -2553,7 +2553,7 @@ static int write_out_one_reject(struct patch *patch)
 	memcpy(namebuf, patch->new_name, cnt);
 	memcpy(namebuf + cnt, ".rej", 5);
 
-	rej = fopen(namebuf, "w");
+	rej = fopen(namebuf, "wb");
 	if (!rej)
 		return error("cannot open %s: %s", namebuf, strerror(errno));
 
@@ -2866,7 +2866,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
-		fd = open(arg, O_RDONLY);
+		fd = open(arg, O_BINARY | O_RDONLY);
 		if (fd < 0)
 			usage(apply_usage);
 		read_stdin = 0;
diff --git a/builtin-blame.c b/builtin-blame.c
index 0519339..0e3b06a 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1727,7 +1727,7 @@ static int prepare_lines(struct scoreboard *sb)
  */
 static int read_ancestry(const char *graft_file)
 {
-	FILE *fp = fopen(graft_file, "r");
+	FILE *fp = fopen(graft_file, "rb");
 	char buf[1024];
 	if (!fp)
 		return -1;
@@ -2035,7 +2035,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 		mode = canon_mode(st.st_mode);
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
-			fd = open(read_from, O_RDONLY);
+			fd = open(read_from, O_BINARY | O_RDONLY);
 			if (fd < 0)
 				die("cannot open %s", read_from);
 			if (read_in_full(fd, buf, fin_size) != fin_size)
diff --git a/builtin-bundle.c b/builtin-bundle.c
index 6ae5ab0..4d189f5 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -66,7 +66,7 @@ static int read_string(int fd, char *buffer, int size)
 /* returns an fd */
 static int read_header(const char *path, struct bundle_header *header) {
 	char buffer[1024];
-	int fd = open(path, O_RDONLY);
+	int fd = open(path, O_BINARY | O_RDONLY);
 
 	if (fd < 0)
 		return error("could not open '%s'", path);
@@ -209,7 +209,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	struct child_process rls;
 
 	bundle_fd = (!strcmp(path, "-") ? 1 :
-			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
+			open(path, O_CREAT | O_EXCL | O_BINARY | O_WRONLY, 0666));
 	if (bundle_fd < 0)
 		return error("Could not create '%s': %s", path, strerror(errno));
 
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index e2f8ede..bf0fd1f 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -539,7 +539,7 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 
 		if (argc != 8)
 			return error("append-fetch-head takes 6 args");
-		fp = fopen(git_path("FETCH_HEAD"), "a");
+		fp = fopen(git_path("FETCH_HEAD"), "ab");
 		result = append_fetch_head(fp, argv[2], argv[3],
 					   argv[4], argv[5],
 					   argv[6], !!argv[7][0],
@@ -553,7 +553,7 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 
 		if (argc != 5)
 			return error("fetch-native-store takes 3 args");
-		fp = fopen(git_path("FETCH_HEAD"), "a");
+		fp = fopen(git_path("FETCH_HEAD"), "ab");
 		result = fetch_native_store(fp, argv[2], argv[3], argv[4],
 					    verbose, force);
 		fclose(fp);
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index ae60fcc..079c2d8 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -265,7 +265,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 				in = stdin;
 			else {
 				fclose(in);
-				in = fopen(argv[2], "r");
+				in = fopen(argv[2], "rb");
 				if (!in)
 					die("cannot open %s", argv[2]);
 			}
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 8d12287..335dd80 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -150,7 +150,7 @@ static void check_unreachable_object(struct object *obj)
 				error("Could not create lost-found");
 				return;
 			}
-			if (!(f = fopen(filename, "w")))
+			if (!(f = fopen(filename, "wb")))
 				die("Could not open %s", filename);
 			if (obj->type == OBJ_BLOB) {
 				enum object_type type;
diff --git a/builtin-grep.c b/builtin-grep.c
index e13cb31..b941b04 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -135,7 +135,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	if (!S_ISREG(st.st_mode))
 		return 0;
 	sz = xsize_t(st.st_size);
-	i = open(filename, O_RDONLY);
+	i = open(filename, O_BINARY | O_RDONLY);
 	if (i < 0)
 		goto err_ret;
 	data = xmalloc(sz + 1);
@@ -577,7 +577,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			char buf[1024];
 			if (argc <= 1)
 				die(emsg_missing_argument, arg);
-			patterns = fopen(argv[1], "r");
+			patterns = fopen(argv[1], "rb");
 			if (!patterns)
 				die("'%s': %s", argv[1], strerror(errno));
 			while (fgets(buf, sizeof(buf), patterns)) {
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 0d9b1e0..f9e6622 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -33,9 +33,9 @@ static int copy_file(const char *dst, const char *src, int mode)
 	int fdi, fdo, status;
 
 	mode = (mode & 0111) ? 0777 : 0666;
-	if ((fdi = open(src, O_RDONLY)) < 0)
+	if ((fdi = open(src, O_BINARY | O_RDONLY)) < 0)
 		return fdi;
-	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
+	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_BINARY | O_EXCL, mode)) < 0) {
 		close(fdi);
 		return fdo;
 	}
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b558754..d462da1 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -905,12 +905,12 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 	fin = in;
 	fout = out;
 
-	cmitmsg = fopen(msg, "w");
+	cmitmsg = fopen(msg, "wb");
 	if (!cmitmsg) {
 		perror(msg);
 		return -1;
 	}
-	patchfile = fopen(patch, "w");
+	patchfile = fopen(patch, "wb");
 	if (!patchfile) {
 		perror(patch);
 		fclose(cmitmsg);
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 43fc373..c04e82e 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -61,7 +61,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	if (is_bare && !allow_bare)
 		goto corrupt;
 
-	fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	fd = open(name, O_WRONLY | O_CREAT | O_BINARY | O_EXCL, 0666);
 	if (fd < 0)
 		die("cannot open output file %s", name);
 	output = fdopen(fd, "w");
@@ -135,7 +135,7 @@ static int split_maildir(const char *maildir, const char *dir,
 	for (i = 0; i < list.nr; i++) {
 		FILE *f;
 		snprintf(file, sizeof(file), "%s/%s", curdir, list.items[i].path);
-		f = fopen(file, "r");
+		f = fopen(file, "rb");
 		if (!f) {
 			error("cannot open mail %s (%s)", file, strerror(errno));
 			goto out;
@@ -165,7 +165,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	char name[PATH_MAX];
 	int ret = -1;
 
-	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
+	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "rb");
 	int file_done = 0;
 
 	if (!f) {
diff --git a/builtin-reflog.c b/builtin-reflog.c
index ce093ca..a6221c3 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -257,7 +257,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		goto finish;
 	if (!cmd->dry_run) {
 		newlog_path = xstrdup(git_path("logs/%s.lock", ref));
-		cb.newlog = fopen(newlog_path, "w");
+		cb.newlog = fopen(newlog_path, "wb");
 	}
 
 	cb.ref_commit = lookup_commit_reference_gently(sha1, 1);
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 29d057c..0fe2beb 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -27,7 +27,7 @@ static void read_rr(struct path_list *rr)
 {
 	unsigned char sha1[20];
 	char buf[PATH_MAX];
-	FILE *in = fopen(merge_rr_path, "r");
+	FILE *in = fopen(merge_rr_path, "rb");
 	if (!in)
 		return;
 	while (fread(buf, 40, 1, in) == 1) {
@@ -98,14 +98,14 @@ static int handle_file(const char *path,
 	int hunk = 0, hunk_no = 0;
 	struct buffer minus = { NULL, 0, 0 }, plus = { NULL, 0, 0 };
 	struct buffer *one = &minus, *two = &plus;
-	FILE *f = fopen(path, "r");
+	FILE *f = fopen(path, "rb");
 	FILE *out;
 
 	if (!f)
 		return error("Could not open %s", path);
 
 	if (output) {
-		out = fopen(output, "w");
+		out = fopen(output, "wb");
 		if (!out) {
 			fclose(f);
 			return error("Could not write %s", output);
@@ -201,7 +201,7 @@ static int merge(const char *name, const char *path)
 	ret = xdl_merge(&base, &cur, "", &other, "",
 			&xpp, XDL_MERGE_ZEALOUS, &result);
 	if (!ret) {
-		FILE *f = fopen(path, "w");
+		FILE *f = fopen(path, "wb");
 		if (!f)
 			return error("Could not write to %s", path);
 		fwrite(result.ptr, result.size, 1, f);
@@ -299,9 +299,9 @@ static int copy_file(const char *src, const char *dest)
 	char buffer[32768];
 	int count;
 
-	if (!(in = fopen(src, "r")))
+	if (!(in = fopen(src, "rb")))
 		return error("Could not open %s", src);
-	if (!(out = fopen(dest, "w")))
+	if (!(out = fopen(dest, "wb")))
 		return error("Could not open %s", dest);
 	while ((count = fread(buffer, 1, sizeof(buffer), in)))
 		fwrite(buffer, 1, count, out);
diff --git a/combine-diff.c b/combine-diff.c
index ef62234..cb37aea 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -694,7 +694,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result[len] = 0;
 			elem->mode = canon_mode(st.st_mode);
 		}
-		else if (0 <= (fd = open(elem->path, O_RDONLY)) &&
+		else if (0 <= (fd = open(elem->path, O_BINARY | O_RDONLY)) &&
 			 !fstat(fd, &st)) {
 			size_t len = xsize_t(st.st_size);
 			size_t sz = 0;
diff --git a/commit.c b/commit.c
index dc5a064..7baa1e7 100644
--- a/commit.c
+++ b/commit.c
@@ -206,7 +206,7 @@ struct commit_graft *read_graft_line(char *buf, int len)
 
 int read_graft_file(const char *graft_file)
 {
-	FILE *fp = fopen(graft_file, "r");
+	FILE *fp = fopen(graft_file, "rb");
 	char buf[1024];
 	if (!fp)
 		return -1;
diff --git a/config.c b/config.c
index dd2de6e..818d444 100644
--- a/config.c
+++ b/config.c
@@ -433,7 +433,7 @@ int git_default_config(const char *var, const char *value)
 int git_config_from_file(config_fn_t fn, const char *filename)
 {
 	int ret;
-	FILE *f = fopen(filename, "r");
+	FILE *f = fopen(filename, "rb");
 
 	ret = -1;
 	if (f) {
@@ -784,7 +784,7 @@ int git_config_set_multivar(const char* key, const char* value,
 	/*
 	 * If .git/config does not exist yet, write a minimal version.
 	 */
-	in_fd = open(config_filename, O_RDONLY);
+	in_fd = open(config_filename, O_BINARY | O_RDONLY);
 	if ( in_fd < 0 ) {
 		free(store.key);
 
diff --git a/daemon.c b/daemon.c
index 9cf22fe..4d2e211 100644
--- a/daemon.c
+++ b/daemon.c
@@ -956,7 +956,7 @@ static int service_loop(int socknum, int *socklist)
 /* if any standard file descriptor is missing open it to /dev/null */
 static void sanitize_stdfds(void)
 {
-	int fd = open("/dev/null", O_RDWR, 0);
+	int fd = open("/dev/null", O_BINARY | O_RDWR, 0);
 	while (fd != -1 && fd < 2)
 		fd = dup(fd);
 	if (fd == -1)
@@ -985,7 +985,7 @@ static void daemonize(void)
 
 static void store_pid(const char *path)
 {
-	FILE *f = fopen(path, "w");
+	FILE *f = fopen(path, "wb");
 	if (!f)
 		die("cannot open pid file %s: %s", path, strerror(errno));
 	if (fprintf(f, "%d\n", getpid()) < 0 || fclose(f) != 0)
diff --git a/diff.c b/diff.c
index a5fc56b..2521bad 100644
--- a/diff.c
+++ b/diff.c
@@ -1638,7 +1638,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 			}
 			return 0;
 		}
-		fd = open(s->path, O_RDONLY);
+		fd = open(s->path, O_BINARY | O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
 		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
diff --git a/diffcore-order.c b/diffcore-order.c
index 2a4bd82..c08226d 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -19,7 +19,7 @@ static void prepare_order(const char *orderfile)
 	if (order)
 		return;
 
-	fd = open(orderfile, O_RDONLY);
+	fd = open(orderfile, O_BINARY | O_RDONLY);
 	if (fd < 0)
 		return;
 	if (fstat(fd, &st)) {
diff --git a/dir.c b/dir.c
index eb6c3ab..559f728 100644
--- a/dir.c
+++ b/dir.c
@@ -144,7 +144,7 @@ static int add_excludes_from_file_1(const char *fname,
 	size_t size;
 	char *buf, *entry;
 
-	fd = open(fname, O_RDONLY);
+	fd = open(fname, O_BINARY | O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0)
 		goto err;
 	size = xsize_t(st.st_size);
diff --git a/entry.c b/entry.c
index 0625112..02696d6 100644
--- a/entry.c
+++ b/entry.c
@@ -82,7 +82,7 @@ static void remove_subtree(const char *path)
 static int create_file(const char *path, unsigned int mode)
 {
 	mode = (mode & 0100) ? 0777 : 0666;
-	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
+	return open(path, O_WRONLY | O_CREAT | O_BINARY | O_EXCL, mode);
 }
 
 static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned long *size)
diff --git a/fast-import.c b/fast-import.c
index 99a19d8..741ca41 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -757,7 +757,7 @@ static char *keep_pack(char *curr_index_name)
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	keep_fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+	keep_fd = open(name, O_RDWR|O_CREAT|O_BINARY | O_EXCL, 0600);
 	if (keep_fd < 0)
 		die("cannot create keep file");
 	write(keep_fd, keep_msg, strlen(keep_msg));
@@ -2109,7 +2109,7 @@ static void cmd_checkpoint(void)
 static void import_marks(const char *input_file)
 {
 	char line[512];
-	FILE *f = fopen(input_file, "r");
+	FILE *f = fopen(input_file, "rb");
 	if (!f)
 		die("cannot read %s: %s", input_file, strerror(errno));
 	while (fgets(line, sizeof(line), f)) {
@@ -2185,7 +2185,7 @@ int main(int argc, const char **argv)
 		else if (!prefixcmp(a, "--export-pack-edges=")) {
 			if (pack_edges)
 				fclose(pack_edges);
-			pack_edges = fopen(a + 20, "a");
+			pack_edges = fopen(a + 20, "ab");
 			if (!pack_edges)
 				die("Cannot open %s: %s", a + 20, strerror(errno));
 		} else if (!strcmp(a, "--force"))
diff --git a/hash-object.c b/hash-object.c
index 18f5017..bb0621c 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -12,7 +12,7 @@ static void hash_object(const char *path, enum object_type type, int write_objec
 	int fd;
 	struct stat st;
 	unsigned char sha1[20];
-	fd = open(path, O_RDONLY);
+	fd = open(path, O_BINARY | O_RDONLY);
 	if (fd < 0 ||
 	    fstat(fd, &st) < 0 ||
 	    index_fd(sha1, fd, &st, write_object, type, path))
diff --git a/http-fetch.c b/http-fetch.c
index 202fae0..3a73acf 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -171,7 +171,7 @@ static void start_object_request(struct object_request *obj_req)
 
 	/* If a previous temp file is present, process what was already
 	   fetched. */
-	prevlocal = open(prevfile, O_RDONLY);
+	prevlocal = open(prevfile, O_BINARY | O_RDONLY);
 	if (prevlocal != -1) {
 		do {
 			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
@@ -403,7 +403,7 @@ static int fetch_index(struct alt_base *repo, unsigned char *sha1)
 
 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
+	indexfile = fopen(tmpfile, "ab");
 	if (!indexfile)
 		return error("Unable to open local file %s for pack index",
 			     filename);
@@ -763,7 +763,7 @@ static int fetch_pack(struct alt_base *repo, unsigned char *sha1)
 
 	filename = sha1_pack_name(target->sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	packfile = fopen(tmpfile, "a");
+	packfile = fopen(tmpfile, "ab");
 	if (!packfile)
 		return error("Unable to open local file %s for pack",
 			     filename);
diff --git a/http-push.c b/http-push.c
index 7c3720f..921960f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -286,7 +286,7 @@ static void start_fetch_loose(struct transfer_request *request)
 
 	/* If a previous temp file is present, process what was already
 	   fetched. */
-	prevlocal = open(prevfile, O_RDONLY);
+	prevlocal = open(prevfile, O_BINARY | O_RDONLY);
 	if (prevlocal != -1) {
 		do {
 			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
@@ -430,7 +430,7 @@ static void start_fetch_packed(struct transfer_request *request)
 		check_request = check_request->next;
 	}
 
-	packfile = fopen(request->tmpfile, "a");
+	packfile = fopen(request->tmpfile, "ab");
 	if (!packfile) {
 		fprintf(stderr, "Unable to open local file %s for pack",
 			filename);
@@ -949,7 +949,7 @@ static int fetch_index(unsigned char *sha1)
 
 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
+	indexfile = fopen(tmpfile, "ab");
 	if (!indexfile)
 		return error("Unable to open local file %s for pack index",
 			     filename);
diff --git a/imap-send.c b/imap-send.c
index a5a0696..1aab483 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -386,7 +386,7 @@ arc4_init( void )
 	int i, fd;
 	unsigned char j, si, dat[128];
 
-	if ((fd = open( "/dev/urandom", O_RDONLY )) < 0 && (fd = open( "/dev/random", O_RDONLY )) < 0) {
+	if ((fd = open( "/dev/urandom", O_RDONLY )) < 0 && (fd = open( "/dev/random", O_BINARY | O_RDONLY )) < 0) {
 		fprintf( stderr, "Fatal: no random number source available.\n" );
 		exit( 3 );
 	}
diff --git a/index-pack.c b/index-pack.c
index 8403c36..f6e65a4 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -117,12 +117,12 @@ static const char *open_pack_file(const char *pack_name)
 			output_fd = mkstemp(tmpfile);
 			pack_name = xstrdup(tmpfile);
 		} else
-			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
+			output_fd = open(pack_name, O_CREAT|O_EXCL|O_BINARY | O_RDWR, 0600);
 		if (output_fd < 0)
 			die("unable to create %s: %s\n", pack_name, strerror(errno));
 		pack_fd = output_fd;
 	} else {
-		input_fd = open(pack_name, O_RDONLY);
+		input_fd = open(pack_name, O_BINARY | O_RDONLY);
 		if (input_fd < 0)
 			die("cannot open packfile '%s': %s",
 			    pack_name, strerror(errno));
@@ -625,7 +625,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				 get_object_directory(), sha1_to_hex(sha1));
 			keep_name = name;
 		}
-		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_BINARY | O_EXCL, 0600);
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
 				die("cannot write keep file");
diff --git a/local-fetch.c b/local-fetch.c
index bf7ec6c..deac558 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -85,13 +85,13 @@ static int copy_file(const char *source, char *dest, const char *hex,
 	if (use_filecopy) {
 		int ifd, ofd, status = 0;
 
-		ifd = open(source, O_RDONLY);
+		ifd = open(source, O_BINARY | O_RDONLY);
 		if (ifd < 0) {
 			if (!warn_if_not_exists && errno == ENOENT)
 				return -1;
 			return error("cannot open %s", source);
 		}
-		ofd = open(dest, O_WRONLY | O_CREAT | O_EXCL, 0666);
+		ofd = open(dest, O_WRONLY | O_CREAT | O_BINARY | O_EXCL, 0666);
 		if (ofd < 0) {
 			close(ifd);
 			return error("cannot open %s", dest);
@@ -173,7 +173,7 @@ int fetch_ref(char *ref, unsigned char *sha1)
 		ref_name_start = strlen(filename);
 	}
 	strcpy(filename + ref_name_start, ref);
-	ifd = open(filename, O_RDONLY);
+	ifd = open(filename, O_BINARY | O_RDONLY);
 	if (ifd < 0) {
 		close(ifd);
 		return error("cannot open %s", filename);
diff --git a/lockfile.c b/lockfile.c
index 9a1f64d..680c2fd 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -130,7 +130,7 @@ static int lock_file(struct lock_file *lk, const char *path)
 	 */
 	resolve_symlink(lk->filename, sizeof(lk->filename)-5);
 	strcat(lk->filename, ".lock");
-	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
+	fd = open(lk->filename, O_RDWR | O_CREAT | O_BINARY | O_EXCL, 0666);
 	if (0 <= fd) {
 		if (!lock_file_list) {
 			signal(SIGINT, remove_lock_file_on_signal);
diff --git a/mailmap.c b/mailmap.c
index 8714167..685dd9d 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -5,7 +5,7 @@
 int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev)
 {
 	char buffer[1024];
-	FILE *f = fopen(filename, "r");
+	FILE *f = fopen(filename, "rb");
 
 	if (f == NULL)
 		return 1;
diff --git a/merge-recursive.c b/merge-recursive.c
index c8539ec..2d44d89 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -590,7 +590,7 @@ static void update_file_flags(const unsigned char *sha,
 				mode = 0777;
 			else
 				mode = 0666;
-			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+			fd = open(path, O_WRONLY | O_TRUNC | O_BINARY | O_CREAT, mode);
 			if (fd < 0)
 				die("failed to open %s: %s", path, strerror(errno));
 			flush_buffer(fd, buf, size);
@@ -831,7 +831,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 		; /* failure in run-command */
 	else
 		status = -status;
-	fd = open(temp[1], O_RDONLY);
+	fd = open(temp[1], O_BINARY | O_RDONLY);
 	if (fd < 0)
 		goto bad;
 	if (fstat(fd, &st))
diff --git a/pack-write.c b/pack-write.c
index 1cf5f7c..9abbd33 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -49,7 +49,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		index_name = xstrdup(tmpfile);
 	} else {
 		unlink(index_name);
-		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+		fd = open(index_name, O_CREAT|O_EXCL|O_BINARY | O_WRONLY, 0600);
 	}
 	if (fd < 0)
 		die("unable to create %s: %s", index_name, strerror(errno));
diff --git a/path.c b/path.c
index 4260952..7707729 100644
--- a/path.c
+++ b/path.c
@@ -6,7 +6,7 @@
  * It's obviously not thread-safe. Sue me. But it's quite
  * useful for doing things like
  *
- *   f = open(mkpath("%s/%s.git", base, name), O_RDONLY);
+ *   f = open(mkpath("%s/%s.git", base, name), O_BINARY | O_RDONLY);
  *
  * which is what it's designed for.
  */
@@ -107,7 +107,7 @@ int validate_headref(const char *path)
 	/*
 	 * Anything else, just open it and try to see if it is a symbolic ref.
 	 */
-	fd = open(path, O_RDONLY);
+	fd = open(path, O_BINARY | O_RDONLY);
 	if (fd < 0)
 		return -1;
 	len = read_in_full(fd, buffer, sizeof(buffer)-1);
diff --git a/read-cache.c b/read-cache.c
index e060392..659b1ef 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -48,7 +48,7 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
-	int fd = open(ce->name, O_RDONLY);
+	int fd = open(ce->name, O_BINARY | O_RDONLY);
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
@@ -894,7 +894,7 @@ int read_index_from(struct index_state *istate, const char *path)
 
 	errno = ENOENT;
 	istate->timestamp = 0;
-	fd = open(path, O_RDONLY);
+	fd = open(path, O_BINARY | O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT)
 			return 0;
diff --git a/refs.c b/refs.c
index fac6548..5d1937f 100644
--- a/refs.c
+++ b/refs.c
@@ -216,7 +216,7 @@ static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 static struct ref_list *get_packed_refs(void)
 {
 	if (!cached_refs.did_packed) {
-		FILE *f = fopen(git_path("packed-refs"), "r");
+		FILE *f = fopen(git_path("packed-refs"), "rb");
 		cached_refs.packed = NULL;
 		if (f) {
 			read_packed_refs(f, &cached_refs);
@@ -293,7 +293,7 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 	int retval;
 
 	strcpy(name + pathlen, "packed-refs");
-	f = fopen(name, "r");
+	f = fopen(name, "rb");
 	if (!f)
 		return -1;
 	read_packed_refs(f, &refs);
@@ -320,7 +320,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen, const char *re
 	if (recursion > MAXDEPTH || len > MAXREFLEN)
 		return -1;
 	memcpy(name + pathlen, refname, len+1);
-	fd = open(name, O_RDONLY);
+	fd = open(name, O_BINARY | O_RDONLY);
 	if (fd < 0)
 		return resolve_gitlink_packed_ref(name, pathlen, refname, result);
 
@@ -429,7 +429,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		 * Anything else, just open it and try to use it as
 		 * a ref
 		 */
-		fd = open(path, O_RDONLY);
+		fd = open(path, O_BINARY | O_RDONLY);
 		if (fd < 0)
 			return NULL;
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
@@ -1209,7 +1209,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 		goto error_free_return;
 	}
 	lockpath = mkpath("%s.lock", git_HEAD);
-	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	fd = open(lockpath, O_CREAT | O_EXCL | O_BINARY | O_WRONLY, 0666);
 	if (fd < 0) {
 		error("Unable to open %s for writing", lockpath);
 		goto error_free_return;
@@ -1268,7 +1268,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	size_t mapsz;
 
 	logfile = git_path("logs/%s", ref);
-	logfd = open(logfile, O_RDONLY, 0);
+	logfd = open(logfile, O_BINARY | O_RDONLY, 0);
 	if (logfd < 0)
 		die("Unable to read log %s: %s", logfile, strerror(errno));
 	fstat(logfd, &st);
@@ -1366,7 +1366,7 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 	int ret = 0;
 
 	logfile = git_path("logs/%s", ref);
-	logfp = fopen(logfile, "r");
+	logfp = fopen(logfile, "rb");
 	if (!logfp)
 		return -1;
 	while (fgets(buf, sizeof(buf), logfp)) {
diff --git a/remote.c b/remote.c
index bb774d0..f7c1644 100644
--- a/remote.c
+++ b/remote.c
@@ -69,7 +69,7 @@ static struct remote *make_remote(const char *name, int len)
 
 static void read_remotes_file(struct remote *remote)
 {
-	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
+	FILE *f = fopen(git_path("remotes/%s", remote->name), "rb");
 
 	if (!f)
 		return;
@@ -117,7 +117,7 @@ static void read_branches_file(struct remote *remote)
 {
 	const char *slash = strchr(remote->name, '/');
 	int n = slash ? slash - remote->name : 1000;
-	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
+	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "rb");
 	char *s, *p;
 	int len;
 
diff --git a/run-command.c b/run-command.c
index 7e779d3..72c47d3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -10,7 +10,7 @@ static inline void close_pair(int fd[2])
 
 static inline void dup_devnull(int to)
 {
-	int fd = open("/dev/null", O_RDWR);
+	int fd = open("/dev/null", O_BINARY | O_RDWR);
 	dup2(fd, to);
 	close(fd);
 }
diff --git a/server-info.c b/server-info.c
index 0d1312c..a096025 100644
--- a/server-info.c
+++ b/server-info.c
@@ -33,7 +33,7 @@ static int update_info_refs(int force)
 	strcpy(path1 + len, "+");
 
 	safe_create_leading_directories(path0);
-	info_ref_fp = fopen(path1, "w");
+	info_ref_fp = fopen(path1, "wb");
 	if (!info_ref_fp)
 		return error("unable to update %s", path0);
 	for_each_ref(add_info_ref, NULL);
@@ -95,7 +95,7 @@ static int read_pack_info_file(const char *infofile)
 	char line[1000];
 	int old_cnt = 0;
 
-	fp = fopen(infofile, "r");
+	fp = fopen(infofile, "rb");
 	if (!fp)
 		return 1; /* nonexistent is not an error. */
 
@@ -223,7 +223,7 @@ static int update_info_packs(int force)
 	init_pack_info(infofile, force);
 
 	safe_create_leading_directories(name);
-	fp = fopen(name, "w");
+	fp = fopen(name, "wb");
 	if (!fp)
 		return error("cannot open %s", name);
 	write_pack_info_file(fp);
diff --git a/sha1_file.c b/sha1_file.c
index aca741b..9866aa9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -360,7 +360,7 @@ static void read_info_alternates(const char * relative_base, int depth)
 	int fd;
 
 	sprintf(path, "%s/%s", relative_base, alt_file_name);
-	fd = open(path, O_RDONLY);
+	fd = open(path, O_BINARY | O_RDONLY);
 	if (fd < 0)
 		return;
 	if (fstat(fd, &st) || (st.st_size == 0)) {
@@ -444,7 +444,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = open(path, O_RDONLY);
+	int fd = open(path, O_BINARY | O_RDONLY);
 	struct stat st;
 
 	if (fd < 0)
@@ -631,7 +631,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
 
-	p->pack_fd = open(p->pack_name, O_RDONLY);
+	p->pack_fd = open(p->pack_name, O_BINARY | O_RDONLY);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 
@@ -983,12 +983,12 @@ static void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 		return NULL;
 	}
 
-	fd = open(filename, O_RDONLY | sha1_file_open_flag);
+	fd = open(filename, O_BINARY | O_RDONLY | sha1_file_open_flag);
 	if (fd < 0) {
 		/* See if it works without O_NOATIME */
 		switch (sha1_file_open_flag) {
 		default:
-			fd = open(filename, O_RDONLY);
+			fd = open(filename, O_BINARY | O_RDONLY);
 			if (fd >= 0)
 				break;
 		/* Fallthrough */
@@ -2059,7 +2059,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 		hashcpy(returnsha1, sha1);
 	if (has_sha1_file(sha1))
 		return 0;
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_BINARY | O_RDONLY);
 	if (fd >= 0) {
 		/*
 		 * FIXME!!! We might do collision checking here, but we'd
@@ -2412,7 +2412,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
-		fd = open(path, O_RDONLY);
+		fd = open(path, O_BINARY | O_RDONLY);
 		if (fd < 0)
 			return error("open(\"%s\"): %s", path,
 				     strerror(errno));
diff --git a/shallow.c b/shallow.c
index dbd9f5a..b31020b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -25,7 +25,7 @@ int is_repository_shallow(void)
 	if (is_shallow >= 0)
 		return is_shallow;
 
-	fp = fopen(git_path("shallow"), "r");
+	fp = fopen(git_path("shallow"), "rb");
 	if (!fp) {
 		is_shallow = 0;
 		return is_shallow;
diff --git a/test-delta.c b/test-delta.c
index 3d885ff..53011a4 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -27,7 +27,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	fd = open(argv[2], O_RDONLY);
+	fd = open(argv[2], O_BINARY | O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[2]);
 		return 1;
@@ -41,7 +41,7 @@ int main(int argc, char *argv[])
 	}
 	close(fd);
 
-	fd = open(argv[3], O_RDONLY);
+	fd = open(argv[3], O_BINARY | O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[3]);
 		return 1;
@@ -68,7 +68,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
+	fd = open (argv[4], O_WRONLY|O_CREAT|O_BINARY | O_TRUNC, 0666);
 	if (fd < 0 || write_in_full(fd, out_buf, out_size) != out_size) {
 		perror(argv[4]);
 		return 1;
diff --git a/trace.c b/trace.c
index 7961a27..b8c6a44 100644
--- a/trace.c
+++ b/trace.c
@@ -65,7 +65,7 @@ static int get_trace_fd(int *need_close)
 	if (strlen(trace) == 1 && isdigit(*trace))
 		return atoi(trace);
 	if (*trace == '/') {
-		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
+		int fd = open(trace, O_WRONLY | O_APPEND | O_BINARY | O_CREAT, 0666);
 		if (fd == -1) {
 			fprintf(stderr,
 				"Could not open '%s' for tracing: %s\n"
-- 
1.5.1.2
