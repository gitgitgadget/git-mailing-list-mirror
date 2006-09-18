From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull a subtree, embedded trees
Date: Mon, 18 Sep 2006 02:42:55 -0400
Message-ID: <20060918064255.GA20660@spearce.org>
References: <4508020F.2050604@sgi.com> <ee945j$h3u$1@sea.gmane.org> <450E3399.5070601@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 08:43:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPCqa-0006AR-A7
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 08:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965480AbWIRGnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 02:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965481AbWIRGnF
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 02:43:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50632 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965480AbWIRGnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 02:43:02 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPCqI-0002Do-1j; Mon, 18 Sep 2006 02:42:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9798120E48E; Mon, 18 Sep 2006 02:42:55 -0400 (EDT)
To: Timothy Shimmin <tes@sgi.com>
Content-Disposition: inline
In-Reply-To: <450E3399.5070601@sgi.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27234>

Timothy Shimmin <tes@sgi.com> wrote:
> Jakub Narebski wrote:
> >Tim Shimmin wrote:
> >
> >>I'm new to git and have a couple of novice questions.
> >>
> >>* Is it possible to only pull in a subtree from
> >>a repository.
> >
> >I assume that by pull you mean checkout...
> >
> >I think it is possible (try git-read-tree with --prefix option, 
> >and select subtree by giving either it's sha1, or e.g.
> >HEAD:<path> form), but not easy to do. Git revisions are 
> >snapshots of the whole project (the revisions are states of
> >the whole project).
> >
> I'm not sure if that was what I was wanting.
> 
> I'm just starting to understand git better (I think:).
> It seems like it is about having object snapshots.
> We have snapshots of files (blobs) and snapshots of a directory,
> tree objects which reference other trees and blob snapshots,
> and then we link the snapshots in time using commit objects.
> So every time we do a "git-update-index file" we create a new blob
> in the object directory and every time we do a "git-write-tree" we
> create tree objects in the database (.git/object/xx/xxxx....).

Right, but only if the object didn't previously exist.  Git assumes
that the SHA1 hash of the given file content or tree content is
unique and uses that to decide if it already has a copy of the
object, or needs to save a copy into .git/objects/xx/xxx...

> So at these snapshot points, do we just keep adding more and
> more objects?

Yes, assuming we don't have the object already.

> I'm used to rcs and sccs, where we just keep diffs for file history,
> we don't do that here do we?; we keep the whole snapshot but in compressed
> form. (And then we have a packed form too.)

Git does diffs, but they are delayed.  What happens is the
compressed (but complete) content is written to a loose object in
the .git/objects directory during git-update-index, git-write-tree
and git-commit-tree.  Later during git-repack these loose objects
are bundled up into a new pack file.  Within the pack file objects
can be deltafied against one another.  Consequently what you find
is that revisions of the same file are "diff'd" against one another
once those objects are all combined up into the same pack.

Git is very good at this compression; the Mozilla CVS repository
went from ~3 GiB in CVS to ~430 MiB in Git.  That's 10 years of
history on 120k files.

> So trying to understand your suggestion and the command:
> Given a tree object in our object database, we can update our
> index with the tree objects but they will be stored in the index
> with entry names which have prepended to them the given "prefix/".

Yes.  But according to the git-read-tree documentation there must be
no existing entries in the index under "prefix/".  This makes merging
very difficult.  And merging is a core feature of a distributed SCM.

> We can then use git-checkout-index to populate our workarea
> with the prefix/ files and dirs.

Well, yes.  Assuming you were able to hammer the index into
reflecting the structure you'd like to have your working directory
take on.

> So how do I get the foreign tree objects into the database;
> just copy them in?

Uh, yes, but don't do that.  Use `git fetch` instead to copy the
commit(s) in question and all tree and blob objects they reference.
For one thing it should be faster; for another it will correctly
walk into pack files and extract only the objects needed.

> And this works with prefix/ dir not already existing in workarea.
> Hmmmmm....

Only with it not existing in the working directory.  If prefix/
already was there you would likely encounter problems with the
git-checkout-index invocation complaining about those files already
existing and not wanting to overwrite them.  Same thing happens
with a merge git-read-tree invocation, which happens a lot in Git
to update the working directory.

> >>Moreover, is it possible to have a subtree based on another
> >>repository.
> >
> >It is possible. For example, make empty directory <subproject>
> >somewhere, add this directory, or just all the files in it
> >either to .gitignore or .git/info/excludes file, then clone
> >the other project (subproject) to this place. You would have
> >the following directory structure
> >
> >  /
> >  dir1
> >  dir2
> >  dir2/subdir
> >  subproject
> >  subproject/.git
> >  subproject/subprojectsubdir
> >  ...
> >
> This could be handy.
> Looks like by using .gitignore, I can check the file in.
> (So the ingore/excludes are used by git scripts which call
> git-ls-files --others.)

Right.  By convention .gitignore is read out of each directory to
find all ignore patterns for that directory and all subdirectories
contined within it.  As such you can check it into the project
to share it across all users.

> >>* Are there any tools for dumping out the contents of the
> >>git objects in the .git/objects directory.
> >>By dumping out, I mean an ascii representation of the data
> >>fields for the commit and tree objects in particular.
> >>I've written a simple small program to dump out the index
> >>entries (cache entries).
> >
> >git-cat-file -p
> >
> Excellent, thanks. (looks like the option is undocumented - secret option:)

