From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 16:58:13 +0200
Message-ID: <4720AF05.3050308@op5.se>
References: <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 25 16:58:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il4AL-0005ly-Lx
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 16:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591AbXJYO6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757494AbXJYO6T
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 10:58:19 -0400
Received: from mail.op5.se ([193.201.96.20]:60898 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757033AbXJYO6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 10:58:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4E9BC1730713;
	Thu, 25 Oct 2007 16:58:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n-LL2qTNPXH8; Thu, 25 Oct 2007 16:58:56 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 738F2173070F;
	Thu, 25 Oct 2007 16:58:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071025132401.GA22103@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62323>

Theodore Tso wrote:
> On Thu, Oct 25, 2007 at 12:33:09PM +0200, Andreas Ericsson wrote:
>> Because it's convenient, ofcourse. Don't you have 'maint', 'next'
>> and 'master' in your clone of git.git? I'm guessing at least 99% of
>> the people on this list have those branches lying around in their
>> clones, even if they only ever use 'next' and/or 'master'.
> 
> I find it just as easy to say: "git checkout origin/maint" or "git
> checkout origin/next" when I want to examine some other branch.
> 
> If I want to make a change against maint, then I follow up "git
> checkout origin/maint" with a "git checkout -b <topic-name>".  Part of

Except that <topic-name> in this case will always be maint, since
only small bugfixes go on that branch. We tried using different-named
branches earlier, but the "git push <local-branch>" behaviour was
much too common, and we ended up with far too many randomly named
branches on the mothership repository.

> 
> You're using a diferent workflow, and with users who aren't interested
> in learning the fine points of git.  But main issue is that git isn't
> optimized for what you want to do.

Correct. I'm working on optimizing it right now though :)

>  So I can suggest a couple of
> different approaches.  One is to simply do things the 'hg' way.
> Explicitly set up different repos for the different branches.  It's
> more inefficient, but it does work.

That makes diffing harder to do, and for those few long-living topics
that get pushed to mothership, there's no logical way for the user to
get only that branch. With the *:refs/remotes/foo/* config thing, this
works seemlessly today.

> 
> Another would be to set up a wrapper script for "git-clone" that
> creates a separate local working directory for each branch.  So for
> example, it might do something like this:
> 
> #!/bin/sh
> # Usage: get-repo <URL> [dir]
> URL=$1
> dir=$2
> branches=`git-ls-remote --heads $URL | sed -e 's;.*/;;'`
> if [ "$dir"x = "x" ]; then dir=`basename $URL`; fi
> git clone $URL .temp-repo
> mkdir $dir
> cd $dir
> for i in $branches; do
>     mkdir $i
>     cd $i
>     git init
>     git remote add -t $i origin $URL
>     echo ref: refs/heads/$i > .git/HEAD
>     git fetch ../../.temp-repo refs/remotes/origin/$i:refs/remotes/origin/$i
>     # do it a second time to get the tags (bug in fetch?)
>     git fetch ../../.temp-repo refs/remotes/origin/$i:refs/remotes/origin/$i
>     git merge origin/$i
>     git config remote.origin.push $i:$i
>     cd ..
> done
> cd ..
> rm -rf .temp-repo
> 
> For bonus points, this script could be made smarter so that each of
> the branches shared a common git object database, and some error
> checking would be nice, but hopefully this gets the basic idea across.
> 
> This way, the "basic git users" get a separate working directory for
> each branch, where "git pull" updates that particular branch, and "git
> push" updates changes to the remote branch.  
> 
> Does this do what you want?
> 

Not really, I'm afraid. Apart from missing out on the auto-download of
new repos you get with "fetch = refs/heads/*:refs/remotes/origin/*",
it seems inelegant.

> 							- Ted
> 
> P.S.  Note by the way that if you are having everyone own access to
> push into a single central repository, having a "next" branch probably
> doesn't make seense.  You're probably way better off just simply
> having "master" (which would be your devel branch), and "maint" for
> bug fixes.
> 

We have
maint = maintenance code. some repos have several maint-branches
master = integration-tested code that will end up in next release
testing = unit-tested features, ready for integration testing

We can't really do without them, but perhaps I can do what Dscho
suggested in another email and force everyone to delete their
locally-modifiable branches once they're done making changes to
them. It'll end up being more commands to run for a single fix,
but at least it's not error-prone.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
