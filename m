From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/5] Correct handling of branch.$name.merge in builtin-fetch
Date: Tue, 18 Sep 2007 11:05:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709181034300.5298@iabervon.org>
References: <20070918085453.GC5390@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXee7-0003Pv-OM
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 17:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbXIRPFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758939AbXIRPFr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 11:05:47 -0400
Received: from iabervon.org ([66.92.72.58]:60543 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbXIRPFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 11:05:46 -0400
Received: (qmail 26103 invoked by uid 1000); 18 Sep 2007 15:05:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Sep 2007 15:05:37 -0000
In-Reply-To: <20070918085453.GC5390@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58617>

On Tue, 18 Sep 2007, Shawn O. Pearce wrote:

> My prior bug fix for git-push titled "Don't configure remote "." to
> fetch everything to itself" actually broke t5520 as we were unable
> to evaluate a branch configuration of:
> 
>   [branch "copy"]
>     remote = .
>     merge = refs/heads/master
> 
> as remote "." did not have a "remote...fetch" configuration entry to
> offer up refs/heads/master as a possible candidate available to be
> fetched and merged.  In shell script git-fetch and prior to the above
> mentioned commit this was hardcoded for a url of "." to be the set of
> local branches.

Ah, right. When you removed that, I remembered there being some reason I'd 
put it in, but I couldn't remember what it was, and knew you'd turn it up 
before I would.

> Chasing down this bug led me to the conclusion that our prior behavior
> with regards to branch.$name.merge was incorrect.  In the shell script
> based git-fetch implementation we only fetched and merged a branch if
> it appeared both in branch.$name.merge *and* in remote.$r.fetch, where
> $r = branch.$name.remote.  In other words in the following config file:
> 
>   [remote "origin"]
>     url = git://git.kernel.org/pub/scm/git/git.git
>     fetch = refs/heads/master:refs/remotes/origin/master
>   [branch "master"]
>     remote = origin
>     merge = refs/heads/master
>   [branch "pu"]
>     remote = origin
>     merge = refs/heads/pu
> 
> Attempting to run `git pull` while on branch "pu" would always give
> the user "Already up-to-date" as git-fetch did not fetch pu and thus
> did not mark it for merge in .git/FETCH_HEAD.  The configured merge
> would always be ignored and the user would be left scratching her
> confused head wondering why merge did not work on "pu" but worked
> fine on "master".
> 
> If we are using the "default fetch" specification for the current
> branch and the current branch has a branch.$name.merge configured
> we now union it with the list of refs in remote.$r.fetch.  This
> way the above configuration does what the user expects it to do,
> which is to fetch only "master" by default but when on "pu" to
> fetch both "master" and "pu".

And store master, but don't store pu. This looks like the right solution 
to me.

> This uncovered some breakage in the test suite where old-style Cogito
> branches (.git/branches/$r) did not fetch the branches listed in
> .git/config for merging and thus did not actually merge them if the
> user tried to use `git pull` on that branch.  Junio and I discussed
> it on list and felt that the union approach here makes more sense to
> DWIM for the end-user than silently ignoring their configured request
> so the test vectors for t5515 have been updated to include for-merge
> lines in .git/FETCH_HEAD where they have been configured for-merge
> in .git/config.

Ah, okay. This is one of the things I'd changed, to make it obey the merge 
configuration (which meant that it didn't get anything to merge), which 
had previously been ignored. So there's nothing that's expecting exactly 
the behavior that you're changing away from, except for that test case.

This whole series looks good to me.

	-Daniel
*This .sig left intentionally blank*
