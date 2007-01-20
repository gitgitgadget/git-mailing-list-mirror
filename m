From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sat, 20 Jan 2007 23:04:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AF5F83.6090207@fs.ei.tum.de> <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfya69xym.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701201025070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 23:04:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8OJn-00052d-7R
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 23:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965402AbXATWEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 17:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965404AbXATWEH
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 17:04:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:53007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965402AbXATWEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 17:04:04 -0500
Received: (qmail invoked by alias); 20 Jan 2007 22:04:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 20 Jan 2007 23:04:03 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37297>

Hi,

On Sat, 20 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I think there are two very valid ways.  You determine what you
> >> would spit out as if there is no --reverse, and then reverse the
> >> result, or you do not limit with them to get everthing, reverse
> >> the result and do the counting limit on that reversed list.
> > ...
> >> I do not think you would need to artificially make it limited like your 
> >> patch does if you go this route
> >
> > Why? To see the last commit (which should be output first), I _have_ to 
> > traverse them first, before reversing the order. I thought revs->limited 
> > does exactly that -- traverse all commits first. Am I mistaken?
> 
> I think you are talking about the second semantics; I was
> talking about the first one.  In other words, the one whose
> semantics of:
> 
> 	$ git log --max-count=10 --skip=5 --reverse HEAD
> 
> is to first internally run
> 
> 	$ git log --max-count=10 --skip=5 HEAD
> 
> then reverse the resulting 10 commits and spit them out.

That is exactly what I meant.

> Now, "git log --max-count=10 --skip=5" does not need to call
> limit_list().  It needs to traverse the usual date-sorted
> revs->commits for fifteen rounds.

Yes. But I have to traverse this _first_, before even returning a commit 
from get_revision().

I had the impression that limit_list() traversed all commits. But I am 
probably wrong, ain't I?

> @@ -1155,6 +1160,8 @@ void prepare_revision_walk(struct rev_info *revs)
>  		sort_in_topological_order_fn(&revs->commits, revs->lifo,
>  					     revs->topo_setter,
>  					     revs->topo_getter);
> +	if (revs->reverse)
> +		revs->commits = reverse_commit_list(revs->commits);
>  }
>  
>  static int rewrite_one(struct rev_info *revs, struct commit **pp)
> 
> This makes the code traverse and grab everything and then
> reverse; the later get_revision() -> get_revision_1() loop skips
> 5, returns 10 and then finally stops.  In other words, this
> gives 10 old commits counting from the 6th oldest one in the
> history.

Okay, I thought that limit_list() honours --skip and --max-count. Looking 
at the code it seems to me that this assumption is wrong.

> If we prefer the first semantics, we do not have to traverse and
> grab everything.  That is what I was getting at.
> 
> That is, something like this, with your option parsing change
> (modulo we _might_ want to explicitly mark some of the users
> incompatible), addition of reverse field to struct rev_info,
> moving reverse_commit_list() to a more public place, but without
> making the reverse to imply limited traversal.
> 
> diff --git a/revision.c b/revision.c
> index f2ddd95..161c4c0 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1274,6 +1274,14 @@ struct commit *get_revision(struct rev_info *revs)
>  {
>  	struct commit *c = NULL;
>  
> +	if (revs->reverse) {
> +		/* we were asked to reverse, but haven't reversed the
> +		 * result, yet, so do it here once
> +		 */
> +		revs->commits = reverse_commit_list(revs->commits);
> +		revs->reverse = 0;
> +	}
> +
>  	if (0 < revs->skip_count) {
>  		while ((c = get_revision_1(revs)) != NULL) {
>  			if (revs->skip_count-- <= 0)

But that would not work, would it?

Example:

A - B - C - D

D is the HEAD. Now, when we do not limit_list(), when we get into 
get_revision() for the first time, revs->commits contains _only_ D (we do 
the ancestry walk on-the-fly). So, your code would "reverse" the list 
containing only D, reset the reverse flag. In effect, it would do exactly 
the same as without --reverse.

What I _wanted_, was to walk the ancestry chain first, then just reverse 
the commits, and be done. However, it seems I was utterly mistaken in my 
approach. This should work better:

---
[PATCH] Teach revision machinery about --reverse

The option --reverse reverses the order of the commits.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/git-rev-list.txt |    5 +++++
 revision.c                     |   25 +++++++++++++++++++++++++
 revision.h                     |    3 ++-
 3 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 86c94e7..6bb9f51 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -27,6 +27,7 @@ SYNOPSIS
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
 	     [ \--merge ]
+	     [ \--reverse ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
@@ -249,6 +250,10 @@ By default, the commits are shown in reverse chronological order.
 	parent comes before all of its children, but otherwise things
 	are still ordered in the commit timestamp order.
 
+--reverse::
+
+	Output the commits in reverse order.
+
 Object Traversal
 ~~~~~~~~~~~~~~~~
 
diff --git a/revision.c b/revision.c
index ebd0250..afc824c 100644
--- a/revision.c
+++ b/revision.c
@@ -1057,6 +1057,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 					git_log_output_encoding = "";
 				continue;
 			}
+			if (!strcmp(arg, "--reverse")) {
+				revs->reverse ^= 1;
+				continue;
+			}
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
@@ -1285,6 +1289,27 @@ struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c = NULL;
 
+	if (revs->reverse) {
+		struct commit_list *list;
+
+		if (revs->reverse == 1) {
+			revs->reverse = 0;
+			list = NULL;
+			while ((c = get_revision(revs)))
+				commit_list_insert(c, &list);
+			revs->commits = list;
+			revs->reverse = 2;
+		}
+
+		if (!revs->commits)
+			return NULL;
+		c = revs->commits->item;
+		list = revs->commits->next;
+		free(revs->commits);
+		revs->commits = list;
+		return c;
+	}
+
 	if (0 < revs->skip_count) {
 		while ((c = get_revision_1(revs)) != NULL) {
 			if (revs->skip_count-- <= 0)
diff --git a/revision.h b/revision.h
index d93481f..5fec184 100644
--- a/revision.h
+++ b/revision.h
@@ -42,7 +42,8 @@ struct rev_info {
 			unpacked:1, /* see also ignore_packed below */
 			boundary:1,
 			left_right:1,
-			parents:1;
+			parents:1,
+			reverse:2;
 
 	/* Diff flags */
 	unsigned int	diff:1,
