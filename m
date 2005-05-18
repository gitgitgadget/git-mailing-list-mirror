From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/1] Diff-helper update
Date: Tue, 17 May 2005 23:29:49 -0700
Message-ID: <7vwtpxoxlu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 18 08:31:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYI4U-0005yo-AJ
	for gcvg-git@gmane.org; Wed, 18 May 2005 08:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVERGav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 02:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVERGav
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 02:30:51 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3461 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261979AbVERG3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 02:29:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050518062949.ZGJR12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 02:29:49 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds a framework and a stub implementation of rename
detection to diff-helper program.

The current stub code is just enough to detect pure renames in
diff-tree output and not fancier.  The plan is perhaps to use
the same delta code when Nico's delta storage patch is merged
for similarity evaluation purposes.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-helper.txt |   12 ++-
diff-helper.c                     |  141 +++++++++++++++++++++++++++++++++++++-
diff.c                            |   34 +++++----
diff.h                            |    2 
4 files changed, 170 insertions(+), 19 deletions(-)

diff -git a/Documentation/git-diff-helper.txt b/Documentation/git-diff-helper.txt
--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-diff-helper' [-z] [-R]
+'git-diff-helper' [-z] [-R] [-r]
 
 DESCRIPTION
 -----------
@@ -28,7 +28,12 @@
 
 		git-diff-cache <tree> | git-diff-helper -R file.c
 
-would show a diff to bring the working file back to what is in the <tree>.
+	would show a diff to bring the working file back to what
+	is in the <tree>.
+
+-r::
+	Detect renames.
+
 
 See Also
 --------
@@ -37,7 +42,8 @@
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
+Written by Junio C Hamano <junkio@cox.net>
+
 
 Documentation
 --------------
diff -git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -21,6 +21,129 @@
 	return 0;
 }
 
+static int detect_rename = 0;
+
+/*
+ * We do not detect circular renames.  Just hold created and deleted
+ * entries and later attempt to match them up.  If they do not match,
+ * then spit them out as deletes or creates as original.
+ */
+
+static struct diff_spec_hold {
+	struct diff_spec_hold *next;
+	struct diff_spec_hold *matched;
+	struct diff_spec old, new;
+	char path[1];
+} *createdfile, *deletedfile;
+
+static void hold_spec(const char *path,
+		      struct diff_spec *old, struct diff_spec *new)
+{
+	struct diff_spec_hold **list, *elem;
+	list = (! old->file_valid) ? &createdfile : &deletedfile;
+	elem = xmalloc(sizeof(*elem) + strlen(path));
+	strcpy(elem->path, path);
+	elem->next = *list;
+	*list = elem;
+	elem->old = *old;
+	elem->new = *new;
+	elem->matched = 0;
+}
+
+#define MINIMUM_SCORE 7000
+int estimate_similarity(struct diff_spec *one, struct diff_spec *two)
+{
+	/* Return how similar they are, representing the score as an
+	 * integer between 0 and 10000.
+	 *
+	 * This version is very dumb and detects exact matches only.
+	 * Wnen Nico's delta stuff gets in, I'll use the delta
+	 * algorithm to estimate the similarity score in core.
+	 */
+
+	if (one->sha1_valid && two->sha1_valid &&
+	    !memcmp(one->blob_sha1, two->blob_sha1, 20))
+		return 10000;
+	return 0;
+}
+
+static void flush_renames(const char **spec, int cnt, int reverse)
+{
+	struct diff_spec_hold *rename_src, *rename_dst, *elem;
+	struct diff_spec_hold *leftover = NULL;
+	int score, best_score;
+
+	while (createdfile) {
+		rename_dst = createdfile;
+		createdfile = rename_dst->next;
+		best_score = MINIMUM_SCORE;
+		rename_src = NULL;
+		for (elem = deletedfile;
+		     elem;
+		     elem = elem->next) {
+			if (elem->matched)
+				continue;
+			score = estimate_similarity(&elem->old,
+						    &rename_dst->new);
+			if (best_score < score) {
+				rename_src = elem;
+				best_score = score;
+			}
+		}
+		if (rename_src) {
+			rename_src->matched = rename_dst;
+			rename_dst->matched = rename_src;
+
+			if (!cnt ||
+			    matches_pathspec(rename_src->path, spec, cnt) ||
+			    matches_pathspec(rename_dst->path, spec, cnt)) {
+				if (reverse)
+					run_external_diff(rename_dst->path,
+							  rename_src->path,
+							  &rename_dst->new,
+							  &rename_src->old);
+				else
+					run_external_diff(rename_src->path,
+							  rename_dst->path,
+							  &rename_src->old,
+							  &rename_dst->new);
+			}
+		}
+		else {
+			rename_dst->next = leftover;
+			leftover = rename_dst;
+		}
+	}
+
+	/* unmatched deletes */
+	for (elem = deletedfile; elem; elem = elem->next) {
+		if (elem->matched)
+			continue;
+		if (!cnt ||
+		    matches_pathspec(elem->path, spec, cnt)) {
+			if (reverse)
+				run_external_diff(elem->path, NULL,
+						  &elem->new, &elem->old);
+			else
+				run_external_diff(elem->path, NULL,
+						  &elem->old, &elem->new);
+		}
+	}
+
+	/* unmatched creates */
+	for (elem = leftover; elem; elem = elem->next) {
+		if (!cnt ||
+		    matches_pathspec(elem->path, spec, cnt)) {
+			if (reverse)
+				run_external_diff(elem->path, NULL,
+						  &elem->new, &elem->old);
+			else
+				run_external_diff(elem->path, NULL,
+						  &elem->old, &elem->new);
+		}
+	}
+}
+
 static int parse_oneside_change(const char *cp, struct diff_spec *one,
 				char *path)
 {
@@ -100,17 +223,24 @@
 	default:
 		return -1;
 	}
