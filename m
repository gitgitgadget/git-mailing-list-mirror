X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: [DRAFT 2] Branching and merging with git
Date: 20 Nov 2006 18:51:36 -0500
Message-ID: <20061120235136.4841.qmail@science.horizon.com>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Mon, 20 Nov 2006 23:52:01 +0000 (UTC)
Cc: linux@horizon.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vslghftix.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31960>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmIvR-0007Iw-Aw for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966308AbWKTXvl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966882AbWKTXvk
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:51:40 -0500
Received: from science.horizon.com ([192.35.100.1]:23869 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S966308AbWKTXvi (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:51:38 -0500
Received: (qmail 4842 invoked by uid 1000); 20 Nov 2006 18:51:36 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I tried to incorporate all the suggestions.  There are still a few things
I have to research, and now I'm worried it's getting too long.  Sigh.

Generally, it's wonderful when the whole is greater than the sum of
the parts.  But trying to explain that is difficult, because you have
to explain all the parts before you can explain how they work together
to deliver a feature.

Oh, well.  Perhaps I can rearrange this to talk about remote branches
*after* local merging?

Thanks to everyone who commented.


* Branching and merging in git

In CVS, branches are difficult and awkward to use, and generally
considered an advanced technique.  Many people use CVS for a long time
without departing from the trunk.

Git is very different.  Branching and merging are central to effective use
of git, and if you aren't comfortable with them, you won't be comfortable
with git.  In particular, they are required to share work with other
people.

The only things that are a bit confusing are some of the names.
In particular, at least when beginning:
- You create new branches with "git checkout -b".
  "git branch" should only be used to list and delete branches.
- You share work with "git fetch" and "git push".  These are opposites.
- You merge with "git pull", not "git merge".  "git pull" can also do a
  "git fetch", but that's optional.  What's not optional is the merge.

Also, a good habit it to never commit directly to your main "master"
branch.  Do all work in temporary "topic" branches, and then merge them
into the master.  Most experienced users don't bother to be quite this
purist, but you should err on the side of using separate topic branches,
so it's excellent practice.


* A brief digression on command names

All git commands can be invoked as "git-foo" and "git foo".  This document
uses them interchangably.  But you have to ask for the "git-foo" man page.
Git provides a few other ways to get the man page as well:
	man git-foo
	git help foo
	git foo --help

Git doesn't have a specialized built-in help system; it just shows you
the man pages.

One outstanding problem with git's man pages is that often the most detail
is in the command page that was written first, not the user-friendly
one that you should use.  For example, there are a number of special
cases of the "git diff" command that were written first, and the man
pages for these commands (git-diff-index, git-diff-files, git-diff-tree,
and git-diff-stages) are considerably more informative than the page for
plain git-diff, even though that's the command that you should use 99%
of the time.

Likewise, the man page for the incredibly useful "git show" command is a
sterile wasteland; you have to refer to the git-rev-list and git-diff-tree
man pages to find the many interesting options it supports.

	
"git-foo --help" often gives you the man page as well, but sometimes
gives a different help listing.  (Try "git-rebase --help" and compare
it with "git rebase --help".)

If you care, here's why:

There are over 100 git-* commands.  This has led to some complaints
about the clutter in /usr/bin.  So it's now possible to move the git-*
commands into a separate directory, and you can either add that directory
to your $PATH, or always use the "git" wrapper to find and invoke them.

This is kind of academic as, despite the complaints, I don't know anyone
who has actually removed the git-* forms from the default $PATH.

Since the wrapper was developed, some simple commands have been made
"builtin", so for example, "git diff" is done internally.  There's a
git-diff link to retain compatability.


* Git's representation of history

As you recall from Git 101 (or the git(7) man page), git's largest
data strucure is the object database, holding exactly four kidnds
of objects.  Each of them has a globally unique 40-character hex name
(a.k.a. object IDs) made by hashing its type and contents.  Since this is
an (effectively unforgeable) cryptographic hash, the name of an object
identifies its contents uniquely.  This is what is meant when people
say that git's history is immutable; you can erase it and rewrite it,
but any alterations will have a different name, and it will be obvious
to anyone looking that something has been changed.

Blob objects are the simplest: they record file contents, and contain
uninterpreted bytes.

Tree objects record directory contents; they contain file names,
permissions, and the associated tree or blob object names.

Tag objects are shareable pointers to other objects; they're generally
used to store a digital signature, and generally point to commits.
(Although you can tag any object, including another tag.)

Finaly, there are commit objects.  Every commit points to (contains the
name of) an associated tree object which records the state of the source
code at the time of the commit, and some descriptive data (time, author,
committer, commit comment) about the commit.

Because every commit is associated with one tree, it's considered
"tree-ish", and almost anywhere that git expect a tree object, you can
supply a commit, and it'll understand.  (Tags on commits are likewise
considered "commit-ish", and can be used almost anywhere a commit or
tree is required.)

Most importantly, each commit contains a list of "parent commits", older
commits from which this one is derived.  These pointers are what produce
the history graph.

Typically only one commit (the initial commit) has zero parents.  It's
possible to have more than one such commit (if you merge two projects
with separate histories), but that's unusual.

Many commits have exactly one parent.  These are made by a normal commit
after editing.  From a branching and merging point of view, they're not
too exciting.

And then there are commits which have multiple parents.  Two is most
common, but git allows many more.  There's a limit of sixteen in
the source code, and the most anyone's ever used in real life is 12,
which was generally regarded as overdoing it.  The famous "dodecapus"
is commit 9fdb62af in the linux kernel repository.


Finally, there are references, stored in the .git/refs directory.
These are the human-readable names associated with commits, and the
"root set" from which all other commits should be reachable.

These references are generally divided into two types, although
there is no fundamental difference:
- Tags are references that are intended to be immutable.
  A tag like "v1.2" is a historical record.  Tag references may or may not
  point to tag objects!  If they do, this is called a "heavyweight tag";
  the tag can hold a digital signature and can be shared between repositores.
  "Lightweight tags" point to commits directly, and are not automatically
  shared.
- Heads are references that are intended to be updated.
  They are invariably "lightweight."  "Head" is actually synonymous with
  "branch", although one emphasizes the tip more, while the other directs
  your attention to the entire path that got there.

Either way, they're just a 41-byte file that contains a 40-byte hex
object ID, plus a newline.  Tags are stored in .git/refs/tags, and heads
are stored in .git/refs/heads.  Creating a new branch is literally just
picking a file name and writing the ID of an existing commit into it.

The git programs enforce the immutability of tags, but that's a safety
feature, not something fundamental.  You can rename a tag to the heads
directory and go wild.  (But the git-update-ref helper takes care of
a few corner cases involving symlinks.)

The only limit on branches is clutter.  A number of git commands have
ways to operate on "all heads", and if you have too many, it can get
annoying.  If you're not using a branch, either delete it, or move it
somewhere (like the tags directory) where it won't clutter up the list of
"currently active heads".

(Note that CVS doesn't have this all-heads default, so people tend to
use longer branch names and keep them around after they've been merged
into the trunk.  Old CVS repositories converted to git generally need
an old-branch cleanup.)

Another thing that's worth mentioning is that head and tag names can
contain slashes; i.e. you're allowed to make subdirectories in the
.git/refs/heads and .git/refs/tags directories.  See the man page
for "git-check-ref-format" for full details of legal names.


* Naming revisions

CVS encourages you to tag like crazy, because the only other way to
find a given revision is by date.  Git makes it a lot easier, so most
revisions don't need names.

You can find a full description in the git-rev-parse man page, but here's
a summary.

First of all, every commit has a globally unique name, its 40-digit hex
object ID.  It's a bit long and awkward, but always works.  This is useful
for talking about a specific commit on a mailing list.  You can abbreviate
it to a unique prefix; most people find about 8 digits sufficient.

(Subversion is easier yet, because it assigns a sequential number to each
commit.  However, that isn't possible in a distributed system like git.)

Second, you can refer to a head or tag name.  Git looks in the
following places, in order, for a reference:
	1) .git/<name>
	2) .git/refs/<name>
	3) .git/refs/tags/<name>
	4) .git/refs/heads/<name>
	5) .git/refs/remotes/<name>
	6) .git/refs/remotes/<name>/HEAD

