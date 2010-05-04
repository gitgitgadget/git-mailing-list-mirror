From: Dylan Reid <dgreid@gmail.com>
Subject: [PATCH] blame: can specify shas of commits to ignore on command line
Date: Mon,  3 May 2010 22:21:27 -0400
Message-ID: <1272939687-17686-1-git-send-email-dgreid@gmail.com>
Cc: Dylan Reid <dgreid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 04:25:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O97or-0002AC-7l
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 04:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941Ab0EDCZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 22:25:00 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:46179 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab0EDCY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 22:24:59 -0400
Received: by qyk27 with SMTP id 27so7165170qyk.23
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vONtpXlrtRtxZmxDicdOPthqQDVKxtucRrbsuMnDidY=;
        b=sQJZ8rH3tLW+PfJb9ZTUZYdDTRyBFFPogyL3qnDU738RkfO8uveGg7wz5WCMLZN2Jb
         lw77Topg7i1XI72R4CXLmq6ZbkcUdT0ye++OuSxKvnRlVeOlhqofQcGqL374oF8BgKlM
         qLkLjTPdneitLjcWG7N1A32NnlE63wd2Lhlxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MvnbEEVnl1rM1iEAN1l+VrWPBhTZpgQCeYLmk9NJLDyd6GJQlBVROFn0dlyQUKyI5W
         QypwxFpQwqT9ywOmLFm0ILUqHXNDxDOORzKmlAxVzfeR0vwPrHg5aBmqvqAGYoQYv8FD
         1N/Zqzyz5RDUyw1el8Ecf9n6YgQehUJQr9zT0=
Received: by 10.229.218.2 with SMTP id ho2mr2440525qcb.51.1272939897925;
        Mon, 03 May 2010 19:24:57 -0700 (PDT)
Received: from localhost.localdomain (209-6-87-142.c3-0.frm-ubr3.sbo-frm.ma.cable.rcn.com [209.6.87.142])
        by mx.google.com with ESMTPS id f5sm1610893qcg.14.2010.05.03.19.24.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 19:24:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.6.gc7a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146281>

Add the ability for git-blame to ignore changes that occur in
certain commits.  The new "-I <sha>" argument can be used to specify
a commit that should be ignored.  This is useful if you have a
few commits that you know didn't cause a problem, for example you
switched from "u8" to "uint8_t" and it messed up your history.

   Allow multiple commits to be specified and store an array in the
scoreboard structure so it is accessible.  Add should_ignore_commit
function to check if a commit should be ignored. Call
"should_ignore_commit" from blame_overlap and if the commit should
be ignored then pass all the blame on to the parent of the ignored
commit.  This is done by calling "pass_whole_blame" which has been
relocated to a above blame_overlap, but is unchanged.

Signed-off-by: Dylan Reid <dgreid@gmail.com>
---
 Documentation/blame-options.txt |    6 ++
 builtin/blame.c                 |  124 +++++++++++++++++++++++++++++----------
 t/t8003-blame.sh                |   42 +++++++++++++
 3 files changed, 141 insertions(+), 31 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index d820569..eb9c825 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -52,6 +52,12 @@ of lines before or after the line given by <start>.
 --porcelain::
 	Show in a format designed for machine consumption.
 
+--ignore-commit <sha>::
+	Ignore the specified commit when assigning blame.  This is
+	useful if there are commits in the history that make non
+	functional changes to the lines you are interested in
+	finding blame for.
+
 --incremental::
 	Show the result incrementally in a format designed for
 	machine consumption.
diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..e4bd095 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -176,6 +176,14 @@ struct blame_entry {
 };
 
 /*
+ * List of any commits to ignore
+ */
+struct ignore_commits {
+	unsigned char (*ignore_shas)[20];
+	unsigned num_ignore_shas;
+};
+
+/*
  * The current state of the blame assignment.
  */
 struct scoreboard {
@@ -198,6 +206,9 @@ struct scoreboard {
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
+
+	/* List of the shas of commits that should be ignored */
+	struct ignore_commits *ignored_commits;
 };
 
 static inline int same_suspect(struct origin *a, struct origin *b)
@@ -653,6 +664,44 @@ static void decref_split(struct blame_entry *split)
 }
 
 /*
+ * The blobs of origin and porigin exactly match, so everything
+ * origin is suspected for can be blamed on the parent.
+ */
+static void pass_whole_blame(struct scoreboard *sb,
+			     struct origin *origin, struct origin *porigin)
+{
+   struct blame_entry *e;
+
+   if (!porigin->file.ptr && origin->file.ptr) {
+      /* Steal its file */
+      porigin->file = origin->file;
+      origin->file.ptr = NULL;
+   }
+   for (e = sb->ent; e; e = e->next) {
+      if (!same_suspect(e->suspect, origin))
+	 continue;
+      origin_incref(porigin);
+      origin_decref(e->suspect);
+      e->suspect = porigin;
+   }
+}
+
+/*
+ * Helper to determine if the given commit should be ignored
+ */
+static unsigned should_ignore_commit(const struct scoreboard *sb,
+				     struct commit *commit)
+{
+	unsigned i;
+	unsigned num_shas = sb->ignored_commits->num_ignore_shas;
+	for(i = 0; i < num_shas; i++)
+		if(!hashcmp(commit->object.sha1,
+			    sb->ignored_commits->ignore_shas[i]))
+			return 1;
+	return 0;
+}
+
+/*
  * Helper for blame_chunk().  blame_entry e is known to overlap with
  * the patch hunk; split it and pass blame to the parent.
  */
