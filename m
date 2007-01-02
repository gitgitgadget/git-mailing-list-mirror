From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining
 conflicts
Date: Tue, 2 Jan 2007 21:58:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701022144290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061227041644.GA22449@spearce.org> <en6fj1$ji5$1@sea.gmane.org>
 <Pine.LNX.4.63.0612310208460.25709@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701021418.48624.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 21:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1qih-00026y-Oj
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 21:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbXABU6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 15:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbXABU6s
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 15:58:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:57785 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964959AbXABU6r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 15:58:47 -0500
Received: (qmail invoked by alias); 02 Jan 2007 20:58:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 02 Jan 2007 21:58:46 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701021418.48624.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35815>

Hi,

On Tue, 2 Jan 2007, Jakub Narebski wrote:

> On Sun, 31 Dec 2006, Johannes Schindelin wrote:
> 
> > On Sat, 30 Dec 2006, Jakub Narebski wrote:
> > 
> >> Johannes Schindelin wrote:
> >> 
> >>> Of course, you can hit mismerges like the illustrated one _without_ 
> >>> being marked as conflict (e.g. if the chunk of identical code is _not_ 
> >>> added, but only the increments), but we should at least avoid them 
> >>> where possible.
> >> 
> >> Perhaps you could make it even more conservating merge conflicts option 
> >> (to tighten merge conflicts even more) to xdl_merge, but not used by 
> >> default because as it removes accidental conflicts it increases 
> >> mismerges (falsely not conflicted).
> > 
> > There is no way to do this sanely. If you want to catch these mismerges, 
> > you have to mark _all_ modifications as conflicting.
> 
> Currently you have:
>  - a level value of 0 means that all overlapping changes are treated
>    as conflicts,
>  - a value of 1 means that if the overlapping changes are identical,
>    it is not treated as a conflict.
>  - If you set level to 2, overlapping changes will be analyzed, so that
>    almost identical changes will not result in huge conflicts. Rather,
>    only the conflicting lines will be shown inside conflict markers.
> 
> I was thinking about:
>  - If you set level to 3, if one part after overlapping changes analysis
>    in level 2 has empty conflict region, resolve this conflict as second
>    side. WARNING: this reduces number of merge conflicts, but might give
>    mismerges!

That is certainly a possibility! But how would you specify it? If you 
do it as a command line option, you'd have to add it to git-merge, 
git-pull, git-merge-recursive and git-merge-file. Ugly.

You could do it as a config variable, but git-merge-file operates without 
a git repository. And you'd want it to be overrideable anyway.

Environment variable? Too unfriendly to users, because it is not really a 
proper UI.

It is certainly easy enough to teach the code (but might introduce 
unwanted side effects, when the _deletion_, not the _addition_ was what 
you wanted):

 xdiff/xdiff.h  |    1 +
 xdiff/xmerge.c |   21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index fa409d5..bdf12e3 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -52,6 +52,7 @@ extern "C" {
 #define XDL_MERGE_MINIMAL 0
 #define XDL_MERGE_EAGER 1
 #define XDL_MERGE_ZEALOUS 2
+#define XDL_MERGE_OVERZEALOUS 3
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index b83b334..e7b740f 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -180,7 +180,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
  * lines. Try hard to show only these few lines as conflicting.
  */
 static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
-		xpparam_t const *xpp)
+		int level, xpparam_t const *xpp)
 {
 	for (; m; m = m->next) {
 		mmfile_t t1, t2;
@@ -225,6 +225,12 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		m->chg1 = xscr->chg1;
 		m->i2 = xscr->i2 + i2;
 		m->chg2 = xscr->chg2;
+		if (level >= XDL_MERGE_OVERZEALOUS) {
+			if (!m->chg1)
+				m->mode = 2;
+			else if (!m->chg2)
+				m->mode = 1;
+		}
 		while (xscr->next) {
 			xdmerge_t *m2 = xdl_malloc(sizeof(xdmerge_t));
 			if (!m2) {
@@ -241,6 +247,12 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 			m->chg1 = xscr->chg1;
 			m->i2 = xscr->i2 + i2;
 			m->chg2 = xscr->chg2;
+			if (level >= XDL_MERGE_OVERZEALOUS) {
+				if (!m->chg1)
+					m->mode = 2;
+				else if (!m->chg2)
+					m->mode = 1;
+			}
 		}
 		xdl_free_env(&xe);
 		xdl_free_script(x);
@@ -252,6 +264,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
  * level == 0: mark all overlapping changes as conflict
  * level == 1: mark overlapping changes as conflict only if not identical
  * level == 2: analyze non-identical changes for minimal conflict set
+ * level == 3: if one side in the analysis is empty, assume no conflict
  *
  * returns < 0 on error, == 0 for no conflicts, else number of conflicts
  */
@@ -290,7 +303,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 			xscr2 = xscr2->next;
 			continue;
 		}
-		if (level < 1 || xscr1->i1 != xscr2->i1 ||
+		if (level < XDL_MERGE_EAGER || xscr1->i1 != xscr2->i1 ||
 				xscr1->chg1 != xscr2->chg1 ||
 				xscr1->chg2 != xscr2->chg2 ||
 				xdl_merge_cmp_lines(xe1, xscr1->i2,
@@ -355,7 +368,9 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	if (!changes)
 		changes = c;
 	/* refine conflicts */
-	if (level > 1 && xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0) {
+	if (level >= XDL_MERGE_ZEALOUS &&
+			xdl_refine_conflicts(xe1, xe2, changes,
+				xpp, level) < 0) {
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
