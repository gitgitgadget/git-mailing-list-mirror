From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] make git-merge-one-file a builtin
Date: Wed, 24 Jan 2007 02:17:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701240214210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 24 02:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Wm1-0007sd-Hu
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965606AbXAXBR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933100AbXAXBR6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:17:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:51245 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933095AbXAXBR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:17:57 -0500
Received: (qmail invoked by alias); 24 Jan 2007 01:17:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 24 Jan 2007 02:17:55 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37587>


While at it, fix the bug that made git-merge-one-file fail when
there is no 'base', but the two-way merge succeeds.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	The plan is, of course, to get rid of the fork() altogether,
	calling merge_one_file() from merge-index directly.

	But not today. I'll go to bed now.

 Makefile                  |    3 +-
 builtin-merge-one-file.c  |   49 +++++++++++++++
 builtin.h                 |    1 +
 cache.h                   |    3 +
 git-merge-one-file.sh     |  134 ----------------------------------------
 git.c                     |    1 +
 merge-file.c              |  149 ++++++++++++++++++++++++++++++++++++++++++++-
 merge-tree.c              |    4 +-
 t/t6025-merge-one-file.sh |    4 +-
 9 files changed, 207 insertions(+), 141 deletions(-)
 create mode 100644 builtin-merge-one-file.c
 delete mode 100755 git-merge-one-file.sh

diff --git a/Makefile b/Makefile
index b5c7336..759564f 100644
--- a/Makefile
+++ b/Makefile
@@ -173,7 +173,7 @@ SCRIPT_SH = \
 	git-clean.sh git-clone.sh git-commit.sh \
 	git-fetch.sh git-gc.sh \
 	git-ls-remote.sh \
-	git-merge-one-file.sh git-parse-remote.sh \
+	git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-resolve.sh git-revert.sh git-sh-setup.sh \
@@ -295,6 +295,7 @@ BUILTIN_OBJS = \
 	builtin-mailsplit.o \
 	builtin-merge-base.o \
 	builtin-merge-file.o \
+	builtin-merge-one-file.o \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
diff --git a/builtin-merge-one-file.c b/builtin-merge-one-file.c
new file mode 100644
index 0000000..5f74c6b
--- /dev/null
+++ b/builtin-merge-one-file.c
@@ -0,0 +1,49 @@
+#include "cache.h"
+
+static const char merge_one_file_usage[] =
+"git-merge-one-file <orig-sha1> <our-sha1> <their-sha1> <path> <orig-mode> <our-mode> <their-mode>";
+
+int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
+{
+	struct lock_file *lock_file;
+	unsigned char buffers[3][20], *hashes[3];
+	unsigned int modes[3];
+	int i, newfd;
+
+	if (argc != 8)
+		usage(merge_one_file_usage);
+
+
+	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
+	lock_file = xcalloc(1, sizeof(struct lock_file));
+
+	newfd = hold_lock_file_for_update(lock_file, get_index_file(), 1);
+
+	if (read_cache() < 0)
+		die("cache corrupted");
+
+	for (i = 0; i < 3; i++) {
+		char *p;
+		hashes[i] = buffers[i];
+		if (!*argv[i + 1] || *argv[i + 1])
+			hashes[i] = NULL;
+		else if (get_sha1_hex(argv[i + 1], buffers[i]))
+			return error("invalid hash: %s\n", argv[i + 1]);
+		modes[i] = strtoul(argv[i + 5], &p, 0);
+		if (p && *p)
+			return error("invalid mode: %s\n", argv[i + 5]);
+	}
+
+	i = merge_one_file(hashes[0], hashes[1], hashes[2], argv[4],
+		modes[0], modes[1], modes[2]);
+
+	if (i >= 0 && active_cache_changed) {
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    close(newfd) || commit_lock_file(lock_file))
+			die("Unable to write new index file");
+	}
+
+	rollback_lock_file(lock_file);
+
+	return i ? 1 : 0;
+}
diff --git a/builtin.h b/builtin.h
index 818c7bf..4be6846 100644
--- a/builtin.h
+++ b/builtin.h
@@ -45,6 +45,7 @@ extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/cache.h b/cache.h
index 64ea1dc..da5ba8c 100644
--- a/cache.h
+++ b/cache.h
@@ -469,4 +469,7 @@ extern int nfvasprintf(char **str, const char *fmt, va_list va);
 extern void trace_printf(const char *format, ...);
 extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
 
