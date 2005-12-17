From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff: --abbrev option
Date: Sat, 17 Dec 2005 01:41:49 -0800
Message-ID: <7v3bks12n6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 17 10:43:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnYZf-0004td-28
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 10:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVLQJlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 04:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVLQJlv
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 04:41:51 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:25242 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932296AbVLQJlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 04:41:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217094052.QTXX20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 04:40:52 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13778>

When I show transcripts to explain how something works, I often
find myself hand-editing the diff-raw output to shorten various
object names in the output.

This adds --abbrev option to the diff family, which shortens
diff-raw output and diff-tree commit id headers.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Earlier I announced that I have this toy in proposed updates
   without actually showing the code, so here it is.  I have
   added code to find unique abbreviation as well.  It is
   primarily useful to quote things in e-mail, like this:

      $ git-rev-parse master | git-diff-tree --pretty -r --abbrev --stdin
      diff-tree 01385e2... (from 6922471...)
      Author: Junio C Hamano <junkio@cox.net>
      Date:   Fri Dec 16 23:12:33 2005 -0800

          Comment fixes.

          Signed-off-by: Junio C Hamano <junkio@cox.net>

      :100755 100755 0266f46... b0e54ed... M	git-branch.sh
      :100755 100755 f241d4b... 36308d2... M	git-checkout.sh

 Documentation/diff-options.txt |    7 +++++
 diff-tree.c                    |   40 +++++++++++++++++-----------
 diff.c                         |   57 ++++++++++++++++++++++++++++++++++++----
 diff.h                         |    9 ++++++
 sha1_name.c                    |    3 ++
 5 files changed, 93 insertions(+), 23 deletions(-)

ea2d93b12d2deae007311d0898616b4bb2f299d2
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6b496ed..3d1175e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -18,6 +18,13 @@
 	object name of pre- and post-image blob on the "index"
 	line when generating a patch format output.	
 
+--abbrev::
+	Instead of showing the full 40-byte hexadecimal object
+	name in diff-raw format output and diff-tree header
+	lines, show only handful prefix.  This is independent of
+	--full-index option above, which controls the diff-patch
+	output format.
+
 -B::
 	Break complete rewrite changes into pairs of delete and create.
 
diff --git a/diff-tree.c b/diff-tree.c
index d56d921..efa2b94 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -14,11 +14,6 @@ static enum cmit_fmt commit_format = CMI
 
 static struct diff_options diff_options;
 
