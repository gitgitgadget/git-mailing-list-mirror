From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 14:55:33 -0700
Message-ID: <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>
	<7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 23:58:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaKv3-0001Zk-Ts
	for gcvg-git@gmane.org; Mon, 23 May 2005 23:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVEWV6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 17:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVEWV6a
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 17:58:30 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42154 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261973AbVEWVzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 17:55:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523215533.IXCT19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 17:55:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 12:03:20 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This changes the diff-raw format again, following the mailing
list discussion.  The new format explicitly expresses which one
is a rename and which one is a copy.

The documentation and tests are updated to match this change.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/diff-format.txt |   42 ++++----
diff-cache.c                  |    2 
diff-files.c                  |    2 
diff-helper.c                 |  200 ++++++++++++++++++++--------------------
diff-tree.c                   |    4 
diff.c                        |  124 +++++++++++++++----------
diff.h                        |   16 +--
diffcore.h                    |    1 
t/t0000-basic.sh              |   16 +--
t/t4002-diff-basic.sh         |  208 +++++++++++++++++++++---------------------
t/t4003-diff-rename-1.sh      |  103 ++++++++++----------
t/t4005-diff-rename-2.sh      |  124 ++++++++++++++++++++++---
12 files changed, 493 insertions(+), 349 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -19,28 +19,34 @@ git-diff-files [<pattern>...]::
 
 An output line is formatted this way:
 
-  ':' <mode> ' ' <mode> ' ' <sha1> ' ' <sha1> I <path> I <path> L
-
-By default, I and L are '\t' and '\n' respectively.  When '-z'
-flag is in effect, both I and L are '\0'.
-
-In each <mode>, <sha1> and <path> pair, left hand side describes
-the left hand side of what is being compared (<tree-ish> in
-git-diff-cache, <tree-ish-1> in git-diff-tree, cache contents in
-git-diff-files).  Non-existence is shown by having 000000 in the
-<mode> column.  That is, 000000 appears as the first <mode> for
-newly created files, and as the second <mode> for deleted files.
-
-Usually two <path> are the same.  When rename/copy detection is
-used, however, an "create" and another "delete" records can be
-merged into a single record that has two <path>, old name and
-new name.
+in-place edit  :100644 100644 bcd1234... 0123456... M file0
+copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
+rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
+create         :000000 100644 0000000... 1234567... N file4
+delete         :100644 000000 1234567... 0000000... D file5
+unmerged       :000000 000000 0000000... 0000000... U file6
+
+That is, from the left to the right:
+
+  (1) a colon.
+  (2) mode for "src"; 000000 if creation or unmerged.
+  (3) a space.
+  (4) mode for "dst"; 000000 if deletion or unmerged.
+  (5) a space.
+  (6) sha1 for "src"; 0{40} if creation or unmerged.
+  (7) a space.
+  (8) sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".
+  (9) status, followed by similarlity index number only for C and R.
+ (10) a tab or a NUL when '-z' option is used.
+ (11) path for "src"
+ (12) a tab or a NUL when '-z' option is used; only exists for C or R.
+ (13) path for "dst"; only exists for C or R.
+ (14) an LF or a NUL when '-z' option is used, to terminate the record.
 
 <sha1> is shown as all 0's if new is a file on the filesystem
 and it is out of sync with the cache.  Example:
 
-  :100644 100644 5be4a4...... 000000......    file.c    file.c
-
+  :100644 100644 5be4a4...... 000000...... M file.c
 
 Generating patches with -p
 --------------------------
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -234,6 +234,6 @@ int main(int argc, const char **argv)
 		diffcore_pickaxe(pickaxe);
 	if (2 <= argc)
 		diffcore_pathspec(argv + 1);
-	diff_flush(diff_output_format);
+	diff_flush(diff_output_format, 1);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -120,6 +120,6 @@ int main(int argc, const char **argv)
 		diffcore_pickaxe(pickaxe);
 	if (1 < argc)
 		diffcore_pathspec(argv + 1);
-	diff_flush(diff_output_format);
+	diff_flush(diff_output_format, 1);
 	return 0;
 }
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -5,84 +5,21 @@
 #include "strbuf.h"
 #include "diff.h"
 
-static int detect_rename = 0;
-static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
-static int diff_output_style = DIFF_FORMAT_PATCH;
 static int line_termination = '\n';
 static int inter_name_termination = '\t';
 
-static int parse_diff_raw(char *buf1, char *buf2, char *buf3)
-{
-	char old_path[PATH_MAX];
-	unsigned char old_sha1[20], new_sha1[20];
-	char *ep;
-	char *cp = buf1;
-	int ch, old_mode, new_mode;
-
-	old_mode = new_mode = 0;
-	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-		old_mode = (old_mode << 3) | (ch - '0');
-		cp++;
-	}
-	if (*cp++ != ' ')
-		return -1;
-	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-		new_mode = (new_mode << 3) | (ch - '0');
-		cp++;
-	}
-	if (*cp++ != ' ')
-		return -1;
-	if (get_sha1_hex(cp, old_sha1))
-		return -1;
-	cp += 40;
-	if (*cp++ != ' ')
-		return -1;
-	if (get_sha1_hex(cp, new_sha1))
-		return -1;
-	cp += 40;
-	if (*cp++ != inter_name_termination)
-		return -1;
-	if (buf2)
-		cp = buf2;
-	ep = strchr(cp, inter_name_termination);
-	if (!ep)
-		return -1;
-	*ep++ = 0;
-	strcpy(old_path, cp);
-	diff_guif(old_mode, new_mode, old_sha1, new_sha1,
-		  old_path, buf3 ? buf3 : ep);
-	return 0;
-}
-
 static const char *diff_helper_usage =
