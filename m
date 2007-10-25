From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/6] Split out "exact content match" phase of rename
 detection
Date: Thu, 25 Oct 2007 11:17:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251116570.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:18:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7Hj-0002xR-Fe
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbXJYSSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbXJYSSJ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:18:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36907 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753182AbXJYSSH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 14:18:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIHtxY017953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 11:17:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIHtGJ007600;
	Thu, 25 Oct 2007 11:17:55 -0700
In-Reply-To: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.219 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62345>


From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/6] Split out "exact content match" phase of rename detection

This makes the exact content match a separate function of its own.
Partly to cut down a bit on the size of the diffcore_rename() function
(which is too complex as it is), and partly because there are smarter
ways to do this than an O(m*n) loop over it all, and that function
should be rewritten to take that into account.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is, I think, identical to the patch you already have. Feel free to 
skip this, and base the rest of the patch-series on your existing one.

 diffcore-rename.c |   90 +++++++++++++++++++++++++++++++++--------------------
 1 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 142e537..2077a9b 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -262,6 +262,58 @@ static int compute_stays(struct diff_queue_struct *q,
 	return 1;
 }
 
+/*
+ * Find exact renames first.
+ *
+ * The first round matches up the up-to-date entries,
+ * and then during the second round we try to match
+ * cache-dirty entries as well.
+ *
+ * Note: the rest of the rename logic depends on this
+ * phase also populating all the filespecs for any
+ * entry that isn't matched up with an exact rename,
+ * see "is_exact_match()".
+ */
+static int find_exact_renames(void)
+{
+	int rename_count = 0;
+	int contents_too;
+
+	for (contents_too = 0; contents_too < 2; contents_too++) {
+		int i;
+
+		for (i = 0; i < rename_dst_nr; i++) {
+			struct diff_filespec *two = rename_dst[i].two;
+			int j;
+
+			if (rename_dst[i].pair)
+				continue; /* dealt with an earlier round */
+			for (j = 0; j < rename_src_nr; j++) {
+				int k;
+				struct diff_filespec *one = rename_src[j].one;
+				if (!is_exact_match(one, two, contents_too))
+					continue;
+
+				/* see if there is a basename match, too */
+				for (k = j; k < rename_src_nr; k++) {
+					one = rename_src[k].one;
+					if (basename_same(one, two) &&
+						is_exact_match(one, two,
+							contents_too)) {
+						j = k;
+						break;
+					}
+				}
+
+				record_rename_pair(i, j, (int)MAX_SCORE);
+				rename_count++;
+				break; /* we are done with this entry */
+			}
+		}
+	}
+	return rename_count;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -270,12 +322,11 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
-	int i, j, rename_count, contents_too;
+	int i, j, rename_count;
 	int num_create, num_src, dst_cnt;
 
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
-	rename_count = 0;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -318,40 +369,11 @@ void diffcore_rename(struct diff_options *options)
 	if (rename_dst_nr * rename_src_nr > rename_limit * rename_limit)
 		goto cleanup;
 
-	/* We really want to cull the candidates list early
+	/*
+	 * We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
-	 * The first round matches up the up-to-date entries,
-	 * and then during the second round we try to match
-	 * cache-dirty entries as well.
 	 */
-	for (contents_too = 0; contents_too < 2; contents_too++) {
-		for (i = 0; i < rename_dst_nr; i++) {
-			struct diff_filespec *two = rename_dst[i].two;
-			if (rename_dst[i].pair)
-				continue; /* dealt with an earlier round */
-			for (j = 0; j < rename_src_nr; j++) {
-				int k;
-				struct diff_filespec *one = rename_src[j].one;
-				if (!is_exact_match(one, two, contents_too))
-					continue;
-
-				/* see if there is a basename match, too */
-				for (k = j; k < rename_src_nr; k++) {
-					one = rename_src[k].one;
-					if (basename_same(one, two) &&
-						is_exact_match(one, two,
-							contents_too)) {
-						j = k;
-						break;
-					}
-				}
-
-				record_rename_pair(i, j, (int)MAX_SCORE);
-				rename_count++;
-				break; /* we are done with this entry */
-			}
-		}
-	}
+	rename_count = find_exact_renames();
 
 	/* Have we run out the created file pool?  If so we can avoid
 	 * doing the delta matrix altogether.
-- 
1.5.3.4.330.g1dec6
