From: "Lauri Alanko" <la@iki.fi>
Subject: A design for subrepositories
Date: Sat, 13 Oct 2012 16:33:22 +0300
Message-ID: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; DelSp="Yes"; format="flowed"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 15:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN2Cy-00036n-Qx
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 15:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab2JMN4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 09:56:41 -0400
Received: from smtp-rs1-vallila2.fe.helsinki.fi ([128.214.173.75]:45226 "EHLO
	smtp-rs1-vallila2.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752297Ab2JMN4k convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 09:56:40 -0400
X-Greylist: delayed 1384 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Oct 2012 09:56:40 EDT
Received: from webmail.helsinki.fi (webmail1-vallila2.fe.helsinki.fi [128.214.173.135])
	by smtp-rs1.it.helsinki.fi (8.14.4/8.14.4) with ESMTP id q9DDXMcF012303;
	Sat, 13 Oct 2012 16:33:23 +0300
Received: from scan-proxy1-1.it.helsinki.fi (scan-proxy1-1.it.helsinki.fi
	[128.214.2.137]) by webmail.helsinki.fi (Horde Framework) with HTTP; Sat,
	13 Oct 2012 16:33:22 +0300
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207573>

Hello.

I intend to work on a "subrepository" tool for git, but before I  
embark on the actual programming, I thought to first invite comments  
on the general design.

Some background first. I know that there are several existing  
approaches already for managing nested repositories, but none of them  
quite seems to fit my purposes. My primary goal is to use git for home  
directory backup and mirroring, while the home directory itself may of  
course contain repositories.

Git-subtree doesn't quite fit the bill. It allows merging a subtree  
into a larger tree and then again splitting it out for exporting, but  
this is tedious. More importantly, a merged tree gets branched along  
with the containing tree, whereas I want to have subrepositories  
precisely because the subtrees need to be branched independently of  
the container.

Submodules are a bit closer to what I want, but they have clearly been  
designed for a different purpose: a repository with submodules is only  
supposed to collate existing repositories, not act as a source for  
them. So they aren't really faithful to the distributed nature of git:  
there's no easy way to completely clone a repository and its submodules.

Moreover, submodules have some other annoyances like not supporting  
bare repositories and checking out the submodules in detached heads.

Now, in other circumstances I might just patch git-submodule to add  
the features I want, but it turns out that it is written in shell. I  
know that is a git tradition, but I'm going to get a bit religious  
here: anything longer than a screenful shouldn't be written in shell,  
and I'm certainly not going to add more lines to an already overlong  
script. Hence I'm going to write a separate tool using something a bit  
more... structured. Probably Python with Dulwich.

So here are some preliminary thoughts on how the tool should work.


* Repository layout

Every subrepository has a unique identifier. The heads of  
subrepository <subname> are simply stored as heads in a subdirectory  
of the main repository: e.g.  
refs/heads/subrepos/<subname>/<branchname>. Likewise for tags:  
refs/tags/subrepos/<subname>/<tagname>.

Rationale: if we had fully independent repositories under the main  
repository directory, like what git-submodule uses, there would be no  
easy way to enumerate all the existing subrepositories to copy them.  
Since the only thing we can directly list from a remote repository are  
references, it makes sense to store the subrepositories just as a  
bunch of them.

The reason for storing the subrepo references under refs/heads/ and  
refs/tags/ (instead of, say, refs/subrepos/) is simply that this way  
everything is directly compatible with standard git tools: one can do  
a normal git clone/push/pull for mirroring and backup purposes without  
any need for special tools. You only need tools once you operate on a  
working tree.


* Tree layout

A tree can mount references of subrepositories. There are two  
components to a mount: a gitlink under <path> to a particular commit  
of a subrepo, and an entry in .gitrepos. This is very similar to how  
git-submodule works.

The entry in .gitrepos specifies two things: the name of the  
subrepository mounted under <path>, and the active branch in that  
mount at the time of commit. So .gitrepos would look like this:

[mount "<path>"]
    subrepo = <subname>
    branch = <branchname>

Rationale: by storing the active branch name we can cater for the very  
common case where we check out a gitlink pointing to the current head  
of the branch. Then, when we check out the subrepository at the mount  
point, we can adjust HEAD to point to the correct branch.

By associating from a path to a subrepository (instead of the other  
way, as git-submodule does), we can have multiple mount points for the  
same subrepository, presumably with different active branches.  
Sometimes we want to have separate working trees for various branches,  
and it's good to be able to store this configuration in the containing  
tree.


* Working tree layout

When a tree containing mount points is checked out, a repository is  
created at each of those mount points. For every <path> specified in  
.gitrepos with subrepo <subname> and active branch <branchname>, and a  
gitlink in <path> pointing to <commit>, we do the following:

- Create a repository under <path>/.git

- Add the object store of the containing repository to  
<path>/.git/objects/info/alternates

- Pull (just copy, really) the containing repository's references to  
the subrepository as follows:

  - refs/heads/subrepos/<subname>/* -> refs/heads/*
  - refs/tags/subrepos/<subname>/* -> refs/tags/*
  - refs/remotes/<remote>/subrepos/<subname>/* -> refs/remotes/<remote>/*

- If now in the subrepository refs/heads/<branchname> points to  
<commit>, set HEAD as a symref to it. Otherwise set a detached HEAD  
directly to <commit>.

- Check out HEAD in the subrepository.

Rationale: it was a tempting idea to make refs/heads and refs/tags to  
be symlinks directly to the correct subdirectories in the containing  
repository, and likewise make objects/ directly a symlink to the  
containing repository's object store. However, this is not really  
feasible due to packed-refs, and it would make symlinks a requirement,  
something that git tries to avoid. (Of course "directory symrefs"  
would be a simple addition to the core.)

More importantly, a symlink to the object store would break git-gc.  
Also, it would be ugly to have ref manipulations under the mount point  
directly affect the refs in the containing repository. It's better  
that none of the changes under the mount point affect the containing  
repository in any way before an explicit add and check-in. At this  
point the refs are pulled back in the reverse direction.


* Basic commands


** git subrepo add <path> [<subname>]

Add a subrepository to the containing repository, or add the changes  
in a subrepository to the index.

If <path> is not yet found in .gitrepos, <subname> must be specified.  
Otherwise <subname> is looked up from .gitrepos.

The command performs the following:

- Add or update the gitlink to the index: git add <path>
- Add or change an entry in .gitmodules, setting mount.<path>.subname  
to <subname> and mount.<path>.branch to the active branch under <path>  
(if any).
- git add .gitmodules


** git subrepo checkin [-f] [<path>...]

Update the subrepo references in the containing repository to the  
references in the mount points. This is meant to be run as a  
pre-commit hook with no arguments.

If no paths are given, <path>... defaults to every mount path in  
.gitrepos that has been changed in the index. For each <path> mounting  
<subname>, perform the following:

- git fetch [-f] <path> refs/heads/*:refs/heads/subrepos/<subname>/
- git fetch [-f] <path> refs/tags/*:refs/tags/subrepos/<subname>/

If [-f] is given, it is passed to git fetch.

The operation can fail in the unlikely case that there are multiple  
mount points for the same subrepository, and a branch has diverged  
between those mount points.

Note: after this operation, any new objects that were added under the  
mount point are now duplicated in the containing repository. A git gc  
in the containing repository followed by a git gc in the mount point  
should remove the now-redundant objects from the mount point.

Note: the default paths overlook the spurious case where have modified  
the head of a non-active branch under the mount point, but the active  
branch (and hence the commit in the gitlink) have remained unchanged.  
I don't know if there's a reasonable way to make "git subrepo add"  
somehow stage even these kinds of changes.


** git subrepo checkout [<path>...]

Check out the subrepositories at mount points <path>..., or at all the  
mount points if none are specified. This is meant to be run as a  
post-checkout hook with no arguments.

This is described above in "Working tree layout". If this is not an  
initial checkout, then the first two steps are skipped and just the  
refs and working tree are updated.


** git subrepo mv <path> <path>

Move a mount point: git mv the actual directory and adjust the path in  
.gitrepos and possibly the relative path in  
<path>/.git/objects/info/alternates. (An absolute path would fix the  
latter, but then we couldn't move the entire containing repository.  
This is the lesser evil, IMHO.)

Gripe: why doesn't git support arbitrary metadata for tree entries?  
Then we wouldn't need to worry about syncing various path attributes  
that are stored in separate files, but a simple git mv could  
automatically move everything associated with the path.


** git subrepo rm <path>

Remove the mount point and its entry in .gitrepos.


* A variant design

The above design is straightforward to implement, but it has a bit of  
an ad-hoc feel in that we have these magic commands that transfer refs  
between the containing repository and the mount points. But there are  
already standard tools for transferring refs: push and pull/fetch. It  
would be more "git-like" to use these directly, and make the  
containing repository be simply a remote for the mount point. We need  
a special remote for this purpose: git-remote-subrepo gives a "view"  
of the refs of a particular subrepo within the ref tree of the  
containing repository. It just makes the following translations for  
push and fetch:

subrepo://<URL>/<subname> refs/heads/<branchname>
-> <URL> heads/subrepos/<subname>/<branchname>

subrepo://<URL>/<subname> refs/tags/<tagname>
-> <URL> tags/subrepos/<subname>/<tagname>

subrepo://<URL>/<subname>/<remote> refs/heads/<branchname> ->
-> <URL> remotes/<remote>/heads/subrepos/<subname>/<branchname>

subrepo://<URL>/<subname>/<remote> refs/heads/<branchname> ->
-> <URL> remotes/<remote>/heads/subrepos/<subname>/<branchname>

Then subrepo://<containingrepo>/<subname> is set as the origin in the  
mount point, so one can just do a normal git push to push the changes  
to the containing repository. Likewise, for all the remotes in the  
containing repository, a remote with the same name is created under  
the mount point with the url  
subrepo://<containingrepo>/<subname>/<remote>. Or it can be set to  
directly access the actual remote:  
subrepo://<url-of-remote>/<subname>. It's a matter of taste.

The problem with explicit pushing to the containing repository is that  
then changes to the refs happen completely independently of changes to  
the gitlinks, and ideally these should be synchronized in a single  
commit. So I'm not quite sure if the additional complexity of a remote  
helper is warranted.


I hope I managed to make some sense of what this is about. Questions  
and comments are appreciated.

Cheers,


Lauri
