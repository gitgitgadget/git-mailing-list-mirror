From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: describe diff tweaking.
Date: Sun, 05 Jun 2005 14:30:58 -0700
Message-ID: <7vr7fg1ofh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 23:28:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df2eq-00040y-OV
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 23:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVFEVbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 17:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVFEVbV
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 17:31:21 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11775 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261606AbVFEVbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 17:31:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605213057.SEIC19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 17:30:57 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds documentation for the diffcore mechanism and explains
how numeric parameters to -B/-C/-M options affect the output,
which was left "black magic" so far.

The documentation is not connected to any of the other asciidoc
nodes yet.  Awaiting for suggestions, fixes and help from other
people.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/diffcore.txt |  241 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 241 insertions(+), 0 deletions(-)

diff --git a/Documentation/diffcore.txt b/Documentation/diffcore.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/diffcore.txt
@@ -0,0 +1,241 @@
+Tweaking diff output
+====================
+June 2005
+
+
+Introduction
+------------
+
+The diff commands git-diff-cache, git-diff-files, and
+git-diff-tree can be told to manipulate differences they find
+in unconventional ways before showing diff(1) output.  The
+manipulation is collectively called "diffcore transformation".
+This short note describes what they are and how to use them to
+produce diff outputs that are easier to understand than the
+conventional kind.
+
+
+The chain of operation
+----------------------
+
+The git-diff-* family works by first comparing two sets of
+files:
+
+ - git-diff-cache compares contents of a "tree" object and the
+   working directory (when --cached flag is not used) or a
+   "tree" object and the index file (when --cached flag is
+   used);
+
+ - git-diff-files compares contents of the index file and the
+   working directory;
+
+ - git-diff-tree compares contents of two "tree" objects.
+
+In all of these cases, the commands themselves compare
+corresponding paths in the two sets of files.  The result of
+comparison is passed from these commands to what is internally
+called "diffcore", in a format similar to what is output when
+the -p option is not used.  E.g.
+
+    in-place edit  :100644 100644 bcd1234... 0123456... M file0
+    create         :000000 100644 0000000... 1234567... N file4
+    delete         :100644 000000 1234567... 0000000... D file5
+    unmerged       :000000 000000 0000000... 0000000... U file6
+
+The diffcore mechanism is fed a list of such comparison results
+(each of which is called "filepair", although at this point each
+of them talks about a single file), and transforms such a list
+into another list.  There are currently 7 such transformations:
+
+ - diffcore-pathspec
+ - diffcore-break
+ - diffcore-rename
+ - diffcore-merge-broken
+ - diffcore-pickaxe
+ - diffcore-order
+
+These are applied in sequence.  The set of filepairs git-diff-*
+commands find are used as the input to diffcore-pathspec, and
+the output from diffcore-pathspec is used as the input to the
+next transformation.  The final result is then passed to the
+output routine and generates either diff-raw format (see Output
+format sections of the manual for git-diff-* commands) or
+diff-patch format.
+
+
+diffcore-pathspec
+-----------------
+
+The first transformation in the chain is diffcore-pathspec, and
+is controlled by giving the pathname parameters to the
+git-diff-* commands on the command line.  The pathspec is used
+to limit the world diff operates in.  It removes the filepairs
+outside the specified set of pathnames.
+
+Implementation note.  For performance reasons, git-diff-tree
+uses the pathname parameters on the command line to cull set of
+filepairs it feeds the diffcore mechanism itself, and does not
+use diffcore-pathspec, but the end result is the same.
+
+
+diffcore-break
+--------------
+
+The second transformation in the chain is diffcore-break, and is
+controlled by the -B option to the git-diff-* commands.  This is
+used to detect a filepair that represents "complete rewrite" and
+break such filepair into two filepairs that represent delete and
+create.  E.g.  If the input contained this filepair:
+
+    :100644 100644 bcd1234... 0123456... M file0
+
+and if it detects that the file "file0" is completely rewritten,
+it changes it to:
+
+    :100644 000000 bcd1234... 0000000... D file0
+    :000000 100644 0000000... 0123456... N file0
+
+For the purpose of breaking a filepair, diffcore-break examines
+the extent of changes between the contents of the files before
+and after modification (i.e. the contents that have "bcd1234..."
+and "0123456..." as their SHA1 content ID, in the above
+example).  The amount of deletion of original contents and
+insertion of new material are added together, and if it exceeds
+the "break score", the filepair is broken into two.  The break
+score defaults to 50% of the size of the smaller of the original
+and the result (i.e. if the edit shrinks the file, the size of
+the result is used; if the edit lengthens the file, the size of
+the original is used), and can be customized by giving a number
+after "-B" option (e.g. "-B75" to tell it to use 75%).
+
+
+diffcore-rename
+---------------
+
+This transformation is used to detect renames and copies, and is
+controlled by the -M option (to detect renames) and the -C option
+(to detect copies as well) to the git-diff-* commands.  If the
+input contained these filepairs:
+
+    :100644 000000 0123456... 0000000... D fileX
+    :000000 100644 0000000... 0123456... N file0
+
+and the contents of the deleted file fileX is similar enough to
+the contents of the created file file0, then rename detection
+merges these filepairs and creates:
+
+    :100644 100644 0123456... 0123456... R100 fileX file0
+
+When the "-C" option is used, the original contents of modified
+files and contents of unchanged files are considered as
+candidates of the source files in rename/copy operation, in
+addition to the deleted files.  If the input were like these
+filepairs, that talk about a modified file fileY and a newly
+created file file0:
+
+    :100644 100644 0123456... 1234567... M fileY
+    :000000 100644 0000000... 0123456... N file0
+
+the original contents of fileY and the resulting contents of
+file0 are compared, and if they are similar enough, they are
+changed to:
+
+    :100644 100644 0123456... 1234567... M fileY
+    :100644 100644 0123456... 0123456... C100 fileY file0
+
+In both rename and copy detection, the same "extent of changes"
+algorithm used in diffcore-break is used to determine if two
+files are "similar enough", and can be customized to use
+similarity score different from the default 50% by giving a
+number after "-M" or "-C" option (e.g. "-M8" to tell it to use
+8/10 = 80%).
+
+Note.  When the "-C" option is used, git-diff-cache and
+git-diff-file commands feed not just modified filepairs but
+unmodified ones to diffcore mechanism as well.  This lets the
+copy detector consider unmodified files as copy source
+candidates at the expense of making it slower.  Currently
+git-diff-tree does not feed unmodified filepairs even when the
+"-C" option is used, so it can detect copies only if the file
+that was copied happened to have been modified in the same
+changeset.
+
+
+diffcore-merge-broken
+---------------------
+
+This transformation is used to merge filepairs broken by
+diffcore-break, and were not transformed into rename/copy by
+diffcore-rename, back into a single modification.  This always
+runs when diffcore-break is used.
+
+For the purpose of merging broken filepairs back, it uses a
+different "extent of changes" computation from the ones used by
+diffcore-break and diffcore-rename.  It counts only the deletion
+from the original, and does not count insertion.  If you removed
+only 10 lines from a 100-line document, even if you added 910
+new lines to make a new 1000-line document, you did not do a
+complete rewrite.  diffcore-break breaks such a case in order to
+help diffcore-rename to consider such filepairs as candidate of
+rename/copy detection, but if filepairs broken that way were not
+matched with other filepairs to create rename/copy, then this
+transformation merges them back into the original
+"modification".
+
+The "extent of changes" parameter can be tweaked from the
+default 80% (that is, unless more than 80% of the original
+material is deleted, the broken pairs are merged back into a
+single modification) by giving a second number to -B option,
+like these:
+
+	-B50/60 (give 50% "break score" to diffcore-break, use
+                 60% for diffcore-merge-broken).
+	-B/60   (the same as above, since diffcore-break defautls to
+		 50%).
+
+
+diffcore-pickaxe
+----------------
+
+This transformation is used to find filepairs that represent
+changes that touch a specified string, and is controlled by the
+-S option and the --pickaxe-all option to the git-diff-*
+commands.
+
+When diffcore-pickaxe is in use, it checks if there are
+filepairs whose "original" side has the specified string and
+whose "result" side does not.  Such a filepair represents "the
+string appeared in this changeset".  It also checks for the
+opposite case that loses the specified string.
+
+When --pickaxe-all is not in effect, diffcore-pickaxe leaves
+only such filepairs that touches the specified string in its
+output.  When --pickaxe-all is used, diffcore-pickaxe leaves all
+filepairs intact if there is such a filepair, or makes the
+output empty otherwise.  The latter behaviour is designed to
+make reviewing of the changes in the context of the whole
+changeset easier.
+
+
+diffcore-order
+--------------
+
+This is used to reorder the filepairs according to the user's
+(or project's) taste, and is controlled by the -O option to the
+git-diff-* commands.
+
+This takes a text file each of whose line is a shell glob
+pattern.  Filepairs that match a glob pattern on an earlier line
+in the file are output before ones that match a later line, and
+filepairs that do not match any glob pattern are output last.
+
+As an example, typical orderfile for the core GIT probably
+should look like this:
+
+    README
+    Makefile
+    Documentation
+    *.h
+    *.c
+    t
+
------------

