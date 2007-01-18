From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Thu, 18 Jan 2007 14:57:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AF5F83.6090207@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 14:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7XlZ-0003Te-5s
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 14:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbXARN5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 08:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbXARN5S
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 08:57:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:57366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932433AbXARN5R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 08:57:17 -0500
Received: (qmail invoked by alias); 18 Jan 2007 13:57:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 18 Jan 2007 14:57:16 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
In-Reply-To: <45AF5F83.6090207@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37090>

Hi,

On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:

> Johannes Schindelin wrote:
> > On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:
> > 
> > >  for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
> > > -			| @@PERL@@ -e 'print reverse <>'`
> > > +			| sed -ne '1!G;$p;h'`
> > 
> > Why not teach the revision machinery to output in reverse with "--reverse"?
> 
> I'm more in favour of "small is beautiful".  Also from looking at the code,
> this seems to be a bit complicated.

I'm more in favour of "less shell dependecy is beautiful". And from what I 
can tell, it should be relatively easy:

---

	14 insertions and 11 deletions stem from moving (and extern'ing) 
	reverse_commit_list() from merge-recursive.c to commit.c

	So the change is actually 9 insertions and one deletion.

 commit.c          |   11 +++++++++++
 commit.h          |    3 +++
 merge-recursive.c |   11 -----------
 revision.c        |    7 +++++++
 revision.h        |    3 ++-
 5 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/commit.c b/commit.c
index f495e2d..2735283 100644
--- a/commit.c
+++ b/commit.c
@@ -1231,3 +1231,14 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	}
 	return ret;
 }
+
+struct commit_list *reverse_commit_list(struct commit_list *list)
+{
+	struct commit_list *next = NULL, *current, *backup;
+	for (current = list; current; current = backup) {
+		backup = current->next;
+		current->next = next;
+		next = current;
+	}
+	return next;
+}
diff --git a/commit.h b/commit.h
index b8e6e18..563fe86 100644
--- a/commit.h
+++ b/commit.h
@@ -115,4 +115,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 
 int in_merge_bases(struct commit *, struct commit **, int);
+
+extern struct commit_list *reverse_commit_list(struct commit_list *list);
+
 #endif /* COMMIT_H */
diff --git a/merge-recursive.c b/merge-recursive.c
index fa320eb..75fec5b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1162,17 +1162,6 @@ static int merge_trees(struct tree *head,
 	return clean;
 }
 
-static struct commit_list *reverse_commit_list(struct commit_list *list)
-{
-	struct commit_list *next = NULL, *current, *backup;
-	for (current = list; current; current = backup) {
-		backup = current->next;
-		current->next = next;
-		next = current;
-	}
-	return next;
-}
-
 /*
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleaness of the merge.
diff --git a/revision.c b/revision.c
index ebd0250..6dc00ba 100644
--- a/revision.c
+++ b/revision.c
@@ -1057,6 +1057,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 					git_log_output_encoding = "";
 				continue;
 			}
+			if (!strcmp(arg, "--reverse")) {
+				revs->reverse = 1;
+				revs->limited = 1;
+				continue;
+			}
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
@@ -1155,6 +1160,8 @@ void prepare_revision_walk(struct rev_info *revs)
 		sort_in_topological_order_fn(&revs->commits, revs->lifo,
 					     revs->topo_setter,
 					     revs->topo_getter);
+	if (revs->reverse)
+		revs->commits = reverse_commit_list(revs->commits);
 }
 
 static int rewrite_one(struct rev_info *revs, struct commit **pp)
diff --git a/revision.h b/revision.h
index d93481f..3eb1ce4 100644
--- a/revision.h
+++ b/revision.h
@@ -42,7 +42,8 @@ struct rev_info {
 			unpacked:1, /* see also ignore_packed below */
 			boundary:1,
 			left_right:1,
-			parents:1;
+			parents:1,
+			reverse:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
