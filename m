From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Current Issues #3
Date: Mon, 22 May 2006 03:18:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605220216310.3697@g5.osdl.org>
References: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 12:18:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi7UM-00060J-Ri
	for gcvg-git@gmane.org; Mon, 22 May 2006 12:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWEVKSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 06:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWEVKSL
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 06:18:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2520 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbWEVKSK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 06:18:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MAI4tH029355
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 03:18:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MAI3WC025261;
	Mon, 22 May 2006 03:18:03 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20495>



On Mon, 22 May 2006, Junio C Hamano wrote:
> 
> * Per branch configuration
> 
>   The [section "foo"] configuration syntax update by Linus, and
>   git-parse-remote update to use remote.stuff.{url,push,pull} by
>   Johannes are now both in the "master".  The stage is set to
>   discuss what to actually do with per-branch configuration.
> 
>   We will use the [branch "foo"] section for configuration about
>   local branch named "foo".  I do not think there is any
>   disagreement about this.
> 
>   The ideas floated so far (I am forgetting many of them
>   perhaps):
> 
>     1. "upstream" refers to the remote section to use when
>        running "git-{fetch,pull,push}" while on that branch.
> 
> 	[branch "master"]
> 		upstream = "origin"
> 
> 	[remote "origin"]
>         	url = "git://git.kernel.org/.../git.git"
> 		fetch = refs/heads/master:refs/remotes/origin/master
> 
>     2. "url/fetch/push" directly specifies what would usually be
>        taken from a remote section by "git-{fetch,pull,push}"
>        while on that branch.
> 
> 	[branch "foo"]
>         	url = "company.com.xz:myrepo"
> 		fetch = refs/heads/master:refs/remotes/origin/master
> 		push = refs/heads/master:refs/heads/origin

I'd _much_ prefer (1) over (2).

However, I wonder if we couldn't do even better. How about forgetting 
about the "branch" vs "remote" thing, and instead splitting it into 
_three_: "branch", "repository" and "remote branch".

Something like

	[repo "origin"]
		url = "git://git.kernel.org/.../git.git"

	[repo "gitk"]
		url = "git://git.kernel.org/.../gitk.git"

to describe two remote repositories (and NOTE! No branch descriptions 
within those. We're just describing the actual repository, so we might 
have things like "readonly" to indicate that we can't push to them, but if 
we do things like that, they would be "repo-wide" things that we 
describe for that repository),

Then, we can describe remote branches within those repositories:

	[remote "origin/master"]
		repo = origin
		branch = master

	[remote "origin/next"]
		repo = origin
		branch = next

	[remote "origin/pu"]
		repo = origin
		branch = pu

	[remote "gitk/master"]
		repo = gitk
		branch = master

now, here we're describing two things: the name of the remote is what we 
will then use for the ".git/remotes/<name>" thing to remember the last 
value, and we're describing where to get that data (which repo, and which 
branch).

NOTE! In the example above, I made the name of the remote always match the 
<repo>/<branch> format, but that would be just a convention. You could do

	[remote "linus"]
		repo = kernel
		branch = master

to describe the "linus" remote as the master branch of the "kernel" 
repository.

Finally, local branches:

	[branch "master"]
		source = origin/master

	[branch "origin"]
		readonly
		source = origin/master

	[branch "next"]
		readonly
		source = origin/next

	[branch "pu"]
		readonly
		rebase
		source = origin/pu

	[branch "gitk"]
		readonly
		source = gitk/master

This marks the things that just _track_ somebody elses branch as being 
readonly (so "master" and "origin" are really different: they're both 
branches, but one of them just tracks remotes/origin/master, while the 
other one can be committed to), and "pu" has been marked as not only being 
read-only, it also re-bases to its source.

I dunno. Does this sound too verbose and abstract?

Normally, you'd not have a lot of these. For example, for somebody who 
follows the kernel, you'd literally just have

	[branch "master"]
		source = linus

	[remote "linus"]
		repo = kernel
		branch = master

	[repo "kernel"]
		url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

and you'd be done. The above would describe both the local "master" branch 
and the "remotes/linus" head, and give the relationship between them.

The git repo is actually much more complex, especially if you want to 
track all of the different branches Junio has, and if you want to also 
track the branches Paul has to gitk.

But with the above, you can fairly naturally do:

 - "git pull" 

	No arguments. fetch the remote described by the current branch, 
	and merge into current branch (we might decide to fetch all the 
	remotes associated with that repo, just because once we do this, 
	we might as well, but that's not that important to the end 
	result).

 - "git pull <repo>"

	fetch all remotes that use <repo>. IFF the current branch is 
	matched to one of those remotes, merge the changes into the 
	current branch. But if you happened to be on another unrelated 
	branch, nothing happens aside from the fetch.

 - "git pull <remote>"

	fetch just the named remote. IFF that remote is also the remote 
	for the current branch, do merge it into current. Again, we 
	_might_ decide to just do the whole repo.

 - "git pull <repo> <branchname>"

	fetch the named branch from the named repository and merge it into 
	current (no ifs, buts or maybes - now we've basically overridden 
	the default relationships, so now the <repo> is just a pure 
	shorthand for the location of the repository)

 - "git pull <repo> <src>:<dst>"

	same as now. fetch <repo> <src> into <dst>, and merge it into the 
	current branch (again, we've overridden any default relationships).

but maybe this is overdesigned. Comments?

			Linus
