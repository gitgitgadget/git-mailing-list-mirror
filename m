X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Documentation: reorganize cvs-migration.txt
Date: Wed, 6 Dec 2006 23:18:05 -0500
Message-ID: <20061207041805.GC3457@fieldses.org>
References: <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org> <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061206171950.GD1714@fieldses.org> <20061206172450.GE1714@fieldses.org> <7v7ix47wbr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 04:18:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v7ix47wbr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33549>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsAi7-00069p-0Y for gcvg-git@gmane.org; Thu, 07 Dec
 2006 05:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968718AbWLGESK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 23:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968717AbWLGESK
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 23:18:10 -0500
Received: from mail.fieldses.org ([66.93.2.214]:57597 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968715AbWLGESI (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 23:18:08 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GsAhx-0001p1-EB; Wed, 06 Dec 2006
 23:18:05 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Modify cvs-migration.txt so it explains first how to develop against a
shared repository, then how to set up a shared repository, then how to
import a repository from cvs.  Though this seems chronologically
backwards, it's still readable in this order, and it puts the more
commonly needed material closer to the front.

Remove the annotate/pickaxe section; perhaps it can find a place elsewhere
in the future.  Remove most of the "why git is better than cvs" stuff from
the introduction.

Add some minor clarifications, including two that have come up several
times on the mailing list:

	1. Recommend committing any changes before running pull.
	2. Note that changes must be commited before they can be pushed.

Update the clone discussion to reflect the new --use-separate-remotes
default, and add a brief mention of git-cvsserver.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/cvs-migration.txt |  349 ++++++++++++---------------------------
 1 files changed, 109 insertions(+), 240 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 6812683..773fc99 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -1,113 +1,21 @@
 git for CVS users
 =================
 
-So you're a CVS user. That's OK, it's a treatable condition.  The job of
-this document is to put you on the road to recovery, by helping you
-convert an existing cvs repository to git, and by showing you how to use a
-git repository in a cvs-like fashion.
+Git differs from CVS in that every working tree contains a repository with
+a full copy of the project history, and no repository is inherently more
+important than any other.  However, you can emulate the CVS model by
+designating a single shared repository which people can synchronize with;
+this document explains how to do that.
 
 Some basic familiarity with git is required.  This
 link:tutorial.html[tutorial introduction to git] should be sufficient.
 
-First, note some ways that git differs from CVS:
-
-  * Commits are atomic and project-wide, not per-file as in CVS.
-
-  * Offline work is supported: you can make multiple commits locally,
-    then submit them when you're ready.
-
-  * Branching is fast and easy.
-
-  * Every working tree contains a repository with a full copy of the
-    project history, and no repository is inherently more important than
-    any other.  However, you can emulate the CVS model by designating a
-    single shared repository which people can synchronize with; see below
-    for details.
-
-Importing a CVS archive
------------------------
-
-First, install version 2.1 or higher of cvsps from
-link:http://www.cobite.com/cvsps/[http://www.cobite.com/cvsps/] and make
-sure it is in your path.  The magic command line is then
-
--------------------------------------------
-$ git cvsimport -v -d <cvsroot> -C <destination> <module>
--------------------------------------------
-
-This puts a git archive of the named CVS module in the directory
-<destination>, which will be created if necessary.  The -v option makes
-the conversion script very chatty.
-
-The import checks out from CVS every revision of every file.  Reportedly
-cvsimport can average some twenty revisions per second, so for a
-medium-sized project this should not take more than a couple of minutes.
-Larger projects or remote repositories may take longer.
-
-The main trunk is stored in the git branch named `origin`, and additional
-CVS branches are stored in git branches with the same names.  The most
-recent version of the main trunk is also left checked out on the `master`
-branch, so you can start adding your own changes right away.
-
-The import is incremental, so if you call it again next month it will
-fetch any CVS updates that have been made in the meantime.  For this to
-work, you must not modify the imported branches; instead, create new
-branches for your own changes, and merge in the imported branches as
-necessary.
-
-Development Models
-------------------
-
-CVS users are accustomed to giving a group of developers commit access to
-a common repository.  In the next section we'll explain how to do this
-with git.  However, the distributed nature of git allows other development
-models, and you may want to first consider whether one of them might be a
-better fit for your project.
-
-For example, you can choose a single person to maintain the project's
-primary public repository.  Other developers then clone this repository
-and each work in their own clone.  When they have a series of changes that
-they're happy with, they ask the maintainer to pull from the branch
-containing the changes.  The maintainer reviews their changes and pulls
-them into the primary repository, which other developers pull from as
-necessary to stay coordinated.  The Linux kernel and other projects use
-variants of this model.
-
-With a small group, developers may just pull changes from each other's
-repositories without the need for a central maintainer.
-
-Emulating the CVS Development Model
+Developing against a CVS repository
 -----------------------------------
 
-Start with an ordinary git working directory containing the project, and
-remove the checked-out files, keeping just the bare .git directory:
-
-------------------------------------------------
-$ mv project/.git /pub/repo.git
-$ rm -r project/
-------------------------------------------------
-
-Next, give every team member read/write access to this repository.  One
-easy way to do this is to give all the team members ssh access to the
-machine where the repository is hosted.  If you don't want to give them a
-full shell on the machine, there is a restricted shell which only allows
-users to do git pushes and pulls; see gitlink:git-shell[1].
-
-Put all the committers in the same group, and make the repository
-writable by that group:
-
-------------------------------------------------
-$ chgrp -R $group repo.git
-$ find repo.git -mindepth 1 -type d |xargs chmod ug+rwx,g+s
-$ GIT_DIR=repo.git git repo-config core.sharedrepository true
-------------------------------------------------
-
-Make sure committers have a umask of at most 027, so that the directories
-they create are writable and searchable by other group members.
-
-Suppose this repository is now set up in /pub/repo.git on the host
+Suppose a shared repository is set up in /pub/repo.git on the host
 foo.com.  Then as an individual committer you can clone the shared
-repository:
+repository over ssh with:
 
 ------------------------------------------------
 $ git clone foo.com:/pub/repo.git/ my-project
@@ -121,7 +29,8 @@ $ git pull origin
 ------------------------------------------------
 
 which merges in any work that others might have done since the clone
-operation.
+operation.  If there are uncommitted changes in your working tree, commit
+them first before running git pull.
 
 [NOTE]
 ================================
@@ -129,20 +38,22 @@ The first `git clone` places the following in the
 `my-project/.git/remotes/origin` file, and that's why the previous step
 and the next step both work.
 ------------
-URL: foo.com:/pub/project.git/ my-project
-Pull: master:origin
+URL: foo.com:/pub/project.git/
+Pull: refs/heads/master:refs/remotes/origin/master
 ------------
 ================================
 
-You can update the shared repository with your changes using:
+You can update the shared repository with your changes by first commiting
+your changes, and then using:
 
 ------------------------------------------------
 $ git push origin master
 ------------------------------------------------
 
-If someone else has updated the repository more recently, `git push`, like
-`cvs commit`, will complain, in which case you must pull any changes
-before attempting the push again.
+to "push" those commits to the shared repository.  If someone else has
+updated the repository more recently, `git push`, like `cvs commit`, will
+complain, in which case you must pull any changes before attempting the
+push again.
 
 In the `git push` command above we specify the name of the remote branch
 to update (`master`).  If we leave that out, `git push` tries to update
@@ -151,21 +62,76 @@ in the local repository.  So the last `push` can be done with either of:
 
 ------------
 $ git push origin
-$ git push repo.shared.xz:/pub/scm/project.git/
+$ git push foo.com:/pub/project.git/
 ------------
 
 as long as the shared repository does not have any branches
 other than `master`.
 
-[NOTE]
-============
-Because of this behavior, if the shared repository and the developer's
-repository both have branches named `origin`, then a push like the above
-attempts to update the `origin` branch in the shared repository from the
-developer's `origin` branch.  The results may be unexpected, so it's
-usually best to remove any branch named `origin` from the shared
-repository.
-============
+Setting Up a Shared Repository
+------------------------------
+
+We assume you have already created a git repository for your project,
+possibly created from scratch or from a tarball (see the
+link:tutorial.html[tutorial]), or imported from an already existing CVS
+repository (see the next section).
+
+If your project's working directory is /home/alice/myproject, you can
+create a shared repository at /pub/repo.git with:
+
+------------------------------------------------
+$ git clone -bare /home/alice/myproject /pub/repo.git
+------------------------------------------------
+
+Next, give every team member read/write access to this repository.  One
+easy way to do this is to give all the team members ssh access to the
+machine where the repository is hosted.  If you don't want to give them a
+full shell on the machine, there is a restricted shell which only allows
+users to do git pushes and pulls; see gitlink:git-shell[1].
+
+Put all the committers in the same group, and make the repository
+writable by that group:
+
+------------------------------------------------
+$ cd /pub
+$ chgrp -R $group repo.git
+$ find repo.git -mindepth 1 -type d |xargs chmod ug+rwx,g+s
+$ GIT_DIR=repo.git git repo-config core.sharedrepository true
+------------------------------------------------
+
+Make sure committers have a umask of at most 027, so that the directories
+they create are writable and searchable by other group members.
+
+Importing a CVS archive
+-----------------------
+
+First, install version 2.1 or higher of cvsps from
+link:http://www.cobite.com/cvsps/[http://www.cobite.com/cvsps/] and make
+sure it is in your path.  The magic command line is then
+
+-------------------------------------------
+$ git cvsimport -v -d <cvsroot> -C <destination> <module>
+-------------------------------------------
+
+This puts a git archive of the named CVS module in the directory
+<destination>, which will be created if necessary.  The -v option makes
+the conversion script very chatty.
+
+The import checks out from CVS every revision of every file.  Reportedly
+cvsimport can average some twenty revisions per second, so for a
+medium-sized project this should not take more than a couple of minutes.
+Larger projects or remote repositories may take longer.
+
+The main trunk is stored in the git branch named `origin`, and additional
+CVS branches are stored in git branches with the same names.  The most
+recent version of the main trunk is also left checked out on the `master`
+branch, so you can start adding your own changes right away.
+
+The import is incremental, so if you call it again next month it will
+fetch any CVS updates that have been made in the meantime.  For this to
+work, you must not modify the imported branches; instead, create new
+branches for your own changes, and merge in the imported branches as
+necessary.
 
 Advanced Shared Repository Management
 -------------------------------------
@@ -178,127 +144,30 @@ You can enforce finer grained permissions using update hooks.  See
 link:howto/update-hook-example.txt[Controlling access to branches using
 update hooks].
 
-CVS annotate
-------------
+Providing CVS Access to a git Repository
+----------------------------------------
+
+It is also possible to provide true CVS access to a git repository, so
+that developers can still use CVS; see gitlink:git-cvsserver[1] for
+details.
+
+Alternative Development Models
+------------------------------
+
+CVS users are accustomed to giving a group of developers commit access to
+a common repository.  As we've seen, this is also possible with git.
+However, the distributed nature of git allows other development models,
+and you may want to first consider whether one of them might be a better
+fit for your project.
+
+For example, you can choose a single person to maintain the project's
+primary public repository.  Other developers then clone this repository
+and each work in their own clone.  When they have a series of changes that
+they're happy with, they ask the maintainer to pull from the branch
+containing the changes.  The maintainer reviews their changes and pulls
+them into the primary repository, which other developers pull from as
+necessary to stay coordinated.  The Linux kernel and other projects use
+variants of this model.
 
-So, something has gone wrong, and you don't know whom to blame, and
-you're an ex-CVS user and used to do "cvs annotate" to see who caused
-the breakage. You're looking for the "git annotate", and it's just
-claiming not to find such a script. You're annoyed.
-
-Yes, that's right.  Core git doesn't do "annotate", although it's
-technically possible, and there are at least two specialized scripts out
-there that can be used to get equivalent information (see the git
-mailing list archives for details). 
-
-git has a couple of alternatives, though, that you may find sufficient
-or even superior depending on your use.  One is called "git-whatchanged"
-(for obvious reasons) and the other one is called "pickaxe" ("a tool for
-the software archaeologist"). 
-
-The "git-whatchanged" script is a truly trivial script that can give you
-a good overview of what has changed in a file or a directory (or an
-arbitrary list of files or directories).  The "pickaxe" support is an
-additional layer that can be used to further specify exactly what you're
-looking for, if you already know the specific area that changed.
-
-Let's step back a bit and think about the reason why you would
-want to do "cvs annotate a-file.c" to begin with.
-
-You would use "cvs annotate" on a file when you have trouble
-with a function (or even a single "if" statement in a function)
-that happens to be defined in the file, which does not do what
-you want it to do.  And you would want to find out why it was
-written that way, because you are about to modify it to suit
-your needs, and at the same time you do not want to break its
-current callers.  For that, you are trying to find out why the
-original author did things that way in the original context.
-
-Many times, it may be enough to see the commit log messages of
-commits that touch the file in question, possibly along with the
-patches themselves, like this:
-
-	$ git-whatchanged -p a-file.c
-
-This will show log messages and patches for each commit that
-touches a-file.
-
-This, however, may not be very useful when this file has many
-modifications that are not related to the piece of code you are
-interested in.  You would see many log messages and patches that
-do not have anything to do with the piece of code you are
-interested in.  As an example, assuming that you have this piece
-of code that you are interested in in the HEAD version:
-
-	if (frotz) {
-		nitfol();
-	}
-
-you would use git-rev-list and git-diff-tree like this:
-
-	$ git-rev-list HEAD |
-	  git-diff-tree --stdin -v -p -S'if (frotz) {
-		nitfol();
-	}'
-
-We have already talked about the "\--stdin" form of git-diff-tree
-command that reads the list of commits and compares each commit
-with its parents (otherwise you should go back and read the tutorial).
-The git-whatchanged command internally runs
-the equivalent of the above command, and can be used like this:
-
-	$ git-whatchanged -p -S'if (frotz) {
-		nitfol();
-	}'
-
-When the -S option is used, git-diff-tree command outputs
-differences between two commits only if one tree has the
-specified string in a file and the corresponding file in the
-other tree does not.  The above example looks for a commit that
-has the "if" statement in it in a file, but its parent commit
-does not have it in the same shape in the corresponding file (or
-the other way around, where the parent has it and the commit
-does not), and the differences between them are shown, along
-with the commit message (thanks to the -v flag).  It does not
-show anything for commits that do not touch this "if" statement.
-
-Also, in the original context, the same statement might have
-appeared at first in a different file and later the file was
-renamed to "a-file.c".  CVS annotate would not help you to go
-back across such a rename, but git would still help you in such
-a situation.  For that, you can give the -C flag to
-git-diff-tree, like this:
-
-	$ git-whatchanged -p -C -S'if (frotz) {
-		nitfol();
-	}'
-
-When the -C flag is used, file renames and copies are followed.
-So if the "if" statement in question happens to be in "a-file.c"
-in the current HEAD commit, even if the file was originally
-called "o-file.c" and then renamed in an earlier commit, or if
-the file was created by copying an existing "o-file.c" in an
-earlier commit, you will not lose track.  If the "if" statement
-did not change across such a rename or copy, then the commit that
-does rename or copy would not show in the output, and if the
-"if" statement was modified while the file was still called
-"o-file.c", it would find the commit that changed the statement
-when it was in "o-file.c".
-
-NOTE: The current version of "git-diff-tree -C" is not eager
-  enough to find copies, and it will miss the fact that a-file.c
-  was created by copying o-file.c unless o-file.c was somehow
-  changed in the same commit.
-
-You can use the --pickaxe-all flag in addition to the -S flag.
-This causes the differences from all the files contained in
-those two commits, not just the differences between the files
-that contain this changed "if" statement:
-
-	$ git-whatchanged -p -C -S'if (frotz) {
-		nitfol();
-	}' --pickaxe-all
-
-NOTE: This option is called "--pickaxe-all" because -S
-  option is internally called "pickaxe", a tool for software
-  archaeologists.
+With a small group, developers may just pull changes from each other's
+repositories without the need for a central maintainer.
-- 
1.4.4.1.GIT