+/* merge-file.c */
+extern int merge_one_file(const unsigned char *, const unsigned char *, const unsigned char *, const char *, unsigned int, unsigned int, unsigned int);
+
 #endif /* CACHE_H */
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
deleted file mode 100755
index bc7c5ef..0000000
--- a/git-merge-one-file.sh
+++ /dev/null
@@ -1,134 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) Linus Torvalds, 2005
-#
-# This is the git per-file merge script, called with
-#
-#   $1 - original file SHA1 (or empty)
-#   $2 - file in branch1 SHA1 (or empty)
-#   $3 - file in branch2 SHA1 (or empty)
-#   $4 - pathname in repository
-#   $5 - original file mode (or empty)
-#   $6 - file in branch1 mode (or empty)
-#   $7 - file in branch2 mode (or empty)
-#
-# Handle some trivial cases.. The _really_ trivial cases have
-# been handled already by git-read-tree, but that one doesn't
-# do any merges that might change the tree layout.
-
-case "${1:-.}${2:-.}${3:-.}" in
-#
-# Deleted in both or deleted in one and unchanged in the other
-#
-"$1.." | "$1.$1" | "$1$1.")
-	if [ "$2" ]; then
-		echo "Removing $4"
-	else
-		# read-tree checked that index matches HEAD already,
-		# so we know we do not have this path tracked.
-		# there may be an unrelated working tree file here,
-		# which we should just leave unmolested.
-		exit 0
-	fi
-	if test -f "$4"; then
-		rm -f -- "$4" &&
-		rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
-	fi &&
-		exec git-update-index --remove -- "$4"
-	;;
-
-#
-# Added in one.
-#
-".$2.")
-	# the other side did not add and we added so there is nothing
-	# to be done.
-	;;
-"..$3")
-	echo "Adding $4"
-	test -f "$4" || {
-		echo "ERROR: untracked $4 is overwritten by the merge."
-		exit 1
-	}
-	git-update-index --add --cacheinfo "$6$7" "$2$3" "$4" &&
-		exec git-checkout-index -u -f -- "$4"
-	;;
-
-#
-# Added in both, identically (check for same permissions).
-#
-".$3$2")
-	if [ "$6" != "$7" ]; then
-		echo "ERROR: File $4 added identically in both branches,"
-		echo "ERROR: but permissions conflict $6->$7."
-		exit 1
-	fi
-	echo "Adding $4"
-	git-update-index --add --cacheinfo "$6" "$2" "$4" &&
-		exec git-checkout-index -u -f -- "$4"
-	;;
-
-#
-# Modified in both, but differently.
-#
-"$1$2$3" | ".$2$3")
-
-	case ",$6,$7," in
-	*,120000,*)
-		echo "ERROR: $4: Not merging symbolic link changes."
-		exit 1
-		;;
-	esac
-
-	src2=`git-unpack-file $3`
-	case "$1" in
-	'')
-		echo "Added $4 in both, but differently."
-		# This extracts OUR file in $orig, and uses git-apply to
-		# remove lines that are unique to ours.
-		orig=`git-unpack-file $2`
-		sz0=`wc -c <"$orig" | tr -dc 0-9`
-		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add 
-		sz1=`wc -c <"$orig" | tr -dc 0-9`
-
-		# If we do not have enough common material, it is not
-		# worth trying two-file merge using common subsections.
-		expr "$sz0" \< "$sz1" \* 2 >/dev/null || : >$orig
-		;;
-	*)
-		echo "Auto-merging $4"
-		orig=`git-unpack-file $1`
-		;;
-	esac
-
-	# Be careful for funny filename such as "-L" in "$4", which
-	# would confuse "merge" greatly.
-	src1=`git-unpack-file $2`
-	git-merge-file "$src1" "$orig" "$src2"
-	ret=$?
-
-	# Create the working tree file, using "our tree" version from the
-	# index, and then store the result of the merge.
-	git-checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4"
-	rm -f -- "$orig" "$src1" "$src2"
-
-	if [ "$6" != "$7" ]; then
-		echo "ERROR: Permissions conflict: $5->$6,$7."
-		ret=1
-	fi
-	if [ "$1" = '' ]; then
-		ret=1
-	fi
-
-	if [ $ret -ne 0 ]; then
-		echo "ERROR: Merge conflict in $4"
-		exit 1
-	fi
-	exec git-update-index -- "$4"
-	;;
-
-*)
-	echo "ERROR: $4: Not handling case $1 -> $2 -> $3"
-	;;
-esac
-exit 1
diff --git a/git.c b/git.c
index 5133a07..1ea2c5b 100644
--- a/git.c
+++ b/git.c
@@ -251,6 +251,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
+		{ "merge-one-file", cmd_merge_one_file },
 		{ "mv", cmd_mv, RUN_SETUP | NOT_BARE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
diff --git a/merge-file.c b/merge-file.c
index 69dc1eb..ba54c96 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -24,7 +24,7 @@ static void free_mmfile(mmfile_t *f)
 	free(f->ptr);
 }
 
