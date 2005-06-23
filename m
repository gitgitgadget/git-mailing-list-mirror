From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 20:36:03 +1200
Message-ID: <46a038f905062301363c3c1ea8@mail.gmail.com>
References: <1119284365.3926.15.camel@localhost.localdomain>
	 <7vbr61j631.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 11:08:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlNgl-0004Sd-12
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 11:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVFWIs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 04:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVFWImi
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 04:42:38 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:41378 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263065AbVFWIgD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 04:36:03 -0400
Received: by rproxy.gmail.com with SMTP id i8so223880rne
        for <git@vger.kernel.org>; Thu, 23 Jun 2005 01:36:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QdCQAZ20qV7idOywXb63ldgrZMMjVmChJKdqC7YUPAeMSGUn7wkDjnSKMXNOfsbOt1ngCwRckxB47JcHNtspfbjKbOyNWMA/9LkOLJRwoFNZZH6iuiHe6roAuo+ZZ8nQQ8Ue+Dh33Kpyx8HTyKf62HA2XDuK72r0qCR3TSz4H1g=
Received: by 10.38.65.51 with SMTP id n51mr737495rna;
        Thu, 23 Jun 2005 01:36:03 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Thu, 23 Jun 2005 01:36:03 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/22/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Btw, I'd like to help automate the 6-7 stage with a different kind of
> merge logic.
(...)
>  - get the different HEAD info set up, and save the original head in
>    ORIG_HEAD, the way "git resolve" does for real merges:
> 
>         : ${GIT_DIR=.git}
> 
>         orig=$(git-rev-parse HEAD)
>         new=$(git-rev-parse FETCH_HEAD)
>         common=$(git-merge-base $orig $new)
> 
>         echo $orig > $GIT_DIR/ORIG_HEAD
> 
>  - fast-forward to the new HEAD. We'll want to re-base everything off
>    that. If that fails, exit out - we've got dirty state
> 
>         git-read-tree -m -u $orig $new && exit 1
> 
>  - for each commit that we had in our old tree but not in the common part,
>    try to re-base it:
> 
>         > FAILED_TO_CHERRYPICK
>         for i in $(git-rev-list $orig ^$common)
>         do
>                 git-cherry-pick $i ||
>                         (echo $i >> FAILED_TO_CHERRYPICK)
>         done
>         if [ -s FAILED_TO_CHERRYPICK ]; then
>                 echo Some commits could not be cherry-picked, check by hand:
>                 cat FAILED_TO_CHERRYPICK
>         fi

Re-base and replay local history is an approach I've been using
successfully with Arch (though it takes literally ages). Ideally, the
process should be able to be restarted after one call to
git-cherry-pick fails. It is usually a handful of patches in a series
of a few hundred that will break, usually because it's been fed
upstream. You want to resolve the conflict and resume somehow.

> and here the "git-cherry-pick" thing is just a script that basically takes
> an old commit ID, and tries to re-apply it as a patch (with author data
> and commit messages, of course) on top of the current head. It would
> basically be nothing more than a "git-diff-tree $1" followed by tryign to
> figure out whether it had already been applied or whether it can be
> applied now.
> 
> What do you think?

Sounds great. 

It might be useful to provide it a "skip" list, so that it skips
applying selected patches (that have presumably made it upstream).

And perhaps --stop-at <commit-sha> so that if a large replay fails or
yields a broken tree (not at the git level, but at the /does it
compile and run/ level), I can throw away the temporary repo where I'm
working and try again in shorter batches, stopping at "strategical"
points.

cheers,


martin
