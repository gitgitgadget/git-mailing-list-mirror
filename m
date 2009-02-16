From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 01:30:05 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0902160103090.7597@reaper.quantumfyre.co.uk>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 02:33:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYsMV-0002pu-68
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 02:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbZBPBcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 20:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863AbZBPBcD
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 20:32:03 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33396 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754440AbZBPBcB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 20:32:01 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 715881213FF
	for <git@vger.kernel.org>; Mon, 16 Feb 2009 01:31:59 +0000 (GMT)
Received: (qmail 20225 invoked by uid 103); 16 Feb 2009 01:30:05 +0000
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/8992. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.041591 secs); 16 Feb 2009 01:30:05 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Feb 2009 01:30:05 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110109>

On Sun, 15 Feb 2009, david@lang.hm wrote:

> as I think about this more I'm puzzled as to why this is an issue.

I think that you have a slightly misunderstanding of what fetch is usually 
configured to do.

> I see mentions of it messing up the index and causing users to loose data, 
> but how is it different to push into a repository that has a workdir (with or 
> without dirty state in the workdir or in the index) and doing a fetch into 
> that repository.
>
> in both cases the new commits are added to the repository and the commit 
> pointed to by the branch changes, but if you do the fetch your HEAD and the 
> contents of the workdir and index aren't touched, why should a push do 
> something different?

This isn't the case.  A fetch will only update the refs that refer to 
the state of the remote repository.  It will not update any of your local refs 
(unless you have a mirror setup - in which case a fetch is just as bad as 
a push).

Say we have two repositories, and local is cloned from remote:

remote# git branch
* master
   foo

local# git branch   #what branches do we have to work on?
* master
   foo

local# git branch -r  #what branches do our remotes have?
   remote/master
   remote/foo

If we have updates on the master branch at remote, then "git fetch remote" 
on local will update "remote/master", but will not affect "master" - the 
currently checked out branch.  To update "master" we then have to either 
merge "remote/master" (pull) or rebase "master" onto the new head of 
"remote/master" (pull --rebase).

However, if we have updates on the master branch at local, then "git push 
remote master" will update "master" on the remote repository - the checked 
out branch.  At which point the user has to know what they are doing, or 
risk confusion and lost work, as any commit made on the remote branch will 
not take account of the changes made by the pushed commits unless care is 
taken to update the wordir first (and it doesn't make any difference if 
you didn't have dirty state before the push).

> I believe that if you fetch into a repository and someone else fetches from 
> you, they will get the content that's newer that what's in your dirty 
> workdir/index (I haven't tried it, but my understanding of the git internals 
> lead me to expect this to be the behavior)

Unless they are also pulling your remote tracking branches (which is not 
the default behaviour, and is a rather odd thing to do), then your fetch 
will not change what they get from you as they only get your local 
branches.

> a pull would try to update the index, HEAD, and workdir, but I've seen many 
> discussions about how push and pull are not symetrical, but push and fetch 
> are (along with the moaning about bad names for the commands and the 
> historical explination of how they got that way)

They are symetrical in operation, but not in destination.  Basically, the 
assumption is that when fetching the user is on that machine and will 
incorporate the updates themselves either using pull, or in a more manual 
way.  With push, the assumption is that there is no user on the remote 
machine only a lonely old server process, and that the changes should be 
immediately made available to anyone accessing the repository.

> If there is some reason for the normal push to try and update the HEAD, 
> index, and workdir. instead of refusing the push, how about having it put the 
> commits in the repository and then fail to change the HEAD, index, and 
> workdir if any of them contain changes? (along with a warning that it's doing 
> so).
>
> this should be safe to do because it will only flag on the particular 
> combination of events that will cause data loss rather than the broader 
> prohibition of "don't push if there is a workdir" that affects legitimate 
> uses as well
>
> David Lang
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Julian

  ---
Q: Does Bill Gates use public domain software?
A: Yes, as all of the public has become Bill Gates' domain.
