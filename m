From: linux@horizon.com
Subject: as promised, docs: git for the confused
Date: 8 Dec 2005 01:34:09 -0500
Message-ID: <20051208063409.31967.qmail@science.horizon.com>
References: <20051204213458.GY22159@pasky.or.cz>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Dec 08 07:35:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkFM8-0002Ya-Ql
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 07:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbVLHGeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 01:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVLHGeN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 01:34:13 -0500
Received: from science.horizon.com ([192.35.100.1]:63304 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030472AbVLHGeL
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 01:34:11 -0500
Received: (qmail 31968 invoked by uid 1000); 8 Dec 2005 01:34:09 -0500
To: git@vger.kernel.org
In-Reply-To: <20051204213458.GY22159@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13360>

As I mentioned with all my questions, I was writing up the answers
I got.  Here's the current status.  If anyone would like to comment on
its accuracy or usefulness, feedback is appreciated.

I've tried to omit or skim very lightly over subjects I think
are adequately explained in existing docs, unless that would
leave an uncomfortable hole in the explanation.

TODO: Describe the config file.  It's a recent invention, and I
haven't found a good description of its contents.


		"I Don't Git It"
		Git for the confused

Git is hardly lacking in documentation, but coming at it fresh, I found
it somewhat confusing.

Git is a toolkit in the Unix tradition.  There are a number of primitives
written in C, which are made friendly by a layer of shell scripts.
These are known in git-speak, as the "plumbing" and the "porcelain",
respectively.  The porcelain should work and look nice.  The plumbing
should just deal with lots of crap efficiently.

Much of git's documentation was first written to explain the plumbing to
the people writing the porcelain.  Since then, although the essentials
haven't changed, porcelain has been added and conventions have been
established that make it a lot more pleasant to deal with.  Some commands
have been changed or replaced, and it's not quite the same.

Using the original low-level commands is now most likely more difficult
than necessary, unless you want to do something not supported by the
existing porcelain.

This document retraces (with fewer false turns) how I learned my
way around git.  There are some concepts I didn't understand so well
the first time through, and an overview of all the git commands, grouped
by application.


A good rule of thumb is that the commands with one-word names (git-diff,
git-commit, git-merge, git-push, git-pull, git-status, git-tag, etc.) are
designed for end-user use.  Multi-word names (git-count-objects,
git-write-tree, git-cat-file) are generally designed for use from
a script.

This isn't ironclad.  The first command to start using git is git-init-db,
and git-show-branch is pure porcelain, while git-mktag is a primitive.
And you don't often run git-daemon by hand.  But still, it's a useful
guideline.


* Background material.

To start with, read "man git".  Or Documentation/git.txt in the git
source tree, which is the same thing.  Particularly note the description
of the index, which is where all the action in git happens.

One thing that's confusing is why git allows you to have one version of
a file in the current HEAD, a second version in the index, and possibly a
third in the working directory.  Why doesn't the index just contain a copy
of the current HEAD until you commit a new one?  The answer is merging,
which does all its work in the index.  Neither the object database nor
the working directory let you have multiple files with the same name.

The index is really very simple.  It's a series of structures, each
describing one file.  There's an object ID (SHA1) of the contents,
some file metadata to detect changes (time-stamps, inode number, size,
permissions, owner, etc.), and the path name relative to the root of
the working directory.  It's always stored sorted by path name, for
efficient merging.

At (almost) any time, you can take a snapshot of the index and write
it as a tree object.

The only interesting feature is that each entry has a 2-bit stage number.
Normally, this is always zero, but each path name is allowed up to three
different versions (object IDs) in the index at once.  This is used to
represent an incomplete merge, and an unmerged index entry (with more
than one version) prevents committing the index to the object database.


* Terminology - heads, branches, refs, and revisions

(This is a supplement to what's already in "man git".)

The most common object needed by git primitives is a tree.  Since a
commit points to a tree and a tag points to a commit, both of these are
acceptable "tree-ish" objects and can be used interchangeably.  Likewise,
a tag is "commit-ish" and can be used where a commit is required.

As soon as you get to the porcelain, the most commonly used object is
a commit.  Also known as a revision, this is a tree plus a history.

While you can always use the full object ID, you can also use a reference.
A reference is a file that contains a 40-character hex SHA1 object ID
(and a trailing newline).  When you specify the name of a reference,
it is searched for in one of the directories:
	.git/			(or $GIT_DIR)
	.git/refs/		(or $GIT_DIR/refs/)
	.git/refs/heads/	(or $GIT_DIR/refs/heads/)
	.git/refs/tags/		(or $GIT_DIR/refs/tags/)

You may use subdirectories by including slashes in the reference name.
There is no search order; if searching the above four path prefixes
produces more than one match for the reference name (it's ambiguous),
then the name is not valid.

There is additional syntax (which looks like "commit~3^2~17") for
specifying an ancestor of a given commit (or tag).  This is documented
in detail in the documentation for git-rev-parse.  Briefly, commit^
is the parent of the given commit.  commit^^ is the grandparent, etc..
If there is more than one ancestor (a merge), then they can be referenced
as commit^1 (a synonym for commit^), commit^2, commit^3, etc.  (commit^0
gives the commit object itself.  A no-op if you're starting from a commit,
but it lets you get the commit object from a tag object.)

As long strings of ^ can be annoying, they can be abbreviated using ~
syntax.  commit^^^ is the same as commit~3, ^^^^ is the same as ~4, etc.
You can see lots of examples in the output of "git-show-branch".


Now, the although the most primitive git tools don't care, a convention
among all the porcelain is that the current head of development is
.git/HEAD, a symbolic link to a reference under refs/heads/.

git-init-db creates HEAD pointing to refs/heads/master, and that is
traditionally the name used for the "main trunk" of development.
Note that initially refs/heads/master doesn't exist - HEAD is a
dangling symlink!  This is okay, and will cause the initial commit
to have zero parents.

A "head" is mostly synonymous with a "branch", but the terms have
different emphasis.  The "head" is particularly the tip of the branch,
where future development will be appended.  A "branch" is the entire
development history leading to the head.  However, as far as git is
concerned, they're both references to commit objects, referred to from
refs/heads/.

When you actually do more (with git-commit, or git-merge), then the
current HEAD reference is overwritten with the new commit's id, and
the old HEAD becomes HEAD^.  Since HEAD is a symlink, it's the file
in refs/heads/ that's actually overwritten.  (See the git-update-ref
documentation for further details.)

The git-checkout command actually changes the HEAD symlink.  git-checkout
enforces the rule that it will only check out a branch under refs/heads.
You can use refs/tags as a source for git-diff or any other command that
only examines the revision, but if you want to check it out, you have
to copy it to refs/heads.


* Resetting

The "undo" command for commits to the object database is git-reset.
Like all deletion-type commands, be careful or you'll hurt yourself.
Given a commit (using any of the syntaxes mentioned above), this
sets the current HEAD to refer to the given commit.

This does NOT alter the HEAD symlink (as git-checkout <branch> will
do), but actually changes the reference pointed to by HEAD
(e.g. refs/heads/master) to contain a new object ID.

The classic example is to undo an erroneous commit, use
"git-reset HEAD^".

There are actually three kinds of git-reset:
git-reset --soft: Only overwrite the reference.  If you can find the
	old object ID, you can put everything back with a second
	git-reset --soft OLD_HEAD.
git-reset --mixed: This is the default, which I always think of
	as "--medium".  Overwrite the reference, and (using
	git-read-tree) read the commit into the index.  The
	working directory is unchanged.
git-reset --hard: Do everything --mixed does, and also check out
	the index into the working directory.  This really erases
	all traces of the previous version.  (One caveat: this
	will not delete any files in the working directory that
	were added as part of the changes being undone.)

The space taken up by the abandoned commit won't actually be
reclaimed until you collect garbage with git-prune.

git-reset with no commit specified is "git-reset HEAD", which is much
safer because the object reference is not actually changed.  This can
be used to undo changes in the index or working directory that you did
not intend.  Note, however, that it is not selective.  "git-commit"
has options for doing this selectively.

Like being sure what directory you're in when typing "rm -r", think
carefully about what branch you're on when typing "git-reset <commit>".

There is an undelete: git-reset stores the previous HEAD commit
in OLD_HEAD.  And git-lost-found can find leftover commits
until you do a git-prune.


* Merging

Merging is central to git operations.  Indeed, a big difference between
git and other version control systems is that git assumes that a change
will be merged more often than it's written, as it's passed around
different developers' repositories.  Even "git checkout" is a merge.

The heart of merging is git-read-tree, but if you can understand it from
the man page, you're doing better than me.

As mentioned, the index and the working directory versions of a file
could both be different from the HEAD.  Git lets you merge "under" your
current working directory edits, as long as the merge doesn't change
the files you're editing.

There are some special cases of merging, but let me start with the
procedure for the general 3-way merge case: merging branch B into branch A
(the current HEAD).

1) Given two commits, find a common ancestor O to server as the origin
   of the merge.  The basic "resolve" algorithm uses git-merge-base for
   the task, but the "recursive" merge strategy gets more clever in the
   case where there are multiple candidates.  I won't got into what it
   does, but it does a pretty good job.

2) Add all three input trees (the Origin, A, and B) to the index by
   "git-read-tree -m O A B".  The index now contains up to three copies
   of every file.  (Four, including the original, but that is discarded
   before git-read-tree returns.)

   Then, for each file in the index, git-read-tree does the following:

   2a) For each file, git-merge-tree tries to collapse the various
       versions into one using the "trivial in-index merge".  This just
       uses the file blob object names to see if the file contents
       are identical, and if two or more of the three trees contain an
       identical copy of this file, it is merged.  A missing (deleted)
       file matches another missing file.

       Note that this is NOT a majority vote.  If A and B agree on the
       contents of the file, that's what is used.  (Whether O agrees is
       irrelevant in this case.)  But if O and A agree, then the change
       made in B is taken as the final value.  Likewise, if O and B agree,
       then A is used.

   2b) If this is possible, then a check is made to see if the merge would
       conflict with any uncommitted work in the index or change the index
       out from under a modified working directory file.  If either of
       those cases happen, the entire merge is backed out and fails.

       (In the git source, the test "t/t1000-read-tree-m-3way.sh" has
       a particularly detailed description of the various cases.)

       If the merge is possible and safe, the versions are collapsed
       into one final result version.

   2c) If all three versions differ, the trivial in-index merge is
       not possible, and the three source versions are left in the
       index unmerged.  Again, if there was uncommitted work in the
       index or the working directory, the entire merge fails.

