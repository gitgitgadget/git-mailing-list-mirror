From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: git svn dcommit doesn't handle network failure
Date: Fri, 8 Jan 2010 18:13:47 -0800
Message-ID: <20100109021347.GA26520@dcvr.yhbt.net>
References: <20091122112434.29914.59452.reportbug@localhost.localdomain> <20100109010058.GA11922@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brice Goglin <bgoglin@debian.org>,
	557477-forwarded@bugs.debian.org, 557477@bugs.debian.org,
	git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>,
	Pedro Melo <melo@simplicidade.org>, Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 03:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTQpv-0006Ld-Ci
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 03:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0AICNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 21:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274Ab0AICNt
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 21:13:49 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48506 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab0AICNs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 21:13:48 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB451F503;
	Sat,  9 Jan 2010 02:13:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100109010058.GA11922@progeny.tock>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136510>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Eric,
> 
> 'git svn dcommit' does not seem to have any error recovery built in,
> so the user is put in a not-great situation if the network cable is
> pulled in the middle, as in the report below.
> 
> See also <http://thread.gmane.org/gmane.comp.version-control.git/70458>
> 
> Ideally, it would be nice if users could pretend that each push of
> a single commit is an atomic operation that rewrites the corresponding
> local commit at the same time.  In other words, to clean up we might
> unapply the unpushed patch, then run rebase_cmd().
> 
> What do you think?

Hi Jonathan,

I agree that error recovery for dcommit sucks right now.

I think Brice's idea (creating a temporary branch to dcommit from)
is easier to implement and less likely to break than automatically
unapplying patches.

Not sure when I'll have time to implement this, but I'll accept
patches in the mean time.

> Brice Goglin wrote:
> 
> > Package: git-svn
> > Version: 1:1.6.5-1
> > Severity: important
> > 
> > Hello,
> > 
> > If the network fails during dcommit, git svn gets totally screwed up.
> > It will give you the prompt back with HEAD pointing to the last SVN-pushed
> > commit, and the next one applied and not git-committed.
> > 
> > $ git svn dcommit
> > Committing to svn+ssh://bgoglin@scm.gforge.inria.fr/svn/knem/branches/rma ...
> > 	M	common/knem_io.h
> > Committed r237
> > 	M	common/knem_io.h
> > r237 = f839e16b94052f8b71aa4b66124b37a8337182e0 (refs/remotes/rma)
> > No changes between current HEAD and refs/remotes/rma
> > Resetting to the latest refs/remotes/rma
> > Unstaged changes after reset:
> > M	common/knem_io.h
> > M	driver/linux/knem_main.c
> > ssh: connect to host scm.gforge.inria.fr port 22: Connection timed out
> > Use of uninitialized value in concatenation (.) or string at /usr/lib/perl5/SVN/Core.pm line 584.
> > Network connection closed unexpectedly:  at /usr/lib/git-core/git-svn line 557
> > 
> > 
> > Now the only way I found to solve this mess is to git-reset --hard,
> > git checkout the old HEAD again, and git svn dcommit the remaining stuff.
> > 
> > The big problem is that I don't see any easy way to find the old HEAD.
> > I had to look back in my terminal history in case there's still the output
> > of a git log showing the old HEAD commitid.
> > 
> > I don't know how dcommit works internally, but my feeling is that it
> > should go to a new temporary branch during dcommit. This way, we would
> > just have to checkout the non-temporary branch on failure. For now,
> > I do it manually in case the SVN server fails again, but that's really
> > annoying.
> > 
> > thanks,
> > Brice
> --