+
+	if (detect_rename && old.file_valid != new.file_valid) {
+		/* hold these */
+		hold_spec(path, &old, &new);
+		return 0;
+	}
+
 	if (!cnt || matches_pathspec(path, spec, cnt)) {
 		if (reverse)
-			run_external_diff(path, &new, &old);
+			run_external_diff(path, NULL, &new, &old);
 		else
-			run_external_diff(path, &old, &new);
+			run_external_diff(path, NULL, &old, &new);
 	}
 	return 0;
 }
 
 static const char *diff_helper_usage =
-"git-diff-helper [-R] [-z] paths...";
+	"git-diff-helper [-r] [-R] [-z] paths...";
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
@@ -124,6 +254,8 @@
 			reverse = 1;
 		else if (av[1][1] == 'z')
 			line_termination = 0;
+		else if (av[1][1] == 'r')
+			detect_rename = 1;
 		else
 			usage(diff_helper_usage);
 		ac--; av++;
@@ -139,5 +271,8 @@
 		if (status)
 			fprintf(stderr, "cannot parse %s\n", sb.buf);
 	}
+
+	if (detect_rename)
+		flush_renames(av+1, ac-1, reverse);
 	return 0;
 }
diff -git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -79,7 +79,8 @@
 	char tmp_path[50];
 } diff_temp[2];
 