3) Use git-merge-index to iterate over the remaining unmerged files, and
   apply an intra-file merge.  The intra-file merge is usually done with
   git-merge-one-file, which does a standard RCS-style three-way merge
   (see "man merge").

4) Check out all the successfully merged files into the working directory.

5) If automatic merging was successful on every file, commit the merged
   version immediately and stop.

6) If automatic merging was not complete, then replace the working
   directory copies of any remaining unmerged files with a merged copy
   with conflict markers (again, just like RCS or CVS) in the working
   directory.  All three source versions are available in the index for
   diffing against.

   (We have not destroyed anything, because in step 2c), we checked to make
   sure the working directory file didn't have anything not in the
   repository.)

7) Manually edit the conflicts and resolve the merge.  As long as an
   unmerged, multi-version file exists in the index, committing the
   index is forbidden.  (You can use the options to git-diff to
   see the changes.)

8) Commit the final merged version of the conflicting file(s), replacing
   the unmerged versions with the single finished version.

Note that if the merge is simple, with no one file edited on both
branches, git never has to open a single file.  It reads three tree
objects (recursively) and stat(2)s some working directory files to
verify that they haven't changed.

Also note that this aborts and backs out rather than overwrite
anything not committed.  You can merge "under" uncommitted edits
only if those edits are to files not affected by the merge.


* 2-way merging

A "2-way merge" is basically a 3-way merge with the contents of the
index as the "current HEAD", and the original HEAD as the Origin.
However, this merge is designed only for simple cases and only supports
the "trivial merge" cases.  It does not fall back to an intra-file merge.

