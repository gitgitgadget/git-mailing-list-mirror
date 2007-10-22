From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH, take 2] Linear-time/space rename logic (exact renames
 only)
Date: Mon, 22 Oct 2007 12:31:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710221207300.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
 <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
 <alpine.LFD.0.999.0710220932150.10525@woody.linux-foundation.org>
 <alpine.LFD.0.999.0710221009580.10525@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	Sven Verdoolaege <skimo@liacs.nl>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 21:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik30v-0000mE-Qc
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 21:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbXJVTcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 15:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXJVTcX
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 15:32:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48828 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbXJVTcW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 15:32:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MJVCKa030942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Oct 2007 12:31:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MJVBTj009779;
	Mon, 22 Oct 2007 12:31:11 -0700
In-Reply-To: <alpine.LFD.0.999.0710221009580.10525@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.923 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_64,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62038>



On Mon, 22 Oct 2007, Linus Torvalds wrote:
> 
> Ok, as some people notices, there were a few bugs in the previous patch. I 
> didn't free the hashes correctly (stupid) and the Makefile had "hash.o" 
> instead of "hash.h".

Ok, there were still more bugs, and before you get too involved with this 
last patch (not that I've seen any comments yet), apply this appended 
patch to actually fix things a bit more first!

Yes, I'm a moron. I hadn't even bothered to run the test-suite on it, and 
that showed several silly problems.

One of the problems was that since the rename detection copied the 
diffspecs around, the "rename_used" count couldn't work right, because 
things got copied around and the count stayed with one diffspec, but not 
the other..

In the kernel, we have a rule that says that any data structure that isn't 
ref-counted is basically a bug, and that was true here too. Instead of 
copying and splitting the diffspecs, just refcount them and keep track of 
how many users there are.

While the above bug was a somewhat subtle issue from me trying to be 
clever in avoiding the O(n*m) file copy/rename reuse issue, there were a 
few issues that were me just being totally braindead: the exact rename 
detection had lost the code that took file modes into account, so it would 
generate "renames" from regular files to symlinks, that the generic diff 
core layer would just split up again.

And even more stupidly, I had matched up the src/dst things when finding 
the rename, which just complicated things (added a totally unnecessary 
need to keep track of a destination being used more than once) and also 
broke the basename matching comparison. Duh.

So here's an incremental patch on top of the previous failed try. And if 
somebody is confused (and that might be me) and cannot get things to 
apply, just holler and I'll send the whole thing again. I might even try 
to clean up the series a bit and do it in stages.

This patch shouldn't change any performance behaviour (well, it might 
speed things up a bit to not allocate those diffspec structures, but it's 
unlikely that is even measurable). It just fixes stuff.

I'm sure there's more to come..

		Linus

---
 diff.c            |   17 ++++++++++++-----
 diffcore-rename.c |   40 ++++++++++++++++++++++------------------
 diffcore.h        |    2 ++
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index e892030..2e74cb3 100644
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
@@ -2431,10 +2440,8 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *queue,
 
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
 
@@ -2588,7 +2595,7 @@ void diff_debug_filepair(const struct diff_filepair *p, int i)
 	diff_debug_filespec(p->two, i, "two");
 	fprintf(stderr, "score %d, status %c rename_used %d broken %d\n",
 		p->score, p->status ? p->status : '?',
-		p->rename_used, p->broken_pair);
+		p->one->rename_used, p->broken_pair);
 }
 
 void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index cc105db..3946932 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -184,7 +184,7 @@ static int estimate_similarity(struct diff_filespec *src,
 
 static void record_rename_pair(int dst_index, int src_index, int score)
 {
-	struct diff_filespec *one, *two, *src, *dst;
+	struct diff_filespec *src, *dst;
 	struct diff_filepair *dp;
 
 	if (rename_dst[dst_index].pair)
@@ -192,14 +192,12 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 
 	src = rename_src[src_index].one;
 	src->rename_used++;
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
@@ -232,21 +230,30 @@ static int find_identical_files(struct file_similarity *src,
 				struct file_similarity *dst)
 {
 	int renames = 0;
+
+	/*
+	 * Walk over all the destinations ...
+	 */
 	do {
-		struct diff_filespec *one = src->filespec;
+		struct diff_filespec *one = dst->filespec;
 		struct file_similarity *p, *best;
 		int i = 100;
 
+		/*
+		 * .. to find the best source match
+		 */
 		best = NULL;
-		for (p = dst; p; p = p->next) {
+		for (p = src; p; p = p->next) {
 			struct diff_filespec *two = p->filespec;
 
-			/* Already picked as a destination? */
-			if (!p->src_dst)
-				continue;
 			/* False hash collission? */
 			if (hashcmp(one->sha1, two->sha1))
 				continue;
+			/* Non-regular files? If so, the modes must match! */
+			if (!S_ISREG(one->mode) || !S_ISREG(two->mode)) {
+				if (one->mode != two->mode)
+					continue;
+			}
 			best = p;
 			if (basename_same(one, two))
 				break;
@@ -256,11 +263,10 @@ static int find_identical_files(struct file_similarity *src,
 				break;
 		}
 		if (best) {
-			best->src_dst = 0;
-			record_rename_pair(best->index, src->index, MAX_SCORE);
+			record_rename_pair(dst->index, best->index, MAX_SCORE);
 			renames++;
 		}
-	} while ((src = src->next) != NULL);
+	} while ((dst = dst->next) != NULL);
 	return renames;
 }
 
@@ -569,10 +575,8 @@ void diffcore_rename(struct diff_options *options)
 	*q = outq;
 	diff_debug_queue("done collapsing", q);
 
-	for (i = 0; i < rename_dst_nr; i++) {
-		diff_free_filespec_data(rename_dst[i].two);
-		free(rename_dst[i].two);
-	}
+	for (i = 0; i < rename_dst_nr; i++)
+		free_filespec(rename_dst[i].two);
 
 	free(rename_dst);
 	rename_dst = NULL;
diff --git a/diffcore.h b/diffcore.h
index ceda932..cc96c20 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -29,6 +29,7 @@ struct diff_filespec {
 	void *cnt_data;
 	const char *funcname_pattern_ident;
 	unsigned long size;
+	int count;               /* Reference count */
 	int xfrm_flags;		 /* for use by the xfrm */
 	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
@@ -44,6 +45,7 @@ struct diff_filespec {
 };
 
 extern struct diff_filespec *alloc_filespec(const char *);
+extern void free_filespec(struct diff_filespec *);
 extern void fill_filespec(struct diff_filespec *, const unsigned char *,
 			  unsigned short);
 