You should avoid having e.g. a head and a tag with the same name, but
if you do, you can specify one or the other with heads/foo and tags/foo.

Third, you can specify a commit relative to another.  The simplest
one is "the parent", specified by appending ^ to a name.  E.g.  HEAD^
or deadbeef^.  If there are multiple parents, then ^ is the same as ^1,
and the others are ^2, ^3, etc.

So the last few commits you've made are HEAD, HEAD^, HEAD^^, HEAD^^^, etc.
After a while, counting carets becomes annoying, so you can abbreviate
^^^^ as ~4.  Note that this only lets you specify the first parent.
If you want to follow a side branch, you have to specify something like
"master~305^2~22".


* Converting between names

Git has three helpers (programs designed mainly for use in shell scripts)
to convert between global object IDs and human-readable names.

The first is git-rev-parse.  This is a general git shell script helper,
which validates the command line and converts object names to absolute
object IDs.  Its man page has a detailed description of the object
name syntax.

The second is git-name-rev, which converts the other way around, giving
a name for the specified commit in terms of the existing references.
This searches the references for the closest descendant of the given
commit.  If called with the --tags option, it'll search only tags,
showing you the next tag on the development path.

Third is git-describe.  This is something like git-name-rev, but
backwards: it finds the closest reference that is an ancestor of the
specified commit.  Its output is not acceptable git input, but takes
the form of either
	v1.2		(tag name), or
	v1.2-g12345678	(commit 12345678, whose nearest ancestor is v1.2)

git-describe's output is intended to be used as a software version
number, something like the "rcsid" feature in RCS and CVS.
By default, git-describe uses only heavyweight tags for its naming,
so they are globally unique, but you can ask for it to be more liberal.

Git has chosen not to implement anything like the RCS/CVS "keyword
substitution" feature, but you can invoke git-describe from a Makefile
and incorporate its output into an executable to achieve a similar effect.


* Working with branches, the trivial cases.

By convention, the local "trunk" of git development is called "master".
This is just the name of the branch it creates when you start an empty
repository.  You can delete it if you don't like the name.

If you create your repository by cloning someone else's repository, the
remote "master" branch is copied to a local branch named "origin".  You
get your own "master" branch which is not tied to the remote repository.

There is always a current head, known as HEAD.  (This is actually a
symbolic link, .git/HEAD, to a file like refs/heads/master.)  Git requires
that this always point to the refs/heads directory.

	Minor technical details:
	1) HEAD used to be a Unix symlink, and can still be though of that
	   way, but for Microsoft support, this is now what's called a
	   "symbolic reference" or symref, and is a plain file containing
	   "ref: refs/heads/master".  Git treats it just like a symlink.
	   There's a git-update-ref helper which writes these.
	2) While HEAD must point to refs/heads, it's legal for it to
	   point to a file that doesn't exist.	This is what happens
	   before the first commit in a brand new repository.

When you do "git commit", a new commit object is created with the old
HEAD as a parent, and the new commit is written to the current head
(pointed to by HEAD).


* The three uses of "git checkout"

Git checkout can do three separate things:

1) Change to a new head

	git checkout [-f|-m] <branch>
   This changes the HEAD symref to point to <branch>, and copies its
   state to the index and the working directory.

   If a file has unsaved changes in the working directory, this tries
   to preserve them.  This is a simple attempt, and requires that the
   modified files(s) are not altered between the old and new HEADs.
   In that case, the version in the working directory is left untouched.

   A more aggressive option is -m, which will try to do a three-way
   (intra-file) merge.  This can fail, leaving unmerged files in the
   index; dealing with this is described later.

   An alternative is to use -f, which will overwrite any unsaved changes
   in the working directory.  This option can be used with no <branch>
   specified (defaults to HEAD) to undo local edits.

2) Revert changes to a small number of files.

	git checkout [<revision>] [--] <paths>
   will copy the version of the <paths> from the index to the working
   directory.  If a <revision> is given, the index for those paths will
   be updated from the given revision before copying from the index to
   the working tree.

   Unlike the version with no <paths> specified, this does NOT change
   HEAD, even if <paths> is ".".

   The "--" is only required if the first <path> could be
   mistaken for a revision.

3) Create a branch.

	git checkout [-f|-m] -b <branch> [revision]
   will create, and switch to, a new branch with the given name.
   This is equivalent to
	git branch <branch> [<revision>]
	git checkout [-f|-m] <branch>
   If <revision> is omitted, it defaults to the current HEAD, in which
   case no working directory files are altered.

   This is the usual way that one creates a new branch to start work
   on it, or checks out a revision that does not have an existing head
   pointing to it.

   Note that you can create a branch at any time up until the git-commit;



* Deleting branches

"git branch -d <head>" is safe.  It deletes the given <head>, but first
it checks that the commit is reachable from the current HEAD.  That is,
you merged the branch in to the current HEAD, or you never did any edits
on that branch.

It's a good idea to create a "topic branch" when you're working on
anything bigger than a one-liner, but it's also a good idea to delete
them when you're done.  The commits are still there in the history.

* Doing rude things to heads: git reset

If you need to overwrite the current HEAD for some reason, the tool to
do it with is "git reset".  There are three levels of reset:

git reset --soft <head>
	This overwrites the current HEAD with the contents of <head>.
	If you omit <head>, it defaults to HEAD, so this does nothing.
git reset [<head>]
git reset --mixed [<head>]
	These overwrite the current HEAD, and copy it to the index,
	undoing any git-update-index commands you may have executed.
	If you omit <head>, it default to HEAD, so there is no change
	to the current branch, but all index changes are undone.
git reset --hard [<head>]
	This does everything mentioned above, and updates the
	working directory.  This throws away all of your in-progress
	edits and gets you a clean copy.  This is also commonly
	used without an explicit <head>, in which case the current
	HEAD is used.


* Using git-reset to fix mistakes

"Oh, no!  I didn't mean to commit *that*!  How do I undo it?"

If you just want to undo a commit, then you can use "git reset HEAD^"
to return the current HEAD to the previous version.  If you want to leave
the commit in the index (this only applies to you if you are familiar with
using the index; see below), then you can use "git reset --soft HEAD^".

And if you want to blow away every record of the changes you made,
you can use "git reset --hard HEAD^"

If you just want a stupid trivial mistake and want to replace the most
recent commit with a corrected one, "git commit --amend" is your friend.
It makes a new commit with HEAD^ rather than HEAD as its ancestor.

It's often much easier to use --amend than fiddle around with git-reset.


* Fixing mistakes without git-reset

git-reset has the problem that it doesn't preserve hacking in progress
in the working directory.  It can leave the working directory alone
(making everything a "hack in progress"), but it can't merge in-progress
changes like git checkout.

So, suppose you've been trying something that should have been simple,
and made three commits to your main branch before realizing that the
problem is harder than you thought, and you want your work so far to be
on a new branch of its own; committing them on the current HEAD (I'll
call it "old") was a mistake.

You don't want to erase anything, just rename it.  Make "new" a copy of
the current "old" and move old back to HEAD^^^ (three commits ago).

