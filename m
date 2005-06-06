From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-whatchanged vs "cvs annotate"
Date: Sun, 05 Jun 2005 17:46:06 -0700
Message-ID: <7vekbgwbw1.fsf_-_@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
	<7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 02:43:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df5hc-0000PU-UU
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 02:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFFAqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 20:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFFAqX
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 20:46:23 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:29385 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261153AbVFFAqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 20:46:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050606004607.EORB20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 20:46:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 5 Jun 2005 17:02:41 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Let's just be upfront about some things being missing, and suggest
LT> alternatives.

I agree that being honest is good.  Something like this?
------------
This adds a section to talk about "cvs annotate".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/cvs-migration.txt |  105 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/cvs-migration.txt
@@ -0,0 +1,105 @@
+CVS annotate.
+
+The core GIT itself does not have a "cvs annotate" equivalent.
+It has something that you may want to use when you would use
+"cvs annotate".
+
+Let's step back a bit and think about the reason why you would
+want to do "cvs annotate a-file.c" to begin with.
+
+You would use "cvs annotate" on a file when you have trouble
+with a function (or even a single "if" statement in a function)
+that happens to be defined in the file, which does not do what
+you want it to do.  And you would want to find out why it was
+written that way, because you are about to modify it to suit
+your needs, and at the same time you do not want to break its
+current callers.  For that, you are trying to find out why the
+original author did things that way in the original context.
+
+Many times, it may be enough to see the commit log messages of
+commits that touch the file in question, possibly along with the
+patches themselves, like this:
+
+	$ git-whatchanged -p a-file.c
+
+This will show log messages and patches for each commit that
+touches a-file.
+
+This, however, may not be very useful when this file has many
+modifications that are not related to the piece of code you are
+interested in.  You would see many log messages and patches that
+do not have anything to do with the piece of code you are
+interested in.  As an example, assuming that you have this piece
+code that you are interested in in the HEAD version:
+
+	if (frotz) {
+		nitfol();
+	}
+
+you would use git-rev-list and git-diff-tree like this:
+
+	$ git-rev-list HEAD |
+	  git-diff-tree --stdin -v -p -S'if (frotz) {
+		nitfol();
+	}'
+
+We have already talked about the "--stdin" form of git-diff-tree
+command that reads the list of commits and compares each commit
+with its parents.  The git-whatchanged command internally runs
+the equivalent of the above command, and can be used like this:
+
+	$ git-whatchanged -p -S'if (frotz) {
+		nitfol();
+	}'
+
+When the -S option is used, git-diff-tree command outputs
+differences between two commits only if one tree has the
+specified string in a file and the corresponding file in the
+other tree does not.  The above example looks for a commit that
+has the "if" statement in it in a file, but its parent commit
+does not have it in the same shape in the corresponding file (or
+the other way around, where the parent has it and the commit
+does not), and the differences between them are shown, along
+with the commit message (thanks to the -v flag).  It does not
+show anything for commits that do not touch this "if" statement.
+
+Also, in the original context, the same statement might have
+appeared at first in a different file and later the file was
+renamed to "a-file.c".  CVS annotate would not help you to go
+back across such a rename, but GIT would still help you in such
+a situation.  For that, you can give the -C flag to
+git-diff-tree, like this:
+
+	$ git-whatchanged -p -C -S'if (frotz) {
+		nitfol();
+	}'
+
+When the -C flag is used, file renames and copies are followed.
+So if the "if" statement in question happens to be in "a-file.c"
+in the current HEAD commit, even if the file was originally
+called "o-file.c" and then renamed in an earlier commit, or if
+the file was created by copying an existing "o-file.c" in an
+earlier commit, you will not lose track.  If the "if" statement
+did not change across such rename or copy, then the commit that
+does rename or copy would not show in the output, and if the
+"if" statement was modified while the file was still called
+"o-file.c", it would find the commit that changed the statement
+when it was in "o-file.c".
+
+[ BTW, the current versions of "git-diff-tree -C" is not eager
+  enough to find copies, and it will miss the fact that a-file.c
+  was created by copying o-file.c unless o-file.c was somehow
+  changed in the same commit.]
+
+You can use the --pickaxe-all flag in addition to the -S flag.
+This causes the differences from all the files contained in
+those two commits, not just the differences between the files
+that contain this changed "if" statement:
+
+	$ git-whatchanged -p -C -S'if (frotz) {
+		nitfol();
+	}' --pickaxe-all
+
+[ Side note.  This option is called "--pickaxe-all" because -S
+  option is internally called "pickaxe", a tool for software
+  archaeologists.]
------------

