From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 02:21:01 -0700
Message-ID: <1176888062865-git-send-email-junkio@cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 11:21:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He6Lv-0007CC-TE
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 11:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbXDRJVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 05:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbXDRJVG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 05:21:06 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36550 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422712AbXDRJVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 05:21:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418092103.UAHU1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 18 Apr 2007 05:21:03 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oZM21W0041kojtg0000100; Wed, 18 Apr 2007 05:21:02 -0400
X-Mailer: git-send-email 1.5.1.1.901.g25ba
In-Reply-To: <11768880622402-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44876>

This allows users to specify custom low-level merge driver per
path, using the attributes mechanism.  Just like you can specify
one of built-in "text", "binary", "union" low-level merge
drivers by saying:

	*		merge=text
	.gitignore	merge=union
	*.jpg		merge=binary

pick a name of your favorite merge driver, and assign it as the
value of the 'merge' attribute.

A custom low-level merge driver is defined via the config
mechanism.  This patch introduces 'merge.driver', a multi-valued
configuration.  Its value is the name (i.e. the one you use as
the value of 'merge' attribute) followed by a command line
specification.  The command line can contain %O, %A, and %B to
be interpolated with the names of temporary files that hold the
common ancestor version, the version from your branch, and the
version from the other branch, and the resulting command is
spawned.

The low-level merge driver is expected to update the temporary
file for your branch (i.e. %A) with the result and exit with
status 0 for a clean merge, and non-zero status for a conflicted
merge.

A new test in t6026 demonstrates a sample usage.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-recursive.c     |  177 +++++++++++++++++++++++++++++++++++++++++++++----
 t/t6026-merge-attr.sh |   71 +++++++++++++++++++-
 2 files changed, 235 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3b34401..8ec18ad 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -15,6 +15,7 @@
 #include "unpack-trees.h"
 #include "path-list.h"
 #include "xdiff-interface.h"
+#include "interpolate.h"
 #include "attr.h"
 
 static int subtree_merge;
@@ -661,12 +662,14 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 }
 
 /* Low-level merge functions */
