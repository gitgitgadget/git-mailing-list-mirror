From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Diff-tree-helper take two.
Date: Tue, 26 Apr 2005 00:57:30 -0700
Message-ID: <7vfyxeotqt.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
	<7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
	<7vll76ouk0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:54:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQKsm-00025i-TJ
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 09:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDZH6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 03:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVDZH6U
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 03:58:20 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40937 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261170AbVDZH5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 03:57:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426075730.GHFQ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 03:57:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll76ouk0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 00:39:59 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch reworks the diff-tree-helper and show-diff to further
make external diff command interface simpler.  These commands
now honor GIT_EXTERNAL_DIFF environment variable which can point
at an arbitrary program that takes 7 parameters:

  name file1 file1-sha1 file1-mode file2 file2-sha1 file2-mode

The parameters for an external diff command are as follows:

  name        this invocation of the command is to emit diff
	      for the named cache/tree entry.

  file1       pathname that holds the contents of the first
	      file.  This can be a file inside the working
	      tree, or a temporary file created from the blob
	      object, or /dev/null.  The command should not
	      attempt to unlink it -- the temporary is
	      unlinked by the caller.

  file1-sha1  sha1 hash if file1 is a blob object, or "."
	      otherwise.

  file1-mode  mode bits for file1, or "." for a deleted file.

If GIT_EXTERNAL_DIFF environment variable is not set, the
default is to invoke diff with the set of parameters old
show-diff used to use.  This built-in implementation honors the
GIT_DIFF_CMD and GIT_DIFF_OPTS environment variables as before.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree-helper.c       |  242 +++++++-------------------------------------
diff.c                   |  254 ++++++++++++++++++++++++++++++++++++++---------
diff.h                   |   34 ++++--
jit-external-diff-script |   14 ++
show-diff.c              |   17 ---
5 files changed, 288 insertions(+), 273 deletions(-)

--- k/diff-tree-helper.c
+++ l/diff-tree-helper.c
@@ -1,3 +1,6 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
 #include "cache.h"
 #include "strbuf.h"
 #include "diff.h"
@@ -17,15 +20,22 @@ static int matches_pathspec(const char *
 	return 0;
 }
 
