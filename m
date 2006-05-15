From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: The git newbie experience
Date: Mon, 15 May 2006 10:46:10 -0600
Organization: Hewlett Packard
Message-ID: <20060515164610.GA24295@hpsvcnb.fc.hp.com>
References: <446778B8.7080201@inoi.fi> <7vfyjcntro.fsf@assigned-by-dhcp.cox.net> <44680C54.8040206@inoi.fi> <7vy7x3x3ux.fsf@assigned-by-dhcp.cox.net> <20060515053133.GB28068@spearce.org> <7v1wuvvg0j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, Tommi Virtanen <tv@inoi.fi>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 18:46:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfgD1-0005BD-5V
	for gcvg-git@gmane.org; Mon, 15 May 2006 18:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWEOQqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 12:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWEOQqM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 12:46:12 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:55213 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964868AbWEOQqM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 12:46:12 -0400
Received: from smtp2.fc.hp.com (smtp2.fc.hp.com [15.11.136.114])
	by atlrel7.hp.com (Postfix) with ESMTP id 5CAF934708;
	Mon, 15 May 2006 12:46:11 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 1BD4819CE5;
	Mon, 15 May 2006 16:46:11 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id F1E604370; Mon, 15 May 2006 10:46:10 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>, Tommi Virtanen <tv@inoi.fi>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v1wuvvg0j.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20067>

Junio,

This seems a lot like what I tried to do with git-undo/git-redo quite a
while back.

My implementation actually wrote the working file state into the object
store as a tree and stored a reference to the tree under something like
.git/refs/undo (or .git/refs/stash).  Redo was a simple merge of this
tree back onto the current working files.

I think I would like something like this better than the 'generate
binary patch and reapply the patch later.

If these commands were added to git I think they would be better if the
commands chose a temporary branch name, committed the current state to
that branch and did everything else that someone more experienced would
do using branches having chosen a temporary branch name.

The redo or unstash operation could just pick the most recent tempory
branch name (top of stack) and merge changes into the working copy.

Carl

On Mon, May 15, 2006 at 01:39:08AM -0700, Junio C Hamano wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> I'd rather do that with a diff file that can be used to do a
> >> 3-way (see how rebase does it with --full-index diff with am -3).
> >> No point creating and forgetting to remove a throw away branch
> >> and getting more complaints.
> >
> > How is a quick stash different from a topic branch?
> 
> The original version of my message in response to TV looked like
> this.
> 
>  - Jack is a beginning user of git and does not (want to) understand
>    the index (right now).
> 
>  - Jack works on branch X, say his HEAD points to X1. He has an edited,
>    uncommitted files with the names A, B and C.
> 
>  - Jack wants to pull new changes made by others to his branch.
>    But "git merge" invoked from "git pull" says he needs to stash
>    away the local changes to do the merge.
> 
>  - Jack stashes away what he has been working on and cleans up
>    his mess.
> 
>    git checkout -b stash ;# risks error when "stash" exists
>    git commit -a -m 'Stashing WIP'
>    git checkout master ;# assuming that was where he was
> 
>  - Jack then pulls.  There are merge conflicts in files D, E, ..., Z.
> 
>  - Jack resolves the merge conflicts and is ready to commit the resulting
>    merge. Note files A, B and C do not have his unfinished work.
> 
>    There is no "if Jack does this or that" problem; he says "git
>    commit -a" because that is the only "commit" command he knows
>    about.
> 
>  - Jack then reapplies what he stashed away, and keeps working.
> 
>    git pull . --no-commit stash
>    git branch -D stash
> 
> You have to teach the new user to (1) name something, only to
> immediately discard it when he returns to what he was in the
> middle of, (2) remember to clean up the temporary thing once he
> is done lest he forgets to clean it up (and common names like
> "stash", "tmp" will be reused by accident causing grief next
> time he needs to do another stash), and (3) use of --no-commit
> pull.
> 
> On the other hand, "git stash/unstash" workflow would be quite
> simple:
> 
> 	$ git stash >my.precious.state
>         ... do whatever you want to deviate to
>         $ git unstash <my.precious.state
> 
> Merge resolve might be needed while unstashing, but 
> we are talking about pulling somebody else's work in "do
> whatever" part, so that is something the user knows how to
> perform anyway.
> 
> A quick and dirty stash implementation would go like this:
> 
> Stash is easy.
> 
>         #!/bin/sh
>         # git stash
>         git diff --binary HEAD
>         git reset --hard
> 
> Unstash is a bit involved.
> 
>         #!/bin/sh
>         # git unstash
>         . git-sh-setup
>         O_OBJECT=`cd "$GIT_OBJECT_DIRECTORY" && pwd`
>         O_DIR=`cd "$GIT_DIR" && pwd`
>         stash="$O_DIR/.stash$$"
>         rm -fr "$stash.*"
>         trap 'rm -rf $stash.*' 0
>         cat >"$stash.patch"
>         git-apply -z --index-info <"$stash.patch" >"$stash.list"
>         GIT_INDEX_FILE="$stash.index"  \
>         GIT_OBJECT_DIRECTORY="$O_OBJECT" \
>         (
>                 mkdir -p "$stash.tmp" &&
>                 git-update-index -z --index-info <"$stash.list" &&
>                 git-write-tree >"$stash.base" &&
>                 cd "$stash.tmp" &&
>                 git-apply --binary --index <"$stash.patch" &&
>                 git-write-tree >"$stash.his"
>         )
>         his_tree=$(cat "$stash.his")
>         orig_tree=$(cat "$stash.base")
>         rm -fr "$stash.*"
>         git-merge-resolve $orig_tree -- HEAD $his_tree
> 
> This is essentially the core of "am -3" logic; if you are going
> to use this for real, you would probably want to see if the
> patch applies cleanly before falling back on the three-way
> merge, though.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
