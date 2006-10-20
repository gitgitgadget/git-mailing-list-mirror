From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] git-pickaxe: introduce heuristics to "best match" scoring
Date: Fri, 20 Oct 2006 15:41:02 -0700
Message-ID: <7vu01ymwzl.fsf_-_@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45390168.6020502@utoronto.ca>
	<Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
	<200610201945.43957.jnareb@gmail.com>
	<Pine.LNX.4.64.0610201049250.3962@g5.osdl.org>
	<7v1wp2oi6s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 21 00:41:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb337-0000gV-52
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 00:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWJTWlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWJTWlG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 18:41:06 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12172 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030259AbWJTWlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 18:41:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020224103.CGSB18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 18:41:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cmgo1V00F1kojtg0000000
	Fri, 20 Oct 2006 18:40:48 -0400
To: git@vger.kernel.org
In-Reply-To: <7v1wp2oi6s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 20 Oct 2006 13:17:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29547>

Instead of comparing number of lines matched, look at the
matched characters and count alnums, so that we do not pass
blame on not-so-interesting lines, such as empty lines and lines
that are indentation with closing brace.

Add an option --score-debug to show the score of each
blame_entry while we cook this further on the "next" branch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This comes on top of "next".  The next one makes output from
   "pickaxe -C commit" actually make sense.

 builtin-pickaxe.c |   71 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/builtin-pickaxe.c b/builtin-pickaxe.c
index 74c7c9a..3c73d82 100644
--- a/builtin-pickaxe.c
+++ b/builtin-pickaxe.c
@@ -34,8 +34,7 @@ static int longest_file;
 static int longest_author;
 static int max_orig_digits;
 static int max_digits;