-static int parse_oneside_change(const char *cp, unsigned char *sha1,
-				char *path) {
+static int parse_oneside_change(const char *cp, struct diff_spec *one,
+				char *path)
+{
 	int ch;
-	while ((ch = *cp) && '0' <= ch && ch <= '7')
-		cp++; /* skip mode bits */
+
+	one->file_valid = one->sha1_valid = 1;
+	one->mode = 0;
+	while ((ch = *cp) && '0' <= ch && ch <= '7') {
+		one->mode = (one->mode << 3) | (ch - '0');
+		cp++;
+	}
+
 	if (strncmp(cp, "\tblob\t", 6))
 		return -1;
 	cp += 6;
-	if (get_sha1_hex(cp, sha1))
+	if (get_sha1_hex(cp, one->u.sha1))
 		return -1;
 	cp += 40;
 	if (*cp++ != '\t')
@@ -34,31 +44,20 @@ static int parse_oneside_change(const ch
 	return 0;
 }
 
-#define STATUS_CACHED    0 /* cached and sha1 valid */
-#define STATUS_ABSENT    1 /* diff-tree says old removed or new added */
-#define STATUS_UNCACHED  2 /* diff-cache output: read from working tree */
-
 static int parse_diff_tree_output(const char *buf,
-				  unsigned char *old_sha1,
-				  int *old_status,
-				  unsigned char *new_sha1,
-				  int *new_status,
+				  struct diff_spec *old,
+				  struct diff_spec *new,
 				  char *path) {
 	const char *cp = buf;
 	int ch;
-	static unsigned char null_sha[20] = { 0, };
 
 	switch (*cp++) {
 	case '+':
-		*old_status = STATUS_ABSENT;
-		*new_status = (memcmp(new_sha1, null_sha, sizeof(null_sha)) ?
-			       STATUS_CACHED : STATUS_UNCACHED);
-		return parse_oneside_change(cp, new_sha1, path);
+		old->file_valid = 0;
+		return parse_oneside_change(cp, new, path);
 	case '-':
-		*new_status = STATUS_ABSENT;
-		*old_status = (memcmp(old_sha1, null_sha, sizeof(null_sha)) ?
-			       STATUS_CACHED : STATUS_UNCACHED);
-		return parse_oneside_change(cp, old_sha1, path);
+		new->file_valid = 0;
+		return parse_oneside_change(cp, old, path);
 	case '*':
 		break;
 	default:
@@ -66,191 +65,36 @@ static int parse_diff_tree_output(const 
 	}
 	
 	/* This is for '*' entries */
-	while ((ch = *cp) && ('0' <= ch && ch <= '7'))
-		cp++; /* skip mode bits */
+	old->file_valid = old->sha1_valid = 1;
+	new->file_valid = new->sha1_valid = 1;
+
+	old->mode = new->mode = 0;
+	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+		old->mode = (old->mode << 3) | (ch - '0');
+		cp++;
+	}
 	if (strncmp(cp, "->", 2))
 		return -1;
 	cp += 2;
-	while ((ch = *cp) && ('0' <= ch && ch <= '7'))
-		cp++; /* skip mode bits */
+	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+		new->mode = (new->mode << 3) | (ch - '0');
+		cp++;
+	}
 	if (strncmp(cp, "\tblob\t", 6))
 		return -1;
 	cp += 6;
-	if (get_sha1_hex(cp, old_sha1))
+	if (get_sha1_hex(cp, old->u.sha1))
 		return -1;
 	cp += 40;
 	if (strncmp(cp, "->", 2))
 		return -1;
 	cp += 2;
-	if (get_sha1_hex(cp, new_sha1))
+	if (get_sha1_hex(cp, new->u.sha1))
 		return -1;
 	cp += 40;
 	if (*cp++ != '\t')
 		return -1;
 	strcpy(path, cp);
-	*old_status = (memcmp(old_sha1, null_sha, sizeof(null_sha)) ?
-		       STATUS_CACHED : STATUS_UNCACHED);
-	*new_status = (memcmp(new_sha1, null_sha, sizeof(null_sha)) ?
-		       STATUS_CACHED : STATUS_UNCACHED);
-	return 0;
-}
-
-static int sha1err(const char *path, const unsigned char *sha1)
-{
-	return error("diff-tree-helper: unable to read sha1 file of %s (%s)",
-		     path, sha1_to_hex(sha1));
-}
-
-static int fserr(const char *path)
-{
-	return error("diff-tree-helper: unable to read file %s", path);
-}
-
-static char *map_whole_file(const char *path, unsigned long *size) {
-	int fd;
-	struct stat st;
-	void *buf;
-
-	if ((fd = open(path, O_RDONLY)) < 0) {
-		error("diff-tree-helper: unable to read file %s", path);
-		return 0;
-	}
-	if (fstat(fd, &st) < 0) {
-		close(fd);
-		error("diff-tree-helper: unable to stat file %s", path);
-		return 0;
-	}
-	*size = st.st_size;
-	buf = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	close(fd);
-	return buf;
-}
-
-static int show_diff(const unsigned char *old_sha1, int old_status,
-		     const unsigned char *new_sha1, int new_status,
-		     const char *path, int reverse_diff)
-{
-	char other[PATH_MAX];
-	unsigned long size;
-	char type[20];
-	int fd;
-	int reverse;
-	void *blob = 0;
-	const char *fs = 0;
-	int need_unmap = 0;
-	int need_unlink = 0;
-
-
-	switch (old_status) {
-	case STATUS_CACHED:
-		blob = read_sha1_file(old_sha1, type, &size);
-		if (! blob)
-			return sha1err(path, old_sha1);
-			
-		switch (new_status) {
-		case STATUS_CACHED:
-			strcpy(other, ".diff_tree_helper_XXXXXX");
-			fd = mkstemp(other);
-			if (fd < 0)
-				die("unable to create temp-file");
-			if (write(fd, blob, size) != size)
-				die("unable to write temp-file");
-			close(fd);
-			free(blob);
-
-			blob = read_sha1_file(new_sha1, type, &size);
-			if (! blob)
-				return sha1err(path, new_sha1);
-
-			need_unlink = 1;
-			/* new = blob, old = fs */
-			reverse = !reverse_diff;
-			fs = other;
-			break;
-
-		case STATUS_ABSENT:
-		case STATUS_UNCACHED:
-			fs = ((new_status == STATUS_ABSENT) ?
-			      "/dev/null" : path);
-			reverse = reverse_diff;
-			break;
-
-		default:
- 			reverse = reverse_diff;
-		}
-		break;
-
-	case STATUS_ABSENT:
-		switch (new_status) {
-		case STATUS_CACHED:
-			blob = read_sha1_file(new_sha1, type, &size);
-			if (! blob)
-				return sha1err(path, new_sha1);
-			/* old = fs, new = blob */
-			fs = "/dev/null";
-			reverse = !reverse_diff;
-			break;
-
-		case STATUS_ABSENT:
-			return error("diff-tree-helper: absent from both old and new?");
-		case STATUS_UNCACHED:
-			fs = path;
-			blob = strdup("");
-			size = 0;
-			/* old = blob, new = fs */
-			reverse = reverse_diff;
-			break;
-		default:
-			reverse = reverse_diff;
-		}
-		break;
-
-	case STATUS_UNCACHED:
-		fs = path; /* old = fs, new = blob */
-		reverse = !reverse_diff;
-
-		switch (new_status) {
-		case STATUS_CACHED:
-			blob = read_sha1_file(new_sha1, type, &size);
-			if (! blob)
-				return sha1err(path, new_sha1);
-			break;
-
-		case STATUS_ABSENT:
-			blob = strdup("");
-			size = 0;
-			break;
-
-		case STATUS_UNCACHED:
-			/* old = fs */
-			blob = map_whole_file(path, &size);
-			if (! blob)
-				return fserr(path);
-			need_unmap = 1;
-			break;
-		default:
-			reverse = reverse_diff;
-		}
-		break;
-
-	default:
-		reverse = reverse_diff;
-	}
-	
-	if (fs)
-		show_differences(fs,
-				 path, /* label */
-				 blob,
-				 size,
-				 reverse /* 0: diff blob fs
-					    1: diff fs blob */);
-
-	if (need_unlink)
-		unlink(other);
-	if (need_unmap && blob)
-		munmap(blob, size);
-	else
-		free(blob);
 	return 0;
 }
 
@@ -275,28 +119,20 @@ int main(int ac, char **av) {
 	}
 	/* the remaining parameters are paths patterns */
 
-	prepare_diff_cmd();
-
 	while (1) {
-		int old_status, new_status;
-		unsigned char old_sha1[20], new_sha1[20];
+		struct diff_spec old, new;
 		char path[PATH_MAX];
 		read_line(&sb, stdin, line_termination);
 		if (sb.eof)
 			break;
-		if (parse_diff_tree_output(sb.buf,
-					   old_sha1, &old_status,
-					   new_sha1, &new_status,
-					   path)) {
+		if (parse_diff_tree_output(sb.buf, &old, &new, path)) { 
 			fprintf(stderr, "cannot parse %s\n", sb.buf);
 			continue;
 		}
-		if (1 < ac && ! matches_pathspec(path, av+1, ac-1))
+		if (1 < ac && !matches_pathspec(path, av+1, ac-1))
 			continue;
 
-		show_diff(old_sha1, old_status,
-			  new_sha1, new_status,
-			  path, reverse_diff);
+		run_external_diff(path, &old, &new);
 	}
 	return 0;
 }
--- k/diff.c
+++ l/diff.c
@@ -1,13 +1,22 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
+#include <sys/types.h>
+#include <sys/wait.h>
 #include "cache.h"
 #include "diff.h"
 
-static char *diff_cmd = "diff -L 'k/%s' -L 'l/%s' ";
-static char *diff_opts = "-p -u";
-static char *diff_arg_forward  = " - '%s'";
-static char *diff_arg_reverse  = " '%s' -";
+static char *diff_cmd = "diff -L'k/%s' -L'l/%s'";
+static char *diff_opts = "-pu";
 
-void prepare_diff_cmd(void)
+static const char *external_diff(void)
 {
+	static char *external_diff_cmd = NULL;
+	static int done_preparing = 0;
+
+	if (done_preparing)
+		return external_diff_cmd;
+
 	/*
 	 * Default values above are meant to match the
 	 * Linux kernel development style.  Examples of
@@ -17,8 +26,15 @@ void prepare_diff_cmd(void)
 	 * GIT_DIFF_CMD="diff -L '%s' -L '%s'"
 	 * GIT_DIFF_OPTS="-c";
 	 */
+	if (getenv("GIT_EXTERNAL_DIFF"))
+		external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
+
+	/* In case external diff fails... */
 	diff_cmd = getenv("GIT_DIFF_CMD") ? : diff_cmd;
 	diff_opts = getenv("GIT_DIFF_OPTS") ? : diff_opts;
+
+	done_preparing = 1;
+	return external_diff_cmd;
 }
 
 /* Help to copy the thing properly quoted for the shell safety.
@@ -58,49 +74,195 @@ static char *sq_expand(const char *src)
 	return buf;
 }
 
-void show_differences(const char *name, /* filename on the filesystem */
-		      const char *label, /* diff label to use */
-		      void *old_contents, /* contents in core */
-		      unsigned long long old_size, /* size in core */
-		      int reverse /* 0: diff core file
-				     1: diff file core */)
-{
-	FILE *f;
-	char *name_sq = sq_expand(name);
-	const char *label_sq = (name != label) ? sq_expand(label) : name_sq;
-	char *diff_arg = reverse ? diff_arg_reverse : diff_arg_forward;
-	int cmd_size = strlen(name_sq) + strlen(label_sq) * 2 +
-		strlen(diff_cmd) + strlen(diff_opts) + strlen(diff_arg);
+static struct diff_tempfile {
+	const char *name;
+	char hex[41];
+	char mode[10];
+	char tmp_path[50];
+} diff_temp[2];
+
+static void builtin_diff(const char *name,
+			 struct diff_tempfile *temp)
+{
+	static char *diff_arg  = "'%s' '%s'";
+	const char *name_1_sq = sq_expand(temp[0].name);
+	const char *name_2_sq = sq_expand(temp[1].name);
+	const char *name_sq = sq_expand(name);
+
+	/* diff_cmd and diff_arg have 4 %s in total which makes
+	 * the sum of these strings 8 bytes larger than required.
+	 * we use 2 spaces around diff-opts, and we need to count
+	 * terminating NUL, so we subtract 5 here.
+	 */
+	int cmd_size = (strlen(diff_cmd) + 
+			strlen(name_sq) * 2 +
+			strlen(diff_opts) +
+			strlen(diff_arg) +
+			strlen(name_1_sq) + strlen(name_2_sq)
+			- 5);
 	char *cmd = malloc(cmd_size);
-	int next_at;
+	int next_at = 0;
+
+	next_at += snprintf(cmd+next_at, cmd_size-next_at,
+			    diff_cmd, name_sq, name_sq);
+	next_at += snprintf(cmd+next_at, cmd_size-next_at,
+			    " %s ", diff_opts);
+	next_at += snprintf(cmd+next_at, cmd_size-next_at,
+			    diff_arg, name_1_sq, name_2_sq);
+	execlp("/bin/sh","sh", "-c", cmd, NULL);
+}
+
+static void prepare_temp_file(const char *name,
+			      struct diff_tempfile *temp,
+			      struct diff_spec *one)
+{
+	static unsigned char null_sha1[20] = { 0, };
 
-	fflush(stdout);
-	next_at = snprintf(cmd, cmd_size, diff_cmd, label_sq, label_sq);
-	next_at += snprintf(cmd+next_at, cmd_size-next_at, "%s", diff_opts);
-	next_at += snprintf(cmd+next_at, cmd_size-next_at, diff_arg, name_sq);
-	f = popen(cmd, "w");
-	if (old_size)
-		fwrite(old_contents, old_size, 1, f);
-	pclose(f);
-	if (label_sq != name_sq)
-		free((void*)label_sq); /* constness */
-	free(name_sq);
-	free(cmd);
-}
-
-void show_diff_empty(const unsigned char *sha1,
-		     const char *name,
-		     int reverse)
-{
-	char *old;
-	unsigned long int size;
-	unsigned char type[20];
-
-	old = read_sha1_file(sha1, type, &size);
-	if (! old) {
-		error("unable to read blob object for %s (%s)", name,
-		      sha1_to_hex(sha1));
+	if (!one->file_valid) {
+	not_a_valid_file:
+		temp->name = "/dev/null";
+		strcpy(temp->hex, ".");
+		strcpy(temp->mode, ".");
 		return;
 	}
-	show_differences("/dev/null", name, old, size, reverse);
+
+	if (one->sha1_valid &&
+	    !memcmp(one->u.sha1, null_sha1, sizeof(null_sha1))) {
+		one->sha1_valid = 0;
+		one->u.name = name;
+	}
+
+	if (!one->sha1_valid) {
+		struct stat st;
+		temp->name = one->u.name;
+		if (stat(temp->name, &st) < 0) {
+			if (errno == ENOENT)
+				goto not_a_valid_file;
+			die("stat(%s): %s", temp->name, strerror(errno));
+		}
+		strcpy(temp->hex, ".");
+		sprintf(temp->mode, "%06o",
+			S_IFREG |ce_permissions(st.st_mode));
+	}
+	else {
+		int fd;
+		void *blob;
+		char type[20];
+		unsigned long size;
+
+		blob = read_sha1_file(one->u.sha1, type, &size);
+		if (!blob || strcmp(type, "blob"))
+			die("unable to read blob object for %s (%s)",
+			    name, sha1_to_hex(one->u.sha1));
+
+		strcpy(temp->tmp_path, ".diff_XXXXXX");
+		fd = mkstemp(temp->tmp_path);
+		if (fd < 0)
+			die("unable to create temp-file");
+		if (write(fd, blob, size) != size)
+			die("unable to write temp-file");
+		close(fd);
+		free(blob);
+		temp->name = temp->tmp_path;
+		strcpy(temp->hex, sha1_to_hex(one->u.sha1));
+		temp->hex[40] = 0;
+		sprintf(temp->mode, "%06o", one->mode);
+	}
+}
+
+static void remove_tempfile(void)
+{
+	int i;
+
+	for (i = 0; i < 2; i++)
+		if (diff_temp[i].name == diff_temp[i].tmp_path) {
+			unlink(diff_temp[i].name);
+			diff_temp[i].name = NULL;
+		}
+}
+
+/* An external diff command takes:
+ *
+ * diff-cmd name infile1 infile1-sha1 infile1-mode \
+ *               infile2 infile2-sha1 infile2-mode.
+ *
+ */
+void run_external_diff(const char *name,
+		       struct diff_spec *one,
+		       struct diff_spec *two)
+{
+	struct diff_tempfile *temp = diff_temp;
+	int pid, status;
+	static int atexit_asked = 0;
+
+	prepare_temp_file(name, &temp[0], one);
+	prepare_temp_file(name, &temp[1], two);
+	if (! atexit_asked &&
+	    (temp[0].name == temp[0].tmp_path ||
+	     temp[1].name == temp[1].tmp_path)) {
+		atexit_asked = 1;
+		atexit(remove_tempfile);
+	}
+
+	fflush(NULL);
+	pid = fork();
+	if (pid < 0)
+		die("unable to fork");
+	if (!pid) {
+		const char *pgm = external_diff();
+		if (pgm)
+			execlp(pgm, pgm,
+			       name,
+			       temp[0].name, temp[0].hex, temp[0].mode,
+			       temp[1].name, temp[1].hex, temp[1].mode,
+			       NULL);
+		/*
+		 * otherwise we use the built-in one.
+		 */
+		builtin_diff(name, temp);
+		exit(0);
+	}
+	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status))
+		die("diff program failed");
+
+	remove_tempfile();
+}
+
+void show_diff_empty(const struct cache_entry *ce, int reverse)
+{
+	struct diff_spec spec[2], *one, *two;
+
+	memcpy(spec[0].u.sha1, ce->sha1, 20);
+	spec[0].mode = ntohl(ce->ce_mode);
+	spec[0].sha1_valid = spec[0].file_valid = 1;
+	spec[1].file_valid = 0;
+
+	if (reverse) {
+		one = spec + 1; two = spec;
+	} else {
+		one = spec; two = one + 1;
+	}
+
+	run_external_diff(ce->name, one, two);
+}
+
+void show_differences(const struct cache_entry *ce, int reverse) 
+{
+	struct diff_spec spec[2], *one, *two;
+
+	memcpy(spec[0].u.sha1, ce->sha1, 20);
+	spec[0].mode = ntohl(ce->ce_mode);
+	spec[0].sha1_valid = spec[0].file_valid = 1;
+
+	spec[1].u.name = ce->name; /* the name we stated */
+	spec[1].sha1_valid = 0;
+	spec[1].file_valid = 1;
+
+	if (reverse) {
+		one = spec + 1; two = spec;
+	} else {
+		one = spec; two = one + 1;
+	}
+
+	run_external_diff(ce->name, one, two);
 }