-typedef int (*ll_merge_fn)(mmfile_t *orig,
+typedef int (*ll_merge_fn)(const char *cmd,
+			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
 			   mmbuffer_t *result);
 
-static int ll_xdl_merge(mmfile_t *orig,
+static int ll_xdl_merge(const char *cmd__unused,
+			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
 			mmbuffer_t *result)
@@ -681,7 +684,8 @@ static int ll_xdl_merge(mmfile_t *orig,
 			 result);
 }
 
-static int ll_union_merge(mmfile_t *orig,
+static int ll_union_merge(const char *cmd__unused,
+			  mmfile_t *orig,
 			  mmfile_t *src1, const char *name1,
 			  mmfile_t *src2, const char *name2,
 			  mmbuffer_t *result)
@@ -690,7 +694,8 @@ static int ll_union_merge(mmfile_t *orig,
 	long size;
 	const int marker_size = 7;
 
-	int status = ll_xdl_merge(orig, src1, NULL, src2, NULL, result);
+	int status = ll_xdl_merge(cmd__unused, orig,
+				  src1, NULL, src2, NULL, result);
 	if (status <= 0)
 		return status;
 	size = result->size;
@@ -721,7 +726,8 @@ static int ll_union_merge(mmfile_t *orig,
 	return 0;
 }
 
-static int ll_binary_merge(mmfile_t *orig,
+static int ll_binary_merge(const char *cmd__unused,
+			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
 			   mmbuffer_t *result)
@@ -743,24 +749,169 @@ static struct {
 	const char *name;
 	ll_merge_fn fn;
 } ll_merge_fns[] = {
-	{ "text", ll_xdl_merge },
 	{ "binary", ll_binary_merge },
+	{ "text", ll_xdl_merge },
 	{ "union", ll_union_merge },
 	{ NULL, NULL },
 };
 
-static ll_merge_fn find_ll_merge_fn(void *merge_attr)
+static void create_temp(mmfile_t *src, char *path)
 {
+	int fd;
+
+	strcpy(path, ".merge_file_XXXXXX");
+	fd = mkstemp(path);
+	if (fd < 0)
+		die("unable to create temp-file");
+	if (write_in_full(fd, src->ptr, src->size) != src->size)
+		die("unable to write temp-file");
+	close(fd);
+}
+
+static int ll_ext_merge(const char *cmd,
+			mmfile_t *orig,
+			mmfile_t *src1, const char *name1,
+			mmfile_t *src2, const char *name2,
+			mmbuffer_t *result)
+{
+	char temp[3][50];
+	char cmdbuf[2048];
+	struct interp table[] = {
+		{ "%O" },
+		{ "%A" },
+		{ "%B" },
+	};
+	struct child_process child;
+	const char *args[20];
+	int status, fd, i;
+	struct stat st;
+
+	result->ptr = NULL;
+	result->size = 0;
+	create_temp(orig, temp[0]);
+	create_temp(src1, temp[1]);
+	create_temp(src2, temp[2]);
+
+	interp_set_entry(table, 0, temp[0]);
+	interp_set_entry(table, 1, temp[1]);
+	interp_set_entry(table, 2, temp[2]);
+
+	interpolate(cmdbuf, sizeof(cmdbuf), cmd, table, 3);
+
+	memset(&child, 0, sizeof(child));
+	child.argv = args;
+	args[0] = "sh";
+	args[1] = "-c";
+	args[2] = cmdbuf;
+	args[3] = NULL;
+
+	status = run_command(&child);
+	if (status < -ERR_RUN_COMMAND_FORK)
+		; /* failure in run-command */
+	else
+		status = -status;
+	fd = open(temp[1], O_RDONLY);
+	if (fd < 0)
+		goto bad;
+	if (fstat(fd, &st))
+		goto close_bad;
+	result->size = st.st_size;
+	result->ptr = xmalloc(result->size + 1);
+	if (read_in_full(fd, result->ptr, result->size) != result->size) {
+		free(result->ptr);
+		result->ptr = NULL;
+		result->size = 0;
+	}
+ close_bad:
+	close(fd);
+ bad:
+	for (i = 0; i < 3; i++)
+		unlink(temp[i]);
+	return status;
+}
+
+/*
+ * merge.default and merge.driver configuration items
+ */
+static struct user_merge_fn {
+	struct user_merge_fn *next;
+	const char *name;
+	char *cmdline;
+	char b_[1];
+} *ll_user_merge_fns, **ll_user_merge_fns_tail;
+
+static int read_merge_config(const char *var, const char *value)
+{
+	struct user_merge_fn *fn;
+	int blen, nlen;
+
+	if (strcmp(var, "merge.driver"))
+		return 0;
+	if (!value)
+		return error("%s: lacks value", var);
+	/*
+	 * merge.driver is a multi-valued configuration, whose value is
+	 * of form:
+	 *
+	 *	name command-line
+	 *
+	 * The command-line will be interpolated with the following
+	 * tokens and is given to the shell:
+	 *
+	 *    %O - temporary file name for the merge base.
+	 *    %A - temporary file name for our version.
+	 *    %B - temporary file name for the other branches' version.
+	 *
+	 * The external merge driver should write the results in the file
+	 * named by %A, and signal that it has done with exit status 0.
+	 */
+	for (nlen = -1, blen = 0; value[blen]; blen++)
+		if (nlen < 0 && isspace(value[blen]))
+			nlen = blen;
+	if (nlen < 0)
+		return error("%s '%s': lacks command line", var, value);
+	fn = xcalloc(1, sizeof(struct user_merge_fn) + blen + 1);
+	memcpy(fn->b_, value, blen + 1);
+	fn->name = fn->b_;
+	fn->b_[nlen] = 0;
+	fn->cmdline = fn->b_ + nlen + 1;
+	fn->next = *ll_user_merge_fns_tail;
+	*ll_user_merge_fns_tail = fn;
+	return 0;
+}
+
+static void initialize_ll_merge(void)
+{
+	if (ll_user_merge_fns_tail)
+		return;
+	ll_user_merge_fns_tail = &ll_user_merge_fns;
+	git_config(read_merge_config);
+}
+
+static ll_merge_fn find_ll_merge_fn(void *merge_attr, const char **cmdline)
+{
+	struct user_merge_fn *fn;
 	const char *name;
 	int i;
 
-	if (ATTR_TRUE(merge_attr) || ATTR_UNSET(merge_attr))
+	initialize_ll_merge();
+
+	if (ATTR_TRUE(merge_attr))
 		return ll_xdl_merge;
 	else if (ATTR_FALSE(merge_attr))
 		return ll_binary_merge;
+	else if (ATTR_UNSET(merge_attr))
+		return ll_xdl_merge;
+	else
+		name = merge_attr;
+
+	for (fn = ll_user_merge_fns; fn; fn = fn->next) {
+		if (!strcmp(fn->name, name)) {
+			*cmdline = fn->cmdline;
+			return ll_ext_merge;
+		}
+	}
 
-	/* Otherwise merge_attr may name the merge function */
-	name = merge_attr;
 	for (i = 0; ll_merge_fns[i].name; i++)
 		if (!strcmp(ll_merge_fns[i].name, name))
 			return ll_merge_fns[i].fn;
@@ -793,6 +944,7 @@ static int ll_merge(mmbuffer_t *result_buf,
 	int merge_status;
 	void *merge_attr;
 	ll_merge_fn fn;
+	const char *driver = NULL;
 
 	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
 	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
@@ -802,9 +954,10 @@ static int ll_merge(mmbuffer_t *result_buf,
 	fill_mm(b->sha1, &src2);
 
 	merge_attr = git_path_check_merge(a->path);
-	fn = find_ll_merge_fn(merge_attr);
+	fn = find_ll_merge_fn(merge_attr, &driver);
 
-	merge_status = fn(&orig, &src1, name1, &src2, name2, result_buf);
+	merge_status = fn(driver, &orig,
+			  &src1, name1, &src2, name2, result_buf);
 
 	free(name1);
 	free(name2);
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 5daa223..1732b60 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -30,8 +30,9 @@ test_expect_success setup '
 		echo Side >>$f && git add $f || break
 	done &&
 	test_tick &&
-	git commit -m Side
+	git commit -m Side &&
 
+	git tag anchor
 '
 
 test_expect_success merge '
@@ -69,4 +70,72 @@ test_expect_success 'check merge result in working tree' '
 
 '
 
+cat >./custom-merge <<\EOF
+#!/bin/sh
+
+orig="$1" ours="$2" theirs="$3" exit="$4"
+(
+	echo "orig is $orig"
+	echo "ours is $ours"
+	echo "theirs is $theirs"
+	echo "=== orig ==="
+	cat "$orig"
+	echo "=== ours ==="
+	cat "$ours"
+	echo "=== theirs ==="
+	cat "$theirs"
+) >"$ours+"
+cat "$ours+" >"$ours"
+rm -f "$ours+"
+exit "$exit"
+EOF
+chmod +x ./custom-merge
+
+test_expect_success 'custom merge backend' '
+
+	echo "* merge=union" >.gitattributes &&
+	echo "text merge=custom" >>.gitattributes &&
+
+	git reset --hard anchor &&
+	git config --replace-all \
+	merge.driver "custom ./custom-merge %O %A %B 0" &&
+
+	git merge master &&
+
+	cmp binary union &&
+	sed -e 1,3d text >check-1 &&
+	o=$(git-unpack-file master^:text) &&
+	a=$(git-unpack-file side^:text) &&
+	b=$(git-unpack-file master:text) &&
+	sh -c "./custom-merge $o $a $b 0" &&
+	sed -e 1,3d $a >check-2 &&
+	cmp check-1 check-2 &&
+	rm -f $o $a $b
+'
+
+test_expect_success 'custom merge backend' '
+
+	git reset --hard anchor &&
+	git config --replace-all \
+	merge.driver "custom ./custom-merge %O %A %B 1" &&
+
+	if git merge master
+	then
+		echo "Eh? should have conflicted"
+		false
+	else
+		echo "Ok, conflicted"
+	fi &&
+
+	cmp binary union &&
+	sed -e 1,3d text >check-1 &&
+	o=$(git-unpack-file master^:text) &&
+	a=$(git-unpack-file anchor:text) &&
+	b=$(git-unpack-file master:text) &&
+	sh -c "./custom-merge $o $a $b 0" &&
+	sed -e 1,3d $a >check-2 &&
+	cmp check-1 check-2 &&
+	rm -f $o $a $b
+'
+
 test_done
-- 
1.5.1.1.901.g25ba