[[ I'm not sure why it couldn't, I confess.  For reversibility?  Or
just because it's likely to be too confusing.  ]]

This merge is used by git-checkout to switch between two branches,
while preserving any changes in the working directory and index.

Like the 3-way case, if a particular file hasn't changed between
the two heads, then git will preserve any uncommitted edits.
If the file has changed in any way, git doesn't try to perform
any sort of intra-file merge, it just fails.

* 1-way merging

This is not actually used by the git-core porcelain, and so is only
useful to someone writing more porcelain, but I'll describe it for
completeness.

Plain (non-merging) git-read-tree will overwrite the index entries with
those from the tree.  This invalidates the cached stat data, causing
git to think all the working directory files are "potentially changed"
until you do a git-update-index --refresh.

By specifying a 1-way merge, any index entry whose contents (object ID)
matches the incoming tree will have its cached stat data preserved.
Thus, git will know if the working directory file is not changed, and
will not overwrite if you execute git-checkout-index.

This is purely an efficiency hack.


* Special merges - already up to date, and fast-forward

There are two cases of 3-way or 2-way merging that are special.
Recall that the basic merge pattern is

   B--------> A+B
  /        /
 /        /
O -----> A

The two special cases arise if one of A or B is a direct ancestor of
the other.  In that case, the common ancestor of both A and B is the
older of the two commits.  And the merged result is simply the
newer of the two, unchanged.

Recalling that we are merging B into A, if B is a direct ancestor of A,
then A already includes all of B.  A is "already up to date" and not
changed at all by the merge.

The other case you'll hear mentioned, because it happens a lot when
pulling, is when A is a direct ancestor of B.  In this case, the
result of the merge is a "fast-forward" to B.

Both of these cases are handled very efficiently by the in-index merge
done by git-read-tree.


* Deleted files during merges

There is one small wrinkle in git's merge algorithm that will probably
never bite you, but I ought to explain anyway, just because it's so rare
that it's difficult to discover it by experiment.

The index contains a list of all files that git is tracking.  If the
index file is empty or missing and you do a commit, you write an empty
tree with no files.

When merging, if git finds no pre-existing index entry for a path it is
trying to merge, it considers that to mean "status unknown" rather than
"modified by being deleted".  Thus, this is not uncommitted work
in the index file, and does not block the merge.  Instead, the
file will reappear in the merge.

This is because it is possible to blow away the index file (rm .git/index
will do it quite nicely), and if this was considered a modification to
be preserved, it would cause all sorts of conflicts.

So the one change to the index that will NOT be preserved by a merge is
the removal of a file.  A missing index entry is treated the same as an
unmodified index entry.  The index will be updated, and when you check
out the revision, the working directory file will be (re-)created.

Note that none of this affects you in the usual case where you make
changes in the working directory only, and leave the index equal to HEAD
until you're ready to commit.


* Packs

Originally, git stored every object in its own file, and used rsync
to share repositories.  It was quickly discovered that this brought
mighty servers to their knees.  It's great for retrieving a small
subset of the database the way git usually does, but rsync scans the
whole .git/objects tree every time.

So packs were developed.  A pack is a file, built all at once, which
contains many delta-compressed objects.  With each .pack file,
there's an accompanying .idx file that indexes the pack so that
individual objects can be retrieved quickly.

You can reduce the disk space used by your repositories by periodically
repacking them with git-repack.  Normally, this makes a new incremental
pack of everything not already packed.  With the -a flag, this repacks
everything for even greater compression (but takes longer).

The git wire protocol basically consists of negotiation over what
objects needs to be transferred followed by sending a custom-built pack.
The .idx file can be reconstructed from the .pack file, so it's
never transferred.

[[ Is once every few hundred commits a good rule of thumb for repacking?
When .git/objects/?? reaches X megabytes?  I think too many packs is
itself a bad thing, since they all have to be searched. ]]


* Raw diffs

A major source of git's speed is that it tries to avoid accessing files
unnecessarily.  In particular, files can be compared based on their
object IDs without needing to open and read them.  As part of this,
the responsibility for finding file differences (printing diffs) is
divided into finding what files have changed, and finding the changes
within those files.

This is all explained in the Documentation/diffcore.txt in the git
distribution, but the basics is that many of the primitives spit out a
line like this:
:100755 100755 68838f3fad1d22ab4f14977434e9ce73365fb304 0000000000000000000000000000000000000000 M	git-bisect.sh
when asked for a diff.  This is known as a "raw diff".  They can be
told to generate a human-readable diff with the "-p" (patch) flag.
The git-diff command includes this by default.


* Advice on using git

If you're used to CVS, where branches and merges are "advanced" features
that you can go a long time, you need to learn to use branches in git a
lot more.  Branch early and often.  Every time you think about developing
a feature or fixing a bug, create a branch to do it on.

In fact, avoid doing any development on the master branch.  Merges only.

A branch is the git equivalent of a patch, and merging a branch is the
equivalent of applying that patch.  A branch gives it a name that
you can use to refer to it.  This is particularly useful if you're
sharing your changes.

Once you're done with a branch, you can delete it.  This is basically
just removing the refs/heads/<branch> file, but "git-branch -d" adds a
few extra safety checks.  Assuming you merged the branch in, you can
still find all the commits in the history, it's just the name that's
been deleted.

You can also rename a branch by renaming the refs/heads/branch file.
There's no git command to do this, but as long as you update
the HEAD symlink if necessary, you don't need one.

Periodically merge all of the branches you're working on into a testing
branch to see if everything works.  Blow away and re-create the
testing branch whenever you do this.  When you like the result,
merge them into the master.


* The .git directory

There are a number of files in the .git directory used by the
porcelain.  In case you're curious (I was), this is what they are:

index
- The actual index file.

objects/
- The object database.  Can be overridden by $GIT_OBJECT_DIRECTORY

hooks/
- where the hook scripts are kept.  The standard git template includes
  examples, but disabled by being marked non-executable.

info/exclude
- Default project-wide list of file patterns to exclude from notice.
  To this is added the per-directory list in .gitignore.
  See the git-ls-files docs for full details.

refs/
- References to development heads (branches) and tags.

remotes/
- Short names of remote repositories we pull from or push to.
  Details are in the "git-fetch" man page.

HEAD
- The current default development head.
- Created by git-init-db and never deleted
- Changed by git-checkout
- Used by git-commit and any other command that commits changes.
- May be a dangling pointer, in which case git-commit
  does an "initial checkin" with no parent.

COMMIT_EDITMSG
- Temp used by git-commit to edit a commit message.
COMMIT_MSG
- Temp used by git-commit to form a commit message,
  post-processed from COMMIT_EDITMSG.

FETCH_HEAD
- Just-fetched commits, to be merged into the local trunk.
- Created by git-fetch.
- Used by git-pull as the source of data to merge.

MERGE_HEAD
- Keeps track of what heads are currently being merged into HEAD.
- Created by git-merge --no-commit with the heads used 
- Deleted by git-checkout and git-reset (since you're abandoning
  the merge)
- Used by git-commit to supply additional parents to the current commit.
  (And deleted when done.)

MERGE_MSG
- Generated by git-merge --no-commit.
- Used by git-commit as the commit message for a merge
  (If present, git-commit doesn't prompt.)

MERGE_SAVE
- cpio archive of all locally modified files created by
  "git-merge" before starting to do anything, if multiple
  merge strategies are being attempted.
  Used to rewind the tree in case a merge fails.

ORIG_HEAD
- Previous HEAD commit prior to a merge or reset operation.

LAST_MERGE
- Set by the "resolve" strategy to the most recently merged-in branch.
  Basically, a copy of MERGE_HEAD.  Not used by the other merge strategies,
  and resolve is no longer the default, so its utility is very limited.

BISECT_LOG
- History of a git-bisect operation.
- Can be replayed (or, more usefully, a prefix can) by "git-bisect replay"
BISECT_NAMES
- The list of files to be modified by git-bisect.
- Set by "git-bisect start"

TMP_HEAD (used by git-fetch)
TMP_ALT (used by git-fetch)


* Git command summary

There are slightly over a hundred git commands.  This section tries to
classify them by purpose, so you can know which commands are intended to
be used for what.  You can always use the low-level plumbing directly,
but that's inconvenient and error-prone.

Helper programs (not for direct use) for a specific utility are shown
indented under the program they help.

Note that all of these can be invoked using the "git" wrapper by replacing
the leading "git-" with "git ".  The results are exactly the same.
There is a suggestion to reduce the clutter in /usr/bin and move all
the git binaries to their own directory, leaving just the git wrapper
in /usr/bin. so you'll have to use it or adjust your $PATH.  But that
hasn't happened yet.  In the meantime, including the hyphen makes
tab-completion work.

I include ".sh", ".perl", etc. suffixes to show what the programs are
written in, so you can read those scripts written in languages you're
familiar with.  These are the names in the git source tree, but the
suffix is not included in the /usr/bin copies.

+ Administrative commands
git-init-db

+ Object database maintenance:
git-convert-objects
git-fsck-objects
git-lost-found.sh
git-prune.sh
git-relink.perl

+ Pack maintenance
git-count-objects.sh
git-index-pack
git-pack-objects
git-pack-redundant
git-prune-packed
git-repack.sh
git-show-index
git-unpack-objects
git-verify-pack

+ Important primitives
git-commit-tree
git-rev-list
git-rev-parse

+ Useful primitives
git-ls-files
git-update-index

+ General script helpers (used only by scripts)
git-cat-file
git-check-ref-format
git-checkout-index
git-fmt-merge-msg.perl
git-hash-object
git-ls-tree
git-repo-config
git-unpack-file
git-update-ref
git-sh-setup.sh
git-stripspace
git-symbolic-ref
git-var
git-write-tree

+ Oddballs
git-mv.perl

+ Code browsing
git-diff.sh
  git-diff-files
  git-diff-index
  git-diff-tree
  git-diff-stages
git-grep.sh
git-log.sh
git-name-rev
git-shortlog.perl
git-show-branch
git-whatchanged.sh

+ Making local changes
git-add.sh
git-bisect.sh
git-branch.sh
git-checkout.sh
git-commit.sh
git-reset.sh
git-status.sh

+ Cherry-picking
git-cherry.sh
  git-patch-id
git-cherry-pick.sh
git-rebase.sh
git-revert.sh

+ Accepting changes by e-mail
git-apply
git-am.sh
  git-mailinfo
  git-mailsplit
  git-applypatch.sh
git-applymbox.sh

+ Publishing changes by e-mail
git-format-patch.sh
git-send-email.perl

+ Merging
git-merge.sh
  git-merge-base
  git-merge-index
    git-merge-one-file.sh
  git-merge-octopus.sh
  git-merge-ours.sh
  git-merge-recursive.py
  git-merge-resolve.sh
  git-merge-stupid.sh
git-read-tree
git-resolve.sh
git-octopus.sh

+ Making releases
git-get-tar-commit-id
git-tag.sh
  git-mktag
git-tar-tree
git-verify-tag.sh

+ Accepting changes by network
git-clone.sh
  git-clone-pack
git-fetch.sh
  git-fetch-pack
  git-local-fetch
  git-http-fetch
  git-ssh-fetch
git-ls-remote.sh
  git-peek-remote
git-parse-remote.sh
git-pull.sh
  git-ssh-pull
git-shell
  git-receive-pack

+ Publishing changes by network
git-daemon

git-push.sh
  git-http-push
  git-ssh-push
  git-ssh-upload
git-request-pull.sh
git-send-pack
git-update-server-info
git-upload-pack

All of the basic git commands are designed to be scripted.  When
scripting, use the "--" option to ensure that files beginning with
"-" won't be interpreted as options, and the "-z" option to output
NUL-terminated file names so embedded newlines won't break things.

(A person who'd do either of these on purpose is probably crazy, but
it's not actually illegal.)

Looking at existing shell scripts can be very informative.



* Detailed list

Here's a repeat, including descriptions.  I don't try to include
every detail you can find on the man page, but to explain when
you'd want to use a command.

+ Administrative commands
git-init-db
	This creates an empty git repository in ./.git (or $GIT_DIR if
	that is non-null) using a system-wide template.
	It won't hurt an existing repository.

+ Object database maintenance:
git-convert-objects
	You will *never* need to use this command.
	The git repository format has undergone some revision since its
	first release.  If you have an ancient and crufty git repository
	from the very very early days, this will convert it for you.
	But as you're new to git, it doesn't apply.
git-fsck-objects
	Validate the object database.  Checks that all references
	point somewhere, all the SHA1 hashes are correct, and that
	sort of thing.

	This walks the entire repository, uncompressing and hashing
	every object, so it takes a while.  Note that by default,
	it skips over packs, which can make it seem misleadingly fast.
git-lost-found.sh
	Find (using git-fsck-objects) any unreferenced commits and
	tags in the object database, and place them in a .git/lost-found
	directory.  This can be used to recover from accidentally
	deleting a tag or branch reference that you wanted to keep.

	This is the opposite of git-prune.
git-prune.sh
	Delete all unreachable objects from the object database.
	It deletes useless packs, but does not remove useless
	objects from the middle of partially useful packs.

	Git leaks objects in a number of cases, such as unsuccessful
	merges.  The leak rate is generally a small fraction of
	the rate at which the desired history grows, so it's not
	very alarming, but occasionally running git-prune will
	eliminate the 

	If you deliberately throw away a development branch, you
	will need to run this command to fully reclaim the disk space.

	On something like the full Linux repository, this takes
	a while.
git-relink.perl
	Merge the objects stores of multiple git repositories by
	making hard links between them.  Useful to save space if
	duplicate copies are accidentally created on one machine.

+ Pack maintenance
	The classic git format is to compress and store each object
	separately.  This is still used for all newly created changes.
	However, objects can also be stored en masse in "packs" which
	contain many objects and tan take advantage of delta-compressing.
	Repacking your repositories periodically can save space.
	(Repacking is pretty quick but not quick enough to be
	comfortable doing every commit.)
git-count-objects.sh
	Print the number and total size of unpacked objects in the
	repository, to help you decide when is a good time to repack.
git-index-pack
	A pack file has an accompanying .idx file to allow rapid lookup.
	This regenerates the .idx file from the .pack.  This is almost never
	needed directly, but can be used after transferring a .pack file
	between machines.
git-pack-objects
	Given a list of objects on stdin, build a pack file.  This is
	a helper used by the various network communication scripts.
git-pack-redundant
	Produce a list of redundant packs, for feeding to "xargs rm".
	A helper for git-prune.
git-prune-packed
	Delete unpacked object files that are duplicated in packs.
	(With -n, only lists them.)  A helper for git-prune.
git-repack.sh
	Make a new pack with all the unpacked objects.
	With -a, include already-packed objects in the new pack.
	With -d as well, deletes all the old packs thereby made redundant.
git-show-index
	Dump the contents of a pack's .idx file.  Mostly for
	debugging git itself.
git-unpack-objects
	Unpack a .pack file, the opposite of git-pack-objects.	With -n,
	doesn't actually create the files.  With -q, suppresses the
	progress indicator.
git-verify-pack
	Validate a pack file.  Useful when debugging git, and when
	downloading from a remote source.  A helper for git-clone.

+ Important primitives
	Although these primitives are not used directly very frequently,
	understanding them will help you understand other git commands
	that wrap them.
git-commit-tree
	Create a new commit object from a tree and a list of parent
	commits.  This is the primitive that's the heart of git-commit.
	(It's also used by git-am, git-applypatch, git-merge, etc.)
git-rev-list
	Print a list of commits (revisions), in reverse chronological
	order.  This is the heart of git-log and other history examination
	commands, and the options for specifying parts of history are
	shared by all of them.

	In particular, it takes an arbitrary number of revisions as
	arguments, some of which may be prefixed with ^ to negate them.
	These make up "include" and "exclude" sets.  git-rev-list
	lists all revisions that are ancestors of the "include" set
	but not ancestors of the "exclude" set.
	
	For this purpose, a revision is considered an ancestor of itself.
	Thus, "git-rev-list ^v1.1 v1.2" will list all revisions from
	the v1.2 release back to (but not including) the v1.1 release.

	Because this is so convenient, a special syntax, "v1.1..v1.2"
	is allowed as an equivalent.  However, occasionally the general
	form is useful.  For example, adding ^branch will show the trunk
	(including merges from the branch), but exclude the branch itself.

	Similarly, "branch ^trunk", a.k.a. trunk..branch, will show
	all work on the branch that hasn't been merged to the trunk.
	This works even though trunk is not a direct ancestor of branch.
	
	Git-rev-list has a variety of flags to control it output format.
	The default is to just print the raw SHA1 object IDs of the
	commits, but --pretty produces a human-readable log.

	You can also specify a set of files names (or directories),
	in which case output will be limited to commits that modified
	those files.

	This command is used extensively by the git:// protocol to compute
	a set of objects to send to update a repository.
git-rev-parse
	This is a very widely used command line canonicalizer for git
	scripts.  It converts relative commit references (e.g. master~3)
	to absolute SHA1 hashes, and can also pass through arguments
	not recognizable as references, so the script can interpret them.

	It is important because it defines the <rev> syntax.

	This takes a variety of options to specify how to prepare the
	command line for the script's use.  --verify is a particularly
	important one.

+ Useful primitives
	These primitives are potentially useful directly.
git-ls-files
	List files in the index and/or working directory.  A variety of
	options control which files to list, based on whether they
	are the same in both places or have been modified.  This command
	is the start of most check-in scripts.
git-update-index
	Copy the given files from the working directory into the index.
	This create the blob objects, but no trees yet.  (Note that
	editing a file executing this multiple times without creating a
	commit will generate orphaned objects.  Harmless.)

	One common safe option is "git-update-index --refresh".  This
	looks for files whose metadata (modification time etc.) has
	changed, but not their contents, and updates the metadata in the
	index so the file contents won't have to be examined again.

+ General script helpers (used only by scripts)
	These are almost exclusively helpers for use in porcelain
	scripts and have little use by themselves from the command line.
git-cat-file
	Extract a file from the object database.  You can ask for
	an object's type or size given only an object ID, but
	to get its contents, you have to specify the type.  This
	is a deliberate safety measure.
git-check-ref-format
	Verify that the reference specified on the command line is
	syntactically valid for a new reference name under $GIT_DIR/refs.
	A number of characters (^, ~, :, and ..) are reserved; see the man
	page for the full list of rules.
git-checkout-index
	Copy files from the index to the working directory, or to a
	specified directory.  Most important as a helper for git-checkout,
	this is also used by git-merge and git-reset.
git-fmt-merge-msg.perl
	Generate a reasonable default commit message for a merge.
	Used by git-pull and git-octopus.
git-hash-object
	Very primitive helper to turn an arbitrary file into an object,
	returning just the ID or actually adding it to the database.
	Used by the cvs-to-git and svn-to-git import filters.
git-ls-tree
	List the contents of a tree object.  Will tell you all the files
	in a commit.  Used by the checkout scripts git-checkout and git-reset.
git-repo-config
	Get and set options in .git/config.  The .git/config format
	is designed to be human-readable.  This gives programmatic
	access to the settings.  This currently has a lot of overlap
	with the function of git-var.
git-unpack-file
	Write the contents of the given block to a temporary file,
	and return the name of that temp file.  Used most often
	by merging scripts.
git-update-ref
	Rewrite a reference (in .git/refs/) to point to a new object.
	"echo $sha1 > $file" is mostly equivalent, but this adds locking
	so two people don't update the same reference at once.
git-sh-setup.sh
	This is a general prefix script that sets up
	$GIT_DIR and $GIT_OBJECT_DIRECTORY for a script,
	or errors out if the git control files can't be found.
git-stripspace
	Remove unnecessary whitespace.  Used mostly on commit messages
	received by e-mail.
git-symbolic-ref
	This queries or creates symlinks to references such as HEAD.
	Basically equivalent to readlink(1) or ln -s, this also works
	on platforms that don't have symlinks.  See the man page.
git-var
	Provide access to the GIT_AUTHOR_IDENT and/or GIT_COMMITTER_IDENT
	values, used in various commit scripts.  This currently has a
	lot of overlap with the function of git-repo-config.
git-write-tree
	Generate a tree object reflecting the current index.  The output
	is the tree object; if you don't remember it somewhere (usually,
	pass it to git-commit-tree), it'll be lost.

	This requires that the index be fully merged.  If any incomplete
	merges are present in the index (files in stages 1, 2 or 3),
	git-write-tree will fail.

+ Oddballs
git-mv.perl
	I have to admit, I'm not quite sure what advantages this is
	supposed to have over plain "mv" followed by "git-update-index",
	or why it's complex enough to need perl.

	Basically, this renames a file, deleting its old name and adding
	its new name to the index.  Otherwise, it's a two-step process
	to rename a file:
	- Rename the file
	- git-add the new name
	Followed by which you must commit both the old and new names

+ Code browsing
git-diff.sh
	Show changes between various trees.  Takes up to two tree
	specifications, and shows the difference between the versions.
	Zero arguments: index vs. working directory (git-diff-files)
	One: tree vs. working directory (git-diff-index)
	One, --cached: tree vs. index (git-diff-index)
	Two: tree vs. tree (git-diff-tree)

	This wrapper always produces human-readable patch output.
	The helpers all produce "diff-raw" format unless you supply
	the -p option.

	There are some interesting options.  Unfortunately, the git-diff
	man page is annoyingly sparse, and refers to the helper scripts'
	documentation rather than describing the many useful options
	they all have in common.  Please do read the man pages of the
	helpers to see what's available.
	
	In particular, although git does not explicitly record file
	renames, it has some pretty good heuristics to notice things.
	-M tries to detect renamed files by matching up deleted files
	with similar newly created files.  -C tries to detect copies
	as well.  By default, -C only looks among the modified files for
	the copy source.  For common cases like splitting a file in two,
	this works well.  The --find-copies-harder searches ALL files
	in the tree for the copy source.  This can be slow on large trees!

	See Documentation/diffcore.txt for an explanation of how all
	this works.
  git-diff-files
	Compare the index and the working directory.
  git-diff-index
	Compare the working directory and a given tree.  This is the
	git equivalent of the single-operand form of "cvs diff".
	If "--cached" is specified, uses the index rather than the working
	directory.
  git-diff-tree
	Compare two trees.  This is the git equivalent of the two-operand
	form of "cvs diff".  This command is sometimes useful by itself
	to see the changes made by a single commit.  If you give it
	only one commit on the command line, it shows the diff between
	that commit and its first parent.  If the commit specification
	is long and awkward to type, using "git-diff-tree -p <commit>"
	can be easier than "git-diff <commit>^ <commit>".
  git-diff-stages
	Although not called by git-diff, there is a fourth diff helper
	routine, used to compare the various versions of an unmerged
	file in the index.  It is intended for use by merging porcelain.
git-grep.sh
	A very simple wrapper that runs git-ls-files and greps the
	output looking for a file name.  Does nothing fancy except
	saves typing.
git-log.sh
	Wrapper around git-rev-list --pretty.  Shows a history
	of changes made to the repository.  Takes all of git-rev-list's
	options for specifying which revisions to list.
git-name-rev
	Find a symbolic name for the commit specified on the
	command line, and returns a symbolic name of the form
	"maint~404^2~7".  Basically, this does a breadth-first search
	from all the heads in .git/refs looking for the given commit.
git-shortlog.perl
	This is a filter for the output of "git-log --pretty=short"
	to generate a one-line-per-change "shortlog" as Linus likes.
git-show-branch
	Visually show the merge history of the references given as
	arguments.  Prints one column per reference and one line per
	commit showing whether that commit is an ancestor of each
	reference.
git-whatchanged.sh
	A simple wrapper around git-rev-list and git-diff-tree,
	this shows the change history of a repository.  Specify a
	directory or file on the command line to limit the
	output to changes affecting those files.  This isn't
	the same as "cvs annotate", but it serves a similar purpose
	among git folks.

	You can add the -p option to include patches as well as log
	comments.  You can also add the -M or -C option to follow
	history back through file renames.

	-S is interesting: it's the "pickaxe" option.  Given a string,
	this limits the output to changes that make that string appear
	or disappear.  This is for "digging through history" to see when
	a piece of code was introduced.  The string may (and often does)
	contain embedded newlines.  See Documentation/cvs-migration.txt.

+ Making local changes
	All of these are examples of "porcelain" scripts.  Reading the
	scripts themselves can be informative; they're generally not
	too confusing.
git-add.sh
	A simple wrapper around "git-ls-files | git-update-index --add"
	to add new files to the index.   You may specify directories.
	You need to invoke this for every new file you want git to
	track.
git-bisect.sh
	Utility to do a binary search to find the change that broke something.
	The heart of this is in "git-rev-list --bisect"
	A very handy little utility!  Kernel developers love it
	when you tell them exactly which patch broke something.
	NOTE: this uses the head named "bisect", and will blow
	away any existing branch by that name.  Try not to
	create a branch with that name.

	There are three steps:
	git-bisect start [<files>]
		- Reset to start bisecting.  If any files are specified,
		  only they will be checked out as bisection proceeds.
	git-bisect good [<revision>]
		- Record the revision as "good".  The change being sought
		  must be after this revision.
	git-bisect bad [<revision>]
		- Record the revision as "bad".  The change being sought
		  must be before or equal to this revision.
	As soon as you have specified one good version and one bad version,
	git-bisect will find a halfway point and check out that
	revision.  Build and test it, then report it as good or bad,
	and git-bisect will narrow the search.  Finally, git-bisect
	will tell you exactly which change caused the problem.
	git-bisect log
		- Show a history of revisions.
	git-bisect replay
		- Replay (part of) a git-bisect log.  Generally used
		  to recover from a mistake, you can truncate the log
		  before the mistake and replay it to continue.
	If git-bisect chooses a version that cannot build, or you
	are otherwise unable to determine whether it is good or bad,
	you can change revisions with "git-reset --hard <revision>"
	to another checkout between the current good and bad limits, and
	continue from there.  "git-reset --hard <revision>" is generally
	dangerous, but you are on a scratch branch.

	This can, of course, be used to look for any change, even
	one for the better, if you can avoid being confused by the
	terms "good" and "bad".
git-branch.sh
	Most commonly used bare, to show the available branches.
	Show, create, or delete a branch.  The current branches
	are simply the contents of .git/refs/heads/.
	Note that this does NOT switch to the created branch!
	For the common case of creating a branch and immediately
	switching to it, "git-checkout -b <branch>" is simpler.
git-checkout.sh
	This does two superficially similar but very different things
	depending on whether any files or paths are specified on the
	command line.

	git-checkout [-f] [-b <new-branch>] <branch>
		This switches (changes the HEAD symlink to) the specified
		branch, updating the index and working directory to
		reflect the change.  This preserves changes in the
		working directory unless -f is specified.
		If -b is specified, a new branch is started from the
		specified point and switched to.  If <branch> is omitted,
		it defaults to HEAD.  This is the usual way to start a
		new branch.

	git-checkout [<branch>] [--] <paths>...
		This replaces the files specified by the given paths with
		the versions from the index or the specified branch.
		It does NOT affect the HEAD symlink, just replaces the
		specified paths.  This form is like a selective form of
		"git-reset".  Normally, this can guess whether the first
		argument is a branch name or a path, but you can use
		"--" to force the latter interpretation.

	With no branch, this is used to revert a botched edit of a
	particular file.

	Both forms use git-read-tree internally, but the net effect is
	quite different.
git-commit.sh
	Commit changes to the revision history.  In terms of primitives,
	this does three things:
	1) Updates the index file with the working directory files
	   specified on the command line, or -a for all
	   (using git-diff-files --name-only | git-update_index),
	2) Prompts for or generates a commit message, and then
	3) Creates a commit object with the current index contents.

	This also executes the pre-commit, commit-msg, and
	post-commit hooks if present.

	This will remove deleted files from the index, but will not
	add new files to the index, even if explicitly specified on the
	command line; you must use git-add for that.
git-reset.sh
	Explained in detail in "resetting", above.  This modifies the
	current branch head reference (as pointed to by .git/HEAD)
	to refer to the given commit.  It does not modify .git/HEAD 
	Reset the current HEAD to the specified commit, so that future
	checkins will be relative to it.  There are three
	variations:
	--soft: Just move the HEAD link.  The index is unchanged.
	--mixed (default): Move the HEAD link and update the index file.
		Any local changes will appear not checked in.
	--hard: Move the HEAD links, update the index file, and
		check out the index, overwriting the working
		directory.  Like "cvs update -C".
	In case of accidents, this copies the previous head
	object ID to ORIG_HEAD (which is NOT a symlink).
git-status.sh
	Show all files in the directory not current with respect
	to the git HEAD.  The basic categories are:
	1) Changed in the index, will be included in the next commit.
	2) Changed in the working directory but NOT in the index; will
	   be committed only if added via git-update-index or the
	   git-commit command line.
	3) Not tracked by git.

