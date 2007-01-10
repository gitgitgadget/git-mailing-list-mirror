From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Make git-describe a builtin.
Date: Wed, 10 Jan 2007 06:36:36 -0500
Message-ID: <20070110113636.GB25251@spearce.org>
References: <de93279981338622182dd8f00e4686c6624697b6.1168428978.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 12:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4bl8-0000uE-A8
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 12:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbXAJLgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 06:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbXAJLgl
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 06:36:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53339 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964864AbXAJLgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 06:36:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4bkx-00044w-Jk; Wed, 10 Jan 2007 06:36:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F04BB20FBAE; Wed, 10 Jan 2007 06:36:36 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <de93279981338622182dd8f00e4686c6624697b6.1168428978.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36500>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile           |    3 +-
 builtin-describe.c |  176 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h          |    1 +
 describe.c         |  176 ----------------------------------------------------
 git.c              |    1 +
 5 files changed, 180 insertions(+), 177 deletions(-)

diff --git a/Makefile b/Makefile
index de746be..f648085 100644
--- a/Makefile
+++ b/Makefile
@@ -203,7 +203,7 @@ PROGRAMS = \
 	git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X \
 	git-pack-redundant$X git-var$X \
-	git-describe$X git-merge-tree$X git-imap-send$X \
+	git-merge-tree$X git-imap-send$X \
 	git-merge-recursive$X \
 	$(EXTRA_PROGRAMS)
 
@@ -274,6 +274,7 @@ BUILTIN_OBJS = \
 	builtin-check-ref-format.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
+	builtin-describe.o \
 	builtin-diff.o \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
