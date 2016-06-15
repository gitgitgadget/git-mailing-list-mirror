From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: (unknown)
Date: Sun, 21 May 2006 19:53:28 -0400
Message-ID: <1148255528.61d5d241.2@fieldses.org>
References: <1148255528.61d5d241.1@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 01:53:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhxjz-00006A-N4
	for gcvg-git@gmane.org; Mon, 22 May 2006 01:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWEUXxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 19:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWEUXxk
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 19:53:40 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34737 "EHLO
	puzzle.fieldses.org") by vger.kernel.org with ESMTP id S964952AbWEUXxj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 19:53:39 -0400
Received: from bfields by puzzle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1Fhxjk-00066H-QZ; Sun, 21 May 2006 19:53:28 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <1148255528.61d5d241.1@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20468>

>From nobody Mon Sep 17 00:00:00 2001
From: J. Bruce Fields <bfields@citi.umich.edu>
Date: Sun, 21 May 2006 19:49:34 -0400
Subject: [PATCH 3/3] tutorial: add discussion of index file, object database

Add a sequel to tutorial.txt which discusses the index file and
the object database.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

e84a9b9a34794c5b9dd36f6ccc11e60daecd3003
 Documentation/Makefile       |    1 
 Documentation/tutorial-2.txt |  391 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/tutorial.txt   |   28 ++-
 3 files changed, 414 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/tutorial-2.txt

e84a9b9a34794c5b9dd36f6ccc11e60daecd3003
diff --git a/Documentation/Makefile b/Documentation/Makefile
index c1af22c..2a08f59 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -7,6 +7,7 @@ MAN7_TXT=git.txt
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
 
 ARTICLES = tutorial