-	"git-diff-helper [-z] [-R] [-M] [-C] [-S<string>] paths...";
+	"git-diff-helper [-z] [-S<string>] paths...";
 
 int main(int ac, const char **av) {
-	struct strbuf sb1, sb2, sb3;
-	int reverse_diff = 0;
+	struct strbuf sb;
 
-	strbuf_init(&sb1);
-	strbuf_init(&sb2);
-	strbuf_init(&sb3);
+	strbuf_init(&sb);
 
 	while (1 < ac && av[1][0] == '-') {
-		if (av[1][1] == 'R')
-			reverse_diff = 1;
-		else if (av[1][1] == 'z')
+		if (av[1][1] == 'z')
 			line_termination = inter_name_termination = 0;
-		else if (av[1][1] == 'p') /* hidden from the help */
-			diff_output_style = DIFF_FORMAT_HUMAN;
-		else if (av[1][1] == 'P') /* hidden from the help */
-			diff_output_style = DIFF_FORMAT_MACHINE;
-		else if (av[1][1] == 'M') {
-			detect_rename = DIFF_DETECT_RENAME;
-			diff_score_opt = diff_scoreopt_parse(av[1]);
-		}
-		else if (av[1][1] == 'C') {
-			detect_rename = DIFF_DETECT_COPY;
-			diff_score_opt = diff_scoreopt_parse(av[1]);
-		}
 		else if (av[1][1] == 'S') {
 			pickaxe = av[1] + 2;
 		}
@@ -92,45 +29,114 @@ int main(int ac, const char **av) {
 	}
 	/* the remaining parameters are paths patterns */
 
-	diff_setup(reverse_diff);
+	diff_setup(0);
 	while (1) {
-		int status;
-		read_line(&sb1, stdin, line_termination);
-		if (sb1.eof)
+		unsigned old_mode, new_mode;
+		unsigned char old_sha1[20], new_sha1[20];
+		char old_path[PATH_MAX];
+		int status, score, two_paths;
+		char new_path[PATH_MAX];
+
+		int ch;
+		char *cp, *ep;
+
+		read_line(&sb, stdin, line_termination);
+		if (sb.eof)
 			break;
-		switch (sb1.buf[0]) {
-		case 'U':
-			diff_unmerge(sb1.buf + 2);
-			continue;
+		switch (sb.buf[0]) {
 		case ':':
-			break;
-		default:
-			goto unrecognized;
-		}
-		if (!line_termination) {
-			read_line(&sb2, stdin, line_termination);
-			if (sb2.eof)
+			/* parse the first part up to the status */
+			cp = sb.buf + 1;
+			old_mode = new_mode = 0;
+			while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+				old_mode = (old_mode << 3) | (ch - '0');
+				cp++;
+			}
+			if (*cp++ != ' ')
 				break;
-			read_line(&sb3, stdin, line_termination);
-			if (sb3.eof)
+			while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+				new_mode = (new_mode << 3) | (ch - '0');
+				cp++;
+			}
+			if (*cp++ != ' ')
 				break;
-			status = parse_diff_raw(sb1.buf+1, sb2.buf, sb3.buf);
-		}
-		else
-			status = parse_diff_raw(sb1.buf+1, NULL, NULL);
-		if (status) {
-		unrecognized:
-			diff_flush(diff_output_style);
-			printf("%s\n", sb1.buf);
+			if (get_sha1_hex(cp, old_sha1))
+				break;
+			cp += 40;
+			if (*cp++ != ' ')
+				break;
+			if (get_sha1_hex(cp, new_sha1))
+				break;
+			cp += 40;
+			if (*cp++ != ' ')
+				break;
+			status = *cp++;
+			if (!strchr("MCRNDU", status))
+				break;
+			two_paths = score = 0;
+			if (status == 'R' || status == 'C') {
+				two_paths = 1;
+				sscanf(cp, "%d", &score);
+				if (line_termination) {
+					cp = strchr(cp,
+						    inter_name_termination);
+					if (!cp)
+						break;
+				}
+			}
+
+			if (*cp++ != inter_name_termination)
+				break;
+
+			/* first pathname */
+			if (!line_termination) {
+				read_line(&sb, stdin, line_termination);
+				if (sb.eof)
+					break;
+				strcpy(old_path, sb.buf);
+			}
+			else if (!two_paths)
+				strcpy(old_path, cp);
+			else {
+				ep = strchr(cp, inter_name_termination);
+				if (!ep)
+					break;
+				strncpy(old_path, cp, ep-cp);
+				old_path[ep-cp] = 0;
+				cp = ep + 1;
+			}
+
+			/* second pathname */
+			if (!two_paths)
+				strcpy(new_path, old_path);
+			else {
+				if (!line_termination) {
+					read_line(&sb, stdin,
+						  line_termination);
+					if (sb.eof)
+						break;
+					strcpy(new_path, sb.buf);
+				}
+				else
+					strcpy(new_path, cp);
+			}
+			diff_helper_input(old_mode, new_mode,
+					  old_sha1, new_sha1,
+					  old_path, status, score,
+					  new_path);
+			continue;
 		}
+		if (pickaxe)
+			diffcore_pickaxe(pickaxe);
+		if (1 < ac)
+			diffcore_pathspec(av + 1);
+		diff_flush(DIFF_FORMAT_PATCH, 0);
+		printf("%s\n", sb.buf);
 	}
-	if (detect_rename)
-		diffcore_rename(detect_rename, diff_score_opt);
-	diffcore_prune();
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe);
-	if (ac)
+	if (1 < ac)
 		diffcore_pathspec(av + 1);
-	diff_flush(diff_output_style);
+	diff_flush(DIFF_FORMAT_PATCH, 0);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -270,7 +270,7 @@ static int call_diff_flush(void)
 	if (pickaxe) {
 		diffcore_pickaxe(pickaxe);
 		if (diff_queue_is_empty()) {
-			diff_flush(DIFF_FORMAT_NO_OUTPUT);
+			diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 			return 0;
 		}
 	}
@@ -291,7 +291,7 @@ static int call_diff_flush(void)
 		}
 		header = NULL;
 	}
