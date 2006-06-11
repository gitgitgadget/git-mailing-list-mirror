From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb.cgi history not shown
Date: Sun, 11 Jun 2006 10:57:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606111044160.5498@g5.osdl.org>
References: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com>
 <Pine.LNX.4.64.0606102248360.5498@g5.osdl.org>
 <e5bfff550606102332v6afb7d51m43ad5d74ba226cf0@mail.gmail.com>
 <Pine.LNX.4.64.0606110902090.5498@g5.osdl.org> <Pine.LNX.4.64.0606110933040.5498@g5.osdl.org>
 <e6hi4g$k4a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 11 19:57:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpUC1-0002s7-AQ
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 19:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWFKR5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 13:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWFKR5m
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 13:57:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750741AbWFKR5m (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 13:57:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5BHvagt025293
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 10:57:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5BHvZkl027591;
	Sun, 11 Jun 2006 10:57:35 -0700
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <e6hi4g$k4a$1@sea.gmane.org>
X-Spam-Status: No, hits=0.224 required=5 tests=REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21666>



On Sun, 11 Jun 2006, Jakub Narebski wrote:
> 
> Could we please 'git whatchanged -p' default to the original (before
> rewrite) behavior, i.e. ALL THE HISTORY?

Ok, here's the full patch to do that.

It does:

 - add a "rev.simplify_history" flag which defaults to on
 - it turns it off for "git whatchanged" (which thus now has real
   semantics outside of "git log")
 - it adds a command line flag ("--full-history") to turn it off for 
   others (ie you can make "git log" and "gitk" etc get the semantics if 
   you want to.

Now, just as an example of _why_ you really really really want to simplify 
history by default, apply this patch, install it, and try these two 
command lines:

	gitk --full-history -- git.c
	gitk -- git.c

and compare the output. 

So with this, you can also now do

	git whatchanged -p -- gitweb.cgi
	git log -p --full-history -- gitweb.cgi

and it will show the old history of gitweb.cgi, even though it's not 
relevant to the _current_ state of the name "gitweb.cgi"

NOTE NOTE NOTE! It will still actually simplify away merges that didn't 
change anything at all into either child. That creates these bogus strange 
discontinuities if you look at it with "gitk" (look at the --full-history 
gitk output for git.c, and you'll see a few strange cases).

So the whole "--parent" thing ends up somewhat bogus with --full-history 
because of this, but I'm not sure it's worth even worrying about. I don't 
think you'd ever want to really use "--full-history" with the graphical 
representation, I just give it as an example exactly to show _why_ doing 
so would be insane.

I think this is trivial enough and useful enough to be worth merging into 
the stable branch.

			Linus

---
diff --git a/builtin-log.c b/builtin-log.c
index 29a8851..4407f06 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -51,6 +51,7 @@ int cmd_whatchanged(int argc, const char
 	init_revisions(&rev);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
+	rev.simplify_history = 0;
 	return cmd_log_wc(argc, argv, envp, &rev);
 }
 
diff --git a/revision.c b/revision.c
index 6a6952c..75c648c 100644
--- a/revision.c
+++ b/revision.c
@@ -303,7 +303,7 @@ static void try_to_simplify_commit(struc
 		parse_commit(p);
 		switch (rev_compare_tree(revs, p->tree, commit->tree)) {
 		case REV_TREE_SAME:
-			if (p->object.flags & UNINTERESTING) {
+			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
 				 * we are interested in, we do not want
@@ -519,6 +519,7 @@ void init_revisions(struct rev_info *rev
 
 	revs->abbrev = DEFAULT_ABBREV;
 	revs->ignore_merges = 1;
+	revs->simplify_history = 1;
 	revs->pruning.recursive = 1;
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
@@ -756,6 +757,10 @@ int setup_revisions(int argc, const char
 				revs->full_diff = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--full-history")) {
+				revs->simplify_history = 0;
+				continue;
+			}
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
 				revs->diff = 1;
diff --git a/revision.h b/revision.h
index 7d85b0f..4020e25 100644
--- a/revision.h
+++ b/revision.h
@@ -30,6 +30,7 @@ struct rev_info {
 			no_merges:1,
 			no_walk:1,
 			remove_empty_trees:1,
+			simplify_history:1,
 			lifo:1,
 			topo_order:1,
 			tag_objects:1,
