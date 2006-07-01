From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 20:13:09 +0200
Message-ID: <20060701181309.GA29199@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org> <20060701150926.GA25800@lsrfire.ath.cx> <Pine.LNX.4.64.0607010921450.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 20:13:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwjxz-0007vT-30
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 20:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWGASNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWGASNL
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 14:13:11 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:47840
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750941AbWGASNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 14:13:10 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 46746B464; Sat,  1 Jul 2006 20:13:09 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607010921450.12404@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23053>

On Sat, Jul 01, 2006 at 09:25:43AM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 1 Jul 2006, Rene Scharfe wrote:
> > 
> > You mean something like the following patch on top of the 'next' branch?
> > It also documents the --not switch because I needed it for the example.
> 
> Yes. 
> 
> However, I think that 90% of the code for the ".." and "..." case are the 
> same, as is largely the finding of it.
> 
> So why not just do this all inside the already existing
> 
> 	dotdot = strstr(arg, "..");
> 	if (dotdot) {
> 		unsigned char other_sha1[20];
> 		const char *one = arg;
> 		const char *two = arg + 2;
> 		int symmetric = *two == '.';
> 
> 		*dotdot = '\0';
> 		two += symmetric;
> 
> 		if (one == arg)
> 			one = "HEAD";
> 		if (!*two)
> 			two = "HEAD";
> 		...
> 
> because the only difference is really at the very end.

Hrm, I'm not sure this is really cleaner.  The two operators consist
of all dots only coincidentally, this is not functionally inherent.
So I think it's better to keep them apart.

Let's see..  [Time passes.  A patch materializes at six o'clock.]

With a little helper factored out this doesn't look as bad as I
imagined.  Maybe we can take it.  What do you think?

> Did you test that it looks correct too?

Sort of; I checked that the two forms (with ... and $(git-merge-base))
gave the same results for 7b8cf0cf and 51d1e83f, that's all.  For a
proper test script we'd need to create a repo for which git-merge-base
can report multiple results.  I wasn't able to come up with the needed
commands without thinking and gave up for now.  Am working on it..

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ad6d14c..6c370e1 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [ \--sparse ]
 	     [ \--no-merges ]
 	     [ \--remove-empty ]
+	     [ \--not ]
 	     [ \--all ]
 	     [ \--topo-order ]
 	     [ \--parents ]
@@ -37,6 +38,14 @@ not in 'baz'".
 A special notation <commit1>..<commit2> can be used as a
 short-hand for {caret}<commit1> <commit2>.
 
+Another special notation is <commit1>...<commit2> which is useful for
+merges.  The resulting set of commits is the symmetric difference
+between the two operands.  The following two commands are equivalent:
+
+------------
+$ git-rev-list A B --not $(git-merge-base --all A B)
+$ git-rev-list A...B
+------------
 
 OPTIONS
 -------
@@ -93,6 +102,11 @@ OPTIONS
 --remove-empty::
 	Stop when a given path disappears from the tree.
 
+--not::
+	Reverses the meaning of the '{caret}' prefix (or lack
+	thereof) for all following revision specifiers, up to
+	the next `--not`.
+
 --all::
 	Pretend as if all the refs in `$GIT_DIR/refs/` are
 	listed on the command line as <commit>.
diff --git a/revision.c b/revision.c
index ae4ca82..bcedf66 100644
--- a/revision.c
+++ b/revision.c
@@ -536,6 +536,18 @@ void init_revisions(struct rev_info *rev
 	diff_setup(&revs->diffopt);
 }
 
+static void add_pending_commit_list(struct rev_info *revs,
+                                    struct commit_list *commit_list,
+                                    unsigned int flags)
+{
+	while (commit_list) {
+		struct object *object = &commit_list->item->object;
+		object->flags |= flags;
+		add_pending_object(revs, object, sha1_to_hex(object->sha1));
+		commit_list = commit_list->next;
+	}
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -771,27 +783,45 @@ int setup_revisions(int argc, const char
 			unsigned char from_sha1[20];
 			const char *next = dotdot + 2;
 			const char *this = arg;
+			int symmetric = *next == '.';
+			unsigned int flags_exclude = flags ^ UNINTERESTING;
+
 			*dotdot = 0;
+			next += symmetric;
+
 			if (!*next)
 				next = "HEAD";
 			if (dotdot == arg)
 				this = "HEAD";
 			if (!get_sha1(this, from_sha1) &&
 			    !get_sha1(next, sha1)) {
-				struct object *exclude;
-				struct object *include;
-
-				exclude = get_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
-				include = get_reference(revs, next, sha1, flags);
-				if (!exclude || !include)
-					die("Invalid revision range %s..%s", arg, next);
+				struct commit *a, *b;
+				struct commit_list *exclude;
+
+				a = lookup_commit_reference(from_sha1);
+				b = lookup_commit_reference(sha1);
+				if (!a || !b) {
+					die(symmetric ?
+					    "Invalid symmetric difference expression %s...%s" :
+					    "Invalid revision range %s..%s",
+					    arg, next);
+				}
 
 				if (!seen_dashdash) {
 					*dotdot = '.';
 					verify_non_filename(revs->prefix, arg);
 				}
-				add_pending_object(revs, exclude, this);
-				add_pending_object(revs, include, next);
+
+				if (symmetric) {
+					exclude = get_merge_bases(a, b);
+					add_pending_commit_list(revs, exclude,
+					                        flags_exclude);
+					a->object.flags |= flags;
+				} else
+					a->object.flags |= flags_exclude;
+				b->object.flags |= flags;
+				add_pending_object(revs, &a->object, this);
+				add_pending_object(revs, &b->object, next);
 				continue;
 			}
 			*dotdot = '.';
