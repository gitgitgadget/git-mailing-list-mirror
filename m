From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH v2] git-diff: Output a warning about stale files in the index
Date: Tue, 7 Aug 2007 00:17:12 -0700
Message-ID: <20070807071712.GA32751@midwinter.com>
References: <7vbqdj9709.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 09:17:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIJJc-00018X-8y
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 09:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbXHGHRN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 03:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754722AbXHGHRN
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 03:17:13 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:55998 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754310AbXHGHRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 03:17:12 -0400
Received: (qmail 402 invoked by uid 1001); 7 Aug 2007 07:17:12 -0000
Content-Disposition: inline
In-Reply-To: <7vbqdj9709.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55229>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
	Modified as suggested by Junio.

 diff.c     |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 diffcore.h |    1 +
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index a5fc56b..5f2e1fe 100644
--- a/diff.c
+++ b/diff.c
@@ -2979,7 +2979,7 @@ int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
 
 	free(q->queue);
 	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	q->nr = q->alloc = q->removed = 0;
 
 	return result;
 }
@@ -3074,6 +3074,12 @@ void diff_flush(struct diff_options *options)
 			if (check_pair_status(p))
 				diff_flush_patch(p, options);
 		}
+
+		if (q->removed > 0) {
+			printf("Warning: %d %s touched but not modified. "
+			       "Consider running git-status.\n",
+			       q->removed, q->removed == 1 ? "path" : "paths");
+		}
 	}
 
 	if (output_format & DIFF_FORMAT_CALLBACK)
@@ -3084,7 +3090,7 @@ void diff_flush(struct diff_options *options)
 free_queue:
 	free(q->queue);
 	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	q->nr = q->alloc = q->removed = 0;
 }
 
 static void diffcore_apply_filter(const char *filter)
@@ -3093,7 +3099,7 @@ static void diffcore_apply_filter(const char *filter)
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
+	outq.nr = outq.alloc = outq.removed = 0;
 
 	if (!filter)
 		return;
@@ -3143,6 +3149,47 @@ static void diffcore_apply_filter(const char *filter)
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
@@ -3160,6 +3207,8 @@ void diffcore_std(struct diff_options *options)
 		diffcore_order(options->orderfile);
 	diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
+	if (options->output_format & DIFF_FORMAT_PATCH)
+		diffcore_remove_empty();
 
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
