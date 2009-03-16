From: pi song <pi.songs@gmail.com>
Subject: [PATCH1/2]  Libify blame
Date: Tue, 17 Mar 2009 00:25:23 +1100
Message-ID: <49BE5343.60900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 16 14:28:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjCqc-000452-1Z
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 14:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbZCPNZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 09:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZCPNZd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 09:25:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:50306 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbZCPNZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 09:25:32 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1778464wah.21
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=hwPmmClQSWnmWVYqwR73yIqFCF8CQRKHxt5mlTc+2A4=;
        b=nk8Bp1rWsjTSjcdyJI84GBzXEgeZtHdyiMwn2SkjwT98+r5kFEJWMVN3XJ/Eu97M8J
         o1NrP7tdSyBUpl1yj5wJpZ+NmTJVYjERnMZ8jm/sxJ6PwHA/Z+I2jfuxjPkW/rHOULHE
         Mcba0/eaf8vElZley4sruYDRNBKq69AocVkAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=uw3dVa/nAneKjCjclAFQymsUGEqGKLwjkHJoZaXwHH+bxzIaiwIyIF5M68kx5Tve1w
         iWEIx3k8pjpFWsDDaR7PNaigFXAwSgYk65ktansJ33+eRSD5blBlxe6ZgTuCm6LGsuvz
         cgBwUbif99H1RHoPpIIu4QLmqHMAI0StZ/Oow=
Received: by 10.114.94.12 with SMTP id r12mr3314583wab.229.1237209930567;
        Mon, 16 Mar 2009 06:25:30 -0700 (PDT)
Received: from ?192.168.0.5? (203-219-184-102.static.tpgi.com.au [203.219.184.102])
        by mx.google.com with ESMTPS id z15sm25079841pod.14.2009.03.16.06.25.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Mar 2009 06:25:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113322>

The patch does extract blame.h

Signed-off-by: Pi Song <pi.songs@gmail.com>
---
 Makefile        |    1 +
 blame.h         |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin-blame.c |  145 +-----------------------------------------------
 3 files changed, 169 insertions(+), 143 deletions(-)
 create mode 100644 blame.h

diff --git a/Makefile b/Makefile
index 38ede68..cc0fb5a 100644
--- a/Makefile
+++ b/Makefile
@@ -359,6 +359,7 @@ XDIFF_LIB=xdiff/lib.a
 
 LIB_H += archive.h
 LIB_H += attr.h
+LIB_H += blame.h
 LIB_H += blob.h
 LIB_H += builtin.h
 LIB_H += cache.h
diff --git a/blame.h b/blame.h
new file mode 100644
index 0000000..72d1e2a
--- /dev/null
+++ b/blame.h
@@ -0,0 +1,166 @@
+#ifndef BLAME_H
+#define BLAME_H
+
+#include "cache.h"
+#include "builtin.h"
+#include "revision.h"
+#include "commit.h"
+#include "string-list.h"
+#include "xdiff-interface.h"
+
+
+/*
+ * for storing stats. it can be used
+ * across multiple blame operations
+ */
+struct blame_stat {
+	int num_read_blob;
+	int num_get_patch;
+	int num_commits;
+};
+
+#define PICKAXE_BLAME_MOVE		01
+#define PICKAXE_BLAME_COPY		02
+#define PICKAXE_BLAME_COPY_HARDER	04
+#define PICKAXE_BLAME_COPY_HARDEST	010
+
+#define BLAME_DEFAULT_MOVE_SCORE	20
+#define BLAME_DEFAULT_COPY_SCORE	40
+
+/* bits #0..7 in revision.h, #8..11 used for merge_bases() in commit.c */
+#define METAINFO_SHOWN		(1u<<12)
+#define MORE_THAN_ONE_PATH	(1u<<13)
+
+/* output formatting constants */
+#define OUTPUT_ANNOTATE_COMPAT  001
+#define OUTPUT_LONG_OBJECT_NAME 002
+#define OUTPUT_RAW_TIMESTAMP    004
+#define OUTPUT_PORCELAIN        010
+#define OUTPUT_SHOW_NAME        020
+#define OUTPUT_SHOW_NUMBER      040
+#define OUTPUT_SHOW_SCORE      0100
+#define OUTPUT_NO_AUTHOR       0200
+
+/*
+ * One blob in a commit that is being suspected
+ */
+struct origin {
+	int refcnt;
+	struct origin *previous;
+	struct commit *commit;
+	mmfile_t file;
+	unsigned char blob_sha1[20];
+	char path[FLEX_ARRAY];
+};
+
+/*
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
+ * Each group of lines is described by a blame_entry; it can be split
+ * as we pass blame to the parents.  They form a linked list in the
+ * scoreboard structure, sorted by the target line number.
+ */
+struct blame_entry {
+	struct blame_entry *prev;
+	struct blame_entry *next;
+
+	/* the first line of this group in the final image;
+	 * internally all line numbers are 0 based.
+	 */
+	int lno;
+
+	/* how many lines this group has */
+	int num_lines;
+
+	/* the commit that introduced this group into the final image */
+	struct origin *suspect;
+
+	/* true if the suspect is truly guilty; false while we have not
+	 * checked if the group came from one of its parents.
+	 */
+	char guilty;
+
+	/* true if the entry has been scanned for copies in the current parent
+	 */
+	char scanned;
+
+	/* the line number of the first line of this group in the
+	 * suspect's file; internally all line numbers are 0 based.
+	 */
+	int s_lno;
+
+	/* how significant this entry is -- cached to avoid
+	 * scanning the lines over and over.
+	 */
+	unsigned score;
+};
+
+/*
+ * The current state of the blame assignment.
+ */
+struct blame_scoreboard {
+	/* the final commit (i.e. where we started digging from) */
+	struct commit *final;
+	struct rev_info *revs;
+	const char *path;
+
+	/*
+	 * The contents in the final image.
+	 * Used by many functions to obtain contents of the nth line,
+	 * indexed with scoreboard.lineno[blame_entry.lno].
+	 */
+	const char *final_buf;
+	unsigned long final_buf_size;
+
+	/* linked list of blames */
+	struct blame_entry *ent;
+
+	/* look-up a line in the final buffer */
+	int num_lines;
+	int *lineno;
+
+	struct blame_info *ssb;
+};
+
+extern void assign_blame(struct blame_scoreboard *sb, int opt) ;
+
+#endif
diff --git a/builtin-blame.c b/builtin-blame.c
index fac79be..d4f812b 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -20,6 +20,7 @@
 #include "mailmap.h"
 #include "parse-options.h"
 #include "utf8.h"