-static void builtin_diff(const char *name,
+static void builtin_diff(const char *name_a,
+			 const char *name_b,
 			 struct diff_tempfile *temp)
 {
 	int i, next_at;
@@ -88,9 +89,12 @@
 	const char *input_name_sq[2];
 	const char *path0[2];
 	const char *path1[2];
-	const char *name_sq = sq_expand(name);
+	const char *name_sq[2];
 	char *cmd;
-	
+
+	name_sq[0] = sq_expand(name_a);
+	name_sq[1] = sq_expand(name_b);
+
 	/* diff_cmd and diff_arg have 6 %s in total which makes
 	 * the sum of these strings 12 bytes larger than required.
 	 * we use 2 spaces around diff-opts, and we need to count
@@ -105,7 +109,7 @@
 			path1[i] = "";
 		} else {
 			path0[i] = i ? "b/" : "a/";
-			path1[i] = name_sq;
+			path1[i] = name_sq[i];
 		}
 		cmd_size += (strlen(path0[i]) + strlen(path1[i]) +
 			     strlen(input_name_sq[i]));
@@ -122,7 +126,7 @@
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
 			    diff_arg, input_name_sq[0], input_name_sq[1]);
 
-	printf("diff -git a/%s b/%s\n", name, name);
+	printf("diff -git a/%s b/%s\n", name_a, name_b);
 	if (!path1[0][0])
 		printf("new file mode %s\n", temp[1].mode);
 	else if (!path1[1][0])
@@ -132,6 +136,10 @@
 			printf("old mode %s\n", temp[0].mode);
 			printf("new mode %s\n", temp[1].mode);
 		}
+		if (strcmp(name_a, name_b)) {
+			printf("rename old %s\n", name_a);
+			printf("rename new %s\n", name_b);
+		}
 		if (strncmp(temp[0].mode, temp[1].mode, 3))
 			/* we do not run diff between different kind
 			 * of objects.
@@ -157,7 +165,7 @@
 	 * benchmark with my previous version that always reads cache
 	 * shows that it makes things worse for diff-tree comparing
 	 * two linux-2.6 kernel trees in an already checked out work
-	 * tree.  This is because most diff-tree comparison deals with
+	 * tree.  This is because most diff-tree comparisons deal with
 	 * only a small number of files, while reading the cache is
 	 * expensive for a large project, and its cost outweighs the
 	 * savings we get by not inflating the object to a temporary
@@ -294,6 +302,7 @@
  *
  */
 void run_external_diff(const char *name,
+		       const char *other,
 		       struct diff_spec *one,
 		       struct diff_spec *two)
 {
@@ -304,7 +313,7 @@
 
 	if (one && two) {
 		prepare_temp_file(name, &temp[0], one);
-		prepare_temp_file(name, &temp[1], two);
+		prepare_temp_file(other ? : name, &temp[1], two);
 		if (! atexit_asked &&
 		    (temp[0].name == temp[0].tmp_path ||
 		     temp[1].name == temp[1].tmp_path)) {
@@ -320,7 +329,8 @@
 		die("unable to fork");
 	if (!pid) {
 		const char *pgm = external_diff();
-		if (pgm) {
+		/* not passing rename patch to external ones */
+		if (!other && pgm) {
 			if (one && two)
 				execlp(pgm, pgm,
 				       name,
@@ -334,7 +344,7 @@
 		 * otherwise we use the built-in one.
 		 */
 		if (one && two)
-			builtin_diff(name, temp);
+			builtin_diff(name, other ? : name, temp);
 		else
 			printf("* Unmerged path %s\n", name);
 		exit(0);
@@ -379,7 +389,7 @@
 		strcpy(concatpath, base);
 		strcat(concatpath, path);
 	}
-	run_external_diff(path ? concatpath : base, one, two);
+	run_external_diff(path ? concatpath : base, NULL, one, two);
 }
 
 void diff_change(unsigned old_mode, unsigned new_mode,
@@ -400,10 +410,10 @@
 		strcpy(concatpath, base);
 		strcat(concatpath, path);
 	}
-	run_external_diff(path ? concatpath : base, &spec[0], &spec[1]);
+	run_external_diff(path ? concatpath : base, NULL, &spec[0], &spec[1]);
 }
 
 void diff_unmerge(const char *path)
 {
-	run_external_diff(path, NULL, NULL);
+	run_external_diff(path, NULL, NULL, NULL);
 }
diff -git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -31,7 +31,7 @@
 	unsigned file_valid : 1; /* if false the file does not even exist */
 };
 
-extern void run_external_diff(const char *name,
+extern void run_external_diff(const char *name, const char *other,
 			      struct diff_spec *, struct diff_spec *);
 
 #endif /* DIFF_H */
------------------------------------------------

