From: Jeff King <peff@peff.net>
Subject: Re: Issue updating files during a checkout from a remote push
Date: Fri, 7 Nov 2008 16:56:55 -0500
Message-ID: <20081107215655.GA20126@coredump.intra.peff.net>
References: <334B3AB1-125A-4163-BEBC-9A73C4F569B5@idibu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steve Walker <steve@idibu.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 22:58:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZLQ-0004e5-2u
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 22:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYKGV47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 16:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYKGV46
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 16:56:58 -0500
Received: from peff.net ([208.65.91.99]:4395 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbYKGV46 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 16:56:58 -0500
Received: (qmail 2567 invoked by uid 111); 7 Nov 2008 21:56:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Nov 2008 16:56:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2008 16:56:55 -0500
Content-Disposition: inline
In-Reply-To: <334B3AB1-125A-4163-BEBC-9A73C4F569B5@idibu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100336>

On Thu, Nov 06, 2008 at 06:04:20PM +0100, Steve Walker wrote:

> The overall issue is that with files that have been pushed into our repo 
> on our server, when we then check out into local working copy the new 
> files appear, but the updated files dont update even though the output 
> suggests it has. The flow I'm doing:

The short answer is: don't push into the current branch of a non-bare
repo.

> 2. On my local box I change file, add it, commit, then push it from my  
> local box to our server repo:

OK, so this updates the HEAD of the receiving repository. But the index
and working tree are untouched.

> 3. It all looks good, on my server if i do a 'git log' I can see in the 
> latest update:

Right, because the HEAD has been updated.

> 4. So I check out:
>
> oneworld:/home/beta_idibu/public_html# git checkout master
> M	.gitignore
> M	steve-git-test.txt
> M	steve-git-test2.txt
> M	steve-git-test3.txt
> Already on branch "master"
> oneworld:/home/beta_idibu/public_html#

But you were already _on_ master, so git shouldn't need to touch the
index and working tree. But the contents of master have changed out from
under you, so it looks like you have modifications.

So generally you don't want to push to the current branch, but there is
no safety valve disallowing it (and I will post a patch series in a
minute which introduces one). In the past, people have suggested doing a
merge with the working tree, but that is not desirable for two reasons:

  1. you are changing the working tree out from under whoever's repo you
     push into

  2. the merge might not be clean, in which case the user needs to
     resolve conflicts. But the user isn't even doing stuff in the
     now-conflicted repository. So the suggested workflow is instead to
     go to that repo and do a 'pull'

So depending on what you want to accomplish, there are a number of
alternative workflows:

 - if you just want to publish refs, you can use a bare repo without a
   working tree at all (git --bare init, or git clone --bare).

 - if you just want to throw away working tree changes on a push (e.g.,
   you are pushing to a production server whose working tree is kept up
   to date), you can do that automatically with a post-receive hook. But
   it will never be the default, because we don't want to throw anything
   away unless the user has explicitly told us to do so.

 - if you are working in repos A and B, and you want to get changes from
   B to A, then you would generally go to A and "git pull B". But
   sometimes that is not possible (e.g., you can only make network
   connections one way). In that case, you can push to a "remote" branch
   on A, and then merge from there when you're at A. E.g.,:

     /repo/B$ git push /repo/A master:refs/remotes/B/master
     /repo/B$ cd /repo/A
     /repo/A$ git merge B/master

-Peff
