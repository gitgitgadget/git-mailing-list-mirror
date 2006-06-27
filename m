From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Print empty line between raw, stat, summary and patch
Date: Tue, 27 Jun 2006 15:09:17 +0300
Message-ID: <20060627150917.7eabde58.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 14:09:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvCNi-0007UY-FA
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 14:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWF0MJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 08:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWF0MJX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 08:09:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:14124 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932192AbWF0MJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 08:09:22 -0400
Received: by nf-out-0910.google.com with SMTP id m19so717761nfc
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 05:09:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=D42UybtfvIe2jNOj3LPDq04JdNclo712SVH7PFHhzdsLcrtSfIpEoV0g5KtJb+ACqIs98FVC7R4IgVyrVh/o/xUDvs9XkenbLb5zlCpIFnkWLD0h193kPPIf+kmnqtZA7i1im3xZ3LjzjIXgrcvDgFtfiAWEQadhg8+i72H6W5c=
Received: by 10.49.54.13 with SMTP id g13mr5559466nfk;
        Tue, 27 Jun 2006 05:09:20 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id y23sm1699080nfb.2006.06.27.05.09.18;
        Tue, 27 Jun 2006 05:09:19 -0700 (PDT)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22733>

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---

  Should we print options->line_termination instead of \n between all
  fields?  The old code didn't support as many combinations of raw,
  stat, summary and patch so I'm not 100% sure about this.

 diff.c |   47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 8880150..2c47f11 100644
--- a/diff.c
+++ b/diff.c
@@ -2040,15 +2040,43 @@ static void diff_summary(struct diff_fil
 	}
 }
 
+static int is_summary_empty(const struct diff_queue_struct *q)
+{
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		const struct diff_filepair *p = q->queue[i];
+
+		switch (p->status) {
+		case DIFF_STATUS_DELETED:
+		case DIFF_STATUS_ADDED:
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			return 0;
+		default:
+			if (p->score)
+				return 0;
+			if (p->one->mode && p->two->mode &&
+			    p->one->mode != p->two->mode)
+				return 0;
+			break;
+		}
+	}
+	return 1;
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i, output_format = options->output_format;
+	int separator = 0;
 
 	/*
 	 * Order: raw, stat, summary, patch
 	 * or:    name/name-status/checkdiff (other bits clear)
 	 */
+	if (!q->nr)
+		goto free_queue;
 
 	if (output_format & (DIFF_FORMAT_RAW |
 			     DIFF_FORMAT_NAME |
@@ -2059,11 +2087,15 @@ void diff_flush(struct diff_options *opt
 			if (check_pair_status(p))
 				flush_one_pair(p, options);
 		}
+		separator++;
 	}
 
 	if (output_format & DIFF_FORMAT_DIFFSTAT) {
 		struct diffstat_t diffstat;
 
+		if (separator++)
+			putchar('\n');
+
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
 		diffstat.xm.consume = diffstat_consume;
 		for (i = 0; i < q->nr; i++) {
@@ -2074,18 +2106,22 @@ void diff_flush(struct diff_options *opt
 		show_stats(&diffstat);
 	}
 
-	if (output_format & DIFF_FORMAT_SUMMARY) {
+	if (output_format & DIFF_FORMAT_SUMMARY && !is_summary_empty(q)) {
+		if (separator++)
+			putchar('\n');
+
 		for (i = 0; i < q->nr; i++)
 			diff_summary(q->queue[i]);
 	}
 
 	if (output_format & DIFF_FORMAT_PATCH) {
-		if (output_format & (DIFF_FORMAT_DIFFSTAT |
-				     DIFF_FORMAT_SUMMARY)) {
-			if (options->stat_sep)
+		if (separator) {
+			if (options->stat_sep) {
+				/* attach patch instead of inline */
 				fputs(options->stat_sep, stdout);
-			else
+			} else {
 				putchar(options->line_termination);
+			}
 		}
 
 		for (i = 0; i < q->nr; i++) {
@@ -2097,6 +2133,7 @@ void diff_flush(struct diff_options *opt
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
+free_queue:
 	free(q->queue);
 	q->queue = NULL;
 	q->nr = q->alloc = 0;
-- 
1.4.1.rc1.g8637