While there are ways to do that using git-reset, but far better is
to use "git branch -f":

	git checkout -b new
		Create (and switch to) the "new" branch.
	git branch -f old HEAD^^^
		Forcibly move "old" back three versions.
		(You could also use old~3 or new^^^ or any synonymous name.)

You can use a similar trick to rename a branch.  If it's the current
HEAD, then:

	git checkout -b newname
	git branch -d oldname

and if it's not, then

	git branch newname oldname
	git branch -d oldname

An alternative in the latter case is to just use mv on the raw
.git/refs/heads/oldname file.


* How do I check out an old version?

A very common beginning question is how to check out an old version.
Say you need to compile an old release for test purposes.  "git checkout
v1.2" gives a funny error message.  What's going on?

Well, "git checkout" makes the current HEAD point to the head that
you specify.  And, as previously mentioned, git requires that it point
to something in the .git/refs/heads directory.  So you can't do that.

If you're busy doing things in your working directory, and don't want to
overwrite your work with an old version, then you can get a snapshot with
the (old) git-tar-tree or (new) git-archive commands.  These produce a
tar file (git-archive can also produce a zip file) which is a snapshot
of any version you like.  You can then unpack this file in a different
directory and build it.

However, if you haven't got any edits in progress, and want to check out
the old version into your working directory, just create a temp branch!

	git checkout -b temp v1.2

Will do what you want.  This will also do what you want if you have a
local edit (like the "#define DEBUG 1" mentioned above) that you want
to preserve while working on the old version.

You'll see this in use if you ever use the (highly recommended) git-bisect
tool.  It creates a branch called "bisect" for the duration of the bisect.

(Yes, I have to confess, I sometimes wish that git would enforce the
"HEAD must point to .git/refs/heads" rule when committing (checking in)
rather than when checking out, but that's the way git has grown up.)


Note that if you want *exactly* an old version, with no local hacks,
make sure there are none (with "git status") when doing this.  It's more
convenient if you do it before the checkout, but you'll get the same
answer if you ask afterwards.


Now, what about the complex case: you have local hacks that you
want to keep, but not have polluting the old version?

Well, one way of the other, you'll have to commit it.  If you don't mind
committing your changes to the current branch ("git commit -a"), do that.

If they're not ready to commit, you can commit them anyway, and back
them out when you're done:

	git commit -a -m "Temp commit"
	git checkout -b temp v1.2
	make ; make test ; whatever
	git checkout master
	git branch -d temp
	git reset HEAD^

This leaves both the working directory and the master head in the states
they were in at the beginning.

If you don't like committing to the master branch, you can make a new one.
In this example, it's "work in progress", a.k.a. "wip":

	git checkout -b wip
	git commit -a -m "Temp commit"
	git checkout -b temp v1.2
	make ; make test ; whatever
	git checkout wip
	git branch -d temp
	git reset master
	git checkout master	# Won't change working directory
	git branch -d wip


* Examining history: git-log and git-rev-list

In another example of docs being better on the first command written,
the all-purpose utility for examining history is "git log", but all of
the examples of clever ways to use it are in the git-rev-list man page.
And git-log also has most of git-diff's options.

Other utilities, notably the gitk and qgit GUIs, also use the git-rev-list
command-line options, so it's well worth learning them.


git-rev-list gives you a filtered subset of the repository history.
There are two basic ways that you can do the filtering:

1) By ancestry.  You specify a set of commits to include all the
   ancestors of, and another set to exclude all the ancestors of.
   (For this purpose, a commit is considered an ancestor of itself.)

   So if you want to see all commits between v1.1 and v1.2, you
   can specify

   	git log ^v1.1 v1.2
   or, with a more convenient syntax
   	git log v1.1..v1.2

  However, there are times when you want to specify something more
  complex.  For example, if a big branch that had been in progress since
  v1.0.7 was merged between v1.1 and v1.2, but you don't want to see it,
  you could specify any of:

   	git log v1.2 ^v1.1 ^bigbranch
   	git log ^bigbranch v1.1..v1.2
	git log ^v1.1 bigbranch..v1.2

  They're all equivalent.  Another special syntax that's sometimes
  handy is

	git log branch1...branch2

   Note the three dots.  This generates the symmetric difference between
   the two; basically it's a diff between the commits that went into
   each of them.

   "git log" by default pipes its output through less(1), and generates
   its output from newest to oldest on the fly, so there's no great
   speed penalty to not specifying a starting place.  It'll generate a
   few screen fulls more than you look at, but not waste any more effort
   than that.

2) By path name.  This is a feature which appears to be unique to git.
   If you give git-rev-list (or git-log, or gitk, or qgit) a list of
   pathname prefixes, it will list only commits which touch those
   paths. So "git log drivers/scsi include/scsi" will list only
   commits which alters a file whose name begins with drivers/scsi
   or include/scsi.

   (If there's any possible ambiguity between a path name and a commit
   name, git-rev-list will refuse to proceed.  You can resolve it by
   including "--" on the command line.  Everything before that is a
   commit name; everything after is a path.)

   This filter is in addition to the ancestry filter.  It's also rather
   clever about omitting unnecessary detail.  In particular, if there's
   a side branch which does not touch the given paths, then the entire
   branch, and the merge at the end, will be removed from the log.

You can additionally limit the commits to a certain number, or by date,
author, committer, and so on.

By default, "git log" only shows the commit messages, so it's important to
write good ones.  Other tools compress commit messages down to
the first line, so try to make that as informative as possible.

