From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 6/6] Refresh and expand the tutorial (not finished)
Date: Sun, 05 Oct 2008 18:02:03 +0200
Message-ID: <20081005160203.19886.33463.stgit@yoghurt>
References: <20081005155450.19886.43748.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 18:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmW5C-0006Ms-Rf
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 18:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbYJEQCc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 12:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbYJEQCc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 12:02:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1884 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbYJEQCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 12:02:30 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KmW3W-0007Ys-00; Sun, 05 Oct 2008 17:02:03 +0100
In-Reply-To: <20081005155450.19886.43748.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97519>

This is a first pass at expanding the tutorial, fixing its formatting,
and updating it with the new things that have happened in StGit.

There are a number of things still left to do in the second half of
the document; they are tagged with "TODO".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/Makefile     |    3=20
 Documentation/tutorial.txt |  794 ++++++++++++++++++++++++++----------=
--------
 2 files changed, 477 insertions(+), 320 deletions(-)


diff --git a/Documentation/Makefile b/Documentation/Makefile
index 37df9ee..dd029d5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -82,6 +82,7 @@ command-list.txt: $(ALL_PY)
=20
 # special formatting rules
 tutorial.html : %.html : %.txt
-	$(ASCIIDOC) -b xhtml11 -d article -f tutorial.conf $(ASCIIDOC_EXTRA) =
$<
+	$(ASCIIDOC) -b xhtml11 -d article -a toc -f tutorial.conf \
+                $(ASCIIDOC_EXTRA) $<
 tutorial.xml : %.xml : %.txt
 	$(ASCIIDOC) -b docbook -d article -f tutorial.conf $<
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 472a5c3..103f3e4 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -1,416 +1,572 @@
-StGIT Tutorial
+StGit tutorial
 ##############
