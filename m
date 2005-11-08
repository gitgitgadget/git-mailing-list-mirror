From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Add bug isolation howto, scraped from Linus.
Date: Mon, 07 Nov 2005 20:45:25 -0600
Message-ID: <E1EZJUD-0001yw-Io@jdl.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 03:46:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZJUT-0005dY-6e
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 03:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965684AbVKHCpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 21:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965686AbVKHCpd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 21:45:33 -0500
Received: from mail.jdl.com ([66.118.10.122]:48838 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S965684AbVKHCpc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 21:45:32 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EZJUD-0001yw-Io
	for git@vger.kernel.org; Mon, 07 Nov 2005 20:45:26 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11305>


Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

You know, eventually this will all be fully documented.
The trick is to catch Words To The Wise as the flow past you.


 Documentation/howto/isolate-bugs-with-bisect.txt |   65 ++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/howto/isolate-bugs-with-bisect.txt

applies-to: 71213f57daeac18b52439d6d8acd5baba9bf05c7
4e0819ff782b33d149634a397fb539f4759ef1f4
diff --git a/Documentation/howto/isolate-bugs-with-bisect.txt b/Documentation/howto/isolate-bugs-with-bisect.txt
new file mode 100644
index 0000000..4009495
--- /dev/null
+++ b/Documentation/howto/isolate-bugs-with-bisect.txt
@@ -0,0 +1,65 @@
+From:	Linus Torvalds <torvalds () osdl ! org>
+To:	git@vger.kernel.org
+Date:	2005-11-08 1:31:34
+Subject: Real-life kernel debugging scenario
+Abstract: Short-n-sweet, Linus tells us how to leverage `git-bisect` to perform
+	bug isolation on a repository where "good" and "bad" revisions are known
+	in order to identify a suspect commit.
+
+
+How To Use git-bisect To Isolate a Bogus Commit
+===============================================
+
+The way to use "git bisect" couldn't be easier.
+
+Figure out what the oldest bad state you know about is (that's usually the 
+head of "master", since that's what you just tried to boot and failed at). 
+Also, figure out the most recent known-good commit (usually the _previous_ 
+kernel you ran: and if you've only done a single "pull" in between, it 
+will be ORIG_HEAD).
+
+Then do
+
+	git bisect start
+	git bisect bad master		<- mark "master" as the bad state
+	git bisect good ORIG_HEAD	<- mark ORIG_HEAD as good (or
+					   whatever other known-good 
+					   thing you booted laste)
+
+and at this point "git bisect" will churn for a while, and tell you what 
+the mid-point between those two commits are, and check that state out as 
+the head of the bew "bisect" branch.
+
+Compile and reboot.
+
+If it's good, just do
+
+	git bisect good		<- mark current head as good
+
+otherwise, reboot into a good kernel instead, and do (surprise surprise, 
+git really is very intuitive):
+
+	git bisect bad		<- mark current head as bad
+
+and whatever you do, git will select a new half-way point. Do this for a 
+while, until git tells you exactly which commit was the first bad commit. 
+That's your culprit.
+
+It really works wonderfully well, except for the case where there was 
+_another_ commit that broke something in between, like introduced some 
+stupid compile error. In that case you should not mark that commit good or 
+bad: you should try to find another commit close-by, and do a "git reset 
+--hard <newcommit>" to try out _that_ commit instead, and then test that 
+instead (and mark it good or bad).
+
+You can do "git bisect visualize" while you do all this to see what's 
+going on by starting up gitk on the bisection range.
+
+Finally, once you've figured out exactly which commit was bad, you can 
+then go back to the master branch, and try reverting just that commit:
+
+	git checkout master
+	git revert <bad-commit-id>
+
+to verify that the top-of-kernel works with that single commit reverted.
+
---
0.99.9.GIT
