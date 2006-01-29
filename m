From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] cvs-migration documentation update
Date: Sat, 28 Jan 2006 23:31:47 -0500
Message-ID: <20060129043147.GA9581@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 05:31:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F34EG-0000X2-Lb
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 05:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWA2Ebx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 23:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWA2Ebw
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 23:31:52 -0500
Received: from mail.fieldses.org ([66.93.2.214]:49639 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750822AbWA2Ebv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 23:31:51 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F34E7-00034v-Ad; Sat, 28 Jan 2006 23:31:47 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15204>

Here's some changes to the cvs-migration.txt.  As usual, in my attempt
to make things clearer someone may have found I've made them less so, or
I may have just gotten something wrong; so any review is welcomed.

I can break up this sort of thing into smaller steps if preferred, the
monolothic patch is just a bit simpler for me for this sort of
thing.

I moved the material describing shared repository management from
core-tutorial.txt to cvs-migration.txt, where it seems more appropriate,
and combined two sections to eliminate some redundancy.

I also revised the earlier sections of cvs-migration.txt, mainly trying
to make it more concise.

I've left the last section of cvs-migration.txt (on CVS annotate
alternatives) alone for now.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

 Documentation/core-tutorial.txt |  118 -----------------
 Documentation/cvs-migration.txt |  276 +++++++++++++++++++++++----------------
 2 files changed, 167 insertions(+), 227 deletions(-)

bfa569527ebfa0388103c0619f15a2ee71ef3624
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 35579cc..4513ad6 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -1623,123 +1623,7 @@ suggested in the previous section may be
 have to worry. git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
-For this, set up a public repository on a machine that is
-reachable via SSH by people with "commit privileges".  Put the
-committers in the same user group and make the repository
-writable by that group.  Make sure their umasks are set up to
-allow group members to write into directories other members
-have created.
-
-You, as an individual committer, then:
-
-- First clone the shared repository to a local repository:
-------------------------------------------------
-$ git clone repo.shared.xz:/pub/scm/project.git/ my-project
-$ cd my-project
-$ hack away
-------------------------------------------------
-
-- Merge the work others might have done while you were hacking
-  away:
-------------------------------------------------
-$ git pull origin
-$ test the merge result
-------------------------------------------------
-[NOTE]
-================================
-The first `git clone` would have placed the following in
-`my-project/.git/remotes/origin` file, and that's why this and
-the next step work.
-------------
-URL: repo.shared.xz:/pub/scm/project.git/ my-project
-Pull: master:origin
-------------
-================================
-
-- push your work as the new head of the shared
-  repository.
-------------------------------------------------
-$ git push origin master
-------------------------------------------------
-If somebody else pushed into the same shared repository while
-you were working locally, `git push` in the last step would
-complain, telling you that the remote `master` head does not
-fast forward.  You need to pull and merge those other changes
-back before you push your work when it happens.
-
-The `git push` command without any explicit refspec parameter
-pushes the refs that exist both in the local repository and the
-remote repository.  So the last `push` can be done with either
-one of these:
-------------
-$ git push origin
-$ git push repo.shared.xz:/pub/scm/project.git/
-------------
-as long as the shared repository does not have any branches
-other than `master`.
-[NOTE]
-============
-If you created your shared repository by cloning from somewhere
-else, you may have the `origin` branch.  Your developers
-typically do not use that branch; remove it.  Otherwise, that
-would be pushed back by the `git push origin` because your
-developers' repository would surely have `origin` branch to keep
-track of the shared repository, and would be counted as "exist
-on both ends".
-============
-
-Advanced Shared Repository Management
--------------------------------------
-
-Being able to push into a shared repository means being able to
-write into it.  If your developers are coming over the network,
-this means you, as the repository administrator, need to give
-each of them an SSH access to the shared repository machine.
-
-In some cases, though, you may not want to give a normal shell
-account to them, but want to restrict them to be able to only
-do `git push` into the repository and nothing else.
-
-You can achieve this by setting the login shell of your
-developers on the shared repository host to `git-shell` program.
-
-[NOTE]
-Most likely you would also need to list `git-shell` program in
-`/etc/shells` file.
-
-This restricts the set of commands that can be run from incoming
-SSH connection for these users to only `receive-pack` and
-`upload-pack`, so the only thing they can do are `git fetch` and
-`git push`.
-
-You still need to create UNIX user accounts for each developer,
-and put them in the same group.  Make sure that the repository
-shared among these developers is writable by that group.
-
-. Initializing the shared repository with `git-init-db --shared`
-helps somewhat.
-
-. Run the following in the shared repository:
-+
-------------
-$ chgrp -R $group repo.git
-$ find repo.git -type d -print | xargs chmod ug+rwx,g+s
-$ GIT_DIR=repo.git git repo-config core.sharedrepository true
-------------
-
-The above measures make sure that directories lazily created in
-`$GIT_DIR` are writable by group members.  You, as the
-repository administrator, are still responsible to make sure
-your developers belong to that shared repository group and set
-their umask to a value no stricter than 027 (i.e. at least allow
-reading and searching by group members).
-
-You can implement finer grained branch policies using update
-hooks.  There is a document ("control access to branches") in
-Documentation/howto by Carl Baldwin and JC outlining how to (1)
-limit access to branch per user, (2) forbid overwriting existing
-tags.
-
+See link:cvs-migration.txt[git for CVS users] for the details.
 
 Bundling your work together
 ---------------------------
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 8fd1a33..2bd58d3 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -1,126 +1,182 @@
 git for CVS users
 =================
 
