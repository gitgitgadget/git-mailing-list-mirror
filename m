From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Diff updates, fixing pathspec and rename/copy interaction.
Date: Thu, 26 May 2005 23:41:28 -0700
Message-ID: <7vsm091887.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 08:50:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbYal-0006e2-3m
	for gcvg-git@gmane.org; Fri, 27 May 2005 08:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVE0GrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 02:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVE0GrJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 02:47:09 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48840 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261894AbVE0Glf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 02:41:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527064130.XHGW26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 02:41:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 26 May 2005 17:41:11 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

During the mailing list discussion about diff-tree omitting to
call diffcore-pathspec, I realized that the current rename/copy
differentiator has a major flaw interacting with pathspec (or
any other filepair filters, including pickaxe).

The problem was that in order to tell if the rename-copy source
still remains in the resulting tree (that is what determines if
one of the rename-copy can become a rename or everybody needs to
be a copy), diffcore-rename was sending a filepair that records
unmodified source downstream, expecting that it reaches
resolve_rename_copy() which happens as the final stage before
actual output happens.  Of course, pathspec and pickaxe can
interfere and happily remove that entry, in which case what
should be shown as a copy suddenly becomes a rename.

The problem was fixed by changing the way diffcore-rename
records whether the source file remains in the resulting tree.

This patch also introduces an optimization for diff-tree -M and
diff-tree -C to throw away implausible rename/copy source
candidate by keeping the filesize information of already seen
SHA1 object IDs in a cache.  This cache is activated only when
diff-tree is reading from --stdin (i.e. processing sequence of
tree pairs) and when rename detection is used.

Pickaxe acquired another option, --pickaxe-all, to diff-* three
brothers.  When a search string is touched, instead of showing
only the changed file that touches that searched string, it
shows the entire changeset.  This is useful to see the change in
context.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c             |   13 ++
diff-files.c             |   11 +-
diff-helper.c            |    9 +-
diff-tree.c              |   16 ++-
diff.c                   |  209 ++++++++++++++++++++++++++++++-----------------
diff.h                   |   18 ++--
diffcore-pathspec.c      |    5 -
diffcore-pickaxe.c       |   79 +++++++++++++----
diffcore-rename.c        |   91 +++++++++-----------
diffcore.h               |   14 +--
git-external-diff-script |    2 
t/t4007-rename-3.sh      |  103 +++++++++++++++++++++++
12 files changed, 392 insertions(+), 178 deletions(-)
new file (100755): t/t4007-rename-3.sh

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -5,9 +5,10 @@ static int cached_only = 0;
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int match_nonexisting = 0;
 static int detect_rename = 0;
-static int reverse_diff = 0;
+static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
@@ -202,13 +203,17 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-R")) {
-			reverse_diff = 1;
+			diff_setup_opt |= DIFF_SETUP_REVERSE;
 			continue;
 		}
 		if (!strcmp(arg, "-S")) {
 			pickaxe = arg + 2;
 			continue;
 		}
