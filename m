From: linux@horizon.com
Subject: Re: git-name-rev off-by-one bug
Date: 29 Nov 2005 03:05:29 -0500
Message-ID: <20051129080529.20705.qmail@science.horizon.com>
References: <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Nov 29 09:49:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh0Ue-0002H0-FK
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 09:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVK2IFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 03:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVK2IFb
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 03:05:31 -0500
Received: from science.horizon.com ([192.35.100.1]:8772 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750897AbVK2IFa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 03:05:30 -0500
Received: (qmail 20706 invoked by uid 1000); 29 Nov 2005 03:05:29 -0500
To: junkio@cox.net
In-Reply-To: <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12931>

> Thanks for the complaints.  No sarcasm intended.  Yours is
> exactly the kind of message we (people who've been around here
> for too long) need to hear.

Thanks for taking it so well!  I'm trying to really *understand* git,
so I can predict its behaviour, but I've been coming to the conclusion
that the only way to do that is by re-reading the mailing list from day 1.

And to understand git at all, you have to understand merging, since
doing merging fast and well is the central reason for git's entire
existence.  Single-developer porcelain like "cvs annotate" is
noticeably lacking, but branching and merging is great.

(In particular, and unlike other SCMs, "push" and "pull" are
based on merging!  So I can't even understand what pulling from
Linus's tree does until I understand merging.)


I'm working on some notes to explain git to myself and people
I work with, which I'll post when they're vaguely complete.

> To the git barebone Porcelain layer (things that start with
> git-*, not with cg-*) [*2*], a merge is always between the
> current HEAD and one or more remote branch heads, and the index
> file must exactly match the tree of HEAD commit (i.e. the
> contents of the last commit) when it happens.  In other words,
> "git-diff --cached HEAD" must report no changes [*3*].  So
> HEAD+1 must be HEAD in your above notation, or merge will refuse
> to do any harm to your repository (that is, it may fetch the
> objects from remote, and it may even update the local branch
> used to keep track of the remote branch with "git pull remote
> rbranch:lbranch", but your working tree, .git/HEAD pointer and
> index file are left intact).

Right!  Since the object database is strictly append-only, it's easy to
see how such changes are quite harmless, and updating a tracking branch
is hardly a big nasty surprise.

It's the index and working directory that are volatile, and that I was
worried about.

BUT... what's the second argument to git-read-tree for, if it
always has to be HEAD?

BTW, I'd change the description of git-read-tree from

>     Reads the tree information  given  by  <tree-ish>  into  the directory
>     cache, but does not actually update any of the files it "caches". (see:
>     git-checkout-index)

to

      Reads the tree information given by <tree-ish> into the index.
      The working directory is not modified in any way (unless -u
      is used).  Use git-checkout-index to do that.

      In addition to the simple one-tree case, this can (with the
      -m flag) merge 2 or 3 trees into the index.  When used with
      -m, the -u flag causes it to also update the files in the
      working directory.

      Trivial merges are done by "git-read-tree" itself.  Conflicts
      are left in an unmerged state for git-merge-index to resolve.

> You may have local modifications in the working tree files.  In
> other words, "git-diff" is allowed to report changes (the
> difference between HEAD+2 and HEAD+1 in your notation).
> However, the merge uses your working tree as the working area,
> and in order to prevent the merge operation from losing such
> changes, it makes sure that they do not interfere with the
> merge.  Those complex tables in read-tree documentation define
> what it means for a path to "interfere with the merge".  And if
> your local modifications interfere with the merge, again, it
> stops before touching anything.

THANK YOU for finally making this clear!  I was wondering why the
hell a 2-way merge looked more complex than a 3-way.  (Although,
admittedly, I'm *still* not clear on what the difference is.  It
seems like a 2-way just picks the origin commit automatically.)
So it goes like this:

- git-merge will refuse to do anything if there are any uncommitted changes
  in the index.  [footnote about harmless exceptions]
- git-merge will refuse to do anything if there are changes in the
  working directory to a file that would be affected by the merge.
  You CAN, however, have unindexed changes to files that are unchanged
  by the merge.


The description of a 1-way merge in git-read tree is quite confusing.
Here's a rephrasing; do I understand it?

READING

    Without -m, git-read-tree pulls a specified tree into the index.
    Any file whose underlying blob is changed by the update will have
    its cached stat data invalidated, so it will appear in the output
    of git-diff-files, and git-checkout-index -f will overwrite it.

    A single-tree merge is a slightly nicer variant on this.

MERGING
    ...


Single Tree Merge
    If only one tree is specfied, any file whose blob changes as a
    result of the update is compared with the working directory file,
    and the cached stat data updated if the working directory file
    matches the new blob.  Thus, working directory files which happen to
    match the contents of the new tree will be excluded from the outout
    of git-diff-files, and git-checkout-index -f will not update their
    file modification times.

    This is basically the effect of git-update-index --refresh.

    This is actually usually preferable to the non-merge case, but
    does do extra work.

I haven't found the code yet, but obviously if the working directory
file is clean relative to the previous blob, it's dirty relative to
the changed blob, so there's no need to actually read the file.

Um... I just tried it, and it appears that things do NOT work as
I just described.  Time to read the code...


BTW, an even cuter way of writing same() in read_tree.c would be:

static int same(struct cache_entry *a, struct cache_entry *b)
{
	if (!a || !b)
		return a == b;
        return a->ce_mode == b->ce_mode &&
                !memcmp(a->sha1, b->sha1, 20);
}

(I presume that
return a&&b ? a->ce_mode == b->ce_mode && !memcmp(a->sha1, b->sha1, 20) : a==b;
would be taking it too far...)

Oh, and the git-read-tree man page fails to mention --reset and --trivial.
And the usage message should have <sha> changed to <tree>.

> So in the above two "failed merge" case, you do not have to
> worry about lossage of data --- you simply were not ready to do
> a merge, so no merge happened at all.  You may want to finish
> whatever you were in the middle of doing, and retry the same
> pull after you are done and ready.

I feel about a thousand percent better about git already.

> When things cleanly merge, these things happen:
>
> (1) the results are updated both in the index file and in your
>     working tree,
> (2) index file is written out as a tree,
> (3) the tree gets committed, and 
> (4) the HEAD pointer gets advanced.

This is git-merge, as opposed to the more primitive git-read-tree -m
plus git-merge-index, right?

(Aside, you should document that got-merge --no-commit saves the <msg>
in .git/MERGE_MSG, and git-commit uses it as the default message.
Otherwise, users wonder why the hell it asks for a commit message it
knows won't be used.)

> Because of (2), we require that the original state of the index
> file to match exactly the current HEAD commit; otherwise we will
> write out your local changes already registered in your index
> file (the difference between HEAD+1 and HEAD in your notation)
> along with the merge result, which is not good.

> *3* This is a bit of lie.  In certain special cases, your index
> are allowed to be different from the tree of HEAD commit;
> basically your index entries are allowed to match the result of
> trivial merge already (e.g. you received the same patch from
> external source to produce the same result as what you are
> merging).  For example, if a path did not exist in the common
> ancestor and your head commit but exists in the tree you are
> merging into your repository, and if you already happen to have
> that path exactly in your index, the merge does not have to
> fail.  This is case #2 in the 3-way read-tree table in t/t1000.

Ah, yes, the light dawns!  So it *is* okay if you have an uncommitted
change in the index which exactly matches what git-read-tree -m would
have done anyway.  It doesn't make a difference to the final state
of the index, and forcing the poor user to undo it just so the merge
can redo it is simply annoying.

But it's NOT okay if you have any other change in the index, even in a
file unaffected by the merge, because then the final state would not
be the result of the merge, and that could be confusing.

> Because (1)
> involves only the paths different between your branch and the
> remote branch you are pulling from during the merge (which is
> typically a fraction of the whole tree), you can have local
> modifications in your working tree as long as they do not
> overlap with what the merge updates.

Wonderfully clear.  Such changes must not exist at the git-read-tree
level, since there's not even a way to represent them to
git-merge-index.  Still, this can save considerable bother when
trying to track someone else's tree.

> When there are conflicts, these things happen:
>
>  (0) HEAD stays the same.
>
>  (1) Cleanly merged paths are updated both in the index file and
>      in your working tree.
> 
>  (2) For conflicting paths, the index file records the version
>      from HEAD. The working tree files have the result of
>      "merge" program; i.e. 3-way merge result with familiar
>      conflict markers <<< === >>>.
> 
>  (3) No other changes are done.  In particular, the local
>      modifications you had before you started merge will stay the
>      same and the index entries for them stay as they were,
>      i.e. matching HEAD.

So this is a lot like what CVS does, but neater because all the
merge sources are available unmodified in the index.  Excellent.

> After seeing a conflict, you can do two things:
>
> * Decide not to merge.  The only clean-up you need are to reset
>   the index file to the HEAD commit to reverse (1) and to clean
>   up working tree changes made by (1) and (2); "git-reset" can
>   be used for this.

Cool.  Two minor questions:

- Doesn't any non-trivial merge or invocation of git-update-index
  produce blob objects in the database that become garbage if you
  do this?  Or are they somehow kept separate until a tree object
  is created to point to them?

  (You could have an "unreferenced" bit in the index, indicating that
  the blobs in question could be found in .git/pending rather than
  .git/objects, until git-write-tree moved them into the database.
  But I don't see mention of any such scheme.)

- Is there any difference between "git-reset --hard" and "git-checkout -f"?

> * Resolve the conflicts.  "git-diff" would report only the
>   conflicting paths because of the above (1) and (2).  Edit the
>   working tree files into a desirable shape, git-update-index
>   them, to make the index file contain what the merge result
>   should be, and run "git-commit" to commit the result.

Okay, so git-update-index will overwrite a staged file with a
fresh stage-0 copy.  And git-commit will refuse to commit
(to be precise, it'll stop at the git-write-tree stage) if there
are unresolved conflicts.

If you want to see the unmodified input files, you can find their
IDs with "git-ls-files -u" and then get a copy with "git-cat-file blob"
or "git-unpack-file".  git-merge-index is basically a different way to
process the output of git-ls-files -u.


> *1* It is a shame that the most comprehensive definition of
> 3-way read-tree semantics is in t/t1000-read-tree-m-3way.sh test
> script.

Thanks for the pointer; I'll go and read it!

> *2* Cogito (things that start with cg-*) seems to try to be
> cleverer.  Pasky might want to brag about the rules in Cogito
> land.

In fact, he might want to explain what the difference is between cogito
and git.  Most particularly, are there any restrictions on mixing cg-*
and git-* operations from within the same directory?

I've been assuming that cogito is just series of friendlier
utilities, in much the same way that a text editor is friendlier
than "cat > kernel/sched.c", so I'll study it after I understand
core git.


One more question to be sure I understand merging... AFAICT, it would
be theoretically possible to stop distinguishing "stage 2" and "stage 0".
If there is only a stage 2 file, then in-index will immediately
collapse it to stage 0, and if there are any other stage files,
you know there's an incomplete merge.

(Alternatively, you could collapse "stage 3" and "stage 0", since
stages 2 and 3 are treated identically, but traditionally, stage 2 is
the "trunk" and state 3 is the "branch" being merged in.)
