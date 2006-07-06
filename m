From: Junio C Hamano <junkio@cox.net>
Subject: Re: comparing file contents in is_exact_match?
Date: Thu, 06 Jul 2006 00:33:33 -0700
Message-ID: <7vwtar89wy.fsf@assigned-by-dhcp.cox.net>
References: <20060706055729.GA12512@admingilde.org>
	<7vd5cj9rvm.fsf@assigned-by-dhcp.cox.net>
	<20060706071629.GB12512@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 09:34:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyONN-0001MY-Bp
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 09:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWGFHdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 03:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWGFHdf
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 03:33:35 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22438 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964964AbWGFHde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 03:33:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060706073334.JTXD12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Jul 2006 03:33:34 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060706071629.GB12512@admingilde.org> (Martin Waitz's message
	of "Thu, 6 Jul 2006 09:16:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23378>

Martin Waitz <tali@admingilde.org> writes:

>> Because your working tree can be out of sync with respect to
>> what's in the index, in which case we cannot trust the sha1
>> while running diff-index (without --cached flag).
>
> so perhaps we need three phases instead of two:
> first sort out all renames that can be detected by the sha1,
> then compare file contents and finally do the diff.

Makes sort-of sense.

Although I am not sure how much this would help with a regular
workload, maybe something like this untested patch might help
your situation?

-- >8 --
diffcore-rename: try matching up renames without populating filespec first

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d57e865..affff7a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -96,11 +96,15 @@ static struct diff_rename_src *register_
 	return &(rename_src[first]);
 }
 
-static int is_exact_match(struct diff_filespec *src, struct diff_filespec *dst)
+static int is_exact_match(struct diff_filespec *src,
+			  struct diff_filespec *dst,
+			  int contents_too)
 {
 	if (src->sha1_valid && dst->sha1_valid &&
 	    !memcmp(src->sha1, dst->sha1, 20))
 		return 1;
+	if (!contents_too)
+		return 0;
 	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
 		return 0;
 	if (src->size != dst->size)
@@ -242,7 +246,7 @@ void diffcore_rename(struct diff_options
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
-	int i, j, rename_count;
+	int i, j, rename_count, contents_too;
 	int num_create, num_src, dst_cnt;
 
 	if (!minimum_score)
@@ -273,16 +277,23 @@ void diffcore_rename(struct diff_options
 
 	/* We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
+	 * The first round matches up the up-to-date entries,
+	 * and then during the second round we try to match
+	 * cache-dirty entries as well.
 	 */
-	for (i = 0; i < rename_dst_nr; i++) {
-		struct diff_filespec *two = rename_dst[i].two;
-		for (j = 0; j < rename_src_nr; j++) {
-			struct diff_filespec *one = rename_src[j].one;
-			if (!is_exact_match(one, two))
-				continue;
-			record_rename_pair(i, j, MAX_SCORE);
-			rename_count++;
-			break; /* we are done with this entry */
+	for (contents_too = 0; contents_too < 2; contents_too++) { 
+		for (i = 0; i < rename_dst_nr; i++) {
+			struct diff_filespec *two = rename_dst[i].two;
+			if (rename_dst[i].pair)
+				continue; /* dealt with an earlier round */
+			for (j = 0; j < rename_src_nr; j++) {
+				struct diff_filespec *one = rename_src[j].one;
+				if (!is_exact_match(one, two, contents_too))
+					continue;
+				record_rename_pair(i, j, MAX_SCORE);
+				rename_count++;
+				break; /* we are done with this entry */
+			}
 		}
 	}
 