-	diff_flush(diff_output_format);
+	diff_flush(diff_output_format, 1);
 	return 1;
 }
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -504,16 +504,29 @@ struct diff_filepair *diff_queue(struct 
 
 static void diff_flush_raw(struct diff_filepair *p)
 {
-	if (DIFF_PAIR_UNMERGED(p)) {
-		printf("U %s%c", p->one->path, line_termination);
-		return;
+	int two_paths;
+	char status[10];
+	switch (p->status) {
+	case 'C': case 'R':
+		two_paths = 1;
+		sprintf(status, "%c%1d", p->status, p->score);
+		break;
+	default:
+		two_paths = 0;
+		status[0] = p->status;
+		status[1] = 0;
+		break;
 	}
 	printf(":%06o %06o %s ",
 	       p->one->mode, p->two->mode, sha1_to_hex(p->one->sha1));
-	printf("%s%c%s%c%s%c",
-	       sha1_to_hex(p->two->sha1), inter_name_termination,
-	       p->one->path, inter_name_termination,
-	       p->two->path, line_termination);
+	printf("%s %s%c%s",
+	       sha1_to_hex(p->two->sha1),
+	       status,
+	       inter_name_termination,
+	       p->one->path);
+	if (two_paths)
+		printf("%c%s", inter_name_termination, p->two->path);
+	putchar(line_termination);
 }
 
 int diff_unmodified_pair(struct diff_filepair *p)
@@ -548,9 +561,10 @@ int diff_unmodified_pair(struct diff_fil
 	return 0;
 }
 
-static void diff_flush_patch(struct diff_filepair *p, const char *msg)
+static void diff_flush_patch(struct diff_filepair *p)
 {
 	const char *name, *other;
+	char msg_[PATH_MAX*2+200], *msg;
 
 	/* diffcore_prune() keeps "stay" entries for diff-raw
 	 * copy/rename detection, but when we are generating
@@ -565,6 +579,29 @@ static void diff_flush_patch(struct diff
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
 		return; /* no tree diffs in patch format */ 
 
+	switch (p->status) {
+	case 'C':
+		sprintf(msg_,
+			"similarity index %d%%\n"
+			"copy from %s\n"
+			"copy to %s\n",
+			(int)(0.5 + p->score * 100/MAX_SCORE),
+			p->one->path, p->two->path);
+		msg = msg_;
+		break;
+	case 'R':
+		sprintf(msg_,
+			"similarity index %d%%\n"
+			"rename old %s\n"
+			"rename new %s\n",
+			(int)(0.5 + p->score * 100/MAX_SCORE),
+			p->one->path, p->two->path);
+		msg = msg_;
+		break;
+	default:
+		msg = NULL;
+	}
+
 	if (DIFF_PAIR_UNMERGED(p))
 		run_external_diff(name, NULL, NULL, NULL, NULL);
 	else
@@ -643,21 +680,13 @@ void diffcore_prune(void)
 	return;
 }
 
-static void diff_flush_one(struct diff_filepair *p, const char *msg)
-{
-	if (generate_patch)
-		diff_flush_patch(p, msg);
-	else
-		diff_flush_raw(p);
-}
-
 int diff_queue_is_empty(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	return q->nr == 0;
 }
 
-void diff_flush(int diff_output_style)
+void diff_flush(int diff_output_style, int resolve_rename_copy)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -676,28 +705,28 @@ void diff_flush(int diff_output_style)
 		break;
 	}
 	for (i = 0; i < q->nr; i++) {
-		char msg_[PATH_MAX*2+200], *msg = NULL;
 		struct diff_filepair *p = q->queue[i];
-		if (strcmp(p->one->path, p->two->path)) {
-			/* This is rename or copy.  Which one is it? */
-			if (diff_needs_to_stay(q, i+1, p->one)) {
-				sprintf(msg_,
-					"similarity index %d%%\n"
-					"copy from %s\n"
-					"copy to %s\n",
-					(int)(0.5 + p->score * 100/MAX_SCORE),
-					p->one->path, p->two->path);
+		if (resolve_rename_copy) {
+			if (DIFF_PAIR_UNMERGED(p))
+				p->status = 'U';
+			else if (!DIFF_FILE_VALID((p)->one))
+				p->status = 'N';
+			else if (!DIFF_FILE_VALID((p)->two))
+				p->status = 'D';
+			else if (strcmp(p->one->path, p->two->path)) {
+				/* This is rename or copy.  Which one is it? */
+				if (diff_needs_to_stay(q, i+1, p->one))
+					p->status = 'C';
+				else
+					p->status = 'R';
 			}
 			else
-				sprintf(msg_,
-					"similarity index %d%%\n"
-					"rename old %s\n"
-					"rename new %s\n",
-					(int)(0.5 + p->score * 100/MAX_SCORE),
-					p->one->path, p->two->path);
-			msg = msg_;
+				p->status = 'M';
 		}
-		diff_flush_one(p, msg);
+		if (generate_patch)
+			diff_flush_patch(p);
+		else
+			diff_flush_raw(p);
 	}
 
 	for (i = 0; i < q->nr; i++) {
@@ -747,28 +776,27 @@ void diff_addremove(int addremove, unsig
 	diff_queue(&diff_queued_diff, one, two);
 }
 
-void diff_guif(unsigned old_mode,
-	       unsigned new_mode,
-	       const unsigned char *old_sha1,
-	       const unsigned char *new_sha1,
-	       const char *old_path,
-	       const char *new_path)
+void diff_helper_input(unsigned old_mode,
+		       unsigned new_mode,
+		       const unsigned char *old_sha1,
+		       const unsigned char *new_sha1,
+		       const char *old_path,
+		       int status,
+		       int score,
+		       const char *new_path)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *dp;
 
-	if (reverse_diff) {
-		unsigned tmp;
-		const unsigned char *tmp_c;
-		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
-		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
-	}
 	one = alloc_filespec(old_path);
 	two = alloc_filespec(new_path);
 	if (old_mode)
 		fill_filespec(one, old_sha1, old_mode);
 	if (new_mode)
 		fill_filespec(two, new_sha1, new_mode);
-	diff_queue(&diff_queued_diff, one, two);
+	dp = diff_queue(&diff_queued_diff, one, two);
+	dp->score = score;
+	dp->status = status;
 }
 
 void diff_change(unsigned old_mode, unsigned new_mode,
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -15,12 +15,14 @@ extern void diff_change(unsigned mode1, 
 			     const unsigned char *sha2,
 			     const char *base, const char *path);
 
-extern void diff_guif(unsigned mode1,
-		      unsigned mode2,
-		      const unsigned char *sha1,
-		      const unsigned char *sha2,
-		      const char *path1,
-		      const char *path2);
+extern void diff_helper_input(unsigned mode1,
+			      unsigned mode2,
+			      const unsigned char *sha1,
+			      const unsigned char *sha2,
+			      const char *path1,
+			      int status,
+			      int score,
+			      const char *path2);
 
 extern void diff_unmerge(const char *path);
 
@@ -44,6 +46,6 @@ extern void diffcore_pathspec(const char
 
 extern int diff_queue_is_empty(void);
 
-extern void diff_flush(int output_style);
+extern void diff_flush(int output_style, int resolve_rename_copy);
 
 #endif /* DIFF_H */
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -47,6 +47,7 @@ struct diff_filepair {
 			  * certain ordering of patches that later
 			  * diffcore transformations should not break.
 			  */
+	int status; /* M C R N D U (see Documentation/diff-format.txt) */
 };
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -155,14 +155,14 @@ test_expect_success \
      test "$newtree" = "$tree"'
 
 cat >expected <<\EOF
-:100644 100644 f87290f8eb2cbbea7857214459a0739927eab154 0000000000000000000000000000000000000000	path0	path0
-:120000 120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0000000000000000000000000000000000000000	path0sym	path0sym
-:100644 100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0000000000000000000000000000000000000000	path2/file2	path2/file2
-:120000 120000 d8ce161addc5173867a3c3c730924388daedbc38 0000000000000000000000000000000000000000	path2/file2sym	path2/file2sym
-:100644 100644 0aa34cae68d0878578ad119c86ca2b5ed5b28376 0000000000000000000000000000000000000000	path3/file3	path3/file3
-:120000 120000 8599103969b43aff7e430efea79ca4636466794f 0000000000000000000000000000000000000000	path3/file3sym	path3/file3sym
-:100644 100644 00fb5908cb97c2564a9783c0c64087333b3b464f 0000000000000000000000000000000000000000	path3/subp3/file3	path3/subp3/file3
-:120000 120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0000000000000000000000000000000000000000	path3/subp3/file3sym	path3/subp3/file3sym
+:100644 100644 f87290f8eb2cbbea7857214459a0739927eab154 0000000000000000000000000000000000000000 M	path0
+:120000 120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0000000000000000000000000000000000000000 M	path0sym
+:100644 100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0000000000000000000000000000000000000000 M	path2/file2
+:120000 120000 d8ce161addc5173867a3c3c730924388daedbc38 0000000000000000000000000000000000000000 M	path2/file2sym
+:100644 100644 0aa34cae68d0878578ad119c86ca2b5ed5b28376 0000000000000000000000000000000000000000 M	path3/file3
+:120000 120000 8599103969b43aff7e430efea79ca4636466794f 0000000000000000000000000000000000000000 M	path3/file3sym
+:100644 100644 00fb5908cb97c2564a9783c0c64087333b3b464f 0000000000000000000000000000000000000000 M	path3/subp3/file3
+:120000 120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0000000000000000000000000000000000000000 M	path3/subp3/file3sym
 EOF
 test_expect_success \
     'validate git-diff-files output for a know cache/work tree state.' \
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -10,120 +10,120 @@ test_description='Test diff raw-output.
 . ../lib-read-tree-m-3way.sh
 
 cat >.test-plain-OA <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 ccba72ad3888a3520b39efcf780b9ee64167535d	AA	AA
-:000000 100644 0000000000000000000000000000000000000000 7e426fb079479fd67f6d81f984e4ec649a44bc25	AN	AN
-:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000	DD	DD
-:000000 040000 0000000000000000000000000000000000000000 6d50f65d3bdab91c63444294d38f08aeff328e42	DF	DF
-:100644 000000 141c1f1642328e4bc46a7d801a71da392e66791e 0000000000000000000000000000000000000000	DM	DM
-:100644 000000 35abde1506ddf806572ff4d407bd06885d0f8ee9 0000000000000000000000000000000000000000	DN	DN
-:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762	LL	LL
-:100644 100644 03f24c8c4700babccfd28b654e7e8eac402ad6cd 103d9f89b50b9aad03054b579be5e7aa665f2d57	MD	MD
-:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 b431b272d829ff3aa4d1a5085f4394ab4d3305b6	MM	MM
-:100644 100644 bd084b0c27c7b6cc34f11d6d0509a29be3caf970 a716d58de4a570e0038f5c307bd8db34daea021f	MN	MN
-:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f	SS	SS
-:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 4c86f9a85fbc5e6804ee2e17a797538fbe785bca	TT	TT
-:040000 040000 7d670fdcdb9929f6c7dac196ff78689cd1c566a1 5e5f22072bb39f6e12cf663a57cb634c76eefb49	Z	Z
+:000000 100644 0000000000000000000000000000000000000000 ccba72ad3888a3520b39efcf780b9ee64167535d N	AA
+:000000 100644 0000000000000000000000000000000000000000 7e426fb079479fd67f6d81f984e4ec649a44bc25 N	AN
+:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000 D	DD
+:000000 040000 0000000000000000000000000000000000000000 6d50f65d3bdab91c63444294d38f08aeff328e42 N	DF
+:100644 000000 141c1f1642328e4bc46a7d801a71da392e66791e 0000000000000000000000000000000000000000 D	DM
+:100644 000000 35abde1506ddf806572ff4d407bd06885d0f8ee9 0000000000000000000000000000000000000000 D	DN
+:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762 N	LL
+:100644 100644 03f24c8c4700babccfd28b654e7e8eac402ad6cd 103d9f89b50b9aad03054b579be5e7aa665f2d57 M	MD
+:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 M	MM
+:100644 100644 bd084b0c27c7b6cc34f11d6d0509a29be3caf970 a716d58de4a570e0038f5c307bd8db34daea021f M	MN
+:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f M	SS
+:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 4c86f9a85fbc5e6804ee2e17a797538fbe785bca M	TT
+:040000 040000 7d670fdcdb9929f6c7dac196ff78689cd1c566a1 5e5f22072bb39f6e12cf663a57cb634c76eefb49 M	Z
 EOF
 
 cat >.test-recursive-OA <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 ccba72ad3888a3520b39efcf780b9ee64167535d	AA	AA
-:000000 100644 0000000000000000000000000000000000000000 7e426fb079479fd67f6d81f984e4ec649a44bc25	AN	AN
-:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000	DD	DD
-:000000 100644 0000000000000000000000000000000000000000 68a6d8b91da11045cf4aa3a5ab9f2a781c701249	DF/DF	DF/DF
-:100644 000000 141c1f1642328e4bc46a7d801a71da392e66791e 0000000000000000000000000000000000000000	DM	DM
-:100644 000000 35abde1506ddf806572ff4d407bd06885d0f8ee9 0000000000000000000000000000000000000000	DN	DN
-:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762	LL	LL
-:100644 100644 03f24c8c4700babccfd28b654e7e8eac402ad6cd 103d9f89b50b9aad03054b579be5e7aa665f2d57	MD	MD
-:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 b431b272d829ff3aa4d1a5085f4394ab4d3305b6	MM	MM
-:100644 100644 bd084b0c27c7b6cc34f11d6d0509a29be3caf970 a716d58de4a570e0038f5c307bd8db34daea021f	MN	MN
-:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f	SS	SS
-:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 4c86f9a85fbc5e6804ee2e17a797538fbe785bca	TT	TT
-:000000 100644 0000000000000000000000000000000000000000 8acb8e9750e3f644bf323fcf3d338849db106c77	Z/AA	Z/AA
-:000000 100644 0000000000000000000000000000000000000000 087494262084cefee7ed484d20c8dc0580791272	Z/AN	Z/AN
-:100644 000000 879007efae624d2b1307214b24a956f0a8d686a8 0000000000000000000000000000000000000000	Z/DD	Z/DD
-:100644 000000 9b541b2275c06e3a7b13f28badf5294e2ae63df4 0000000000000000000000000000000000000000	Z/DM	Z/DM
-:100644 000000 beb5d38c55283d280685ea21a0e50cfcc0ca064a 0000000000000000000000000000000000000000	Z/DN	Z/DN
-:100644 100644 d41fda41b7ec4de46b43cb7ea42a45001ae393d5 a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9	Z/MD	Z/MD
-:100644 100644 4ca22bae2527d3d9e1676498a0fba3b355bd1278 61422ba9c2c873416061a88cd40a59a35b576474	Z/MM	Z/MM
-:100644 100644 b16d7b25b869f2beb124efa53467d8a1550ad694 a5c544c21cfcb07eb80a4d89a5b7d1570002edfd	Z/MN	Z/MN
+:000000 100644 0000000000000000000000000000000000000000 ccba72ad3888a3520b39efcf780b9ee64167535d N	AA
+:000000 100644 0000000000000000000000000000000000000000 7e426fb079479fd67f6d81f984e4ec649a44bc25 N	AN
+:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000 D	DD
+:000000 100644 0000000000000000000000000000000000000000 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 N	DF/DF
+:100644 000000 141c1f1642328e4bc46a7d801a71da392e66791e 0000000000000000000000000000000000000000 D	DM
+:100644 000000 35abde1506ddf806572ff4d407bd06885d0f8ee9 0000000000000000000000000000000000000000 D	DN
+:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762 N	LL
+:100644 100644 03f24c8c4700babccfd28b654e7e8eac402ad6cd 103d9f89b50b9aad03054b579be5e7aa665f2d57 M	MD
+:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 M	MM
+:100644 100644 bd084b0c27c7b6cc34f11d6d0509a29be3caf970 a716d58de4a570e0038f5c307bd8db34daea021f M	MN
+:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f M	SS
+:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 4c86f9a85fbc5e6804ee2e17a797538fbe785bca M	TT
+:000000 100644 0000000000000000000000000000000000000000 8acb8e9750e3f644bf323fcf3d338849db106c77 N	Z/AA
+:000000 100644 0000000000000000000000000000000000000000 087494262084cefee7ed484d20c8dc0580791272 N	Z/AN
+:100644 000000 879007efae624d2b1307214b24a956f0a8d686a8 0000000000000000000000000000000000000000 D	Z/DD
+:100644 000000 9b541b2275c06e3a7b13f28badf5294e2ae63df4 0000000000000000000000000000000000000000 D	Z/DM
+:100644 000000 beb5d38c55283d280685ea21a0e50cfcc0ca064a 0000000000000000000000000000000000000000 D	Z/DN
+:100644 100644 d41fda41b7ec4de46b43cb7ea42a45001ae393d5 a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9 M	Z/MD
+:100644 100644 4ca22bae2527d3d9e1676498a0fba3b355bd1278 61422ba9c2c873416061a88cd40a59a35b576474 M	Z/MM
+:100644 100644 b16d7b25b869f2beb124efa53467d8a1550ad694 a5c544c21cfcb07eb80a4d89a5b7d1570002edfd M	Z/MN
 EOF
 cat >.test-plain-OB <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2	AA	AA
-:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000	DD	DD
-:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787	DF	DF
-:100644 100644 141c1f1642328e4bc46a7d801a71da392e66791e 3c4d8de5fbad08572bab8e10eef8dbb264cf0231	DM	DM
-:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762	LL	LL
-:100644 000000 03f24c8c4700babccfd28b654e7e8eac402ad6cd 0000000000000000000000000000000000000000	MD	MD
-:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 19989d4559aae417fedee240ccf2ba315ea4dc2b	MM	MM
-:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67	NA	NA
-:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000	ND	ND
-:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983	NM	NM
-:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f	SS	SS
-:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 c4e4a12231b9fa79a0053cb6077fcb21bb5b135a	TT	TT
-:040000 040000 7d670fdcdb9929f6c7dac196ff78689cd1c566a1 1ba523955d5160681af65cb776411f574c1e8155	Z	Z
+:000000 100644 0000000000000000000000000000000000000000 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 N	AA
+:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000 D	DD
+:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787 N	DF
+:100644 100644 141c1f1642328e4bc46a7d801a71da392e66791e 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 M	DM
+:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762 N	LL
+:100644 000000 03f24c8c4700babccfd28b654e7e8eac402ad6cd 0000000000000000000000000000000000000000 D	MD
+:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 19989d4559aae417fedee240ccf2ba315ea4dc2b M	MM
+:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67 N	NA
+:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000 D	ND
+:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983 M	NM
+:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f M	SS
+:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 c4e4a12231b9fa79a0053cb6077fcb21bb5b135a M	TT
+:040000 040000 7d670fdcdb9929f6c7dac196ff78689cd1c566a1 1ba523955d5160681af65cb776411f574c1e8155 M	Z
 EOF
 cat >.test-recursive-OB <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2	AA	AA
-:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000	DD	DD
-:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787	DF	DF
-:100644 100644 141c1f1642328e4bc46a7d801a71da392e66791e 3c4d8de5fbad08572bab8e10eef8dbb264cf0231	DM	DM
-:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762	LL	LL
-:100644 000000 03f24c8c4700babccfd28b654e7e8eac402ad6cd 0000000000000000000000000000000000000000	MD	MD
-:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 19989d4559aae417fedee240ccf2ba315ea4dc2b	MM	MM
-:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67	NA	NA
-:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000	ND	ND
-:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983	NM	NM
-:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f	SS	SS
-:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 c4e4a12231b9fa79a0053cb6077fcb21bb5b135a	TT	TT
-:000000 100644 0000000000000000000000000000000000000000 6c0b99286d0bce551ac4a7b3dff8b706edff3715	Z/AA	Z/AA
-:100644 000000 879007efae624d2b1307214b24a956f0a8d686a8 0000000000000000000000000000000000000000	Z/DD	Z/DD
-:100644 100644 9b541b2275c06e3a7b13f28badf5294e2ae63df4 d77371d15817fcaa57eeec27f770c505ba974ec1	Z/DM	Z/DM
-:100644 000000 d41fda41b7ec4de46b43cb7ea42a45001ae393d5 0000000000000000000000000000000000000000	Z/MD	Z/MD
-:100644 100644 4ca22bae2527d3d9e1676498a0fba3b355bd1278 697aad7715a1e7306ca76290a3dd4208fbaeddfa	Z/MM	Z/MM
-:000000 100644 0000000000000000000000000000000000000000 d12979c22fff69c59ca9409e7a8fe3ee25eaee80	Z/NA	Z/NA
-:100644 000000 a18393c636b98e9bd7296b8b437ea4992b72440c 0000000000000000000000000000000000000000	Z/ND	Z/ND
-:100644 100644 3fdbe17fd013303a2e981e1ca1c6cd6e72789087 7e09d6a3a14bd630913e8c75693cea32157b606d	Z/NM	Z/NM
+:000000 100644 0000000000000000000000000000000000000000 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 N	AA
+:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000 D	DD
+:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787 N	DF
+:100644 100644 141c1f1642328e4bc46a7d801a71da392e66791e 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 M	DM
+:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762 N	LL
+:100644 000000 03f24c8c4700babccfd28b654e7e8eac402ad6cd 0000000000000000000000000000000000000000 D	MD
+:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 19989d4559aae417fedee240ccf2ba315ea4dc2b M	MM
+:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67 N	NA
+:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000 D	ND
+:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983 M	NM
+:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f M	SS
+:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 c4e4a12231b9fa79a0053cb6077fcb21bb5b135a M	TT
+:000000 100644 0000000000000000000000000000000000000000 6c0b99286d0bce551ac4a7b3dff8b706edff3715 N	Z/AA
+:100644 000000 879007efae624d2b1307214b24a956f0a8d686a8 0000000000000000000000000000000000000000 D	Z/DD
+:100644 100644 9b541b2275c06e3a7b13f28badf5294e2ae63df4 d77371d15817fcaa57eeec27f770c505ba974ec1 M	Z/DM
+:100644 000000 d41fda41b7ec4de46b43cb7ea42a45001ae393d5 0000000000000000000000000000000000000000 D	Z/MD
+:100644 100644 4ca22bae2527d3d9e1676498a0fba3b355bd1278 697aad7715a1e7306ca76290a3dd4208fbaeddfa M	Z/MM
+:000000 100644 0000000000000000000000000000000000000000 d12979c22fff69c59ca9409e7a8fe3ee25eaee80 N	Z/NA
+:100644 000000 a18393c636b98e9bd7296b8b437ea4992b72440c 0000000000000000000000000000000000000000 D	Z/ND
+:100644 100644 3fdbe17fd013303a2e981e1ca1c6cd6e72789087 7e09d6a3a14bd630913e8c75693cea32157b606d M	Z/NM
 EOF
 cat >.test-plain-AB <<\EOF
-:100644 100644 ccba72ad3888a3520b39efcf780b9ee64167535d 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2	AA	AA
-:100644 000000 7e426fb079479fd67f6d81f984e4ec649a44bc25 0000000000000000000000000000000000000000	AN	AN
-:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787	DF	DF
-:040000 000000 6d50f65d3bdab91c63444294d38f08aeff328e42 0000000000000000000000000000000000000000	DF	DF
-:000000 100644 0000000000000000000000000000000000000000 3c4d8de5fbad08572bab8e10eef8dbb264cf0231	DM	DM
-:000000 100644 0000000000000000000000000000000000000000 35abde1506ddf806572ff4d407bd06885d0f8ee9	DN	DN
-:100644 000000 103d9f89b50b9aad03054b579be5e7aa665f2d57 0000000000000000000000000000000000000000	MD	MD
-:100644 100644 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 19989d4559aae417fedee240ccf2ba315ea4dc2b	MM	MM
-:100644 100644 a716d58de4a570e0038f5c307bd8db34daea021f bd084b0c27c7b6cc34f11d6d0509a29be3caf970	MN	MN
-:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67	NA	NA
-:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000	ND	ND
-:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983	NM	NM
-:100644 100644 4c86f9a85fbc5e6804ee2e17a797538fbe785bca c4e4a12231b9fa79a0053cb6077fcb21bb5b135a	TT	TT
-:040000 040000 5e5f22072bb39f6e12cf663a57cb634c76eefb49 1ba523955d5160681af65cb776411f574c1e8155	Z	Z
+:100644 100644 ccba72ad3888a3520b39efcf780b9ee64167535d 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 M	AA
+:100644 000000 7e426fb079479fd67f6d81f984e4ec649a44bc25 0000000000000000000000000000000000000000 D	AN
+:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787 N	DF
+:040000 000000 6d50f65d3bdab91c63444294d38f08aeff328e42 0000000000000000000000000000000000000000 D	DF
+:000000 100644 0000000000000000000000000000000000000000 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 N	DM
+:000000 100644 0000000000000000000000000000000000000000 35abde1506ddf806572ff4d407bd06885d0f8ee9 N	DN
+:100644 000000 103d9f89b50b9aad03054b579be5e7aa665f2d57 0000000000000000000000000000000000000000 D	MD
+:100644 100644 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 19989d4559aae417fedee240ccf2ba315ea4dc2b M	MM
+:100644 100644 a716d58de4a570e0038f5c307bd8db34daea021f bd084b0c27c7b6cc34f11d6d0509a29be3caf970 M	MN
+:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67 N	NA
+:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000 D	ND
+:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983 M	NM
+:100644 100644 4c86f9a85fbc5e6804ee2e17a797538fbe785bca c4e4a12231b9fa79a0053cb6077fcb21bb5b135a M	TT
+:040000 040000 5e5f22072bb39f6e12cf663a57cb634c76eefb49 1ba523955d5160681af65cb776411f574c1e8155 M	Z
 EOF
 cat >.test-recursive-AB <<\EOF
-:100644 100644 ccba72ad3888a3520b39efcf780b9ee64167535d 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2	AA	AA
-:100644 000000 7e426fb079479fd67f6d81f984e4ec649a44bc25 0000000000000000000000000000000000000000	AN	AN
-:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787	DF	DF
-:100644 000000 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 0000000000000000000000000000000000000000	DF/DF	DF/DF
-:000000 100644 0000000000000000000000000000000000000000 3c4d8de5fbad08572bab8e10eef8dbb264cf0231	DM	DM
-:000000 100644 0000000000000000000000000000000000000000 35abde1506ddf806572ff4d407bd06885d0f8ee9	DN	DN
-:100644 000000 103d9f89b50b9aad03054b579be5e7aa665f2d57 0000000000000000000000000000000000000000	MD	MD
-:100644 100644 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 19989d4559aae417fedee240ccf2ba315ea4dc2b	MM	MM
-:100644 100644 a716d58de4a570e0038f5c307bd8db34daea021f bd084b0c27c7b6cc34f11d6d0509a29be3caf970	MN	MN
-:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67	NA	NA
-:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000	ND	ND
-:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983	NM	NM
-:100644 100644 4c86f9a85fbc5e6804ee2e17a797538fbe785bca c4e4a12231b9fa79a0053cb6077fcb21bb5b135a	TT	TT
-:100644 100644 8acb8e9750e3f644bf323fcf3d338849db106c77 6c0b99286d0bce551ac4a7b3dff8b706edff3715	Z/AA	Z/AA
-:100644 000000 087494262084cefee7ed484d20c8dc0580791272 0000000000000000000000000000000000000000	Z/AN	Z/AN
-:000000 100644 0000000000000000000000000000000000000000 d77371d15817fcaa57eeec27f770c505ba974ec1	Z/DM	Z/DM
-:000000 100644 0000000000000000000000000000000000000000 beb5d38c55283d280685ea21a0e50cfcc0ca064a	Z/DN	Z/DN
-:100644 000000 a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9 0000000000000000000000000000000000000000	Z/MD	Z/MD
-:100644 100644 61422ba9c2c873416061a88cd40a59a35b576474 697aad7715a1e7306ca76290a3dd4208fbaeddfa	Z/MM	Z/MM
-:100644 100644 a5c544c21cfcb07eb80a4d89a5b7d1570002edfd b16d7b25b869f2beb124efa53467d8a1550ad694	Z/MN	Z/MN
-:000000 100644 0000000000000000000000000000000000000000 d12979c22fff69c59ca9409e7a8fe3ee25eaee80	Z/NA	Z/NA
-:100644 000000 a18393c636b98e9bd7296b8b437ea4992b72440c 0000000000000000000000000000000000000000	Z/ND	Z/ND
-:100644 100644 3fdbe17fd013303a2e981e1ca1c6cd6e72789087 7e09d6a3a14bd630913e8c75693cea32157b606d	Z/NM	Z/NM
+:100644 100644 ccba72ad3888a3520b39efcf780b9ee64167535d 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 M	AA
+:100644 000000 7e426fb079479fd67f6d81f984e4ec649a44bc25 0000000000000000000000000000000000000000 D	AN
+:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787 N	DF
+:100644 000000 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 0000000000000000000000000000000000000000 D	DF/DF
+:000000 100644 0000000000000000000000000000000000000000 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 N	DM
+:000000 100644 0000000000000000000000000000000000000000 35abde1506ddf806572ff4d407bd06885d0f8ee9 N	DN
+:100644 000000 103d9f89b50b9aad03054b579be5e7aa665f2d57 0000000000000000000000000000000000000000 D	MD
+:100644 100644 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 19989d4559aae417fedee240ccf2ba315ea4dc2b M	MM
+:100644 100644 a716d58de4a570e0038f5c307bd8db34daea021f bd084b0c27c7b6cc34f11d6d0509a29be3caf970 M	MN
+:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67 N	NA
+:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000 D	ND
+:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983 M	NM
+:100644 100644 4c86f9a85fbc5e6804ee2e17a797538fbe785bca c4e4a12231b9fa79a0053cb6077fcb21bb5b135a M	TT
+:100644 100644 8acb8e9750e3f644bf323fcf3d338849db106c77 6c0b99286d0bce551ac4a7b3dff8b706edff3715 M	Z/AA
+:100644 000000 087494262084cefee7ed484d20c8dc0580791272 0000000000000000000000000000000000000000 D	Z/AN
+:000000 100644 0000000000000000000000000000000000000000 d77371d15817fcaa57eeec27f770c505ba974ec1 N	Z/DM
+:000000 100644 0000000000000000000000000000000000000000 beb5d38c55283d280685ea21a0e50cfcc0ca064a N	Z/DN
+:100644 000000 a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9 0000000000000000000000000000000000000000 D	Z/MD
+:100644 100644 61422ba9c2c873416061a88cd40a59a35b576474 697aad7715a1e7306ca76290a3dd4208fbaeddfa M	Z/MM
+:100644 100644 a5c544c21cfcb07eb80a4d89a5b7d1570002edfd b16d7b25b869f2beb124efa53467d8a1550ad694 M	Z/MN
+:000000 100644 0000000000000000000000000000000000000000 d12979c22fff69c59ca9409e7a8fe3ee25eaee80 N	Z/NA
+:100644 000000 a18393c636b98e9bd7296b8b437ea4992b72440c 0000000000000000000000000000000000000000 D	Z/ND
+:100644 100644 3fdbe17fd013303a2e981e1ca1c6cd6e72789087 7e09d6a3a14bd630913e8c75693cea32157b606d M	Z/NM
 EOF
 
 x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
@@ -134,7 +134,7 @@ cmp_diff_files_output () {
     # object ID for the changed files because it wants you to look at the
     # filesystem.
     sed <"$2" >.test-tmp \
-	-e '/^:000000 /d;s/'$x40'	/'$z40'	/' &&
+	-e '/^:000000 /d;s/'$x40'\( [MCRNDU][0-9]*\)	/'$z40'\1	/' &&
     diff "$1" .test-tmp
 }
 
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -8,6 +8,14 @@ test_description='More rename detection
 '
 . ./test-lib.sh
 
+compare_diff_patch () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    sed -e '/^similarity index [0-9]*%$/d' <"$1" >.tmp-1
+    sed -e '/^similarity index [0-9]*%$/d' <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
 test_expect_success \
     'prepare reference tree' \
     'cat ../../COPYING >COPYING &&
@@ -28,38 +36,35 @@ test_expect_success \
 # copy-and-edit one, and rename-and-edit the other.  We do not say
 # anything about rezrov.
 
-GIT_DIFF_OPTS=--unified=0 git-diff-cache -M -p $tree |
-sed -e 's/\([0-9][0-9]*\)/#/g' >current &&
+GIT_DIFF_OPTS=--unified=0 git-diff-cache -M -p $tree >current
 cat >expected <<\EOF
-diff --git a/COPYING b/COPYING.#
-similarity index #%
+diff --git a/COPYING b/COPYING.1
 copy from COPYING
-copy to COPYING.#
+copy to COPYING.1
 --- a/COPYING
-+++ b/COPYING.#
-@@ -# +# @@
-- HOWEVER, in order to allow a migration to GPLv# if that seems like
-+ However, in order to allow a migration to GPLv# if that seems like
-diff --git a/COPYING b/COPYING.#
-similarity index #%
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
+diff --git a/COPYING b/COPYING.2
 rename old COPYING
-rename new COPYING.#
+rename new COPYING.2
 --- a/COPYING
-+++ b/COPYING.#
-@@ -# +# @@
++++ b/COPYING.2
+@@ -2 +2 @@
 - Note that the only valid version of the GPL as far as this project
 + Note that the only valid version of the G.P.L as far as this project
-@@ -# +# @@
-- HOWEVER, in order to allow a migration to GPLv# if that seems like
-+ HOWEVER, in order to allow a migration to G.P.Lv# if that seems like
-@@ -# +# @@
--	This file is licensed under the GPL v#, or a later version
-+	This file is licensed under the G.P.L v#, or a later version
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv3 if that seems like
+@@ -12 +12 @@
+-	This file is licensed under the GPL v2, or a later version
++	This file is licensed under the G.P.L v2, or a later version
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
-    'diff -u current expected'
+    'validate output from rename/copy detection (#1)' \
+    'compare_diff_patch current expected'
 
 test_expect_success \
     'prepare work tree again' \
@@ -71,35 +76,33 @@ test_expect_success \
 # edited one, and copy-and-edit the other.  We do not say
 # anything about rezrov.
 
-GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree |
-sed -e 's/\([0-9][0-9]*\)/#/g' >current
+GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree >current
 cat >expected <<\EOF
-diff --git a/COPYING b/COPYING.#
-similarity index #%
+diff --git a/COPYING b/COPYING.1
 copy from COPYING
-copy to COPYING.#
+copy to COPYING.1
 --- a/COPYING
-+++ b/COPYING.#
-@@ -# +# @@
-- HOWEVER, in order to allow a migration to GPLv# if that seems like
-+ However, in order to allow a migration to GPLv# if that seems like
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
 diff --git a/COPYING b/COPYING
 --- a/COPYING
 +++ b/COPYING
-@@ -# +# @@
+@@ -2 +2 @@
 - Note that the only valid version of the GPL as far as this project
 + Note that the only valid version of the G.P.L as far as this project
-@@ -# +# @@
-- HOWEVER, in order to allow a migration to GPLv# if that seems like
-+ HOWEVER, in order to allow a migration to G.P.Lv# if that seems like
-@@ -# +# @@
--	This file is licensed under the GPL v#, or a later version
-+	This file is licensed under the G.P.L v#, or a later version
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv3 if that seems like
+@@ -12 +12 @@
+-	This file is licensed under the GPL v2, or a later version
++	This file is licensed under the G.P.L v2, or a later version
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
-    'diff -u current expected'
+    'validate output from rename/copy detection (#2)' \
+    'compare_diff_patch current expected'
 
 test_expect_success \
     'prepare work tree once again' \
@@ -112,22 +115,20 @@ test_expect_success \
 # the diff-core.  Unchanged rezrov, although being fed to
 # git-diff-cache as well, should not be mentioned.
 
-GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree |
-sed -e 's/\([0-9][0-9]*\)/#/g' >current
+GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree >current
 cat >expected <<\EOF
-diff --git a/COPYING b/COPYING.#
-similarity index #%
+diff --git a/COPYING b/COPYING.1
 copy from COPYING
-copy to COPYING.#
+copy to COPYING.1
 --- a/COPYING
-+++ b/COPYING.#
-@@ -# +# @@
-- HOWEVER, in order to allow a migration to GPLv# if that seems like
-+ However, in order to allow a migration to GPLv# if that seems like
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
-    'diff -u current expected'
+    'validate output from rename/copy detection (#3)' \
+    'compare_diff_patch current expected'
 
 test_done
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -8,6 +8,22 @@ test_description='Same rename detection 
 '
 . ./test-lib.sh
 
+compare_diff_raw () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    sed -e 's/ \([CR]\)[0-9]*	/\1#/' <"$1" >.tmp-1
+    sed -e 's/ \([CR]\)[0-9]*	/\1#/' <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+compare_diff_patch () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    sed -e '/^similarity index [0-9]*%$/d' <"$1" >.tmp-1
+    sed -e '/^similarity index [0-9]*%$/d' <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
 test_expect_success \
     'prepare reference tree' \
     'cat ../../COPYING >COPYING &&
@@ -31,13 +47,47 @@ test_expect_success \
 git-diff-cache -M $tree >current
 
 cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178	COPYING	COPYING.1
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471	COPYING	COPYING.2
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 R1234	COPYING	COPYING.2
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
-    'diff -u current expected'
+    'validate output from rename/copy detection (#1)' \
+    'compare_diff_raw current expected'
+
+# make sure diff-helper can grok it.
+mv expected diff-raw
+GIT_DIFF_OPTS=--unified=0 git-diff-helper <diff-raw >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.1
+copy from COPYING
+copy to COPYING.1
+--- a/COPYING
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
+diff --git a/COPYING b/COPYING.2
+rename old COPYING
+rename new COPYING.2
+--- a/COPYING
++++ b/COPYING.2
+@@ -2 +2 @@
+- Note that the only valid version of the GPL as far as this project
++ Note that the only valid version of the G.P.L as far as this project
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv3 if that seems like
+@@ -12 +12 @@
+-	This file is licensed under the GPL v2, or a later version
++	This file is licensed under the G.P.L v2, or a later version
+EOF
+
+test_expect_success \
+    'validate output from diff-helper (#1)' \
+    'compare_diff_patch current expected'
+
+################################################################
 
 test_expect_success \
     'prepare work tree again' \
@@ -51,19 +101,51 @@ test_expect_success \
 
 git-diff-cache -C $tree >current
 cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178	COPYING	COPYING.1
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471	COPYING	COPYING
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 M	COPYING
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
-    'diff -u current expected'
+    'validate output from rename/copy detection (#2)' \
+    'compare_diff_raw current expected'
 
 test_expect_success \
     'prepare work tree once again' \
     'cat ../../COPYING >COPYING &&
      git-update-cache --add --remove COPYING COPYING.1'
 
+# make sure diff-helper can grok it.
+mv expected diff-raw
+GIT_DIFF_OPTS=--unified=0 git-diff-helper <diff-raw >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.1
+copy from COPYING
+copy to COPYING.1
+--- a/COPYING
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
+diff --git a/COPYING b/COPYING
+--- a/COPYING
++++ b/COPYING
+@@ -2 +2 @@
+- Note that the only valid version of the GPL as far as this project
++ Note that the only valid version of the G.P.L as far as this project
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv3 if that seems like
+@@ -12 +12 @@
+-	This file is licensed under the GPL v2, or a later version
++	This file is licensed under the G.P.L v2, or a later version
+EOF
+
+test_expect_success \
+    'validate output from diff-helper (#2)' \
+    'compare_diff_patch current expected'
+
+################################################################
+
 # tree has COPYING and rezrov.  work tree has the same COPYING and
 # copy-edited COPYING.1, and unchanged rezrov.  We should see
 # unmodified COPYING in the output, so that downstream diff-helper can
@@ -71,12 +153,30 @@ test_expect_success \
 
 git-diff-cache -C $tree >current
 cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178	COPYING	COPYING.1
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3	COPYING	COPYING
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M	COPYING
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection (#3)' \
+    'compare_diff_raw current expected'
+
+# make sure diff-helper can grok it.
+mv expected diff-raw
+GIT_DIFF_OPTS=--unified=0 git-diff-helper <diff-raw >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.1
+copy from COPYING
+copy to COPYING.1
+--- a/COPYING
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
-    'diff -u current expected'
+    'validate output from diff-helper (#3)' \
+    'compare_diff_patch current expected'
 
 test_done
------------------------------------------------