=20
+StGit is a command-line application that provides functionality
+similar to htmllink:http://savannah.nongnu.org/projects/quilt/[Quilt]
+(i.e. pushing/popping patches to/from a stack), but using Git instead
+of +diff+ and +patch+. StGit stores its patches in a Git repository as
+normal Git commits, and provides a number of commands to manipulate
+them in various ways.
=20
-StGIT is a Python application that provides functionality similar to
-quilt (i.e. pushing/popping patches to/from a stack) using GIT instead
-of 'diff' and 'patch'. StGIT stores its patches in a GIT repository as
-normal GIT commit objects.
-StGIT is not an SCM interface on top of GIT. For standard SCM
-operations, either use GIT's porcelain commands or the Cogito tool.
-StGIT is available for download at http://www.procode.org/stgit/ .
-This tutorial assumes you are already familiar with GIT. For more
-information on GIT, see the GIT_tutorial or git(7) .
+This tutorial assumes you are already familiar with the basics of Git
+(for example, branches, commits, and conflicts). For more information
+on Git, see manlink:git[1] or htmllink:http://git.or.cz/[the Git home
+page].
=20
=20
-Basic Operation
+Help
+=3D=3D=3D=3D
+
+For a full list of StGit commands:
+
+  $ stg help
+
+For quick help on individual subcommands:
+
+  $ stg help <cmd>
+
+For more extensive help on a subcommand:
+
+  $ man stg-<cmd>
+
+(The documentation is also available in htmllink:stg.html[HTML
+format].)
+
+
+Getting started
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Help
-----
+StGit is not a stand-alone program -- it operates on a Git repository
+that you have already created, using +git init+ or +git clone+. So get
+one of those; if you don't have one at hand, try for example
+
+  $ git clone http://homepage.ntlworld.com/cmarinas/stgit.git
+  $ cd stgit
+
+Before you can create StGit patches, you have to run stglink:init[]:
+
+  $ stg init
=20
-For a full list of StGIT commands:
+This initializes the StGit metadata for the current branch. (So if you
+want to have StGit patches in another branch too, you need to run +stg
+init+ again in that branch.)
=20
-  stg help
+NOTE: As a shortcut, stglink:clone[] will run +git clone+ followed by
++stg init+ for you.
=20
-For help on individual subcommands:
=20
-  stg <cmd> (-h | --help)
+Creating a patch
+----------------
=20
+Now we're ready to create our first patch:
=20
-Repository initialisation
--------------------------
+  $ stg new my-first-patch
=20
-In stand-alone mode, StGIT is used in conjunction with a GIT repositor=
y
-that is already initialised (using 'git init'). StGIT cannot be used
-outside of a GIT repository.
-Any branch in a GIT repository may be managed by StGIT. Each branch
-managed by StGIT contains an independent series of StGIT patches.
-To initialise an existing GIT branch to be managed by StGIT, cd into t=
he
-top of your GIT repository, check out the branch you'd like to manage
-with StGIT, and type:
+This will create a patch called +my-first-patch+, and open an editor
+to let you edit the patch's commit message. (If you don't give a name
+on the command line, StGit will make one up based on the first line of
+the commit message.) This patch is empty, as stglink:show[] will tell
+you:
=20
-  stg init
+  $ stg show
=20
-Run the 'stg init' command for any pre-existing GIT branches intended =
to
-be used with StGIT.
-You can switch between GIT branches with:
+But it won't stay that way for long! Open one of the files in your
+favorite text editor, change something, and save. You now have some
+local changes in your tree:
=20
-  stg branch [<branch name>]
+  $ stg status
+  M stgit/main.py
=20
-This checks out the named branch and places you at the topmost applied
-StGIT patch in that branch.
-Alternately, you can create branches using only StGIT commands, which
-will automatically prepare them for use with StGIT:
+Then stgsublink:refresh[] the patch:
=20
-  stg branch --create <new branch>
+  $ stg refresh
=20
+And voil=C3=A0 -- the patch is no longer empty:
=20
-Working with remote repositories
---------------------------------
+  $ stg show
+  commit 3de32068c600d40d8af2a9cf1f1c762570ae9610
+  Author: Audrey U. Thor <author@example.com>
+  Date:   Sat Oct 4 16:10:54 2008 +0200
=20
-With a single command, StGIT can create and initialize a GIT repositor=
y
-which mirrors a remote GIT repository. This is known as cloning. All G=
IT
-transports are supported.
-To clone a repository, use:
+      Tell the world that I've made a patch
=20
-  stg clone <repository> <local-dir>
+  diff --git a/stgit/main.py b/stgit/main.py
+  index e324179..6398958 100644
+  --- a/stgit/main.py
+  +++ b/stgit/main.py
+  @@ -171,6 +171,7 @@ def _main():
+       sys.exit(ret or utils.STGIT_SUCCESS)
=20
-This creates a fresh local repository, initialises a GIT database in i=
t,
-pulls the latest version of the remote, and creates and initialises a
-'master' branch for use with StGIT.
-At any time you can pull the latest changes from the remote repository=
=2E
-By default, StGIT pulls from the location stored in .git/branches/
-origin, and updates the base of the current branch.
-To pull the latest changes from a remote repository, use:
+   def main():
+  +    print 'My first patch!'
+       try:
+           _main()
+       finally:
=20
-  stg pull [<branch> or 'origin']
+(I'm assuming you're already familiar with patches like this from Git,
+but it's really quite simple; in this example, I've added the +$$print
+'My first patch!'$$+ line to the file +stgit/main.py+, at around line
+171.)
=20
-This command removes all applied StGIT patches from the current branch=
,
-updates the branch's base commit, then attempts to re-apply the patche=
s.
-Any merge conflicts will halt this process, allowing you to clean up t=
he
-conflicts and continue (see below).
-If the maintainer of the remote repository includes one of your patche=
s
-in the published repository that you pull from, StGIT can usually
-recognize that an incoming patch from the remote matches one of yours,
-and it turns your local version into an empty patch.
-To automatically delete empty patches after a pull, use:
+Since the patch is also a regular Git commit, you can also look at it
+with regular Git tools such as manlink:gitk[].
=20
-  stg clean
+Creating another patch
+----------------------
=20
-As a convention, you should avoid working in the 'master' branch and u=
se
-it only as a reference, since it reflects someone else's work. If you
-decide to publish your GIT repository, you'll want your own work
-separated into its own branch to make it convenient for others to pull
-just your patches.
+We want to make another improvement, so let's create a new patch for
+it:
=20
-Getting started: creating a patch
----------------------------------
+  $ echo 'Audrey U. Thor' > AUTHORS
+  $ stg new credit --message 'Give me some credit'
+  $ stg refresh
=20
-Changes to your working directory are saved in a patch. An StGIT patch
-is simply a saved set of modifications to your working directory, plus=
 a