-Ok, so you're a CVS user. That's ok, it's a treatable condition, and the
-first step to recovery is admitting you have a problem. The fact that
-you are reading this file means that you may be well on that path
-already.
-
-The thing about CVS is that it absolutely sucks as a source control
-manager, and you'll thus be happy with almost anything else. git,
-however, may be a bit 'too' different (read: "good") for your taste, and
-does a lot of things differently. 
-
-One particular suckage of CVS is very hard to work around: CVS is
-basically a tool for tracking 'file' history, while git is a tool for
-tracking 'project' history.  This sometimes causes problems if you are
-used to doing very strange things in CVS, in particular if you're doing
-things like making branches of just a subset of the project.  git can't
-track that, since git never tracks things on the level of an individual
-file, only on the whole project level. 
-
-The good news is that most people don't do that, and in fact most sane
-people think it's a bug in CVS that makes it tag (and check in changes)
-one file at a time.  So most projects you'll ever see will use CVS
-'as if' it was sane.  In which case you'll find it very easy indeed to
-move over to git. 
-
-First off: this is not a git tutorial. See
-link:tutorial.html[Documentation/tutorial.txt] for how git
-actually works. This is more of a random collection of gotcha's
-and notes on converting from CVS to git.
-
-Second: CVS has the notion of a "repository" as opposed to the thing
-that you're actually working in (your working directory, or your
-"checked out tree").  git does not have that notion at all, and all git
-working directories 'are' the repositories.  However, you can easily
-emulate the CVS model by having one special "global repository", which
-people can synchronize with.  See details later, but in the meantime
-just keep in mind that with git, every checked out working tree will
-have a full revision control history of its own.
+So you're a CVS user. That's ok, it's a treatable condition.  The job of
+this document is to put you on the road to recovery, by helping you
+convert an existing cvs repository to git, and by showing you how to use a
+git repository in a cvs-like fashion.
 
+Some basic familiarity with git is required.  This
+link:tutorial.html[tutorial introduction to git] should be sufficient.
+
+First, note some ways that git differs from CVS:
+
+  * Commits are atomic and project-wide, not per-file as in CVS.
+
+  * Offline work is supported: you can make multiple commits locally,
+    then submit them when you're ready.
+
+  * Branching is fast and easy.
+
+  * Every working tree contains a repository with a full copy of the
+    project history, and no repository is inherently more important than
+    any other.  However, you can emulate the CVS model by designating a
+    single shared repository which people can synchronize with; see below
+    for details.
 
 Importing a CVS archive
 -----------------------
 
