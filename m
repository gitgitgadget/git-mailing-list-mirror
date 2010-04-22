From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 1/2 v3] Make diffcore_std only can run once before a diff_flush.
Date: Thu, 22 Apr 2010 22:05:41 +0800
Message-ID: <1271945142-27015-2-git-send-email-struggleyb.nku@gmail.com>
References: <1271945142-27015-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 16:06:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4x2V-0003I9-RD
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab0DVOF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 10:05:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56186 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab0DVOFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:05:54 -0400
Received: by mail-pw0-f46.google.com with SMTP id 9so5971057pwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OfYpfdqwwS/XLPGb2ruPwCyw+1bkdrfiHkHpYh83C1c=;
        b=cjxnhmErRdGI7Ic+rNvCuedvSF3zePMuulsu0Nq/tCT3iY6OhtdJV5GbCZ9STM0/dk
         ODToUwNy1Nh/sJ8IvkJZjp7fnF550fcTfwA+AdKotwyJmA3IG7nsGLEywBPC6YyM5Lme
         DSt8nq99wAIdr+n9wvR/gUiy9tqbDJhthlJuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uWqT9zUR8pHTXVcpAXhHCgZR1hGXOQP9cdwhbbDR74vL2VMVidy6EyDTLqXGpseZHA
         xzQd227J7oOTHAe1FYA8KamPPCY/jK/yQz2X31geJAQ86pkbujzKhxsfRLqA56fxfpo6
         gjMOgLDg7JT4HVPKuvDeySrZD3Re8QnJLaVak=
Received: by 10.114.11.9 with SMTP id 9mr9132582wak.178.1271945154248;
        Thu, 22 Apr 2010 07:05:54 -0700 (PDT)
Received: from localhost.localdomain ([222.35.130.216])
        by mx.google.com with ESMTPS id b17sm4487756wam.22.2010.04.22.07.05.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 07:05:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
In-Reply-To: <1271945142-27015-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145530>

When file renames/copies detection is turned on, the
second diffcore_std will degrade a 'C' pair to a 'R' pair.

And this may happen when we run 'git log --follow' with
hard copies finding. That is, the try_to_follow_renames()
will run diffcore_std to find the copies, and then
'git log' will issue another diffcore_std, which will reduce
'src->rename_used' and recognize this copy as a rename.
This is not what we want.

So, I think we really don't need to run diffcore_std more
than one time.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c             |   21 +++++++++++++--------
 diffcore-break.c   |    6 ++----
 diffcore-pickaxe.c |    3 +--
 diffcore-rename.c  |    3 +--
 diffcore.h         |    6 ++++++
 5 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index d0ecbc3..d32fc68 100644
--- a/diff.c
+++ b/diff.c
@@ -2544,6 +2544,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
+	memset(&diff_queued_diff, 0, sizeof(diff_queued_diff));
 
 	options->file = stdout;
 
@@ -3462,8 +3463,7 @@ int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
 		diff_free_filepair(q->queue[i]);
 
 	free(q->queue);
-	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	DIFF_QUEUE_CLEAR(q);
 
 	return result;
 }
@@ -3591,8 +3591,7 @@ void diff_flush(struct diff_options *options)
 		diff_free_filepair(q->queue[i]);
 free_queue:
 	free(q->queue);
-	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	DIFF_QUEUE_CLEAR(q);
 	if (options->close_file)
 		fclose(options->file);
 
@@ -3614,8 +3613,7 @@ static void diffcore_apply_filter(const char *filter)
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
+	DIFF_QUEUE_CLEAR(&outq);
 
 	if (!filter)
 		return;
@@ -3683,8 +3681,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
+	DIFF_QUEUE_CLEAR(&outq);
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -3745,6 +3742,12 @@ void diffcore_fix_diff_index(struct diff_options *options)
 
 void diffcore_std(struct diff_options *options)
 {
+	/* We never run this function more than one time, because the
+	 * rename/copy detection logic can only run once.
+	 */
+	if (diff_queued_diff.run)
+		return;
+
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
 	if (options->break_opt != -1)
@@ -3764,6 +3767,8 @@ void diffcore_std(struct diff_options *options)
 		DIFF_OPT_SET(options, HAS_CHANGES);
 	else
 		DIFF_OPT_CLR(options, HAS_CHANGES);
+
+	diff_queued_diff.run = 1;
 }
 
 int diff_result_code(struct diff_options *opt, int status)
diff --git a/diffcore-break.c b/diffcore-break.c
index 3a7b60a..44f8678 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -162,8 +162,7 @@ void diffcore_break(int break_score)
 	if (!merge_score)
 		merge_score = DEFAULT_MERGE_SCORE;
 
-	outq.nr = outq.alloc = 0;
-	outq.queue = NULL;
+	DIFF_QUEUE_CLEAR(&outq);
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -256,8 +255,7 @@ void diffcore_merge_broken(void)
 	struct diff_queue_struct outq;
 	int i, j;
 
-	outq.nr = outq.alloc = 0;
-	outq.queue = NULL;
+	DIFF_QUEUE_CLEAR(&outq);
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index d0ef839..929de15 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -55,8 +55,7 @@ void diffcore_pickaxe(const char *needle, int opts)
 	int i, has_changes;
 	regex_t regex, *regexp = NULL;
 	struct diff_queue_struct outq;
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
+	DIFF_QUEUE_CLEAR(&outq);
 
 	if (opts & DIFF_PICKAXE_REGEX) {
 		int err;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d6fd3ca..df41be5 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -569,8 +569,7 @@ void diffcore_rename(struct diff_options *options)
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
+	DIFF_QUEUE_CLEAR(&outq);
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		struct diff_filepair *pair_to_free = NULL;
diff --git a/diffcore.h b/diffcore.h
index fcd00bf..e77db31 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -91,7 +91,13 @@ struct diff_queue_struct {
 	struct diff_filepair **queue;
 	int alloc;
 	int nr;
+	int run;
 };
+#define DIFF_QUEUE_CLEAR(q) \
+	do { \
+		(q)->queue = NULL; \
+		(q)->nr = (q)->alloc = (q)->run = 0; \
+	} while(0);
 
 extern struct diff_queue_struct diff_queued_diff;
 extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
-- 
1.7.0.2.273.gc2413.dirty
