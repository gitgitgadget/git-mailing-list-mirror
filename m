From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 12:44:42 +0000 (UTC)
Message-ID: <loom.20070319T124736-893@post.gmane.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 13:45:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTHEc-00032e-5A
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 13:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbXCSMpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 08:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbXCSMpI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 08:45:08 -0400
Received: from main.gmane.org ([80.91.229.2]:53083 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933845AbXCSMpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 08:45:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HTHEN-0004GR-DS
	for git@vger.kernel.org; Mon, 19 Mar 2007 13:44:55 +0100
Received: from st-a-2.ingfo.unibo.it ([137.204.201.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 13:44:55 +0100
Received: from scallegari by st-a-2.ingfo.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 13:44:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.201.23 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.2) Gecko/20060601 Firefox/2.0.0.2 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42611>

Hi,

Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:

> 
> Hi,
> 
> I have a repository with a working tree on a machine A, did a clone to
> another machine B and commited there locally.
> 
> I want my changes to get back into the first repository, so I did a
> "push". The new commit is in the history, I can see it with "git log",
> but the modifications are not in the working tree.
> 
> This time, it's OK: I didn't have any uncommited modifications on A,
> so I just did a "git reset --hard HEAD" there.

At times I have a similar scenario, working with both an office-pc (attached to
the internet with a public static address) and a laptop (either detached from
the internet or attached to it under a dynamic address and NAT) 

> But if I had some uncommited changes, "git reset --hard HEAD" means
> data loss, which is precisely what I want to avoid by using a VCS. It
> seems a solution is to do:
> 
> $ git reset --soft <commit-id-before-the-push>
> $ git merge <commit-id-after-the-push>

I think that there might also be another option...
perhaps in some cases you might want to commit the local changes by branching
at <commit-id-before-the-push>...

For instance:
* you work on the office-pc: work work work (you do not commit yet, as you
expect you will be able to finish your stuff and commit after that)
* but for some reason you do not finish, you go away and you start working on
the laptop...
* you cannot pull the changes from the office-pc (as they are not committed)
and assume you cannot or don't want to retrieve them otherwise... so you start
working on what you have... work work work ... commit. You do not branch before
committing as this is a finished thing and you now believe it deserves going on
your current branch... (or you just have forgotten about the hanging stuff on
the office-pc)...
* As soon as you can, you push to the office-pc
* Since the local changes on the office-pc are relative to something that has
suddendly got older than the current branch-tip, you might want to merge, but
you also might not want to... you might prefer to complete the thing and first
test it as is... in this case you might want to branch, rather than merging.

So when you push to a non-bare repo, it might probably be nice to be able to
select between different behaviors:
A) Try to auto merge and refuse the push if merging is impossible (as it is
currently suggested)
B) Accept the push anyway (in the end if one machine is under NAT, pushing is
the only way to propagate changes), update the branch, loose the head and store
somewhere some information like "I used to be in branch so and so, but I am not
anymore at the branch tip since that has been changed, local changes are against
commit ..."  In this way the non-bare repo can start working as if it has become
a headless checkout with local changes, explaining the situation and suggesting
appropriate action (either merging or branching) to the user...
something like:
git status (or git commit)
No current branch since the repository has been changed from outside this
working tree... Cannot commit... Your last branch was ...
Possible options
< suggestion for merging >
< suggestion for branching >

I do not know if this makes any sense at all, since my usage of git is somehow
limited and atypical (e.g. due to the 2 machines) and I might be missing many
many implications...

However B looks like a behavior that could be applied also in the case of
multiple working trees insisting on a single repo, like in Junio's recen post
where he wrote:

 > These days I use a few working trees that are connected to my
> primary repository (which also has a working tree).  The primary
> repository is in /src/git, and other ones look like this:
> 
> : gitster git.wk0; ls -l .git/
> total 120
> drwxrwsr-x  3 junio src  4096 Mar  5 16:22 ./
> drwxrwsr-x 15 junio src 16384 Mar  5 16:23 ../
> -rw-rw-r--  1 junio src    41 Mar  5 16:22 HEAD
> lrwxrwxrwx  1 junio src    27 Mar  3 22:53 config -> /src/git/.git/config
> lrwxrwxrwx  1 junio src    26 Mar  3 22:53 hooks -> /src/git/.git/hooks/
> -rw-rw-r--  1 junio src 82455 Mar  5 16:22 index
> lrwxrwxrwx  1 junio src    25 Mar  3 22:53 info -> /src/git/.git/info/
> drwxrwsr-x  3 junio src  4096 Mar  3 22:59 logs/
> lrwxrwxrwx  1 junio src    28 Mar  3 22:53 objects -> /src/git/.git/objects/
> lrwxrwxrwx  1 junio src    32 Mar  3 22:53 packed-refs ->
/src/git/.git/packed-refs
> lrwxrwxrwx  1 junio src    25 Mar  3 22:53 refs -> /src/git/.git/refs/
> lrwxrwxrwx  1 junio src    28 Mar  3 22:53 remotes -> /src/git/.git/remotes/
> lrwxrwxrwx  1 junio src    29 Mar  3 22:53 rr-cache -> /src/git/.git/rr-cache/
> 
> It shares everything other than HEAD and the index (the reflog
> for branches are also shared by a symlink .git/logs/refs
> pointing at the one in the primary repository).
> 
> This risks confusion for an uninitiated if you update a ref that
> is checked out in another working tree, but modulo that caveat
> it works reasonably well.
> 
> We might want to add an option to 'git-clone' to create
> something like this, but I am somewhat worried about the newbie
> confusion factor.  Perhaps...
> 
> $ git clone --i-know-what-i-am-doing-give-me-an-alternate-working-tree \
>   /src/git /src/git.wk0


So, did I miss something?
 
Many thanks,

Sergio