-Ok, you have an old project, and you want to at least give git a chance
-to see how it performs. The first thing you want to do (after you've
-gone through the git tutorial, and generally familiarized yourself with
-how to commit stuff etc in git) is to create a git'ified version of your
-CVS archive.
-
-Happily, that's very easy indeed. git will do it for you, although git
-will need the help of a program called "cvsps":
-
-	http://www.cobite.com/cvsps/
-
-which is not actually related to git at all, but which makes CVS usage
-look almost sane (ie you almost certainly want to have it even if you
-decide to stay with CVS). However, git will want 'at least' version 2.1
-of cvsps (available at the address above), and in fact will currently
-refuse to work with anything else.
-
-Once you've gotten (and installed) cvsps, you may or may not want to get
-any more familiar with it, but make sure it is in your path. After that,
-the magic command line is
-
-	git cvsimport -v -d <cvsroot> -C <destination> <module>
-
-which will do exactly what you'd think it does: it will create a git
-archive of the named CVS module. The new archive will be created in the
-subdirectory named <destination>; it'll be created if it doesn't exist.
-Default is the local directory.
-
-It can take some time to actually do the conversion for a large archive
-since it involves checking out from CVS every revision of every file,
-and the conversion script is reasonably chatty unless you omit the '-v'
-option, but on some not very scientific tests it averaged about twenty
-revisions per second, so a medium-sized project should not take more
-than a couple of minutes.  For larger projects or remote repositories,
-the process may take longer.
-
-After the (initial) import is done, the CVS archive's current head
-revision will be checked out -- thus, you can start adding your own
-changes right away.
-
-The import is incremental, i.e. if you call it again next month it'll
-fetch any CVS updates that have been happening in the meantime. The
-cut-off is date-based, so don't change the branches that were imported
-from CVS.
-
-You can merge those updates (or, in fact, a different CVS branch) into
-your main branch:
-
-	git resolve HEAD origin "merge with current CVS HEAD"
-
-The HEAD revision from CVS is named "origin", not "HEAD", because git
-already uses "HEAD". (If you don't like 'origin', use cvsimport's
-'-o' option to change it.)
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
+
+Development Models
+------------------
+
+CVS users are accustomed to giving a group of developers commit access to
+a common repository.  In the next section we'll explain how to do this
+with git.  However, the distributed nature of git allows other development
+models, and you may want to first consider whether one of them might be a
+better fit for your project.
+
+For example, you can choose a single person to maintain the project's
+primary public repository.  Other developers then clone this repository
+and each work in their own clone.  When they have a series of changes that
+they're happy with, they ask the maintainer to pull from the branch
+containing the changes.  The maintainer reviews their changes and pulls
+them into the primary repository, which other developers pull from as
+necessary to stay coordinated.  The Linux kernel and other projects use
+variants of this model.
+
+With a small group, developers may just pull changes from each other's
+repositories without the need for a central maintainer.
+
+Emulating the CVS Development Model
+-----------------------------------
+
+Start with an ordinary git working directory containing the project, and
+remove the checked-out files, keeping just the bare .git directory:
+
+------------------------------------------------
+$ mv project/.git /pub/repo.git
+$ rm -r project/
+------------------------------------------------
+
+Next, give every team member read/write access to this repository.  One
+easy way to do this is to give all the team members ssh access to the
+machine where the repository is hosted.  If you don't want to give them a
+full shell on the machine, there is a restricted shell which only allows
+users to do git pushes and pulls; see gitlink:git-shell[1].
+
+Put all the committers should in the same group, and make the repository
+writable by that group:
+
+------------------------------------------------
+$ chgrp -R $group repo.git
+$ find repo.git -mindepth 1 -type d |xargs chmod ug+rwx,g+s
+$ GIT_DIR=repo.git git repo-config core.sharedrepository true
+------------------------------------------------
+
+Make sure committers have a umask of at most 027, so that the directories
+they create are writable and searchable by other group members.
+
+Suppose this repository is now set up in /pub/repo.git on the host
+foo.com.  Then as an individual commiter you can clone the shared
+repository:
+
+------------------------------------------------
+$ git clone foo.com:/pub/repo.git/ my-project
+$ cd my-project
+------------------------------------------------
+
+and hack away.  The equivalent of `cvs update` is
+
+------------------------------------------------
+$ git pull origin
+------------------------------------------------
+
+which merges in any work that others might have done since the clone
+operation.
+
+[NOTE]
+================================
+The first `git clone` places the following in the
+`my-project/.git/remotes/origin` file, and that's why the previous step
+and the next step both work.
+------------
+URL: foo.com:/pub/project.git/ my-project
+Pull: master:origin
+------------
+================================
 
+You can update the shared repository with your changes using:
 
-Emulating CVS behaviour
------------------------
+------------------------------------------------
+$ git push origin master
+------------------------------------------------
+
+If some else has updated the repository more recently, `git push`, like
+`cvs commit`, will complain, in which case you must pull any changes
+before attempting the push again.
+
+In the `git push` command above we specify the name of the remote branch
+to update (`master`).  If we leave that out, `git push` tries to update
+any branches in the remote repository that have the same name as a branch
+in the local repository.  So the last `push` can be done with either of:
 
+------------
+$ git push origin
+$ git push repo.shared.xz:/pub/scm/project.git/
+------------
 
-So, by now you are convinced you absolutely want to work with git, but
-at the same time you absolutely have to have a central repository.
-Step back and think again. Okay, you still need a single central
-repository? There are several ways to go about that:
-
-1. Designate a person responsible to pull all branches. Make the
-repository of this person public, and make every team member
-pull regularly from it.
-
-2. Set up a public repository with read/write access for every team
-member. Use "git pull/push" as you used "cvs update/commit".  Be
-sure that your repository is up to date before pushing, just
-like you used to do with "cvs commit"; your push will fail if
-what you are pushing is not up to date.
-
-3. Make the repository of every team member public. It is the
-responsibility of each single member to pull from every other
-team member.
+as long as the shared repository does not have any branches
+other than `master`.
 
+[NOTE]
+============
+Because of this behaviour, if the shared repository and the developer's
+repository both have branches named `origin`, then a push like the above
+attempts to update the `origin` branch in the shared repository from the
+developer's `origin` branch.  The results may be unexpected, so it's
+usually best to remove any branch named `origin` from the shared
+repository.
+============
+
+Advanced Shared Repository Management
+-------------------------------------
+
+Git allows you to specify scripts called "hooks" to be run at certain
+points.  You can use these, for example, to send all commits to the shared
+repository to a mailing list.  See link:hooks.txt[Hooks used by git].
+
+You can enforce finer grained permissions using update hooks.  See
+link:howto/update-hook-example.txt[Controlling access to branches using
+update hooks].
 
 CVS annotate
 ------------
-- 
0.99.8b.g3480-dirty
