From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: rebase -i segmentation fault and another problem
Date: Mon, 27 Sep 2010 11:01:10 -0500
Message-ID: <E2A2pg3JJJ3HO95lSjieK3cGmuaKW6JyYGAV6A_XDmFJCJGyAYa00A@cipher.nrlssc.navy.mil>
References: <20100927142327.GW6756@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, python-faculty@g-node.org
To: Zbyszek Szmek <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0G94-0002In-J7
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857Ab0I0QBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:01:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36263 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab0I0QBd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:01:33 -0400
Received: by mail.nrlssc.navy.mil id o8RG1BwE018592; Mon, 27 Sep 2010 11:01:11 -0500
In-Reply-To: <20100927142327.GW6756@in.waw.pl>
X-OriginalArrivalTime: 27 Sep 2010 16:01:11.0295 (UTC) FILETIME=[345200F0:01CB5E5D]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157344>

On 09/27/2010 09:23 AM, Zbyszek Szmek wrote:
> Hi,
> I get a core dump when trying to remove a commit from the tip
> of a branch which was merged with a branch with a different
> root. Sorry if this is unclear - picture might help:
> 
>  *-*-m-r
>     /
>  z-*
> 
> (m is merge point, and r is the commit to be removed,
>  z is initial commit on the other branch).
> 
> A simple 'git reset --hard HEAD^' works, I know. But:
> 
> $ git rebase --interactive HEAD~2
> Segmentation fault (core dumped)
> 
> Could not apply 532e7e0... z
> 
> The core files comes from 'git cherry-pick ...',
> and indeed it's enough to run this command directly:
> 
> $ git-cherry-pick --ff 532e7e0
> [2]    9582 segmentation fault (core dumped)  git-cherry-pick --ff 532e7e0
> 
> gdb:
> Program terminated with signal 11, Segmentation fault.
> #0  do_pick_commit (argc=3, argv=<value optimized out>) at builtin/revert.c:445
> 445 		   if (allow_ff && !hashcmp(parent->object.sha1, head))
                                            ^^^^^^
Looks like gdb points us to exactly where the problem is.
"parent" should be checked for NULL as it is in the 'if' statement
following this one at line 445.

Since your 'b' commit is a root commit, it has no parents.  In the cascading
'if' statement preceding line 445, parent was set to NULL for this case.
Then here at line 445, we try to dereference parent to get object.sha1. fail.

The fix seems to be this (copy/paste):


diff --git a/builtin/revert.c b/builtin/revert.c
index 4b47ace..57b51e4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -442,7 +442,7 @@ static int do_pick_commit(void)
        else
                parent = commit->parents->item;
 
-       if (allow_ff && !hashcmp(parent->object.sha1, head))
+       if (allow_ff && parent && !hashcmp(parent->object.sha1, head))
                return fast_forward_to(commit->object.sha1, head);
 
        if (parent && parse_commit(parent) < 0)



> (gdb) bt
> #0  do_pick_commit (argc=3, argv=<value optimized out>) at builtin/revert.c:445
> #1  revert_or_cherry_pick (argc=3, argv=<value optimized out>) at builtin/revert.c:576
> #2  0x000000000040499a in run_builtin (argc=3, argv=0x7fff86b20ba8) at git.c:275
> #3  handle_internal_command (argc=3, argv=0x7fff86b20ba8) at git.c:431
> #4  0x0000000000404f9f in main (argc=3, argv=0x7fff86b20ba8) at git.c:516
> 
> Repo which shows this behaviour can be created with:
> git init repo1; cd repo1
> touch a; git add a; git commit -m a
> cd ..
> git init repo2; cd repo2
> touch b; git add b; git commit -m b
> cd ../repo1
> git pull ../repo2
> touch c; git add c; git commit -m c
> git rebase --interactive HEAD~2
>  (just save without doing anything -> segmentation fault)
> 
> 
> $ git --version
> git version 1.7.3 (compiled from git/master) 


And a stacktrace...  You included all of the information needed to
investigate and reproduce this issue.  Great bug report!  Thanks.

> --------------------------------------------------------
> 
> Another small problem with git rebase --interactive: in the same repo,
> running git rebase HEAD~1 and removing the only commit on the list
> doesn't do anything (repo is unchanged). The expected behaviour
> would be to remove the tip of branch...

This is actually documented behavior.

Read the last comment in the buffer that rebase --interactive gives
you (after the list of commits).  It says:

   # If you remove a line here THAT COMMIT WILL BE LOST.
   # However, if you remove everything, the rebase will be aborted.

-Brandon
