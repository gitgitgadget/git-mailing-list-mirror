From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 1/3 v4] Add a macro DIFF_QUEUE_CLEAR.
Date: Thu,  6 May 2010 21:52:27 -0700
Message-ID: <1273207949-18500-2-git-send-email-struggleyb.nku@gmail.com>
References: <1273207949-18500-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 06:52:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAFYV-00005k-Ur
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 06:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab0EGEwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 00:52:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64876 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab0EGEwk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 00:52:40 -0400
Received: by gwj19 with SMTP id 19so432270gwj.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mHMkO8zUzN0wrbAw5pMZSZSIHzqiNSNT9u/GWXX3n0s=;
        b=RKNrhfH0QhvVkC1L9gVwR0RxIolLsPAJ2Ce09+VHHW5SI+mc1kclxH062MOgOPUxVm
         3ew4DW3PWIlgvQhuSK1WfVa+4ijoBuPF2RpWX9iN4sRCVsKRWfHzx2mFsJPIbzmG2Ot5
         mlNAHEjSWeZmdyfYOFJC6VqOK5kC48LaeMlvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EMoHV2iMcVhQty+alvIyl+Db/D5LD4BoJTmEp5NJ5V2gWXtNmBvdcmYO1NRue84AKV
         Xmw3d17DDAEgdlEPe9ABBFUC6ruLNZuLPqdX52so7hC52uKFQw/zPhwYxo5yKsr2i7rf
         olpGxejlUSCv8Pc6vk5g9rAO809jM0QmkTwNo=
Received: by 10.100.87.16 with SMTP id k16mr9834922anb.227.1273207957453;
        Thu, 06 May 2010 21:52:37 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n2sm16458856ann.12.2010.05.06.21.52.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 21:52:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273207949-18500-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146522>

Refactor the diff_queue_struct code, this macro help
to reset the structure.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c             |   13 +++++--------
 diffcore-break.c   |    6 ++----
 diffcore-pickaxe.c |    3 +--
 diffcore-rename.c  |    3 +--
 diffcore.h         |    5 +++++
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index e40c127..4a350e3 100644
--- a/diff.c
+++ b/diff.c
@@ -2540,6 +2540,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
+	memset(&diff_queued_diff, 0, sizeof(diff_queued_diff));
 
 	options->file = stdout;
 
@@ -3457,8 +3458,7 @@ int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
 		diff_free_filepair(q->queue[i]);
 
 	free(q->queue);
-	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	DIFF_QUEUE_CLEAR(q);
 
 	return result;
 }
@@ -3586,8 +3586,7 @@ void diff_flush(struct diff_options *options)
 		diff_free_filepair(q->queue[i]);
 free_queue:
 	free(q->queue);
-	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	DIFF_QUEUE_CLEAR(q);
 	if (options->close_file)
 		fclose(options->file);
 
@@ -3609,8 +3608,7 @@ static void diffcore_apply_filter(const char *filter)
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
+	DIFF_QUEUE_CLEAR(&outq);
 
 	if (!filter)
 		return;
@@ -3678,8 +3676,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
+	DIFF_QUEUE_CLEAR(&outq);
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
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
index fcd00bf..5d05dea 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -92,6 +92,11 @@ struct diff_queue_struct {
 	int alloc;
 	int nr;
 };
+#define DIFF_QUEUE_CLEAR(q) \
+	do { \
+		(q)->queue = NULL; \
+		(q)->nr = (q)->alloc = 0; \
+	} while(0);
 
 extern struct diff_queue_struct diff_queued_diff;
 extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
-- 
1.6.0.4