+		if (!strcmp(arg, "--pickaxe-all")) {
+			pickaxe_opts = DIFF_PICKAXE_ALL;
+			continue;
+		}
 		if (!strcmp(arg, "-m")) {
 			match_nonexisting = 1;
 			continue;
@@ -224,7 +229,7 @@ int main(int argc, const char **argv)
 		usage(diff_cache_usage);
 
 	/* The rest is for paths restriction. */
-	diff_setup(reverse_diff);
+	diff_setup(diff_setup_opt);
 
 	mark_merge_entries();
 
@@ -238,7 +243,7 @@ int main(int argc, const char **argv)
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diffcore_pickaxe(pickaxe);
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (pathspec)
 		diffcore_pathspec(pathspec);
 	diff_flush(diff_output_format, 1);
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -11,9 +11,10 @@ static const char *diff_files_usage =
 
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
-static int reverse_diff = 0;
+static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
 static int silent = 0;
 
 static void show_unmerge(const char *path)
@@ -51,9 +52,11 @@ int main(int argc, const char **argv)
 		else if (!strcmp(argv[1], "-z"))
 			diff_output_format = DIFF_FORMAT_MACHINE;
 		else if (!strcmp(argv[1], "-R"))
-			reverse_diff = 1;
+			diff_setup_opt |= DIFF_SETUP_REVERSE;
 		else if (!strcmp(argv[1], "-S"))
 			pickaxe = argv[1] + 2;
+		else if (!strcmp(argv[1], "--pickaxe-all"))
+			pickaxe_opts = DIFF_PICKAXE_ALL;
 		else if (!strncmp(argv[1], "-M", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
 			detect_rename = DIFF_DETECT_RENAME;
@@ -75,7 +78,7 @@ int main(int argc, const char **argv)
 		exit(1);
 	}
 
-	diff_setup(reverse_diff);
+	diff_setup(diff_setup_opt);
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
@@ -116,7 +119,7 @@ int main(int argc, const char **argv)
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diffcore_pickaxe(pickaxe);
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (1 < argc)
 		diffcore_pathspec(argv + 1);
 	diff_flush(diff_output_format, 1);
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -4,9 +4,9 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "diff.h"
-#include "diffcore.h" /* just for MAX_SCORE */
 
 static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
 static int line_termination = '\n';
 static int inter_name_termination = '\t';
 
@@ -24,6 +24,8 @@ int main(int ac, const char **av) {
 		else if (av[1][1] == 'S') {
 			pickaxe = av[1] + 2;
 		}
+		else if (!strcmp(av[1], "--pickaxe-all"))
+			pickaxe_opts = DIFF_PICKAXE_ALL;
 		else
 			usage(diff_helper_usage);
 		ac--; av++;
@@ -78,7 +80,6 @@ int main(int ac, const char **av) {
 			if (status == 'R' || status == 'C') {
 				two_paths = 1;
 				sscanf(cp, "%d", &score);
-				score = score * MAX_SCORE / 100;
 				if (line_termination) {
 					cp = strchr(cp,
 						    inter_name_termination);
@@ -129,14 +130,14 @@ int main(int ac, const char **av) {
 			continue;
 		}
 		if (pickaxe)
-			diffcore_pickaxe(pickaxe);
+			diffcore_pickaxe(pickaxe, pickaxe_opts);
 		if (1 < ac)
 			diffcore_pathspec(av + 1);
 		diff_flush(DIFF_FORMAT_PATCH, 0);
 		printf("%s\n", sb.buf);
 	}
 	if (pickaxe)
-		diffcore_pickaxe(pickaxe);
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (1 < ac)
 		diffcore_pathspec(av + 1);
 	diff_flush(DIFF_FORMAT_PATCH, 0);
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -10,9 +10,10 @@ static int show_tree_entry_in_recursive 
 static int read_stdin = 0;
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
-static int reverse_diff = 0;
+static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
@@ -255,7 +256,7 @@ static int diff_tree_sha1(const unsigned
 
 static void call_diff_setup(void)
 {
-	diff_setup(reverse_diff);
+	diff_setup(diff_setup_opt);
 }
 
 static int call_diff_flush(void)
@@ -263,7 +264,7 @@ static int call_diff_flush(void)
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diffcore_pickaxe(pickaxe);
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (diff_queue_is_empty()) {
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
@@ -504,7 +505,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-R")) {
-			reverse_diff = 1;
+			diff_setup_opt |= DIFF_SETUP_REVERSE;
 			continue;
 		}
 		if (!strcmp(arg, "-p")) {
@@ -516,6 +517,10 @@ int main(int argc, const char **argv)
 			pickaxe = arg + 2;
 			continue;
 		}
+		if (!strcmp(arg, "--pickaxe-all")) {
+			pickaxe_opts = DIFF_PICKAXE_ALL;
+			continue;
+		}
 		if (!strncmp(arg, "-M", 2)) {
 			detect_rename = DIFF_DETECT_RENAME;
 			diff_score_opt = diff_scoreopt_parse(arg);
@@ -580,6 +585,9 @@ int main(int argc, const char **argv)
 	if (!read_stdin)
 		return 0;
 
+	if (detect_rename)
+		diff_setup_opt |= (DIFF_SETUP_USE_SIZE_CACHE |
+				   DIFF_SETUP_USE_CACHE);
 	while (fgets(line, sizeof(line), stdin))
 		diff_tree_stdin(line);
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -12,6 +12,7 @@ static const char *diff_opts = "-pu";
 static unsigned char null_sha1[20] = { 0, };
 
 static int reverse_diff;
+static int use_size_cache;
 
 static const char *external_diff(void)
 {
@@ -141,7 +142,7 @@ static void builtin_diff(const char *nam
 			printf("new mode %s\n", temp[1].mode);
 		}
 		if (xfrm_msg && xfrm_msg[0])
-			fputs(xfrm_msg, stdout);
+			puts(xfrm_msg);
 
 		if (strncmp(temp[0].mode, temp[1].mode, 3))
 			/* we do not run diff between different kind
@@ -222,12 +223,60 @@ static int work_tree_matches(const char 
 	return 1;
 }
 
+static struct sha1_size_cache {
+	unsigned char sha1[20];
+	unsigned long size;
+} **sha1_size_cache;
+static int sha1_size_cache_nr, sha1_size_cache_alloc;
+
+static struct sha1_size_cache *locate_size_cache(unsigned char *sha1,
+						 unsigned long size)
+{
+	int first, last;
+	struct sha1_size_cache *e;
+
+	first = 0;
+	last = sha1_size_cache_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		e = sha1_size_cache[next];
+		int cmp = memcmp(e->sha1, sha1, 20);
+		if (!cmp)
+			return e;
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next+1;
+	}
+	/* not found */
+	if (size == UINT_MAX)
+		return NULL;
+	/* insert to make it at "first" */
+	if (sha1_size_cache_alloc <= sha1_size_cache_nr) {
+		sha1_size_cache_alloc = alloc_nr(sha1_size_cache_alloc);
+		sha1_size_cache = xrealloc(sha1_size_cache,
+					   sha1_size_cache_alloc *
+					   sizeof(*sha1_size_cache));
+	}
+	sha1_size_cache_nr++;
+	if (first < sha1_size_cache_nr)
+		memmove(sha1_size_cache + first + 1, sha1_size_cache + first,
+			(sha1_size_cache_nr - first - 1) *
+			sizeof(*sha1_size_cache));
+	e = xmalloc(sizeof(struct sha1_size_cache));
+	sha1_size_cache[first] = e;
+	memcpy(e->sha1, sha1, 20);
+	e->size = size;
+	return e;
+}
+
 /*
  * While doing rename detection and pickaxe operation, we may need to
  * grab the data for the blob (or file) for our own in-core comparison.
  * diff_filespec has data and size fields for this purpose.
  */
-int diff_populate_filespec(struct diff_filespec *s)
+int diff_populate_filespec(struct diff_filespec *s, int size_only)
 {
 	int err = 0;
 	if (!DIFF_FILE_VALID(s))
@@ -235,6 +284,9 @@ int diff_populate_filespec(struct diff_f
 	if (S_ISDIR(s->mode))
 		return -1;
 
+	if (!use_size_cache)
+		size_only = 0;
+
 	if (s->data)
 		return err;
 	if (!s->sha1_valid ||
@@ -254,6 +306,8 @@ int diff_populate_filespec(struct diff_f
 		s->size = st.st_size;
 		if (!s->size)
 			goto empty;
+		if (size_only)
+			return 0;
 		if (S_ISLNK(st.st_mode)) {
 			int ret;
 			s->data = xmalloc(s->size);
@@ -273,9 +327,21 @@ int diff_populate_filespec(struct diff_f
 		close(fd);
 	}
 	else {
+		/* We cannot do size only for SHA1 blobs */
 		char type[20];
+		struct sha1_size_cache *e;
+
+		if (size_only) {
+			e = locate_size_cache(s->sha1, UINT_MAX);
+			if (e) {
+				s->size = e->size;
+				return 0;
+			}
+		}
 		s->data = read_sha1_file(s->sha1, type, &s->size);
 		s->should_free = 1;
+		if (s->data && size_only)
+			locate_size_cache(s->sha1, s->size);
 	}
 	return 0;
 }
@@ -361,7 +427,7 @@ static void prepare_temp_file(const char
 		return;
 	}
 	else {
-		if (diff_populate_filespec(one))
+		if (diff_populate_filespec(one, 0))
 			die("cannot read data blob for %s", one->path);
 		prep_temp_blob(temp, one->data, one->size,
 			       one->sha1, one->mode);
@@ -492,9 +558,23 @@ static void run_diff(const char *name,
 		run_external_diff(pgm, name, other, one, two, xfrm_msg);
 }
 
-void diff_setup(int reverse_diff_)
+void diff_setup(int flags)
 {
-	reverse_diff = reverse_diff_;
+	if (flags & DIFF_SETUP_REVERSE)
+		reverse_diff = 1;
+	if (flags & DIFF_SETUP_USE_CACHE) {
+		if (!active_cache)
+			/* read-cache does not die even when it fails
+			 * so it is safe for us to do this here.  Also
+			 * it does not smudge active_cache or active_nr
+			 * when it fails, so we do not have to worry about
+			 * cleaning it up oufselves either.
+			 */
+			read_cache();
+	}
+	if (flags & DIFF_SETUP_USE_SIZE_CACHE)
+		use_size_cache = 1;
+	
 }
 
 struct diff_queue_struct diff_queued_diff;
@@ -517,10 +597,18 @@ struct diff_filepair *diff_queue(struct 
 	dp->one = one;
 	dp->two = two;
 	dp->score = 0;
+	dp->source_stays = 0;
 	diff_q(queue, dp);
 	return dp;
 }
 
+void diff_free_filepair(struct diff_filepair *p)
+{
+	diff_free_filespec_data(p->one);
+	diff_free_filespec_data(p->two);
+	free(p);
+}
+
 static void diff_flush_raw(struct diff_filepair *p,
 			   int line_termination,
 			   int inter_name_termination)
@@ -615,7 +703,7 @@ static void diff_flush_patch(struct diff
 		sprintf(msg_,
 			"similarity index %d%%\n"
 			"copy from %s\n"
-			"copy to %s\n",
+			"copy to %s",
 			(int)(0.5 + p->score * 100.0/MAX_SCORE),
 			p->one->path, p->two->path);
 		msg = msg_;
@@ -624,7 +712,7 @@ static void diff_flush_patch(struct diff
 		sprintf(msg_,
 			"similarity index %d%%\n"
 			"rename old %s\n"
-			"rename new %s\n",
+			"rename new %s",
 			(int)(0.5 + p->score * 100.0/MAX_SCORE),
 			p->one->path, p->two->path);
 		msg = msg_;
@@ -639,28 +727,6 @@ static void diff_flush_patch(struct diff
 		run_diff(name, other, p->one, p->two, msg);
 }
 
-int diff_needs_to_stay(struct diff_queue_struct *q, int i,
-		       struct diff_filespec *it)
-{
-	/* If it will be used in later entry (either stay or used
-	 * as the source of rename/copy), we need to copy, not rename.
-	 */
-	while (i < q->nr) {
-		struct diff_filepair *p = q->queue[i++];
-		if (!DIFF_FILE_VALID(p->two))
-			continue; /* removed is fine */
-		if (strcmp(p->one->path, it->path))
-			continue; /* not relevant */
-
-		/* p has its src set to *it and it is not a delete;
-		 * it will be used for in-place change, rename/copy,
-		 * or just stays there.  We cannot rename it out.
-		 */
-		return 1;
-	}
-	return 0;
-}
-
 int diff_queue_is_empty(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -689,8 +755,8 @@ void diff_debug_filepair(const struct di
 {
 	diff_debug_filespec(p->one, i, "one");
 	diff_debug_filespec(p->two, i, "two");
-	fprintf(stderr, "score %d, status %c\n",
-		p->score, p->status ? : '?');
+	fprintf(stderr, "score %d, status %c source_stays %d\n",
+		p->score, p->status ? : '?', p->source_stays);
 }
 
 void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
@@ -712,8 +778,6 @@ static void diff_resolve_rename_copy(voi
 	struct diff_filepair *p, *pp;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
-	/* This should not depend on the ordering of things. */
-
 	diff_debug_queue("resolve-rename-copy", q);
 
 	for (i = 0; i < q->nr; i++) {
@@ -721,23 +785,28 @@ static void diff_resolve_rename_copy(voi
 		p->status = 0; /* undecided */
 		if (DIFF_PAIR_UNMERGED(p))
 			p->status = 'U';
-		else if (!DIFF_FILE_VALID((p)->one))
+		else if (!DIFF_FILE_VALID(p->one))
 			p->status = 'N';
-		else if (!DIFF_FILE_VALID((p)->two)) {
-			/* Deletion record should be omitted if there
-			 * are rename/copy entries using this one as
-			 * the source.  Then we can say one of them
-			 * is a rename and the rest are copies.
+		else if (!DIFF_FILE_VALID(p->two)) {
+			/* Deleted entry may have been picked up by
+			 * another rename-copy entry.  So we scan the
+			 * queue and if we find one that uses us as the
+			 * source we do not say delete for this entry.
 			 */
-			p->status = 'D';
 			for (j = 0; j < q->nr; j++) {
 				pp = q->queue[j];
-				if (!strcmp(pp->one->path, p->one->path) &&
-				    strcmp(pp->one->path, pp->two->path)) {
+				if (!strcmp(p->one->path, pp->one->path) &&
+				    pp->score) {
+					/* rename/copy are always valid
+					 * so we do not say DIFF_FILE_VALID()
+					 * on pp->one and pp->two.
+					 */
 					p->status = 'X';
 					break;
 				}
 			}
+			if (!p->status)
+				p->status = 'D';
 		}
 		else if (DIFF_PAIR_TYPE_CHANGED(p))
 			p->status = 'T';
@@ -746,33 +815,24 @@ static void diff_resolve_rename_copy(voi
 		 * whose both sides are valid and of the same type, i.e.
 		 * either in-place edit or rename/copy edit.
 		 */
-		else if (strcmp(p->one->path, p->two->path)) {
-			/* See if there is somebody else anywhere that
-			 * will keep the path (either modified or
-			 * unmodified).  If so, we have to be a copy,
-			 * not a rename.  In addition, if there is
-			 * some other rename or copy that comes later
-			 * than us that uses the same source, we
-			 * have to be a copy, not a rename.
+		else if (p->score) {
+			if (p->source_stays) {
+				p->status = 'C';
+				continue;
+			}
+			/* See if there is some other filepair that
+			 * copies from the same source as us.  If so
+			 * we are a copy.  Otherwise we are a rename.
 			 */
-			for (j = 0; j < q->nr; j++) {
+			for (j = i + 1; j < q->nr; j++) {
 				pp = q->queue[j];
 				if (strcmp(pp->one->path, p->one->path))
-					continue;
-				if (!strcmp(pp->one->path, pp->two->path)) {
-					if (DIFF_FILE_VALID(pp->two)) {
-						/* non-delete */
-						p->status = 'C';
-						break;
-					}
-					continue;
-				}
-				/* pp is a rename/copy ... */
-				if (i < j) {
-					/* ... and comes later than us */
-					p->status = 'C';
-					break;
-				}
+					continue; /* not us */
+				if (!pp->score)
+					continue; /* not a rename/copy */
+				/* pp is a rename/copy from the same source */
+				p->status = 'C';
+				break;
 			}
 			if (!p->status)
 				p->status = 'R';
@@ -781,8 +841,11 @@ static void diff_resolve_rename_copy(voi
 			 p->one->mode != p->two->mode)
 			p->status = 'M';
 		else
-			/* this is a "no-change" entry */
-			p->status = 'X';
+			/* this is a "no-change" entry.
+			 * should not happen anymore.
+			 * p->status = 'X';
+			 */
+			die("internal error in diffcore: unmodified entry remains");
 	}
 	diff_debug_queue("resolve-rename-copy done", q);
 }
@@ -817,12 +880,8 @@ void diff_flush(int diff_output_style, i
 			break;
 		}
 	}
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		diff_free_filespec_data(p->one);
-		diff_free_filespec_data(p->two);
-		free(p);
-	}
+	for (i = 0; i < q->nr; i++)
+		diff_free_filepair(q->queue[i]);
 	free(q->queue);
 	q->queue = NULL;
 	q->nr = q->alloc = 0;
@@ -883,7 +942,7 @@ void diff_helper_input(unsigned old_mode
 	if (new_mode)
 		fill_filespec(two, new_sha1, new_mode);
 	dp = diff_queue(&diff_queued_diff, one, two);
-	dp->score = score;
+	dp->score = score * MAX_SCORE / 100;
 	dp->status = status;
 }
 
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -28,22 +28,28 @@ extern void diff_unmerge(const char *pat
 
 extern int diff_scoreopt_parse(const char *opt);
 
-#define DIFF_FORMAT_HUMAN	0
-#define DIFF_FORMAT_MACHINE	1
-#define DIFF_FORMAT_PATCH	2
-#define DIFF_FORMAT_NO_OUTPUT	3
-extern void diff_setup(int reverse);
+#define DIFF_SETUP_REVERSE      	1
+#define DIFF_SETUP_USE_CACHE		2
+#define DIFF_SETUP_USE_SIZE_CACHE	4
+extern void diff_setup(int flags);
 
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
 
 extern void diffcore_rename(int rename_copy, int minimum_score);
 
-extern void diffcore_pickaxe(const char *needle);
+#define DIFF_PICKAXE_ALL	1
+extern void diffcore_pickaxe(const char *needle, int opts);
+
 extern void diffcore_pathspec(const char **pathspec);
 
 extern int diff_queue_is_empty(void);
 
+#define DIFF_FORMAT_HUMAN	0
+#define DIFF_FORMAT_MACHINE	1
+#define DIFF_FORMAT_PATCH	2
+#define DIFF_FORMAT_NO_OUTPUT	3
+
 extern void diff_flush(int output_style, int resolve_rename_copy);
 
 #endif /* DIFF_H */
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -55,11 +55,10 @@ void diffcore_pathspec(const char **path
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (matches_pathspec(p->one->path, spec, speccnt) ||
-		    matches_pathspec(p->two->path, spec, speccnt))
+		if (matches_pathspec(p->two->path, spec, speccnt))
 			diff_q(&outq, p);
 		else
-			free(p);
+			diff_free_filepair(p);
 	}
 	free(q->queue);
 	*q = outq;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -11,7 +11,7 @@ static int contains(struct diff_filespec
 {
 	unsigned long offset, sz;
 	const char *data;
-	if (diff_populate_filespec(one))
+	if (diff_populate_filespec(one, 0))
 		return 0;
 	sz = one->size;
 	data = one->data;
@@ -21,36 +21,73 @@ static int contains(struct diff_filespec
 	return 0;
 }
 
-void diffcore_pickaxe(const char *needle)
+void diffcore_pickaxe(const char *needle, int opts)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
-	int i;
+	int i, has_changes;
 	struct diff_queue_struct outq;
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
 
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		int onum = outq.nr;
-		if (!DIFF_FILE_VALID(p->one)) {
-			if (!DIFF_FILE_VALID(p->two))
-				continue; /* ignore nonsense */
-			/* created */
-			if (contains(p->two, needle, len))
-				diff_q(&outq, p);
+	if (opts & DIFF_PICKAXE_ALL) {
+		/* Showing the whole changeset if needle exists */
+		for (i = has_changes = 0; !has_changes && i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (!DIFF_FILE_VALID(p->one)) {
+				if (!DIFF_FILE_VALID(p->two))
+					continue; /* ignore unmerged */
+				/* created */
+				if (contains(p->two, needle, len))
+					has_changes++;
+			}
+			else if (!DIFF_FILE_VALID(p->two)) {
+				if (contains(p->one, needle, len))
+					has_changes++;
+			}
+			else if (!diff_unmodified_pair(p) &&
+				 contains(p->one, needle, len) !=
+				 contains(p->two, needle, len))
+				has_changes++;
 		}
-		else if (!DIFF_FILE_VALID(p->two)) {
-			if (contains(p->one, needle, len))
+		if (has_changes)
+			return; /* not munge the queue */
+
+		/* otherwise we will clear the whole queue
+		 * by copying the empty outq at the end of this
+		 * function, but first clear the current entries
+		 * in the queue.
+		 */
+		for (i = 0; i < q->nr; i++)
+			diff_free_filepair(q->queue[i]);
+	}
+	else 
+		/* Showing only the filepairs that has the needle */
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			has_changes = 0;
+			if (!DIFF_FILE_VALID(p->one)) {
+				if (!DIFF_FILE_VALID(p->two))
+					; /* ignore unmerged */
+				/* created */
+				else if (contains(p->two, needle, len))
+					has_changes = 1;
+			}
+			else if (!DIFF_FILE_VALID(p->two)) {
+				if (contains(p->one, needle, len))
+					has_changes = 1;
+			}
+			else if (!diff_unmodified_pair(p) &&
+				 contains(p->one, needle, len) !=
+				 contains(p->two, needle, len))
+				has_changes = 1;
+
+			if (has_changes)
 				diff_q(&outq, p);
+			else
+				diff_free_filepair(p);
 		}
-		else if (!diff_unmodified_pair(p) &&
-			 contains(p->one, needle, len) !=
-			 contains(p->two, needle, len))
-			diff_q(&outq, p);
-		if (onum == outq.nr)
-			free(p);
-	}
+
 	free(q->queue);
 	*q = outq;
 	return;
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -52,14 +52,15 @@ static struct diff_rename_dst *locate_re
 	return &(rename_dst[first]);
 }
 
+/* Table of rename/copy src files */
 static struct diff_rename_src {
 	struct diff_filespec *one;
-	unsigned src_used : 1;
+	unsigned src_stays : 1;
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
-static struct diff_rename_src *locate_rename_src(struct diff_filespec *one,
-						 int insert_ok)
+static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
+						   int src_stays)
 {
 	int first, last;
 
@@ -77,9 +78,7 @@ static struct diff_rename_src *locate_re
 		}
 		first = next+1;
 	}
-	/* not found */
-	if (!insert_ok)
-		return NULL;
+
 	/* insert to make it at "first" */
 	if (rename_src_alloc <= rename_src_nr) {
 		rename_src_alloc = alloc_nr(rename_src_alloc);
@@ -91,7 +90,7 @@ static struct diff_rename_src *locate_re
 		memmove(rename_src + first + 1, rename_src + first,
 			(rename_src_nr - first - 1) * sizeof(*rename_src));
 	rename_src[first].one = one;
-	rename_src[first].src_used = 0;
+	rename_src[first].src_stays = src_stays;
 	return &(rename_src[first]);
 }
 
@@ -100,8 +99,11 @@ static int is_exact_match(struct diff_fi
 	if (src->sha1_valid && dst->sha1_valid &&
 	    !memcmp(src->sha1, dst->sha1, 20))
 		return 1;
-	if (diff_populate_filespec(src) || diff_populate_filespec(dst))
-		/* this is an error but will be caught downstream */
+	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
+		return 0;
+	if (src->size != dst->size)
+		return 0;
+	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0;
 	if (src->size == dst->size &&
 	    !memcmp(src->data, dst->data, src->size))
@@ -113,7 +115,6 @@ struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
 	int score;
-	int rank;
 };
 
 static int estimate_similarity(struct diff_filespec *src,
@@ -127,9 +128,11 @@ static int estimate_similarity(struct di
 	 * dst, and then some edit has been applied to dst.
 	 *
 	 * Compare them and return how similar they are, representing
-	 * the score as an integer between 0 and 10000, except
-	 * where they match exactly it is considered better than anything
-	 * else.
+	 * the score as an integer between 0 and MAX_SCORE.
+	 *
+	 * When there is an exact match, it is considered a better
+	 * match than anything else; the destination does not even
+	 * call into this function in that case.
 	 */
 	void *delta;
 	unsigned long delta_size, base_size;
@@ -149,6 +152,7 @@ static int estimate_similarity(struct di
 	/* We would not consider edits that change the file size so
 	 * drastically.  delta_size must be smaller than
 	 * (MAX_SCORE-minimum_score)/MAX_SCORE * min(src->size, dst->size).
+	 *
 	 * Note that base_size == 0 case is handled here already
 	 * and the final score computation below would not have a
 	 * divide-by-zero issue.
@@ -156,6 +160,9 @@ static int estimate_similarity(struct di
 	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
+	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
+		return 0; /* error but caught downstream */
+
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
 			   &delta_size);
@@ -163,7 +170,7 @@ static int estimate_similarity(struct di
 	/* A delta that has a lot of literal additions would have
 	 * big delta_size no matter what else it does.
 	 */
-	if (minimum_score < MAX_SCORE * delta_size / base_size)
+	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
 	/* Estimate the edit size by interpreting delta. */
@@ -200,15 +207,14 @@ static void record_rename_pair(struct di
 	fill_filespec(two, dst->sha1, dst->mode);
 
 	dp = diff_queue(renq, one, two);
-	dp->score = score;
-
-	rename_src[src_index].src_used = 1;
+	dp->score = score ? : 1; /* make sure it is at least 1 */
+	dp->source_stays = rename_src[src_index].src_stays;
 	rename_dst[dst_index].pair = dp;
 }
 
 /*
  * We sort the rename similarity matrix with the score, in descending
- * order (more similar first).
+ * order (the most similar first).
  */
 static int score_compare(const void *a_, const void *b_)
 {
@@ -223,7 +229,7 @@ int diff_scoreopt_parse(const char *opt)
 		return -1; /* that is not a -M nor -C option */
 	diglen = strspn(opt+2, "0123456789");
 	if (diglen == 0 || strlen(opt+2) != diglen)
-		return 0; /* use default */
+		return DEFAULT_MINIMUM_SCORE; /* use default */
 	sscanf(opt+2, "%d", &num);
 	for (i = 0, scale = 1; i < diglen; i++)
 		scale *= 10;
@@ -255,9 +261,9 @@ void diffcore_rename(int detect_rename, 
 			else
 				locate_rename_dst(p->two, 1);
 		else if (!DIFF_FILE_VALID(p->two))
-			locate_rename_src(p->one, 1);
-		else if (1 < detect_rename) /* find copy, too */
-			locate_rename_src(p->one, 1);
+			register_rename_src(p->one, 0);
+		else if (detect_rename == DIFF_DETECT_COPY)
+			register_rename_src(p->one, 1);
 	}
 	if (rename_dst_nr == 0)
 		goto cleanup; /* nothing to do */
@@ -308,7 +314,7 @@ void diffcore_rename(int detect_rename, 
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
 		if (mx[i].score < minimum_score)
-			break; /* there is not any more diffs applicable. */
+			break; /* there is no more usable pair. */
 		record_rename_pair(&renq, mx[i].dst, mx[i].src, mx[i].score);
 	}
 	free(mx);
@@ -317,28 +323,21 @@ void diffcore_rename(int detect_rename, 
  flush_rest:
 	/* At this point, we have found some renames and copies and they
 	 * are kept in renq.  The original list is still in *q.
-	 *
-	 * Scan the original list and move them into the outq; we will sort
-	 * outq and swap it into the queue supplied to pass that to
-	 * downstream, so we assign the sort keys in this loop.
-	 *
-	 * See comments at the top of record_rename_pair for numbers used
-	 * to assign rename_rank.
 	 */
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct diff_rename_src *src = locate_rename_src(p->one, 0);
 		struct diff_rename_dst *dst = locate_rename_dst(p->two, 0);
 		struct diff_filepair *pair_to_free = NULL;
 
 		if (dst) {
 			/* creation */
 			if (dst->pair) {
-				/* renq has rename/copy already to produce
-				 * this file, so we do not emit the creation
-				 * record in the output.
+				/* renq has rename/copy to produce
+				 * this file already, so we do not
+				 * emit the creation record in the
+				 * output.
 				 */
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
@@ -350,25 +349,17 @@ void diffcore_rename(int detect_rename, 
 				diff_q(&outq, p);
 		}
 		else if (!diff_unmodified_pair(p))
-			/* all the other cases need to be recorded as is */
+			/* all the usual ones need to be kept */
 			diff_q(&outq, p);
-		else {
-			/* unmodified pair needs to be recorded only if
-			 * it is used as the source of rename/copy
-			 */
-			if (src && src->src_used)
-				diff_q(&outq, p);
-			else
-				pair_to_free = p;
-		}
-		if (pair_to_free) {
-			diff_free_filespec_data(pair_to_free->one);
-			diff_free_filespec_data(pair_to_free->two);
-			free(pair_to_free);
-		}
+		else
+			/* no need to keep unmodified pairs */
+			pair_to_free = p;
+
+		if (pair_to_free)
+			diff_free_filepair(pair_to_free);
 	}
 	diff_debug_queue("done copying original", &outq);
-
+	
 	free(renq.queue);
 	free(q->queue);
 	*q = outq;
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -33,14 +33,17 @@ extern struct diff_filespec *alloc_files
 extern void fill_filespec(struct diff_filespec *, const unsigned char *,
 			  unsigned short);
 
-extern int diff_populate_filespec(struct diff_filespec *);
+extern int diff_populate_filespec(struct diff_filespec *, int);
 extern void diff_free_filespec_data(struct diff_filespec *);
 
 struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
-	int score; /* only valid when one and two are different paths */
-	int status; /* M C R N D U (see Documentation/diff-format.txt) */
+	unsigned short int score; /* only valid when one and two are
+				   * different paths
+				   */
+	char source_stays; /* all of R/C are copies */
+	char status; /* M C R N D U (see Documentation/diff-format.txt) */
 };
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
@@ -54,6 +57,8 @@ struct diff_filepair {
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
 
+extern void diff_free_filepair(struct diff_filepair *);
+
 extern int diff_unmodified_pair(struct diff_filepair *);
 
 struct diff_queue_struct {
@@ -68,9 +73,6 @@ extern struct diff_filepair *diff_queue(
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
-extern int diff_needs_to_stay(struct diff_queue_struct *, int,
-			      struct diff_filespec *);
-
 #define DIFF_DEBUG 0
 #if DIFF_DEBUG
 void diff_debug_filespec(struct diff_filespec *, int, const char *);
diff --git a/git-external-diff-script b/git-external-diff-script
--- a/git-external-diff-script
+++ b/git-external-diff-script
@@ -59,7 +59,7 @@ then
     echo "new mode $mode2"
     if test "$xfrm_msg" != ""
     then
-	echo -n $xfrm_msg
+	echo "$xfrm_msg"
     fi
 fi
 diff ${GIT_DIFF_OPTS-'-pu'} -L "a/$name1" -L "b/$name2" "$tmp1" "$tmp2"
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
new file mode 100755
--- /dev/null
+++ b/t/t4007-rename-3.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Rename interaction with pathspec.
+
+'
+. ./test-lib.sh
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sanitize_diff_raw='s/ \('"$_x40"'\) \1 \([CR]\)[0-9]*	/ \1 \1 \2#	/'
+compare_diff_raw () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    # Also we do not check SHA1 hash generation in this test, which
+    # is a job for t0000-basic.sh
+
+    sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
+    sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+test_expect_success \
+    'prepare reference tree' \
+    'mkdir path0 path1 &&
+     cp ../../COPYING path0/COPYING &&
+     git-update-cache --add path0/COPYING &&
+    tree=$(git-write-tree) &&
+    echo $tree'
+
+test_expect_success \
+    'prepare work tree' \
+    'cp path0/COPYING path1/COPYING &&
+     git-update-cache --add --remove path0/COPYING path1/COPYING'
+
+# In the tree, there is only path0/COPYING.  In the cache, path0 and
+# path1 both have COPYING and the latter is a copy of path0/COPYING.
+# Comparing the full tree with cache should tell us so.
+
+git-diff-cache -C $tree >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	path0/COPYING	path1/COPYING
+EOF
+
+test_expect_success \
+    'validate the result' \
+    'compare_diff_raw current expected'
+
+# In the tree, there is only path0/COPYING.  In the cache, path0 and
+# path1 both have COPYING and the latter is a copy of path0/COPYING.
+# When we omit output from path0 it should still be able to tell us
+# that path1/COPYING is result from a copy from path0/COPYING, not
+# rename, which would imply path0/COPYING is now gone.
+
+git-diff-cache -C $tree path1 >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	path0/COPYING	path1/COPYING
+EOF
+
+test_expect_success \
+    'validate the result' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'tweak work tree' \
+    'rm -f path0/COPYING &&
+     git-update-cache --remove path0/COPYING'
+
+# In the tree, there is only path0/COPYING.  In the cache, path0 does
+# not have COPYING anymore and path1 has COPYING which is a copy of
+# path0/COPYING.  Showing the full tree with cache should tell us about
+# the rename.
+
+git-diff-cache -C $tree >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	path0/COPYING	path1/COPYING
+EOF
+
+test_expect_success \
+    'validate the result' \
+    'compare_diff_raw current expected'
+
+# In the tree, there is only path0/COPYING.  In the cache, path0 does
+# not have COPYING anymore and path1 has COPYING which is a copy of
+# path0/COPYING.  Even if we restrict the output to path1, it still
+# should show us the rename.
+
+git-diff-cache -C $tree path1 >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	path0/COPYING	path1/COPYING
+EOF
+
+test_expect_success \
+    'validate the result' \
+    'compare_diff_raw current expected'
+
+test_done
\ No newline at end of file
------------------------------------------------

