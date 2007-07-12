From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn+cygwin failed fetch
Date: Thu, 12 Jul 2007 11:27:54 -0700
Message-ID: <20070712182754.GB24854@hand.yhbt.net>
References: <f9d2a5e10707101106w305e28acy55f465e558485298@mail.gmail.com> <20070711090600.GB29676@muzzle> <f9d2a5e10707110254j46d1123fuade955f17da0a8c5@mail.gmail.com> <20070712054800.GC29676@muzzle> <f9d2a5e10707121049o758109c0l4ebeb08250093ba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93OQ-0005z2-MK
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbXGLS14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbXGLS1z
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:27:55 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40762 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbXGLS1z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:27:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 905EF2DC032;
	Thu, 12 Jul 2007 11:27:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f9d2a5e10707121049o758109c0l4ebeb08250093ba0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52312>

Russ Dill <russ.dill@gmail.com> wrote:
> On 7/11/07, Eric Wong <normalperson@yhbt.net> wrote:
> >Russ Dill <russ.dill@gmail.com> wrote:
> >> On 7/11/07, Eric Wong <normalperson@yhbt.net> wrote:
> >> >Russ Dill <russ.dill@gmail.com> wrote:
> >> >> [...]/src $ mkdir foo
> >> >> [...]/src $ cd foo
> >> >> [...]/src/foo $ git-svn init -t tags -b branches -T trunk
> >> >> https://www.[...].com/svn/foo/bar/bla
> >> >> Initialized empty Git repository in .git/
> >> >> Using higher level of URL: https://www.[...].com/svn/foo/bar/bla =>
> >> >> https://www.[...].com/svn/foo
> >> >>
> >> >> [...]/src/foo $ git-svn fetch
> >> >> config --get svn-remote.svn.url: command returned error: 1
> >> >>
> >> >> [...]/src/foo $ git config --get svn-remote.svn.url
> >> >> https://www.[...].com/svn/foo
> >> >
> >> >Sorry, I can't help here other than recommending a real UNIX with
> >> >fork + pipe + exec and all that fun stuff.
> >> >
> >> >git-svn relies heavily[1] on both input and output pipes of the
> >> >safer-but-made-for-UNIX fork + pipe + exec(@list) variety, so I suspect
> >> >this is just the tip of the iceberg for Windows incompatibilies with
> >> >git-svn...
> >>
> >> Its actually reading and writing quite a bit of stuff from the config
> >> file, so why this one simple command would fail eludes me. Especially
> >> since it wrote it there in the first place. If I comment out the
> >> command_oneline and hardcode the value I know it should return,
> >> git-fetch runs. Its actually been running for several hours now.
> >
> >Wow.  That's a pleasant surprise that anything in git-svn works at all
> >on cygwin.  I was almost certain git-svn on Windows was a hopeless cause
> >from other chatter I had heard on the mailing list.
> >
> >command_oneline() is used everywhere in that code, so I'm at a total loss
> >as to why it would fail in one place.  Can you put a the following lines
> >right before where it was failing?
> >
> >        print "GIT_CONFIG: $ENV{GIT_CONFIG} | GIT_DIR: $ENV{GIT_DIR}\n";
> >        system('cat', "$ENV{GIT_DIR}/config");
> >
> >And tell me what it outputs?
> 
> 
> Use of uninitialized value in concatenation (.) or string at
> /usr/bin/git-svn line 1189.
> GIT_CONFIG:  | GIT_DIR: .git
> [core]
>        repositoryformatversion = 0
>        filemode = true
>        bare = false
>        logallrefupdates = true
> [svn-remote "svn"]
>        url = https://www.[...].com/svn/foo
>        fetch = bar/bla/trunk:refs/remotes/trunk
>        branches = bar/bla/branches/*:refs/remotes/*
>        tags = bar/bla/tags/*:refs/remotes/tags/*
> [gui]
>        geometry = 864x678+162+162 104 204
> 
> 
> If I export GIT_CONFIG, then the problem goes away. Much better work
> around then hardcoding svn-remote.svn.url

Very strange.  I do set GIT_CONFIG internally in git-svn in a few places
and then unset it.

> The git-svn fetch died overnight due to an http error. Its restarted
> now. There are dozens of branches and tags in the repo, and each one
> seems to take about a half hour to and hour to fully fetch. It takes a
> similar amount of time to checkout trunk with tortise SVN. The repo is
> local, but I don't have direct access to it.

SVN 1.4.4 with a working do_switch() API call should be much faster.

-- 
Eric Wong
