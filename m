From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] built-in diff.
Date: Sat, 29 Apr 2006 00:19:28 -0700
Message-ID: <7virosalxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 29 09:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZjjw-0001as-Mw
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 09:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWD2HTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 03:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWD2HTa
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 03:19:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44541 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750918AbWD2HT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 03:19:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060429071929.TIHF4388.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Apr 2006 03:19:29 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19295>

This starts to replace the shell script version of "git diff".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Should apply on top of "next" with trivial conflict fixups
   (hint: "git am -3").

   It is not fully compatible with the shell script version yet,
   so it is called "git diffn" for now.  It does not do the
   fancy option defaulting, other than "git diffn --cached" to
   mean "git diffn --cached HEAD", and I do not think I got the
   defaulting to --cc right either.  Also it does not default to
   do -M either.  If somebody cares deeply, patches are welcome.
   When its option defaulting gets compatible with the shell
   script version, or when its new default options becomes
   accepted, we will rename it to "git diff" and merge it in.

   To ask for the diff-raw output, you can give --raw option.

 Makefile       |    2 
 builtin-diff.c |  332 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h      |    1 
 git.c          |    1 
 4 files changed, 335 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8ce27a6..277c1ac 100644
--- a/Makefile
+++ b/Makefile
@@ -214,7 +214,7 @@ LIB_OBJS = \
 	$(DIFF_OBJS)
 
 BUILTIN_OBJS = \
