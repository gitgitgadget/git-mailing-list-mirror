From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Use symbolic constants for diff-raw status indicators.
Date: Mon, 25 Jul 2005 17:20:48 -0700
Message-ID: <7vd5p6fme7.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722204120.GD11916@pasky.ji.cz>
	<7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net>
	<20050722212725.GJ11916@pasky.ji.cz>
	<7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net>
	<7vpst6fmif.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 02:22:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxDDV-0007OU-39
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 02:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGZAWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 20:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVGZAWD
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 20:22:03 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:34480 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261545AbVGZAUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 20:20:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050726002047.KTPA19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 20:20:47 -0400
To: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <7vpst6fmif.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon, 25 Jul 2005 17:18:16 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Both Cogito and StGIT prefer to see 'A' for new files.  The
current 'N' is visually harder to distinguish from 'M', which is
used for modified files.  Prepare the internals to use symbolic
constants to make the change easier.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff-helper.c |    3 ++-
 diff.c        |   58 ++++++++++++++++++++++++++++++++-------------------------
 diff.h        |   16 ++++++++++++++++
 3 files changed, 51 insertions(+), 26 deletions(-)

e7baa4f45f4420a6d2da6a13e8959f8405c3ea19
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -94,7 +94,8 @@ int main(int ac, const char **av) {
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
@@ -617,7 +617,7 @@ static void run_diff(struct diff_filepai
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 	one = p->one; two = p->two;
 	switch (p->status) {
-	case 'C':
+	case DIFF_STATUS_COPIED:
 		sprintf(msg_,
 			"similarity index %d%%\n"
 			"copy from %s\n"
@@ -626,7 +626,7 @@ static void run_diff(struct diff_filepai
 			name, other);
 		xfrm_msg = msg_;
 		break;
-	case 'R':
+	case DIFF_STATUS_RENAMED:
 		sprintf(msg_,
 			"similarity index %d%%\n"
 			"rename from %s\n"
@@ -635,7 +635,7 @@ static void run_diff(struct diff_filepai
 			name, other);
 		xfrm_msg = msg_;
 		break;
-	case 'M':
+	case DIFF_STATUS_MODIFIED:
 		if (p->score) {
 			sprintf(msg_,
 				"dissimilarity index %d%%",
@@ -796,10 +796,12 @@ static void diff_flush_raw(struct diff_f
 		status[1] = 0;
 	}
 	switch (p->status) {
-	case 'C': case 'R':
+	case DIFF_STATUS_COPIED:
+	case DIFF_STATUS_RENAMED:
 		two_paths = 1;
 		break;
-	case 'N': case 'D':
+	case DIFF_STATUS_ADDED:
+	case DIFF_STATUS_DELETED:
 		two_paths = 0;
 		break;
 	default:
@@ -928,13 +930,13 @@ static void diff_resolve_rename_copy(voi
 		p = q->queue[i];
 		p->status = 0; /* undecided */
 		if (DIFF_PAIR_UNMERGED(p))
-			p->status = 'U';
+			p->status = DIFF_STATUS_UNMERGED;
 		else if (!DIFF_FILE_VALID(p->one))
-			p->status = 'N';
+			p->status = DIFF_STATUS_ADDED;
 		else if (!DIFF_FILE_VALID(p->two))
-			p->status = 'D';
+			p->status = DIFF_STATUS_DELETED;
 		else if (DIFF_PAIR_TYPE_CHANGED(p))
-			p->status = 'T';
+			p->status = DIFF_STATUS_TYPE_CHANGED;
 
 		/* from this point on, we are dealing with a pair
 		 * whose both sides are valid and of the same type, i.e.
@@ -942,7 +944,7 @@ static void diff_resolve_rename_copy(voi
 		 */
 		else if (DIFF_PAIR_RENAME(p)) {
 			if (p->source_stays) {
-				p->status = 'C';
+				p->status = DIFF_STATUS_COPIED;
 				continue;
 			}
 			/* See if there is some other filepair that
@@ -956,22 +958,22 @@ static void diff_resolve_rename_copy(voi
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
+			p->status = DIFF_STATUS_UNKNOWN;
 		}
 	}
 	diff_debug_queue("resolve-rename-copy done", q);
@@ -989,7 +991,7 @@ void diff_flush(int diff_output_style, i
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if ((diff_output_style == DIFF_FORMAT_NO_OUTPUT) ||
-		    (p->status == 'X'))
+		    (p->status == DIFF_STATUS_UNKNOWN))
 			continue;
 		if (p->status == 0)
 			die("internal error in diff-resolve-rename-copy");
@@ -1024,15 +1026,17 @@ static void diffcore_apply_filter(const 
 	if (!filter)
 		return;
 
-	if (strchr(filter, 'A')) {
-		/* All-or-none */
+	if (strchr(filter, DIFF_STATUS_FILTER_AON)) {
 		int found;
 		for (i = found = 0; !found && i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (((p->status == 'M') &&
-			     ((p->score && strchr(filter, 'B')) ||
-			      (!p->score && strchr(filter, 'M')))) ||
-			    ((p->status != 'M') && strchr(filter, p->status)))
+			if (((p->status == DIFF_STATUS_MODIFIED) &&
+			     ((p->score &&
+			       strchr(filter, DIFF_STATUS_FILTER_BROKEN)) ||
+			      (!p->score &&
+			       strchr(filter, DIFF_STATUS_MODIFIED)))) ||
+			    ((p->status != DIFF_STATUS_MODIFIED) &&
+			     strchr(filter, p->status)))
 				found++;
 		}
 		if (found)
@@ -1050,10 +1054,14 @@ static void diffcore_apply_filter(const 
 		/* Only the matching ones */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (((p->status == 'M') &&
-			     ((p->score && strchr(filter, 'B')) ||
-			      (!p->score && strchr(filter, 'M')))) ||
-			    ((p->status != 'M') && strchr(filter, p->status)))
+
+			if (((p->status == DIFF_STATUS_MODIFIED) &&
+			     ((p->score &&
+			       strchr(filter, DIFF_STATUS_FILTER_BROKEN)) ||
+			      (!p->score &&
+			       strchr(filter, DIFF_STATUS_MODIFIED)))) ||
+			    ((p->status != DIFF_STATUS_MODIFIED) &&
+			     strchr(filter, p->status)))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -82,4 +82,20 @@ extern int diff_queue_is_empty(void);
 
 extern void diff_flush(int output_style, int line_terminator);
 
+/* diff-raw status letters */
+#define DIFF_STATUS_ADDED		'N'
+#define DIFF_STATUS_COPIED		'C'
+#define DIFF_STATUS_DELETED		'D'
+#define DIFF_STATUS_MODIFIED		'M'
+#define DIFF_STATUS_RENAMED		'R'
+#define DIFF_STATUS_TYPE_CHANGED	'T'
+#define DIFF_STATUS_UNKNOWN		'X'
+#define DIFF_STATUS_UNMERGED		'U'
+
+/* these are not diff-raw status letters proper, but used by
+ * diffcore-filter insn to specify additional restrictions.
+ */
+#define DIFF_STATUS_FILTER_AON		'A'
+#define DIFF_STATUS_FILTER_BROKEN	'B'
+
 #endif /* DIFF_H */
