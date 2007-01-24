From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Problem with git push over <hostname>:/path protocol (ssh)
Date: Wed, 24 Jan 2007 15:04:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701241453410.20138@iabervon.org>
References: <17847.47131.694158.247941@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 21:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9oMe-0006rq-Hj
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXAXUE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 15:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbXAXUE4
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:04:56 -0500
Received: from iabervon.org ([66.92.72.58]:3456 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011AbXAXUEz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 15:04:55 -0500
Received: (qmail 27580 invoked by uid 1000); 24 Jan 2007 15:04:54 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jan 2007 15:04:54 -0500
In-Reply-To: <17847.47131.694158.247941@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37671>

On Wed, 24 Jan 2007, Bill Lear wrote:

> We are seeing very strange behavior with git (1.4.4.1, and 1.5.0-rc2)
> that results in a push to a remote repo leaving modified files in
> the remote repo.  Here is the gist (slightly edited for clarity):
> 
> On machine1:
> 
> % mkdir git_it
> % git init-db
> % echo lksjdflksdf > foo
> % git add foo
> % git commit -a -m foo
> % git status
> [nothing, all clear]
> 
> On machine2:
> 
> % git clone machine1:/path/to/git_it
> Initialized empty Git repository in /home/blear/tst/git_it/.git/
> remote: Generating pack...
> remote: Done counting 3 objects.
> remote: Deltifying 3 objects.
> remote:  100% (3/3) done
> remote: Total 3, written 3 (delta 0), reused 0 (delta 0)
> Indexing 3 objects.
>  100% (3/3) done
> % cd git_it
> % git co -b new_branch
> % echo -e "\nbar fig dongle\n" >> foo
> % git commit -a -m foo
> Created commit 082d40b1906eecc8a26f6e6e5500c476a8e4311f
>  1 files changed, 3 insertions(+), 0 deletions(-)
> % git co master
> % git pull . new_branch
> Updating f404614..082d40b
> Fast forward
>  foo |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> % git push
> updating 'refs/heads/master'
>   from f4046144d031a779c7127b01ce6241fd66eb9f54
>   to   082d40b1906eecc8a26f6e6e5500c476a8e4311f
> Generating pack...
> Done counting 5 objects.
> Result has 3 objects.
> Deltifying 3 objects.
>  100% (3/3) done
> Writing 3 objects.
>  100% (3/3) done
> Total 3 (delta 0), reused 0 (delta 0)
> Unpacking 3 objects
> refs/heads/master: f4046144d031a779c7127b01ce6241fd66eb9f54 -> 082d40b1906eecc8a26f6e6e5500c476a8e4311f
> 
> On machine1:
> 
> % cd git_it
> % git status
> # Updated but not checked in:
> #   (will commit)
> #
> #       modified:   foo
> #
> % cat foo
> foo
> % git diff --cached
> diff --git a/foo b/foo
> index 5b9d7b1..0155b25 100644
> --- a/foo
> +++ b/foo
> @@ -1,4 +1 @@
>  lksjdflksdf
> -
> -bar fig dongle
> -
> 
> So, if the developer then commits on his branch on machine 1, all his
> changes get undone.  This has happened to him consistently --- he is
> running git 1.4.4.1 throughout.  I just reproduced it using the above,
> and I am using 1.5.0-rc2 on machine 2, and 1.4.4.1 on machine 1.

Git gets unhappy if you push into a branch that's checked out. It doesn't 
update the index or working directory, so the state after the push looks 
like the user reverted the patch in the working directory and updated the 
index.

It should probably give an error message and stop the push; dealing with a 
checked out version conceptually requires a merge, which push doesn't do. 
Most likely, you want a clone of the upstream repository, and a 
post-update hook in the upstream repository that goes into the clone and 
pulls the changes. (And possibly does more stuff after that)

	-Daniel
*This .sig left intentionally blank*
