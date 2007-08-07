From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] git-diff: Output a warning about stale files in the index
Date: Mon, 6 Aug 2007 23:35:23 -0700
Message-ID: <20070807063523.GA29617@midwinter.com>
References: <46B80993.3080409@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 08:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIIfA-0006rs-8s
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 08:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbXHGGfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 02:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbXHGGfY
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 02:35:24 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:52030 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752432AbXHGGfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 02:35:23 -0400
Received: (qmail 30049 invoked by uid 1001); 7 Aug 2007 06:35:23 -0000
Content-Disposition: inline
In-Reply-To: <46B80993.3080409@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55224>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
	This is based on (and includes) Junio's patch. This should
	hopefully address the "I want to know when my index is very
	stale" problem with both his original patch and mine.

	If we are running a pager, I output the warning to standard
	output so it doesn't get immediately scrolled off the screen by
	the paged diff output. Otherwise I output to standard error
	which is really the more appropriate place for the warning.
	Obviously that is no good if the user is running his own pager,
	but I'm not sure how to detect that and not cause problems for
	diffs that are piped into other programs.

 diff.c     |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 diffcore.h |    1 +
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index a5fc56b..7b11195 100644
--- a/diff.c
+++ b/diff.c
@@ -2979,7 +2979,7 @@ int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
 
 	free(q->queue);
 	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	q->nr = q->alloc = q->removed = 0;
 
 	return result;
 }
@@ -3015,6 +3015,17 @@ void diff_flush(struct diff_options *options)
 	int i, output_format = options->output_format;
 	int separator = 0;
 
+	if (q->removed > 0 && ! (output_format & DIFF_FORMAT_NO_OUTPUT)) {
+		char *format = "Warning: %d %s touched but not modified. "
+			       "Consider running git-status.\n";
+		char *plural = q->removed == 1 ? "path" : "paths";
+
+		if (pager_in_use)
+			printf(format, q->removed, plural);
+		else
+			fprintf(stderr, format, q->removed, plural);
+	}
+
 	/*
 	 * Order: raw, stat, summary, patch
 	 * or:    name/name-status/checkdiff (other bits clear)
@@ -3084,7 +3095,7 @@ void diff_flush(struct diff_options *options)
 free_queue:
 	free(q->queue);
 	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	q->nr = q->alloc = q->removed = 0;
 }
 
 static void diffcore_apply_filter(const char *filter)
@@ -3093,7 +3104,7 @@ static void diffcore_apply_filter(const char *filter)
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
+	outq.nr = outq.alloc = outq.removed = 0;
 
 	if (!filter)
 		return;
@@ -3143,6 +3154,47 @@ static void diffcore_apply_filter(const char *filter)
 	*q = outq;
 }
 
+static void diffcore_remove_empty(void)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	outq.queue = NULL;
+	outq.nr = outq.alloc = outq.removed = 0;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+
+		/*
+		 * 1. Keep the ones that cannot be diff-files
+		 *    "false" match that are only queued due to
+		 *    cache dirtyness.
+		 *
+		 * 2. Modified, same size and mode, and the object
+		 *    name of one side is unknown.  If they do not
+		 *    have identical contents, keep them.
+		 *    They are different.
+		 */
+		if ((p->status != DIFF_STATUS_MODIFIED) || /* (1) */
+		    (p->one->sha1_valid && p->two->sha1_valid) ||
+		    (p->one->mode != p->two->mode) ||
+
+		    diff_populate_filespec(p->one, 1) || /* (2) */
+		    diff_populate_filespec(p->two, 1) ||
+		    (p->one->size != p->two->size) ||
+		    diff_populate_filespec(p->one, 0) ||
+		    diff_populate_filespec(p->two, 0) ||
+		    memcmp(p->one->data, p->two->data, p->one->size))
+			diff_q(&outq, p);
+		else {
+			diff_free_filepair(p);
+			outq.removed++;
+		}
+	}
+	free(q->queue);
+	*q = outq;
+}
+
 void diffcore_std(struct diff_options *options)
 {
 	if (options->quiet)
@@ -3160,6 +3212,7 @@ void diffcore_std(struct diff_options *options)
 		diffcore_order(options->orderfile);
 	diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
+	diffcore_remove_empty();
 
 	options->has_changes = !!diff_queued_diff.nr;
 }
diff --git a/diffcore.h b/diffcore.h
index eef17c4..e5a9244 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -81,6 +81,7 @@ struct diff_queue_struct {
 	struct diff_filepair **queue;
 	int alloc;
 	int nr;
+	int removed;
 };
 
 extern struct diff_queue_struct diff_queued_diff;
-- 
1.5.3.rc2.4.g726f9
