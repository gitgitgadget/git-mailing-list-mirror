From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 12/12] Optimize diff-tree -[CM] --stdin
Date: Fri, 27 May 2005 15:56:38 -0700
Message-ID: <7vhdgo2s7t.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:56:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbnjv-0002RG-95
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVE0W5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVE0W5r
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:57:47 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:30430 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262651AbVE0W4k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:56:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225639.OVEL550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:56:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This attempts to optimize "diff-tree -[CM] --stdin", which
compares successible tree pairs.  This optimization does not
make much sense for other commands in the diff-* brothers.

When reading from --stdin and using rename/copy detection, the
patch makes diff-tree to read the current index file first.
This is done to reuse the optimization used by diff-cache in the
non-cached case.  Similarity estimator can avoid expanding a
blob if the index says what is in the work tree has an exact
copy of that blob already expanded.

Another optimization the patch makes is to check only file sizes
first to terminate similarity estimation early.  In order for
this to work, it needs a way to tell the size of the blob
without expanding it.  Since an obvious way of doing it, which
is to keep all the blobs previously used in the memory, is too
costly, it does so by keeping the filesize for each object it
has already seen in memory.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree.c        |    3 +
diff.c             |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++--
diff.h             |    2 +
diffcore-pickaxe.c |    2 -
diffcore-rename.c  |   19 ++++++++----
diffcore.h         |    2 -
6 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -578,6 +578,9 @@ int main(int argc, const char **argv)
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
@@ -496,6 +562,19 @@ void diff_setup(int flags)
 {
 	if (flags & DIFF_SETUP_REVERSE)
 		reverse_diff = 1;
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
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -29,6 +29,8 @@ extern void diff_unmerge(const char *pat
 extern int diff_scoreopt_parse(const char *opt);
 
 #define DIFF_SETUP_REVERSE      	1
+#define DIFF_SETUP_USE_CACHE		2
+#define DIFF_SETUP_USE_SIZE_CACHE	4
 extern void diff_setup(int flags);
 
 #define DIFF_DETECT_RENAME	1
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
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -99,8 +99,11 @@ static int is_exact_match(struct diff_fi
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
@@ -125,9 +128,11 @@ static int estimate_similarity(struct di
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
@@ -147,6 +152,7 @@ static int estimate_similarity(struct di
 	/* We would not consider edits that change the file size so
 	 * drastically.  delta_size must be smaller than
 	 * (MAX_SCORE-minimum_score)/MAX_SCORE * min(src->size, dst->size).
+	 *
 	 * Note that base_size == 0 case is handled here already
 	 * and the final score computation below would not have a
 	 * divide-by-zero issue.
@@ -154,6 +160,9 @@ static int estimate_similarity(struct di
 	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
+	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
+		return 0; /* error but caught downstream */
+
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
 			   &delta_size);
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -33,7 +33,7 @@ extern struct diff_filespec *alloc_files
 extern void fill_filespec(struct diff_filespec *, const unsigned char *,
 			  unsigned short);
 
-extern int diff_populate_filespec(struct diff_filespec *);
+extern int diff_populate_filespec(struct diff_filespec *, int);
 extern void diff_free_filespec_data(struct diff_filespec *);
 
 struct diff_filepair {
------------------------------------------------