@@ -660,12 +709,15 @@ static void blame_overlap(struct scoreboard *sb, struct blame_entry *e,
 			  int tlno, int plno, int same,
 			  struct origin *parent)
 {
-	struct blame_entry split[3];
-
-	split_overlap(split, e, tlno, plno, same, parent);
-	if (split[1].suspect)
-		split_blame(sb, split, e);
-	decref_split(split);
+	if(should_ignore_commit(sb, e->suspect->commit))
+		pass_whole_blame(sb, e->suspect, parent);
+	else {
+		struct blame_entry split[3];
+		split_overlap(split, e, tlno, plno, same, parent);
+		if (split[1].suspect)
+			split_blame(sb, split, e);
+		decref_split(split);
+	}
 }
 
 /*
@@ -1105,29 +1157,6 @@ static int find_copy_in_parent(struct scoreboard *sb,
 }
 
 /*
- * The blobs of origin and porigin exactly match, so everything
- * origin is suspected for can be blamed on the parent.
- */
-static void pass_whole_blame(struct scoreboard *sb,
-			     struct origin *origin, struct origin *porigin)
-{
-	struct blame_entry *e;
-
-	if (!porigin->file.ptr && origin->file.ptr) {
-		/* Steal its file */
-		porigin->file = origin->file;
-		origin->file.ptr = NULL;
-	}
-	for (e = sb->ent; e; e = e->next) {
-		if (!same_suspect(e->suspect, origin))
-			continue;
-		origin_incref(porigin);
-		origin_decref(e->suspect);
-		e->suspect = porigin;
-	}
-}
-
-/*
  * We pass blame from the current commit to its parents.  We keep saying
  * "parent" (and "porigin"), but what we mean is to find scapegoat to
  * exonerate ourselves.
@@ -1540,8 +1569,14 @@ static void assign_blame(struct scoreboard *sb, int opt)
 
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
-			if (same_suspect(ent->suspect, suspect))
-				found_guilty_entry(ent);
+			if (same_suspect(ent->suspect, suspect)) {
+				if (should_ignore_commit(sb, commit) &&
+				    ent->suspect->previous)
+					pass_whole_blame(sb, ent->suspect,
+							 ent->suspect->previous);
+				else
+					found_guilty_entry(ent);
+		   }
 		origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
@@ -2204,6 +2239,24 @@ static int blame_bottomtop_callback(const struct option *option, const char *arg
 	return 0;
 }
 
+static int blame_ignorecommit_callback(const struct option *option,
+				       const char *arg, int unset)
+{
+	struct ignore_commits *commits = option->value;
+	if (!arg)
+		return -1;
+	commits->ignore_shas =
+		realloc(commits->ignore_shas,
+			( (commits->num_ignore_shas + 1) *
+			  20 ));
+	if(!get_sha1(arg, commits->ignore_shas[commits->num_ignore_shas]))
+		commits->num_ignore_shas++;
+	else
+		return -1;
+
+	return 0;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2215,6 +2268,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	const char *final_commit_name = NULL;
 	enum object_type type;
 
+	static struct ignore_commits ignored_commits;
 	static const char *bottomtop = NULL;
 	static int output_option = 0, opt = 0;
 	static int show_stats = 0;
@@ -2239,6 +2293,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements within and across files", PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_CALLBACK('L', NULL, &bottomtop, "n,m", "Process only line range n,m, counting from 1", blame_bottomtop_callback),
+		OPT_CALLBACK(0, "ignore-commit", &ignored_commits, "sha", "don't blame the specified commit for anything", blame_ignorecommit_callback),
 		OPT_END()
 	};
 
@@ -2252,6 +2307,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
 
+	memset(&ignored_commits, 0, sizeof(ignored_commits));
+
 	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
 			    PARSE_OPT_KEEP_ARGV0);
 	for (;;) {
@@ -2369,6 +2426,8 @@ parse_done:
 	setup_revisions(argc, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
 
+	sb.ignored_commits = &ignored_commits;
+
 	sb.revs = &revs;
 	if (!reverse)
 		final_commit_name = prepare_final(&sb);
@@ -2468,6 +2527,9 @@ parse_done:
 		ent = e;
 	}
 
+	if (ignored_commits.ignore_shas)
+		free(ignored_commits.ignore_shas);
+
 	if (show_stats) {
 		printf("num read blob: %d\n", num_read_blob);
 		printf("num get patch: %d\n", num_get_patch);
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 230143c..f90d37a 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -185,4 +185,46 @@ test_expect_success 'indent of line numbers, ten lines' '
 	test $(grep -c "  " actual) = 9
 '
 
+test_expect_success 'blame ignore setup with split' '
+	echo A A A >one
+	echo b b b b b >> one
+	echo c c c c c >> one
+	git add one
+	GIT_AUTHOR_NAME=AddLine git commit -m "add As"
+	INIT_ADD_SHA=`git log --pretty=format:"%H" HEAD^..`
+	echo " " A A A >one
+	echo b b b b b >> one
+	echo c c c c c >> one
+	git add one
+	GIT_AUTHOR_NAME=Indent git commit -m "reindent"
+	IGNORE_SHA=`git log --pretty=format:"%H" HEAD^..`
+'
+
+test_expect_success 'blame ignore commit' '
+	git blame --ignore-commit $IGNORE_SHA one > ignored &&
+	test $(grep -c "AddLine" ignored) = 3
+'
+
+test_expect_success 'blame ignore first commit' '
+	git blame --ignore-commit $IGNORE_SHA --ignore-commit $INIT_ADD_SHA \
+		$INIT_ADD_SHA.. -- one > ignore_1st &&
+	test $(grep -c "AddLine" ignore_1st) = 3
+'
+
+test_expect_success 'blame ignore setup avoid blame_overlap' '
+	echo A A A >one
+	git add one
+	GIT_AUTHOR_NAME=AddLine git commit -m "add As"
+	INIT_ADD_SHA=`git log --pretty=format:"%H" HEAD^..`
+	echo " " A A A >one
+	git add one
+	GIT_AUTHOR_NAME=Indent git commit -m "reindent"
+	IGNORE_SHA=`git log --pretty=format:"%H" HEAD^..`
+'
+
+test_expect_success 'blame ignore commit no blame_overlap call' '
+	git blame --ignore-commit $IGNORE_SHA one > ignored &&
+	test $(grep -c "Indent" ignored) = 0
+'
+
 test_done
-- 
1.7.1.6.gc7a9
