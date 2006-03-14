From: Qingning Huo <qhuo@mayhq.co.uk>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Tue, 14 Mar 2006 22:40:27 +0000
Message-ID: <20060314224027.GB14733@localhost.localdomain>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Mar 14 23:49:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJIKR-00024h-Q1
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 23:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbWCNWtU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 17:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbWCNWtU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 17:49:20 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:37604 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1752042AbWCNWtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 17:49:19 -0500
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060314224917.MDAY1118.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Tue, 14 Mar 2006 22:49:17 +0000
Received: from rabbit.zoo.mayhq.org ([80.0.127.16])
          by aamtaout02-winn.ispmail.ntl.com with SMTP
          id <20060314224917.XUJQ28606.aamtaout02-winn.ispmail.ntl.com@rabbit.zoo.mayhq.org>
          for <git@vger.kernel.org>; Tue, 14 Mar 2006 22:49:17 +0000
Received: (qmail 15050 invoked by uid 1000); 14 Mar 2006 22:49:23 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17601>

On Tue, Mar 14, 2006 at 01:58:09PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 14 Mar 2006, Qingning Huo wrote:
> >
> > The system have GNU git installed at /usr/bin/git.  I installed git-core
> > to ~/opt/bin.  ~/opt/bin is in my PATH, but is after /usr/bin.  I have
> > set alias git="$HOME/opt/bin/git".
> 
> This should not be a problem with the modern "git.c" wrapper. It 
> _should_, if you call it with the full path, automatically prepend that 
> path to the PATH when executing sub-commands. 
> 
> So if you run git as "$HOME/opt/bin/git", the PATH _should_ be 
>  - first the "PREFIX/bin" path as defined by the build
>  - second the "$HOME/opt/bin/" path as defined by the fact that you ran 
>    git from that path
>  - finally the normal $PATH.
> 
> To check this out, do this:
> 
> 	ln -s /usr/bin/printenv ~/opt/bin/git-printenv
> 	git printenv
> 
> and you should see the proper PATH that git ends up using internally that 
> way.
> 
> So your problem seems to be that you do "git-pull", when you really should 
> do "git pull" (where that wrapper will set up PATH for you). Since you 
> don't use the wrapper, the scripts end up doing the wrong thing.
> 

Thanks for your detailed explanation.  Yes, "git push" and "git pull"
both work fine out of the box.  That is the good thing.  But,

$ grep git git-pull.sh

. git-sh-setup
orig_head=$(git-rev-parse --verify HEAD) || die "Pulling into a black hole?"
git-fetch --update-head-ok "$@" || exit 1
curr_head=$(git-rev-parse --verify HEAD)
        git-read-tree -u -m "$orig_head" "$curr_head" ||
        var=`git repo-config --get pull.octopus`
        var=`git repo-config --get pull.twohead`
merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
git-merge $no_summary $no_commit $strategy_args "$merge_name" HEAD $merge_head

We have "git-read-tree" and "git repo-config" at the same time.  Are
there any rules saying which form should be preferred?  How about pick
one form and stick to it?

If we uniformly call git helper programs/scripts with "git helper"
style, would git(1) append two paths to PATH everytime it is being
invoked?  For example, "git pull" -> "git repo-config" would prepend
~/opt/bin four times to PATH.  This wouldn't be very effecient.

Regards,
Qingning