-	builtin-log.o builtin-help.o
+	builtin-log.o builtin-help.o builtin-diff.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-diff.c b/builtin-diff.c
new file mode 100644
index 0000000..1968212
--- /dev/null
+++ b/builtin-diff.c
@@ -0,0 +1,332 @@
+/*
+ * Builtin "git diff"
+ *
+ * Copyright (c) 2006 Junio C Hamano
+ */
+#include "cache.h"
+#include "commit.h"
+#include "blob.h"
+#include "tag.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "log-tree.h"
+#include "builtin.h"
+
+/* NEEDSWORK: struct object has place for name but we _do_
+ * know mode when we extracted the blob out of a tree, which
+ * we currently lose.
+ */
+struct blobinfo {
+	unsigned char sha1[20];
+	const char *name;
+};
+
+static const char builtin_diff_usage[] =
+"diff <options> <rev>{0,2} -- <path>*";
+
+static int builtin_diff_files(struct rev_info *revs,
+			      int argc, const char **argv)
+{
+	int silent = 0;
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "--base"))
+			revs->max_count = 1;
+		else if (!strcmp(arg, "--ours"))
+			revs->max_count = 2;
+		else if (!strcmp(arg, "--theirs"))
+			revs->max_count = 3;
+		else if (!strcmp(arg, "-q"))
+			silent = 1;
+		else if (!strcmp(arg, "--raw"))
+			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+		else
+			usage(builtin_diff_usage);
+		argv++; argc--;
+	}
+	/*
+	 * Make sure there are NO revision (i.e. pending object) parameter,
+	 * rev.max_count is reasonable (0 <= n <= 3),
+	 * there is no other revision filtering parameters.
+	 */
+	if (revs->pending_objects ||
+	    revs->min_age != -1 ||
+	    revs->max_age != -1)
+		usage(builtin_diff_usage);
+	/*
+	 * Backward compatibility wart - "diff-files -s" used to
+	 * defeat the common diff option "-s" which asked for
+	 * DIFF_FORMAT_NO_OUTPUT.
+	 */
+	if (revs->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
+		revs->diffopt.output_format = DIFF_FORMAT_RAW;
+	return run_diff_files(revs, silent);
+}
+
+static void stuff_change(struct diff_options *opt,
+			 unsigned old_mode, unsigned new_mode,
+			 const unsigned char *old_sha1,
+			 const unsigned char *new_sha1,
+			 const char *old_name,
+			 const char *new_name)
+{
+	struct diff_filespec *one, *two;
+
+	if (memcmp(null_sha1, old_sha1, 20) &&
+	    memcmp(null_sha1, new_sha1, 20) &&
+	    !memcmp(old_sha1, new_sha1, 20))
+		return;
+
+	if (opt->reverse_diff) {
+		unsigned tmp;
+		const
+			const unsigned char *tmp_u;
+		const char *tmp_c;
+		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
+		tmp_u = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_u;
+		tmp_c = old_name; old_name = new_name; new_name = tmp_c;
+	}
+	one = alloc_filespec(old_name);
+	two = alloc_filespec(new_name);
+	fill_filespec(one, old_sha1, old_mode);
+	fill_filespec(two, new_sha1, new_mode);
+
+	/* NEEDSWORK: shouldn't this part of diffopt??? */
+	diff_queue(&diff_queued_diff, one, two);
+}
+
+static int builtin_diff_b_f(struct rev_info *revs,
+			    int argc, const char **argv,
+			    struct blobinfo *blob,
+			    const char *path)
+{
+	/* Blob vs file in the working tree*/
+	struct stat st;
+
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "--raw"))
+			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+		else
+			usage(builtin_diff_usage);
+		argv++; argc--;
+	}
+	if (lstat(path, &st))
+		die("'%s': %s", path, strerror(errno));
+	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
+		die("'%s': not a regular file or symlink", path);
+	stuff_change(&revs->diffopt,
+		     canon_mode(st.st_mode), canon_mode(st.st_mode),
+		     blob[0].sha1, null_sha1,
+		     blob[0].name, path);
+	diffcore_std(&revs->diffopt);
+	diff_flush(&revs->diffopt);
+	return 0;
+}
+
+static int builtin_diff_blobs(struct rev_info *revs,
+			      int argc, const char **argv,
+			      struct blobinfo *blob)
+{
+	/* Blobs */
+	unsigned mode = canon_mode(S_IFREG | 0644);
+
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "--raw"))
+			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+		else
+			usage(builtin_diff_usage);
+		argv++; argc--;
+	}
+	stuff_change(&revs->diffopt,
+		     mode, mode,
+		     blob[0].sha1, blob[1].sha1,
+		     blob[1].name, blob[1].name);
+	diffcore_std(&revs->diffopt);
+	diff_flush(&revs->diffopt);
+	return 0;
+}
+
+static int builtin_diff_index(struct rev_info *revs,
+			      int argc, const char **argv)
+{
+	int cached = 0;
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "--cached"))
+			cached = 1;
+		else if (!strcmp(arg, "--raw"))
+			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+		else
+			usage(builtin_diff_usage);
+		argv++; argc--;
+	}
+	/*
+	 * Make sure there is one revision (i.e. pending object),
+	 * and there is no revision filtering parameters.
+	 */
+	if (!revs->pending_objects || revs->pending_objects->next ||
+	    revs->max_count != -1 || revs->min_age != -1 ||
+	    revs->max_age != -1)
+		usage(builtin_diff_usage);
+	return run_diff_index(revs, cached);
+}
+
+static int builtin_diff_tree(struct rev_info *revs,
+			     int argc, const char **argv,
+			     struct object_list *ent)
+{
+	/* We saw two trees, ent[0] and ent[1].
+	 * unless ent[0] is unintesting, they are swapped
+	 */
+	const unsigned char *(sha1[2]);
+	int swap = 1;
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "--raw"))
+			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+		else
+			usage(builtin_diff_usage);
+		argv++; argc--;
+	}
+	if (ent[0].item->flags & UNINTERESTING)
+		swap = 0;
+	sha1[swap] = ent[0].item->sha1;
+	sha1[1-swap] = ent[1].item->sha1;
+	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
+	log_tree_diff_flush(revs);
+	return 0;
+}
+
+static void add_head(struct rev_info *revs)
+{
+	unsigned char sha1[20];
+	struct object *obj;
+	if (get_sha1("HEAD", sha1))
+		return;
+	obj = parse_object(sha1);
+	if (!obj)
+		return;
+	add_object(obj, &revs->pending_objects, NULL, "HEAD");
+}
+
+int cmd_diff(int argc, const char **argv, char **envp)
+{
+	struct rev_info rev;
+	struct object_list *list, ent[2];
+	int ents = 0, blobs = 0, paths = 0;
+	const char *path = NULL;
+	struct blobinfo blob[2];
+
+	/*
+	 * We could get N tree-ish in the rev.pending_objects list.
+	 * Also there could be M blobs there, and P pathspecs.
+	 *
+	 * N=0, M=0:
+	 *	cache vs files (diff-files)
+	 * N=0, M=2:
+	 *      compare two random blobs.  P must be zero.
+	 * N=0, M=1, P=1:
+	 *	compare a blob with a working tree file.
+	 *
+	 * N=1, M=0:
+	 *      tree vs cache (diff-index --cached)
+	 *
+	 * N=2, M=0:
+	 *      tree vs tree (diff-tree)
+	 *
+	 * Other cases are errors.
+	 */
+	
+	git_config(git_diff_config);
+	init_revisions(&rev);
+	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	/* Do we have --cached and not have a pending object, then
+	 * default to HEAD by hand.  Eek.
+	 */
+	if (!rev.pending_objects) {
+		int i;
+		for (i = 1; i < argc; i++) {
+			const char *arg = argv[i];
+			if (!strcmp(arg, "--"))
+				break;
+			else if (!strcmp(arg, "--cached")) {
+				add_head(&rev);
+				break;
+			}
+		}
+	}
+
+	for (list = rev.pending_objects; list; list = list->next) {
+		struct object *obj = list->item;
+		const char *name = list->name;
+		int flags = (obj->flags & UNINTERESTING);
+		if (!obj->parsed)
+			obj = parse_object(obj->sha1);
+		obj = deref_tag(obj, NULL, 0);
+		if (!obj)
+			die("invalid object '%s' given.", name);
+		if (!strcmp(obj->type, commit_type))
+			obj = &((struct commit *)obj)->tree->object;
+		if (!strcmp(obj->type, tree_type)) {
+			if (2 <= ents)
+				die("more than two trees given: '%s'", name);
+			obj->flags |= flags;
+			ent[ents].item = obj;
+			ent[ents].name = name;
+			ents++;
+			continue;
+		}
+		if (!strcmp(obj->type, blob_type)) {
+			if (2 <= blobs)
+				die("more than two blobs given: '%s'", name);
+			memcpy(blob[blobs].sha1, obj->sha1, 20);
+			blob[blobs].name = name;
+			blobs++;
+			continue;
+			
+		}
+		die("unhandled object '%s' given.", name);
+	}
+	if (rev.prune_data) {
+		const char **pathspec = rev.prune_data;
+		while (*pathspec) {
+			if (!path)
+				path = *pathspec;
+			paths++;
+			pathspec++;
+		}
+	}
+
+	/*
+	 * Now, do the arguments look reasonable?
+	 */
+	if (!ents) {
+		switch (blobs) {
+		case 0:
+			return builtin_diff_files(&rev, argc, argv);
+			break;
+		case 1:
+			if (paths != 1)
+				usage(builtin_diff_usage);
+			return builtin_diff_b_f(&rev, argc, argv, blob, path);
+			break;
+		case 2:
+			return builtin_diff_blobs(&rev, argc, argv, blob);
+			break;
+		default:
+			usage(builtin_diff_usage);
+		}
+	}
+	else if (blobs)
+		usage(builtin_diff_usage);
+	else if (ents == 1)
+		return builtin_diff_index(&rev, argc, argv);
+	else if (ents == 2)
+		return builtin_diff_tree(&rev, argc, argv, ent);
+	usage(builtin_diff_usage);
+}
diff --git a/builtin.h b/builtin.h
index 47408a0..52ffa52 100644
--- a/builtin.h
+++ b/builtin.h
@@ -19,5 +19,6 @@ extern int cmd_version(int argc, const c
 extern int cmd_whatchanged(int argc, const char **argv, char **envp);
 extern int cmd_show(int argc, const char **argv, char **envp);
 extern int cmd_log(int argc, const char **argv, char **envp);
+extern int cmd_diff(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 01b7e28..ff9b87a 100644
--- a/git.c
+++ b/git.c
@@ -46,6 +46,7 @@ static void handle_internal_command(int 
 		{ "log", cmd_log },
 		{ "whatchanged", cmd_whatchanged },
 		{ "show", cmd_show },
+		{ "diffn", cmd_diff },
 	};
 	int i;
 
-- 
1.3.1.g1d19
