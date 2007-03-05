From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 5 Mar 2007 11:39:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	=?ISO-8859-1?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:40:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOJ2b-0006h2-VE
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 20:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbXCETkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 14:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbXCETkJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 14:40:09 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33282 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933187AbXCETkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 14:40:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25Jdsq8006468
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Mar 2007 11:39:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l25Jdqof031429;
	Mon, 5 Mar 2007 11:39:53 -0800
In-Reply-To: <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.452 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41477>



On Mon, 5 Mar 2007, Johannes Schindelin wrote:
> 
> In case revs->limited == 1, the revision walker really reads
> everything into revs->commits. The behaviour introduced in
> c4025103fa does not behave correctly in that case.
> 
> It used to say: everything which is _still_ in the pipeline
> must be a boundary commit.

I would suggest this (more invasive) patch instead.

Yours is

 revision.c |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

and mine is

 revision.c |   86 ++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 44 insertions(+), 42 deletions(-)

ie I have bigger changes, but on the whole this patch just adds two lines 
total, and I *think* the end result is more readable.

NOTE! Our patches aren't really mutually incompatible, and they attack the 
problem from two different directions. You do the separate phase (which is 
also correct), and my patch instead tries to clean up the commit walking 
so that the commit number limiter works more like the date limiter (which 
fundamentally has all the same issues! Including the problem with some 
commits possibly being marked as boundary commits when they aren't really, 
because the path-limiting or revision-limiting ended up cutting things off 
*differently* than the date-limiting).

So I would humbly suggest applying this one first (which makes the 
handling of the walk-time commit limiter more uniform and less hacky), and 
if we need to, we can *also* add the whole separate phase for the 
"revs->limited" case..

		Linus

---
commit d3dd7e89c123b644ef199380f4f050226e4df862
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Mon Mar 5 10:15:20 2007 -0800

    revision list: fix BOUNDARY handling with limiters and commit counts
    
    When we limited the number of commits using "max_count", we would not
    correctly handle the combination of various time- and reachability-based
    limiting and the use of a commit counting.  Everything that was
    reachable (but overflowed the commit count) would be marked as a
    BOUNDARY commit, resulting in things like "gitk" not being usable
    together with a numerical limit on the number of commits.
    
    This largely fixes it by being more careful about how we mark commits
    that went over the commit counts.
    
    NOTE! Because the numerical limiting happens without a separate phase as
    we traverse the commit list, we still won't do the boundary handling
    100% correct when a commit may be reachable from multiple sources, and
    under those circumstances, some commits will be marked as boundary
    commits even though they strictly aren't.
    
    To fix this, we would need to make rather more invasive changes, with
    commit counting being an integral part of the limiting (whuch is
    fundamnetally hard, since limiting itself will change the number of
    commits!).
    
    So this is the "good enough to be quite usable" approach.  The problem
    only affects boundary commits, and programs like 'gitk' that uses
    boundary commits would be better off just noticing themselves that not
    all boundary commits are necessarily useful.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 revision.c |   86 ++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/revision.c b/revision.c
index f5b8ae4..f5430d6 100644
--- a/revision.c
+++ b/revision.c
@@ -1213,6 +1213,30 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 			   commit->buffer, strlen(commit->buffer));
 }
 
+enum walk_action {
+	WALK_PARENTS,
+	WALK_STOP,
+};
+
+/*
+ * When we do the list limiting at commit-walking time, we
+ * need to make sure that we stop walking parenthood when
+ * we hit a commit that isn't interesting any more. This can
+ * be due to max_count or due to date limiters.
+ */
+static enum walk_action walk_commit(struct rev_info *revs, struct commit *commit)
+{
+	if (!revs->max_count)
+		return WALK_STOP;
+
+	if (revs->max_age != -1) {
+		if (commit->date < revs->max_age)
+			return WALK_STOP;
+	}
+
+	return WALK_PARENTS;
+}
+
 static struct commit *get_revision_1(struct rev_info *revs)
 {
 	if (!revs->commits)
@@ -1233,17 +1257,19 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 * the parents here. We also need to do the date-based limiting
 		 * that we'd otherwise have done in limit_list().
 		 */
-		if (!revs->limited) {
-			if (revs->max_age != -1 &&
-			    (commit->date < revs->max_age)) {
-				if (revs->boundary)
-					commit->object.flags |=
-						BOUNDARY_SHOW | BOUNDARY;
-				else
-					continue;
-			} else
-				add_parents_to_list(revs, commit,
-						&revs->commits);
+		switch (walk_commit(revs, commit)) {
+		case WALK_PARENTS:
+			if (revs->limited)
+				break;
+			add_parents_to_list(revs, commit, &revs->commits);
+			break;
+		case WALK_STOP:
+			if (!revs->boundary)
+				continue;
+			if (!(commit->object.flags & UNINTERESTING))
+				commit->object.flags |= BOUNDARY_SHOW | BOUNDARY | UNINTERESTING;
+			mark_parents_uninteresting(commit);
+			break;
 		}
 		if (commit->object.flags & SHOWN)
 			continue;
@@ -1289,6 +1315,12 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		if (revs->boundary)
 			mark_boundary_to_show(commit);
 		commit->object.flags |= SHOWN;
+		if (revs->skip_count > 0) {
+			revs->skip_count--;
+			continue;
+		}
+		if (revs->max_count > 0)
+			revs->max_count--;
 		return commit;
 	} while (revs->commits);
 	return NULL;
@@ -1296,9 +1328,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 struct commit *get_revision(struct rev_info *revs)
 {
-	struct commit *c = NULL;
-
 	if (revs->reverse) {
+		struct commit *c;
 		struct commit_list *list;
 
 		/*
@@ -1332,34 +1363,5 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	if (0 < revs->skip_count) {
-		while ((c = get_revision_1(revs)) != NULL) {
-			if (revs->skip_count-- <= 0)
-				break;
-		}
-	}
-
-	/* Check the max_count ... */
-	switch (revs->max_count) {
-	case -1:
-		break;
-	case 0:
-		if (revs->boundary) {
-			struct commit_list *list = revs->commits;
-			while (list) {
-				list->item->object.flags |=
-					BOUNDARY_SHOW | BOUNDARY;
-				list = list->next;
-			}
-			/* all remaining commits are boundary commits */
-			revs->max_count = -1;
-			revs->limited = 1;
-		} else
-			return NULL;
-	default:
-		revs->max_count--;
-	}
-	if (c)
-		return c;
 	return get_revision_1(revs);
 }
