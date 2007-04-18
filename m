From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Custom low-level merge driver: change the configuration scheme.
Date: Wed, 18 Apr 2007 11:28:36 -0700
Message-ID: <7vbqhlh6zv.fsf_-_@assigned-by-dhcp.cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0704181247410.12094@racer.site>
	<20070418153445.GC12888@admingilde.org>
	<alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:28:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeEtW-0007Ku-IP
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbXDRS2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbXDRS2j
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:28:39 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52104 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167AbXDRS2i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 14:28:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418182837.KDWQ1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 14:28:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oiUc1W00h1kojtg0000000; Wed, 18 Apr 2007 14:28:37 -0400
In-Reply-To: <alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 18 Apr 2007 09:16:31 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44925>

This changes the configuration syntax for defining a low-level
merge driver to be:

	[merge "<<drivername>>"]
		driver = "<<command line>>"
		name = "<<driver description>>"

which is much nicer to read and is extensible.  Credit goes to
Martin Waitz and Linus.

In addition, when we use an external low-level merge driver, it
is reported as an extra output from merge-recursive, using the
value of merge.<<drivername>.name variable.

The demonstration in t6026 has also been updated.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is on top of what I pushed out on 'pu' last night.  This
   being my git day, I am hoping I can push this out in 'next'
   today.

 merge-recursive.c     |  202 ++++++++++++++++++++++++++++++-------------------
 t/t6026-merge-attr.sh |    8 ++-
 2 files changed, 131 insertions(+), 79 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5983000..4af69d7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -661,14 +661,31 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 	mm->size = size;
 }
 
-/* Low-level merge functions */
-typedef int (*ll_merge_fn)(const char *cmd,
+/*
+ * Customizable low-level merge drivers support.
+ */
+
+struct ll_merge_driver;
+typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
+			   const char *path,
 			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
 			   mmbuffer_t *result);
 
-static int ll_xdl_merge(const char *cmd__unused,
+struct ll_merge_driver {
+	const char *name;
+	const char *description;
+	ll_merge_fn fn;
+	struct ll_merge_driver *next;
+	char *cmdline;
+};
+
+/*
+ * Built-in low-levels
+ */
+static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
+			const char *path_unused,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
@@ -684,7 +701,8 @@ static int ll_xdl_merge(const char *cmd__unused,
 			 result);
 }
 
