From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH]  Removed static variables in blame for catering reuse of
 blame code
Date: Sat, 14 Mar 2009 01:03:08 -0700
Message-ID: <7vd4ckcz0j.fsf@gitster.siamese.dyndns.org>
References: <49B8E42B.30901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: pi song <pi.songs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 09:05:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiOrY-0006d0-Ss
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 09:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbZCNIDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 04:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbZCNIDX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 04:03:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZCNIDS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 04:03:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4525359F1;
	Sat, 14 Mar 2009 04:03:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83B6859F0; Sat,
 14 Mar 2009 04:03:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91971176-106E-11DE-BADA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113242>

pi song <pi.songs@gmail.com> writes:

> diff --git a/builtin-blame.c b/builtin-blame.c
> index 2aedd17..2e19ddf 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -30,42 +30,29 @@ static const char *blame_opt_usage[] = {
>  	NULL
>  };
>  
> -static int longest_file;
> -static int longest_author;
> ...
> -static int num_read_blob;
> -static int num_get_patch;
> -static int num_commits;

I eyeballed the above removals and the additions to the new structure and
they match, which is good.

I'd suggest removing the blame_stat and make its members part of the
super-scoreboard, though.

>  /*
> - * Given an origin, prepare mmfile_t structure to be used by the
> - * diff machinery
> - */
> -static void fill_origin_blob(struct origin *o, mmfile_t *file)
> ...
> -static void drop_origin_blob(struct origin *o)
> -{
> -	if (o->file.ptr) {
> -		free(o->file.ptr);
> -		o->file.ptr = NULL;
> -	}
> -}

I do not see why you had to have this huge block of removed lines, and
another identcal huge block of added lines later.