+ Cherry-picking
	Cherry-picking is the process of taking part of the changes
	introduced on one tree and applying those changes to another.
	This doesn't produce a parent/descendant relationship in the
	commit history.

	To produce that relationship, there's a special type of merge you
	can do if you've taken everything you want off a branch and
	want to show it in the merge history without actually importing
	any changes from it: ours.  "git-merge -s ours" will generate a
	commit that shows some branches were merged in, but not
	actually alter the current HEAD source code in any way.

	One thing cherry-picking is sometimes used for is taking a
	development branch and re-organizing the changes into a patch
	series for submission to the Linux kernel.
git-cherry.sh
	This searches a branch for patches which have not been applied
	to another.  Basically, it finds the unpicked cherries.
	It searches back to the common ancestor of the named branch and
	the current head using git-patch-id to identify similarity
	in patches.
  git-patch-id
	Generate a hash of a patch, ignoring whitespace and line numbers
	so that "the same" patch, even relative to a different code base,
	probably has the same hash, and different patches probably have
	different ones.  git-cherry looks for patch hashes which 
	are present on the branch (source branch) that are not present
	on the trunk (destination branch).
git-cherry-pick.sh
	Given a commit (on a different branch), compute a diff between
	it and its immediate parent, and apply it to the current HEAD.  
	This is actually the same script as "git revert", but
	works forward.  git-cherry finds the patches, this merges them.
	Handles failures gracefully.