--- k/diff.h
+++ l/diff.h
@@ -1,17 +1,31 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
 #ifndef DIFF_H
 #define DIFF_H
 
-extern void prepare_diff_cmd(void);
+/* These two are for backward compatibility with show-diff;
+ * new users should not use them.
+ */
+extern void show_differences(const struct cache_entry *ce, int reverse);
+extern void show_diff_empty(const struct cache_entry *ce, int reverse);
 
-extern void show_differences(const char *name, /* filename on the filesystem */
-			     const char *label, /* diff label to use */
-			     void *old_contents, /* contents in core */
-			     unsigned long long old_size, /* size in core */
-			     int reverse /* 0: diff core file
-					    1: diff file core */);
+struct diff_spec {
+	union {
+		const char *name;       /* path on the filesystem */
+		unsigned char sha1[20]; /* blob object ID */
+	} u;
+	unsigned short mode;	 /* file mode */
+	unsigned sha1_valid : 1; /* if true, use u.sha1 and trust mode.
+				  * (however with a NULL SHA1, read them
+				  * from the file!).
+				  * if false, use u.name and read mode from
+				  * the filesystem.
+				  */
+	unsigned file_valid : 1; /* if false the file does not even exist */
+};
 
-extern void show_diff_empty(const unsigned char *sha1,
-			    const char *name,
-			    int reverse);
+extern void run_external_diff(const char *name,
+			      struct diff_spec *, struct diff_spec *);
 
 #endif /* DIFF_H */
