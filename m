From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 4/5] Log ref updates made by fetch.
Date: Fri, 19 May 2006 04:03:14 -0400
Message-ID: <20060519080314.GG22257@spearce.org>
References: <20060519072926.GE22257@spearce.org> <7vodxuih2d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 10:03:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzxN-0003U5-BT
	for gcvg-git@gmane.org; Fri, 19 May 2006 10:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWESIDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 04:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWESIDT
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 04:03:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:6086 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932125AbWESIDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 04:03:18 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fgzx4-0003kc-Lm; Fri, 19 May 2006 04:03:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 04264212691; Fri, 19 May 2006 04:03:14 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodxuih2d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20336>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > diff --git a/refs.c b/refs.c
> > index 31cf276..d3ddc82 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -142,6 +142,8 @@ static int do_for_each_ref(const char *b
> >  			namelen = strlen(de->d_name);
> >  			if (namelen > 255)
> >  				continue;
> > +			if (namelen>5 && !strcmp(de->d_name+namelen-5,".lock"))
> > +				continue;
> >  			memcpy(path + baselen, de->d_name, namelen+1);
> >  			if (stat(git_path("%s", path), &st) < 0)
> >  				continue;
> 
> Now this got me worried.  Until now I did not realize that we
> are clobbering refnames that ends with ".lock" if another ref
> with the name without ".locK" is updated.  Because we do not
> forbid a name that ends with ".lock" to be used as a refname,
> this is an accident waiting to happen.
> 
> Not your fault, though.  It was like this ever since the initial
> version of refs.c was accepted by Linus.
> 
> We could do one of two things: officially forbid any refname
> that ends with ".lock", or fix the lockfile naming convention.
> 
> Nobody should be relying on what the actual lockfile-to-be-
> renamed-to-become-the-real-file is called.  I suspect we would
> want to fix refs.c::ref_lock_file_name() to use a name that
> would never be used as a refname.
> 
> We could make it begin with ".", so the lock file for the master
> ".git/refs/heads/master" would become ".git/refs/heads/.master",
> for example.  That way, we cannot clobber a valid unrelated ref
> (".master" is not a valid ref name), and as an added bonus, you
> do not even have to have the above hunk.

Not a bad idea.  I found this bug because fetch.c was trying to
work on the bob.lock while it was fetching "heads/bob".  Which
didn't make sense to me, so I put this skip thing in...

I'd want to get all of the "lockers" move to using the common
lock code before changing the lock name to ".master" (for example)
but yes that's a good idea.

-- 
Shawn.
