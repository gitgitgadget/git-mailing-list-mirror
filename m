From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: pull, push, packing repository and working with others.
Date: Fri, 15 Jul 2005 11:40:56 -0700
Message-ID: <7vzmsnrjyf.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 20:42:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtV7o-0002NG-Hg
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 20:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVGOSlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVGOSlH
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 14:41:07 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19379 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261997AbVGOSk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 14:40:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050715184057.XAWN550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Jul 2005 14:40:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmsots7t.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 15 Jul 2005 00:59:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Describe where you can pull from with a bit more detail.
Clarify description of pushing.

Add a section on packing repositories.

Add a section on recommended workflow for the project lead,
subsystem maintainers and individual developers.

Move "Tag" section around to make the flow of example simpler to
follow.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/tutorial.txt |  371 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 290 insertions(+), 81 deletions(-)

9ad5d377ecf29ab6d7044db128bee98bf9690bbe
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -453,6 +453,55 @@ With that, you should now be having some
 can explore on your own.
 
 
+[ Side note: most likely, you are not directly using the core
+  git Plumbing commands, but using Porcelain like Cogito on top
+  of it.  Cogito works a bit differently and you usually do not
+  have to run "git-update-cache" yourself for changed files (you
+  do tell underlying git about additions and removals via
+  "cg-add" and "cg-rm" commands).  Just before you make a commit
+  with "cg-commit", Cogito figures out which files you modified,
+  and runs "git-update-cache" on them for you.  ]
+
+
+	Tagging a version
+	-----------------
+
+In git, there's two kinds of tags, a "light" one, and a "signed tag".
+
+A "light" tag is technically nothing more than a branch, except we put
+it in the ".git/refs/tags/" subdirectory instead of calling it a "head".
+So the simplest form of tag involves nothing more than
+
+	cat .git/HEAD > .git/refs/tags/my-first-tag
+
+after which point you can use this symbolic name for that particular
+state. You can, for example, do
+
+	git diff my-first-tag
+
+to diff your current state against that tag (which at this point will
+obviously be an empty diff, but if you continue to develop and commit
+stuff, you can use your tag as a "anchor-point" to see what has changed
+since you tagged it.
+
+A "signed tag" is actually a real git object, and contains not only a
+pointer to the state you want to tag, but also a small tag name and
+message, along with a PGP signature that says that yes, you really did
+that tag. You create these signed tags with
+
+	git tag <tagname>
+
+which will sign the current HEAD (but you can also give it another
+argument that specifies the thing to tag, ie you could have tagged the
+current "mybranch" point by using "git tag <tagname> mybranch").
+
+You normally only do signed tags for major releases or things
+like that, while the light-weight tags are useful for any marking you
+want to do - any time you decide that you want to remember a certain
+point, just create a private tag for it, and you have a nice symbolic
+name for the state at that point.
+
+
 	Copying archives
 	-----------------
 
@@ -729,117 +778,277 @@ simply do
 and optionally give a branch-name for the remote end as a second
 argument.
 
-[ Todo: fill in real examples ]
-
-
-	Tagging a version
-	-----------------
-
-In git, there's two kinds of tags, a "light" one, and a "signed tag".
-
-A "light" tag is technically nothing more than a branch, except we put
-it in the ".git/refs/tags/" subdirectory instead of calling it a "head".
-So the simplest form of tag involves nothing more than
-
-	cat .git/HEAD > .git/refs/tags/my-first-tag
-
-after which point you can use this symbolic name for that particular
-state. You can, for example, do
-
-	git diff my-first-tag
-
-to diff your current state against that tag (which at this point will
-obviously be an empty diff, but if you continue to develop and commit
-stuff, you can use your tag as a "anchor-point" to see what has changed
-since you tagged it.
-
-A "signed tag" is actually a real git object, and contains not only a
-pointer to the state you want to tag, but also a small tag name and
-message, along with a PGP signature that says that yes, you really did
-that tag. You create these signed tags with
-
-	git tag <tagname>
-
-which will sign the current HEAD (but you can also give it another
-argument that specifies the thing to tag, ie you could have tagged the
-current "mybranch" point by using "git tag <tagname> mybranch").
-
-You normally only do signed tags for major releases or things
-like that, while the light-weight tags are useful for any marking you
-want to do - any time you decide that you want to remember a certain
-point, just create a private tag for it, and you have a nice symbolic
-name for the state at that point.
-
-[ to be continued.. cvsimports, pushing and pulling ]
+The "remote" repository can even be on the same machine.  One of
+the following notations can be used to name the repository to
+pull from:
+
+	Rsync URL
+		rsync://remote.machine/path/to/repo.git/
+
+	HTTP(s) URL
+		http://remote.machine/path/to/repo.git/
+
+	GIT URL
+		git://remote.machine/path/to/repo.git/
+		remote.machine:/path/to/repo.git/
+
+	Local directory
+		/path/to/repo.git/
+
+[ Side Note: currently, HTTP transport is slightly broken in
+  that when the remote repository is "packed" they do not always
+  work.  But we have not talked about packing repository yet, so
+  let's not worry too much about it for now.  ]
+
+[ Digression: you could do without using any branches at all, by
+  keeping as many local repositories as you would like to have
+  branches, and merging between them with "git pull", just like
+  you merge between branches.  The advantage of this approach is
+  that it lets you keep set of files for each "branch" checked
+  out and you may find it easier to switch back and forth if you
+  juggle multiple lines of development simultaneously.  Of
+  course, you will pay the price of more disk usage to hold
+  multiple working trees, but disk space is cheap these days.  ]
 
 
 	Publishing your work
 	--------------------
 
-We already talked about using somebody else's work from a remote
-repository, in the "merging external work" section.  It involved
-fetching the work from a remote repository; but how would _you_
-prepare a repository so that other people can fetch from it?
+So we can use somebody else's work from a remote repository; but
+how can _you_ prepare a repository to let other people pull from
+it?
 
-Your real work happens in your working directory with your
+Your do your real work in your working directory that has your
 primary repository hanging under it as its ".git" subdirectory.
-You _could_ make it accessible remotely and ask people to pull
-from it, but in practice that is not the way things are usually
-done.  A recommended way is to have a public repository, make it
-reachable by other people, and when the changes you made in your
-primary working directory are in good shape, update the public
-repository with it.
+You _could_ make that repository accessible remotely and ask
+people to pull from it, but in practice that is not the way
+things are usually done.  A recommended way is to have a public
+repository, make it reachable by other people, and when the
+changes you made in your primary working directory are in good
+shape, update the public repository from it.  This is often
+called "pushing".
 
 [ Side note: this public repository could further be mirrored,
   and that is how kernel.org git repositories are done.  ]
 
-Publishing the changes from your private repository to your
-public repository requires you to have write privilege on the
-machine that hosts your public repository, and it is internally
-done via an SSH connection.
-
-First, you need to create an empty repository to push to on the
-machine that houses your public repository.  This needs to be
+Publishing the changes from your local (private) repository to
+your remote (public) repository requires a write privilege on
+the remote machine.  You need to have an SSH account there to
+run a single command, "git-receive-pack".
+
+First, you need to create an empty repository on the remote
+machine that will house your public repository.  This empty
+repository will be populated and be kept up-to-date by pushing
+into it later.  Obviously, this repository creation needs to be
 done only once.
 
+[ Digression: "git push" uses a pair of programs,
+  "git-send-pack" on your local machine, and "git-receive-pack"
+  on the remote machine.  The communication between the two over
+  the network internally uses an SSH connection.  ]
+
 Your private repository's GIT directory is usually .git, but
-often your public repository is named "<projectname>.git".
-Let's create such a public repository for project "my-git".
-After logging into the remote machine, create an empty
-directory:
+your public repository is often named after the project name,
+i.e. "<project>.git".  Let's create such a public repository for
+project "my-git".  After logging into the remote machine, create
+an empty directory:
 
 	mkdir my-git.git
 
-Then, initialize that directory with git-init-db, but this time,
-since it's name is not usual ".git", we do things a bit
-differently:
+Then, make that directory into a GIT repository by running
+git-init-db, but this time, since it's name is not the usual
+".git", we do things slightly differently:
 
 	GIT_DIR=my-git.git git-init-db
 
 Make sure this directory is available for others you want your
-changes to be pulled by.  Also make sure that you have the
-'git-receive-pack' program on the $PATH.
-
-[ Side note: many installations of sshd does not invoke your
-  shell as the login shell when you directly run programs; what
-  this means is that if your login shell is bash, only .bashrc
-  is read bypassing .bash_profile.  As a workaround, make sure
-  .bashrc sets up $PATH so that 'git-receive-pack' program can
-  be run.  ]
+changes to be pulled by via the transport of your choice.  Also
+you need to make sure that you have the "git-receive-pack"
+program on the $PATH.
+
+[ Side note: many installations of sshd do not invoke your shell
+  as the login shell when you directly run programs; what this
+  means is that if your login shell is bash, only .bashrc is
+  read and not .bash_profile.  As a workaround, make sure
+  .bashrc sets up $PATH so that you can run 'git-receive-pack'
+  program.  ]
 
-Your 'public repository' is ready to accept your changes.  Now,
-come back to the machine you have your private repository.  From
+Your "public repository" is now ready to accept your changes.
+Come back to the machine you have your private repository.  From
 there, run this command:
 
 	git push <public-host>:/path/to/my-git.git master
 
 This synchronizes your public repository to match the named
-branch head (i.e. refs/heads/master in this case) and objects
-reachable from them in your current repository.
+branch head (i.e. "master" in this case) and objects reachable
+from them in your current repository.
 
 As a real example, this is how I update my public git
 repository.  Kernel.org mirror network takes care of the
-propagation to other publically visible machines:
+propagation to other publicly visible machines:
 
 	git push master.kernel.org:pub/scm/git/git.git/ 
 
+
+[ Digression: your GIT "public" repository people can pull from
+  is different from a public CVS repository that lets read-write
+  access to multiple developers.  It is a copy of _your_ primary
+  repository published for others to use, and you should not
+  push into it from more than one repository (this means, not
+  just disallowing other developers to push into it, but also
+  you should push into it from a single repository of yours).
+  Sharing the result of work done by multiple people are always
+  done by pulling (i.e. fetching and merging) from public
+  repositories of those people.  Typically this is done by the
+  "project lead" person, and the resulting repository is
+  published as the public repository of the "project lead" for
+  everybody to base further changes on.  ]
+
+
+	Packing your repository
+	-----------------------
+
+Earlier, we saw that one file under .git/objects/??/ directory
+is stored for each git object you create.  This representation
+is convenient and efficient to create atomically and safely, but
+not so to transport over the network.  Since git objects are
+immutable once they are created, there is a way to optimize the
+storage by "packing them together".  The command
+
+	git repack
+
+will do it for you.  If you followed the tutorial examples, you
+would have accumulated about 17 objects in .git/objects/??/
+directories by now.  "git repack" tells you how many objects it
+packed, and stores the packed file in .git/objects/pack
+directory.
+
+[ Side Note: you will see two files, pack-*.pack and pack-*.idx,
+  in .git/objects/pack directory.  They are closely related to
+  each other, and if you ever copy them by hand to a different
+  repository for whatever reason, you should make sure you copy
+  them together.  The former holds all the data from the objects
+  in the pack, and the latter holds the index for random
+  access.  ]
+
+If you are paranoid, running "git-verify-pack" command would
+detect if you have a corrupt pack, but do not worry too much.
+Our programs are always perfect ;-).
+
+Once you have packed objects, you do not need to leave the
+unpacked objects that are contained in the pack file anymore.
+
+	git prune-packed
+
+would remove them for you.
+
+You can try running "find .git/objects -type f" before and after
+you run "git prune-packed" if you are curious.
+
+[ Side Note: as we already mentioned, "git pull" is broken for
+  some transports dealing with packed repositories right now, so
+  do not run "git prune-packed" if you plan to give "git pull"
+  access via HTTP transport for now.  ]
+
+If you run "git repack" again at this point, it will say
+"Nothing to pack".  Once you continue your development and
+accumulate the changes, running "git repack" again will create a
+new pack, that contains objects created since you packed your
+archive the last time.  We recommend that you pack your project
+soon after the initial import (unless you are starting your
+project from scratch), and then run "git repack" every once in a
+while, depending on how active your project is.
+
+When a repository is synchronized via "git push" and "git pull",
+objects packed in the source repository is usually stored
+unpacked in the destination, unless rsync transport is used.
+
+
+	Working with Others
+	-------------------
+
+A recommended work cycle for a "project lead" is like this:
+
+ (1) Prepare your primary repository on your local machine. Your
+     work is done there.
+
+ (2) Prepare a public repository accessible to others.
+
+ (3) Push into the public repository from your primary
+     repository.
+
+ (4) "git repack" the public repository.  This establishes a big
+     pack that contains the initial set of objects.
+
+ (5) Keep working in your primary repository, and push your
+     changes to the public repository.  Your changes include
+     your own, patches you receive via e-mail, and merge resulting
+     from pulling the "public" repositories of your "subsystem
+     maintainers".
+
+     You can repack this private repository whenever you feel
+     like.
+
+ (6) Every once in a while, "git repack" the public repository.
+     Go back to step (5) and continue working.
+
+A recommended work cycle for a "subsystem maintainer" that
+works on that project and has own "public repository" is like
+this:
+
+ (1) Prepare your work repository, by "git clone" the public
+     repository of the "project lead".
+
+ (2) Prepare a public repository accessible to others.
+
+ (3) Copy over the packed files from "project lead" public
+     repository to your public repository by hand; this part is
+     currently not automated.
+
+ (4) Push into the public repository from your primary
+     repository.
+
+ (5) Keep working in your primary repository, and push your
+     changes to your public repository, and ask your "project
+     lead" to pull from it.  Your changes include your own,
+     patches you receive via e-mail, and merge resulting from
+     pulling the "public" repositories of your "project lead"
+     and possibly your "sub-subsystem maintainers".
+
+     You can repack this private repository whenever you feel
+     like.
+
+ (6) Every once in a while, "git repack" the public repository.
+     Go back to step (5) and continue working.
+
+A recommended work cycle for an "individual developer" who does
+not have a "public" repository is somewhat different.  It goes
+like this:
+
+ (1) Prepare your work repositories, by "git clone" the public
+     repository of the "project lead" (or "subsystem
+     maintainer", if you work on a subsystem).
+
+ (2) Copy .git/refs/master to .git/refs/upstream.
+
+ (3) Do your work there.  Make commits.
+
+ (4) Run "git fetch" from the public repository of your upstream
+     every once in a while.  This does only the first half of
+     "git pull" but does not merge.  The head of the public
+     repository is stored in .git/FETCH_HEAD.  Copy it in
+     .git/refs/heads/upstream.
+
+ (5) Use "git cherry" to see which ones of your patches were
+     accepted, and/or use "git rebase" to port your unmerged
+     changes forward to the updated upstream.
+
+ (6) Use "git format-patch upstream" to prepare patches for
+     e-mail submission to your upstream and send it out.
+     Go back to step (3) and continue. 
+
+[Side Note: I think Cogito calls this upstream "origin".
+ Somebody care to confirm or deny?  ]
+
+
+[ to be continued.. cvsimports ]