git-rebase.sh
	Move a branch to a more recent "base" release.	This just extracts
	all the patches applied on the local head since the last merge
	with upstream (using git-format-patch) and re-applies them
	relative to the current upstream with git-am (explained under
	"accepting changes by e-mail").  Finally, it deletes the old
	branch and gives its name to the new one, so your branch now
	contains all the same changes, but relative to a different base.
	Basically the same as cherry-picking an entire branch.
git-revert.sh
	Undo a commit.	Basically "patch -R" followed by a commit.
	This is actually the same script as "git-cherry-pick", just
	applies the patch in reverse, undoing a change that you don't
	wish to back up to using git-reset.  Handles failures gracefully
	by telling the user what to do.

+ Accepting changes by e-mail
git-apply
	Apply a (git-style extended) patch to the current index
	and working directory.
git-am.sh
	The new and improved "apply an mbox" script.  Takes an
	mbox-style concatenation of e-mails as input and batch-applies
	them, generating one commit per message.  Can resume after
	stopping on a patch problem.
	(Invoke it as "git-am --skip" or "git-am --resolved" to
	deal with the problematic patch and continue.)
  git-mailinfo
	Given a single mail message on stdin (in the Linux standard
	SubmittingPatches format), extract a commit message and
	the patch proper.
  git-mailsplit
	Split an mbox into separate files.
  git-applypatch.sh
	Tries simple git-apply, then tries a few other clever merge
	strategies to get a patch to apply.  Used in the main loop
	of git-am and git-applymbox.