-saved description. To create an empty StGIT patch in the current branc=
h:
+Note that we can give the commit message on the command line, and that
+it doesn't matter whether we run stglink:new[] before or after we edit
+the files.
=20
-  stg new <name>
+So now we have two patches:
=20
-To save the changes you've made (that is, to refresh a patch), use:
+  $ stg series --description
+  + my-first-patch # This is my first patch
+  > credit         # Give me some credit
=20
-  stg refresh
+stglink:series[] lists the patches from bottom to top; +$$+$$+ means
+that a patch is 'applied', and +>+ that it is the 'current', or
+topmost, patch.
=20
-To discard changes in your working directory, use:
+If we want to make further changes to the topmost patch, we just edit
+the files and run +stg refresh+. But what if we wanted to change
++my-first-patch+? The simplest way is to stgsublink:pop[] the +credit+
+patch, so that +my-first-patch+ becomes topmost again:
=20
-  git checkout -f
+  $ stg pop credit
+  Checking for changes in the working directory ... done
+  Popping patch "credit" ... done
+  Now at patch "my-first-patch"
+  $ stg series --description
+  > my-first-patch # This is my first patch
+  - credit         # Give me some credit
=20
-This restores your working directory to the state it was in the last
-time the patch was refreshed.
-Modified files that haven't been saved via a refresh operation can be
-viewed with:
+stglink:series[] now shows that +my-first-patch+ is topmost again,
+which means that stglink:refresh[] will update it with any changes we
+make.
=20
-  stg status
+The minus sign says that +credit+ is 'unapplied' -- this means that
+it's been temporarily put aside. If you look at the +AUTHORS+ file,
+you'll see that our change to it is gone; and tools such as
+manlink:gitk[] will not show it, because it's been edited out of the
+Git history. But it's just one stglink:push[] command away from being
+restored:
=20
-You can view modified files that have already been saved into a patch:
+  $ stg push credit
+  Checking for changes in the working directory ... done
+  Fast-forwarded patch "credit"
+  Now at patch "credit"
=20
-  stg files
+NOTE: You can omit the patch name argument to stglink:push[] and
+stglink:pop[]. If you do, you will push the next unapplied patch, and
+pop the topmost patch, respectively.
=20
-The 'stg refresh' command automatically notes changes to files that
-already exist in the working directory (it also notices if you remove
-them), but you have to tell StGIT explicitly if you add or rename a
-file:
+NOTE: There are at least two more ways to update a non-topmost patch.
+One is to use stglink:refresh[] with the +$$--patch$$+ flag, the other
+to create a new patch for the update and then merge it into the other
+patch with stglink:coalesce[].
=20
-  git add new-file
=20
-to add a file, and
+Keeping commit messages up to date
+----------------------------------
=20
-  mv old-file new-file
-  git add new-file
+Since StGit is all about creating readable Git history (or a readable
+patch series, which is essentially the same thing), one thing you'll
+want to pay attention to is the commit messages of your patches.
+stglink:new[] asks you for a commit message when you create a new
+patch, but as time goes by and you refresh the patch again and again,
+chances are that the original commit message isn't quite correct
+anymore. Fortunately, editing the commit message is very easy:
=20
-or simply
+  $ stg edit <patch-name>
=20
-  git mv old-file new-file
+In addition to stglink:edit[], you can also give the +$$--edit$$+ flag
+to stglink:refresh[] -- that way, you get to change the commit message
+and update the patch at the same time. Use whichever feels most
+natural to you.
=20
-to move a file.
+NOTE: stglink:edit[] has a +$$--diff$$+ flag, which gives you the diff
+text and not just the commit message in your editor. Be aware, though,
+that if you change the diff so that it no longer applies, the edit
+will be saved to a file instead of being carried out. If you're not
+comfortable editing diffs, just treat +$$--diff$$+ as a way to get to
+'see' the diff while you edit the commit message.
=20
+If the patch changes considerably, it might even deserve a new name.
+stglink:rename[] is your friend there.
=20
-Stack manipulation: managing multiple patches
----------------------------------------------
=20
-StGIT can manage more than one patch at a time. A series of StGIT
-patches in a GIT branch are known collectively as a stack. The new pat=
ch
-you created above is now the topmost patch in your stack. You can alwa=
ys
-see the name of the topmost (current) patch with:
+Conflicts
+---------
+
+Normally, when you pop a patch, change something, and then later push
+it again, StGit sorts out everything for you automatically. For
+example, let's create two patches that modify different files:
+
+  $ stg clone http://homepage.ntlworld.com/cmarinas/stgit.git stgit
+  $ cd stgit
+  $ stg new first --message 'First patch'
+  $ echo '- Do something' >> TODO
+  $ stg refresh
+  $ stg new second --message 'Second patch'
+  $ echo '- Install something' >> INSTALL
+  $ stg refresh
+
+then pop them both:
+
+  $ stg pop --all
+
+and then push them in the opposite order:
+
+  $ stg push second first
+  $ stg series
+  + second
+  > first
+
+StGit had no problems reordering these patches for us, since they
+didn't touch the same file. But it would have worked just fine even if
+they had touched the same file, as long as they didn't change the same
+part of the file. But what if they did? Let's find out.
+
+  $ stg pop
+  Checking for changes in the working directory ... done
+  Popping patch "first" ... done
+  Now at patch "second"
+  $ echo '- Do something else' >> TODO
+  $ stg refresh
+
+Now, both patches add a new line at the end of +TODO+. So what happens
+when we try to have them both applied?
+
+  $ stg push
+  Pushing patch "first" ...
+    CONFLICT (content): Merge conflict in TODO
+    Error: The merge failed during "push".
+           Revert the operation with "stg undo".
+    stg push: 1 conflict(s)
+
+StGit is telling us that it couldn't figure out how to push +first+ on
+top of +second+, now that they both modify +TODO+. We can take a look
+at the situation with stglink:status[]:
+
+  $ stg status
+  ? TODO.ancestor
+  ? TODO.current
+  ? TODO.patched
+  C TODO
+
+As we were told by stglink:push[], the conflict is in the file +TODO+.
+(If the patch was bigger and touched multiple files, they would all be
+listed here; prefixed with +C+ if they had conflicts, and +M+ if StGit
+managed to automatically resolve everything in the file.)
+
+NOTE: +TODO.ancestor+, +TODO.current+, and +TODO.patched+ are the
+three versions of the file that StGit tried to merge. The +.current+
+file is the version before the patch was applied, +.patched+ is the
+version in the patch we tried to push, and +.ancestor+ the version
+that contains neither of the added lines.
+
+At this point, we have two options:
+
+  1. Undo the failed merge with stglink:undo[]. (Remember to use the
+     +$$--hard$$+ flag, since the unresolved conflict means the
+     worktree is not clean.)
+
+  2. Manually resolve the conflict.
+
+To resolve the conflict, open +TODO+ in your favorite editor. It ends
+like this:
+
+----------------------------------------------------------------------
+- numeric shortcuts for naming patches near top (eg. +1, -2)
+- (config?) parameter for number of patches included by "series -s"
+<<<<<<< current:TODO
+- Do something else
+=3D=3D=3D=3D=3D=3D=3D
+- Do something
+>>>>>>> patched:TODO
+----------------------------------------------------------------------
+
+The 'conflict markers' +<<<<<<<+, +=3D=3D=3D=3D=3D=3D=3D+, and +>>>>>>=
>+ indicate
+which lines were already there (+current+) and which were added by the
+patch (+patched+). Edit the file so that it looks like it should; in
+this case, we want something like this:
+
+----------------------------------------------------------------------
+- numeric shortcuts for naming patches near top (eg. +1, -2)
+- (config?) parameter for number of patches included by "series -s"
+- Do something
+- Do something else
+----------------------------------------------------------------------
+
+Note that ``looks like it should'' includes removing the conflict
+markers.
+
+Now that we've resolved the conflict, we just need to tell StGit about
+it:
+
+  $ stg resolved TODO
+  $ stg status
+  M TODO
+
++TODO+ is listed as being modified, not in conflict. And we know from
+before how to deal with modified files:
+
+  $ stg refresh
+
+The conflict is now resolved. We can see that +first+ now looks a
+little different; it no longer adds a line at the end of the file:
+
+  $ stg show
+  commit 8e3ae5f6fa6e9a5f831353524da5e0b91727338e
+  Author: Audrey U. Thor <author@example.com>
+  Date:   Sun Oct 5 14:43:42 2008 +0200
+
+      First patch
+
+  diff --git a/TODO b/TODO
+  index 812d236..4ef3841 100644
+  --- a/TODO
+  +++ b/TODO
+  @@ -24,4 +24,5 @@ The future, when time allows or if someone else do=
es them:
+     they have scripts for moving the changes in one to the others)
+   - numeric shortcuts for naming patches near top (eg. +1, -2)
+   - (config?) parameter for number of patches included by "series -s"
+  +- Do something
+   - Do something else
+
+
+Workflow: Development branch
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+One common use of StGit is to ``polish'' a Git branch before you
+publish it for others to see. Such history falsification can often be
+a 'good' thing -- when you (or someone else) needs to look at what you
+did six months later, you are not really interested in all the false
+starts and the steps needed to corect them. What you want is the final
+solution, presented in a way that makes it easy to read and
+understand.
+
+Of course, there are limits. Editing the last few days' worth of
+history is probably a good idea; editing the last few months' probably
+isn't. A rule of thumb might be to not mess with history old enough
+that you don't remember the details anymore. And rewriting history
+that you have published for others to see (and base their own work on)
+usually just makes everyone more confused, not less.
+
+So, let's take a concrete example. Say that you're hacking on StGit,
+and have made several Git commits as your work progressed, with commit
+messages such as ``Improve the snarfle cache'', ``Remove debug
+printout'', ``New snarfle cache test'', ``Oops, spell function name
+correctly'', ``Fix documentation error'', and ``More snarfle cache''.
+
+Now, this is the actual history, but for obvious reasons, this isn't
+the kind of history you'd ideally want to find when you six months
+from now try to figure out exactly where that elusive snarfle cache
+bug was introduced. So let's turn this into the history we can be
+proud of. The first step is to make StGit patches out of all those Git
+commits:
+
+  $ stg uncommit --number 6
+  Uncommitting 6 patches ...
+    Now at patch "more-snarfle-cache"
+  done
+  $ stg series --description
+  + improve-the-snarfle-cache      # Improve the snarfle cache
+  + remove-debug-printout          # Remove debug printout
+  + new-snarfle-cache-test         # New snarfle cache test
+  + oops-spell-function-name-corre # Oops, spell function name correct=
ly
+  + fix-documentation-error        # Fix documentation error
+  > more-snarfle-cache             # More snarfle cache
+
+As you can see, stglink:uncommit[] adds StGit metadata to the last few
+Git commits, turning them into StGit patches so that we can do stuff
+with them.
+
+NOTE: With the +$$--number$$+ flag, stglink:uncommit[] uncommits that
+many commits and generates names for them based on their commit
+messages. If you like, you can instead list the patch names you want
+on the command line.
+
+At this point, there are a number of things we could do:
+
+  * Continue developing, and take advantage of e.g. stglink:goto[] or
+    +stg refresh $$--patch$$+ to stick updates in the right patch to
+    begin with.
+
+  * Use e.g. stglink:float[], stglink:sink[], stglink:push[], and
+    stglink:pop[] to reorder patches.
+
+  * Use stglink:coalesce[] to merge two or more patches into one.
+    stgsublink:coalesce[] pushes and pops so that the patches to be
+    merged are consecutive and unrelated patches aren't in the way,
+    then makes one big patch out of the patches to be merged, and
+    finally pushes the other patches back.
++
+Of course, as always when there is pushing involved, there is the
+possibility of conflicts. If a push results in a conflict, the
+operation will be halted, and we'll be given the option of either
+resolving the conflict or undoing.
+
+Once we feel that the history is as good as it's going to get, we can
+remove the StGit metadata, turning the patches back into regular Git
+commits again:
+
+  $ stg commit --all
+
+TIP: stglink:commit[] can also commit specific patches (named on the
+command line), leaving the rest alone. This can be used to retire
+patches as they mature, while keeping the newer and more volatile
+patches as patches.
+
+
+Workflow: Tracking branch
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+
+Rebasing a patch series
+-----------------------
+
+TODO:: rebase, ...
+
+
+Getting patches upstream
+------------------------
+
+TODO:: export, mail, ...
=20
-  stg top
=20
-The topmost patch is used as the default patch for most StGIT
-operations. It is the default target of the 'stg refresh' command, for
-example.
-Patches that are pushed onto the stack are referred to as applied, and
-patches that are popped off the stack are referred to as unapplied.
-To push/pop a patch to/from a stack:
+Importing patches
+-----------------
=20
-  stg push [--all | <name>]
-  stg pop [--all]
+TODO:: import, ...
=20
-The last patch you pushed is the topmost patch. This patch is always i=
n
-the applied list; StGIT can't operate on an unapplied patch unless you
-apply it first.
-You can display the order of patches in a stack with one of these
-commands:
=20
-  stg series
-  stg applied
-  stg unapplied
+Other stuff that needs to be placed somewhere
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+Undo
+----
+
+TODO:: undo, redo, log, reset
=20
-By default the 'stg push' command applies the first patch in the
-unapplied list, but you can push any patch in the unapplied list by
-giving the name of the patch. This is useful if you want to reorder th=
e
-patches in a stack.
-During a push operation, merge conflicts can occur (especially if you
-are changing the order of the patches in your stack). If the push caus=
es
-merge conflicts, they need to be fixed and 'stg resolved' run (see
-below). A 'push' operation can also be reverted with 'stg undo' (you
-will need to give it the --hard flag, since the conflicting push will
-have left your work tree dirty).
-A few more stack basics; to rename a patch:
=20
-  stg rename <old-name> <new-name>
+Interoperating with Git
+-----------------------
=20
-To delete a patch:
+TODO::
=20
-  stg delete <name>
+* git commit + repair
=20
-This permanently discards the named patch. In other words, the patch n=
o
-longer appears in either the applied or unapplied lists, and cannot be
-reapplied to the series.
-You may want to make patches in your stack a permanent part of your GI=
T
-repository, for example if you are publishing your repository to other=
s.
-To do this, use:
+* git reset HEAD~n + repair
=20
-  stg commit
+* don't do git rebase or git merge, because it won't work
=20
-This merges all applied patches in your patch series into the GIT
-repository and removes them from your stack. Use this command only if
-you want to permanently store the applied patches and no longer manage
-them with StGIT.
=20
-Converting between StGIT patches and text diffs
------------------------------------------------
+Patch stuff
+-----------
+
+TODO:: This section needs revising. I've only fixed the formatting.
+Most of it should go under "Workflow: Tracking branch"
+
+As mentioned in the introduction, StGit stores modifications to your
+working tree in the form of Git commits. This means if you want to
+apply your changes to a tree not managed by Git, or send your changes
+to someone else in e-mail, you need to convert your StGit patches into
+normal textual diffs that can be applied with the GNU patch command.
+stglink:diff[] is a powerful way to generate and view textual diffs of
+patches managed by StGit.
=20
-As mentioned in the introduction, StGIT stores modifications to your
-working tree in the form of GIT commits. This means if you want to app=
ly
-your changes to a tree not managed by GIT, or send your changes to
-someone else in e-mail, you need to convert your StGIT patches into
-normal textual diffs that can be applied with the GNU 'patch' command.
-The 'stg diff' command is a powerful way to generate and view textual
-diffs of patches managed by StGIT.
 To view a diff of the topmost patch:
