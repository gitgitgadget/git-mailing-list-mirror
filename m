From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 05/10] Documentation: remove howto's now incorporated into manual
Date: Mon, 14 May 2007 11:21:24 -0400
Message-ID: <17563.3460902192$1179156135@news.gmane.org>
References: <11791560893572-git-send-email->
 <1179156089759-git-send-email->
 <11791560893022-git-send-email->
 <11791560891179-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNG-0006P0-Q0
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685AbXENPVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756712AbXENPVg
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:36 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54961 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755507AbXENPVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:32 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMb-0004z8-RV; Mon, 14 May 2007 11:21:29 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <11791560891179-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47253>

From: J. Bruce Fields <bfields@citi.umich.edu>

These two howto's have both been copied into the manual.  I'd rather not
maintain both versions if possible, and I think the user-manual will be
more visible than the howto directory.  (Though I wouldn't mind some
duplication if people really like having them here.)

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/howto/dangling-objects.txt         |  109 ----------------------
 Documentation/howto/isolate-bugs-with-bisect.txt |   65 -------------
 2 files changed, 0 insertions(+), 174 deletions(-)
 delete mode 100644 Documentation/howto/dangling-objects.txt
 delete mode 100644 Documentation/howto/isolate-bugs-with-bisect.txt

diff --git a/Documentation/howto/dangling-objects.txt b/Documentation/howto/dangling-objects.txt
deleted file mode 100644
index e82ddae..0000000
--- a/Documentation/howto/dangling-objects.txt
+++ /dev/null
@@ -1,109 +0,0 @@
-From: Linus Torvalds <torvalds@linux-foundation.org>
-Subject: Re: Question about fsck-objects output
-Date: Thu, 25 Jan 2007 12:01:06 -0800 (PST)
-Message-ID: <Pine.LNX.4.64.0701251144290.25027@woody.linux-foundation.org>
-Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37754>
-Abstract: Linus describes what dangling objects are, when they
- are left behind, and how to view their relationship with branch
- heads in gitk
-
-On Thu, 25 Jan 2007, Larry Streepy wrote:
-
-> Sorry to ask such a basic question, but I can't quite decipher the output of
-> fsck-objects.  When I run it, I get this:
->
->  git fsck-objects
-> dangling commit 2213f6d4dd39ca8baebd0427723723e63208521b
-> dangling commit f0d4e00196bd5ee54463e9ea7a0f0e8303da767f
-> dangling blob 6a6d0b01b3e96d49a8f2c7addd4ef8c3bd1f5761
->
->
-> Even after a "repack -a -d" they still exist.  The man page has a short
-> explanation, but, at least for me, it wasn't fully enlightening. :-)
->
-> The man page says that dangling commits could be "root" commits, but since my
-> repo started as a clone of another repo, I don't see how I could have any root
-> commits.  Also, the page doesn't really describe what a dangling blob is.
->
-> So, can someone explain what these artifacts are and if they are a problem
-> that I should be worried about?
-
-The most common situation is that you've rebased a branch (or you have
-pulled from somebody else who rebased a branch, like the "pu" branch in
-the git.git archive itself).
-
-What happens is that the old head of the original branch still exists, as
-does obviously everything it pointed to. The branch pointer itself just
-doesn't, since you replaced it with another one.
-
-However, there are certainly other situations too that cause dangling
-objects. For example, the "dangling blob" situation you have tends to be
-because you did a "git add" of a file, but then, before you actually
-committed it and made it part of the bigger picture, you changed something
-else in that file and committed that *updated* thing - the old state that
-you added originally ends up not being pointed to by any commit/tree, so
-it's now a dangling blob object.
-
-Similarly, when the "recursive" merge strategy runs, and finds that there
-are criss-cross merges and thus more than one merge base (which is fairly
-unusual, but it does happen), it will generate one temporary midway tree
-(or possibly even more, if you had lots of criss-crossing merges and
-more than two merge bases) as a temporary internal merge base, and again,
-those are real objects, but the end result will not end up pointing to
-them, so they end up "dangling" in your repository.
-
-Generally, dangling objects aren't anything to worry about. They can even
-be very useful: if you screw something up, the dangling objects can be how
-you recover your old tree (say, you did a rebase, and realized that you
-really didn't want to - you can look at what dangling objects you have,
-and decide to reset your head to some old dangling state).
-
-For commits, the most useful thing to do with dangling objects tends to be
-to do a simple
-
-	gitk <dangling-commit-sha-goes-here> --not --all
-
-which means exactly what it sounds like: it says that you want to see the
-commit history that is described by the dangling commit(s), but you do NOT
-want to see the history that is described by all your branches and tags
-(which are the things you normally reach). That basically shows you in a
-nice way what the danglign commit was (and notice that it might not be
-just one commit: we only report the "tip of the line" as being dangling,
-but there might be a whole deep and complex commit history that has gotten
-dropped - rebasing will do that).
-
-For blobs and trees, you can't do the same, but you can examine them. You
-can just do
-
-	git show <dangling-blob/tree-sha-goes-here>
-
-to show what the contents of the blob were (or, for a tree, basically what
-the "ls" for that directory was), and that may give you some idea of what
-the operation was that left that dangling object.
-
-Usually, dangling blobs and trees aren't very interesting. They're almost
-always the result of either being a half-way mergebase (the blob will
-often even have the conflict markers from a merge in it, if you have had
-conflicting merges that you fixed up by hand), or simply because you
-interrupted a "git fetch" with ^C or something like that, leaving _some_
-of the new objects in the object database, but just dangling and useless.
-
-Anyway, once you are sure that you're not interested in any dangling
-state, you can just prune all unreachable objects:
-
-	git prune
-
-and they'll be gone. But you should only run "git prune" on a quiescent
-repository - it's kind of like doing a filesystem fsck recovery: you don't
-want to do that while the filesystem is mounted.
-
-(The same is true of "git-fsck-objects" itself, btw - but since
-git-fsck-objects never actually *changes* the repository, it just reports
-on what it found, git-fsck-objects itself is never "dangerous" to run.
-Running it while somebody is actually changing the repository can cause
-confusing and scary messages, but it won't actually do anything bad. In
-contrast, running "git prune" while somebody is actively changing the
-repository is a *BAD* idea).
-
-			Linus
-
diff --git a/Documentation/howto/isolate-bugs-with-bisect.txt b/Documentation/howto/isolate-bugs-with-bisect.txt
deleted file mode 100644
index 926bbdc..0000000
--- a/Documentation/howto/isolate-bugs-with-bisect.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-From:	Linus Torvalds <torvalds () osdl ! org>
-To:	git@vger.kernel.org
-Date:	2005-11-08 1:31:34
-Subject: Real-life kernel debugging scenario
-Abstract: Short-n-sweet, Linus tells us how to leverage `git-bisect` to perform
-	bug isolation on a repository where "good" and "bad" revisions are known
-	in order to identify a suspect commit.
-
-
-How To Use git-bisect To Isolate a Bogus Commit
-===============================================
-
-The way to use "git bisect" couldn't be easier.
-
-Figure out what the oldest bad state you know about is (that's usually the 
-head of "master", since that's what you just tried to boot and failed at). 
-Also, figure out the most recent known-good commit (usually the _previous_ 
-kernel you ran: and if you've only done a single "pull" in between, it 
-will be ORIG_HEAD).
-
-Then do
-
-	git bisect start
-	git bisect bad master		<- mark "master" as the bad state
-	git bisect good ORIG_HEAD	<- mark ORIG_HEAD as good (or
-					   whatever other known-good 
-					   thing you booted last)
-
-and at this point "git bisect" will churn for a while, and tell you what 
-the mid-point between those two commits are, and check that state out as 
-the head of the new "bisect" branch.
-
-Compile and reboot.
-
-If it's good, just do
-
-	git bisect good		<- mark current head as good
-
-otherwise, reboot into a good kernel instead, and do (surprise surprise, 
-git really is very intuitive):
-
-	git bisect bad		<- mark current head as bad
-
-and whatever you do, git will select a new half-way point. Do this for a 
-while, until git tells you exactly which commit was the first bad commit. 
-That's your culprit.
-
-It really works wonderfully well, except for the case where there was 
-_another_ commit that broke something in between, like introduced some 
-stupid compile error. In that case you should not mark that commit good or 
-bad: you should try to find another commit close-by, and do a "git reset 
---hard <newcommit>" to try out _that_ commit instead, and then test that 
-instead (and mark it good or bad).
-
-You can do "git bisect visualize" while you do all this to see what's 
-going on by starting up gitk on the bisection range.
-
-Finally, once you've figured out exactly which commit was bad, you can 
-then go back to the master branch, and try reverting just that commit:
-
-	git checkout master
-	git revert <bad-commit-id>
-
-to verify that the top-of-kernel works with that single commit reverted.
-
-- 
1.5.1.4.19.g69e2
