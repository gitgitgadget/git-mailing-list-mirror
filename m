From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn of both trunk and tags while having no access to the
	'parent' of those
Date: Thu, 19 Nov 2009 01:53:07 -0800
Message-ID: <20091119095307.GA30423@dcvr.yhbt.net>
References: <20091117025945.GE17964@onerussian.com> <4B03B7D3.8050905@drmicha.warpmail.net> <20091118133205.GB17964@onerussian.com> <4B03FD29.3090001@drmicha.warpmail.net> <20091118142332.GC17964@onerussian.com> <4B040D95.9040901@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 19 10:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB3hT-0001HC-J3
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 10:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbZKSJxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 04:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753055AbZKSJxD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 04:53:03 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34580 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbZKSJxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 04:53:01 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672301F606;
	Thu, 19 Nov 2009 09:53:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B040D95.9040901@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133221>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Yaroslav Halchenko venit, vidit, dixit 18.11.2009 15:23:
> > 
> > On Wed, 18 Nov 2009, Michael J Gruber wrote:
> >>> git svn clone --no-minimize-url --prefix=upstream-svn/ -T trunk -t releases  http://domain.com/svnrepo/trunk svnrepo.gitsvn
> >> Is the trunk really at svnrepo/trunk/trunk?
> > nope... it is just svnrepo/trunk but if I set url to point to parent --
> > git svn seeks authentication right away
> > 
> >> I would try both
> >> git svn clone --no-minimize-url --prefix=upstream-svn/ -T trunk -t
> >> releases  http://domain.com/svnrepo/ svnrepo.gitsvn
> > 
> > asks for authentication since there is no public access to
> > http://domain.com/svnrepo/
> > 
> >> and also the seemingly equivalent
> > 
> >> git svn clone --no-minimize-url --prefix=upstream-svn/ -T
> >> http://domain.com/svnrepo/trunk -t http://domain.com/svnrepo/releases
> >> svnrepo.gitsvn
> > seems to not work since it wants url as a parameter 
> > 
> > Bad URL passed to RA layer: Illegal repository URL svnrepo.gitsvn  at /usr/lib/git-core/git-svn line 940

Hi Michael, Yaroslav,

I think that second command syntax only works for "git svn init" right
now, not sure if it ever worked with "clone".

> >> Also, I assume you can svn list http://domain.com/svnrepo/trunk and
> >> http://domain.com/svnrepo/releases ;)
> > yeap -- I can list both of those but not their parent.
> > 
> 
> OK, so the way it's implemented --no-minimize-url might be half as
> useful as it could be. One last try (before asking Eric...) would be
> 
> git svn clone --no-minimize-url --prefix=upstream-svn/ -T
> http://domain.com/svnrepo/trunk -t http://domain.com/svnrepo/releases
> http://domain.com/svnrepo/trunk svnrepo.gitsvn
> 
> because that involves accessible URLs only and trunk and branch URLs are
> absolute.
> 
> [Meanwhile I git the actual URL PMed by Yaroslov.]

Any chance I could get that URL?  (I probably won't get a chance to
spend time debugging this until Friday).  Might be worth it to get an
strace or tcpdump to see what exactly is going on.  Or at least some
print statements around Git::SVN::Ra::new()...

> So, what happens with the above is that git-svn tries to set the URL
> config again from the URL part of an absolute tags argument. I don't
> know how absolute URLs (which are documented) for tags etc. could
> possibly work if git-svn tries to do that. Eric?

It looks like support for specifying absolute URLs with "clone"
has been broken for a while.  Guess I'll need test cases...

> I tried also with two svn sections to circumvent this:
> 
> [svn-remote "svn"]
>         url = http://domain.com:/project/trunk
>         fetch = :refs/remotes/trunk
> [svn-remote "svnr"]
>         url = http://domain.com:/project/releases
>         tags = /*:refs/remotes/tags/*
> 
> Fetching -Rsvn works fine, but fetching -Rsvnr gives the same
> authentication problems. And fetch does not accept --no-minimize-url as
> an option. OTOH: If the option is not used it seems to me (from the
> source) that not minimizing is the default, which leaves me really
> stomped. Eric?? ;)

Odd that the svnr one doesn't work.  Does changing:
         tags = /*:refs/remotes/tags/*
to:
         tags = *:refs/remotes/tags/*
help at all?

Minimizing should be the default in 1.6.5.  I'm a bit stumped, too :x
I'd like to see what network traffic git svn is sending for
the "svnr" case vs "svn ls http://domain.com/project/releases"

-- 
Eric Wong
