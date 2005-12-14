From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: git-merge fails when trying to merge from a tag
Date: Tue, 13 Dec 2005 17:00:12 -0700
Organization: Hewlett Packard
Message-ID: <20051214000012.GA13925@hpsvcnb.fc.hp.com>
References: <20051213175516.GA3695@hpsvcnb.fc.hp.com> <7vy82o951s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 01:02:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmK4B-0005gW-KR
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 01:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVLNAAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 19:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVLNAAP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 19:00:15 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:18078 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030320AbVLNAAN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 19:00:13 -0500
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel6.hp.com (Postfix) with ESMTP id 15AA2374A6;
	Tue, 13 Dec 2005 19:00:12 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id CBE0E41EC6F; Wed, 14 Dec 2005 00:00:12 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id AE90F6290; Tue, 13 Dec 2005 17:00:12 -0700 (MST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy82o951s.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13607>

On Tue, Dec 13, 2005 at 11:21:19AM -0800, Junio C Hamano wrote:
> Carl Baldwin <cnb@fc.hp.com> writes:
> 
> > I just tried to merge using a tag object.
> 
> Thanks for the report.
> 
> > % git merge "Merging release-0.3.1" HEAD refs/tags/release-0.3.1
> 
> Once I considered changing commit-tree to take any committish
> after -p, but thought the command is a low level primitive and
> the user should know what he is doing, but apparently, git-merge
> does not know what it is doing ;-).
> 
> In fact, I never use "merge" myself, and haven't noticed this
> breakage until now (you would notice that the Everyday document
> never talks about "git merge").  Instead, I always do this:
> 
> 	$ git pull . tag release-0.3.1

I've done this also.  Personally, I feel a little more in control with a
fetch, merge, tag type of flow.  Maybe its just me but I couldn't get
used to pull doing it all for me so I like to split the operation so
that I can easily run a diff-tree between the two if I want after
performing the fetch.

While we're on the subject.  It might be nice if merge behaved a little
more like pull (without the fetch of course).  At the moment, I've got
to give merge three arguments whereas pull is happy with just one of
them.

So, sometimes I would like to type this
% git merge <head>

much like one would type
% git pull . <head>

Rather than typing
% git merge "Message" HEAD <head>

But, this might not be an easy API change to make.  I suppose I could
just type 'git pull . <head>' and be satisfied but my thought process
tells be that I'm merging branches rather than pulling so I usually
don't think about it.  I'm really just typing my stream of thought at
this point so I'll wrap it up.

Thanks,
Carl

> But you are right.  It is advertised as the end-user
> command and demonstrated in the tutorial.
> 
> How about this patch?  I haven't looked at what (old)
> git-resolve and git-octopus commands do --- they may need
> similar parameter massaging.
> 
> -- >8 --
> [PATCH] allow merging any committish
> 
> Although "git-merge" is advertised as the end-user level command
> (instead of being a "git-pull" backend), it was not prepared to
> take tag objects that point at commits and barfed when fed one.
> Sanitize the input while we validate them, for which we already
> have a loop.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> diff --git a/git-merge.sh b/git-merge.sh
> index a221daa..d25ae4b 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -97,11 +97,14 @@ head=$(git-rev-parse --verify "$1"^0) ||
>  shift
>  
>  # All the rest are remote heads
> +remoteheads=
>  for remote
>  do
> -	git-rev-parse --verify "$remote"^0 >/dev/null ||
> +	remotehead=$(git-rev-parse --verify "$remote"^0) ||
>  	    die "$remote - not something we can merge"
> +	remoteheads="${remoteheads}$remotehead "
>  done
> +set x $remoteheads ; shift
>  
>  case "$#" in
>  1)
> 
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