+#include "blame.h"
 
 static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
 
@@ -39,81 +40,6 @@ static unsigned opt_blame_copy_score;
 #endif
 
 /*
- * for storing stats. it can be used
- * across multiple blame operations
- */
-struct blame_stat {
-	int num_read_blob;
-	int num_get_patch;
-	int num_commits;
-};
-
-#define PICKAXE_BLAME_MOVE		01
-#define PICKAXE_BLAME_COPY		02
-#define PICKAXE_BLAME_COPY_HARDER	04
-#define PICKAXE_BLAME_COPY_HARDEST	010
-
-#define BLAME_DEFAULT_MOVE_SCORE	20
-#define BLAME_DEFAULT_COPY_SCORE	40
-
-/* bits #0..7 in revision.h, #8..11 used for merge_bases() in commit.c */
-#define METAINFO_SHOWN		(1u<<12)
-#define MORE_THAN_ONE_PATH	(1u<<13)
-
-/*
- * One blob in a commit that is being suspected
- */
-struct origin {
-	int refcnt;
-	struct origin *previous;
-	struct commit *commit;
-	mmfile_t file;
-	unsigned char blob_sha1[20];
-	char path[FLEX_ARRAY];
-};
-
-/*
- * stores things that survive across multiple blame operations
- * 1) for blame specific global parameters
- * 2) for reusable structures (possibly for optimization purpose)
- */
-struct blame_info {
-	/*
-	 * miscellaneous parameters collected during processing
-	 * for pretty formatting purpose
-	 */
-	int longest_file;
-	int longest_author;
-	int max_orig_digits;
-	int max_digits;
-	int max_score_digits;
-
-	/* formatting parameters */
-	int show_root;
-	int reverse;
-	int blank_boundary;
-	int incremental;
-	int xdl_opts;
-
-	/*
-	 * blame for a blame_entry with score lower than these thresholds
-	 * is not passed to the parent using move/copy logic.
-	 */
-	unsigned blame_move_score;
-	unsigned blame_copy_score;
-
-	/* date formatting related */
-	enum date_mode blame_date_mode;
-	size_t blame_date_width;
-
-	/* for fast mailmap lookup */
-	struct string_list mailmap;
-
-	/* for stat collecting purpose */
-	struct blame_stat *stat;
-};
-
-/*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
@@ -163,73 +89,6 @@ static void drop_origin_blob(struct origin *o)
 	}
 }
 
-/*
- * Each group of lines is described by a blame_entry; it can be split
- * as we pass blame to the parents.  They form a linked list in the
- * scoreboard structure, sorted by the target line number.
- */
-struct blame_entry {
-	struct blame_entry *prev;
-	struct blame_entry *next;
-
-	/* the first line of this group in the final image;
-	 * internally all line numbers are 0 based.
-	 */
-	int lno;
-
-	/* how many lines this group has */
-	int num_lines;
-
-	/* the commit that introduced this group into the final image */
-	struct origin *suspect;
-
-	/* true if the suspect is truly guilty; false while we have not
-	 * checked if the group came from one of its parents.
-	 */
-	char guilty;
-
-	/* true if the entry has been scanned for copies in the current parent
-	 */
-	char scanned;
-
-	/* the line number of the first line of this group in the
-	 * suspect's file; internally all line numbers are 0 based.
-	 */
-	int s_lno;
-
-	/* how significant this entry is -- cached to avoid
-	 * scanning the lines over and over.
-	 */
-	unsigned score;
-};
-
-/*
- * The current state of the blame assignment.
- */
-struct blame_scoreboard {
-	/* the final commit (i.e. where we started digging from) */
-	struct commit *final;
-	struct rev_info *revs;
-	const char *path;
-
-	/*
-	 * The contents in the final image.
-	 * Used by many functions to obtain contents of the nth line,
-	 * indexed with scoreboard.lineno[blame_entry.lno].
-	 */
-	const char *final_buf;
-	unsigned long final_buf_size;
-
-	/* linked list of blames */
-	struct blame_entry *ent;
-
-	/* look-up a line in the final buffer */
-	int num_lines;
-	int *lineno;
-
-	struct blame_info *ssb;
-};
-
 static inline int same_suspect(struct origin *a, struct origin *b)
 {
 	if (a == b)
@@ -1520,7 +1379,7 @@ static void found_guilty_entry(struct blame_info *ssb, struct blame_entry *ent)
  * is still unknown, pick one blame_entry, and allow its current
  * suspect to pass blames to its parents.
  */
-static void assign_blame(struct blame_scoreboard *sb, int opt)
+void assign_blame(struct blame_scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 
-- 
1.5.4.3