-static int ll_union_merge(const char *cmd__unused,
+static int ll_union_merge(const struct ll_merge_driver *drv_unused,
+			  const char *path_unused,
 			  mmfile_t *orig,
 			  mmfile_t *src1, const char *name1,
 			  mmfile_t *src2, const char *name2,
@@ -694,8 +712,8 @@ static int ll_union_merge(const char *cmd__unused,
 	long size;
 	const int marker_size = 7;
 
-	int status = ll_xdl_merge(cmd__unused, orig,
-				  src1, NULL, src2, NULL, result);
+	int status = ll_xdl_merge(drv_unused, path_unused,
+				  orig, src1, NULL, src2, NULL, result);
 	if (status <= 0)
 		return status;
 	size = result->size;
@@ -726,7 +744,8 @@ static int ll_union_merge(const char *cmd__unused,
 	return 0;
 }
 
-static int ll_binary_merge(const char *cmd__unused,
+static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
+			   const char *path_unused,
 			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
@@ -745,14 +764,13 @@ static int ll_binary_merge(const char *cmd__unused,
 	return 1;
 }
 
-static struct {
-	const char *name;
-	ll_merge_fn fn;
-} ll_merge_fns[] = {
-	{ "binary", ll_binary_merge },
-	{ "text", ll_xdl_merge },
-	{ "union", ll_union_merge },
-	{ NULL, NULL },
+#define LL_BINARY_MERGE 0
+#define LL_TEXT_MERGE 1
+#define LL_UNION_MERGE 2
+static struct ll_merge_driver ll_merge_drv[] = {
+	{ "binary", "built-in binary merge", ll_binary_merge },
+	{ "text", "built-in 3-way text merge", ll_xdl_merge },
+	{ "union", "built-in union merge", ll_union_merge },
 };
 
 static void create_temp(mmfile_t *src, char *path)
@@ -768,7 +786,11 @@ static void create_temp(mmfile_t *src, char *path)
 	close(fd);
 }
 
-static int ll_ext_merge(const char *cmd,
+/*
+ * User defined low-level merge driver support.
+ */
+static int ll_ext_merge(const struct ll_merge_driver *fn,
+			const char *path,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
@@ -796,7 +818,10 @@ static int ll_ext_merge(const char *cmd,
 	interp_set_entry(table, 1, temp[1]);
 	interp_set_entry(table, 2, temp[2]);
 
-	interpolate(cmdbuf, sizeof(cmdbuf), cmd, table, 3);
+	output(1, "merging %s using %s", path,
+	       fn->description ? fn->description : fn->name);
+
+	interpolate(cmdbuf, sizeof(cmdbuf), fn->cmdline, table, 3);
 
 	memset(&child, 0, sizeof(child));
 	child.argv = args;
@@ -833,101 +858,124 @@ static int ll_ext_merge(const char *cmd,
 /*
  * merge.default and merge.driver configuration items
  */
-static struct user_merge_fn {
-	struct user_merge_fn *next;
-	const char *name;
-	char *cmdline;
-	char b_[1];
-} *ll_user_merge_fns, **ll_user_merge_fns_tail;
+static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
 static const char *default_ll_merge;
 
 static int read_merge_config(const char *var, const char *value)
 {
-	struct user_merge_fn *fn;
-	int blen, nlen;
+	struct ll_merge_driver *fn;
+	const char *ep, *name;
+	int namelen;
 
 	if (!strcmp(var, "merge.default")) {
-		default_ll_merge = strdup(value);
+		if (value)
+			default_ll_merge = strdup(value);
 		return 0;
 	}
 
-	if (strcmp(var, "merge.driver"))
+	/*
+	 * We are not interested in anything but "merge.<name>.variable";
+	 * especially, we do not want to look at variables such as
+	 * "merge.summary", "merge.tool", and "merge.verbosity".
+	 */
+	if (prefixcmp(var, "merge.") || (ep = strchr(var + 6, '.')) == NULL)
 		return 0;
-	if (!value)
-		return error("%s: lacks value", var);
+
 	/*
-	 * merge.driver is a multi-valued configuration, whose value is
-	 * of form:
-	 *
-	 *	name command-line
-	 *
-	 * The command-line will be interpolated with the following
-	 * tokens and is given to the shell:
-	 *
-	 *    %O - temporary file name for the merge base.
-	 *    %A - temporary file name for our version.
-	 *    %B - temporary file name for the other branches' version.
-	 *
-	 * The external merge driver should write the results in the file
-	 * named by %A, and signal that it has done with exit status 0.
+	 * Find existing one as we might be processing merge.<name>.var2
+	 * after seeing merge.<name>.var1.
 	 */
-	for (nlen = -1, blen = 0; value[blen]; blen++)
-		if (nlen < 0 && isspace(value[blen]))
-			nlen = blen;
-	if (nlen < 0)
-		return error("%s '%s': lacks command line", var, value);
-	fn = xcalloc(1, sizeof(struct user_merge_fn) + blen + 1);
-	memcpy(fn->b_, value, blen + 1);
-	fn->name = fn->b_;
-	fn->b_[nlen] = 0;
-	fn->cmdline = fn->b_ + nlen + 1;
-	fn->next = *ll_user_merge_fns_tail;
-	*ll_user_merge_fns_tail = fn;
+	name = var + 6;
+	namelen = ep - name;
+	for (fn = ll_user_merge; fn; fn = fn->next)
+		if (!strncmp(fn->name, name, namelen) && !fn->name[namelen])
+			break;
+	if (!fn) {
+		char *namebuf;
+		fn = xcalloc(1, sizeof(struct ll_merge_driver));
+		namebuf = xmalloc(namelen + 1);
+		memcpy(namebuf, name, namelen);
+		namebuf[namelen] = 0;
+		fn->name = namebuf;
+		fn->fn = ll_ext_merge;
+		fn->next = *ll_user_merge_tail;
+		*ll_user_merge_tail = fn;
+	}
+
+	ep++;
+
+	if (!strcmp("name", ep)) {
+		if (!value)
+			return error("%s: lacks value", var);
+		fn->description = strdup(value);
+		return 0;
+	}
+
+	if (!strcmp("driver", ep)) {
+		if (!value)
+			return error("%s: lacks value", var);
+		/*
+		 * merge.<name>.driver specifies the command line:
+		 *
+		 *	command-line
+		 *
+		 * The command-line will be interpolated with the following
+		 * tokens and is given to the shell:
+		 *
+		 *    %O - temporary file name for the merge base.
+		 *    %A - temporary file name for our version.
+		 *    %B - temporary file name for the other branches' version.
+		 *
+		 * The external merge driver should write the results in the
+		 * file named by %A, and signal that it has done with zero exit
+		 * status.
+		 */
+		fn->cmdline = strdup(value);
+		return 0;
+	}
+
 	return 0;
 }
 
 static void initialize_ll_merge(void)
 {
-	if (ll_user_merge_fns_tail)
+	if (ll_user_merge_tail)
 		return;
-	ll_user_merge_fns_tail = &ll_user_merge_fns;
+	ll_user_merge_tail = &ll_user_merge;
 	git_config(read_merge_config);
 }
 
-static ll_merge_fn find_ll_merge_fn(void *merge_attr, const char **cmdline)
+static const struct ll_merge_driver *find_ll_merge_driver(void *merge_attr)
 {
-	struct user_merge_fn *fn;
+	struct ll_merge_driver *fn;
 	const char *name;
 	int i;
 
 	initialize_ll_merge();
 
 	if (ATTR_TRUE(merge_attr))
-		return ll_xdl_merge;
+		return &ll_merge_drv[LL_TEXT_MERGE];
 	else if (ATTR_FALSE(merge_attr))
-		return ll_binary_merge;
+		return &ll_merge_drv[LL_BINARY_MERGE];
 	else if (ATTR_UNSET(merge_attr)) {
 		if (!default_ll_merge)
-			return ll_xdl_merge;
+			return &ll_merge_drv[LL_TEXT_MERGE];
 		else
 			name = default_ll_merge;
 	}
 	else
 		name = merge_attr;
 
-	for (fn = ll_user_merge_fns; fn; fn = fn->next) {
-		if (!strcmp(fn->name, name)) {
-			*cmdline = fn->cmdline;
-			return ll_ext_merge;
-		}
-	}
+	for (fn = ll_user_merge; fn; fn = fn->next)
+		if (!strcmp(fn->name, name))
+			return fn;
 
-	for (i = 0; ll_merge_fns[i].name; i++)
-		if (!strcmp(ll_merge_fns[i].name, name))
-			return ll_merge_fns[i].fn;
+	for (i = 0; i < ARRAY_SIZE(ll_merge_drv); i++)
+		if (!strcmp(ll_merge_drv[i].name, name))
+			return &ll_merge_drv[i];
 
 	/* default to the 3-way */
-	return ll_xdl_merge;
+	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
 static void *git_path_check_merge(const char *path)
@@ -953,8 +1001,7 @@ static int ll_merge(mmbuffer_t *result_buf,
 	char *name1, *name2;
 	int merge_status;
 	void *merge_attr;
-	ll_merge_fn fn;
-	const char *driver = NULL;
+	const struct ll_merge_driver *driver;
 
 	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
 	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
@@ -964,10 +1011,11 @@ static int ll_merge(mmbuffer_t *result_buf,
 	fill_mm(b->sha1, &src2);
 
 	merge_attr = git_path_check_merge(a->path);
-	fn = find_ll_merge_fn(merge_attr, &driver);
+	driver = find_ll_merge_driver(merge_attr);
 
-	merge_status = fn(driver, &orig,
-			  &src1, name1, &src2, name2, result_buf);
+	merge_status = driver->fn(driver, a->path,
+				  &orig, &src1, name1, &src2, name2,
+				  result_buf);
 
 	free(name1);
 	free(name2);
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 1732b60..56fc341 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -98,7 +98,9 @@ test_expect_success 'custom merge backend' '
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.driver "custom ./custom-merge %O %A %B 0" &&
+	merge.custom.driver "./custom-merge %O %A %B 0" &&
+	git config --replace-all \
+	merge.custom.name "custom merge driver for testing" &&
 
 	git merge master &&
 
@@ -117,7 +119,9 @@ test_expect_success 'custom merge backend' '
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.driver "custom ./custom-merge %O %A %B 1" &&
+	merge.custom.driver "./custom-merge %O %A %B 1" &&
+	git config --replace-all \
+	merge.custom.name "custom merge driver for testing" &&
 
 	if git merge master
 	then
-- 
1.5.1.1.901.g25ba
