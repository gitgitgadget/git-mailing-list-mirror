From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] apply --unidiff-zero: loosen sanity checks for --unidiff=0 patches
Date: Sun, 17 Sep 2006 01:17:16 -0700
Message-ID: <7vsliq7vqr.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060915132225.12040.qmail@a0896f98af57b2.315fe32.mid.smarden.org>
	<7vzmcz6mrq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 386495@bugs.debian.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 10:17:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOrq6-0004XD-Fe
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 10:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWIQIRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 04:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWIQIRT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 04:17:19 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:60094 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751165AbWIQIRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 04:17:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917081717.KFOQ21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 04:17:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PLH41V00F1kojtg0000000
	Sun, 17 Sep 2006 04:17:05 -0400
To: Gerrit Pape <pape@smarden.org>
In-Reply-To: <7vzmcz6mrq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Sep 2006 23:16:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27162>

One request and one question:

 (1) I think the attached patch should fix this.  Could you
     see if it works for you?

 (2) Is it absolutely necessary to work with a context-free
     patch in the workflow of the particular job (pciutils
     maintenance)?  If so what is the reason?

-- >8 --
In "git-apply", we have a few sanity checks and heuristics that
expects that the patch fed to us is a unified diff with at least
one line of context.

 * When there is no leading context line in a hunk, the hunk
   must apply at the beginning of the preimage.  Similarly, no
   trailing context means that the hunk is anchored at the end.

 * We learn a patch deletes the file from a hunk that has no
   resulting line (i.e. all lines are prefixed with '-') if it
   has not otherwise been known if the patch deletes the file.
   Similarly, no old line means the file is being created.

And we declare an error condition when the file created by a
creation patch already exists, and/or when a deletion patch
still leaves content in the file.

These sanity checks are good safety measures, but breaks down
when people feed a diff generated with --unified=0.  This was
recently noticed first by Matthew Wilcox and Gerrit Pape.

This adds a new flag, --unified-zero, to allow bypassing these
checks.  If you are in control of the patch generation process,
you should not use --unified=0 patch and fix it up with this
flag; rather you should try work with a patch with context.  But
if all you have to work with is a patch without context, this
flag may come handy as the last resort.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-apply.c           |  112 +++++++++++++++++++++++++++++++-------------
 t/t3403-rebase-skip.sh    |    4 +-
 t/t4104-apply-boundary.sh |  115 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 34 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 6e0864c..25e90d8 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -27,6 +27,7 @@ static const char *prefix;
 static int prefix_length = -1;
 static int newfd = -1;
 
+static int unidiff_zero;
 static int p_value = 1;
 static int check_index;
 static int write_index;