=20
-  stg diff -r /
+  $ stg diff -r /
=20
 Observe that this does not show any changes in the working directory
-that have not been saved by a 'refresh'. To view just the changes you'=
ve
-made since the last refresh, use:
+that have not been saved by a stgsublink:refresh[]. To view just the
+changes you've made since the last refresh, use:
=20
-  stg diff -r /top
+  $ stg diff -r /top
=20
 If you want to see the changes made by the patch combined with any
 unsaved changes in the working directory, try:
=20
-  stg diff -r /bottom
+  $ stg diff -r /bottom
=20
 You can also show the changes to any patch in your stack with:
=20
-  stg diff -r <patch>/
+  $ stg diff -r <patch>/
=20
 Use this command to view all the changes in your stack up through the
 current patch:
=20
-  stg diff -r base
+  $ stg diff -r base
=20
-The 'stg diff' command supports a number of other features that are ve=
ry
-useful. Be sure to take a look at the help information for this comman=
d.
-To convert your StGIT patches into patch files:
+stglink:diff[] supports a number of other features that are very
+useful. Be sure to take a look at the help information for this
+command. To convert your StGit patches into patch files:
=20
-  stg export [--range=3D[<patch1>[:<patch2>]]] [<dir-name>]
+  $ stg export [--range=3D[<patch1>[:<patch2>]]] [<dir-name>]
=20
-The 'export' command supports options to automatically number the
-patches (-n) or add the '.diff' extension (-d). If you don't tell "stg
-export" where to put the patches, it will create directory named "patc=
h-
-branchname" in your current directory, and store the patches there.
-To e-mail a patch or range of patches:
+stglink:export[] supports options to automatically number the patches
+(+-n+) or add the +.diff+ extension (+-d+). If you don't tell
+stgsublink:export[] where to put the patches, it will create directory
+named +patch-<branchname>+ in your current directory, and store the
+patches there. To e-mail a patch or range of patches:
=20
-  stg mail [--to=3D...] (--all | --range=3D[<patch1>[:<patch2>]] | <pa=
tch>)
+  $ stg mail [--to=3D...] (--all | --range=3D[<patch1>[:<patch2>]] | <=
patch>)
=20
-"stg mail" has a lot of options, so read the output of "stg mail -h" f=
or
-more information.
-You can also import an existing GNU diff patch file as a new StGIT pat=
ch
-with a single command. "stg import" will automatically parse through t=
he
-patch file and extract a patch description. Use:
+stglink:mail[] has a lot of options, so read the output of +stg mail
+-h+ for more information.
=20
-  stg import [<file>]
+You can also import an existing GNU diff patch file as a new StGit
+patch with a single command. stglink:import[] will automatically parse
+through the patch file and extract a patch description. Use:
=20
-This is the equivalent of "stg new" followed by "patch -i <file>", the=
n
-"stg refresh -e".
-Sometimes the patch file won't apply cleanly. In that case, "stg impor=
t"
-will leave you with an empty StGIT patch, to which you then apply the
-patch file by hand using "patch -i" and your favorite editor.
-To merge a GNU diff file (defaulting to the standard input) into the
-topmost patch:
+  $ stg import [<file>]
=20
-  stg fold [<file>]
+This is the equivalent of
=20
-This command supports a '--threeway' option which applies the patch on=
to
-the bottom of the topmost one and performs a three-way merge.
+  $ stg new
+  $ patch -i <file>
+  $ stg refresh -e
=20
+Sometimes the patch file won't apply cleanly. In that case,
+stglink:import[] will leave you with an empty StGit patch, to which
+you then apply the patch file by hand using "patch -i" and your
+favorite editor.
=20
-Advanced Usage
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+To merge a GNU diff file (defaulting to the standard input) into the
+topmost patch:
=20
-Handling merge conflicts
-------------------------
+  $ stg fold [<file>]
=20
-Pushing a patch on the stack can fail if the patch cannot be applied
-cleanly. This usually happens if there are overlapping changes in the
-tree, the patch depends on another patch which is not applied, or if a
-patch was not merged upstream in the exact form it was sent.
-The 'push' operation stops after the first patch with conflicts. The
-'status' command shows the conflict files by marking them with a 'C'. =
If
-the 'keeporig' options is set to 'yes' (the default), the original fil=
es
-involved in the merge operations are left in the tree as <file>.older,
-<file>.local and <file>.remote for better analysis of the conflict. If
-'diff3' is used as the merger (the default), markers are added to the
-conflicted files as well.
-Run the 'resolved' command to mark the conflicts resolved and remove t=
he
-temporary merge files from the working tree. Then run the 'refresh'
-command to update the StGIT patch with the modifications you made to
-resolve the conflict.
-
-
-Configuration file
-------------------
-
-StGIT tries to read the configuration options from the following files=
:
-/etc/stgitrc, ~/.stgitrc and .git/stgitrc. The latter overrides the
-options in the former files. If no file is found, the defaults are use=
d.
-An example configuration file with options description can be found in
-the examples/ directory. Most users would probably only define the
-'smtpserver' option used by the 'mail' command.
-The gitmergeonefile.py script does the three-way merging on individual
-files using the tool specified by the 'merger' option. The user can
-specify a smarter tool to be used.
+This command supports a +$$--threeway$$+ option which applies the
+patch onto the bottom of the topmost one and performs a three-way
+merge.
=20
=20
 Templates
 ---------
