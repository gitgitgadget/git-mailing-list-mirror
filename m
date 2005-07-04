From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] enum for diff status
Date: Sun, 03 Jul 2005 21:18:35 -0400
Message-ID: <1120439915.30987.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 04 03:19:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpFc3-0001qA-A0
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 03:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVGDBTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 21:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGDBTA
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 21:19:00 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:56545
	"HELO roinet.com") by vger.kernel.org with SMTP id S261591AbVGDBSq
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 21:18:46 -0400
Received: (qmail 4068 invoked from network); 4 Jul 2005 01:18:46 -0000
Received: from mtproxy.roinet.com (HELO dv) (192.168.1.1)
  by roinet.com with SMTP; 4 Jul 2005 01:18:46 -0000
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

Readability of the sources could be improved by replacing one-char diff
status with more verbose keywords.  This patch converts diff status to
enum.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -54,7 +54,8 @@ int main(int ac, const char **av) {
 		unsigned old_mode, new_mode;
 		unsigned char old_sha1[20], new_sha1[20];
 		char old_path[PATH_MAX];
-		int status, score, two_paths;
+		enum diff_status status;
+		int score, two_paths;
 		char new_path[PATH_MAX];
 
 		int ch;
@@ -94,7 +95,8 @@ int main(int ac, const char **av) {
 			if (!strchr("MCRNDU", status))
 				break;
 			two_paths = score = 0;
-			if (status == 'R' || status == 'C')
+			if (status == DIFF_STATUS_RENAMED ||
+			    status == DIFF_STATUS_COPIED)
 				two_paths = 1;
 
 			/* pick up score if exists */
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -652,7 +652,7 @@ static void run_diff(struct diff_filepai
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 	one = p->one; two = p->two;
 	switch (p->status) {
-	case 'C':
+	case DIFF_STATUS_COPIED:
 		sprintf(msg_,
 			"similarity index %d%%\n"
 			"copy from %s\n"
@@ -661,7 +661,7 @@ static void run_diff(struct diff_filepai
 			name, other);
 		xfrm_msg = msg_;
 		break;
-	case 'R':
+	case DIFF_STATUS_RENAMED:
 		sprintf(msg_,
 			"similarity index %d%%\n"
 			"rename from %s\n"
@@ -670,7 +670,7 @@ static void run_diff(struct diff_filepai
 			name, other);
 		xfrm_msg = msg_;
 		break;
-	case 'M':
+	case DIFF_STATUS_MODIFIED:
 		if (p->score) {
 			sprintf(msg_,
 				"dissimilarity index %d%%",
@@ -792,7 +792,7 @@ struct diff_filepair *diff_queue(struct 
 	dp->one = one;
 	dp->two = two;
 	dp->score = 0;
-	dp->status = 0;
+	dp->status = DIFF_STATUS_UNKNOWN;
 	dp->source_stays = 0;
 	dp->broken_pair = 0;
 	diff_q(queue, dp);
@@ -831,10 +831,12 @@ static void diff_flush_raw(struct diff_f
 		status[1] = 0;
 	}
 	switch (p->status) {
-	case 'C': case 'R':
+	case DIFF_STATUS_COPIED:
+	case DIFF_STATUS_RENAMED:
 		two_paths = 1;
 		break;
-	case 'N': case 'D':
+	case DIFF_STATUS_NEW:
+	case DIFF_STATUS_DELETED:
 		two_paths = 0;
 		break;
 	default:
@@ -955,15 +957,15 @@ static void diff_resolve_rename_copy(voi
 
 	for (i = 0; i < q->nr; i++) {
 		p = q->queue[i];
-		p->status = 0; /* undecided */
+		p->status = DIFF_STATUS_UNKNOWN;
 		if (DIFF_PAIR_UNMERGED(p))
-			p->status = 'U';
+			p->status = DIFF_STATUS_UNMERGED;
 		else if (!DIFF_FILE_VALID(p->one))
-			p->status = 'N';
+			p->status = DIFF_STATUS_NEW;
 		else if (!DIFF_FILE_VALID(p->two))
-			p->status = 'D';
+			p->status = DIFF_STATUS_DELETED;
 		else if (DIFF_PAIR_TYPE_CHANGED(p))
-			p->status = 'T';
+			p->status = DIFF_STATUS_TYPE_CHANGED;
 
 		/* from this point on, we are dealing with a pair
 		 * whose both sides are valid and of the same type, i.e.
@@ -971,7 +973,7 @@ static void diff_resolve_rename_copy(voi
 		 */
 		else if (DIFF_PAIR_RENAME(p)) {
 			if (p->source_stays) {
-				p->status = 'C';
+				p->status = DIFF_STATUS_COPIED;
 				continue;
 			}
 			/* See if there is some other filepair that
@@ -985,22 +987,22 @@ static void diff_resolve_rename_copy(voi
 				if (!DIFF_PAIR_RENAME(pp))
 					continue; /* not a rename/copy */
 				/* pp is a rename/copy from the same source */
-				p->status = 'C';
+				p->status = DIFF_STATUS_COPIED;
 				break;
 			}
 			if (!p->status)
-				p->status = 'R';
+				p->status = DIFF_STATUS_RENAMED;
 		}
 		else if (memcmp(p->one->sha1, p->two->sha1, 20) ||
 			 p->one->mode != p->two->mode)
-			p->status = 'M';
+			p->status = DIFF_STATUS_MODIFIED;
 		else {
 			/* This is a "no-change" entry and should not
 			 * happen anymore, but prepare for broken callers.
 			 */
 			error("feeding unmodified %s to diffcore",
 			      p->one->path);
-			p->status = 'X';
+			p->status = DIFF_STATUS_UNCHANGED;
 		}
 	}
 	diff_debug_queue("resolve-rename-copy done", q);
@@ -1019,9 +1021,9 @@ void diff_flush(int diff_output_style)
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if ((diff_output_style == DIFF_FORMAT_NO_OUTPUT) ||
-		    (p->status == 'X'))
+		    (p->status == DIFF_STATUS_UNCHANGED))
 			continue;
-		if (p->status == 0)
+		if (p->status == DIFF_STATUS_UNKNOWN)
 			die("internal error in diff-resolve-rename-copy");
 		switch (diff_output_style) {
 		case DIFF_FORMAT_PATCH:
@@ -1057,10 +1059,11 @@ static void diffcore_apply_filter(const 
 		int found;
 		for (i = found = 0; !found && i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (((p->status == 'M') &&
+			if (((p->status == DIFF_STATUS_MODIFIED) &&
 			     ((p->score && strchr(filter, 'B')) ||
 			      (!p->score && strchr(filter, 'M')))) ||
-			    ((p->status != 'M') && strchr(filter, p->status)))
+			    ((p->status != DIFF_STATUS_MODIFIED) &&
+			     strchr(filter, p->status)))
 				found++;
 		}
 		if (found)
@@ -1078,10 +1081,11 @@ static void diffcore_apply_filter(const 
 		/* Only the matching ones */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (((p->status == 'M') &&
+			if (((p->status == DIFF_STATUS_MODIFIED) &&
 			     ((p->score && strchr(filter, 'B')) ||
 			      (!p->score && strchr(filter, 'M')))) ||
-			    ((p->status != 'M') && strchr(filter, p->status)))
+			    ((p->status != DIFF_STATUS_MODIFIED) &&
+			     strchr(filter, p->status)))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
@@ -1170,7 +1174,7 @@ void diff_helper_input(unsigned old_mode
 		       const unsigned char *old_sha1,
 		       const unsigned char *new_sha1,
 		       const char *old_path,
-		       int status,
+		       enum diff_status status,
 		       int score,
 		       const char *new_path)
 {
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -8,6 +8,18 @@
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
 
+enum diff_status {
+	DIFF_STATUS_UNKNOWN = 0,
+	DIFF_STATUS_COPIED = 'C',
+	DIFF_STATUS_DELETED = 'D',
+	DIFF_STATUS_MODIFIED = 'M',
+	DIFF_STATUS_NEW = 'N',
+	DIFF_STATUS_RENAMED = 'R',
+	DIFF_STATUS_TYPE_CHANGED = 'T',
+	DIFF_STATUS_UNMERGED = 'U',
+	DIFF_STATUS_UNCHANGED = 'X',
+};
+
 extern void diff_addremove(int addremove,
 			   unsigned mode,
 			   const unsigned char *sha1,
@@ -24,7 +36,7 @@ extern void diff_helper_input(unsigned m
 			      const unsigned char *sha1,
 			      const unsigned char *sha2,
 			      const char *path1,
-			      int status,
+			      enum diff_status status,
 			      int score,
 			      const char *path2);
 
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -49,7 +49,7 @@ struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	unsigned short int score;
-	char status; /* M C R N D U (see Documentation/diff-format.txt) */
+	enum diff_status status; /* (see Documentation/diff-format.txt) */
 	unsigned source_stays : 1; /* all of R/C are copies */
 	unsigned broken_pair : 1;
 };


-- 
Regards,
Pavel Roskin