@@ -854,11 +855,10 @@ static int find_header(char *line, unsig
 }
 
 /*
- * Parse a unified diff. Note that this really needs
- * to parse each fragment separately, since the only
- * way to know the difference between a "---" that is
- * part of a patch, and a "---" that starts the next
- * patch is to look at the line counts..
+ * Parse a unified diff. Note that this really needs to parse each
+ * fragment separately, since the only way to know the difference
+ * between a "---" that is part of a patch, and a "---" that starts
+ * the next patch is to look at the line counts..
  */
 static int parse_fragment(char *line, unsigned long size, struct patch *patch, struct fragment *fragment)
 {
@@ -875,31 +875,14 @@ static int parse_fragment(char *line, un
 	leading = 0;
 	trailing = 0;
 
-	if (patch->is_new < 0) {
-		patch->is_new =  !oldlines;
-		if (!oldlines)
-			patch->old_name = NULL;
-	}
-	if (patch->is_delete < 0) {
-		patch->is_delete = !newlines;
-		if (!newlines)
-			patch->new_name = NULL;
-	}
-
-	if (patch->is_new && oldlines)
-		return error("new file depends on old contents");
-	if (patch->is_delete != !newlines) {
-		if (newlines)
-			return error("deleted file still has contents");
-		fprintf(stderr, "** warning: file %s becomes empty but is not deleted\n", patch->new_name);
-	}
-
 	/* Parse the thing.. */
 	line += len;
 	size -= len;
 	linenr++;
 	added = deleted = 0;
-	for (offset = len; size > 0; offset += len, size -= len, line += len, linenr++) {
+	for (offset = len;
+	     0 < size;
+	     offset += len, size -= len, line += len, linenr++) {
 		if (!oldlines && !newlines)
 			break;
 		len = linelen(line, size);
@@ -972,12 +955,18 @@ static int parse_fragment(char *line, un
 
 	patch->lines_added += added;
 	patch->lines_deleted += deleted;
+
+	if (0 < patch->is_new && oldlines)
+		return error("new file depends on old contents");
+	if (0 < patch->is_delete && newlines)
+		return error("deleted file still has contents");
 	return offset;
 }
 
 static int parse_single_patch(char *line, unsigned long size, struct patch *patch)
 {
 	unsigned long offset = 0;
+	unsigned long oldlines = 0, newlines = 0, context = 0;
 	struct fragment **fragp = &patch->fragments;
 
 	while (size > 4 && !memcmp(line, "@@ -", 4)) {
@@ -988,9 +977,11 @@ static int parse_single_patch(char *line
 		len = parse_fragment(line, size, patch, fragment);
 		if (len <= 0)
 			die("corrupt patch at line %d", linenr);
-
 		fragment->patch = line;
 		fragment->size = len;
+		oldlines += fragment->oldlines;
+		newlines += fragment->newlines;
+		context += fragment->leading + fragment->trailing;
 
 		*fragp = fragment;
 		fragp = &fragment->next;
@@ -999,6 +990,46 @@ static int parse_single_patch(char *line
 		line += len;
 		size -= len;
 	}
+
+	/*
+	 * If something was removed (i.e. we have old-lines) it cannot
+	 * be creation, and if something was added it cannot be
+	 * deletion.  However, the reverse is not true; --unified=0
+	 * patches that only add are not necessarily creation even
+	 * though they do not have any old lines, and ones that only
+	 * delete are not necessarily deletion.
+	 *
+	 * Unfortunately, a real creation/deletion patch do _not_ have
+	 * any context line by definition, so we cannot safely tell it
+	 * apart with --unified=0 insanity.  At least if the patch has
+	 * more than one hunk it is not creation or deletion.
+	 */
+	if (patch->is_new < 0 &&
+	    (oldlines || (patch->fragments && patch->fragments->next)))
+		patch->is_new = 0;
+	if (patch->is_delete < 0 &&
+	    (newlines || (patch->fragments && patch->fragments->next)))
+		patch->is_delete = 0;
+	if (!unidiff_zero || context) {
+		/* If the user says the patch is not generated with
+		 * --unified=0, or if we have seen context lines,
+		 * then not having oldlines means the patch is creation,
+		 * and not having newlines means the patch is deletion.
+		 */
+		if (patch->is_new < 0 && !oldlines)
+			patch->is_new = 1;
+		if (patch->is_delete < 0 && !newlines)
+			patch->is_delete = 1;
+	}
+
+	if (0 < patch->is_new && oldlines)
+		die("new file %s depends on old contents", patch->new_name);
+	if (0 < patch->is_delete && newlines)
+		die("deleted file %s still has contents", patch->old_name);
+	if (!patch->is_delete && !newlines && context)
+		fprintf(stderr, "** warning: file %s becomes empty but "
+			"is not deleted\n", patch->new_name);
+
 	return offset;
 }
 
@@ -1556,9 +1587,19 @@ static int apply_one_fragment(struct buf
 	/*
 	 * If we don't have any leading/trailing data in the patch,
 	 * we want it to match at the beginning/end of the file.
+	 *
+	 * But that would break if the patch is generated with
+	 * --unified=0; sane people wouldn't do that to cause us
+	 * trouble, but we try to please not so sane ones as well.
 	 */
-	match_beginning = !leading && (frag->oldpos == 1);
-	match_end = !trailing;
+	if (unidiff_zero) {
+		match_beginning = (!leading && !frag->oldpos);
+		match_end = 0;
+	}
+	else {
+		match_beginning = !leading && (frag->oldpos == 1);
+		match_end = !trailing;
+	}
 
 	lines = 0;
 	pos = frag->newpos;
@@ -1804,7 +1845,7 @@ static int apply_data(struct patch *patc
 	patch->result = desc.buffer;
 	patch->resultsize = desc.size;
 
-	if (patch->is_delete && patch->resultsize)
+	if (0 < patch->is_delete && patch->resultsize)
 		return error("removal patch leaves file contents");
 
 	return 0;
@@ -1876,7 +1917,7 @@ static int check_patch(struct patch *pat
 				old_name, st_mode, patch->old_mode);
 	}
 
-	if (new_name && prev_patch && prev_patch->is_delete &&
+	if (new_name && prev_patch && 0 < prev_patch->is_delete &&
 	    !strcmp(prev_patch->old_name, new_name))
 		/* A type-change diff is always split into a patch to
 		 * delete old, immediately followed by a patch to
@@ -1889,7 +1930,8 @@ static int check_patch(struct patch *pat
 	else
 		ok_if_exists = 0;
 
-	if (new_name && (patch->is_new | patch->is_rename | patch->is_copy)) {
+	if (new_name &&
+	    ((0 < patch->is_new) | (0 < patch->is_rename) | patch->is_copy)) {
 		if (check_index &&
 		    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
 		    !ok_if_exists)
@@ -1906,7 +1948,7 @@ static int check_patch(struct patch *pat
 				return error("%s: %s", new_name, strerror(errno));
 		}
 		if (!patch->new_mode) {
-			if (patch->is_new)
+			if (0 < patch->is_new)
 				patch->new_mode = S_IFREG | 0644;
 			else
 				patch->new_mode = patch->old_mode;
@@ -1957,7 +1999,7 @@ static void show_index_list(struct patch
 		const char *name;
 
 		name = patch->old_name ? patch->old_name : patch->new_name;
-		if (patch->is_new)
+		if (0 < patch->is_new)
 			sha1_ptr = null_sha1;
 		else if (get_sha1(patch->old_sha1_prefix, sha1))
 			die("sha1 information is lacking or useless (%s).",
@@ -2543,6 +2585,10 @@ int cmd_apply(int argc, const char **arg
 			apply_in_reverse = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--unidiff-zero")) {
+			unidiff_zero = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--reject")) {
 			apply = apply_with_reject = apply_verbosely = 1;
 			continue;
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 8ab63c5..bb25315 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -37,7 +37,9 @@ test_expect_success setup '
 	git branch skip-merge skip-reference
 	'
 
-test_expect_failure 'rebase with git am -3 (default)' 'git rebase master'
+test_expect_failure 'rebase with git am -3 (default)' '
+	git rebase master
+'
 
 test_expect_success 'rebase --skip with am -3' '
 	git reset --hard HEAD &&
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
new file mode 100755
index 0000000..2ff800c
--- /dev/null
+++ b/t/t4104-apply-boundary.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-apply boundary tests
+
+'
+. ./test-lib.sh
+
+L="c d e f g h i j k l m n o p q r s t u v w x"
+
+test_expect_success setup '
+	for i in b '"$L"' y
+	do
+		echo $i
+	done >victim &&
+	cat victim >original &&
+	git update-index --add victim &&
+
+	: add to the head
+	for i in a b '"$L"' y
+	do
+		echo $i
+	done >victim &&
+	cat victim >add-a-expect &&
+	git diff victim >add-a-patch.with &&
+	git diff --unified=0 >add-a-patch.without &&
+
+	: modify at the head
+	for i in a '"$L"' y
+	do
+		echo $i
+	done >victim &&
+	cat victim >mod-a-expect &&
+	git diff victim >mod-a-patch.with &&
+	git diff --unified=0 >mod-a-patch.without &&
+
+	: remove from the head
+	for i in '"$L"' y
+	do
+		echo $i
+	done >victim &&
+	cat victim >del-a-expect &&
+	git diff victim >del-a-patch.with
+	git diff --unified=0 >del-a-patch.without &&
+
+	: add to the tail
+	for i in b '"$L"' y z
+	do
+		echo $i
+	done >victim &&
+	cat victim >add-z-expect &&
+	git diff victim >add-z-patch.with &&
+	git diff --unified=0 >add-z-patch.without &&
+
+	: modify at the tail
+	for i in a '"$L"' y
+	do
+		echo $i
+	done >victim &&
+	cat victim >mod-z-expect &&
+	git diff victim >mod-z-patch.with &&
+	git diff --unified=0 >mod-z-patch.without &&
+
+	: remove from the tail
+	for i in b '"$L"'
+	do
+		echo $i
+	done >victim &&
+	cat victim >del-z-expect &&
+	git diff victim >del-z-patch.with
+	git diff --unified=0 >del-z-patch.without &&
+
+	: done
+'
+
+for with in with without
+do
+	case "$with" in
+	with) u= ;;
+	without) u='--unidiff-zero ' ;;
+	esac
+	for kind in add-a add-z mod-a mod-z del-a del-z
+	do
+		test_expect_success "apply $kind-patch $with context" '
+			cat original >victim &&
+			git update-index victim &&
+			git apply --index '"$u$kind-patch.$with"' || {
+				cat '"$kind-patch.$with"'
+				(exit 1)
+			} &&
+			diff -u '"$kind"'-expect victim
+		'
+	done
+done
+
+for kind in add-a add-z mod-a mod-z del-a del-z
+do
+	rm -f $kind-ng.without
+	sed	-e "s/^diff --git /diff /" \
+		-e '/^index /d' \
+		<$kind-patch.without >$kind-ng.without
+	test_expect_success "apply non-git $kind-patch without context" '
+		cat original >victim &&
+		git update-index victim &&
+		git apply --unidiff-zero --index '"$kind-ng.without"' || {
+			cat '"$kind-ng.without"'
+			(exit 1)
+		} &&
+		diff -u '"$kind"'-expect victim
+	'
+done
+
+test_done
-- 
1.4.2.1.gca4e5c
