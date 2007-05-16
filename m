From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: pull/push inconsistencies
Date: Wed, 16 May 2007 13:11:02 +1200
Message-ID: <46a038f90705151811o2159aa5ai84a13e77e790e376@mail.gmail.com>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
	 <7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 03:11:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho82n-00017K-BM
	for gcvg-git@gmane.org; Wed, 16 May 2007 03:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164AbXEPBLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 21:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759675AbXEPBLF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 21:11:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:6255 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbXEPBLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 21:11:03 -0400
Received: by wr-out-0506.google.com with SMTP id 76so14028wra
        for <git@vger.kernel.org>; Tue, 15 May 2007 18:11:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dKtq/x9GEkPi8C5kfKZ/6MgcmJgjpE29HDTEMD+6Gb8i4kny7okpab3QXvi/2Kfg4NrQpJzxujjWyrOHY2w0ZHopbMoeD9lHPl/NSYcQj1KrSSAc7CvqnJylGMpzF646vUqQ24d86S4i5Bo8OszBfAZL3tLUjIx9kt0OQktn1HU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SCH/Xbro+o1G7RylLbd/cweXC753l4JjkaiAQKK2l3S27kh1PqayubWdF2x9P2k7Xg7dhpkcwrtEfeFUbBgq27y+Lywh3YUxDulo33u/lOGgTKSIpfD0GWLia1eswB/n2DDuGQjSfKtinE9IPgHyrYN0S2lhGiIhV2RQ+dgxcQ8=
Received: by 10.90.116.6 with SMTP id o6mr7206003agc.1179277862720;
        Tue, 15 May 2007 18:11:02 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Tue, 15 May 2007 18:11:02 -0700 (PDT)
In-Reply-To: <7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47402>

On 5/16/07, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> > When tracking several branches from a repo, git-pull does a fetch (of
> > all the remote heads) and merges _only the tracking branch currently
> > checked out_. That's ok. However, if I checkout another tracking
> > branch and issue git-pull, the merge does not happen because git-fetch
> > finds nothing new on the remote side. git-pull should merge anyway if
> > remotes/origin/<trackinghead> is ahead of the local head.
>
> That's my expectation and I am a bit surprised if it doesn't.

I'll try get a repro script then.

> > My second issue is that git-push does not update
> > remotes/<repo>/<headname> so if I do git-push && gitk --all it looks
> > as if I haven't pushed. Misleading again. :-/
>
> The standard answer is not to push into a live repository
> without understanding what you are doing.

I don't quite understand that statement. I think I know what I am
doing: telling git-push to push new commits from matching local refs
to remote refs safely (only ff, unless there's a + in the
configuration for that head).

Why can't git match that the remote is the remote in .git/refs/remotes
and put the right data SHA1 in .git/refs/remotes/<headname>?

...

> And pushing into live repository using 'matching refs' is almost
> always a mistake, unless the user knows what he is doing.

Hey - I'm only using it because you've recommended it as a migration
path! ;-) Combined with tracking branches, it works great.

> > Third issue - if I do
> >
> >  # we start with a cloned repo that is in sync with
> >  # its "origin" repo. No local commits to speak of...
> >  # git-fetch brings updates to 3 remote branches - none affecting the current
> >  # checked out branch...
> >   git-fetch
> >   git-commit some/path
> >   git-push
> >
> > the output of git-push will show _4_ branches being pushed. For some
> > reason git-push says that it's pushing remotes/origin/branchname ->
> > origin/branchname for all the branches fetched recently -- and not
> > modified! I expect only _1_ branch to be named during push - the only
> > one.
>
> git-push without parameters and configuration pushes matching
> branches.  This has been true from day one.  Again, I think we
> should be able to make this safer so that "git-push" in cloned
> repository would do something more restricted (perhaps limiting
> to refs/heads?), but I do not think of a universally acceptable
> canned configuration.

There are 2 things that I see as wrong...
 - local .git/refs/remote/origin/foo and refs/heads/foo match - why is
git-push talking about updating them?
 - matching refs should ignore .git/refs/remote

But perhaps I'm naive in thinking that the 'matching refs' thing will
ignore the local .git/refs/remotes directory. AFAICS it's the only
sane thing to do.

cheers,


martin