-
-#define DEBUG 0
+static int max_score_digits;
 
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
@@ -78,6 +77,11 @@ struct blame_entry {
 	 * suspect's file; internally all line numbers are 0 based.
 	 */
 	int s_lno;
+
+	/* how significant this entry is -- cached to avoid
+	 * scanning the lines over and over
+	 */
+	unsigned score;
 };
 
 struct scoreboard {
@@ -215,9 +219,6 @@ static void process_u_diff(void *state_,
 	struct chunk *chunk;
 	int off1, off2, len1, len2, num;
 
-	if (DEBUG)
-		fprintf(stderr, "%.*s", (int) len, line);
-
 	num = state->ret->num;
 	if (len < 4 || line[0] != '@' || line[1] != '@') {
 		if (state->hunk_in_pre_context && line[0] == ' ')
@@ -295,10 +296,6 @@ static struct patch *get_patch(struct or
 	char *blob_p, *blob_o;
 	struct patch *patch;
 
-	if (DEBUG) fprintf(stderr, "get patch %.8s %.8s\n",
-			   sha1_to_hex(parent->commit->object.sha1),
-			   sha1_to_hex(origin->commit->object.sha1));
-
 	blob_p = read_sha1_file(parent->blob_sha1, type,
 				(unsigned long *) &file_p.size);
 	blob_o = read_sha1_file(origin->blob_sha1, type,
@@ -352,6 +349,7 @@ static void dup_entry(struct blame_entry
 	memcpy(dst, src, sizeof(*src));
 	dst->prev = p;
 	dst->next = n;
+	dst->score = 0;
 }
 
 static const char *nth_line(struct scoreboard *sb, int lno)
@@ -448,7 +446,7 @@ static void split_blame(struct scoreboar
 		add_blame_entry(sb, new_entry);
 	}
 
-	if (DEBUG) {
+	if (1) { /* sanity */
 		struct blame_entry *ent;
 		int lno = 0, corrupt = 0;
 
@@ -530,12 +528,6 @@ static int pass_blame_to_parent(struct s
 	for (i = 0; i < patch->num; i++) {
 		struct chunk *chunk = &patch->chunks[i];
 
-		if (DEBUG)
-			fprintf(stderr,
-				"plno = %d, tlno = %d, "
-				"same as parent up to %d, resync %d and %d\n",
-				plno, tlno,
-				chunk->same, chunk->p_next, chunk->t_next);
 		blame_chunk(sb, tlno, plno, chunk->same, target, parent);
 		plno = chunk->p_next;
 		tlno = chunk->t_next;
@@ -547,14 +539,37 @@ static int pass_blame_to_parent(struct s
 	return 0;
 }
 
-static void copy_split_if_better(struct blame_entry best_so_far[3],
+static unsigned ent_score(struct scoreboard *sb, struct blame_entry *e)
+{
+	unsigned score;
+	const char *cp, *ep;
+
+	if (e->score)
+		return e->score;
+
+	score = 0;
+	cp = nth_line(sb, e->lno);
+	ep = nth_line(sb, e->lno + e->num_lines);
+	while (cp < ep) {
+		unsigned ch = *((unsigned char *)cp);
+		if (isalnum(ch))
+			score++;
+		cp++;
+	}
+	e->score = score;
+	return score;
+}
+
+static void copy_split_if_better(struct scoreboard *sb,
+				 struct blame_entry best_so_far[3],
 				 struct blame_entry this[3])
 {
 	if (!this[1].suspect)
 		return;
-	if (best_so_far[1].suspect &&
-	    (this[1].num_lines < best_so_far[1].num_lines))
-		return;
+	if (best_so_far[1].suspect) {
+		if (ent_score(sb, &this[1]) < ent_score(sb, &best_so_far[1]))
+			return;
+	}
 	memcpy(best_so_far, this, sizeof(struct blame_entry [3]));
 }
 
@@ -596,7 +611,7 @@ static void find_copy_in_blob(struct sco
 				      tlno + ent->s_lno, plno,
 				      chunk->same + ent->s_lno,
 				      parent);
-			copy_split_if_better(split, this);
+			copy_split_if_better(sb, split, this);
 		}
 		plno = chunk->p_next;
 		tlno = chunk->t_next;
@@ -699,7 +714,7 @@ static int find_copy_in_parent(struct sc
 				continue;
 			}
 			find_copy_in_blob(sb, ent, norigin, this, &file_p);
-			copy_split_if_better(split, this);
+			copy_split_if_better(sb, split, this);
 		}
 		if (split[1].suspect)
 			split_blame(sb, split, ent);
@@ -944,6 +959,7 @@ #define OUTPUT_RAW_TIMESTAMP	004
 #define OUTPUT_PORCELAIN	010
 #define OUTPUT_SHOW_NAME	020
 #define OUTPUT_SHOW_NUMBER	040
+#define OUTPUT_SHOW_SCORE      0100
 
 static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 {
@@ -1016,6 +1032,8 @@ static void emit_other(struct scoreboard
 					   show_raw_time),
 			       ent->lno + 1 + cnt);
 		else {
+			if (opt & OUTPUT_SHOW_SCORE)
+				printf(" %*d", max_score_digits, ent->score);
 			if (opt & OUTPUT_SHOW_NAME)
 				printf(" %-*.*s", longest_file, longest_file,
 				       suspect->path);
@@ -1060,8 +1078,9 @@ static void output(struct scoreboard *sb
 	for (ent = sb->ent; ent; ent = ent->next) {
 		if (option & OUTPUT_PORCELAIN)
 			emit_porcelain(sb, ent);
-		else
+		else {
 			emit_other(sb, ent, option);
+		}
 	}
 }
 
@@ -1118,6 +1137,7 @@ static void find_alignment(struct scoreb
 {
 	int longest_src_lines = 0;
 	int longest_dst_lines = 0;
+	unsigned largest_score = 0;
 	struct blame_entry *e;
 
 	for (e = sb->ent; e; e = e->next) {
@@ -1143,9 +1163,12 @@ static void find_alignment(struct scoreb
 		num = e->lno + e->num_lines;
 		if (longest_dst_lines < num)
 			longest_dst_lines = num;
+		if (largest_score < ent_score(sb, e))
+			largest_score = ent_score(sb, e);
 	}
 	max_orig_digits = lineno_width(longest_src_lines);
 	max_digits = lineno_width(longest_dst_lines);
+	max_score_digits = lineno_width(largest_score);
 }
 
 static int has_path_in_work_tree(const char *path)
@@ -1206,6 +1229,8 @@ int cmd_pickaxe(int argc, const char **a
 				tmp = top; top = bottom; bottom = tmp;
 			}
 		}
+		else if (!strcmp("--score-debug", arg))
+			output_option |= OUTPUT_SHOW_SCORE;
 		else if (!strcmp("-f", arg) ||
 			 !strcmp("--show-name", arg))
 			output_option |= OUTPUT_SHOW_NAME;
-- 
1.4.3.ge193