("git show" is the standard tool for examining a single commit,
and it does show 


* History diagrams

When talking about various situations involving multiple branches,
people often find it handy to draw pictures.  Gitk draws nice pictures
vertically, but for e-mail, ASCII art drawn horizontally is often easier.
Commits are shown as "o", and the links between them with lines drawn with
- / and \.  Time goes left to right, and heads may be labelled with names.

For example:

         o--o--o <-- Branch A
        /
 o--o--o <-- master
        \
         o--o--o <-- Branch B

If someone needs to talk about a particular commit, the character "o"
may be replaced with another letter or number.


* Trivial merges: fast-forward and already up-to-date.

There are two kinds of merge that are particularly simple, and you will
encounter them in git a great deal.  They are mirror images.

Suppose that you are working on branch A and merge in branch B, but no
work has been done to branch B since the last time you merged, or since
you spawned branch A from it.  That is, the history looks like


 o--o--o--o <-- B
           \
	    o--o--o <-- A
or
 o--o--o--o--o--o <-- B
           \     \
	    o--o--o--o--o <-- A

If you then merge B into A, A is described as "already up to date".
It is already a strict superset of B, and the merge does nothing.

In particular, git will not create a dummy commit to record the fact that
a merge was done.  It turns out that are a number of bad things that would
happen if you did this, but for now, I'll just say that git doesn't do it.


Now, the opposite scenario is the "fast-forward" merge.  Suppose you
merge A into B.  Again, A is a strict superset of B.

In this case, git will simply change the head B to point to the same
commit as A and say that it did a "fast-forward" merge.  Again, no commit
object is created to reflect this fact.

The effect is to unclutter the git history.  If I create a topic branch to
work on a feature, do some hacking, and then merge the result back into
the (untouched!) master, the history will look just like I did all the
work on the master directly.  If I then delete the topic branch (because
I'm done using it), the repository state is truly indistinguishable.

While the topic branch existed, you could have done something to the
master branch, in which case the final merge would have been non-trivial,
but if that didn't happen, git produces a simple, easy-to-follow linear
history.

Some people used to heavyweight branches find this confusing; they
think a merge is a big deal and it should be memorialized, but there
are actually excellent reasons for doing this.

The most important one is that a fit of merging back and forth will
eventually end.  Suppose that branches A and B are maintained by separate
developers who like to track each other's work closely.

If the fast-forward case did create a commit, then merging A into B
would produce

 o--o--o--o---------o <-- B
           \       /
	    o--o--o <-- A
then merging B into A would produce:
 o--o--o--o---------o <-- B
           \       / \
	    o--o--o---o <-- A

and further merges would produce more and more dummy commits, all without
ever reaching a steady state, and without making it obvious that the
two heads are actually identical.

Since history lasts forever, cluttering it up with unimportant stuff is a
burden to all future users, and not a good idea.  Allowing the merge of a
branch to be seamless in the simple case encourages lightweight branches.
If you _might_ need a separate branch, create it.  If it turned out that
you didn't, it won't make a difference.


* Exchanging work with other repositories

The basic tools for exchanging work with other repositories are "git
fetch" and "git push".  The fact that "git pull" is not the opposite of
"git push" is often confusing to beginners (it's a superset of git fetch),
but that's the terminology that has grown up.

The unit of sharing in git is the branch.  If you've used branches in
CVS, you'll be familiar with using "CVS update" to pull changes from your
"current branch" in the repository into your working directory.

In Git, you don't pull into the working directory, but rather into a
tracking branch.  You set up a branch in your repository which will be
a copy of the branch in the remote repository.  For example, if you use
"git clone", then the remote "master" branch is tracked by the local
"origin" branch.

Then, when you do a "git fetch", git fetches all of the new commits
and sets the origin head to point to the newly fetched head of the
remote branch.

By default, git checks that this is a trivial fast-forward merge, that
is not throwing away history.  If it finds something like:

o--o--o--o--o--o <-- remote master
       \
        o <-- Local origin

It will complain and abort the fetch.  This is usually a warning that
something has gone wrong - in particular, you forgot that this was
supposed to be a tracking branch and committed some work to it - and it
aborts before throwing your work away.

However, sometimes the remote git user will have a branch name that they
delete and re-create frequently.  There are plenty of reasons to do this.
The most common is doing a "test merge" between various branches in
progress.  They're all unfinished, so the developer of branch A doesn't
want to merge in all the new bugs in branch B, but a tester might want
to create a merged version with both sets of bugs for testing.

The merged version is not intended to be a permanent part of history -
it'll get deleted after the test - but it can still be useful to have
a draft copy.

In this case, you can mark the source branch with a leading "+", to
disable this sanity check.  (See the git-fetch man page for details.)

Note that in this case, you should specifically avoid merging from such
a branch into any non-test branches of your own.  It is, as mentioned,
not intended to be a permanent part of history, so it would be rude
to make it part of your permanent history.  (You still might want to
test-merge it with your work in progress, of course.)

The fact that you should know to treat such branches specially is why
git doesn't try to automatically cope with them.


* Alternate branch naming

The original git scheme mixes tracking branches with all the other heads.
This requires that you remember which branches are tracking branches and
which aren't.  Hopefully, you remember what all your branches are for,
but if you track a lot of remote repositories, you might not remember
what every remote branch is for and what you called it locally.

An alternative convention has been developed (which may become the
default in future), that places copies of the remote servers' heads
under .git/refs/remotes/<server>/<branch>.

Then you can refer to

If you use "git-line --use-separate-remote", it will set

If you want to use the "separate remotes" tracking branch
There's an alternate way, using the --use-separate-remote option
to git-clone.  This sets up a copy of the remote server's heads
under .git/refs/remotes/origin/<name>.  Then you can refer to
"origin/<branch>" whenever you want.

Because the branch names are got under .git/refs/heads, the git
tools will not let you commit to the branch.

* Remotes files

You can specify what to fetch on the git-fetch command line.
That is, you can type

	git fetch <url> src1:dst1 src2:dst2

to fetch the given remote heads src1 and src2
However,
if you intend to monitor another repository on an ongoing basis,
it's generally easier to set up a short-cut by placing the options in
.git/remotes/<name>.

The syntax is explained in the git-fetch man page.  When this is st
up, "git fetch <name>" will retrieve all the branches listed in the
.git/remotes/<name> file.  The ability to fetch multiple branches at
once (such as release, beta, and development) is an advantage of using
a remotes file.

git-fetch with no argument uses the default file .git/remotes/origin.
If you have a single primary "upstream" repository that you sync to,
place it in the origin remotes file, and you can just type "git fetch"
to get all the latest changes.

Note that branches to fetch are identified by "Pull: " lines in the
remotes file.  This is another example of the fetch/pull confusion.
git-pull will be explained eventually.

If you want to follow this convention when manually adding
branches to track, just supply .git/-relative branch names:

	Pull: refs/heads/master:refs/remotes/origin/master
	Pull: refs/heads/beta:refs/remotes/origin/beta
	Pull: refs/heads/alpha:refs/remotes/origin/alpha

[TODO: Explain the git config file alternative.  I need to write a section
on the config file itself first.]

* Cloning

If you want to watch a project that's hosted on a git server, the easiest
way is to use "git clone".

git-clone creates a new repository, sets up a remotes file to reack
every branch in the remote repository, and fetches all those branches.
By default, it maps them to local heads as follows:

- The remote "master" is tracked by the local "origin"
- The local "master" is made a copy of that.
- The remote "origin" is not tracked at all.
- All other heads are tracked by local heads of the same name.

If you use git-clone --use-separate-remote, then a different,
simpler convention for remote heads will be used:

- Every remote <head> is tracked by .git/refs/remotes/origin/<head>.

Either way, the fetch information is all placed in the .git/remotes/origin
file, which (as mentioned above) is the default used by git-fetch if no
argument is supplied.


* Fetching without tracking (advanced)

Whenever a fetch is done, the fetched heads are also stored in
.git/FETCH_HEAD.  This is for use by later merging (coming up
really soon, promise!).  In fact, it's possible to fetch without
writing to any local heads at all.  If you just

	git fetch <url> src1 src2

Then the fetch will be done, but the results will be written nowhere
but .git/FETCH_HEAD.  This is actually the earliest form of git_fetch
impllemented; everything else is a later addition.  It's not something
you'd do on purpose much, except as part of a script that uses FETCH_HEAD,
but it's worth mentioning it in case you type it and wonder what the
heck happened.


* Remote tags

When you fetch to a tracking branch, git-fetch also fetches every
heavyweight tag (one that involves an actual tag object) that
points to a commit reachable from the branch head and installs a
copy locally.

It will never overwrite a pre-existing tag of the same name.
This means that if you publish a heavyweight tag, and then try
to change it, people who fetched the old tag won't see the change!

This is perhaps an excessively liberal policy, but it has worked
well in practice so far.  Still, it does mean that you should
think about who you fetch code from.

Since tags can be PGP-signed, one option would be to verify them
before installing them locally.

In case it helps, the primitive to get a list of remote heads and tags
is git-ls-remote.  It's used by git-clone to get the list of heads to
track, and can be used manually to see what's been added since then that
you might be interested in tracking.


* Git network protocols

There a few basic ways to share a git repository over the 'net, which
break down into "dumb" protocols that just copy files, and the "smart"
git native protocol that can deliver just the objects that you need.

1) http protocol.  This is sub-optimal, but may be all you have.
   The challenge with this is that you have to pack your repository
   into chunks that are neither too big (because you have to download
   all of a chunk to download any of it) not too small (because the
   http request overhead would kill you).  So think carefully about
   how often you run git-repack, and don't run git-repack -a.

   http clients also need some extra index information to help them
   find which pack files they need.  git-update-server-info is the
   command that generates these files, but it's run automatically
   from git-repack, so it's not too important to know.

2) rsync protocol.  This is basically an alternative to http, and
   has the same strictures and limitations.

3) The git protocol.  This is represented with a git:// URL, and talks
   to a dedicated git daemon (see the git-daemin man page) on the
   remote machine.  It uses TP port 9418 by default.  This is a smart
   protocol that understands the git format and does sophisticated
   wire compression.

   It uses more CPU on the server, but less bandwidth.  And it doesn't
   require any special care when repacking.  git-daemon is purposefully
   written to provide read-only service.