+ARTICLES += tutorial-2
 ARTICLES += core-tutorial
 ARTICLES += cvs-migration
 ARTICLES += diffcore
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
new file mode 100644
index 0000000..a3d45ee
--- /dev/null
+++ b/Documentation/tutorial-2.txt
@@ -0,0 +1,391 @@
+A tutorial introduction to git: part two
+========================================
+
+You should work through link:tutorial.html[A tutorial introduction to
+git] before reading this tutorial.
+
+The goal of this tutorial is to introduce two fundamental pieces of
+git's architecture--the object database and the index file--and to
+provide the reader with everything necessary to understand the rest
+of the git documentation.
+
+The git object database
+-----------------------
+
+Let's start a new project and create a small amount of history:
+
+------------------------------------------------
+$ mkdir test-project
+$ cd test-project
+$ git init-db
+defaulting to local storage area
+$ echo 'hello world' > file.txt
+$ git add .
+$ git commit -a -m "initial commit"
+Committing initial tree 92b8b694ffb1675e5975148e1121810081dbdffe
+$ echo 'hello world!' >file.txt
+$ git commit -a -m "add emphasis"
+------------------------------------------------
+
+What are the 40 digits of hex that git responded to the first commit
+with?
+
+We saw in part one of the tutorial that commits have names like this.
+It turns out that every object in the git history is stored under
+such a 40-digit hex name.  That name is the SHA1 hash of the object's
+contents; among other things, this ensures that git will never store
+the same data twice (since identical data is given an identical SHA1
+name), and that the contents of a git object will never change (since
+that would change the object's name as well).
+
+We can ask git about this particular object with the cat-file
+command--just cut-and-paste from the reply to the initial commit, to
+save yourself typing all 40 hex digits:
+
+------------------------------------------------
+$ git cat-file -t 92b8b694ffb1675e5975148e1121810081dbdffe
+tree
+------------------------------------------------
+
+A tree can refer to one or more "blob" objects, each corresponding to
+a file.  In addition, a tree can also refer to other tree objects,
+thus creating a directory heirarchy.  You can examine the contents of
+any tree using ls-tree (remember that a long enough initial portion
+of the SHA1 will also work):
+
+------------------------------------------------
+$ git ls-tree 92b8b694
+100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad    file.txt
+------------------------------------------------
+
+Thus we see that this tree has one file in it.  The SHA1 hash is a
+reference to that file's data:
+
+------------------------------------------------
+$ git cat-file -t 3b18e512
+blob
+------------------------------------------------
+
+A "blob" is just file data, which we can also examine with cat-file:
+
+------------------------------------------------
+$ git cat-file blob 3b18e512
+hello world
+------------------------------------------------
+
+Note that this is the old file data; so the object that git named in
+its response to the initial tree was a tree with a snapshot of the
+directory state that was recorded by the first commit.
+
+All of these objects are stored under their SHA1 names inside the git
+directory:
+
+------------------------------------------------
+$ find .git/objects/
+.git/objects/
+.git/objects/pack
+.git/objects/info
+.git/objects/3b
+.git/objects/3b/18e512dba79e4c8300dd08aeb37f8e728b8dad
+.git/objects/92
+.git/objects/92/b8b694ffb1675e5975148e1121810081dbdffe
+.git/objects/54
+.git/objects/54/196cc2703dc165cbd373a65a4dcf22d50ae7f7
+.git/objects/a0
+.git/objects/a0/423896973644771497bdc03eb99d5281615b51
+.git/objects/d0
+.git/objects/d0/492b368b66bdabf2ac1fd8c92b39d3db916e59
+.git/objects/c4
+.git/objects/c4/d59f390b9cfd4318117afde11d601c1085f241
+------------------------------------------------
+
+and the contents of these files is just the compressed data plus a
+header identifying their length and their type.  The type is either a
+blob, a tree, a commit, or a tag.  We've seen a blob and a tree now,
+so next we should look at a commit.
+
+The simplest commit to find is the HEAD commit, which we can find
+from .git/HEAD:
+
+------------------------------------------------
+$ cat .git/HEAD
+ref: refs/heads/master
+------------------------------------------------
+
+As you can see, this tells us which branch we're currently on, and it
+tells us this by naming a file under the .git directory, which itself
+contains a SHA1 name referring to a commit object, which we can
+examine with cat-file:
+
+------------------------------------------------
+$ cat .git/refs/heads/master
+c4d59f390b9cfd4318117afde11d601c1085f241
+$ git cat-file -t c4d59f39
+commit
+$ git cat-file commit c4d59f39
+tree d0492b368b66bdabf2ac1fd8c92b39d3db916e59
+parent 54196cc2703dc165cbd373a65a4dcf22d50ae7f7
+author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143418702 -0500
+committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143418702 -0500
+
+add emphasis
+------------------------------------------------
+
+The "tree" object here refers to the new state of the tree:
+
+------------------------------------------------
+$ git ls-tree d0492b36
+100644 blob a0423896973644771497bdc03eb99d5281615b51    file.txt
+$ git cat-file commit a0423896
+hello world!
+------------------------------------------------
+
+and the "parent" object refers to the previous commit:
+
+------------------------------------------------
+$ git-cat-file commit 54196cc2
+tree 92b8b694ffb1675e5975148e1121810081dbdffe
+author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
+committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
+
+initial commit
+------------------------------------------------
+
+The tree object is the tree we examined first, and this commit is
+unusual in that it lacks any parent.
+
+Most commits have only one parent, but it is also common for a commit
+to have multiple parents.   In that case the commit represents a
+merge, with the parent references pointing to the heads of the merged
+branches.
+
+Besides blobs, trees, and commits, the only remaining type of object
+is a "tag", which we won't discuss here; refer to gitlink:git-tag[1]
+for details.
+
+So now we know how git uses the object database to represent a
+project's history:
+
+  * "commit" objects refer to "tree" objects representing the
+    snapshot of a directory tree at a particular point in the
+    history, and refer to "parent" commits to show how they're
+    connected into the project history.
+  * "tree" objects represent the state of a single directory,
+    associating directory names to "blob" objects containing file
+    data and "tree" objects containing subdirectory information.
+  * "blob" objects contain file data without any other structure.
+  * References to commit objects at the head of each branch are
+    stored in files under .git/refs/heads/.
+  * The name of the current branch is stored in .git/HEAD.
+
+Note, by the way, that lots of commands take a tree as an argument.
+But as we can see above, a tree can be referred to in many different
+ways--by the SHA1 name for that tree, by the name of a commit that
+refers to the tree, by the name of a branch whose head refers to that
+tree, etc.--and most such commands can accept any of these names.
+
+In command synopses, the word "tree-ish" is sometimes used to
+designate such an argument.
+
+The index file
+--------------
+
+The primary tool we've been using to create commits is "git commit
+-a", which creates a commit including every change you've made to
+your working tree.  But what if you want to commit changes only to
+certain files?  Or only certain changes to certain files?
+
+If we look at the way commits are created under the cover, we'll see
+that there are more flexible ways creating commits.
+
+Continuing with our test-project, let's modify file.txt again:
+
+------------------------------------------------
+$ echo "hello world, again" >>file.txt
+------------------------------------------------
+
+but this time instead of immediately making the commit, let's take an
+intermediate step, and ask for diffs along the way to keep track of
+what's happening:
+
+------------------------------------------------
+$ git diff
+--- a/file.txt
++++ b/file.txt
+@@ -1 +1,2 @@
+ hello world!
+ +hello world, again
+$ git update-index file.txt
+$ git diff
+------------------------------------------------
+
+The last diff is empty, but no new commits have been made, and the
+head still doesn't contain the new line:
+
+------------------------------------------------
+$ git-diff HEAD
+diff --git a/file.txt b/file.txt
+index a042389..513feba 100644
+--- a/file.txt
++++ b/file.txt
+@@ -1 +1,2 @@
+ hello world!
+ +hello world, again
+------------------------------------------------
+
+So "git diff" is comparing against something other than the head.
+The thing that it's comparing against is actually the index file,
+which is stored in .git/index in a binary format, but whose contents
+we can examine with ls-files:
+
+------------------------------------------------
+$ git ls-files --stage
+100644 513feba2e53ebbd2532419ded848ba19de88ba00 0       file.txt
+$ git cat-file -t 513feba2
+blob
+$ git cat-file blob 513feba2
+hello world, again
+------------------------------------------------
+
+So what our "git update-index" did was store a new blob and then put
+a reference to it in the index file.  If we modify the file again,
+we'll see that the new modifications are reflected in the "git-diff"
+output:
+
+------------------------------------------------
+$ echo 'again?' >>file.txt
+$ git diff
+index 513feba..ba3da7b 100644
+--- a/file.txt
++++ b/file.txt
+@@ -1,2 +1,3 @@
+ hello world!
+ hello world, again
++again?
+------------------------------------------------
+
+With the right arguments, git diff can also show us the difference
+between the working directory and the last commit, or between the
+index and the last commit:
+
+------------------------------------------------
+$ git diff HEAD
+diff --git a/file.txt b/file.txt
+index a042389..ba3da7b 100644
+--- a/file.txt
++++ b/file.txt
+@@ -1 +1,3 @@
+ hello world!
++hello world, again
++again?
+$ git diff --cached
+diff --git a/file.txt b/file.txt
+index a042389..513feba 100644
+--- a/file.txt
++++ b/file.txt
+@@ -1 +1,2 @@
+ hello world!
++hello world, again
+------------------------------------------------
+
+At any time, we can create a new commit using "git commit" (without
+the -a option), and verify that the state committed only includes the
+changes stored in the index file, not the additional change that is
+still only in our working tree:
+
+------------------------------------------------
+$ git commit -m "repeat"
+$ git diff HEAD
+diff --git a/file.txt b/file.txt
+index 513feba..ba3da7b 100644
+--- a/file.txt
++++ b/file.txt
+@@ -1,2 +1,3 @@
+ hello world!
+ hello world, again
++again?
+------------------------------------------------
+
+So by default "git commit" uses the index to create the commit, not
+the working tree; the -a option to commit tells it to first update
+the index with all changes in the working tree.
+
+Finally, it's worth looking at the effect of "git add" on the index
+file:
+
+------------------------------------------------
+$ echo "goodbye, world" >closing.txt
+$ git add closing.txt
+------------------------------------------------
+
+The effect of the "git add" was to add one entry to the index file:
+
+------------------------------------------------
+$ git ls-files --stage
+100644 8b9743b20d4b15be3955fc8d5cd2b09cd2336138 0       closing.txt
+100644 513feba2e53ebbd2532419ded848ba19de88ba00 0       file.txt
+------------------------------------------------
+
+And, as you can see with cat-file, this new entry refers to the
+current contents of the file:
+
+------------------------------------------------
+$ git cat-file blob a6b11f7a
+goodbye, word
+------------------------------------------------
+
+The "status" command is a useful way to get a quick summary of the
+situation:
+
+------------------------------------------------
+$ git status
+#
+# Updated but not checked in:
+#   (will commit)
+#
+#       new file: closing.txt
+#
+#
+# Changed but not updated:
+#   (use git-update-index to mark for commit)
+#
+#       modified: file.txt
+#
+------------------------------------------------
+
+Since the current state of closing.txt is cached in the index file,
+it is listed as "updated but not checked in".  Since file.txt has
+changes in the working directory that aren't reflected in the index,
+it is marked "changed but not updated".  At this point, running "git
+commit" would create a commit that added closing.txt (with its new
+contents), but that didn't modify file.txt.
+
+Also, note that a bare "git diff" shows the changes to file.txt, but
+not the addition of closing.txt, because the version of closing.txt
+in the index file is identical to the one in the working directory.
+
+In addition to being the staging area for new commits, the index file
+is also populated from the object database when checking out a
+branch, and is used to hold the trees involved in a merge operation.
+See the link:core-tutorial.txt[core tutorial] and the relevant man
+pages for details.
+
+What next?
+----------
+
+At this point you should know everything necessary to read the man
+pages for any of the git commands; one good place to start would be
+with the commands mentioned in link:everday.html[Everyday git].  You
+should be able to find any unknown jargon in the
+link:glossary.html[Glosssay].
+
+The link:cvs-migration.html[CVS migration] document explains how to
+import a CVS repository into git, and shows how to use git in a
+CVS-like way.
+
+For some interesting examples of git use, see the
+link:howto-index.html[howtos].
+
+For git developers, the link:core-tutorial.html[Core tutorial] goes
+into detail on the lower-level git mechanisms involved in, for
+example, creating a new commit.
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 4c298c6..79781ad 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -442,7 +442,25 @@ fo the file:
 Next Steps
 ----------
 
