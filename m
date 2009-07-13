From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] Re: Make 'git show' more useful
Date: Tue, 14 Jul 2009 01:43:34 +0200
Message-ID: <1247528614-24590-1-git-send-email-bonzini@gnu.org>
References: <7vtz1gi67v.fsf@alter.siamese.dyndns.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 01:43:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQVBQ-0003DV-Gt
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 01:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757633AbZGMXni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbZGMXni
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 19:43:38 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:54582 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbZGMXnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 19:43:37 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MQVBI-0000Hx-Hr; Mon, 13 Jul 2009 19:43:36 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <7vtz1gi67v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123214>

> And, admittedly, you can _already_ do this by just adding "--do-walk"
> whenever you specify a range. And equally admittedly, you can already
> confuse git by adding the "--no-walk" _after_ specifying the range,
> ie you can do this:
>
> 	git log HEAD~5.. --no-walk

Even without the change you could do

	git show --do-walk HEAD~5.. --no-walk

But then why do we want --do-walk and --no-walk?  You can always use "git
rev-parse" instead of "git rev-list --no-walk" (just check that the output 
is a single SHA1 id), and I don't think it is so important to be able
to say "git log --no-walk" instead of "git log -1".

They are not tested either.  Just gitk cares about --no-walk... to prevent
the user from giving it.

So, what about squashing this with Linus's patch?  (This is meant to be
squashed, which is why this text is not in a cover letter).  Still:

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 Documentation/git-rev-list.txt     |    1 -
 Documentation/rev-list-options.txt |    8 --------
 revision.c                         |   13 ++-----------
 gitk-git/gitk                      |    1 -+
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 1c9cc28..b02cf54 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -44,7 +44,6 @@ SYNOPSIS
 	     [ \--merge ]
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
-	     [ \--no-walk ] [ \--do-walk ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 11eec94..d137e32 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -624,11 +624,3 @@ These options are mostly targeted for packing of git repositories.
 
 	Only useful with '--objects'; print the object IDs that are not
 	in packs.
-
---no-walk::
-
-	Only show the given revs, but do not traverse their ancestors.
-
---do-walk::
-
-	Overrides a previous --no-walk.
diff --git a/revision.c b/revision.c
index a31434b..8b1a385 100644
--- a/revision.c
+++ b/revision.c
@@ -993,8 +993,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	/* pseudo revision arguments */
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
 	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
-	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
-	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
+	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not"))
 	{
 		unkv[(*unkc)++] = arg;
 		return 1;
@@ -1273,14 +1272,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				flags ^= UNINTERESTING;
 				continue;
 			}
-			if (!strcmp(arg, "--no-walk")) {
-				revs->no_walk = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--do-walk")) {
-				revs->no_walk = 0;
-				continue;
-			}
 
 			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
 			if (opts > 0) {
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4604c83..984d30a 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -169,7 +169,7 @@ proc parseviewargs {n arglist} {
 	    "--name-only" - "--name-status" - "--color" - "--color-words" -
 	    "--log-size" - "--pretty=*" - "--decorate" - "--abbrev-commit" -
 	    "--cc" - "-z" - "--header" - "--parents" - "--boundary" -
-	    "--no-color" - "-g" - "--walk-reflogs" - "--no-walk" -
+	    "--no-color" - "-g" - "--walk-reflogs" -
 	    "--timestamp" - "relative-date" - "--date=*" - "--stdin" -
 	    "--objects" - "--objects-edge" - "--reverse" {
 		# These cause our parsing of git log's output to fail, or else
-- 
1.6.2.5