diff --git a/builtin-describe.c b/builtin-describe.c
new file mode 100644
index 0000000..ad3b469
--- /dev/null
+++ b/builtin-describe.c
@@ -0,0 +1,176 @@
+#include "cache.h"
+#include "commit.h"
+#include "tag.h"
+#include "refs.h"
+#include "builtin.h"
+
+#define SEEN (1u << 0)
+
+static const char describe_usage[] =
+"git-describe [--all] [--tags] [--abbrev=<n>] <committish>*";
+
+static int all;	/* Default to annotated tags only */
+static int tags;	/* But allow any tags if --tags is specified */
+
+static int abbrev = DEFAULT_ABBREV;
+
+static int names, allocs;
+static struct commit_name {
+	const struct commit *commit;
+	int prio; /* annotated tag = 2, tag = 1, head = 0 */
+	char path[FLEX_ARRAY]; /* more */
+} **name_array = NULL;
+
+static struct commit_name *match(struct commit *cmit)
+{
+	int i = names;
+	struct commit_name **p = name_array;
+
+	while (i-- > 0) {
+		struct commit_name *n = *p++;
+		if (n->commit == cmit)
+			return n;
+	}
+	return NULL;
+}
+
+static void add_to_known_names(const char *path,
+			       const struct commit *commit,
+			       int prio)
+{
+	int idx;
+	int len = strlen(path)+1;
+	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
+
+	name->commit = commit;
+	name->prio = prio;
+	memcpy(name->path, path, len);
+	idx = names;
+	if (idx >= allocs) {
+		allocs = (idx + 50) * 3 / 2;
+		name_array = xrealloc(name_array, allocs*sizeof(*name_array));
+	}
+	name_array[idx] = name;
+	names = ++idx;
+}
+
+static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct object *object;
+	int prio;
+
+	if (!commit)
+		return 0;
+	object = parse_object(sha1);
+	/* If --all, then any refs are used.
+	 * If --tags, then any tags are used.
+	 * Otherwise only annotated tags are used.
+	 */
+	if (!strncmp(path, "refs/tags/", 10)) {
+		if (object->type == OBJ_TAG)
+			prio = 2;
+		else
+			prio = 1;
+	}
+	else
+		prio = 0;
+
+	if (!all) {
+		if (!prio)
+			return 0;
+		if (!tags && prio < 2)
+			return 0;
+	}
+	add_to_known_names(all ? path + 5 : path + 10, commit, prio);
+	return 0;
+}
+
+static int compare_names(const void *_a, const void *_b)
+{
+	struct commit_name *a = *(struct commit_name **)_a;
+	struct commit_name *b = *(struct commit_name **)_b;
+	unsigned long a_date = a->commit->date;
+	unsigned long b_date = b->commit->date;
+
+	if (a->prio != b->prio)
+		return b->prio - a->prio;
+	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
+}
+
+static void describe(const char *arg, int last_one)
+{
+	unsigned char sha1[20];
+	struct commit *cmit;
+	struct commit_list *list;
+	static int initialized = 0;
+	struct commit_name *n;
+
+	if (get_sha1(arg, sha1))
+		die("Not a valid object name %s", arg);
+	cmit = lookup_commit_reference(sha1);
+	if (!cmit)
+		die("%s is not a valid '%s' object", arg, commit_type);
+
+	if (!initialized) {
+		initialized = 1;
+		for_each_ref(get_name, NULL);
+		qsort(name_array, names, sizeof(*name_array), compare_names);
+	}
+
+	n = match(cmit);
+	if (n) {
+		printf("%s\n", n->path);
+		return;
+	}
+
+	list = NULL;
+	commit_list_insert(cmit, &list);
+	while (list) {
+		struct commit *c = pop_most_recent_commit(&list, SEEN);
+		n = match(c);
+		if (n) {
+			printf("%s-g%s\n", n->path,
+			       find_unique_abbrev(cmit->object.sha1, abbrev));
+			if (!last_one)
+				clear_commit_marks(cmit, SEEN);
+			return;
+		}
+	}
+	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+}
+
+int cmd_describe(int argc, const char **argv, const char *prefix)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (*arg != '-')
+			break;
+		else if (!strcmp(arg, "--all"))
+			all = 1;
+		else if (!strcmp(arg, "--tags"))
+			tags = 1;
+		else if (!strncmp(arg, "--abbrev=", 9)) {
+			abbrev = strtoul(arg + 9, NULL, 10);
+			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
+				abbrev = DEFAULT_ABBREV;
+		}
+		else
+			usage(describe_usage);
+	}
+
+	save_commit_buffer = 0;
+
+	if (argc <= i)
+		describe("HEAD", 1);
+	else
+		while (i < argc) {
+			describe(argv[i], (i == argc - 1));
+			i++;
+		}
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index ae32993..818c7bf 100644
--- a/builtin.h
+++ b/builtin.h
@@ -25,6 +25,7 @@ extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_describe(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
diff --git a/describe.c b/describe.c
deleted file mode 100644
index 3c2df03..0000000
--- a/describe.c
+++ /dev/null
@@ -1,176 +0,0 @@
-#include "cache.h"
-#include "commit.h"
-#include "tag.h"
-#include "refs.h"
-
-#define SEEN (1u << 0)
-
-static const char describe_usage[] =
-"git-describe [--all] [--tags] [--abbrev=<n>] <committish>*";
-
-static int all;	/* Default to annotated tags only */
-static int tags;	/* But allow any tags if --tags is specified */
-
-static int abbrev = DEFAULT_ABBREV;
-
-static int names, allocs;
-static struct commit_name {
-	const struct commit *commit;
-	int prio; /* annotated tag = 2, tag = 1, head = 0 */
-	char path[FLEX_ARRAY]; /* more */
-} **name_array = NULL;
-
-static struct commit_name *match(struct commit *cmit)
-{
-	int i = names;
-	struct commit_name **p = name_array;
-
-	while (i-- > 0) {
-		struct commit_name *n = *p++;
-		if (n->commit == cmit)
-			return n;
-	}
-	return NULL;
-}
-
-static void add_to_known_names(const char *path,
-			       const struct commit *commit,
-			       int prio)
-{
-	int idx;
-	int len = strlen(path)+1;
-	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
-
-	name->commit = commit;
-	name->prio = prio;
-	memcpy(name->path, path, len);
-	idx = names;
-	if (idx >= allocs) {
-		allocs = (idx + 50) * 3 / 2;
-		name_array = xrealloc(name_array, allocs*sizeof(*name_array));
-	}
-	name_array[idx] = name;
-	names = ++idx;
-}
-
-static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
-	struct object *object;
-	int prio;
-
-	if (!commit)
-		return 0;
-	object = parse_object(sha1);
-	/* If --all, then any refs are used.
-	 * If --tags, then any tags are used.
-	 * Otherwise only annotated tags are used.
-	 */
-	if (!strncmp(path, "refs/tags/", 10)) {
-		if (object->type == OBJ_TAG)
-			prio = 2;
-		else
-			prio = 1;
-	}
-	else
-		prio = 0;
-
-	if (!all) {
-		if (!prio)
-			return 0;
-		if (!tags && prio < 2)
-			return 0;
-	}
-	add_to_known_names(all ? path + 5 : path + 10, commit, prio);
-	return 0;
-}
-
-static int compare_names(const void *_a, const void *_b)
-{
-	struct commit_name *a = *(struct commit_name **)_a;
-	struct commit_name *b = *(struct commit_name **)_b;
-	unsigned long a_date = a->commit->date;
-	unsigned long b_date = b->commit->date;
-
-	if (a->prio != b->prio)
-		return b->prio - a->prio;
-	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
-}
-
-static void describe(const char *arg, int last_one)
-{
-	unsigned char sha1[20];
-	struct commit *cmit;
-	struct commit_list *list;
-	static int initialized = 0;
-	struct commit_name *n;
-
-	if (get_sha1(arg, sha1))
-		die("Not a valid object name %s", arg);
-	cmit = lookup_commit_reference(sha1);
-	if (!cmit)
-		die("%s is not a valid '%s' object", arg, commit_type);
-
-	if (!initialized) {
-		initialized = 1;
-		for_each_ref(get_name, NULL);
-		qsort(name_array, names, sizeof(*name_array), compare_names);
-	}
-
-	n = match(cmit);
-	if (n) {
-		printf("%s\n", n->path);
-		return;
-	}
-
-	list = NULL;
-	commit_list_insert(cmit, &list);
-	while (list) {
-		struct commit *c = pop_most_recent_commit(&list, SEEN);
-		n = match(c);
-		if (n) {
-			printf("%s-g%s\n", n->path,
-			       find_unique_abbrev(cmit->object.sha1, abbrev));
-			if (!last_one)
-				clear_commit_marks(cmit, SEEN);
-			return;
-		}
-	}
-	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
-}
-
-int main(int argc, char **argv)
-{
-	int i;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (*arg != '-')
-			break;
-		else if (!strcmp(arg, "--all"))
-			all = 1;
-		else if (!strcmp(arg, "--tags"))
-			tags = 1;
-		else if (!strncmp(arg, "--abbrev=", 9)) {
-			abbrev = strtoul(arg + 9, NULL, 10);
-			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
-				abbrev = DEFAULT_ABBREV;
-		}
-		else
-			usage(describe_usage);
-	}
-
-	setup_git_directory();
-	save_commit_buffer = 0;
-
-	if (argc <= i)
-		describe("HEAD", 1);
-	else
-		while (i < argc) {
-			describe(argv[i], (i == argc - 1));
-			i++;
-		}
-
-	return 0;
-}
diff --git a/git.c b/git.c
index e7bc79a..9a0185c 100644
--- a/git.c
+++ b/git.c
@@ -220,6 +220,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff, RUN_SETUP | USE_PAGER },
 		{ "diff-files", cmd_diff_files, RUN_SETUP },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
-- 
1.4.4.4.gf027-dirty
