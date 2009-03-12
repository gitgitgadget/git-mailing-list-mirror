From: pi song <pi.songs@gmail.com>
Subject: [PATCH]  Removed static variables in blame for catering reuse of
 blame code
Date: Thu, 12 Mar 2009 21:30:03 +1100
Message-ID: <49B8E42B.30901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 12 11:31:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhiCU-00062K-53
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 11:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbZCLKaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 06:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbZCLKaP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 06:30:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:38914 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbZCLKaL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 06:30:11 -0400
Received: by rv-out-0506.google.com with SMTP id g37so483106rvb.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Z3Jl3x2HMS1Gst443g8xSzGqt8UwV/odogJA2MY1lA4=;
        b=Y+ABDtR/cNqOhPu8FgAqHDDr3d/pgZ1xE0bVO6B5Gb1nEdfTccWdHwck6ND9bPXuTr
         qwD6VASsLl4I7GZDvNrUwEWYu1e2f0kIMwcssiMxgfI5utt3aCv8dbMV/w/GbQmhIA1Z
         rSBF8r6H1GXbcJtAD/T0zkiSmGpk61cNE9mAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=KthRBDz2HzqGvYheHCmqHhwHfq2g7ZPeX0oFyGXAv1WGZGPjnQpmccTkXu0L92aAwi
         TAj+TZ1nUy7HAvYwYdAtuedNLQtBWmOn2XixrU7/nbnf7kdPTnVv1ZwC6jbKWMWh5gQO
         zYG9BWYBh0YnLRYv2/i1rV7n6nHFHUMYCQ8K0=
Received: by 10.114.95.1 with SMTP id s1mr5948072wab.20.1236853809245;
        Thu, 12 Mar 2009 03:30:09 -0700 (PDT)
Received: from ?192.168.0.5? (203-219-184-102.static.tpgi.com.au [203.219.184.102])
        by mx.google.com with ESMTPS id q18sm2248065pog.9.2009.03.12.03.30.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Mar 2009 03:30:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113039>

The patch refactors builtin-blame.c to not rely on static variables 
so that blame code can later be reused in different context.

This is the first patch toward making grep --blame, based on the latest "next" branch.

Signed-off-by: Pi Song <pi.songs@gmail.com>
---
 builtin-blame.c |  386 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 214 insertions(+), 172 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 2aedd17..2e19ddf 100644
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
+static unsigned opt_blame_copy_score;
 
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
+        int num_read_blob;
+        int num_get_patch;
+        int num_commits;
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
 