> -/*
>   * Each group of lines is described by a blame_entry; it can be split
>   * as we pass blame to the parents.  They form a linked list in the
>   * scoreboard structure, sorted by the target line number.
> @@ -176,6 +113,47 @@ struct blame_entry {
>  };
>  
>  /*
> + * stores things that survive across multiple blame operations
> + * 1) for blame specific global parameters
> + * 2) for reusable structures (possibly for optimization purpose)
> + */
> +struct super_scoreboard {

If your goal is to make a blame library out of this, I think "scoreboard"
should be renamed to "blame_scoreboard".  And this should be called
something like "blame_info".

> +/*
> + * Given an origin, prepare mmfile_t structure to be used by the
> + * diff machinery
> + */
> +static void fill_origin_blob(struct scoreboard *sb, struct origin *o, mmfile_t *file)
> +{

When the original function did not take "scoreboard", please do *not* add
scoreboard as a new parameter.  Instead, make it directly take the overall
blame state "super_scoreboard" (or even narrower subpart of it when you
can).  That way, when somebody later study the code, they can immediately
see that such a function does not affect what is in the scoreboard
(i.e. how the blame is passed around).

> +/*
> + * Origin is refcounted and usually we keep the blob contents to be
> + * reused.
> + */
> +static inline struct origin *origin_incref(struct origin *o)
> +...
> +static void drop_origin_blob(struct origin *o)
> +{
> +	if (o->file.ptr) {
> +		free(o->file.ptr);
> +		o->file.ptr = NULL;
> +	}
> +}

These look like duplicated/moved for no good reason.

> @@ -1122,17 +1153,21 @@ static void pass_whole_blame(struct scoreboard *sb,
>   * "parent" (and "porigin"), but what we mean is to find scapegoat to
>   * exonerate ourselves.
>   */
> -static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
> +static struct commit_list *first_scapegoat(struct scoreboard *sb, 

Same comment as fill_origin_blob() applies here.

> -static int num_scapegoats(struct rev_info *revs, struct commit *commit)
> +static int num_scapegoats(struct scoreboard *sb,

Likewise.

> @@ -1274,8 +1309,8 @@ struct commit_info
>  /*
>   * Parse author/committer line in the commit object buffer
>   */
> -static void get_ac_line(const char *inbuf, const char *what,
> -			int person_len, char *person,
> +static void get_ac_line(struct scoreboard *sb, const char *inbuf, 

Likewise.  You only need the mailmap here.

> @@ -1349,7 +1384,8 @@ static void get_ac_line(const char *inbuf, const char *what,
>  	}
>  }
>  
> -static void get_commit_info(struct commit *commit,
> +static void get_commit_info(struct scoreboard *sb,

Likewise.

> @@ -1430,7 +1466,8 @@ static void write_filename_info(const char *path)
>   * commit.  Instead of repeating this every line, emit it only once,
>   * the first time each commit appears in the output.
>   */
> -static int emit_one_suspect_detail(struct origin *suspect)
> +static int emit_one_suspect_detail(struct scoreboard *sb, 
> +				   struct origin *suspect)

Likewise.

> @@ -1462,18 +1499,18 @@ static int emit_one_suspect_detail(struct origin *suspect)
>   * The blame_entry is found to be guilty for the range.  Mark it
>   * as such, and show it in incremental output.
>   */
> -static void found_guilty_entry(struct blame_entry *ent)
> +static void found_guilty_entry(struct scoreboard *sb, struct blame_entry *ent)

Likewise.

> @@ -1532,8 +1569,8 @@ static void assign_blame(struct scoreboard *sb, int opt)
>  	}
>  }
>  
> -static const char *format_time(unsigned long time, const char *tz_str,
> -			       int show_raw_time)
> +static const char *format_time(struct scoreboard *sb, unsigned long time, 

Likewise.

Here is a fixed-up replacement along the lines I suggested above, except
that I did not bother getting rid of "struct blame_stat".

I've also fixed up a few style violations I noticed and fixed up the
commit log message a bit.

-- >8 --
From: pi song <pi.songs@gmail.com>
Date: Thu, 12 Mar 2009 21:30:03 +1100
Subject: [PATCH] blame.c: start libifying the blame infrastructure

The patch refactors builtin-blame.c to not rely on static variables by
introducing a "blame_info" structure and moving them into it.  While at
it, "scoreboard" is renamed to "blame_scoreboard".

We can later use a same blame_info that holds the settings with different
scoreboards to run blame multiple times on different data.

Signed-off-by: Pi Song <pi.songs@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c |  365 +++++++++++++++++++++++++++++++------------------------
 1 files changed, 205 insertions(+), 160 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 2aedd17..efac5d4 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -30,42 +30,29 @@ static const char *blame_opt_usage[] = {
 	NULL
 };
 
-static int longest_file;
-static int longest_author;
-static int max_orig_digits;
-static int max_digits;
-static int max_score_digits;
-static int show_root;
-static int reverse;
-static int blank_boundary;
-static int incremental;
-static int xdl_opts = XDF_NEED_MINIMAL;
-
-static enum date_mode blame_date_mode = DATE_ISO8601;
-static size_t blame_date_width;
-
-static struct string_list mailmap;
+/* only use for command line parameter parsing */
+static unsigned opt_blame_move_score;
1+static unsigned opt_blame_copy_score;
 
 #ifndef DEBUG
 #define DEBUG 0
 #endif
 
-/* stats */
-static int num_read_blob;
-static int num_get_patch;
-static int num_commits;
+/*
+ * for storing stats. it can be used
+ * across multiple blame operations
+ */
+struct blame_stat {
+	int num_read_blob;
+	int num_get_patch;
+	int num_commits;
+};
 
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
 #define PICKAXE_BLAME_COPY_HARDER	04
 #define PICKAXE_BLAME_COPY_HARDEST	010
 
-/*
- * blame for a blame_entry with score lower than these thresholds
- * is not passed to the parent using move/copy logic.
- */
-static unsigned blame_move_score;
-static unsigned blame_copy_score;
 #define BLAME_DEFAULT_MOVE_SCORE	20
 #define BLAME_DEFAULT_COPY_SCORE	40
 
@@ -86,14 +73,55 @@ struct origin {
 };
 
 /*
+ * stores things that survive across multiple blame operations
+ * 1) for blame specific global parameters
+ * 2) for reusable structures (possibly for optimization purpose)
+ */
+struct blame_info {
+	/*
+	 * miscellaneous parameters collected during processing
+	 * for pretty formatting purpose
+	 */
+	int longest_file;
+	int longest_author;
+	int max_orig_digits;
+	int max_digits;
+	int max_score_digits;
+
+	/* formatting parameters */
+	int show_root;
+	int reverse;
+	int blank_boundary;
+	int incremental;
+	int xdl_opts;
+
+	/*
+	 * blame for a blame_entry with score lower than these thresholds
+	 * is not passed to the parent using move/copy logic.
+	 */
+	unsigned blame_move_score;
+	unsigned blame_copy_score;
+
+	/* date formatting related */
+	enum date_mode blame_date_mode;
+	size_t blame_date_width;
+
+	/* for fast mailmap lookup */
+	struct string_list mailmap;
+
+	/* for stat collecting purpose */
+	struct blame_stat *stat;
+};
+
+/*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
-static void fill_origin_blob(struct origin *o, mmfile_t *file)
+static void fill_origin_blob(struct blame_info *ssb, struct origin *o, mmfile_t *file)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
-		num_read_blob++;
+		ssb->stat->num_read_blob++;
 		file->ptr = read_sha1_file(o->blob_sha1, &type,
 					   (unsigned long *)(&(file->size)));
 		if (!file->ptr)
@@ -178,7 +206,7 @@ struct blame_entry {
 /*
  * The current state of the blame assignment.
  */
-struct scoreboard {
+struct blame_scoreboard {
 	/* the final commit (i.e. where we started digging from) */
 	struct commit *final;
 	struct rev_info *revs;
@@ -198,6 +226,8 @@ struct scoreboard {
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
+
+	struct blame_info *ssb;
 };
 
 static inline int same_suspect(struct origin *a, struct origin *b)
@@ -209,14 +239,14 @@ static inline int same_suspect(struct origin *a, struct origin *b)
 	return !strcmp(a->path, b->path);
 }
 
-static void sanity_check_refcnt(struct scoreboard *);
+static void sanity_check_refcnt(struct blame_scoreboard *);
 
 /*
  * If two blame entries that are next to each other came from
  * contiguous lines in the same origin (i.e. <commit, path> pair),
  * merge them together.
  */
-static void coalesce(struct scoreboard *sb)
+static void coalesce(struct blame_scoreboard *sb)
 {
 	struct blame_entry *ent, *next;
 
@@ -258,7 +288,7 @@ static struct origin *make_origin(struct commit *commit, const char *path)
 /*
  * Locate an existing origin or create a new one.
  */
-static struct origin *get_origin(struct scoreboard *sb,
+static struct origin *get_origin(struct blame_scoreboard *sb,
 				 struct commit *commit,
 				 const char *path)
 {
@@ -301,7 +331,7 @@ static int fill_blob_sha1(struct origin *origin)
  * We have an origin -- check if the same path exists in the
  * parent and return an origin structure to represent it.
  */
-static struct origin *find_origin(struct scoreboard *sb,
+static struct origin *find_origin(struct blame_scoreboard *sb,
 				  struct commit *parent,
 				  struct origin *origin)
 {
@@ -409,7 +439,7 @@ static struct origin *find_origin(struct scoreboard *sb,
  * We have an origin -- find the path that corresponds to it in its
  * parent and return an origin structure to represent it.
  */
-static struct origin *find_rename(struct scoreboard *sb,
+static struct origin *find_rename(struct blame_scoreboard *sb,
 				  struct commit *parent,
 				  struct origin *origin)
 {
@@ -454,7 +484,7 @@ static struct origin *find_rename(struct scoreboard *sb,
  * Link in a new blame entry to the scoreboard.  Entries that cover the
  * same line range have been removed from the scoreboard previously.
  */
-static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
+static void add_blame_entry(struct blame_scoreboard *sb, struct blame_entry *e)
 {
 	struct blame_entry *ent, *prev = NULL;
 
@@ -497,7 +527,7 @@ static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
 	dst->score = 0;
 }
 
-static const char *nth_line(struct scoreboard *sb, int lno)
+static const char *nth_line(struct blame_scoreboard *sb, int lno)
 {
 	return sb->final_buf + sb->lineno[lno];
 }
@@ -564,7 +594,7 @@ static void split_overlap(struct blame_entry *split,
  * in split.  Adjust the linked list of blames in the scoreboard to
  * reflect the split.
  */
-static void split_blame(struct scoreboard *sb,
+static void split_blame(struct blame_scoreboard *sb,
 			struct blame_entry *split,
 			struct blame_entry *e)
 {
@@ -646,7 +676,7 @@ static void decref_split(struct blame_entry *split)
  * Helper for blame_chunk().  blame_entry e is known to overlap with
  * the patch hunk; split it and pass blame to the parent.
  */
-static void blame_overlap(struct scoreboard *sb, struct blame_entry *e,
+static void blame_overlap(struct blame_scoreboard *sb, struct blame_entry *e,
 			  int tlno, int plno, int same,
 			  struct origin *parent)
 {
@@ -661,7 +691,7 @@ static void blame_overlap(struct scoreboard *sb, struct blame_entry *e,
 /*
  * Find the line number of the last line the target is suspected for.
  */
-static int find_last_in_target(struct scoreboard *sb, struct origin *target)
+static int find_last_in_target(struct blame_scoreboard *sb, struct origin *target)
 {
 	struct blame_entry *e;
 	int last_in_target = -1;
@@ -680,7 +710,7 @@ static int find_last_in_target(struct scoreboard *sb, struct origin *target)
  * blame_entry e and its parent.  Find and split the overlap, and
  * pass blame to the overlapping part to the parent.
  */
-static void blame_chunk(struct scoreboard *sb,
+static void blame_chunk(struct blame_scoreboard *sb,
 			int tlno, int plno, int same,
 			struct origin *target, struct origin *parent)
 {
@@ -697,7 +727,7 @@ static void blame_chunk(struct scoreboard *sb,
 }
 
 struct blame_chunk_cb_data {
-	struct scoreboard *sb;
+	struct blame_scoreboard *sb;
 	struct origin *target;
 	struct origin *parent;
 	long plno;
@@ -717,7 +747,7 @@ static void blame_chunk_cb(void *data, long same, long p_next, long t_next)
  * for the lines it is suspected to its parent.  Run diff to find
  * which lines came from parent and pass blame for them.
  */
-static int pass_blame_to_parent(struct scoreboard *sb,
+static int pass_blame_to_parent(struct blame_scoreboard *sb,
 				struct origin *target,
 				struct origin *parent)
 {
@@ -731,12 +761,12 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
 
-	fill_origin_blob(parent, &file_p);
-	fill_origin_blob(target, &file_o);
-	num_get_patch++;
+	fill_origin_blob(sb->ssb, parent, &file_p);
+	fill_origin_blob(sb->ssb, target, &file_o);
+	sb->ssb->stat->num_get_patch++;
 
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = xdl_opts;
+	xpp.flags = sb->ssb->xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 0;
 	xdi_diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, &xpp, &xecfg);
@@ -755,7 +785,7 @@ static int pass_blame_to_parent(struct scoreboard *sb,
  *
  * Compute how trivial the lines in the blame_entry are.
  */
-static unsigned ent_score(struct scoreboard *sb, struct blame_entry *e)
+static unsigned ent_score(struct blame_scoreboard *sb, struct blame_entry *e)
 {
 	unsigned score;
 	const char *cp, *ep;
@@ -782,7 +812,7 @@ static unsigned ent_score(struct scoreboard *sb, struct blame_entry *e)
  * so far, by comparing this and best_so_far and copying this into
  * bst_so_far as needed.
  */
-static void copy_split_if_better(struct scoreboard *sb,
+static void copy_split_if_better(struct blame_scoreboard *sb,
 				 struct blame_entry *best_so_far,
 				 struct blame_entry *this)
 {
@@ -816,7 +846,7 @@ static void copy_split_if_better(struct scoreboard *sb,
  *
  * All line numbers are 0-based.
  */
-static void handle_split(struct scoreboard *sb,
+static void handle_split(struct blame_scoreboard *sb,
 			 struct blame_entry *ent,
 			 int tlno, int plno, int same,
 			 struct origin *parent,
@@ -835,7 +865,7 @@ static void handle_split(struct scoreboard *sb,
 }
 
 struct handle_split_cb_data {
-	struct scoreboard *sb;
+	struct blame_scoreboard *sb;
 	struct blame_entry *ent;
 	struct origin *parent;
 	struct blame_entry *split;
@@ -856,7 +886,7 @@ static void handle_split_cb(void *data, long same, long p_next, long t_next)
  * we can pass blames to it.  file_p has the blob contents for
  * the parent.
  */
-static void find_copy_in_blob(struct scoreboard *sb,
+static void find_copy_in_blob(struct blame_scoreboard *sb,
 			      struct blame_entry *ent,
 			      struct origin *parent,
 			      struct blame_entry *split,
@@ -887,7 +917,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	 * file_p partially may match that image.
 	 */
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = xdl_opts;
+	xpp.flags = sb->ssb->xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 1;
 	memset(split, 0, sizeof(struct blame_entry [3]));
@@ -900,7 +930,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
  * See if lines currently target is suspected for can be attributed to
  * parent.
  */
-static int find_move_in_parent(struct scoreboard *sb,
+static int find_move_in_parent(struct blame_scoreboard *sb,
 			       struct origin *target,
 			       struct origin *parent)
 {
@@ -912,7 +942,7 @@ static int find_move_in_parent(struct scoreboard *sb,
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
 
-	fill_origin_blob(parent, &file_p);
+	fill_origin_blob(sb->ssb, parent, &file_p);
 	if (!file_p.ptr)
 		return 0;
 
@@ -921,11 +951,11 @@ static int find_move_in_parent(struct scoreboard *sb,
 		made_progress = 0;
 		for (e = sb->ent; e; e = e->next) {
 			if (e->guilty || !same_suspect(e->suspect, target) ||
-			    ent_score(sb, e) < blame_move_score)
+			    ent_score(sb, e) < sb->ssb->blame_move_score)
 				continue;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
 			if (split[1].suspect &&
-			    blame_move_score < ent_score(sb, &split[1])) {
+			    sb->ssb->blame_move_score < ent_score(sb, &split[1])) {
 				split_blame(sb, split, e);
 				made_progress = 1;
 			}
@@ -944,7 +974,7 @@ struct blame_list {
  * Count the number of entries the target is suspected for,
  * and prepare a list of entry and the best split.
  */
-static struct blame_list *setup_blame_list(struct scoreboard *sb,
+static struct blame_list *setup_blame_list(struct blame_scoreboard *sb,
 					   struct origin *target,
 					   int min_score,
 					   int *num_ents_p)
@@ -973,7 +1003,7 @@ static struct blame_list *setup_blame_list(struct scoreboard *sb,
 /*
  * Reset the scanned status on all entries.
  */
-static void reset_scanned_flag(struct scoreboard *sb)
+static void reset_scanned_flag(struct blame_scoreboard *sb)
 {
 	struct blame_entry *e;
 	for (e = sb->ent; e; e = e->next)
@@ -985,7 +1015,7 @@ static void reset_scanned_flag(struct scoreboard *sb)
  * across file boundary from the parent commit.  porigin is the path
  * in the parent we already tried.
  */
-static int find_copy_in_parent(struct scoreboard *sb,
+static int find_copy_in_parent(struct blame_scoreboard *sb,
 			       struct origin *target,
 			       struct commit *parent,
 			       struct origin *porigin,
@@ -998,7 +1028,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	struct blame_list *blame_list;
 	int num_ents;
 
-	blame_list = setup_blame_list(sb, target, blame_copy_score, &num_ents);
+	blame_list = setup_blame_list(sb, target, sb->ssb->blame_copy_score, &num_ents);
 	if (!blame_list)
 		return 1; /* nothing remains for this target */
 
@@ -1053,7 +1083,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 
 			norigin = get_origin(sb, parent, p->one->path);
 			hashcpy(norigin->blob_sha1, p->one->sha1);
-			fill_origin_blob(norigin, &file_p);
+			fill_origin_blob(sb->ssb, norigin, &file_p);
 			if (!file_p.ptr)
 				continue;
 
@@ -1070,7 +1100,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 		for (j = 0; j < num_ents; j++) {
 			struct blame_entry *split = blame_list[j].split;
 			if (split[1].suspect &&
-			    blame_copy_score < ent_score(sb, &split[1])) {
+			    sb->ssb->blame_copy_score < ent_score(sb, &split[1])) {
 				split_blame(sb, split, blame_list[j].ent);
 				made_progress = 1;
 			}
@@ -1082,7 +1112,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 
 		if (!made_progress)
 			break;
-		blame_list = setup_blame_list(sb, target, blame_copy_score, &num_ents);
+		blame_list = setup_blame_list(sb, target, sb->ssb->blame_copy_score, &num_ents);
 		if (!blame_list) {
 			retval = 1;
 			break;
@@ -1098,7 +1128,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
  * The blobs of origin and porigin exactly match, so everything
  * origin is suspected for can be blamed on the parent.
  */
-static void pass_whole_blame(struct scoreboard *sb,
+static void pass_whole_blame(struct blame_scoreboard *sb,
 			     struct origin *origin, struct origin *porigin)
 {
 	struct blame_entry *e;
@@ -1122,17 +1152,21 @@ static void pass_whole_blame(struct scoreboard *sb,
  * "parent" (and "porigin"), but what we mean is to find scapegoat to
  * exonerate ourselves.
  */
-static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
+static struct commit_list *first_scapegoat(struct blame_info *ssb,
+					   struct rev_info *revs,
+					   struct commit *commit)
 {
-	if (!reverse)
+	if (!ssb->reverse)
 		return commit->parents;
 	return lookup_decoration(&revs->children, &commit->object);
 }
 
-static int num_scapegoats(struct rev_info *revs, struct commit *commit)
+static int num_scapegoats(struct blame_info *ssb,
+			  struct rev_info *revs,
+			  struct commit *commit)
 {
 	int cnt;
-	struct commit_list *l = first_scapegoat(revs, commit);
+	struct commit_list *l = first_scapegoat(ssb, revs, commit);
 	for (cnt = 0; l; l = l->next)
 		cnt++;
 	return cnt;
@@ -1140,7 +1174,7 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit)
 
 #define MAXSG 16
 
-static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
+static void pass_blame(struct blame_scoreboard *sb, struct origin *origin, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	int i, pass, num_sg;
@@ -1149,7 +1183,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	struct origin *sg_buf[MAXSG];
 	struct origin *porigin, **sg_origin = sg_buf;
 
-	num_sg = num_scapegoats(revs, commit);
+	num_sg = num_scapegoats(sb->ssb, revs, commit);
 	if (!num_sg)
 		goto finish;
 	else if (num_sg < ARRAY_SIZE(sg_buf))
@@ -1162,11 +1196,11 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * common cases, then we look for renames in the second pass.
 	 */
 	for (pass = 0; pass < 2; pass++) {
-		struct origin *(*find)(struct scoreboard *,
+		struct origin *(*find)(struct blame_scoreboard *,
 				       struct commit *, struct origin *);
 		find = pass ? find_rename : find_origin;
 
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct commit *p = sg->item;
@@ -1198,8 +1232,8 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		}
 	}
 
-	num_commits++;
-	for (i = 0, sg = first_scapegoat(revs, commit);
+	sb->ssb->stat->num_commits++;
+	for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
 		struct origin *porigin = sg_origin[i];
@@ -1217,7 +1251,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find moves in parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_MOVE)
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct origin *porigin = sg_origin[i];
@@ -1231,7 +1265,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find copies from parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_COPY)
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(sb->ssb, revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct origin *porigin = sg_origin[i];
@@ -1274,8 +1308,8 @@ struct commit_info
 /*
  * Parse author/committer line in the commit object buffer
  */
-static void get_ac_line(const char *inbuf, const char *what,
-			int person_len, char *person,
+static void get_ac_line(struct string_list *mailmap, const char *inbuf,
+			const char *what, int person_len, char *person,
 			int mail_len, char *mail,
 			unsigned long *time, const char **tz)
 {
@@ -1323,7 +1357,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	maillen = timepos - tmp;
 	memcpy(mail, mailpos, maillen);
 
-	if (!mailmap.nr)
+	if (!mailmap->nr)
 		return;
 
 	/*
@@ -1338,7 +1372,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	/*
 	 * Now, convert both name and e-mail using mailmap
 	 */
-	if(map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
+	if (map_user(mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
 		/* Add a trailing '>' to email, since map_user returns plain emails
 		   Note: It already has '<', since we replace from mail+1 */
 		mailpos = memchr(mail, '\0', mail_len);
@@ -1349,7 +1383,8 @@ static void get_ac_line(const char *inbuf, const char *what,
 	}
 }
 
-static void get_commit_info(struct commit *commit,
+static void get_commit_info(struct string_list *mailmap,
+			    struct commit *commit,
 			    struct commit_info *ret,
 			    int detailed)
 {
@@ -1378,7 +1413,7 @@ static void get_commit_info(struct commit *commit,
 	message   = reencoded ? reencoded : commit->buffer;
 	ret->author = author_name;
 	ret->author_mail = author_mail;
-	get_ac_line(message, "\nauthor ",
+	get_ac_line(mailmap, message, "\nauthor ",
 		    sizeof(author_name), author_name,
 		    sizeof(author_mail), author_mail,
 		    &ret->author_time, &ret->author_tz);
@@ -1390,7 +1425,7 @@ static void get_commit_info(struct commit *commit,
 
 	ret->committer = committer_name;
 	ret->committer_mail = committer_mail;
-	get_ac_line(message, "\ncommitter ",
+	get_ac_line(mailmap, message, "\ncommitter ",
 		    sizeof(committer_name), committer_name,
 		    sizeof(committer_mail), committer_mail,
 		    &ret->committer_time, &ret->committer_tz);
@@ -1430,7 +1465,8 @@ static void write_filename_info(const char *path)
  * commit.  Instead of repeating this every line, emit it only once,
  * the first time each commit appears in the output.
  */
-static int emit_one_suspect_detail(struct origin *suspect)
+static int emit_one_suspect_detail(struct string_list *mailmap,
+				   struct origin *suspect)
 {
 	struct commit_info ci;
 
@@ -1438,7 +1474,7 @@ static int emit_one_suspect_detail(struct origin *suspect)
 		return 0;
 
 	suspect->commit->object.flags |= METAINFO_SHOWN;
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(mailmap, suspect->commit, &ci, 1);
 	printf("author %s\n", ci.author);
 	printf("author-mail %s\n", ci.author_mail);
 	printf("author-time %lu\n", ci.author_time);
@@ -1462,18 +1498,18 @@ static int emit_one_suspect_detail(struct origin *suspect)
  * The blame_entry is found to be guilty for the range.  Mark it
  * as such, and show it in incremental output.
  */
-static void found_guilty_entry(struct blame_entry *ent)
+static void found_guilty_entry(struct blame_info *ssb, struct blame_entry *ent)
 {
 	if (ent->guilty)
 		return;
 	ent->guilty = 1;
-	if (incremental) {
+	if (ssb->incremental) {
 		struct origin *suspect = ent->suspect;
 
 		printf("%s %d %d %d\n",
 		       sha1_to_hex(suspect->commit->object.sha1),
 		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
-		emit_one_suspect_detail(suspect);
+		emit_one_suspect_detail(&ssb->mailmap, suspect);
 		write_filename_info(suspect->path);
 		maybe_flush_or_die(stdout, "stdout");
 	}
@@ -1484,7 +1520,7 @@ static void found_guilty_entry(struct blame_entry *ent)
  * is still unknown, pick one blame_entry, and allow its current
  * suspect to pass blames to its parents.
  */
-static void assign_blame(struct scoreboard *sb, int opt)
+static void assign_blame(struct blame_scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 
@@ -1508,7 +1544,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		commit = suspect->commit;
 		if (!commit->object.parsed)
 			parse_commit(commit);
-		if (reverse ||
+		if (sb->ssb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
 			pass_blame(sb, suspect, opt);
@@ -1518,13 +1554,13 @@ static void assign_blame(struct scoreboard *sb, int opt)
 				mark_parents_uninteresting(commit);
 		}
 		/* treat root commit as boundary */
-		if (!commit->parents && !show_root)
+		if (!commit->parents && !sb->ssb->show_root)
 			commit->object.flags |= UNINTERESTING;
 
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
 			if (same_suspect(ent->suspect, suspect))
-				found_guilty_entry(ent);
+				found_guilty_entry(sb->ssb, ent);
 		origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
@@ -1532,8 +1568,8 @@ static void assign_blame(struct scoreboard *sb, int opt)
 	}
 }
 
-static const char *format_time(unsigned long time, const char *tz_str,
-			       int show_raw_time)
+static const char *format_time(struct blame_info *ssb, unsigned long time,
+			       const char *tz_str, int show_raw_time)
 {
 	static char time_buf[128];
 	const char *time_str;
@@ -1545,10 +1581,10 @@ static const char *format_time(unsigned long time, const char *tz_str,
 	}
 	else {
 		tz = atoi(tz_str);
-		time_str = show_date(time, tz, blame_date_mode);
+		time_str = show_date(time, tz, ssb->blame_date_mode);
 		time_len = strlen(time_str);
 		memcpy(time_buf, time_str, time_len);
-		memset(time_buf + time_len, ' ', blame_date_width - time_len);
+		memset(time_buf + time_len, ' ', ssb->blame_date_width - time_len);
 	}
 	return time_buf;
 }
@@ -1562,7 +1598,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_SHOW_SCORE      0100
 #define OUTPUT_NO_AUTHOR       0200
 
-static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
+static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent)
 {
 	int cnt;
 	const char *cp;
@@ -1576,7 +1612,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
-	if (emit_one_suspect_detail(suspect) ||
+	if (emit_one_suspect_detail(&sb->ssb->mailmap, suspect) ||
 	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
 		write_filename_info(suspect->path);
 
@@ -1596,7 +1632,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 	}
 }
 
-static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
+static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
 {
 	int cnt;
 	const char *cp;
@@ -1605,7 +1641,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	char hex[41];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(&sb->ssb->mailmap, suspect->commit, &ci, 1);
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
 
 	cp = nth_line(sb, ent->lno);
@@ -1614,7 +1650,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
-			if (blank_boundary)
+			if (sb->ssb->blank_boundary)
 				memset(hex, ' ', length);
 			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
 				length--;
@@ -1625,31 +1661,31 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT)
 			printf("\t(%10s\t%10s\t%d)", ci.author,
-			       format_time(ci.author_time, ci.author_tz,
-					   show_raw_time),
+			       format_time(sb->ssb, ci.author_time,
+					   ci.author_tz, show_raw_time),
 			       ent->lno + 1 + cnt);
 		else {
 			if (opt & OUTPUT_SHOW_SCORE)
 				printf(" %*d %02d",
-				       max_score_digits, ent->score,
+				       sb->ssb->max_score_digits, ent->score,
 				       ent->suspect->refcnt);
 			if (opt & OUTPUT_SHOW_NAME)
-				printf(" %-*.*s", longest_file, longest_file,
-				       suspect->path);
+				printf(" %-*.*s", sb->ssb->longest_file,
+						  sb->ssb->longest_file, suspect->path);
 			if (opt & OUTPUT_SHOW_NUMBER)
-				printf(" %*d", max_orig_digits,
+				printf(" %*d", sb->ssb->max_orig_digits,
 				       ent->s_lno + 1 + cnt);
 
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
-				int pad = longest_author - utf8_strwidth(ci.author);
+				int pad = sb->ssb->longest_author - utf8_strwidth(ci.author);
 				printf(" (%s%*s %10s",
 				       ci.author, pad, "",
-				       format_time(ci.author_time,
+				       format_time(sb->ssb, ci.author_time,
 						   ci.author_tz,
 						   show_raw_time));
 			}
 			printf(" %*d) ",
-			       max_digits, ent->lno + 1 + cnt);
+			       sb->ssb->max_digits, ent->lno + 1 + cnt);
 		}
 		do {
 			ch = *cp++;
@@ -1659,7 +1695,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	}
 }
 
-static void output(struct scoreboard *sb, int option)
+static void output(struct blame_scoreboard *sb, int option)
 {
 	struct blame_entry *ent;
 
@@ -1693,7 +1729,7 @@ static void output(struct scoreboard *sb, int option)
  * To allow quick access to the contents of nth line in the
  * final image, prepare an index in the scoreboard.
  */
-static int prepare_lines(struct scoreboard *sb)
+static int prepare_lines(struct blame_scoreboard *sb)
 {
 	const char *buf = sb->final_buf;
 	unsigned long len = sb->final_buf_size;
@@ -1758,7 +1794,7 @@ static int lineno_width(int lines)
  * How many columns do we need to show line numbers, authors,
  * and filenames?
  */
-static void find_alignment(struct scoreboard *sb, int *option)
+static void find_alignment(struct blame_scoreboard *sb, int *option)
 {
 	int longest_src_lines = 0;
 	int longest_dst_lines = 0;
@@ -1773,14 +1809,14 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		if (strcmp(suspect->path, sb->path))
 			*option |= OUTPUT_SHOW_NAME;
 		num = strlen(suspect->path);
-		if (longest_file < num)
-			longest_file = num;
+		if (sb->ssb->longest_file < num)
+			sb->ssb->longest_file = num;
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			suspect->commit->object.flags |= METAINFO_SHOWN;
-			get_commit_info(suspect->commit, &ci, 1);
+			get_commit_info(&sb->ssb->mailmap, suspect->commit, &ci, 1);
 			num = utf8_strwidth(ci.author);
-			if (longest_author < num)
-				longest_author = num;
+			if (sb->ssb->longest_author < num)
+				sb->ssb->longest_author = num;
 		}
 		num = e->s_lno + e->num_lines;
 		if (longest_src_lines < num)
@@ -1791,16 +1827,16 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		if (largest_score < ent_score(sb, e))
 			largest_score = ent_score(sb, e);
 	}
-	max_orig_digits = lineno_width(longest_src_lines);
-	max_digits = lineno_width(longest_dst_lines);
-	max_score_digits = lineno_width(largest_score);
+	sb->ssb->max_orig_digits = lineno_width(longest_src_lines);
+	sb->ssb->max_digits = lineno_width(longest_dst_lines);
+	sb->ssb->max_score_digits = lineno_width(largest_score);
 }
 
 /*
  * For debugging -- origin is refcounted, and this asserts that
  * we do not underflow.
  */
-static void sanity_check_refcnt(struct scoreboard *sb)
+static void sanity_check_refcnt(struct blame_scoreboard *sb)
 {
 	int baa = 0;
 	struct blame_entry *ent;
@@ -1851,7 +1887,7 @@ static const char *add_prefix(const char *prefix, const char *path)
  * Parsing of (comma separated) one item in the -L option
  */
 static const char *parse_loc(const char *spec,
-			     struct scoreboard *sb, long lno,
+			     struct blame_scoreboard *sb, long lno,
 			     long begin, long *ret)
 {
 	char *term;
@@ -1927,7 +1963,7 @@ static const char *parse_loc(const char *spec,
 /*
  * Parsing of -L option
  */
-static void prepare_blame_range(struct scoreboard *sb,
+static void prepare_blame_range(struct blame_scoreboard *sb,
 				const char *bottomtop,
 				long lno,
 				long *bottom, long *top)
@@ -1947,17 +1983,17 @@ static void prepare_blame_range(struct scoreboard *sb,
 static int git_blame_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "blame.showroot")) {
-		show_root = git_config_bool(var, value);
+		((struct blame_info *)cb)->show_root = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "blame.blankboundary")) {
-		blank_boundary = git_config_bool(var, value);
+		((struct blame_info *)cb)->blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "blame.date")) {
 		if (!value)
 			return config_error_nonbool(var);
-		blame_date_mode = parse_date_format(value);
+		((struct blame_info *)cb)->blame_date_mode = parse_date_format(value);
 		return 0;
 	}
 	return git_default_config(var, value, cb);
@@ -2079,7 +2115,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	return commit;
 }
 
-static const char *prepare_final(struct scoreboard *sb)
+static const char *prepare_final(struct blame_scoreboard *sb)
 {
 	int i;
 	const char *final_commit_name = NULL;
@@ -2107,7 +2143,7 @@ static const char *prepare_final(struct scoreboard *sb)
 	return final_commit_name;
 }
 
-static const char *prepare_initial(struct scoreboard *sb)
+static const char *prepare_initial(struct blame_scoreboard *sb)
 {
 	int i;
 	const char *final_commit_name = NULL;
@@ -2155,7 +2191,7 @@ static int blame_copy_callback(const struct option *option, const char *arg, int
 	*opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
 
 	if (arg)
-		blame_copy_score = parse_score(arg);
+		opt_blame_copy_score = parse_score(arg);
 	return 0;
 }
 
@@ -2166,7 +2202,7 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	*opt |= PICKAXE_BLAME_MOVE;
 
 	if (arg)
-		blame_move_score = parse_score(arg);
+		opt_blame_move_score = parse_score(arg);
 	return 0;
 }
 
@@ -2185,9 +2221,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	const char *path;
-	struct scoreboard sb;
 	struct origin *o;
 	struct blame_entry *ent;
+	static struct blame_stat stat;
+	static struct blame_info ssb = {
+		.xdl_opts = XDF_NEED_MINIMAL,
+		.blame_date_mode = DATE_ISO8601,
+		.stat = &stat
+	};
+	static struct blame_scoreboard sb;
 	long dashdash_pos, bottom, top, lno;
 	const char *final_commit_name = NULL;
 	enum object_type type;
@@ -2198,9 +2240,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	static const char *revs_file = NULL;
 	static const char *contents_from = NULL;
 	static const struct option options[] = {
-		OPT_BOOLEAN(0, "incremental", &incremental, "Show blame entries as we find them, incrementally"),
-		OPT_BOOLEAN('b', NULL, &blank_boundary, "Show blank SHA-1 for boundary commits (Default: off)"),
-		OPT_BOOLEAN(0, "root", &show_root, "Do not treat root commits as boundaries (Default: off)"),
+		OPT_BOOLEAN(0, "incremental", &ssb.incremental, "Show blame entries as we find them, incrementally"),
+		OPT_BOOLEAN('b', NULL, &ssb.blank_boundary, "Show blank SHA-1 for boundary commits (Default: off)"),
+		OPT_BOOLEAN(0, "root", &ssb.show_root, "Do not treat root commits as boundaries (Default: off)"),
 		OPT_BOOLEAN(0, "show-stats", &show_stats, "Show work cost statistics"),
 		OPT_BIT(0, "score-debug", &output_option, "Show output score for blame entries", OUTPUT_SHOW_SCORE),
 		OPT_BIT('f', "show-name", &output_option, "Show original filename (Default: auto)", OUTPUT_SHOW_NAME),
@@ -2210,7 +2252,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('t', NULL, &output_option, "Show raw timestamp (Default: off)", OUTPUT_RAW_TIMESTAMP),
 		OPT_BIT('l', NULL, &output_option, "Show long commit SHA1 (Default: off)", OUTPUT_LONG_OBJECT_NAME),
 		OPT_BIT('s', NULL, &output_option, "Suppress author name and timestamp (Default: off)", OUTPUT_NO_AUTHOR),
-		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
+		OPT_BIT('w', NULL, &ssb.xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
 		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git-rev-list"),
 		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
@@ -2222,9 +2264,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	int cmd_is_annotate = !strcmp(argv[0], "annotate");
 
-	git_config(git_blame_config, NULL);
+	git_config(git_blame_config, &ssb);
 	init_revisions(&revs, NULL);
-	revs.date_mode = blame_date_mode;
+	revs.date_mode = ssb.blame_date_mode;
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
@@ -2243,7 +2285,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 		if (!strcmp(ctx.argv[0], "--reverse")) {
 			ctx.argv[0] = "--children";
-			reverse = 1;
+			ssb.reverse = 1;
 		}
 		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
 	}
@@ -2252,42 +2294,45 @@ parse_done:
 
 	if (cmd_is_annotate) {
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
-		blame_date_mode = DATE_ISO8601;
+		ssb.blame_date_mode = DATE_ISO8601;
 	} else {
-		blame_date_mode = revs.date_mode;
+		ssb.blame_date_mode = revs.date_mode;
 	}
 
+	ssb.blame_move_score = opt_blame_move_score;
+	ssb.blame_copy_score = opt_blame_copy_score;
+
 	/* The maximum width used to show the dates */
-	switch (blame_date_mode) {
+	switch (ssb.blame_date_mode) {
 	case DATE_RFC2822:
-		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
+		ssb.blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
 		break;
 	case DATE_ISO8601:
-		blame_date_width = sizeof("2006-10-19 16:00:04 -0700");
+		ssb.blame_date_width = sizeof("2006-10-19 16:00:04 -0700");
 		break;
 	case DATE_RAW:
-		blame_date_width = sizeof("1161298804 -0700");
+		ssb.blame_date_width = sizeof("1161298804 -0700");
 		break;
 	case DATE_SHORT:
-		blame_date_width = sizeof("2006-10-19");
+		ssb.blame_date_width = sizeof("2006-10-19");
 		break;
 	case DATE_RELATIVE:
 		/* "normal" is used as the fallback for "relative" */
 	case DATE_LOCAL:
 	case DATE_NORMAL:
-		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
+		ssb.blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
 	}
-	blame_date_width -= 1; /* strip the null */
+	ssb.blame_date_width -= 1; /* strip the null */
 
 	if (DIFF_OPT_TST(&revs.diffopt, FIND_COPIES_HARDER))
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
 			PICKAXE_BLAME_COPY_HARDER);
 
-	if (!blame_move_score)
-		blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
-	if (!blame_copy_score)
-		blame_copy_score = BLAME_DEFAULT_COPY_SCORE;
+	if (!ssb.blame_move_score)
+		ssb.blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
+	if (!ssb.blame_copy_score)
+		ssb.blame_copy_score = BLAME_DEFAULT_COPY_SCORE;
 
 	/*
 	 * We have collected options unknown to us in argv[1..unk]
@@ -2341,9 +2386,9 @@ parse_done:
 
 	setup_revisions(argc, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
-
+	sb.ssb = &ssb;
 	sb.revs = &revs;
-	if (!reverse)
+	if (!sb.ssb->reverse)
 		final_commit_name = prepare_final(&sb);
 	else if (contents_from)
 		die("--contents and --children do not blend well.");
@@ -2391,7 +2436,7 @@ parse_done:
 			    sha1_to_hex(o->blob_sha1),
 			    path);
 	}
-	num_read_blob++;
+	stat.num_read_blob++;
 	lno = prepare_lines(&sb);
 
 	bottom = top = 0;
@@ -2422,14 +2467,14 @@ parse_done:
 		die("reading graft file %s failed: %s",
 		    revs_file, strerror(errno));
 
-	read_mailmap(&mailmap, NULL);
+	read_mailmap(&sb.ssb->mailmap, NULL);
 
-	if (!incremental)
+	if (!sb.ssb->incremental)
 		setup_pager();
 
 	assign_blame(&sb, opt);
 
-	if (incremental)
+	if (sb.ssb->incremental)
 		return 0;
 
 	coalesce(&sb);
@@ -2446,9 +2491,9 @@ parse_done:
 	}
 
 	if (show_stats) {
-		printf("num read blob: %d\n", num_read_blob);
-		printf("num get patch: %d\n", num_get_patch);
-		printf("num commits: %d\n", num_commits);
+		printf("num read blob: %d\n", stat.num_read_blob);
+		printf("num get patch: %d\n", stat.num_get_patch);
+		printf("num commits: %d\n", stat.num_commits);
 	}
 	return 0;
 }
-- 
1.6.2
