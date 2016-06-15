From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] new tutorial
Date: Sun, 22 Jan 2006 23:57:25 -0500
Message-ID: <20060123045725.GA24485@fieldses.org>
References: <7vek3epbs9.fsf@assigned-by-dhcp.cox.net> <20060112005531.GB14599@fieldses.org> <7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net> <20060113030837.GD27214@fieldses.org> <7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net> <20060113151005.GA29804@fieldses.org> <7v4q477vqj.fsf@assigned-by-dhcp.cox.net> <20060113200152.GI4369@fieldses.org> <20060115185458.GA3985@fieldses.org> <7v64olysw2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 05:57:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0tll-0004Kn-Pv
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 05:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWAWE5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 23:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWAWE5a
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 23:57:30 -0500
Received: from mail.fieldses.org ([66.93.2.214]:43913 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932133AbWAWE53
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 23:57:29 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F0tld-0007Nc-Kn; Sun, 22 Jan 2006 23:57:25 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64olysw2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15076>

On Sun, Jan 15, 2006 at 03:26:53PM -0800, Junio C Hamano wrote:
> I have a mixed feeling on this one.  I tend to recommend --soft
> instead --mixed to people, but both have their pros and cons:

Yeah.  My goal here is to pare this down to the minimum of text required
to get people up and running and having fun.  To that end, I'd rather
just not explain what the index file is or how it's used.  And really
git-reset could probably be left out entirely.  So I've cut most of this
out, and left just one mention of git-reset --hard.

> If this is intended to be a beginner documentation, I'd prefer
> if it did not talk about cat-file, nor how commit objects are
> internally represented.

Fair enough.  I was trying to find a way to show the structure of the
commit graph.  But that was probably overkill.

So I've cut that out.  I've also left out discussion of the SHA1's
entirely, though we might want to add that back in at some point.  For
now it seems you can do enough without paying attention to them.

> These days by default "git fetch" (and "git pull") fetches the
> tags that refer to the commits you fetch as part of regular
> updates, so this part is mostly redundant.

Got it.

> BTW^2, it might be interesting to do
> 
> 	$ git format-patch -C origin..master
> 
> the next time around.

Here's take two.--b.

The current Documentation/tutorial.txt concentrates on the lower-level
git interfaces.  So it's useful to people developing alternative
porcelains, to advanced users, etc., but not so much to beginning users.

I think it makes sense for the main tutorial to address those
beginnning users, so with this patch I'm proposing that we move
Documentation/tutorial.txt to Documentation/core-tutorial.txt and
replace it by a new tutorial.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

 Documentation/core-tutorial.txt |    0 
 Documentation/tutorial.txt      | 2023 ++++++---------------------------------
 2 files changed, 303 insertions(+), 1720 deletions(-)
 copy Documentation/{tutorial.txt => core-tutorial.txt} (100%)

99f6a432f3a4da666d3f535e78cba04085aa1b46
diff --git a/Documentation/tutorial.txt b/Documentation/core-tutorial.txt
similarity index 100%
copy from Documentation/tutorial.txt
copy to Documentation/core-tutorial.txt
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index b8fa299..a09bbea 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -1,1821 +1,404 @@
-A short git tutorial
-====================
+A tutorial introduction to git
+==============================
 
-Introduction
-------------
+This tutorial explains how to import a new project into git, make
+changes to it, and share changes with other developers.
 
-This is trying to be a short tutorial on setting up and using a git
-repository, mainly because being hands-on and using explicit examples is
-often the best way of explaining what is going on.
+First, note that you can get documentation for a command such as "git
+diff" with:
 
-In normal life, most people wouldn't use the "core" git programs
-directly, but rather script around them to make them more palatable. 
-Understanding the core git stuff may help some people get those scripts
-done, though, and it may also be instructive in helping people
-understand what it is that the higher-level helper scripts are actually
-doing. 
+------------------------------------------------
+$ man git-diff
+------------------------------------------------
 
-The core git is often called "plumbing", with the prettier user
-interfaces on top of it called "porcelain". You may not want to use the
-plumbing directly very often, but it can be good to know what the
-plumbing does for when the porcelain isn't flushing.
+Importing a new project
+-----------------------
 
-The material presented here often goes deep describing how things
-work internally.  If you are mostly interested in using git as a
-SCM, you can skip them during your first pass.
+Assume you have a tarball project.tar.gz with your initial work.  You
+can place it under git revision control as follows.
 
-[NOTE]
-And those "too deep" descriptions are often marked as Note.
+------------------------------------------------
+$ tar -xzf project.tar.gz
+$ cd project
+$ git init-db
+------------------------------------------------
 
-[NOTE]
-If you are already familiar with another version control system,
-like CVS, you may want to take a look at
-link:everyday.html[Everyday GIT in 20 commands or so] first
-before reading this.
+Git will reply
 
+------------------------------------------------
+defaulting to local storage area
+------------------------------------------------
 
-Creating a git repository
--------------------------
+You've now initialized the working directory--you may notice a new
+directory created, named ".git".  Tell git that you want it to track
+every file under the current directory with
 
-Creating a new git repository couldn't be easier: all git repositories start
-out empty, and the only thing you need to do is find yourself a
-subdirectory that you want to use as a working tree - either an empty
-one for a totally new project, or an existing working tree that you want
-to import into git. 
+------------------------------------------------
+$ git add .
+------------------------------------------------
 
-For our first example, we're going to start a totally new repository from
-scratch, with no pre-existing files, and we'll call it `git-tutorial`.
-To start up, create a subdirectory for it, change into that
-subdirectory, and initialize the git infrastructure with `git-init-db`:
+Finally,
 
 ------------------------------------------------
-$ mkdir git-tutorial
-$ cd git-tutorial
-$ git-init-db
+$ git commit -a
 ------------------------------------------------
 
-to which git will reply
+will prompt you for a commit message, then record the current state
+of all the files to the repository.
 
-----------------
-defaulting to local storage area
-----------------
+Try modifying some files, then run
 
-which is just git's way of saying that you haven't been doing anything
-strange, and that it will have created a local `.git` directory setup for
-your new project. You will now have a `.git` directory, and you can
-inspect that with `ls`. For your new empty project, it should show you
-three entries, among other things:
-
- - a symlink called `HEAD`, pointing to `refs/heads/master` (if your
-   platform does not have native symlinks, it is a file containing the
-   line "ref: refs/heads/master")
-+
-Don't worry about the fact that the file that the `HEAD` link points to
-doesn't even exist yet -- you haven't created the commit that will
-start your `HEAD` development branch yet.
-
- - a subdirectory called `objects`, which will contain all the
-   objects of your project. You should never have any real reason to
-   look at the objects directly, but you might want to know that these
-   objects are what contains all the real 'data' in your repository.
-
- - a subdirectory called `refs`, which contains references to objects.
-
-In particular, the `refs` subdirectory will contain two other
-subdirectories, named `heads` and `tags` respectively. They do
-exactly what their names imply: they contain references to any number
-of different 'heads' of development (aka 'branches'), and to any
-'tags' that you have created to name specific versions in your
-repository.
-
-One note: the special `master` head is the default branch, which is
-why the `.git/HEAD` file was created as a symlink to it even if it
-doesn't yet exist. Basically, the `HEAD` link is supposed to always
-point to the branch you are working on right now, and you always
-start out expecting to work on the `master` branch.
-
-However, this is only a convention, and you can name your branches
-anything you want, and don't have to ever even 'have' a `master`
-branch. A number of the git tools will assume that `.git/HEAD` is
-valid, though.
-
-[NOTE]
-An 'object' is identified by its 160-bit SHA1 hash, aka 'object name',
-and a reference to an object is always the 40-byte hex
-representation of that SHA1 name. The files in the `refs`
-subdirectory are expected to contain these hex references
-(usually with a final `\'\n\'` at the end), and you should thus
-expect to see a number of 41-byte files containing these
-references in these `refs` subdirectories when you actually start
-populating your tree.
-
-[NOTE]
-An advanced user may want to take a look at the
-link:repository-layout.html[repository layout] document
-after finishing this tutorial.
+------------------------------------------------
+$ git diff
+------------------------------------------------
 
-You have now created your first git repository. Of course, since it's
-empty, that's not very useful, so let's start populating it with data.
+to review your changes.  When you're done,
 
+------------------------------------------------
+$ git commit -a
+------------------------------------------------
 
-Populating a git repository
----------------------------
+will again prompt your for a message describing the change, and then
+record the new versions of the modified files.
 
-We'll keep this simple and stupid, so we'll start off with populating a
-few trivial files just to get a feel for it.
+A note on commit messages: Though not required, it's a good idea to
+begin the commit message with a single short (less than 50 character)
+line summarizing the change, followed by a blank line and then a more
+thorough description.  Tools that turn commits into email, for
+example, use the first line on the Subject line and the rest of the
+commit in the body.
 
-Start off with just creating any random files that you want to maintain
-in your git repository. We'll start off with a few bad examples, just to
-get a feel for how this works:
+To add a new file, first create the file, then
 
 ------------------------------------------------
-$ echo "Hello World" >hello
-$ echo "Silly example" >example
+$ git add path/to/new/file
 ------------------------------------------------
 
-you have now created two files in your working tree (aka 'working directory'), but to
-actually check in your hard work, you will have to go through two steps:
+then commit as usual.  No special command is required when removing a
+file; just remove it, then commit.
 
- - fill in the 'index' file (aka 'cache') with the information about your
-   working tree state.
+At any point you can view the history of your changes using
 
- - commit that index file as an object.
+------------------------------------------------
+$ git whatchanged
+------------------------------------------------
 
-The first step is trivial: when you want to tell git about any changes
-to your working tree, you use the `git-update-index` program. That
-program normally just takes a list of filenames you want to update, but
-to avoid trivial mistakes, it refuses to add new entries to the index
-(or remove existing ones) unless you explicitly tell it that you're
-adding a new entry with the `\--add` flag (or removing an entry with the
-`\--remove`) flag.
+If you also want to see complete diffs at each step, use
 
-So to populate the index with the two files you just created, you can do
+------------------------------------------------
+$ git whatchanged -p
+------------------------------------------------
+
+Managing branches
+-----------------
+
+A single git repository can maintain multiple branches of
+development.  To create a new branch named "experimental", use
 
 ------------------------------------------------
-$ git-update-index --add hello example
+$ git branch experimental
 ------------------------------------------------
 
-and you have now told git to track those two files.
+If you now run
 
-In fact, as you did that, if you now look into your object directory,
-you'll notice that git will have added two new objects to the object
-database. If you did exactly the steps above, you should now be able to do
+------------------------------------------------
+$ git branch
+------------------------------------------------
 
+you'll get a list of all existing branches:
 
-----------------
-$ ls .git/objects/??/*
-----------------
+------------------------------------------------
+  experimental
+* master
+------------------------------------------------
 
-and see two files:
+The "experimental" branch is the one you just created, and the
+"master" branch is a default branch that was created for you
+automatically.  The asterisk marks the branch you are currently on;
+type
 
-----------------
-.git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238 
-.git/objects/f2/4c74a2e500f5ee1332c86b94199f52b1d1d962
-----------------
+------------------------------------------------
+$ git checkout experimental
+------------------------------------------------
 
-which correspond with the objects with names of 557db... and f24c7..
-respectively.
+to switch to the experimental branch.  Now edit a file, commit the
+change, and switch back to the master branch:
 
-If you want to, you can use `git-cat-file` to look at those objects, but
-you'll have to use the object name, not the filename of the object:
+------------------------------------------------
+(edit file)
+$ git commit -a
+$ git checkout master
+------------------------------------------------
 
-----------------
-$ git-cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
-----------------
+Check that the change you made is no longer visible, since it was
+made on the experimental branch and you're back on the master branch.
 
-where the `-t` tells `git-cat-file` to tell you what the "type" of the
-object is. git will tell you that you have a "blob" object (ie just a
-regular file), and you can see the contents with
+You can make a different change on the master branch:
 
-----------------
-$ git-cat-file "blob" 557db03
-----------------
+------------------------------------------------
+(edit file)
+$ git commit -a
+------------------------------------------------
 
-which will print out "Hello World". The object 557db03 is nothing
-more than the contents of your file `hello`.
+at this point the two branches have diverged, with different changes
+made in each.  To merge the changes made in the two branches, run
 
-[NOTE]
-Don't confuse that object with the file `hello` itself. The
-object is literally just those specific *contents* of the file, and
-however much you later change the contents in file `hello`, the object
-we just looked at will never change. Objects are immutable.
+------------------------------------------------
+$ git pull . experimental
+------------------------------------------------
 
-[NOTE]
-The second example demonstrates that you can
-abbreviate the object name to only the first several
-hexadecimal digits in most places.
+If the changes don't conflict, you're done.  If there are conflicts,
+markers will be left in the problematic files showing the conflict;
 
-Anyway, as we mentioned previously, you normally never actually take a
-look at the objects themselves, and typing long 40-character hex
-names is not something you'd normally want to do. The above digression
-was just to show that `git-update-index` did something magical, and
-actually saved away the contents of your files into the git object
-database.
+------------------------------------------------
+$ git diff
+------------------------------------------------
 
-Updating the index did something else too: it created a `.git/index`
-file. This is the index that describes your current working tree, and
-something you should be very aware of. Again, you normally never worry
-about the index file itself, but you should be aware of the fact that
-you have not actually really "checked in" your files into git so far,
-you've only *told* git about them.
+will show this.  Once you've edited the files to resolve the
+conflicts,
 
-However, since git knows about them, you can now start using some of the
-most basic git commands to manipulate the files or look at their status. 
+------------------------------------------------
+$ git commit -a
+------------------------------------------------
 
-In particular, let's not even check in the two files into git yet, we'll
-start off by adding another line to `hello` first:
+will commit the result of the merge. Finally,
 
 ------------------------------------------------
-$ echo "It's a new day for git" >>hello
+$ gitk
 ------------------------------------------------
 
-and you can now, since you told git about the previous state of `hello`, ask
-git what has changed in the tree compared to your old index, using the
-`git-diff-files` command:
+will show a nice graphical representation of the resulting history.
 
-------------
-$ git-diff-files
-------------
+If you develop on a branch crazy-idea, then regret it, you can always
+delete the branch with
 
-Oops. That wasn't very readable. It just spit out its own internal
-version of a `diff`, but that internal version really just tells you
-that it has noticed that "hello" has been modified, and that the old object
-contents it had have been replaced with something else.
+-------------------------------------
+$ git branch -D crazy-idea
+-------------------------------------
 
-To make it readable, we can tell git-diff-files to output the
-differences as a patch, using the `-p` flag:
+Branches are cheap and easy, so this is a good way to try something
+out.
 
-------------
-$ git-diff-files -p
-diff --git a/hello b/hello
-index 557db03..263414f 100644
---- a/hello
-+++ b/hello
-@@ -1 +1,2 @@
- Hello World
-+It's a new day for git
-----
+Using git for collaboration
+---------------------------
 
-i.e. the diff of the change we caused by adding another line to `hello`.
+Suppose that Alice has started a new project with a git repository in
+/home/alice/project, and that Bob, who has a home directory on the
+same machine, wants to contribute.
 
-In other words, `git-diff-files` always shows us the difference between
-what is recorded in the index, and what is currently in the working
-tree. That's very useful.
+Bob begins with:
 
-A common shorthand for `git-diff-files -p` is to just write `git
-diff`, which will do the same thing.
+------------------------------------------------
+$ git clone /home/alice/project myrepo
+------------------------------------------------
 
-------------
-$ git diff
-diff --git a/hello b/hello
-index 557db03..263414f 100644
---- a/hello
-+++ b/hello
-@@ -1 +1,2 @@
- Hello World
-+It's a new day for git
-------------
-
-
-Committing git state
---------------------
-
-Now, we want to go to the next stage in git, which is to take the files
-that git knows about in the index, and commit them as a real tree. We do
-that in two phases: creating a 'tree' object, and committing that 'tree'
-object as a 'commit' object together with an explanation of what the
-tree was all about, along with information of how we came to that state.
-
-Creating a tree object is trivial, and is done with `git-write-tree`.
-There are no options or other input: git-write-tree will take the
-current index state, and write an object that describes that whole
-index. In other words, we're now tying together all the different
-filenames with their contents (and their permissions), and we're
-creating the equivalent of a git "directory" object:
-
-------------------------------------------------
-$ git-write-tree
-------------------------------------------------
-
-and this will just output the name of the resulting tree, in this case
-(if you have done exactly as I've described) it should be
-
-----------------
-8988da15d077d4829fc51d8544c097def6644dbb
-----------------
-
-which is another incomprehensible object name. Again, if you want to,
-you can use `git-cat-file -t 8988d\...` to see that this time the object
-is not a "blob" object, but a "tree" object (you can also use
-`git-cat-file` to actually output the raw object contents, but you'll see
-mainly a binary mess, so that's less interesting).
-
-However -- normally you'd never use `git-write-tree` on its own, because
-normally you always commit a tree into a commit object using the
-`git-commit-tree` command. In fact, it's easier to not actually use
-`git-write-tree` on its own at all, but to just pass its result in as an
-argument to `git-commit-tree`.
-
-`git-commit-tree` normally takes several arguments -- it wants to know
-what the 'parent' of a commit was, but since this is the first commit
-ever in this new repository, and it has no parents, we only need to pass in
-the object name of the tree. However, `git-commit-tree`
-also wants to get a commit message
-on its standard input, and it will write out the resulting object name for the
-commit to its standard output.
-
-And this is where we create the `.git/refs/heads/master` file
-which is pointed at by `HEAD`. This file is supposed to contain
-the reference to the top-of-tree of the master branch, and since
-that's exactly what `git-commit-tree` spits out, we can do this
-all with a sequence of simple shell commands:
-
-------------------------------------------------
-$ tree=$(git-write-tree)
-$ commit=$(echo 'Initial commit' | git-commit-tree $tree)
-$ git-update-ref HEAD $commit
-------------------------------------------------
-
-which will say:
-
-----------------
-Committing initial tree 8988da15d077d4829fc51d8544c097def6644dbb
-----------------
-
-just to warn you about the fact that it created a totally new commit
-that is not related to anything else. Normally you do this only *once*
-for a project ever, and all later commits will be parented on top of an
-earlier commit, and you'll never see this "Committing initial tree"
-message ever again.
-
-Again, normally you'd never actually do this by hand. There is a
-helpful script called `git commit` that will do all of this for you. So
-you could have just written `git commit`
-instead, and it would have done the above magic scripting for you.
-
-
-Making a change
----------------
-
-Remember how we did the `git-update-index` on file `hello` and then we
-changed `hello` afterward, and could compare the new state of `hello` with the
-state we saved in the index file? 
-
-Further, remember how I said that `git-write-tree` writes the contents
-of the *index* file to the tree, and thus what we just committed was in
-fact the *original* contents of the file `hello`, not the new ones. We did
-that on purpose, to show the difference between the index state, and the
-state in the working tree, and how they don't have to match, even
-when we commit things.
-
-As before, if we do `git-diff-files -p` in our git-tutorial project,
-we'll still see the same difference we saw last time: the index file
-hasn't changed by the act of committing anything. However, now that we
-have committed something, we can also learn to use a new command:
-`git-diff-index`.
-
-Unlike `git-diff-files`, which showed the difference between the index
-file and the working tree, `git-diff-index` shows the differences
-between a committed *tree* and either the index file or the working
-tree. In other words, `git-diff-index` wants a tree to be diffed
-against, and before we did the commit, we couldn't do that, because we
-didn't have anything to diff against. 
-
-But now we can do
-
-----------------
-$ git-diff-index -p HEAD
-----------------
-
-(where `-p` has the same meaning as it did in `git-diff-files`), and it
-will show us the same difference, but for a totally different reason. 
-Now we're comparing the working tree not against the index file,
-but against the tree we just wrote. It just so happens that those two
-are obviously the same, so we get the same result.
-
-Again, because this is a common operation, you can also just shorthand
-it with
-
-----------------
-$ git diff HEAD
-----------------
-
-which ends up doing the above for you.
-
-In other words, `git-diff-index` normally compares a tree against the
-working tree, but when given the `\--cached` flag, it is told to
-instead compare against just the index cache contents, and ignore the
-current working tree state entirely. Since we just wrote the index
-file to HEAD, doing `git-diff-index \--cached -p HEAD` should thus return
-an empty set of differences, and that's exactly what it does. 
-
-[NOTE]
-================
-`git-diff-index` really always uses the index for its
-comparisons, and saying that it compares a tree against the working
-tree is thus not strictly accurate. In particular, the list of
-files to compare (the "meta-data") *always* comes from the index file,
-regardless of whether the `\--cached` flag is used or not. The `\--cached`
-flag really only determines whether the file *contents* to be compared
-come from the working tree or not.
-
-This is not hard to understand, as soon as you realize that git simply
-never knows (or cares) about files that it is not told about
-explicitly. git will never go *looking* for files to compare, it
-expects you to tell it what the files are, and that's what the index
-is there for.
-================
-
-However, our next step is to commit the *change* we did, and again, to
-understand what's going on, keep in mind the difference between "working
-tree contents", "index file" and "committed tree". We have changes
-in the working tree that we want to commit, and we always have to
-work through the index file, so the first thing we need to do is to
-update the index cache:
-
-------------------------------------------------
-$ git-update-index hello
-------------------------------------------------
-
-(note how we didn't need the `\--add` flag this time, since git knew
-about the file already).
-
-Note what happens to the different `git-diff-\*` versions here. After
-we've updated `hello` in the index, `git-diff-files -p` now shows no
-differences, but `git-diff-index -p HEAD` still *does* show that the
-current state is different from the state we committed. In fact, now
-`git-diff-index` shows the same difference whether we use the `--cached`
-flag or not, since now the index is coherent with the working tree.
-
-Now, since we've updated `hello` in the index, we can commit the new
-version. We could do it by writing the tree by hand again, and
-committing the tree (this time we'd have to use the `-p HEAD` flag to
-tell commit that the HEAD was the *parent* of the new commit, and that
-this wasn't an initial commit any more), but you've done that once
-already, so let's just use the helpful script this time:
-
-------------------------------------------------
-$ git commit
-------------------------------------------------
-
-which starts an editor for you to write the commit message and tells you
-a bit about what you have done.
-
-Write whatever message you want, and all the lines that start with '#'
-will be pruned out, and the rest will be used as the commit message for
-the change. If you decide you don't want to commit anything after all at
-this point (you can continue to edit things and update the index), you
-can just leave an empty message. Otherwise `git commit` will commit
-the change for you.
-
-You've now made your first real git commit. And if you're interested in
-looking at what `git commit` really does, feel free to investigate:
-it's a few very simple shell scripts to generate the helpful (?) commit
-message headers, and a few one-liners that actually do the
-commit itself (`git-commit`).
-
-
-Inspecting Changes
-------------------
-
-While creating changes is useful, it's even more useful if you can tell
-later what changed. The most useful command for this is another of the
-`diff` family, namely `git-diff-tree`.
-
-`git-diff-tree` can be given two arbitrary trees, and it will tell you the
-differences between them. Perhaps even more commonly, though, you can
-give it just a single commit object, and it will figure out the parent
-of that commit itself, and show the difference directly. Thus, to get
-the same diff that we've already seen several times, we can now do
-
-----------------
-$ git-diff-tree -p HEAD
-----------------
-
-(again, `-p` means to show the difference as a human-readable patch),
-and it will show what the last commit (in `HEAD`) actually changed.
-
-[NOTE]
-============
-Here is an ASCII art by Jon Loeliger that illustrates how
-various diff-\* commands compare things.
-
-                      diff-tree
-                       +----+
-                       |    |
-                       |    |
-                       V    V
-                    +-----------+
-                    | Object DB |
-                    |  Backing  |
-                    |   Store   |
-                    +-----------+
-                      ^    ^
-                      |    |
-                      |    |  diff-index --cached
-                      |    |
-          diff-index  |    V
-                      |  +-----------+
-                      |  |   Index   |
-                      |  |  "cache"  |
-                      |  +-----------+
-                      |    ^
-                      |    |
-                      |    |  diff-files
-                      |    |
-                      V    V
-                    +-----------+
-                    |  Working  |
-                    | Directory |
-                    +-----------+
-============
-
-More interestingly, you can also give `git-diff-tree` the `-v` flag, which
-tells it to also show the commit message and author and date of the
-commit, and you can tell it to show a whole series of diffs.
-Alternatively, you can tell it to be "silent", and not show the diffs at
-all, but just show the actual commit message.
-
-In fact, together with the `git-rev-list` program (which generates a
-list of revisions), `git-diff-tree` ends up being a veritable fount of
-changes. A trivial (but very useful) script called `git-whatchanged` is
-included with git which does exactly this, and shows a log of recent
-activities.
-
-To see the whole history of our pitiful little git-tutorial project, you
-can do
-
-----------------
-$ git log
-----------------
-
-which shows just the log messages, or if we want to see the log together
-with the associated patches use the more complex (and much more
-powerful)
-
-----------------
-$ git-whatchanged -p --root
-----------------
-
-and you will see exactly what has changed in the repository over its
-short history. 
-
-[NOTE]
-The `\--root` flag is a flag to `git-diff-tree` to tell it to
-show the initial aka 'root' commit too. Normally you'd probably not
-want to see the initial import diff, but since the tutorial project
-was started from scratch and is so small, we use it to make the result
-a bit more interesting.
-
-With that, you should now be having some inkling of what git does, and
-can explore on your own.
-
-[NOTE]
-Most likely, you are not directly using the core
-git Plumbing commands, but using Porcelain like Cogito on top
-of it. Cogito works a bit differently and you usually do not
-have to run `git-update-index` yourself for changed files (you
-do tell underlying git about additions and removals via
-`cg-add` and `cg-rm` commands). Just before you make a commit
-with `cg-commit`, Cogito figures out which files you modified,
-and runs `git-update-index` on them for you.
+This creates a new directory "myrepo" containing a clone of Alice's
+repository.  The clone is on an equal footing with the original
+project, posessing its own copy of the original project's history.
 
+Bob then makes some changes and commits them:
 
-Tagging a version
------------------
+------------------------------------------------
+(edit files)
+$ git commit -a
+(repeat as necessary)
+------------------------------------------------
+
+When he's ready, he tells Alice to pull changes from the repository
+at /home/bob/myrepo.  She does this with:
+
+------------------------------------------------
+$ cd /home/alice/project
+$ git pull /home/bob/myrepo
+------------------------------------------------
+
+This actually pulls changes from the branch in Bob's repository named
+"master".  Alice could request a different branch by adding the name
+of the branch to the end of the git pull command line.
+
+This merges Bob's changes into her repository; "git whatchanged" will
+now show the new commits.  If Alice has made her own changes in the
+meantime, then Bob's changes will be merged in, and she will need to
+manually fix any conflicts.
 
-In git, there are two kinds of tags, a "light" one, and an "annotated tag".
+A more cautious Alice might wish to examine Bob's changes before
+pulling them.  She can do this by creating a temporary branch just
+for the purpose of studying Bob's changes:
 
-A "light" tag is technically nothing more than a branch, except we put
-it in the `.git/refs/tags/` subdirectory instead of calling it a `head`.
-So the simplest form of tag involves nothing more than
-
-------------------------------------------------
-$ git tag my-first-tag
-------------------------------------------------
-
-which just writes the current `HEAD` into the `.git/refs/tags/my-first-tag`
-file, after which point you can then use this symbolic name for that
-particular state. You can, for example, do
-
-----------------
-$ git diff my-first-tag
-----------------
-
-to diff your current state against that tag (which at this point will
-obviously be an empty diff, but if you continue to develop and commit
-stuff, you can use your tag as an "anchor-point" to see what has changed
-since you tagged it.
-
-An "annotated tag" is actually a real git object, and contains not only a
-pointer to the state you want to tag, but also a small tag name and
-message, along with optionally a PGP signature that says that yes,
-you really did
-that tag. You create these annotated tags with either the `-a` or
-`-s` flag to `git tag`:
-
-----------------
-$ git tag -s <tagname>
-----------------
-
-which will sign the current `HEAD` (but you can also give it another
-argument that specifies the thing to tag, ie you could have tagged the
-current `mybranch` point by using `git tag <tagname> mybranch`).
-
-You normally only do signed tags for major releases or things
-like that, while the light-weight tags are useful for any marking you
-want to do -- any time you decide that you want to remember a certain
-point, just create a private tag for it, and you have a nice symbolic
-name for the state at that point.
-
-
-Copying repositories
---------------------
-
-git repositories are normally totally self-sufficient and relocatable
-Unlike CVS, for example, there is no separate notion of
-"repository" and "working tree". A git repository normally *is* the
-working tree, with the local git information hidden in the `.git`
-subdirectory. There is nothing else. What you see is what you got.
-
-[NOTE]
-You can tell git to split the git internal information from
-the directory that it tracks, but we'll ignore that for now: it's not
-how normal projects work, and it's really only meant for special uses.
-So the mental model of "the git information is always tied directly to
-the working tree that it describes" may not be technically 100%
-accurate, but it's a good model for all normal use.
-
-This has two implications: 
-
- - if you grow bored with the tutorial repository you created (or you've
-   made a mistake and want to start all over), you can just do simple
-+
-----------------
-$ rm -rf git-tutorial
-----------------
-+
-and it will be gone. There's no external repository, and there's no
-history outside the project you created.
-
- - if you want to move or duplicate a git repository, you can do so. There
-   is `git clone` command, but if all you want to do is just to
-   create a copy of your repository (with all the full history that
-   went along with it), you can do so with a regular
-   `cp -a git-tutorial new-git-tutorial`.
-+
-Note that when you've moved or copied a git repository, your git index
-file (which caches various information, notably some of the "stat"
-information for the files involved) will likely need to be refreshed.
-So after you do a `cp -a` to create a new copy, you'll want to do
-+
-----------------
-$ git-update-index --refresh
-----------------
-+
-in the new repository to make sure that the index file is up-to-date.
-
-Note that the second point is true even across machines. You can
-duplicate a remote git repository with *any* regular copy mechanism, be it
-`scp`, `rsync` or `wget`.
-
-When copying a remote repository, you'll want to at a minimum update the
-index cache when you do this, and especially with other peoples'
-repositories you often want to make sure that the index cache is in some
-known state (you don't know *what* they've done and not yet checked in),
-so usually you'll precede the `git-update-index` with a
-
-----------------
-$ git-read-tree --reset HEAD
-$ git-update-index --refresh
-----------------
-
-which will force a total index re-build from the tree pointed to by `HEAD`.
-It resets the index contents to `HEAD`, and then the `git-update-index`
-makes sure to match up all index entries with the checked-out files.
-If the original repository had uncommitted changes in its
-working tree, `git-update-index --refresh` notices them and
-tells you they need to be updated.
-
-The above can also be written as simply
-
-----------------
-$ git reset
-----------------
-
-and in fact a lot of the common git command combinations can be scripted
-with the `git xyz` interfaces.  You can learn things by just looking
-at what the various git scripts do.  For example, `git reset` is the
-above two lines implemented in `git-reset`, but some things like
-`git status` and `git commit` are slightly more complex scripts around
-the basic git commands.
-
-Many (most?) public remote repositories will not contain any of
-the checked out files or even an index file, and will *only* contain the
-actual core git files. Such a repository usually doesn't even have the
-`.git` subdirectory, but has all the git files directly in the
-repository. 
-
-To create your own local live copy of such a "raw" git repository, you'd
-first create your own subdirectory for the project, and then copy the
-raw repository contents into the `.git` directory. For example, to
-create your own copy of the git repository, you'd do the following
-
-----------------
-$ mkdir my-git
-$ cd my-git
-$ rsync -rL rsync://rsync.kernel.org/pub/scm/git/git.git/ .git
-----------------
-
-followed by 
-
-----------------
-$ git-read-tree HEAD
-----------------
-
-to populate the index. However, now you have populated the index, and
-you have all the git internal files, but you will notice that you don't
-actually have any of the working tree files to work on. To get
-those, you'd check them out with
-
-----------------
-$ git-checkout-index -u -a
-----------------
-
-where the `-u` flag means that you want the checkout to keep the index
-up-to-date (so that you don't have to refresh it afterward), and the
-`-a` flag means "check out all files" (if you have a stale copy or an
-older version of a checked out tree you may also need to add the `-f`
-flag first, to tell git-checkout-index to *force* overwriting of any old
-files). 
-
-Again, this can all be simplified with
-
-----------------
-$ git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git
-$ cd my-git
-$ git checkout
-----------------
-
-which will end up doing all of the above for you.
-
-You have now successfully copied somebody else's (mine) remote
-repository, and checked it out. 
-
-
-Creating a new branch
----------------------
-
-Branches in git are really nothing more than pointers into the git
-object database from within the `.git/refs/` subdirectory, and as we
-already discussed, the `HEAD` branch is nothing but a symlink to one of
-these object pointers. 
-
-You can at any time create a new branch by just picking an arbitrary
-point in the project history, and just writing the SHA1 name of that
-object into a file under `.git/refs/heads/`. You can use any filename you
-want (and indeed, subdirectories), but the convention is that the
-"normal" branch is called `master`. That's just a convention, though,
-and nothing enforces it. 
-
-To show that as an example, let's go back to the git-tutorial repository we
-used earlier, and create a branch in it. You do that by simply just
-saying that you want to check out a new branch:
-
-------------
-$ git checkout -b mybranch
-------------
-
-will create a new branch based at the current `HEAD` position, and switch
-to it. 
-
-[NOTE]
-================================================
-If you make the decision to start your new branch at some
-other point in the history than the current `HEAD`, you can do so by
-just telling `git checkout` what the base of the checkout would be.
-In other words, if you have an earlier tag or branch, you'd just do
-
-------------
-$ git checkout -b mybranch earlier-commit
-------------
-
-and it would create the new branch `mybranch` at the earlier commit,
-and check out the state at that time.
-================================================
+-------------------------------------
+$ git fetch /home/bob/myrepo master:bob-incoming
+-------------------------------------
+
+which fetches the changes from Bob's master branch into a new branch
+named bob-incoming.  (Unlike git pull, git fetch just fetches a copy
+of Bob's line of development without doing any merging).  Then
+
+-------------------------------------
+$ git whatchanged -p master..bob-incoming
+-------------------------------------
 
-You can always just jump back to your original `master` branch by doing
+shows a list of all the changes that Bob made since he branched from
+Alice's master branch.
 
-------------
+After examing those changes, and possibly fixing things, Alice can
+pull the changes into her master branch:
+
+-------------------------------------
 $ git checkout master
-------------
+$ git pull . bob-incoming
+-------------------------------------
 
-(or any other branch-name, for that matter) and if you forget which
-branch you happen to be on, a simple
+The last command is a pull from the "bob-incoming" branch in Alice's
+own repository.
 
-------------
-$ ls -l .git/HEAD
-------------
+Later, Bob can update his repo with Alice's latest changes using
 
-will tell you where it's pointing (Note that on platforms with bad or no
-symlink support, you have to execute
+-------------------------------------
+$ git pull
+-------------------------------------
 
-------------
-$ cat .git/HEAD
-------------
+Note that he doesn't need to give the path to Alice's repository;
+when Bob cloned Alice's repository, git stored the location of her
+repository in the file .git/remotes/origin, and that location is used
+as the default for pulls.
 
-instead). To get the list of branches you have, you can say
+Bob may also notice a branch in his repository that he didn't create:
 
-------------
+-------------------------------------
 $ git branch
-------------
+* master
+  origin
+-------------------------------------
 
-which is nothing more than a simple script around `ls .git/refs/heads`.
-There will be asterisk in front of the branch you are currently on.
+The "origin" branch, which was created automatically by "git clone",
+is a pristine copy of Alice's master branch; Bob should never commit
+to it.
 
-Sometimes you may wish to create a new branch _without_ actually
-checking it out and switching to it. If so, just use the command
+If Bob later decides to work from a different host, he can still
+perform clones and pulls using the ssh protocol:
 
-------------
-$ git branch <branchname> [startingpoint]
-------------
+-------------------------------------
+$ git clone alice.org:/home/alice/project myrepo
+-------------------------------------
 
-which will simply _create_ the branch, but will not do anything further. 
-You can then later -- once you decide that you want to actually develop
-on that branch -- switch to that branch with a regular `git checkout`
-with the branchname as the argument.
+Alternatively, git has a native protocol, or can use rsync or http;
+see gitlink:git-pull[1] for details.
 
+Git can also be used in a CVS-like mode, with a central repository
+that various users push changes to; see gitlink:git-push[1] and
+link:cvs-migration.html[git for CVS users].
 
-Merging two branches
---------------------
+Keeping track of history
+------------------------
 
-One of the ideas of having a branch is that you do some (possibly
-experimental) work in it, and eventually merge it back to the main
-branch. So assuming you created the above `mybranch` that started out
-being the same as the original `master` branch, let's make sure we're in
-that branch, and do some work there.
+Git history is represented as a series of interrelated commits.  The
+most recent commit in the currently checked-out branch can always be
+referred to as HEAD, and the "parent" of any commit can always be
+referred to by appending a caret, "^", to the end of the name of the
+commit.  So, for example,
 
-------------------------------------------------
-$ git checkout mybranch
-$ echo "Work, work, work" >>hello
-$ git commit -m 'Some work.' hello
-------------------------------------------------
+-------------------------------------
+git diff HEAD^ HEAD
+-------------------------------------
 
-Here, we just added another line to `hello`, and we used a shorthand for
-doing both `git-update-index hello` and `git commit` by just giving the
-filename directly to `git commit`. The `-m` flag is to give the
-commit log message from the command line.
+shows the difference between the most-recently checked-in state of
+the tree and the previous state, and
 
-Now, to make it a bit more interesting, let's assume that somebody else
-does some work in the original branch, and simulate that by going back
-to the master branch, and editing the same file differently there:
+-------------------------------------
+git diff HEAD^^ HEAD^
+-------------------------------------
 
-------------
-$ git checkout master
-------------
+shows the difference between that previous state and the state two
+commits ago.  Also, HEAD~5 can be used as a shorthand for HEAD^^^^^,
+and more generally HEAD~n can refer to the nth previous commit.
+Commits representing merges have more than one parent, and you can
+specify which parent to follow in that case; see
+gitlink:git-rev-parse[1].
 
-Here, take a moment to look at the contents of `hello`, and notice how they
-don't contain the work we just did in `mybranch` -- because that work
-hasn't happened in the `master` branch at all. Then do
-
-------------
-$ echo "Play, play, play" >>hello
-$ echo "Lots of fun" >>example
-$ git commit -m 'Some fun.' hello example
-------------
-
-since the master branch is obviously in a much better mood.
-
-Now, you've got two branches, and you decide that you want to merge the
-work done. Before we do that, let's introduce a cool graphical tool that
-helps you view what's going on:
-
-----------------
-$ gitk --all
-----------------
-
-will show you graphically both of your branches (that's what the `\--all`
-means: normally it will just show you your current `HEAD`) and their
-histories. You can also see exactly how they came to be from a common
-source. 
-
-Anyway, let's exit `gitk` (`^Q` or the File menu), and decide that we want
-to merge the work we did on the `mybranch` branch into the `master`
-branch (which is currently our `HEAD` too). To do that, there's a nice
-script called `git merge`, which wants to know which branches you want
-to resolve and what the merge is all about:
-
-------------
-$ git merge "Merge work in mybranch" HEAD mybranch
-------------
-
-where the first argument is going to be used as the commit message if
-the merge can be resolved automatically.
-
-Now, in this case we've intentionally created a situation where the
-merge will need to be fixed up by hand, though, so git will do as much
-of it as it can automatically (which in this case is just merge the `example`
-file, which had no differences in the `mybranch` branch), and say:
-
-----------------
-	Trying really trivial in-index merge...
-	fatal: Merge requires file-level merging
-	Nope.
-	...
-	Auto-merging hello 
-	CONFLICT (content): Merge conflict in hello 
-	Automatic merge failed/prevented; fix up by hand
-----------------
-
-which is way too verbose, but it basically tells you that it failed the
-really trivial merge ("Simple merge") and did an "Automatic merge"
-instead, but that too failed due to conflicts in `hello`.
-
-Not to worry. It left the (trivial) conflict in `hello` in the same form you
-should already be well used to if you've ever used CVS, so let's just
-open `hello` in our editor (whatever that may be), and fix it up somehow.
-I'd suggest just making it so that `hello` contains all four lines:
-
-------------
-Hello World
-It's a new day for git
-Play, play, play
-Work, work, work
-------------
-
-and once you're happy with your manual merge, just do a
-
-------------
-$ git commit hello
-------------
-
-which will very loudly warn you that you're now committing a merge
-(which is correct, so never mind), and you can write a small merge
-message about your adventures in git-merge-land.
-
-After you're done, start up `gitk \--all` to see graphically what the
-history looks like. Notice that `mybranch` still exists, and you can
-switch to it, and continue to work with it if you want to. The
-`mybranch` branch will not contain the merge, but next time you merge it
-from the `master` branch, git will know how you merged it, so you'll not
-have to do _that_ merge again.
-
-Another useful tool, especially if you do not always work in X-Window
-environment, is `git show-branch`.
-
-------------------------------------------------
-$ git show-branch master mybranch
-* [master] Merge work in mybranch
- ! [mybranch] Some work.
---
--  [master] Merge work in mybranch
-*+ [mybranch] Some work.
-------------------------------------------------
-
-The first two lines indicate that it is showing the two branches
-and the first line of the commit log message from their
-top-of-the-tree commits, you are currently on `master` branch
-(notice the asterisk `*` character), and the first column for
-the later output lines is used to show commits contained in the
-`master` branch, and the second column for the `mybranch`
-branch. Three commits are shown along with their log messages.
-All of them have non blank characters in the first column (`*`
-shows an ordinary commit on the current branch, `.` is a merge commit), which
-means they are now part of the `master` branch. Only the "Some
-work" commit has the plus `+` character in the second column,
-because `mybranch` has not been merged to incorporate these
-commits from the master branch.  The string inside brackets
-before the commit log message is a short name you can use to
-name the commit.  In the above example, 'master' and 'mybranch'
-are branch heads.  'master~1' is the first parent of 'master'
-branch head.  Please see 'git-rev-parse' documentation if you
-see more complex cases.
-
-Now, let's pretend you are the one who did all the work in
-`mybranch`, and the fruit of your hard work has finally been merged
-to the `master` branch. Let's go back to `mybranch`, and run
-resolve to get the "upstream changes" back to your branch.
-
-------------
-$ git checkout mybranch
-$ git merge "Merge upstream changes." HEAD master
-------------
-
-This outputs something like this (the actual commit object names
-would be different)
-
-----------------
-Updating from ae3a2da... to a80b4aa....
- example |    1 +
- hello   |    1 +
- 2 files changed, 2 insertions(+), 0 deletions(-)
-----------------
-
-Because your branch did not contain anything more than what are
-already merged into the `master` branch, the resolve operation did
-not actually do a merge. Instead, it just updated the top of
-the tree of your branch to that of the `master` branch. This is
-often called 'fast forward' merge.
-
-You can run `gitk \--all` again to see how the commit ancestry
-looks like, or run `show-branch`, which tells you this.
-
-------------------------------------------------
-$ git show-branch master mybranch
-! [master] Merge work in mybranch
- * [mybranch] Merge work in mybranch
---
--- [master] Merge work in mybranch
-------------------------------------------------
-
-
-Merging external work
----------------------
-
-It's usually much more common that you merge with somebody else than
-merging with your own branches, so it's worth pointing out that git
-makes that very easy too, and in fact, it's not that different from
-doing a `git merge`. In fact, a remote merge ends up being nothing
-more than "fetch the work from a remote repository into a temporary tag"
-followed by a `git merge`.
-
-Fetching from a remote repository is done by, unsurprisingly,
-`git fetch`:
-
-----------------
-$ git fetch <remote-repository>
-----------------
-
-One of the following transports can be used to name the
-repository to download from:
-
-Rsync::
-	`rsync://remote.machine/path/to/repo.git/`
-+
-Rsync transport is usable for both uploading and downloading,
-but is completely unaware of what git does, and can produce
-unexpected results when you download from the public repository
-while the repository owner is uploading into it via `rsync`
-transport.  Most notably, it could update the files under
-`refs/` which holds the object name of the topmost commits
-before uploading the files in `objects/` -- the downloader would
-obtain head commit object name while that object itself is still
-not available in the repository.  For this reason, it is
-considered deprecated.
-
-SSH::
-	`remote.machine:/path/to/repo.git/` or
-+
-`ssh://remote.machine/path/to/repo.git/`
-+
-This transport can be used for both uploading and downloading,
-and requires you to have a log-in privilege over `ssh` to the
-remote machine.  It finds out the set of objects the other side
-lacks by exchanging the head commits both ends have and
-transfers (close to) minimum set of objects.  It is by far the
-most efficient way to exchange git objects between repositories.
-
-Local directory::
-	`/path/to/repo.git/`
-+
-This transport is the same as SSH transport but uses `sh` to run
-both ends on the local machine instead of running other end on
-the remote machine via `ssh`.
-
-git Native::
-	`git://remote.machine/path/to/repo.git/`
-+
-This transport was designed for anonymous downloading.  Like SSH
-transport, it finds out the set of objects the downstream side
-lacks and transfers (close to) minimum set of objects.
-
-HTTP(S)::
-	`http://remote.machine/path/to/repo.git/`
-+
-Downloader from http and https URL
-first obtains the topmost commit object name from the remote site
-by looking at the specified refname under `repo.git/refs/` directory,
-and then tries to obtain the
-commit object by downloading from `repo.git/objects/xx/xxx\...`
-using the object name of that commit object.  Then it reads the
-commit object to find out its parent commits and the associate
-tree object; it repeats this process until it gets all the
-necessary objects.  Because of this behaviour, they are
-sometimes also called 'commit walkers'.
-+
-The 'commit walkers' are sometimes also called 'dumb
-transports', because they do not require any git aware smart
-server like git Native transport does.  Any stock HTTP server
-that does not even support directory index would suffice.  But
-you must prepare your repository with `git-update-server-info`
-to help dumb transport downloaders.
-+
-There are (confusingly enough) `git-ssh-fetch` and `git-ssh-upload`
-programs, which are 'commit walkers'; they outlived their
-usefulness when git Native and SSH transports were introduced,
-and not used by `git pull` or `git push` scripts.
-
-Once you fetch from the remote repository, you `resolve` that
-with your current branch.
-
-However -- it's such a common thing to `fetch` and then
-immediately `resolve`, that it's called `git pull`, and you can
-simply do
-
-----------------
-$ git pull <remote-repository>
-----------------
-
-and optionally give a branch-name for the remote end as a second
-argument.
-
-[NOTE]
-You could do without using any branches at all, by
-keeping as many local repositories as you would like to have
-branches, and merging between them with `git pull`, just like
-you merge between branches. The advantage of this approach is
-that it lets you keep set of files for each `branch` checked
-out and you may find it easier to switch back and forth if you
-juggle multiple lines of development simultaneously. Of
-course, you will pay the price of more disk usage to hold
-multiple working trees, but disk space is cheap these days.
-
-[NOTE]
-You could even pull from your own repository by
-giving '.' as <remote-repository> parameter to `git pull`.  This
-is useful when you want to merge a local branch (or more, if you
-are making an Octopus) into the current branch.
-
-It is likely that you will be pulling from the same remote
-repository from time to time. As a short hand, you can store
-the remote repository URL in a file under .git/remotes/
-directory, like this:
-
-------------------------------------------------
-$ mkdir -p .git/remotes/
-$ cat >.git/remotes/linus <<\EOF
-URL: http://www.kernel.org/pub/scm/git/git.git/
-EOF
-------------------------------------------------
-
-and use the filename to `git pull` instead of the full URL.
-The URL specified in such file can even be a prefix
-of a full URL, like this:
-
-------------------------------------------------
-$ cat >.git/remotes/jgarzik <<\EOF
-URL: http://www.kernel.org/pub/scm/linux/git/jgarzik/
-EOF
-------------------------------------------------
-
-
-Examples.
-
-. `git pull linus`
-. `git pull linus tag v0.99.1`
-. `git pull jgarzik/netdev-2.6.git/ e100`
-
-the above are equivalent to:
-
-. `git pull http://www.kernel.org/pub/scm/git/git.git/ HEAD`
-. `git pull http://www.kernel.org/pub/scm/git/git.git/ tag v0.99.1`
-. `git pull http://www.kernel.org/pub/.../jgarzik/netdev-2.6.git e100`
+The name of a branch can also be used to refer to the most recent
+commit on that branch; so you can also say things like
 
+-------------------------------------
+git diff HEAD experimental
+-------------------------------------
 
-How does the merge work?
-------------------------
+to see the difference between the most-recently committed tree in
+the current branch and the most-recently committed tree in the
+experimental branch.
 
-We said this tutorial shows what plumbing does to help you cope
-with the porcelain that isn't flushing, but we so far did not
-talk about how the merge really works.  If you are following
-this tutorial the first time, I'd suggest to skip to "Publishing
-your work" section and come back here later.
-
-OK, still with me?  To give us an example to look at, let's go
-back to the earlier repository with "hello" and "example" file,
-and bring ourselves back to the pre-merge state:
-
-------------
-$ git show-branch --more=3 master mybranch
-! [master] Merge work in mybranch
- * [mybranch] Merge work in mybranch
---
--- [master] Merge work in mybranch
-+* [master^2] Some work.
-+* [master^] Some fun.
-------------
-
-Remember, before running `git merge`, our `master` head was at
-"Some fun." commit, while our `mybranch` head was at "Some
-work." commit.
-
-------------
-$ git checkout mybranch
-$ git reset --hard master^2
-$ git checkout master
-$ git reset --hard master^
-------------
+But you may find it more useful to see the list of commits made in
+the experimental branch but not in the current branch, and
 
-After rewinding, the commit structure should look like this:
+-------------------------------------
+git whatchanged HEAD..experimental
+-------------------------------------
 
-------------
-$ git show-branch
-* [master] Some fun.
- ! [mybranch] Some work.
---
- + [mybranch] Some work.
-*  [master] Some fun.
-*+ [mybranch^] New day.
-------------
-
-Now we are ready to experiment with the merge by hand.
-
-`git merge` command, when merging two branches, uses 3-way merge
-algorithm.  First, it finds the common ancestor between them.
-The command it uses is `git-merge-base`:
-
-------------
-$ mb=$(git-merge-base HEAD mybranch)
-------------
-
-The command writes the commit object name of the common ancestor
-to the standard output, so we captured its output to a variable,
-because we will be using it in the next step.  BTW, the common
-ancestor commit is the "New day." commit in this case.  You can
-tell it by:
-
-------------
-$ git-name-rev $mb
-my-first-tag
-------------
-
-After finding out a common ancestor commit, the second step is
-this:
-
-------------
-$ git-read-tree -m -u $mb HEAD mybranch
-------------
-
-This is the same `git-read-tree` command we have already seen,
-but it takes three trees, unlike previous examples.  This reads
-the contents of each tree into different 'stage' in the index
-file (the first tree goes to stage 1, the second stage 2,
-etc.).  After reading three trees into three stages, the paths
-that are the same in all three stages are 'collapsed' into stage
-0.  Also paths that are the same in two of three stages are
-collapsed into stage 0, taking the SHA1 from either stage 2 or
-stage 3, whichever is different from stage 1 (i.e. only one side
-changed from the common ancestor).
-
-After 'collapsing' operation, paths that are different in three
-trees are left in non-zero stages.  At this point, you can
-inspect the index file with this command:
-
-------------
-$ git-ls-files --stage
-100644 7f8b141b65fdcee47321e399a2598a235a032422 0	example
-100644 263414f423d0e4d70dae8fe53fa34614ff3e2860 1	hello
-100644 06fa6a24256dc7e560efa5687fa84b51f0263c3a 2	hello
-100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
-------------
-
-In our example of only two files, we did not have unchanged
-files so only 'example' resulted in collapsing, but in real-life
-large projects, only small number of files change in one commit,
-and this 'collapsing' tends to trivially merge most of the paths
-fairly quickly, leaving only a handful the real changes in non-zero
-stages.
-
-To look at only non-zero stages, use `\--unmerged` flag:
-
-------------
-$ git-ls-files --unmerged
-100644 263414f423d0e4d70dae8fe53fa34614ff3e2860 1	hello
-100644 06fa6a24256dc7e560efa5687fa84b51f0263c3a 2	hello
-100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
-------------
-
-The next step of merging is to merge these three versions of the
-file, using 3-way merge.  This is done by giving
-`git-merge-one-file` command as one of the arguments to
-`git-merge-index` command:
-
-------------
-$ git-merge-index git-merge-one-file hello
-Auto-merging hello.
-merge: warning: conflicts during merge
-ERROR: Merge conflict in hello.
-fatal: merge program failed
-------------
-
-`git-merge-one-file` script is called with parameters to
-describe those three versions, and is responsible to leave the
-merge results in the working tree.
-It is a fairly straightforward shell script, and
-eventually calls `merge` program from RCS suite to perform a
-file-level 3-way merge.  In this case, `merge` detects
-conflicts, and the merge result with conflict marks is left in
-the working tree..  This can be seen if you run `ls-files
---stage` again at this point:
-
-------------
-$ git-ls-files --stage
-100644 7f8b141b65fdcee47321e399a2598a235a032422 0	example
-100644 263414f423d0e4d70dae8fe53fa34614ff3e2860 1	hello
-100644 06fa6a24256dc7e560efa5687fa84b51f0263c3a 2	hello
-100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
-------------
-
-This is the state of the index file and the working file after
-`git merge` returns control back to you, leaving the conflicting
-merge for you to resolve.  Notice that the path `hello` is still
-unmerged, and what you see with `git diff` at this point is
-differences since stage 2 (i.e. your version).
-
-
-Publishing your work
---------------------
-
-So we can use somebody else's work from a remote repository; but
-how can *you* prepare a repository to let other people pull from
-it?
-
-Your do your real work in your working tree that has your
-primary repository hanging under it as its `.git` subdirectory.
-You *could* make that repository accessible remotely and ask
-people to pull from it, but in practice that is not the way
-things are usually done. A recommended way is to have a public
-repository, make it reachable by other people, and when the
-changes you made in your primary working tree are in good shape,
-update the public repository from it. This is often called
-'pushing'.
-
-[NOTE]
-This public repository could further be mirrored, and that is
-how git repositories at `kernel.org` are managed.
-
-Publishing the changes from your local (private) repository to
-your remote (public) repository requires a write privilege on
-the remote machine. You need to have an SSH account there to
-run a single command, `git-receive-pack`.
-
-First, you need to create an empty repository on the remote
-machine that will house your public repository. This empty
-repository will be populated and be kept up-to-date by pushing
-into it later. Obviously, this repository creation needs to be
-done only once.
-
-[NOTE]
-`git push` uses a pair of programs,
-`git-send-pack` on your local machine, and `git-receive-pack`
-on the remote machine. The communication between the two over
-the network internally uses an SSH connection.
-
-Your private repository's git directory is usually `.git`, but
-your public repository is often named after the project name,
-i.e. `<project>.git`. Let's create such a public repository for
-project `my-git`. After logging into the remote machine, create
-an empty directory:
-
-------------
-$ mkdir my-git.git
-------------
-
-Then, make that directory into a git repository by running
-`git init-db`, but this time, since its name is not the usual
-`.git`, we do things slightly differently:
-
-------------
-$ GIT_DIR=my-git.git git-init-db
-------------
-
-Make sure this directory is available for others you want your
-changes to be pulled by via the transport of your choice. Also
-you need to make sure that you have the `git-receive-pack`
-program on the `$PATH`.
-
-[NOTE]
-Many installations of sshd do not invoke your shell as the login
-shell when you directly run programs; what this means is that if
-your login shell is `bash`, only `.bashrc` is read and not
-`.bash_profile`. As a workaround, make sure `.bashrc` sets up
-`$PATH` so that you can run `git-receive-pack` program.
-
-[NOTE]
-If you plan to publish this repository to be accessed over http,
-you should do `chmod +x my-git.git/hooks/post-update` at this
-point.  This makes sure that every time you push into this
-repository, `git-update-server-info` is run.
-
-Your "public repository" is now ready to accept your changes.
-Come back to the machine you have your private repository. From
-there, run this command:
-
-------------
-$ git push <public-host>:/path/to/my-git.git master
-------------
-
-This synchronizes your public repository to match the named
-branch head (i.e. `master` in this case) and objects reachable
-from them in your current repository.
-
-As a real example, this is how I update my public git
-repository. Kernel.org mirror network takes care of the
-propagation to other publicly visible machines:
-
-------------
-$ git push master.kernel.org:/pub/scm/git/git.git/ 
-------------
+will do that, just as
 
+-------------------------------------
+git whatchanged experimental..HEAD
+-------------------------------------
 
-Packing your repository
------------------------
+will show the list of commits made on the HEAD but not included in
+experimental.
+
+You can also give commits convenient names of your own: after running
+
+-------------------------------------
+$ git-tag v2.5 HEAD^^
+-------------------------------------
 
-Earlier, we saw that one file under `.git/objects/??/` directory
-is stored for each git object you create. This representation
-is efficient to create atomically and safely, but
-not so convenient to transport over the network. Since git objects are
-immutable once they are created, there is a way to optimize the
-storage by "packing them together". The command
-
-------------
-$ git repack
-------------
-
-will do it for you. If you followed the tutorial examples, you
-would have accumulated about 17 objects in `.git/objects/??/`
-directories by now. `git repack` tells you how many objects it
-packed, and stores the packed file in `.git/objects/pack`
-directory.
-
-[NOTE]
-You will see two files, `pack-\*.pack` and `pack-\*.idx`,
-in `.git/objects/pack` directory. They are closely related to
-each other, and if you ever copy them by hand to a different
-repository for whatever reason, you should make sure you copy
-them together. The former holds all the data from the objects
-in the pack, and the latter holds the index for random
-access.
-
-If you are paranoid, running `git-verify-pack` command would
-detect if you have a corrupt pack, but do not worry too much.
-Our programs are always perfect ;-).
-
-Once you have packed objects, you do not need to leave the
-unpacked objects that are contained in the pack file anymore.
-
-------------
-$ git prune-packed
-------------
-
-would remove them for you.
-
-You can try running `find .git/objects -type f` before and after
-you run `git prune-packed` if you are curious.  Also `git
-count-objects` would tell you how many unpacked objects are in
-your repository and how much space they are consuming.
-
-[NOTE]
-`git pull` is slightly cumbersome for HTTP transport, as a
-packed repository may contain relatively few objects in a
-relatively large pack. If you expect many HTTP pulls from your
-public repository you might want to repack & prune often, or
-never.
-
-If you run `git repack` again at this point, it will say
-"Nothing to pack". Once you continue your development and
-accumulate the changes, running `git repack` again will create a
-new pack, that contains objects created since you packed your
-repository the last time. We recommend that you pack your project
-soon after the initial import (unless you are starting your
-project from scratch), and then run `git repack` every once in a
-while, depending on how active your project is.
-
-When a repository is synchronized via `git push` and `git pull`
-objects packed in the source repository are usually stored
-unpacked in the destination, unless rsync transport is used.
-While this allows you to use different packing strategies on
-both ends, it also means you may need to repack both
-repositories every once in a while.
-
-
-Working with Others
--------------------
-
-Although git is a truly distributed system, it is often
-convenient to organize your project with an informal hierarchy
-of developers. Linux kernel development is run this way. There
-is a nice illustration (page 17, "Merges to Mainline") in Randy
-Dunlap's presentation (`http://tinyurl.com/a2jdg`).
-
-It should be stressed that this hierarchy is purely *informal*.
-There is nothing fundamental in git that enforces the "chain of
-patch flow" this hierarchy implies. You do not have to pull
-from only one remote repository.
-
-A recommended workflow for a "project lead" goes like this:
-
-1. Prepare your primary repository on your local machine. Your
-   work is done there.
-
-2. Prepare a public repository accessible to others.
-+
-If other people are pulling from your repository over dumb
-transport protocols (HTTP), you need to keep this repository
-'dumb transport friendly'.  After `git init-db`,
-`$GIT_DIR/hooks/post-update` copied from the standard templates
-would contain a call to `git-update-server-info` but the
-`post-update` hook itself is disabled by default -- enable it
-with `chmod +x post-update`.  This makes sure `git-update-server-info`
-keeps the necessary files up-to-date.
-
-3. Push into the public repository from your primary
-   repository.
-
-4. `git repack` the public repository. This establishes a big
-   pack that contains the initial set of objects as the
-   baseline, and possibly `git prune` if the transport
-   used for pulling from your repository supports packed
-   repositories.
-
-5. Keep working in your primary repository. Your changes
-   include modifications of your own, patches you receive via
-   e-mails, and merges resulting from pulling the "public"
-   repositories of your "subsystem maintainers".
-+
-You can repack this private repository whenever you feel like.
-
-6. Push your changes to the public repository, and announce it
-   to the public.
-
-7. Every once in a while, "git repack" the public repository.
-   Go back to step 5. and continue working.
-
-
-A recommended work cycle for a "subsystem maintainer" who works
-on that project and has an own "public repository" goes like this:
-
-1. Prepare your work repository, by `git clone` the public
-   repository of the "project lead". The URL used for the
-   initial cloning is stored in `.git/remotes/origin`.
-
-2. Prepare a public repository accessible to others, just like
-   the "project lead" person does.
-
-3. Copy over the packed files from "project lead" public
-   repository to your public repository, unless the "project
-   lead" repository lives on the same machine as yours.  In the
-   latter case, you can use `objects/info/alternates` file to
-   point at the repository you are borrowing from.
-
-4. Push into the public repository from your primary
-   repository. Run `git repack`, and possibly `git prune` if the
-   transport used for pulling from your repository supports
-   packed repositories.
-
-5. Keep working in your primary repository. Your changes
-   include modifications of your own, patches you receive via
-   e-mails, and merges resulting from pulling the "public"
-   repositories of your "project lead" and possibly your
-   "sub-subsystem maintainers".
-+
-You can repack this private repository whenever you feel
-like.
-
-6. Push your changes to your public repository, and ask your
-   "project lead" and possibly your "sub-subsystem
-   maintainers" to pull from it.
-
-7. Every once in a while, `git repack` the public repository.
-   Go back to step 5. and continue working.
-
-
-A recommended work cycle for an "individual developer" who does
-not have a "public" repository is somewhat different. It goes
-like this:
-
-1. Prepare your work repository, by `git clone` the public
-   repository of the "project lead" (or a "subsystem
-   maintainer", if you work on a subsystem). The URL used for
-   the initial cloning is stored in `.git/remotes/origin`.
-
-2. Do your work in your repository on 'master' branch.
-
-3. Run `git fetch origin` from the public repository of your
-   upstream every once in a while. This does only the first
-   half of `git pull` but does not merge. The head of the
-   public repository is stored in `.git/refs/heads/origin`.
-
-4. Use `git cherry origin` to see which ones of your patches
-   were accepted, and/or use `git rebase origin` to port your
-   unmerged changes forward to the updated upstream.
-
-5. Use `git format-patch origin` to prepare patches for e-mail
-   submission to your upstream and send it out. Go back to
-   step 2. and continue.
-
-
-Working with Others, Shared Repository Style
---------------------------------------------
-
-If you are coming from CVS background, the style of cooperation
-suggested in the previous section may be new to you. You do not
-have to worry. git supports "shared public repository" style of
-cooperation you are probably more familiar with as well.
-
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
+you can refer to HEAD^^ by the name "v2.5".  If you intend to share
+this name with other people (for example, to identify a release
+version), you should create a "tag" object, and perhaps sign it; see
+gitlink:git-tag[1] for details.
 
+You can revisit the old state of a tree, and make further
+modifications if you wish, using git branch: the command
 
-Bundling your work together
----------------------------
+-------------------------------------
+$ git branch stable-release v2.5
+-------------------------------------
+
+will create a new branch named "stable-release" starting from the
+commit which you tagged with the name v2.5.
 
-It is likely that you will be working on more than one thing at
-a time.  It is easy to manage those more-or-less independent tasks
-using branches with git.
-
-We have already seen how branches work previously,
-with "fun and work" example using two branches.  The idea is the
-same if there are more than two branches.  Let's say you started
-out from "master" head, and have some new code in the "master"
-branch, and two independent fixes in the "commit-fix" and
-"diff-fix" branches:
-
-------------
-$ git show-branch
-! [commit-fix] Fix commit message normalization.
- ! [diff-fix] Fix rename detection.
-  * [master] Release candidate #1
----
- +  [diff-fix] Fix rename detection.
- +  [diff-fix~1] Better common substring algorithm.
-+   [commit-fix] Fix commit message normalization.
-  * [master] Release candidate #1
-++* [diff-fix~2] Pretty-print messages.
-------------
-
-Both fixes are tested well, and at this point, you want to merge
-in both of them.  You could merge in 'diff-fix' first and then
-'commit-fix' next, like this:
-
-------------
-$ git merge 'Merge fix in diff-fix' master diff-fix
-$ git merge 'Merge fix in commit-fix' master commit-fix
-------------
-
-Which would result in:
-
-------------
-$ git show-branch
-! [commit-fix] Fix commit message normalization.
- ! [diff-fix] Fix rename detection.
-  * [master] Merge fix in commit-fix
----
-  - [master] Merge fix in commit-fix
-+ * [commit-fix] Fix commit message normalization.
-  - [master~1] Merge fix in diff-fix
- +* [diff-fix] Fix rename detection.
- +* [diff-fix~1] Better common substring algorithm.
-  * [master~2] Release candidate #1
-++* [master~3] Pretty-print messages.
-------------
-
-However, there is no particular reason to merge in one branch
-first and the other next, when what you have are a set of truly
-independent changes (if the order mattered, then they are not
-independent by definition).  You could instead merge those two
-branches into the current branch at once.  First let's undo what
-we just did and start over.  We would want to get the master
-branch before these two merges by resetting it to 'master~2':
-
-------------
-$ git reset --hard master~2
-------------
-
-You can make sure 'git show-branch' matches the state before
-those two 'git merge' you just did.  Then, instead of running
-two 'git merge' commands in a row, you would pull these two
-branch heads (this is known as 'making an Octopus'):
-
-------------
-$ git pull . commit-fix diff-fix
-$ git show-branch
-! [commit-fix] Fix commit message normalization.
- ! [diff-fix] Fix rename detection.
-  * [master] Octopus merge of branches 'diff-fix' and 'commit-fix'
----
-  - [master] Octopus merge of branches 'diff-fix' and 'commit-fix'
-+ * [commit-fix] Fix commit message normalization.
- +* [diff-fix] Fix rename detection.
- +* [diff-fix~1] Better common substring algorithm.
-  * [master~1] Release candidate #1
-++* [master~2] Pretty-print messages.
-------------
-
-Note that you should not do Octopus because you can.  An octopus
-is a valid thing to do and often makes it easier to view the
-commit history if you are pulling more than two independent
-changes at the same time.  However, if you have merge conflicts
-with any of the branches you are merging in and need to hand
-resolve, that is an indication that the development happened in
-those branches were not independent after all, and you should
-merge two at a time, documenting how you resolved the conflicts,
-and the reason why you preferred changes made in one side over
-the other.  Otherwise it would make the project history harder
-to follow, not easier.
+You can reset the state of any branch to an earlier commit at any
+time with
+
+-------------------------------------
+$ git reset --hard v2.5
+-------------------------------------
 
-[ to be continued.. cvsimports ]
+This will remove all later commits from this branch and reset the
+working tree to the state it had when the given commit was made.  If
+this branch is the only branch containing the later commits, those
+later changes will be lost.  Don't use "git reset" on a
+publicly-visible branch that other developers pull from, as git will
+be confused by history that disappears in this way.
+
+Next Steps
+----------
+
+Some good commands to explore next:
+
+  * gitlink:git-diff[1]: This flexible command does much more than
+    we've seen in the few examples above.
+
+  * gitlink:git-format-patch[1], gitlink:git-am[1]: These convert
+    series of git commits into emailed patches, and vice versa,
+    useful for projects such as the linux kernel which rely heavily
+    on emailed patches.
+
+  * gitlink:git-bisect[1]: When there is a regression in your
+    project, one way to track down the bug is by searching through
+    the history to find the exact commit that's to blame.  Git bisect
+    can help you perform a binary search for that commit.  It is
+    smart enough to perform a close-to-optimal search even in the
+    case of complex non-linear history with lots of merged branches.
+
+Other good starting points include link:everyday.html[Everday GIT
+with 20 Commands Or So] and link:cvs-migration.html[git for CVS
+users].  Also, link:core-tutorial.html[A short git tutorial] gives an
+introduction to lower-level git commands for advanced users and
+developers.
-- 
0.99.8b-g58e3