-static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
+static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size, int *result)
 {
 	mmbuffer_t res;
 	xpparam_t xpp;
@@ -34,6 +34,9 @@ static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their,
 	merge_status = xdl_merge(base, our, ".our", their, ".their",
 		&xpp, XDL_MERGE_ZEALOUS, &res);
 
+	if (result)
+		*result = merge_status;
+
 	if (merge_status < 0)
 		return NULL;
 
@@ -73,7 +76,7 @@ static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
 	return xdl_diff(f1, f2, &xpp, &xecfg, &ecb);
 }
 
-void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsigned long *size, int *return_code)
 {
 	void *res = NULL;
 	mmfile_t f1, f2, common;
@@ -106,7 +109,7 @@ void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsign
 		if (generate_common_file(&common, &f1, &f2) < 0)
 			goto out_free_f2_f1;
 	}
-	res = three_way_filemerge(&common, &f1, &f2, size);
+	res = three_way_filemerge(&common, &f1, &f2, size, return_code);
 	free_mmfile(&common);
 out_free_f2_f1:
 	free_mmfile(&f2);
@@ -115,3 +118,143 @@ out_free_f1:
 out_no_mmfile:
 	return res;
 }
+
+int remove_from_index(const char *path)
+{
+	int pos = cache_name_pos(path, strlen(path));
+	if (pos < 0) {
+		pos = -1 - pos;
+		if (pos >= active_nr || strcmp(path, active_cache[pos]->name))
+			return error("%s not in index", path);
+	}
+	while (pos < active_nr) {
+		if (strcmp(active_cache[pos]->name, path))
+			break;
+		remove_cache_entry_at(pos);
+	}
+	return 0;
+}
+
+int update_file(const char *path, void *buffer, unsigned long size,
+		int mode, int update_index)
+{
+	if (update_index && remove_from_index(path))
+		return -1;
+
+	if (S_ISLNK(mode)) {
+		char *target = buffer;
+		target[size] = '\0';
+		if (symlink(target, path))
+			return error("Could not create symlink %s", path);
+	} else {
+		int fd = open(path, O_WRONLY | O_CREAT, mode);
+		if (!fd)
+			return error("Could not open %s\n", path);
+		if (size != write_in_full(fd, buffer, size))
+			return error("Could not write %s\n", path);
+		if (close(fd))
+			return error("Could not close %s\n", path);
+	}
+	if (update_index)
+		return add_file_to_index(path, 0);
+	return 0;
+}
+
+int write_file_from_sha1(const char *path, const unsigned char *sha1, int mode)
+{
+	unsigned long size;
+	unsigned char type[20];
+	void *buffer = read_sha1_file(sha1, type, &size);
+	int ret = buffer ? update_file(path, buffer, size, mode, 1) : 0;
+
+	free(buffer);
+	return ret;
+}
+
+/*
+ * Handle some trivial cases.. The _really_ trivial cases have
+ * been handled already by git-read-tree, but that one doesn't
+ * do any merges that might change the tree layout.
+ */
+int merge_one_file(const unsigned char *orig_sha1,
+		const unsigned char *our_sha1,
+		const unsigned char *their_sha1,
+		const char *path,
+		unsigned int orig_mode,
+		unsigned int our_mode,
+		unsigned int their_mode)
+{
+	int ret = -1;
+	struct stat st;
+
+	/* Deleted in both or deleted in one and unchanged in the other */
+	if (orig_sha1 && (!our_sha1 || !hashcmp(orig_sha1, our_sha1)) &&
+			(!their_sha1 || !hashcmp(orig_sha1, their_sha1))) {
+		if (our_sha1)
+			printf("Removing %s\n", path);
+		else
+			/*
+			 * read-tree checked that index matches HEAD already,
+			 * so we know we do not have this path tracked.
+			 * there may be an unrelated working tree file here,
+			 * which we should just leave unmolested.
+			 */
+			return 0;
+		if (!lstat(path, &st)) {
+			if (remove_from_index(path))
+				return -1;
+			if (remove_path_recursively(path) < 0)
+				die("Error removing %s: %s\n",
+						path, strerror(errno));
+		}
+		return 0;
+	}
+	if (!orig_sha1) {
+		/* Added in one */
+		if (our_sha1 && !their_sha1)
+			return 0;
+		else if (their_sha1 && (!our_sha1 ||
+					!hashcmp(our_sha1, their_sha1))) {
+			if (!our_sha1 && !lstat(path, &st))
+				return error("Untracked %s is overwritten by "
+						"the merge", path);
+			if (our_sha1 && our_mode != their_mode)
+				return error("File %s added in both branches,\n"
+					"but permissions conflict 0%o->0%o",
+					path, our_mode, their_mode);
+			return write_file_from_sha1(path,
+					their_sha1, their_mode);
+		}
+	}
+	if (our_sha1 && their_sha1) {
+		struct object *base = NULL, *our, *their;
+		void *result;
+		unsigned long size;
+
+		if (S_ISLNK(our_mode) || S_ISLNK(their_mode))
+			return error("%s: not merging symbolic link changes.",
+				path);
+		if (!(our = parse_object(our_sha1)))
+			return error("Could not read %s\n",
+					sha1_to_hex(our_sha1));
+		if (!(their = parse_object(their_sha1)))
+			return error("Could not read %s\n",
+					sha1_to_hex(their_sha1));
+		if (orig_sha1 && !(base = parse_object(orig_sha1)))
+			return error("Could not read %s\n",
+					sha1_to_hex(orig_sha1));
+
+		result = merge_file((struct blob *)base, (struct blob *)our,
+				(struct blob *)their, &size, &ret);
+		if (result)
+			ret |= update_file(path, result, size, our_mode, !ret);
+		if (ret)
+			return error("%s: merge failure", path);
+		return 0;
+	}
+
+	return error("Unhandled case: %s->%s,%s\n",
+			sha1_to_hex(orig_sha1 ? orig_sha1 : null_sha1),
+			sha1_to_hex(our_sha1 ? our_sha1 : null_sha1),
+			sha1_to_hex(their_sha1 ? their_sha1 : null_sha1));
+}
diff --git a/merge-tree.c b/merge-tree.c
index 692ede0..2a52a56 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -53,7 +53,7 @@ static const char *explanation(struct merge_list *entry)
 	return "removed in remote";
 }
 