git-applymbox.sh
	This is Linus's original apply-mbox script.  Mostly superseded by
	git-am (which is friendlier and has more features), but he still
	uses it, so it's maintained.  This is so old it was originally
	a test of the git core called "dotest", and that name is still
	lurking in the temp file names.

+ Publishing changes by e-mail
git-format-patch.sh
	Generate a series of patches, in the preferred Linux kernel
	(Documentation/SubmittingPatches) format, for posting to lkml
	or the like.  This formats every commit on a branch as a separate
	patch.
git-send-email.perl
	Actually e-mail the output of git-format-patch.
	(This uses direct SMTP, a matter of some controversy.  Others feel
	that /bin/mail is the correct local mail-sending interface.)

+ Merging
git-merge.sh
	Merge one or more "remote" heads into the current head.
	Some changes, when there has been change only on one branch or
	the same change has been made to all branches, can be resolved
	by the "trivial in-index" merge done by git-read-tree.	For more
	complex cases, git provides a number of different merge strategies
	(with reasonable defaults).

	Note that merges are done on a filename basis.	While git tries
	to detect renames when generating diffs, most merge strategies
	don't track them by renaming.  (The "recursive" strategy, which
	recently became the default, is a notable exception.)
  git-merge-base
	Finds a common ancestor to use when comparing the changes made
	on two branches.  The simple case is straightforward, but if
	there have been cross-merges between the branches, it gets
	somewhat hairy.  The algorithm is not 100% final yet.
	(There's also --all, which lists all candidates.)
  git-merge-index
	This is the outer merging loop.  It takes the name of a one-file
	merge executable as an argument, and runs it for every incomplete
	merge.
    git-merge-one-file.sh
	This is the standard git-merge-index helper, that tries to
	resolve a 3-way merge.  A helper used by all the merge strategies.
	(Except "recursive" which has its own equivalent.)
  git-merge-octopus.sh
	Many-way merge.  Overlaps should be negligible.
  git-merge-ours.sh
	A "dummy" merge strategy helper.  Claims that we did the merge, but
	actually takes the current tree unmodified.  This is used to
	cleanly terminate side branches that heve been cherry-picked in.
  git-merge-recursive.py
	A somewhat fancier 3-way merge.   This handles multiple cross-merges
	better by using multiple common ancestors.
  git-merge-resolve.sh
  git-merge-stupid.sh
	Not actually used by git-merge, this is a simple example
	merge strategy.
git-read-tree
	Read the given tree into the index.  This is the difference
	between the "--soft" and "--mixed" modes of git-reset, but the
	important thing this command does is simple merging.
	If -m is specified, this can take up to three trees as arguments.
git-resolve.sh
	OBSOLETE.  Perform a merge using the "resolve" strategy.
	Has been superseded by the "-s resolve" option to git-merge
	and git-pull.
git-octopus.sh
	OBSOLETE.   Perform a merge using the "octopus" strategy.
	Has been superseded by the "-s octopus" option to git-merge
	and git-pull.

+ Making releases
git-get-tar-commit-id
	Reads out the commit ID that git-tar-tree puts in its output.
	(Or fails if this isn't a git-generated tar file.)
git-tag.sh
	Create a tag in the refs/tags directory.  There are two kinds:
	"lightweight tags" are just references to commits.  More
	serious tags are GPG-signed tag objects, and people receiving
	the git tree can verify that it is the version that you released.
  git-mktag
	Creates a tag object.  Verifies syntactic correctness of its
	input.  (If you want to cheat, use git-hash-object.)
git-tar-tree
	Generate a tar archive of the named tree.  Because git does NOT
	track file timestamps, this uses the timestamp of the commit,
	or the current time if you specify a tree.
	Also stores the commit ID in an extended tar header.
git-verify-tag.sh
	Given a tag object, GPG-verify the embedded signature.

+ Accepting changes by network
	Pulling consists of two steps: retrieving the remote commit
	objects and everything they point to (including ancestors),
	then merging that into the desired tree.  There are still
	separate fetch and merge commands, but it's more commonly done
	with a single "git-pull" command.  git-fetch leaves the commit
	objects, one per line, in .git/FETCH_HEAD.  git-merge will
	merge those in if that file exists when it is run.

	References to remote repositories can be made with long URLs,
	or with files in the .git/remotes/ directory.  The latter
	also specifies the local branches to merge the fetched data into,
	making it very easy to track a remote repository.
git-clone.sh
	Create a new local clone of a remote repository.
	(Can do a couple of space-sharing hacks when "remote" is on
	a local machine.)

	You only do this once.
  git-clone-pack
	Runs git-upload-pack remotely and places the resultant pack
	into the local repository.  Supports a variety of network
	protocols, but "remote" can also be a different directory on
	the current machine.
git-fetch.sh
	Fetch the named refs and all linked objects from a remote repository.
	The resultant refs (tags and commits) are stored in .git/FETCH_HEAD,
	which is used by a later git-resolve or git octopus.

	This is the first half of a "git pull" operation.
  git-fetch-pack
	Retrieve missing objects from a remote repository.
  git-local-fetch
	Duplicates a git repository from the local system.
	(Er... is this used anywhere???)
  git-http-fetch
	Do a fetch via http.  Http requires some kludgery on the
	server (see git-update-server-info), but it works.
  git-ssh-fetch
	Do a fetch via ssh.
git-ls-remote.sh
	Show the contents of the refs/heads/ and/or refs/tags/ directories
	of a remote repository.  Useful to see what's available.
  git-peek-remote
	Helper C program for the git-ls-remote script.  Implements the
	git protocol form of it.
git-parse-remote.sh
	Helper script to parse a .git/remotes/ file.  Used by a number
	of these programs.
git-pull.sh
	Fetches specific commits from the given remote repository,
	and merges everything into the current branch.	If a remote
	commit is named as src:dst, this merges the remote head "src"
	into the branch "dst" as well as the trunk.  Typically, the "dst"
	branch is not modified locally, but is kept as a pristine copy
	of the remote branch.

	One very standard example of this contention is that
	a repository that is tracking another specifies "master:origin"
	to provide a pristine local copy of the remote "master"
	branch in the local branch named "origin".
  git-ssh-pull
	A helper program that pulls over ssh.
git-shell
	A shell that can be used for git-only users.  Allows git
	push (git-receive-pack) and pull (git-upload-pack) only.
  git-receive-pack
	Receive a pack from git-send-pack, validate it, and add it to
	the repository.  Adding just the bare objects has no security
	implications, but this can also update branches and tags, which
	does have an effect.
	Runs pre-update and post-update hooks; the former may do
	permissions checking and disallow the upload.
	This is the command run remotely via ssh by git-push.

+ Publishing changes by network
git-daemon
	A daemon that serves up the git native protocol so anonymous
	clients can fetch data.  For it to allow export of a directory,
	the magic file name "git-daemon-export-ok" must exist in it.

	This does not accept (receive) data under any circumstances.
git-push.sh
	Git-pull, only backwards.  Send local changes to a remote
	repository.  The same .git/remotes/ short-cuts can be used,
	and the same src:dst syntax.  (But this time, the src is local
	and the dst is remote.)
  git-http-push
	A helper to git-push to implement the http: protocol.
  git-ssh-push
	A helper to git-push to push over ssh.
  git-ssh-upload
	Another helper.  This just does the equivalent of "fetch"
	("throw"?) and doesn't actually merge the result.  Obsolete?
git-request-pull.sh
	Generate an e-mail summarizing the changes between two commits,
	and request that the recipient pull them from your repository.
	Just a little helper to generate a consistent and informative
	format.
git-send-pack
	Pack together a pile of objects missing at the destination and
	send them.  This is the sending half that talks to a remote
	git-receive-pack.
git-update-server-info
	To run git over http, auxiliary info files are required that
	describes what objects are in the repository (since git-upload-pack
	can't generate this on the fly).  If you want to publish a
	repository via http, run this after every commit.  (Typically
	via the hooks/post-update script.)
git-upload-pack
	Like git-send-pack, but this is invoked by a remote git-fetch-pack.
