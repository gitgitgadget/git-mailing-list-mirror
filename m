From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb.cgi history not shown
Date: Sat, 10 Jun 2006 23:02:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606102248360.5498@g5.osdl.org>
References: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 08:02:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpJ1v-0005kh-4B
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 08:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWFKGCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 02:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWFKGCS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 02:02:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932099AbWFKGCS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 02:02:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5B62Bgt014892
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Jun 2006 23:02:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5B62A5Q012722;
	Sat, 10 Jun 2006 23:02:11 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21633>



On Sun, 11 Jun 2006, Marco Costalba wrote:
>
> What I do wrong?
> 
> $ git-rev-list --all -- gitweb/gitweb.cgi
> 0a8f4f0020cb35095005852c0797f0b90e9ebb74
> $ git-rev-list --all -- gitweb.cgi
> $

[ no output ]

This is getting to be a FAQ, and I think we should add the 
"--no-prune-history" flag (or whatever I called it - I even sent out a 
patch for it) so that you can avoid it.

The thing that happens in

	git-rev-list --all -- gitweb.cgi

is that since your _current_ HEAD does not have that file at all, it 
starts going back in history, and at each merge it finds it will 
_simplify_ the history, and only look at that part of history that is 
identical _with_respect_to_the_name_you_gave_!

Now, in the main git history, that name has NEVER existed, so the 
simplified history for that particular name (as seen from the current 
branch) is simply empty. It's empty all the way back to the root. No 
commits at all add that name along the main history branch.

Now, that name obviously existed in the _side_ histories, but we don't 
show those, because they obviously didn't matter (as far as that 
particular name happened) within the particular history starting point you 
chose. See?

Now, look what happens if you instead of starting the history search from 
all the _current_ heads, you start it from a location that actually _had_ 
that file:

	git log 1130ef362fc8d9c3422c23f5d5 -- gitweb.cgi

and suddenly there the history is - in all its glory.

So what this boils down to is really: when you limit revision history by a 
set of filenames, GIT REALLY REWRITES AND SIMPLIFIES THE HISTORY AS PER 
_THAT_ PARTICULAR SET OF FILENAMES. In particular, it will generate the 
_simplest_ history that is consistent with the state of those filenames at 
the point you asked it to start.

If you want to get the non-simplified history (ie you object to the fact 
that we give the simplest history, you want _all_ the possible history for 
that particular filename, whether it was the same along one branch or 
not), you need to apply something like the appended..

(And you obviously need to add that "no_simplify_merge" flag to the 
revision data structure, and you need to add some command line flag to 
enable it. Alternatively, try to find the patch I sent out a couple of 
months ago, I'm pretty sure I called it "--no-simplify-merge" or 
"--no-prune-history" or something like that).

		Linus
---
diff --git a/revision.c b/revision.c
index 6a6952c..5640cef 100644
--- a/revision.c
+++ b/revision.c
@@ -303,7 +303,7 @@ static void try_to_simplify_commit(struc
 		parse_commit(p);
 		switch (rev_compare_tree(revs, p->tree, commit->tree)) {
 		case REV_TREE_SAME:
-			if (p->object.flags & UNINTERESTING) {
+			if (revs->no_simplify_merge || (p->object.flags & UNINTERESTING)) {
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
 				 * we are interested in, we do not want