@@ -86,56 +73,6 @@ struct origin {
 };
 
 /*
- * Given an origin, prepare mmfile_t structure to be used by the
- * diff machinery
- */
-static void fill_origin_blob(struct origin *o, mmfile_t *file)
-{
-	if (!o->file.ptr) {
-		enum object_type type;
-		num_read_blob++;
-		file->ptr = read_sha1_file(o->blob_sha1, &type,
-					   (unsigned long *)(&(file->size)));
-		if (!file->ptr)
-			die("Cannot read blob %s for path %s",
-			    sha1_to_hex(o->blob_sha1),
-			    o->path);
-		o->file = *file;
-	}
-	else
-		*file = o->file;
-}
-
-/*
- * Origin is refcounted and usually we keep the blob contents to be
- * reused.
- */
-static inline struct origin *origin_incref(struct origin *o)
-{
-	if (o)
-		o->refcnt++;
-	return o;
-}
-
-static void origin_decref(struct origin *o)
-{
-	if (o && --o->refcnt <= 0) {
-		if (o->previous)
-			origin_decref(o->previous);
-		free(o->file.ptr);
-		free(o);
-	}
-}
-
-static void drop_origin_blob(struct origin *o)
-{
-	if (o->file.ptr) {
-		free(o->file.ptr);
-		o->file.ptr = NULL;
-	}
-}
-
-/*
  * Each group of lines is described by a blame_entry; it can be split
  * as we pass blame to the parents.  They form a linked list in the
  * scoreboard structure, sorted by the target line number.
@@ -176,6 +113,47 @@ struct blame_entry {
 };
 
 /*
+ * stores things that survive across multiple blame operations
+ * 1) for blame specific global parameters
+ * 2) for reusable structures (possibly for optimization purpose)
+ */
+struct super_scoreboard {
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
  * The current state of the blame assignment.
  */
 struct scoreboard {
@@ -198,8 +176,61 @@ struct scoreboard {
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
+
+	/* super scoreboard */
+	struct super_scoreboard *ssb ;
 };
 
+/*
+ * Given an origin, prepare mmfile_t structure to be used by the
+ * diff machinery
+ */
+static void fill_origin_blob(struct scoreboard *sb, struct origin *o, mmfile_t *file)
+{
+	if (!o->file.ptr) {
+		enum object_type type;
+		sb->ssb->stat->num_read_blob++;
+		file->ptr = read_sha1_file(o->blob_sha1, &type,
+					   (unsigned long *)(&(file->size)));
+		if (!file->ptr)
+			die("Cannot read blob %s for path %s",
+			    sha1_to_hex(o->blob_sha1),
+			    o->path);
+		o->file = *file;
+	}
+	else
+		*file = o->file;
+}
+
+/*
+ * Origin is refcounted and usually we keep the blob contents to be
+ * reused.
+ */
+static inline struct origin *origin_incref(struct origin *o)
+{
+	if (o)
+		o->refcnt++;
+	return o;
+}
+
+static void origin_decref(struct origin *o)
+{
+	if (o && --o->refcnt <= 0) {
+		if (o->previous)
+			origin_decref(o->previous);
+		free(o->file.ptr);
+		free(o);
+	}
+}
+
+static void drop_origin_blob(struct origin *o)
+{
+	if (o->file.ptr) {
+		free(o->file.ptr);
+		o->file.ptr = NULL;
+	}
+}
+
 static inline int same_suspect(struct origin *a, struct origin *b)
 {
 	if (a == b)
@@ -731,12 +762,12 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
 
-	fill_origin_blob(parent, &file_p);
-	fill_origin_blob(target, &file_o);
-	num_get_patch++;
+	fill_origin_blob(sb, parent, &file_p);
+	fill_origin_blob(sb, target, &file_o);
+	sb->ssb->stat->num_get_patch++;
 
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = xdl_opts;
+	xpp.flags = sb->ssb->xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 0;
 	xdi_diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, &xpp, &xecfg);
@@ -887,7 +918,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	 * file_p partially may match that image.
 	 */
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = xdl_opts;
+	xpp.flags = sb->ssb->xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 1;
 	memset(split, 0, sizeof(struct blame_entry [3]));
@@ -912,7 +943,7 @@ static int find_move_in_parent(struct scoreboard *sb,
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
 
-	fill_origin_blob(parent, &file_p);
+	fill_origin_blob(sb, parent, &file_p);
 	if (!file_p.ptr)
 		return 0;
 
@@ -921,11 +952,11 @@ static int find_move_in_parent(struct scoreboard *sb,
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
@@ -998,7 +1029,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	struct blame_list *blame_list;
 	int num_ents;
 
-	blame_list = setup_blame_list(sb, target, blame_copy_score, &num_ents);
+	blame_list = setup_blame_list(sb, target, sb->ssb->blame_copy_score, &num_ents);
 	if (!blame_list)
 		return 1; /* nothing remains for this target */
 
@@ -1053,7 +1084,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 
 			norigin = get_origin(sb, parent, p->one->path);
 			hashcpy(norigin->blob_sha1, p->one->sha1);
-			fill_origin_blob(norigin, &file_p);
+			fill_origin_blob(sb, norigin, &file_p);
 			if (!file_p.ptr)
 				continue;
 
@@ -1070,7 +1101,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 		for (j = 0; j < num_ents; j++) {
 			struct blame_entry *split = blame_list[j].split;
 			if (split[1].suspect &&
-			    blame_copy_score < ent_score(sb, &split[1])) {
+			    sb->ssb->blame_copy_score < ent_score(sb, &split[1])) {
 				split_blame(sb, split, blame_list[j].ent);
 				made_progress = 1;
 			}
@@ -1082,7 +1113,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 
 		if (!made_progress)
 			break;
-		blame_list = setup_blame_list(sb, target, blame_copy_score, &num_ents);
+		blame_list = setup_blame_list(sb, target, sb->ssb->blame_copy_score, &num_ents);
 		if (!blame_list) {
 			retval = 1;
 			break;
@@ -1122,17 +1153,21 @@ static void pass_whole_blame(struct scoreboard *sb,
  * "parent" (and "porigin"), but what we mean is to find scapegoat to
  * exonerate ourselves.
  */
-static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
+static struct commit_list *first_scapegoat(struct scoreboard *sb, 
+					   struct rev_info *revs, 
+					   struct commit *commit)
 {
-	if (!reverse)
+	if (!sb->ssb->reverse)
 		return commit->parents;
 	return lookup_decoration(&revs->children, &commit->object);
 }
 
-static int num_scapegoats(struct rev_info *revs, struct commit *commit)
+static int num_scapegoats(struct scoreboard *sb,
+			  struct rev_info *revs, 
+			  struct commit *commit)
 {
 	int cnt;
-	struct commit_list *l = first_scapegoat(revs, commit);
+	struct commit_list *l = first_scapegoat(sb, revs, commit);
 	for (cnt = 0; l; l = l->next)
 		cnt++;
 	return cnt;
@@ -1149,7 +1184,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	struct origin *sg_buf[MAXSG];
 	struct origin *porigin, **sg_origin = sg_buf;
 
-	num_sg = num_scapegoats(revs, commit);
+	num_sg = num_scapegoats(sb, revs, commit);
 	if (!num_sg)
 		goto finish;
 	else if (num_sg < ARRAY_SIZE(sg_buf))
@@ -1166,7 +1201,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 				       struct commit *, struct origin *);
 		find = pass ? find_rename : find_origin;
 
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(sb, revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct commit *p = sg->item;
@@ -1198,8 +1233,8 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		}
 	}
 
-	num_commits++;
-	for (i = 0, sg = first_scapegoat(revs, commit);
+	sb->ssb->stat->num_commits++;
+	for (i = 0, sg = first_scapegoat(sb, revs, commit);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
 		struct origin *porigin = sg_origin[i];
@@ -1217,7 +1252,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find moves in parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_MOVE)
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(sb, revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct origin *porigin = sg_origin[i];
@@ -1231,7 +1266,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find copies from parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_COPY)
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(sb, revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct origin *porigin = sg_origin[i];
@@ -1274,8 +1309,8 @@ struct commit_info
 /*
  * Parse author/committer line in the commit object buffer
  */
-static void get_ac_line(const char *inbuf, const char *what,
-			int person_len, char *person,
+static void get_ac_line(struct scoreboard *sb, const char *inbuf, 
+			const char *what, int person_len, char *person,
 			int mail_len, char *mail,
 			unsigned long *time, const char **tz)
 {
@@ -1323,7 +1358,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	maillen = timepos - tmp;
 	memcpy(mail, mailpos, maillen);
 
-	if (!mailmap.nr)
+	if (!sb->ssb->mailmap.nr)
 		return;
 
 	/*
@@ -1338,7 +1373,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	/*
 	 * Now, convert both name and e-mail using mailmap
 	 */
-	if(map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
+	if(map_user(&sb->ssb->mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
 		/* Add a trailing '>' to email, since map_user returns plain emails
 		   Note: It already has '<', since we replace from mail+1 */
 		mailpos = memchr(mail, '\0', mail_len);
@@ -1349,7 +1384,8 @@ static void get_ac_line(const char *inbuf, const char *what,
 	}
 }
 
-static void get_commit_info(struct commit *commit,
+static void get_commit_info(struct scoreboard *sb,
+			    struct commit *commit,
 			    struct commit_info *ret,
 			    int detailed)
 {
@@ -1378,7 +1414,7 @@ static void get_commit_info(struct commit *commit,
 	message   = reencoded ? reencoded : commit->buffer;
 	ret->author = author_name;
 	ret->author_mail = author_mail;
-	get_ac_line(message, "\nauthor ",
+	get_ac_line(sb, message, "\nauthor ",
 		    sizeof(author_name), author_name,
 		    sizeof(author_mail), author_mail,
 		    &ret->author_time, &ret->author_tz);
@@ -1390,7 +1426,7 @@ static void get_commit_info(struct commit *commit,
 
 	ret->committer = committer_name;
 	ret->committer_mail = committer_mail;
-	get_ac_line(message, "\ncommitter ",
+	get_ac_line(sb, message, "\ncommitter ",
 		    sizeof(committer_name), committer_name,
 		    sizeof(committer_mail), committer_mail,
 		    &ret->committer_time, &ret->committer_tz);
@@ -1430,7 +1466,8 @@ static void write_filename_info(const char *path)
  * commit.  Instead of repeating this every line, emit it only once,
  * the first time each commit appears in the output.
  */
-static int emit_one_suspect_detail(struct origin *suspect)
+static int emit_one_suspect_detail(struct scoreboard *sb, 
+				   struct origin *suspect)
 {
 	struct commit_info ci;
 
@@ -1438,7 +1475,7 @@ static int emit_one_suspect_detail(struct origin *suspect)
 		return 0;
 
 	suspect->commit->object.flags |= METAINFO_SHOWN;
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(sb, suspect->commit, &ci, 1);
 	printf("author %s\n", ci.author);
 	printf("author-mail %s\n", ci.author_mail);
 	printf("author-time %lu\n", ci.author_time);
@@ -1462,18 +1499,18 @@ static int emit_one_suspect_detail(struct origin *suspect)
  * The blame_entry is found to be guilty for the range.  Mark it
  * as such, and show it in incremental output.
  */
-static void found_guilty_entry(struct blame_entry *ent)
+static void found_guilty_entry(struct scoreboard *sb, struct blame_entry *ent)
 {
 	if (ent->guilty)
 		return;
 	ent->guilty = 1;
-	if (incremental) {
+	if (sb->ssb->incremental) {
 		struct origin *suspect = ent->suspect;
 
 		printf("%s %d %d %d\n",
 		       sha1_to_hex(suspect->commit->object.sha1),
 		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
-		emit_one_suspect_detail(suspect);
+		emit_one_suspect_detail(sb, suspect);
 		write_filename_info(suspect->path);
 		maybe_flush_or_die(stdout, "stdout");
 	}
@@ -1508,7 +1545,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		commit = suspect->commit;
 		if (!commit->object.parsed)
 			parse_commit(commit);
-		if (reverse ||
+		if (sb->ssb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
 			pass_blame(sb, suspect, opt);
@@ -1518,13 +1555,13 @@ static void assign_blame(struct scoreboard *sb, int opt)
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
+				found_guilty_entry(sb, ent);
 		origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
@@ -1532,8 +1569,8 @@ static void assign_blame(struct scoreboard *sb, int opt)
 	}
 }
 
-static const char *format_time(unsigned long time, const char *tz_str,
-			       int show_raw_time)
+static const char *format_time(struct scoreboard *sb, unsigned long time, 
+			       const char *tz_str, int show_raw_time)
 {
 	static char time_buf[128];
 	const char *time_str;
@@ -1545,10 +1582,10 @@ static const char *format_time(unsigned long time, const char *tz_str,
 	}
 	else {
 		tz = atoi(tz_str);
-		time_str = show_date(time, tz, blame_date_mode);
+		time_str = show_date(time, tz, sb->ssb->blame_date_mode);
 		time_len = strlen(time_str);
 		memcpy(time_buf, time_str, time_len);
-		memset(time_buf + time_len, ' ', blame_date_width - time_len);
+		memset(time_buf + time_len, ' ', sb->ssb->blame_date_width - time_len);
 	}
 	return time_buf;
 }
@@ -1576,7 +1613,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
-	if (emit_one_suspect_detail(suspect) ||
+	if (emit_one_suspect_detail(sb, suspect) ||
 	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
 		write_filename_info(suspect->path);
 
@@ -1605,7 +1642,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	char hex[41];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(sb, suspect->commit, &ci, 1);
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
 
 	cp = nth_line(sb, ent->lno);
@@ -1614,7 +1651,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
-			if (blank_boundary)
+			if (sb->ssb->blank_boundary)
 				memset(hex, ' ', length);
 			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
 				length--;
@@ -1625,31 +1662,31 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT)
 			printf("\t(%10s\t%10s\t%d)", ci.author,
-			       format_time(ci.author_time, ci.author_tz,
-					   show_raw_time),
+			       format_time(sb, ci.author_time, 
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
+				       format_time(sb, ci.author_time,
 						   ci.author_tz,
 						   show_raw_time));
 			}
 			printf(" %*d) ",
-			       max_digits, ent->lno + 1 + cnt);
+			       sb->ssb->max_digits, ent->lno + 1 + cnt);
 		}
 		do {
 			ch = *cp++;
@@ -1773,14 +1810,14 @@ static void find_alignment(struct scoreboard *sb, int *option)
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
+			get_commit_info(sb, suspect->commit, &ci, 1);
 			num = utf8_strwidth(ci.author);
-			if (longest_author < num)
-				longest_author = num;
+			if (sb->ssb->longest_author < num)
+				sb->ssb->longest_author = num;
 		}
 		num = e->s_lno + e->num_lines;
 		if (longest_src_lines < num)
@@ -1791,9 +1828,9 @@ static void find_alignment(struct scoreboard *sb, int *option)
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
@@ -1945,19 +1982,19 @@ static void prepare_blame_range(struct scoreboard *sb,
 }
 
 static int git_blame_config(const char *var, const char *value, void *cb)
-{
+{ 
 	if (!strcmp(var, "blame.showroot")) {
-		show_root = git_config_bool(var, value);
+		((struct super_scoreboard *)cb)->show_root = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "blame.blankboundary")) {
-		blank_boundary = git_config_bool(var, value);
+		((struct super_scoreboard *)cb)->blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "blame.date")) {
 		if (!value)
 			return config_error_nonbool(var);
-		blame_date_mode = parse_date_format(value);
+		((struct super_scoreboard *)cb)->blame_date_mode = parse_date_format(value);
 		return 0;
 	}
 	return git_default_config(var, value, cb);
@@ -2155,7 +2192,7 @@ static int blame_copy_callback(const struct option *option, const char *arg, int
 	*opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
 
 	if (arg)
-		blame_copy_score = parse_score(arg);
+		opt_blame_copy_score = parse_score(arg);
 	return 0;
 }
 
@@ -2166,7 +2203,7 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	*opt |= PICKAXE_BLAME_MOVE;
 
 	if (arg)
-		blame_move_score = parse_score(arg);
+		opt_blame_move_score = parse_score(arg);
 	return 0;
 }
 
@@ -2185,9 +2222,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	const char *path;
-	struct scoreboard sb;
 	struct origin *o;
 	struct blame_entry *ent;
+	static struct blame_stat stat;
+	static struct super_scoreboard ssb = { .xdl_opts = XDF_NEED_MINIMAL, .blame_date_mode = DATE_ISO8601, .stat = &stat } ;
+	static struct scoreboard sb ;
 	long dashdash_pos, bottom, top, lno;
 	const char *final_commit_name = NULL;
 	enum object_type type;
@@ -2198,9 +2237,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
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
@@ -2210,7 +2249,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('t', NULL, &output_option, "Show raw timestamp (Default: off)", OUTPUT_RAW_TIMESTAMP),
 		OPT_BIT('l', NULL, &output_option, "Show long commit SHA1 (Default: off)", OUTPUT_LONG_OBJECT_NAME),
 		OPT_BIT('s', NULL, &output_option, "Suppress author name and timestamp (Default: off)", OUTPUT_NO_AUTHOR),
-		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
+		OPT_BIT('w', NULL, &ssb.xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
 		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git-rev-list"),
 		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
@@ -2222,9 +2261,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	int cmd_is_annotate = !strcmp(argv[0], "annotate");
 
-	git_config(git_blame_config, NULL);
+	git_config(git_blame_config, &ssb);
 	init_revisions(&revs, NULL);
-	revs.date_mode = blame_date_mode;
+	revs.date_mode = ssb.blame_date_mode;
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
@@ -2243,7 +2282,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 		if (!strcmp(ctx.argv[0], "--reverse")) {
 			ctx.argv[0] = "--children";
-			reverse = 1;
+			ssb.reverse = 1;
 		}
 		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
 	}
@@ -2252,42 +2291,45 @@ parse_done:
 
 	if (cmd_is_annotate) {
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
-		blame_date_mode = DATE_ISO8601;
+		ssb.blame_date_mode = DATE_ISO8601;
 	} else {
-		blame_date_mode = revs.date_mode;
+		ssb.blame_date_mode = revs.date_mode;
 	}
 
+	ssb.blame_move_score = opt_blame_move_score ;
+	ssb.blame_copy_score = opt_blame_copy_score ;
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
@@ -2341,9 +2383,9 @@ parse_done:
 
 	setup_revisions(argc, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
-
+	sb.ssb = &ssb ;
 	sb.revs = &revs;
-	if (!reverse)
+	if (!sb.ssb->reverse)
 		final_commit_name = prepare_final(&sb);
 	else if (contents_from)
 		die("--contents and --children do not blend well.");
@@ -2391,7 +2433,7 @@ parse_done:
 			    sha1_to_hex(o->blob_sha1),
 			    path);
 	}
-	num_read_blob++;
+	stat.num_read_blob++;
 	lno = prepare_lines(&sb);
 
 	bottom = top = 0;
@@ -2422,14 +2464,14 @@ parse_done:
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
@@ -2446,9 +2488,9 @@ parse_done:
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
1.5.4.3