-extern void *merge_file(struct blob *, struct blob *, struct blob *, unsigned long *);
+extern void *merge_file(struct blob *, struct blob *, struct blob *, unsigned long *, int *);
 
 static void *result(struct merge_list *entry, unsigned long *size)
 {
@@ -75,7 +75,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	their = NULL;
 	if (entry)
 		their = entry->blob;
-	return merge_file(base, our, their, size);
+	return merge_file(base, our, their, size, NULL);
 }
 
 static void *origin(struct merge_list *entry, unsigned long *size)
diff --git a/t/t6025-merge-one-file.sh b/t/t6025-merge-one-file.sh
index 2eadcb3..6b79202 100644
--- a/t/t6025-merge-one-file.sh
+++ b/t/t6025-merge-one-file.sh
@@ -67,7 +67,9 @@ git-update-index --index-info << EOF
 10644 $hash_13 3	two
 EOF
 
-test_expect_failure "created non-identically, but mergeable" \
+# the old git-merge-one-file script used to fail here, too, even
+# if the merge succeeded.
+test_expect_success "created non-identically, but mergeable" \
 	"git-merge-one-file '' $hash_one $hash_13 two '' 0644 0644"
 
 test_expect_success "-> correct file" "diff -u thirteen two"
-- 
1.5.0.rc2.gc5868-dirty