=20
-The 'export' and 'mail' commands use templates for generating the patc=
h
-files or e-mails. The default templates are installed under <prefix>/
-share/stgit/templates/ and, combined with the extra options available
-for the commands, should be enough for most users. The template format
-uses the standard Python string formatting rules. The variables
-available are shown in the the help message for the commands.
-The 'mail' command can also send an initial e-mail for which there is =
no
-default template. The <prefix>/share/stgit/examples/firstmail.tmpl fil=
e
-can be used as an example.
-A default description for new patches can be defined in the .git/
-patchdescr.tmpl file. This is useful for things like signed-off-by
-lines.
-
-
-Merging two patches into one
-----------------------------
-
-There is no command to do this directly at the moment but one can expo=
rt
-the patch to be merged and use the 'stg fold' command on the generated
-diff file. Assuming that the merged patch was not already applied, the
-operation will succeed. Pushing the merged patch onto the stack will
-result in an empty patch (StGIT notifying the user) that can be safely
-deleted.
-
-
-Technical Information
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-A bit of StGIT patch theory
----------------------------
-
-We assume that a patch is a diff between two nodes - bottom and top. A
-node is a commit SHA1 id or tree SHA1 id in the GIT terminology:
-
-  P - patch
-  N - node
-
-  P =3D diff(Nt, Nb)
-
-  	Nb - bottom (start) node
-  	Nt - top (end) node
-  	Nf - first node (for log generation)
-
-For an ordered stack of patches:
-
-  P1 =3D diff(N1, N0)
-  P2 =3D diff(N2, N1)
-  ...
-
-
-  Ps =3D P1 + P2 + P3 + ... =3D diff(Nst, Nsb)
-
-  	Ps  - the big patch of the whole stack
-  	Nsb - bottom stack node (=3D N0)
-  	Nst - top stack node (=3D Nn)
-
-Applying (pushing) a patch on the stack (Nst can differ from Nb) is do=
ne
-by diff3 merging. The new patch becomes:
-
-  P' =3D diff(Nt', Nb')
-  Nb' =3D Nst
-  Nt' =3D diff3(Nst, Nb, Nt)
-
-(note that the diff3 parameters order is: branch1, ancestor, branch2)
-The above operation allows easy patch re-ordering.
-Removing (popping) a patch from the stack is done by simply setting th=
e
-Nst to Nb.
-
-
-Layout of the .git directory
-----------------------------
-
-  HEAD			-> refs/heads/<something>
-  objects/
-    ??/
-    ...
-  refs/
-    heads/
-      master		- the master commit id
-      ...
-    tags/
-      ...
-    branches/
-      ...
-    patches/
-      master/
-        applied		- list of applied patches
-        unapplied		- list of not-yet applied patches
-        current		- name of the topmost patch
-        patch1/
-          bottom		- the bottom id of the patch
-          top		- the top id of the patch
-  	description	- the patch description
-  	authname	- author's name
-  	authemail	- author's e-mail
-  	commname	- committer's name
-  	commemail	- committer's e-mail
-        patch2/
-          ...
-        ...
-      ...
+TODO:: This section needs revising. I've only fixed the formatting.
+
+stglink:export[] and stglink:mail[] use templates for generating the
+patch files or e-mails. The default templates are installed under
++<prefix>/share/stgit/templates/+ and, combined with the extra options
+available for these commands, should be enough for most users. The
+template format uses the standard Python string formatting rules. The
+variables available are listed in the the manual pages for each
+command. stglink:mail[] can also send an initial 'cover' e-mail for
+which there is no default template. The
++<prefix>/share/stgit/examples/firstmail.tmpl+ file can be used as an
+example. A default description for new patches can be defined in the
++.git/ patchdescr.tmpl+ file. This is useful for things like
+signed-off-by lines.