-Some good commands to explore next:
+This tutorial should be enough to perform basic distributed revision
+control for your projects.  However, to fully understand the depth
+and power of git you need to understand two simple ideas on which it
+is based:
+
+  * The object database is the rather elegant system used to
+    store the history of your project--files, directories, and
+    commits.
+
+  * The index file is a cache of the state of a directory tree,
+    used to create commits, check out working directories, and
+    hold the various trees involved in a merge.
+
+link:tutorial-2.html[Part two of this tutorial] explains the object
+database, the index file, and a few other odds and ends that you'll
+need to make the most of git.
+
+If you don't want to consider with that right away, a few other
+digressions that may be interesting at this point are:
 
   * gitlink:git-format-patch[1], gitlink:git-am[1]: These convert
     series of git commits into emailed patches, and vice versa,
@@ -456,8 +474,6 @@ Some good commands to explore next:
     smart enough to perform a close-to-optimal search even in the
     case of complex non-linear history with lots of merged branches.
 
-Other good starting points include link:everyday.html[Everday GIT
-with 20 Commands Or So] and link:cvs-migration.html[git for CVS
-users].  Also, link:core-tutorial.html[A short git tutorial] gives an
-introduction to lower-level git commands for advanced users and
-developers.
+  * link:everyday.html[Everday GIT with 20 Commands Or So]
+
+  * link:cvs-migration.html[git for CVS users].
-- 
1.3.3.gff62
