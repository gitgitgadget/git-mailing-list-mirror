From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/6] Ref-count the filespecs used by diffcore
Date: Thu, 25 Oct 2007 11:19:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251117590.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:21:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7Kd-0003kN-Ad
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbXJYSVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbXJYSVL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:21:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49303 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753124AbXJYSVK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 14:21:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIJBTG018244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 11:19:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIJAf1007674;
	Thu, 25 Oct 2007 11:19:11 -0700
In-Reply-To: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.919 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_64,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62347>



From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/6] Ref-count the filespecs used by diffcore

Rather than copy the refcounts when introducing new versions of them
(for rename or copy detection), use a refcount and increment the count
when reusing the diff_filespec.

This avoids unnecessary allocations, but the real reason behind this is
a future enhancement: we will want to track shared data across the
copy/rename detection.  In order to efficiently notice when a filespec
is used by a rename, the rename machinery wants to keep track of a
rename usage count which is shared across all different users of the
filespec.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This was sent out in the original series as a fix on top of broken code. 
Now it sets up the infrastructure so that the next patch won't be broken.

 diff.c            |   15 +++++++++++----
 diffcore-rename.c |   16 ++++++----------
 diffcore.h        |    2 ++
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index dfb8595..0b320f6 100644
--- a/diff.c
+++ b/diff.c
@@ -1440,9 +1440,18 @@ struct diff_filespec *alloc_filespec(const char *path)
 	memset(spec, 0, sizeof(*spec));
 	spec->path = (char *)(spec + 1);
 	memcpy(spec->path, path, namelen+1);
+	spec->count = 1;
 	return spec;
 }
 
+void free_filespec(struct diff_filespec *spec)
+{
+	if (!--spec->count) {
+		diff_free_filespec_data(spec);
+		free(spec);
+	}
+}
+
 void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
 		   unsigned short mode)
 {
@@ -2435,10 +2444,8 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *queue,
 
 void diff_free_filepair(struct diff_filepair *p)
 {
-	diff_free_filespec_data(p->one);
-	diff_free_filespec_data(p->two);
-	free(p->one);
-	free(p->two);
+	free_filespec(p->one);
+	free_filespec(p->two);
 	free(p);
 }
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 2077a9b..3da06b7 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -209,21 +209,19 @@ static int estimate_similarity(struct diff_filespec *src,
 
 static void record_rename_pair(int dst_index, int src_index, int score)
 {
-	struct diff_filespec *one, *two, *src, *dst;
+	struct diff_filespec *src, *dst;
 	struct diff_filepair *dp;
 
 	if (rename_dst[dst_index].pair)
 		die("internal error: dst already matched.");
 
 	src = rename_src[src_index].one;
-	one = alloc_filespec(src->path);
-	fill_filespec(one, src->sha1, src->mode);
+	src->count++;
 
 	dst = rename_dst[dst_index].two;
-	two = alloc_filespec(dst->path);
-	fill_filespec(two, dst->sha1, dst->mode);
+	dst->count++;
 
-	dp = diff_queue(NULL, one, two);
+	dp = diff_queue(NULL, src, dst);
 	dp->renamed_pair = 1;
 	if (!strcmp(src->path, dst->path))
 		dp->score = rename_src[src_index].score;
@@ -526,10 +524,8 @@ void diffcore_rename(struct diff_options *options)
 		}
 	}
 
-	for (i = 0; i < rename_dst_nr; i++) {
-		diff_free_filespec_data(rename_dst[i].two);
-		free(rename_dst[i].two);
-	}
+	for (i = 0; i < rename_dst_nr; i++)
+		free_filespec(rename_dst[i].two);
 
 	free(rename_dst);
 	rename_dst = NULL;
diff --git a/diffcore.h b/diffcore.h
index eb618b1..30055ac 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -29,6 +29,7 @@ struct diff_filespec {
 	void *cnt_data;
 	const char *funcname_pattern_ident;
 	unsigned long size;
+	int count;               /* Reference count */
 	int xfrm_flags;		 /* for use by the xfrm */
 	unsigned short mode;	 /* file mode */
 	unsigned sha1_valid : 1; /* if true, use sha1 and trust mode;
@@ -43,6 +44,7 @@ struct diff_filespec {
 };
 
 extern struct diff_filespec *alloc_filespec(const char *);
+extern void free_filespec(struct diff_filespec *);
 extern void fill_filespec(struct diff_filespec *, const unsigned char *,
 			  unsigned short);
 
-- 
1.5.3.4.330.g1dec6