--- k/jit-external-diff-script
+++ l/jit-external-diff-script
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Copyright (C) 2005 Junio C Hamano
+#
+
+name="$1" name1="$2" sha11="$3" mode1="$4"
+          name2="$5" sha12="$6" mode2="$7"
+
+case "$sha11" in .) sha11=file-not-in-blob-but-in-the-working-tree ;; esac
+case "$sha12" in .) sha12=file-not-in-blob-but-in-the-working-tree ;; esac
+case "$mode1" in .) mode1=;; *) mode1=" ($mode1)" ;;esac
+case "$mode2" in .) mode2=;; *) mode2=" ($mode2)" ;;esac
+
+diff -pu -L "$sha11/$name$mode1" -L "$sha12/$name$mode2" "$name1" "$name2"
--- k/show-diff.c
+++ l/show-diff.c
@@ -53,14 +53,11 @@ int main(int argc, char **argv)
 		perror("read_cache");
 		exit(1);
 	}
-	prepare_diff_cmd();
+
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		struct cache_entry *ce = active_cache[i];
 		int changed;
-		unsigned long size;
-		char type[20];
-		void *old;
 
 		if (1 < argc &&
 		    ! matches_pathspec(ce, argv+1, argc-1))
@@ -87,8 +84,7 @@ int main(int argc, char **argv)
 			else {
 				printf("%s: %s\n", ce->name, strerror(errno));
 				if (errno == ENOENT)
-					show_diff_empty(ce->sha1, ce->name,
-							reverse);
+					show_diff_empty(ce, reverse);
 			}
 			continue;
 		}
@@ -104,14 +100,7 @@ int main(int argc, char **argv)
 		if (silent)
 			continue;
 
-		old = read_sha1_file(ce->sha1, type, &size);
-		if (! old)
-			error("unable to read blob object for %s (%s)",
-			      ce->name, sha1_to_hex(ce->sha1));
-		else
-			show_differences(ce->name, ce->name, old, size,
-					 reverse);
-		free(old);
+		show_differences(ce, reverse);
 	}
 	return 0;
 }

