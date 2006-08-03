From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating diffs
Date: Thu, 03 Aug 2006 11:45:00 -0700
Message-ID: <7v4pwtr74j.fsf@assigned-by-dhcp.cox.net>
References: <20060803122937.GI5016@robert.daprodeges.fqdn.th-h.de>
	<easqpi$o51$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 03 20:45:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8iBw-0000GD-8B
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 20:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWHCSpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 14:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWHCSpE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 14:45:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39122 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030210AbWHCSpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 14:45:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803184501.TRKV6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 14:45:01 -0400
To: git@vger.kernel.org
In-Reply-To: <easqpi$o51$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	03 Aug 2006 14:39:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24746>

Jakub Narebski <jnareb@gmail.com> writes:

> If I remember correctly there were two patches which solved it differently:
> one gave
>
>    --- a/source:file
>    +++ b/dest:file
>
> second (and I guess it is better solution)
>
>    --- a/file
>    +++ b/file
>
> Unfortunately they seem unapplied...

I think I explained why it was not enough in a neighboring
thread.  You would need to defeat the rename classification done
in diff.c::diff_resolve_rename_copy().

The diff reversal is independent.  I think it was introduced by
mistake when we switched revision.c::add_pending_object() to use
object_array from object_list.

Here is a patch to fix the reversal (swapping of indices for
blob[].sha1 in builtin-diff.c), show both names (swapping of
indices for blob[].name in builtin-diff.c), and not mistake this
as an rename (all the rest).  The change touches rather delicate
parts of the system, so I am reluctant to do the latter two at
this late in the game for 1.4.2, but please do test it and give
feedback.

---
diff --git a/builtin-diff.c b/builtin-diff.c
index 48d2fd0..cb4216e 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -125,9 +125,6 @@ static int builtin_diff_blobs(struct rev
 			      int argc, const char **argv,
 			      struct blobinfo *blob)
 {
-	/* Blobs: the arguments are reversed when setup_revisions()
-	 * picked them up.
-	 */
 	unsigned mode = canon_mode(S_IFREG | 0644);
 
 	if (argc > 1)
@@ -135,8 +132,8 @@ static int builtin_diff_blobs(struct rev
 
 	stuff_change(&revs->diffopt,
 		     mode, mode,
-		     blob[1].sha1, blob[0].sha1,
-		     blob[0].name, blob[0].name);
+		     blob[0].sha1, blob[1].sha1,
+		     blob[0].name, blob[1].name);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	return 0;
diff --git a/diff.c b/diff.c
index 607c357..895c137 100644
--- a/diff.c
+++ b/diff.c
@@ -1786,13 +1786,9 @@ struct diff_filepair *diff_queue(struct 
 				 struct diff_filespec *one,
 				 struct diff_filespec *two)
 {
-	struct diff_filepair *dp = xmalloc(sizeof(*dp));
+	struct diff_filepair *dp = xcalloc(1, sizeof(*dp));
 	dp->one = one;
 	dp->two = two;
-	dp->score = 0;
-	dp->status = 0;
-	dp->source_stays = 0;
-	dp->broken_pair = 0;
 	if (queue)
 		diff_q(queue, dp);
 	return dp;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1de8d32..0ec488a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -205,6 +205,7 @@ static void record_rename_pair(int dst_i
 	fill_filespec(two, dst->sha1, dst->mode);
 
 	dp = diff_queue(NULL, one, two);
+	dp->renamed_pair = 1;
 	if (!strcmp(src->path, dst->path))
 		dp->score = rename_src[src_index].score;
 	else
diff --git a/diffcore.h b/diffcore.h
index 73c7842..2249bc2 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -53,11 +53,12 @@ struct diff_filepair {
 	char status; /* M C R N D U (see Documentation/diff-format.txt) */
 	unsigned source_stays : 1; /* all of R/C are copies */
 	unsigned broken_pair : 1;
+	unsigned renamed_pair : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
 
-#define DIFF_PAIR_RENAME(p) (strcmp((p)->one->path, (p)->two->path))
+#define DIFF_PAIR_RENAME(p) ((p)->renamed_pair)
 
 #define DIFF_PAIR_BROKEN(p) \
 	( (!DIFF_FILE_VALID((p)->one) != !DIFF_FILE_VALID((p)->two)) && \
