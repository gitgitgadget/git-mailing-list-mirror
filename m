From: Junio C Hamano <junkio@cox.net>
Subject: Re: a slight anomaly in '--unified=0' diff output for one particular commit?
Date: Sat, 03 Feb 2007 12:37:54 -0800
Message-ID: <7virej3rkt.fsf@assigned-by-dhcp.cox.net>
References: <200702020919.31801.rayl@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Lehtiniemi <rayl@mail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:38:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRe5-0004QK-Vw
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXBCUh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbXBCUh4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:37:56 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:35922 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751517AbXBCUhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:37:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203203756.BURB1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 15:37:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K8du1W0151kojtg0000000; Sat, 03 Feb 2007 15:37:55 -0500
In-Reply-To: <200702020919.31801.rayl@mail.com> (Ray Lehtiniemi's message of
	"Fri, 02 Feb 2007 09:19:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38595>

Ray Lehtiniemi <rayl@mail.com> writes:

> i get the same output for both these commands in the git repository using 
> v1.5.0-rc3-1-ge4b0e4a. 
>
>   # git show --unified=1 9299c4f147bcff603eef187eb04fe38153571d30
>   # git show --unified=0 9299c4f147bcff603eef187eb04fe38153571d30
>
> in both cases, i get the following single line of context at the end of the 
> diff:
>
>   glossary.html : glossary.txt sort_glossary.pl
>
> i'm also not sure the numbers in the '@@@' line look correct for 
> the 'unified=0' case...

That's sick.

-- >8 --
[PATCH] combine-diff: special case --unified=0

Even when --unified=0 is given, the main loop to show the
combined textual diff needs to handle a line that is unchanged
but has lines that were deleted relative to a parent before it
(because that is where the lost lines hang).  However, such a
line should not be emitted in the final output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 combine-diff.c |   34 ++++++++++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 29d0c9c..a5f2c8d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -482,11 +482,11 @@ static int make_hunks(struct sline *sline, unsigned long cnt,
 	return has_interesting;
 }
 
-static void show_parent_lno(struct sline *sline, unsigned long l0, unsigned long l1, int n)
+static void show_parent_lno(struct sline *sline, unsigned long l0, unsigned long l1, int n, unsigned long null_context)
 {
 	l0 = sline[l0].p_lno[n];
 	l1 = sline[l1].p_lno[n];
-	printf(" -%lu,%lu", l0, l1-l0);
+	printf(" -%lu,%lu", l0, l1-l0-null_context);
 }
 
 static int hunk_comment_line(const char *bol)
@@ -519,6 +519,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 		unsigned long hunk_end;
 		unsigned long rlines;
 		const char *hunk_comment = NULL;
+		unsigned long null_context = 0;
 
 		while (lno <= cnt && !(sline[lno].flag & mark)) {
 			if (hunk_comment_line(sline[lno].bol))
@@ -535,10 +536,28 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 		rlines = hunk_end - lno;
 		if (cnt < hunk_end)
 			rlines--; /* pointing at the last delete hunk */
+
+		if (!context) {
+			/*
+			 * Even when running with --unified=0, all
+			 * lines in the hunk needs to be processed in
+			 * the loop below in order to show the
+			 * deletion recorded in lost_head.  However,
+			 * we do not want to show the resulting line
+			 * with all blank context markers in such a
+			 * case.  Compensate.
+			 */
+			unsigned long j;
+			for (j = lno; j < hunk_end; j++)
+				if (!(sline[j].flag & (mark-1)))
+					null_context++;
+			rlines -= null_context;
+		}
+
 		fputs(c_frag, stdout);
 		for (i = 0; i <= num_parent; i++) putchar(combine_marker);
 		for (i = 0; i < num_parent; i++)
-			show_parent_lno(sline, lno, hunk_end, i);
+			show_parent_lno(sline, lno, hunk_end, i, null_context);
 		printf(" +%lu,%lu ", lno+1, rlines);
 		for (i = 0; i <= num_parent; i++) putchar(combine_marker);
 
@@ -578,8 +597,15 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 			if (cnt < lno)
 				break;
 			p_mask = 1;
-			if (!(sl->flag & (mark-1)))
+			if (!(sl->flag & (mark-1))) {
+				/*
+				 * This sline was here to hang the
+				 * lost lines in front of it.
+				 */
+				if (!context)
+					continue;
 				fputs(c_plain, stdout);
+			}
 			else
 				fputs(c_new, stdout);
 			for (j = 0; j < num_parent; j++) {
