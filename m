From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] merge-recursive: separate out xdl_merge() interface.
Date: Tue, 17 Apr 2007 01:08:36 -0700
Message-ID: <11767973192276-git-send-email-junkio@cox.net>
References: <11767973183627-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 10:08:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdik2-0001Yq-S5
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 10:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbXDQIIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 04:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbXDQIIn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 04:08:43 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39168 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbXDQIIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 04:08:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417080841.VFLR1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Tue, 17 Apr 2007 04:08:41 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o88e1W01q1kojtg0000100; Tue, 17 Apr 2007 04:08:39 -0400
X-Mailer: git-send-email 1.5.1.1.125.g402f-dirty
In-Reply-To: <11767973183627-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44738>

This just moves code around to make the actual call to
xdl_merge() into a separate function.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-recursive.c |   56 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3096594..4eb62cf 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -659,6 +659,39 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 	mm->size = size;
 }
 
+static int ll_merge(mmbuffer_t *result_buf,
+		    struct diff_filespec *o,
+		    struct diff_filespec *a,
+		    struct diff_filespec *b,
+		    const char *branch1,
+		    const char *branch2)
+{
+	mmfile_t orig, src1, src2;
+	xpparam_t xpp;
+	char *name1, *name2;
+	int merge_status;
+
+	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
+	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
+
+	fill_mm(o->sha1, &orig);
+	fill_mm(a->sha1, &src1);
+	fill_mm(b->sha1, &src2);
+
+	memset(&xpp, 0, sizeof(xpp));
+	merge_status = xdl_merge(&orig,
+				 &src1, name1,
+				 &src2, name2,
+				 &xpp, XDL_MERGE_ZEALOUS,
+				 result_buf);
+	free(name1);
+	free(name2);
+	free(orig.ptr);
+	free(src1.ptr);
+	free(src2.ptr);
+	return merge_status;
+}
+
 static struct merge_file_info merge_file(struct diff_filespec *o,
 		struct diff_filespec *a, struct diff_filespec *b,
 		const char *branch1, const char *branch2)
@@ -687,30 +720,11 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 		else if (sha_eq(b->sha1, o->sha1))
 			hashcpy(result.sha, a->sha1);
 		else if (S_ISREG(a->mode)) {
-			mmfile_t orig, src1, src2;
 			mmbuffer_t result_buf;
-			xpparam_t xpp;
-			char *name1, *name2;
 			int merge_status;
 
-			name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
-			name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
-
-			fill_mm(o->sha1, &orig);
-			fill_mm(a->sha1, &src1);
-			fill_mm(b->sha1, &src2);
-
-			memset(&xpp, 0, sizeof(xpp));
-			merge_status = xdl_merge(&orig,
-						 &src1, name1,
-						 &src2, name2,
-						 &xpp, XDL_MERGE_ZEALOUS,
-						 &result_buf);
-			free(name1);
-			free(name2);
-			free(orig.ptr);
-			free(src1.ptr);
-			free(src2.ptr);
+			merge_status = ll_merge(&result_buf, o, a, b,
+						branch1, branch2);
 
 			if ((merge_status < 0) || !result_buf.ptr)
 				die("Failed to execute internal merge");
-- 
1.5.1.1.821.g88bdb
