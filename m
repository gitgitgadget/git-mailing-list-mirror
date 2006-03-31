From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Thu, 30 Mar 2006 17:05:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Mar 31 03:05:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP857-0007h9-Ih
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 03:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWCaBFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 20:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWCaBFg
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 20:05:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751102AbWCaBFg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 20:05:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2V15SCo005303
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Mar 2006 17:05:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2V15Q4o002132;
	Thu, 30 Mar 2006 17:05:27 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18213>


This makes git-rev-list able to do path-limiting without having to parse
all of history before it starts showing the results.

This makes it things like "git log -- pathname" much more pleasant to use.

This is actually a pretty small patch, and the biggest part of it is 
purely cleanups (turning the "goto next" statements into "continue"), but 
it's conceptually a lot bigger than it looks.

What it does is that if you do a path-limited revision list, and you do 
_not_ ask for pseudo-parenthood information, it won't do all the 
path-limiting up-front, but instead do it incrementally in 
"get_revision()".

This is an absolutely huge deal for anything like "git log -- <pathname>", 
but also for some things that we don't do yet - like the "find where 
things changed" logic I've described elsewhere, where we want to find the 
previous revision that changed a file.

The reason I put "RFC" in the subject line is that while I've validated it 
various ways, like doing

	git-rev-list HEAD -- drivers/char/ | md5sum 

before-and-after on the kernel archive, it's "git-rev-list" after all. In 
other words, it's that really really subtle and complex central piece of 
software. So while I think this is important and should go in asap, I also 
think it should get lots of testing and eyeballs looking at the code.

Btw, don't even bother testing this with the git archive. git itself is so 
small that parsing the whole revision history for it takes about a second 
even with path limiting. The thing that _really_ shows this off is doing

	git log drivers/

on the kernel archive, or even better, on the _historic_ kernel archive.

With this change, the response is instantaneous (although seeking to the 
end of the result will obviously take as long as it ever did). Before this 
change, the command would think about the result for tens of seconds - or 
even minutes, in the case of the bigger old kernel archive - before 
starting to output the results.

NOTE NOTE NOTE! Using path limiting with things like "gitk", which uses 
the "--parents" flag to actually generate a pseudo-history of the 
resulting commits won't actually see the improvement in interactivity, 
since that forces git-rev-list to do the whole-history thing after all. 

MAYBE we can fix that too at some point, but I won't promise anything.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---


diff --git a/revision.c b/revision.c
index 0330f9f..0e3f074 100644
--- a/revision.c
+++ b/revision.c
@@ -702,7 +702,13 @@ int setup_revisions(int argc, const char
 	if (revs->prune_data) {
 		diff_tree_setup_paths(revs->prune_data);
 		revs->prune_fn = try_to_simplify_commit;
-		revs->limited = 1;
+
+		/*
+		 * If we fix up parent data, we currently cannot
+		 * do that on-the-fly.
+		 */
+		if (revs->parents)
+			revs->limited = 1;
 	}
 
 	return left;
@@ -763,23 +769,32 @@ struct commit *get_revision(struct rev_i
 
 	do {
 		struct commit *commit = revs->commits->item;
+
+		revs->commits = revs->commits->next;
 
+		/*
+		 * If we haven't done the list limiting, we need to look at
+		 * the parents here
+		 */
+		if (!revs->limited)
+			add_parents_to_list(revs, commit, &revs->commits);
 		if (commit->object.flags & SHOWN)
-			goto next;
+			continue;
 		if (!(commit->object.flags & BOUNDARY) &&
 		    (commit->object.flags & UNINTERESTING))
-			goto next;
+			continue;
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
-			goto next;
+			continue;
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			return NULL;
 		if (revs->no_merges &&
 		    commit->parents && commit->parents->next)
-			goto next;
+			continue;
 		if (revs->prune_fn && revs->dense) {
 			if (!(commit->object.flags & TREECHANGE))
-				goto next;
-			rewrite_parents(commit);
+				continue;
+			if (revs->parents)
+				rewrite_parents(commit);
 		}
 		/* More to go? */
 		if (revs->max_count) {
@@ -792,13 +807,9 @@ struct commit *get_revision(struct rev_i
 				revs->commits = it->next;
 				free(it);
 			}
-			else
-				pop_most_recent_commit(&revs->commits, SEEN);
 		}
 		commit->object.flags |= SHOWN;
 		return commit;
-next:
-		pop_most_recent_commit(&revs->commits, SEEN);
 	} while (revs->commits);
 	return NULL;
 }