-static void call_diff_setup_done(void)
-{
-	diff_setup_done(&diff_options);
-}
-
 static int call_diff_flush(void)
 {
 	diffcore_std(&diff_options);
@@ -43,7 +38,6 @@ static int diff_tree_sha1_top(const unsi
 {
 	int ret;
 
-	call_diff_setup_done();
 	ret = diff_tree_sha1(old, new, base, &diff_options);
 	call_diff_flush();
 	return ret;
@@ -55,7 +49,6 @@ static int diff_root_tree(const unsigned
 	void *tree;
 	struct tree_desc empty, real;
 
-	call_diff_setup_done();
 	tree = read_object_with_reference(new, "tree", &real.size, NULL);
 	if (!tree)
 		die("unable to read root tree (%s)", sha1_to_hex(new));
@@ -69,18 +62,29 @@ static int diff_root_tree(const unsigned
 	return retval;
 }
 
-static const char *generate_header(const char *commit, const char *parent, const char *msg)
+static const char *generate_header(const unsigned char *commit_sha1,
+				   const unsigned char *parent_sha1,
+				   const char *msg)
 {
 	static char this_header[16384];
 	int offset;
 	unsigned long len;
+	int abbrev = diff_options.abbrev;
 
 	if (!verbose_header)
-		return commit;
+		return sha1_to_hex(commit_sha1);
 
 	len = strlen(msg);
-	offset = sprintf(this_header, "%s%s (from %s)\n", header_prefix, commit, parent);
-	offset += pretty_print_commit(commit_format, msg, len, this_header + offset, sizeof(this_header) - offset);
+
+	offset = sprintf(this_header, "%s%s ",
+			 header_prefix,
+			 diff_unique_abbrev(commit_sha1, abbrev));
+	offset += sprintf(this_header + offset, "(from %s)\n",
+			 parent_sha1 ?
+			 diff_unique_abbrev(parent_sha1, abbrev) : "root");
+	offset += pretty_print_commit(commit_format, msg, len,
+				      this_header + offset,
+				      sizeof(this_header) - offset);
 	return this_header;
 }
 
@@ -99,18 +103,18 @@ static int diff_tree_commit(const unsign
 	
 	/* Root commit? */
 	if (show_root_diff && !commit->parents) {
-		header = generate_header(name, "root", commit->buffer);
+		header = generate_header(sha1, NULL, commit->buffer);
 		diff_root_tree(commit_sha1, "");
 	}
 
 	/* More than one parent? */
 	if (ignore_merges && commit->parents && commit->parents->next)
-			return 0;
+		return 0;
 
 	for (parents = commit->parents; parents; parents = parents->next) {
 		struct commit *parent = parents->item;
-		header = generate_header(name,
-					 sha1_to_hex(parent->object.sha1),
+		header = generate_header(sha1,
+					 parent->object.sha1,
 					 commit->buffer);
 		diff_tree_sha1_top(parent->object.sha1, commit_sha1, "");
 		if (!header && verbose_header) {
@@ -129,6 +133,7 @@ static int diff_tree_stdin(char *line)
 	int len = strlen(line);
 	unsigned char commit[20], parent[20];
 	static char this_header[1000];
+	int abbrev = diff_options.abbrev;
 
 	if (!len || line[len-1] != '\n')
 		return -1;
@@ -138,7 +143,9 @@ static int diff_tree_stdin(char *line)
 	if (isspace(line[40]) && !get_sha1_hex(line+41, parent)) {
 		line[40] = 0;
 		line[81] = 0;
-		sprintf(this_header, "%s (from %s)\n", line, line+41);
+		sprintf(this_header, "%s (from %s)\n",
+			diff_unique_abbrev(commit, abbrev),
+			diff_unique_abbrev(parent, abbrev));
 		header = this_header;
 		return diff_tree_sha1_top(parent, commit, "");
 	}
@@ -239,6 +246,7 @@ int main(int argc, const char **argv)
 		diff_options.recursive = 1;
 
 	diff_tree_setup_paths(get_pathspec(prefix, argv));
+	diff_setup_done(&diff_options);
 
 	switch (nr_sha1) {
 	case 0:
diff --git a/diff.c b/diff.c
index 2e0797b..c815918 100644
--- a/diff.c
+++ b/diff.c
@@ -723,11 +723,13 @@ static void run_diff(struct diff_filepai
 
 	if (memcmp(one->sha1, two->sha1, 20)) {
 		char one_sha1[41];
-		const char *index_fmt = o->full_index ? "index %s..%s" : "index %.7s..%.7s";
+		int abbrev = o->full_index ? 40 : DIFF_DEFAULT_INDEX_ABBREV;
 		memcpy(one_sha1, sha1_to_hex(one->sha1), 41);
 
 		len += snprintf(msg + len, sizeof(msg) - len,
-				index_fmt, one_sha1, sha1_to_hex(two->sha1));
+				"index %.*s..%.*s",
+				abbrev, one_sha1, abbrev,
+				sha1_to_hex(two->sha1));
 		if (one->mode == two->mode)
 			len += snprintf(msg + len, sizeof(msg) - len,
 					" %06o", one->mode);
@@ -791,6 +793,8 @@ int diff_setup_done(struct diff_options 
 	}
 	if (options->setup & DIFF_SETUP_USE_SIZE_CACHE)
 		use_size_cache = 1;
+	if (options->abbrev <= 0 || 40 < options->abbrev)
+		options->abbrev = 40; /* full */
 
 	return 0;
 }
@@ -841,6 +845,10 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--find-copies-harder"))
 		options->find_copies_harder = 1;
+	else if (!strcmp(arg, "--abbrev"))
+		options->abbrev = DIFF_DEFAULT_ABBREV;
+	else if (!strncmp(arg, "--abbrev=", 9))
+		options->abbrev = strtoul(arg + 9, NULL, 10);
 	else
 		return 0;
 	return 1;
@@ -947,14 +955,49 @@ void diff_free_filepair(struct diff_file
 	free(p);
 }
 
+/* This is different from find_unique_abbrev() in that
+ * it needs to deal with 0{40} SHA1.
+ */
+const char *diff_unique_abbrev(const unsigned char *sha1, int len)
+{
+	int abblen;
+	const char *abbrev;
+	if (len == 40)
+		return sha1_to_hex(sha1);
+
+	abbrev = find_unique_abbrev(sha1, len);
+	if (!abbrev) {
+		if (!memcmp(sha1, null_sha1, 20)) {
+			char *buf = sha1_to_hex(null_sha1);
+			if (len < 37)
+				strcpy(buf + len, "...");
+			return buf;
+		}
+		else 
+			return sha1_to_hex(sha1);
+	}
+	abblen = strlen(abbrev);
+	if (abblen < 37) {
+		static char hex[41];
+		if (len < abblen && abblen <= len + 2)
+			sprintf(hex, "%s%.*s", abbrev, len+3-abblen, "..");
+		else
+			sprintf(hex, "%s...", abbrev);
+		return hex;
+	}
+	return sha1_to_hex(sha1);
+}
+
 static void diff_flush_raw(struct diff_filepair *p,
 			   int line_termination,
 			   int inter_name_termination,
-			   int output_format)
+			   struct diff_options *options)
 {
 	int two_paths;
 	char status[10];
+	int abbrev = options->abbrev;
 	const char *path_one, *path_two;
+	int output_format = options->output_format;
 
 	path_one = p->one->path;
 	path_two = p->two->path;
@@ -985,8 +1028,10 @@ static void diff_flush_raw(struct diff_f
 	}
 	if (output_format != DIFF_FORMAT_NAME_STATUS) {
 		printf(":%06o %06o %s ",
-		       p->one->mode, p->two->mode, sha1_to_hex(p->one->sha1));
-		printf("%s ", sha1_to_hex(p->two->sha1));
+		       p->one->mode, p->two->mode,
+		       diff_unique_abbrev(p->one->sha1, abbrev));
+		printf("%s ",
+		       diff_unique_abbrev(p->two->sha1, abbrev));
 	}
 	printf("%s%c%s", status, inter_name_termination, path_one);
 	if (two_paths)
@@ -1194,7 +1239,7 @@ void diff_flush(struct diff_options *opt
 		case DIFF_FORMAT_NAME_STATUS:
 			diff_flush_raw(p, line_termination,
 				       inter_name_termination,
-				       diff_output_format);
+				       options);
 			break;
 		case DIFF_FORMAT_NAME:
 			diff_flush_name(p,
diff --git a/diff.h b/diff.h
index 32b4780..c3486ff 100644
--- a/diff.h
+++ b/diff.h
@@ -44,6 +44,7 @@ struct diff_options {
 	int reverse_diff;
 	int rename_limit;
 	int setup;
+	int abbrev;
 
 	change_fn_t change;
 	add_remove_fn_t add_remove;
@@ -87,6 +88,9 @@ extern int diff_setup_done(struct diff_o
 
 #define DIFF_PICKAXE_ALL	1
 
+#define DIFF_DEFAULT_INDEX_ABBREV	7 /* hex digits */
+#define DIFF_DEFAULT_ABBREV	7 /* hex digits */
+
 extern void diffcore_std(struct diff_options *);
 
 extern void diffcore_std_no_resolve(struct diff_options *);
@@ -98,7 +102,8 @@ extern void diffcore_std_no_resolve(stru
 "  -u            synonym for -p.\n" \
 "  --name-only   show only names of changed files.\n" \
 "  --name-status show names and status of changed files.\n" \
-"  --full-index  show full object name on index ines.\n" \
+"  --full-index  show full object name on index lines.\n" \
+"  --abbrev      abbreviate object names in diff-tree header and diff-raw.\n" \
 "  -R            swap input file pairs.\n" \
 "  -B            detect complete rewrites.\n" \
 "  -M            detect renames.\n" \
@@ -137,4 +142,6 @@ extern void diff_flush(struct diff_optio
 #define DIFF_STATUS_FILTER_AON		'*'
 #define DIFF_STATUS_FILTER_BROKEN	'B'
 
+extern const char *diff_unique_abbrev(const unsigned char *, int);
+
 #endif /* DIFF_H */
diff --git a/sha1_name.c b/sha1_name.c
index bf8f0f0..875e2f8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -188,7 +188,10 @@ const char *find_unique_abbrev(const uns
 {
 	int status;
 	static char hex[41];
+
 	memcpy(hex, sha1_to_hex(sha1), 40);
+	if (len == 40)
+		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, 1);
-- 
0.99.9.GIT