Hmm; it's documented in ed90cbf5 by Jeff King; this is 68 commits
before v1.4.0 so I'd say its definately in v1.4.0 and later.

> So I added this to a script which walks over the objects directory,
> to work out what all the object ids are so I can apply git-cat-file
> to all the objects on my test directory.
> I guess this will fall down if the objects are stored in a pack :)
> I'll have to look and see how to extract all the object ids using
> some command.

Try this:

	git-rev-list --all 

this will scan every ref and tag listed in .git/refs and proceed to
print the entire DAG they represent, including all commits, trees
and blobs.  Git uses this internal to form the list of objects which
should be included into a pack file.  It will include everything
that is also packed.

But I'd have to say say its sort of strange to walk over every
object in a repository and dump it to text with git-cat-file -p.

> What I have is an existing full tree with a subproject directory.
> And then I have a separate tree just for the subproject.
> The development happens in the subproject tree.
> At certain points we want to update the existing full tree's subproject
> directory with the work we have done in the subproject tree.
> At these points I'd like to effectively copy over the new tree objects
> and blobs to the full tree, but I guess I'd need new commits
> (which are based on the new commits of the subproject tree which would
> include their commit messages)
> which refer to new higher level tree objects (which refer down
> to my subproject tree objects).
> This presupposes that no other outside changes happened to subproject
> in the full tree - since I'm just copying over objects.
> Probably should be merging, just in case.
> Does this sound too confusing and awkward? :)

Yes.  :)

But this may be able to be done in a somewhat sane (or perhaps
insane) fashion using current tooling.  Lets say you want a
structure of:

	full/
		Makefile
		subA/
			Makefile
			a.c
		subB/
			Makefile
			b.c

with "full/" being the full repository that's updated at specific
points to specific revisions of smaller repositories "subA/" and
"subB/", each of which are developed on their own independently.

Then make all 3 their own Git repositories.  Except in the "subA/"
repository layout your files within the "my-subA" repository within
a single "subA" top level directory:

	my-subA/
		subA/
			Makefile
			a.c

and do the same for subB.  This will help when it comes time to
merge subA and subB into full.

subA and subB are completely isolated and can develop at will.
Now to upgrade full's subA to some branch or tag X of subA we can do:

	cd full
	git fetch ../path/to/my-subA X:refs/heads/tmp-subA

that just copied everything for commit X from ../path/to/my-subA
into full and stored it locally as branch tmp-subA but it hasn't
merged it yet.

	git pull . tmp-subA

will merge the tmp-subA branch into the current branch.  Now this
will cause a complete merge of the "subA/" directory content to
occur but it will avoid all other directories.  This happens because
the tmp-subA branch *ONLY* has a "subA/" directory and no other
top level files or directories, and because the current branch in
full also has a "subA/" directory which is a lot like the "subA/"
directory in tmp-subA.  (This is why the individual subprojects
have only one top level directory in them and why that directory
matches with its name within full.)

Later on to upgrade again the merge should pretty much go the
same way.  Except the last merge between full and subA will be
automatically used as the merge base, which is exactly what you want.


The standard merge driver (git-merge-recursive or git-merge-recur)
will freak out and take a *very* long time to execute the "git pull"
portion of the merge process if there are a lot of files in full/
which are not in subA/.  In this case you may wish to use a more
direct merge approach if the directory was not changed in full.

So a faster (but more complex) approach to merging in tmp-subA
during an update is:

	cd full
	git fetch ../my-subA X:refs/heads/tmp-subA
	base=$(git merge-base HEAD tmp-subA)
	if [  $(git rev-parse --verify $base:subA) \
	    = $(git rev-parse --verify HEAD:subA)
	then
		t=$(git ls-tree HEAD | ## replace ID of subA ## | git mk-tree)
		c=$(echo "Updated subA"|git-commit-tree $t -p HEAD -p tmp-subA)
		git update-ref HEAD $c
	else
		echo panic: full changed subA, full manual merge required
		git pull . tmp-subA
	fi

I've glossed over the '## replace ID of subA ##' part but the idea
here is that you can list an existing tree with ls-tree and if you
edit the output of that and feed it back into git mk-tree you can
produce a different tree with whatever content you want it to have.

The general concept here is that if the subA subdirectory hasn't
changed IDs between the last time full and subA were merged together
than that means that full hasn't changed subA.  Consequently we
can just wholesale replace the subA directory with the new one
we got from subA.  We do that by editing the tree with a simple
search/replace then generate a merge commit which merges the two
branches together.

Assuming full never modifies a subrepository the mk-tree hack above
should be *very* fast (few milliseconds on nearly all hardware)
no matter how many files are in full or the individual subrepository.


Either method (`git pull` or the mk-tree hack above) will preserve
the full development lineage on every subdirectory within the larger
full repository yet allow the individual subdirectory repositories
to be worked on in isolation.  Either method will also record as
part of full's history who merged in the updated subrepository, when
they did it, and what version of the subrepository got merged in.

However due to the "overlay" structure being applied here there
is some planning involved with regards to directory naming, as
well as some difficulty in forming a temporary working area of just
subdirectory repositories that layout the same way as they would when
merged into a full repository.  Its also basically impossible to take
changes from full and move them back to the relevant subrepository
(though git-cherry-pick may help there).


[*1*] I totally did not expect $(git rev-parse --verify HEAD:subA) to
      return the ID of subtree subA within branch HEAD.  Yet it does.
      Talk about an unexpected bonus from Junio's quick cat-file
      sha1 file path expression hack!

-- 
Shawn.