4) The git protocol over ssh.  This is a git+ssh:// URL; ssh:// is
   accepted as a synonym.  It has the same efficiency issues as
   plain git.  If you want to limit ssh users to just the git commands
   necessary to share work, git provides a git-shell command that can
   be used as a very limited login shell.

It's been reported that using http or rsync for the initial clone is
faster than the smart git protocol, because the smarts are wasted
when you just need to download everything.  Then you can go into
the remotes/origin file and edit the URL line to git:// for later
smart access.

But unless you want to bother with that very minor optimization,
just remember to use the git native protocol whenever possible.


* Exchanging work with other repositories, part II: git-push

It's simpler to set up git sharing on a pull basis.  If your source
code isn't secret, you can set up a public read-only server very easily
(see the git-daemon man page for details), and have other fetch from that.

However, N developers all pulling from each other is an N^2 mess.
Some centralization helps.

One way is to have a central coordinator (like Linus) who pulls from
all of the developers, and who they in turn pull from.

The other is familiar to users of centralized VCSs: have a central
repository that people can push to.  This generally requires an ssh login
on the server.  You can use git-shell as the login shell if all you want
to allow the account to do is git fetch and push.  (You can use the hook
scripts to enforce rules about who's allowed to do what to which branch.)

Git-push to the remote machine works exactly like git-fetch from the
remote machine.  The objects are moved over, and the branches pushed to
are fast-forwarded.  If fast-forward is impossible, you get an error.

So if you have multiple people committing to a branch on the server,
you will not be allowed to push if someone has pushed more to that branch
since last time you fetched it.

You have to fix the problem locally, and re-try the push when you've
got a new head that includes the most recently pushed work as an ancestor.

This is exactly like "cvs commit" not working if your recent checkout
wasn't the (current) tip of the branch, but git can upload more than
one commit.

The simplest way to resolve the conflict is to merge the remote head with
your local head.  Alternatively, you can rebase your work to the new
head.  (See below for details.)

In either case, this is easiest if you have different local branches
for fetching the remote repository and for pushing to it.

That is, you have one head that just tracks the master repository's
main branch, and another that you add your work to, and push from.
It makes resolving conflicts between the two much easier if you
have a name for each of them.

Like git-fetch, you can specify everything on the command line:

	git-push <url> src1:dst1 src2:dst2 src3:dst3

to upload the local branches src1, src2 and src3 to the corresponding
remote branches, or you can create a .git/remotes/<name> file.
The URL: and any Push: lines in the file are 

(If you need different ssh options for different hosts you push to,
set them up in a .ssh_config file.  You can even have different
options for the same host, as .ssh_config lets you specify "Host alias"
and "HostName real.dom.aim".)


Another use for git-push, even for a solo developer, is sharing your work
with the world.  You can set up a public git server on a high-bandwidth
machine (possibly rented from a hosting service) and then push to it to
publish something.  This also helps keep your private development
branches private; git-daemon doesn't have a way to limit which
branches it exposes to which people.


* Merging (finally!)

I went through everything else first because the most common merge case
is local changes with remote changes.  Not that you can't merge two
branches of your own, but beginners will encounter the local/remote
case first.

The primitive that does the merging is called (guess what?) git-merge.
And there's nothing too terribly wrong with using it.
However, it's usually easier to use the git-pull wrapper.  This merges
the changes from some other branch into the current HEAD and generates
a commit message automatically.

git-merge lets you specify the commit message (rather than generating it
automatically), but that's about it.

The basic git-pull syntax is

	git-pull <repository> <branch>

The repository can be any URL that git supports.  Including, particularly,
a local file.  So to do a simple local merge, you just type

	git-pull . <branch>

So after doing some hacking on branch "foo", you would

	git checkout master
	git pull . foo

and ba-boom, all is done.


Now, you can also specify a remote repository to merge from, using a
git://, http:// or git+ssh:// URL.  This is what Linus does all day
long, and why the git-pull tool is optimized to allow that.  It uses
git-fetch to fetch the remote branch without assigning it a branch name
(as mentioned above, it gets the magic name FETCH_HEAD), and them merges
it into the current HEAD directly.

There is absolutely nothing wrong with doing that, but beginners often
find it confusing to have a single short command do quite so much.
And if you are working closely with someone, it's often more convenient
and less confusing to keep local tracking branches.  Then you can

	git fetch		# Fetches 'origin'
	git pull . origin

It's also possible to give just a single remotes file name to git-pull:

	git pull origin

That does a git fetch, updating all of the listed branches as usual,
then merges the _first_ listed branch into HEAD.  It would be more
cinsistent to merge all the branches, but that's almost never what
you want.

By the way: don't blink, you might miss it!  As I mentioned, pulling is
a very big part of Linus's daily routine, and he's made sure it's fast.
(Actually, you cant miss all the output it produces.)


Just to clarify, because people often get confused:

git-pull is a MERGING tool.  It always does a merge, as well as an optional
fetch.  If you just want to LOOK at a remote branch, use git-fetch.


* Undoing a merge

If you discover that a merge was a mistake, it can be undone just like
any other commit.  The HEAD you merged to is the first parent, so just do

	git reset --hard HEAD^

Since your local git repository is private, it's easy to un-commit;
it's your own private infinite undo.  It's only when you publish
your branch that

This is why Linus likes a git-pull command that does so much in one shot;
if he doesn't like what he pulls, it's easy to undo.


* How merging operates

Git uses the basic three-way merge.  First, it applies it to file names,
then to whole files, and then to lines within files.

To do a three-way merge, you need three versions of a file.  The versions
A and B you want to merge, and a common ancestor, commonly called O.
That is, history proceeds something like:

         o--o--A
        /
 o--o--O
        \
	 o--B

The basic idea is "I want the file O, plus all the changes made from O
to A, plus all the changes made from O to B."  Since the cases where one
of A or B is a direct ancestor of the other have already been disposed
of, the three commits must be different.

For each file, there are a few cases that are trivial, and git gets
these out of the way immediately:

- If A and B are identical, the merged result is obvious.
- If O and A are the same, then the result should be B.
- If O and B are the same, then the result should be A.

In the completely trivial case when O, A and B are the same, then
all three rules apply, they all produce the same obvious result.

Git automatically finds the masrge base O as the most recent
common ancestor of the heads A and B to be merged.

When doing a merge, git uses the above 2-out-of-3 merging rules
three times:

First, the rules are applied to file renames.  So if foo.c is renamed
to bar.c on branch A, then branch B's foo.c will be merged with it
to produce the result.

Second, they're applied to whole files.  If two out of three entire
files are identical, there's nothing more to do.  Since the name of
a blob object uniquely identifies its contents, this lets git do a
considerable amount of merging without even looking at the file contents.

Finally, any files where all three versions are different are loaded
into the index file, with the same file name but marked "stage 1",
"stage 2", and "stage 3", and the classic line-based three-way merge
is used to resolve the mess,  This looks for isolated "hunks" of change
and uses the same 2-out-of-3 rules to resolve each hunk separately.

Only if all three commits have differing hunks that overlap (or come
so glose that git can't be sure) is git unable to automatically resolve
the problem.  This requires manual correction, as described below.

If the merge goes well, it is automatically comitted and the HEAD branch
updated to point to the new commit.


* Merge subtleties (advanced)

As mentioned before, the merge base is the most recent common ancestor
of A and B.  The only problem is, that's not necessarily unique!

The classic confusing case is called a "criss-cross merge", and looks
like this:

         o--b-o-o--B
        /    \ /
 o--o--o      X
        \    / \
	 o--a-o-o--A

There are two most-recent common ancestors of A and B, marked a and b
in the graph above.  And they're not the same.  You could use either
one and get reasonable results, but how to choose?

The details are too advanced for this discussion, but the default
"recursive" merge strategy that git uses solves the answer by merging
a and b into a temporary commit and using *that* as the merge base.

Of course, a and b could have the same problem, so merging them could
require another merge of still-older commits.  This is why the algorithm
is called "recursive."  It's been tested with pathological conditions,
but multiply nested criss-cross merges are very rare, so the recursion
isn't a performance limit in practice.

(This can lead to occasional confusing messages about merge conflicts
that aren't real.  That's because git computes the full merge base,
but if the conflicting file is actually identical in A and B, the
messed-up version in O doesn't matter.)


* Alternate merge strategies (advanced)

In every version control system prior to git, the merging algorithm was
buried deep in the bowels of the software, and very difficult to change.
One of particularly nice things that git did was allow for easily
replaceable "merge strategies".  Indeed, you can try multiple merge
strategies, and the fallback - print an error message and let the user
sort it out - can be thought of as just another merge strategy.

Enabling this is why the index is so important to git.  It provides a
place to store an unfinished merge, so you can try various strategies
(including hand-editing) to finish it.

There are two non-default strategies that have their uses in special
circumstances.


* Octopus merge (advanced)

The first is the "octopus" stratgy.  This is special because it can do
a three- or more-way merge.  See 5401f304 in the git repository for
an example.  (Run gitk, double-click on the "SHA1 ID" box to select
what's already there, enter "5401f304" instead, and click "Goto".)

The octopus strategy is invoked automatically when you specify more
than one branch at a time to merge in with "git pull".  It can't handle
complicated overlaps and file renames as well as the 2-way recursive
strategy, but if you have a number of simple, independent changes that you
want to merge together, an octopus merge is the obvious way to document
the fact that they're truly independent.

The only downside to using an octopus to combine a number of simple
changes is that any merge makes git-bisect's job harder.  If you have
a development history like

    /-b-\
   /     \
  | /-c-\ |
  |/     \|
--a---d---g--
  |\     /|
  | \-e-/ |
   \     /
    \-f-/

And you know that a works but g doesn't, there's no way to do a binary
search on b through f; they have to be searched linearly.  This is
no harder to bisect, and a lot nicer-looking than the equivalent with
2-way merges:

    /-b
   /   \
  | /-c-g
  |/     \
--a---d---h--i--j--
  |\        /  /
  | \-e----/  /
   \         /
    \-f-----/

But if they were just done one after the other, you'd have

--a--b--c--d--e--f--

Which may imply a non-existent dependency between the changes, but
is a bit simpler.  Still, the first octopus merge in git's own development
(211232ba) is of this form.  It's a matter of taste.

For the beginner, the important thing to know is that you never *need*
an octopus.

   
* "Ours" merge (advanced)

The other merge strategy that is surprisingly useful is specified with
the "-s ours" option to git-pull.

This strategy instructs git that the merged result should be the same
as the current HEAD.  Any other branches are recorded as parents, but
their contents are ignored.

What the heck is the use of that?  Well, it lets you record the fact
that some work has been done in the history, and that it shouldn't be
merged again.  For example, say you write and share a popular patch set.
People are always merging it in to their local source trees.  But then
you discover a much better way to achieve the goal of that patch set, and
you want to publish the fact that the new patch supersedes the old one.

If you developed the new set starting from the old one, that would happen
automatically.  But another way to achieve the same goal is to merge the
old branch it in using the "ours" strategy.  Everyone else's git will
notice that the patch is already included, and stop trying to merge it in.


* When merging goes wrong

This is the fun part.  Git's default recursive-merge strategy is pretty
clever, but sometimes changes truly do conflict and need manual fix-up.

When git is unable to complete a merge, it leaves the three different
versions in the index and places a file with CVS-style conflict markers
in the working directory.

As long as there is a "staged" file like this in the index, you will
not be able to commit.  You must resolve the conflict, and update the
index with the resolved versions.  You can do this one at a time with
git-update-index, or at the end by giving the files as arguments to
git-commit.

Doing them one at a time is probably safest; checking in a file which
still has conflict markers makes a bit of a mess.  Git will still use
the automatically generated commit message when you finally commit.
(It's stashed in .git/MERGE_MSG, if you care.)

Note that "git diff" knows how to be useful with a staged file.
By default, it displays a multi-way diff.  For example, suppose I take a
(slightly buggy) hello.c:

--- hello.c ---
#include <stdio.h>

int main(void)
{
	printf("Hello, world!");
}
--- end ---

Now, suppose that in branch A, I fix some bugs - add the missing newline
and "return 0;".  In branch B, I display my angst and change it to
"Goodbye, cruel world!".  When I try to merge A into B, obviously I'll
get a conflict.  The resultant file, with conflict markers, looks like:

--- hello.c ---
#include <stdio.h>

int
main(void)
{
<<<<<<< HEAD/hello.c
        printf("Goodbye, cruel world!");
=======
	printf("Hello, world!\n");
	return 0;
>>>>>>> edadc53fc7a8aef2a672a4fa9d09aa16f4e14706/hello.c
}
--- end ---

and the result of "git diff" is

diff --cc hello.c
index 4b7f550,948a5f8..0000000
--- a/hello.c
+++ b/hello.c
@@@ -3,5 -3,6 +3,10 @@@
  int
  main(void)
  {
++<<<<<<< HEAD/hello.c
 +      printf("Goodbye, cruel world!");
++=======
+       printf("Hello, world!\n");
+       return 0;
++>>>>>>> edadc53fc7a8aef2a672a4fa9d09aa16f4e14706/hello.c
  }

Notice how this is not a standard diff!  It has two columns of diff
symbols, and shows the difference from each of the ancestors to the
current hello.c contents.  I can also use "git diff -1" to compare
against the common ancestor, or "-2" or "-3" to compare against each of
the merged copies individually.

In any case, I have to replace the lines from <<<<<<< to >>>>>>> with
correct code.  Then, unless I'm feeling really brave, I should probably
do a test compile.  Suppose I fix it to read:

--- hello.c ---
#include <stdio.h>

int
main(void)
{
        printf("Goodbye, cruel world!\n");
	return 0;
}
--- end ---

When I'm done, another "git diff" convinces me that I haven't forgotten
any conflict markers anywhere like a comment that doesn't get compiled,
and I can do

	git commit -a

This then prompts me to edit the commit message, but there's a
difference; there's something already written:

--- .git/COMMIT_EDITMSG ---
Merge branch 'A' into B

Conflicts:

        hello.c
#
# It looks like you may be committing a MERGE.
# If this is not correct, please remove the file
#       .git/MERGE_HEAD
# and try again
#

# Please enter the commit message for your changes.
# (Comment lines starting with '#' will not be included)
# On branch refs/heads/B
# Updated but not checked in:
#   (will commit)
#
#       modified: hello.c
--- end ---

This is the automatically generated merge message and a reminder
to future readers of what had to be manually fixed.

In many cases, this is fine, and you can save it and complete the
commit.  Or you can add something about the merge if it needs saying.

When I'm done, if I don't need branch A any more, I can

	git branch -d A


* More on fixing broken merges

Often, a merge conflict is a simple textual issue that git's built-in
merge couldn't quite handle, like two #include additions in the same
place, and it doesn't know that the order doesn't actually matter.

But sometimes, you have real conceptual conflicts between two changes,
and it's not clear what to do.  There are a number of ways to look
through history to see what's going on.

	git log --merge

will show you all the commits that
1) touch files that are unresolved (staged) in the index, and
2) differ between the branches being merged.

By default, this only shows the commit messages, but you can
add all the usual git-log options, like -p to see the patches
themselves.

Note that this doesn't show you which branch each commit is on,
but it's still often useful to see what someone was trying to
do that caused the problem.

You can, of course, add a pathname limiter argument to further restrict
the commits being shown.


* Redoing a merge in case of push conflicts.

When pushing to an upstream repository, the usual procedure is
to merge the remote head and your new development into a push head,
and then push it to the remore repository.  That is, your work looks
like this ("a" commits are your work, "o" commits are other people's):

--o--o
      \
       a--a--a <-- development

And suppose that the upstream repository has grown to

--o--o--o--o--o <-- upstream

So you fetch it:

--o--o--o--o--o <-- from-upstream
      \       
       a--a--a <-- development

And merge it:

--o--o--o--o--o <-- from-upstream
      \        \
       a--a--a--a <-- to-upstream
              

And now you can push it upstream, which will be a simply
fast-forward merge:

--o--o--o--o--o
      \        \
       a--a--a--a <-- upstream

However, if someone else has pushed in the meantime, your push will fail
because it can't fast-forward:

          b--b--b <-- upstream
         /     /
--o--o--o--o--o
      \        \
       a--a--a--a <-- to-upstream

The obvious solution is to re-merge the upstream branch and push again:

          b--b--b
         /     / \
--o--o--o--o--o   \
      \        \   \
       a--a--a--a---a <-- to-upstream

But that puts more merge commits in the history than necessary.
Better is to re-fetch and re-do the merge:

          b--b--b
         /     / \
--o--o--o--o--o   \
      \            \
       a--a--a------a <-- to-upstream

This is just a matter of (starting from the to-upstream branch)

	git fetch		# Fetches "from-upstream"
	git-reset --hard from-upstream
	git pull . development
	git push 


* Alternatives to merging

The bigger and more active your source tree, the more important it is to
keep the history reasonably clean.  Just because git can do a merge in
under a second doesn't mean that you should do one daily.  When you look
back at a feature's development history, you'd like to see meaningful
changes recorded and not a lot of meaningless ones.

Another nice thing to keep out of the published history is commits that
don't compile or are catastrophically buggy.  These makes git-bisect
harder to use, and once you've experienced the joys of git-bisect when
tracking down a newly introduced bug, you'll appreciate why it's good
to keep the public history clean.

Now, once you have shared a commit with others, and they have incorporated
it into their development, it becomes impossible to undo.  But git
provides tools that are useful for "rewriting history" before public
release.  These can be used to edit a commit for publication.


* Test merging

One way to keep the history clean is to simply not merge other branches
into your development branch.  If you want to use your new features and
other people's code changes, make a test merge and use that, but don't
make that merge part of your branch.

This is slightly more work (you have to change to a test branch and do
your merging there), but not very much.

Sometimes, when doing this, a conflict appears between your changes and
someone else's development.  If you get tired of fixing the same conflict
every time you do a test merge, have a look at the git-rerere tool.
This remembers resolved conflicts and tries to apply the same resolution
patch the next time.

It's written specifically to help you not do an extra merge unnecessarily.
Although its man page is well worth reading, you never invoke git-rerere
explicitly; it's invoked automatically by the merge and patch tools if
you create a .git/rr-cache directory.

* Cherry picking

If you have a series of patches on a branch, but you want a subset
of them, or in a different order, there's a handy utility called
"git-cherry-pick" which will find the diff and apply it as a patch to
the current HEAD.  It automatically recycles the commit message from
the original commit.

If the patch can't be applied, it leaves the versions in the index and
conflict markers in the working directory just like a failed merge.
And just like a merge, it remembers the commit message and provides it
as a default when I finally commit.

Note that this can only work on a chain of single-parent commits.
If a commit has multiple parents, there's no single patch to apply.


You can get the list of commits on a branch with git-log or git-rev-list,
but for more complex cases, the git-cherry tool is designed to generate
the list of commits to merge.  It has a rather neat approximate-match
function built in which identifies patches that appear to already be
present in the target branch.


* Rebasing

A special case of cherry-picking is if you want to move a whole branch
to a newer "base" commit.  This is done by git-rebase.  You specify
the branch to move (default HEAD) and where to move it to (no default),
and git cherry-picks every patch out of that branch, applies it on top
of the target, and moves the refs/heads/<branch> pointer to the newly
created commits.

By default, "the branch" is every commit back to the last common
ancestor of the branch head and the target, but you can override that
with command-line arguments.

If you want to avoid merge conflicts due to the master code changing out
from under your edits, but not have "cleanup" merges in your history,
git-rebase is the tool to use.

Git-rebase will also use git-rerere if enabled ("mkdir .git/rr-cache").


If rebasing encounters a conflict it can't resolve, it will stop halfway
and ask you to resolve the problem by hand.  However, it still knows it
has a job to finish!  The unapplied patches are remembered until you do
one of

	git-rebase --continue
		This will check in the current index.  You should
		do git-update-index <files> in the conflicts that
		you resolve, but NOT do an actual git-commit.
		git-rebase --continue will do the commit.
	git-rebase --skip
		This will skip the conflicting patch.  You
		don't have to resolve the conflicts; git will
		just back up and try the next patch in the series.
	git-rebase --abort
		This will abandon the whole rebase operation (including
		any half-done work) and return you to where you began.


* Rebasing 2: splitting a branch

Git-rebase can also help you divide up work.  Suppose you've mixed up
development of two features in the current HEAD, a branch called "dev".
You want to divide them up into "dev1" and "dev2".  Assuming that HEAD
is a branch off master, then you can either look through

	git log master..HEAD
or just get a raw list of the commits with
	git rev-list master..HEAD

Drawing a picture, suppose we start with:

o--o--o--o--o <-- master
    \
     x--y--y--x--x--y <-- dev

And want to end up with
              x--x--x <-- dev1
             /
o--o--o--o--o <-- master
             \
	      y--y <-- dev2

Either way, you'll have to manually figure out a list of vommits that
you want in dev1 and create that branch:

	git checkout -b dev1 master
	for i in `cat commit_list`; do
		git-cherry-pick $i
	done

You can use the other half of the list you edited to generate the dev2
branch, but if you're not sure if you forgot something, or just don't
feel like doing that manual work, then you can use git-rebase to do it
for you...

	git checkout -b dev2 dev	# Create dev2 branch
	git-rebase --onto master dev1	# Subtract dev1 and rebase

This will find all patches that are in dev and not in dev1,
apply them on top of master, and call the result dev2.

That is, after you've manually picked out the dev1 branch commits:

              x--x--x <-- dev1
             /
o--o--o--o--o <-- master
    \
     x--y--y--x--x--y <-- dev, dev2

this will automatically produce:

              x--x--x <-- dev1
             /
o--o--o--o--o <-- master
   |         \
   |          y--y <-- dev2
    \
     x--y--y--x--x--y <-- dev

If you had omitted the "--onto master" part, it would have produced instead
	              y--y <-- dev2
	             /
              x--x--x <-- dev1
             /
o--o--o--o--o <-- master
    \
     x--y--y--x--x--y <-- dev

git-rebase abandons the original branch, since (think about it!) it never
loses a significant change.  In the example here, the branch is
still accessible via the "dev" name, but if you had skipped creating
a "dev2" branch and just called it "dev", that branch would be gone.


* Cherry picking and rebasing: Merging changes

Suppose that you accidentally ommitted a broken source tree,
and forgot to use "git-commit --amend" when comitting the following
one-liner.  Or say you didn't notice the brokenness immediately
and made the fix a few commits later.  But now you want to
rewrite history with the fix merged into the original commit.

Here's a simple way to do it, assuming that you're fixing the
"dev" branch, and the commits to merge are <commit1> and <commit2>:

       1--o--o--2--o--o <-- dev
      /
--o--o

	git status	# Make sure there's no uncommitted work
	git checkout -b temp <commit1>
	git cherry-pick -n <commit2>
	git commit --amend -a

       1--o--o--2--o--o <-- dev
      /
--o--o
      \
       1+2 <-- temp

Now, we can git-rebase the remainder.  The only complication is
that git can't tell that the change from commit2 has been applied,
since the combined 1+2 change isn't "the same".  One option is to
trust that there will be amerge conflict when you try and just do:

	git checkout dev
	git rebase --onto temp <commit1>
	# Which will stop with a conflict
	git rebase --skip
	git branch -d temp

The other is to explicitly do the two stretches separately:

	git checkout -b temp2 <commit2>^
	git rebase --onto temp <commit1>
	git checkout dev
	git rebase --onto temp <commit2>
	git branch -d temp2
	git branch -d temp


[TODO: are there any better tools for reordering patches?  Maybe explain
how to create an mbox file and mess with it?]


* Dirty tricks: evil merges (advanced)

Generally, a merge is supposed to include all the changes made on
both contributing branches, and that's all.  But sometimes, people
slip additional changes in.  This is known as an "evil merge", because
it can be very misleading to someone reading the history.

But occasionally there are good reasons to do that.  For example, look
at the output of "git show v1.0.0" in the git repository itself.

(Recall that git-show uses "git diff --cc", which only shows
hunks that are not trivially taken from one parent or the other.
Any line that starts with "++" is not taken from either parent.)

You'll see that, as the merge was the last thing required for a 1.0.0
release, the git maintainer also bumped the version number and updated
the changelog.  It could have been a separate commit, but didn't seem
worth it.

This was done by forcing the git-pull to not commit:

	git pull --no-commit . <branch>
	(edit as desired)
	git commit

The commit message should be edited to explain that this is not just
a normal merge, as was done in this case.



* Experimenting with git

The best way to learn how git works is to try it.  Once you understand
the basic concept well enough to not delete anything by accident, it's
quite hard to hurt anything.


* Experimenting with fetching

Remember that fetching from a repository on the same machine is both
possible and fast.  So if you want to play around, just make a new
directory, run git-init-db, and give it a try.  You can't hurt the source
repoistory, and deleting the destination is as easy as "rm -rf".

(Of course, you can hurt things with "rm -rf", so make certain you're
in the right directory before excecuting that!)

* Experimenting with merging

To play with non-trivial merging, get an existing git repository of
a non-trivial project (git itself and the Linux kernel are readily
available.  Fire up gitk to look at history, find some interesting-looking
merges, and redo them yourself on a test branch.

As long as you do everything on test branches, you aren't going to screw
anything up.  So play!

You can use gitk to search for "Conflicts:" in the commit comments to
find merges that didn't go smoothly and see what happens.  (Or you can
search in "git log" output.  gitk just draws prettier pictures.)

You can also set up two repositories on the same machine and try pulling
and pushing between them.

To identify arbitrary commits, the 40-byte raw hex ID is probably easiest;
you can cut-and-paste them from the gitk window.

For example, in the git repository,
3f69d405d749742945afd462bff6541604ecd420

looks like an interesting merge.  Its parents are
Parent: 7d55561986ffe94ca7ca22dc0a6846f698893226
Parent: 097dc3d8c32f4b85bf9701d5e1de98999ac25c1c

Let's try doing that manually:

$ git checkout -b test 7d55561986ffe94ca7ca22dc0a6846f698893226
$ git pull . 097dc3d8c32f4b85bf9701d5e1de98999ac25c1c
error: no such remote ref refs/heads/097dc3d8c32f4b85bf9701d5e1de98999ac25c1c
Fetch failure: .

Cool!  I didn't know that wasn't allowed.  (I'll have to ask why it's
not; perhaps it's because it uses the branch name in the automatic
commit message.)  I could do it by hand with git-merge, but I'll just
give it a branch name:

$ git branch test2 097dc3d8c32f4b85bf9701d5e1de98999ac25c1c
$ git pull . test2
Merging HEAD with 097dc3d8c32f4b85bf9701d5e1de98999ac25c1c
Merging:
7d55561986ffe94ca7ca22dc0a6846f698893226 Merge branch 'jc/dirwalk-n-cache-tree' into jc/cache-tree
097dc3d8c32f4b85bf9701d5e1de98999ac25c1c Remove "tree->entries" tree-entry list from tree parser
found 2 common ancestor(s):
d9b814cc97f16daac06566a5340121c446136d22 Add builtin "git rm" command
288c0384505e6c25cc1a162242919a0485d50a74 Merge branch 'js/fetchconfig'
  Merging:
  d9b814cc97f16daac06566a5340121c446136d22 Add builtin "git rm" command
  288c0384505e6c25cc1a162242919a0485d50a74 Merge branch 'js/fetchconfig'
  found 1 common ancestor(s):
  63dffdf03da65ddf1a02c3215ad15ba109189d42 Remove old "git-grep.sh" remnants
  Auto-merging Makefile
merge: warning: conflicts during merge
  CONFLICT (content): Merge conflict in Makefile
  Auto-merging builtin.h
merge: warning: conflicts during merge
  CONFLICT (content): Merge conflict in builtin.h
  Auto-merging cache.h
  Removing check-ref-format.c
  Auto-merging git.c
merge: warning: conflicts during merge
  CONFLICT (content): Merge conflict in git.c
  Auto-merging read-cache.c
  Auto-merging update-index.c
merge: warning: conflicts during merge
  CONFLICT (content): Merge conflict in update-index.c
Renaming apply.c => builtin-apply.c
Auto-merging builtin-apply.c
Renaming read-tree.c => builtin-read-tree.c
Auto-merging builtin-read-tree.c
Auto-merging .gitignore
Auto-merging Makefile
merge: warning: conflicts during merge
CONFLICT (content): Merge conflict in Makefile
Auto-merging builtin.h
merge: warning: conflicts during merge
CONFLICT (content): Merge conflict in builtin.h
Auto-merging cache.h
Auto-merging fsck-objects.c
Removing git-format-patch.sh
Auto-merging git.c
merge: warning: conflicts during merge
CONFLICT (content): Merge conflict in git.c
Auto-merging update-index.c
Automatic merge failed; fix conflicts and then commit the result.

$ git status
Hey, look, lots of interesting stuff.  Particularly, see
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       unmerged: Makefile
#       modified: Makefile
#       unmerged: builtin.h
#       modified: builtin.h
#       unmerged: git.c
#       modified: git.c

The "unmerged" (a.k.a. "staged") files are ones that need manual resolution.

(Notice the complaint about update-index.c, which doesn't
(I notice that update-index.c isn't listed, despite being mentioned
as a conflict in the message.  Can someone explain that?)

Fixing those is easy, but as you can see from the original commit comment
and diffs, there were some additional changes that were necessary to
make that compile.

You can test before committing the change, or do it the git way - commit
anyway, then test and "git commit --amend" with the fixes, of any.

Unlike a centralized VCS, committing is not the same as pushing upstream.
You can use test branches in the repository to save as much work as
you like.  While it's still nice to keep the public repository clean,
you don't have to worry about "breaking the tree" every time you commit.
You can do all kinds of stuff in test branches, and clean it up later.

This is why all the git merge tools do the commit without waiting for
you to test it.  The merge is usually okay, and it saves time.  If not,
