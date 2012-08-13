From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git svn clone, a non-standard layout question
Date: Mon, 13 Aug 2012 08:31:32 +0200
Message-ID: <20120813063132.GD10899@m62s10.vlinux.de>
References: <CANW+GuQ=egge=NcdSakChYXXZkW=MsG9f3i9yNvoutXXVFcPzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Marshall <christopherlmarshall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:31:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0oBi-0004xr-3i
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 08:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab2HMGbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 02:31:37 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:60536 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751196Ab2HMGbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 02:31:36 -0400
Received: (qmail invoked by alias); 13 Aug 2012 06:31:35 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp012) with SMTP; 13 Aug 2012 08:31:35 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19fEtUbEulfblNs/rq8Gk5KgFI8GE6DXnslrBBRmI
	GyQ+N2VrKGNQSP
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 16A41D6D55; Mon, 13 Aug 2012 08:31:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CANW+GuQ=egge=NcdSakChYXXZkW=MsG9f3i9yNvoutXXVFcPzQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203327>

On Sun, Aug 12, 2012 at 11:23:16PM -0400, Christopher Marshall wrote:
> I would like to use git svn to clone an svn repo with a non-standard
> branches layout roughly like this:
> trunk/
> tags/
> branches/
>    b1
>    b2
>    ...
>    bdir/
>       b3
>       b4
>       ...
> 
> That is, every directory under branches is a branch except bdir, and
> every directory under bdir is a branch.
> 
> One thing I have attempted is this:
>    git svn clone \
>                       --trunk=trunk \
>                       --branches=branches/bdir \
>                       --branches=branches \
>                       --tags=tags \
>                       --prefix=svn/ $SVN_REPO \
>                       git.svn
> 
> That properly creates the remote tracking branches b1,b2,b3,b4 but
> also creates the remote tracking branch bdir, which I am trying to
> exclude.  If I were to settle for this, the bdir branch would have
> enormous trees committed to it (when I ran against the real svn repo I
> am targetting).
> 
> I get can exactly the branch mapping I want by editing .git/config like this:
> [svn-remote "svn"]
>         url = file:///home/chris/programs/svn/repo
>         fetch = trunk:refs/remotes/svn/trunk
>         tags = tags/*:refs/remotes/svn/tags/*
>         branches = branches/{b1,b2}:refs/remotes/svn/*
>         branches = branches/bdir/{b3,b4}:refs/remotes/svn/*
> 
> but then I would have to manually add branches before every git svn
> fetch, or risk not importing new branches that other developers have
> created since I last fetched.
> 

I had a similar problem, but I solved it using "ignore-paths" and "ignore-refs".
If I remember correctly, you need to set both to ignore bdir directly without
ignoring b3, b4,...

For ignore-refs, pls see cdb51a13c3cf4830d499d1138160eacdd2b8aa46, as it is currently
undocumented.

So I would try experimenting with the following settings:

[svn-remote "svn"]
	url = file:///home/chris/programs/svn/repo
	fetch = trunk:refs/remotes/svn/trunk
	tags = tags/*:refs/remotes/svn/tags/*
	branches = branches/{b1,b2}:refs/remotes/svn/*
	branches = branches/bdir/{b3,b4}:refs/remotes/svn/*

	# Operates on the imported git branches
	ignore-refs  = ^refs/remotes/bdir$

	# Operates on the SVN branches; you might try it first without this statement
	ignore-paths = ^branches/bdir$
