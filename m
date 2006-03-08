From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn, tree moves, and --no-stop-on-copy
Date: Tue, 7 Mar 2006 17:42:07 -0800
Message-ID: <20060308014207.GA31137@localdomain>
References: <20060307220837.GB27397@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 08 02:42:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGngs-0003WW-Jw
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 02:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWCHBmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 20:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbWCHBmL
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 20:42:11 -0500
Received: from hand.yhbt.net ([66.150.188.102]:46513 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751917AbWCHBmK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 20:42:10 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 32A9D2DC033;
	Tue,  7 Mar 2006 17:42:08 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  7 Mar 2006 17:42:07 -0800
To: Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <20060307220837.GB27397@nowhere.earth>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17359>

Yann Dirson <ydirson@altern.org> wrote:
> It looks that the --no-stop-on-copy flag has been dropped by error
> during the "options cleanup" commit a couple of days ago.  This
> trivial patch appears at first sight to address the problem:

Thanks for the patch, but on second thought...

I'm tempted to drop it as an option...  IIRC, the only reason
--no-stop-on-copy exists in git-svn is in case ancient versions of svn
did not support --stop-on-copy.  I haven't bothered looking deeply into
SVN history to see if it was always supported or not.
 
> Before I find out in the doc about --no-stop-on-copy, I did a coupld
> of experimentation.  Among them, was using a peg-revision in the URL
> passed to "git-svn init":
> 
> $ GIT_SVN_ID=git-oldsvn git-svn init https://svn.sourceforge.net/svnroot/ufoai/trunk/src@165
> 
> That succeeds, but then "git-svn fetch" will fail with:
> 
> svn: REPORT request failed on '/svnroot/ufoai/!svn/bc/190/trunk/src@165'
> svn: '/svnroot/ufoai/!svn/bc/190/trunk/src@165' path not found
> 256 at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 783
>         man::svn_log_raw('https://svn.sourceforge.net/svnroot/ufoai/trunk/src@165', '-r0:HEAD', '--stop-on-copy') called at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 219
>         main::fetch() called at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 81

If you want full repository history for reorganized repositories,
easiest way is to pay the price for full repository and all of its
history.

	git-svn init https://svn.sourceforge.net/svnroot/ufoai
	git-svn fetch
	# this puts all your branches and tags into one single big git tree.

However, the following should always work: (after the following patch,

	GIT_SVN_ID=git-oldsvn git-svn init \
		https://svn.sourceforge.net/svnroot/ufoai/trunk
	GIT_SVN_ID=git-oldsvn git-svn fetch -r1:165

	GIT_SVN_ID=git-newsvn git-svn init
		https://svn.sourceforge.net/svnroot/ufoai/ufoai/trunk
	GIT_SVN_ID=git-newsvn git-svn fetch \
		166=`git-rev-parse refs/remotes/git-oldsvn`

Unfortunately, it does not, at least with svn 1.2.3...  I have a patch
coming that should fix things for 1.1.1 (and give better 1.1.x support
in general).  I'm not sure, but it feels like something is screwed up
with svn 1.2.3dfsg1-3:

This works:	svn log -r1 https://svn.sourceforge.net/svnroot/ufoai/trunk

This doesn't:	svn  co -r1 https://svn.sourceforge.net/svnroot/ufoai/trunk

But this:	svn  co -r1 https://svn.sourceforge.net/svnroot/ufoai
will create the following structure:
	ufoai/{trunk,branches,tags}

I'm quite puzzled about it, as I swear I've seen it work on a different
project recently (of course I cannot remember which :<)

> Maybe git-svn could also be guarded against peg-revisions on init
> command-line, since that appears to confuse it quite a bit :)

Possibly, but having '@' in URLs is valid in some cases outside of
peg-revisions.

> Additionally, it may be worth poiting out in the doc at least one
> valid use of the --no-stop-on-copy flag that is friendly to the user's
> sanity: when the svn repository has undergone a reorg, such that the
> URL passed to "init" indeed moved - at least, when/if it is made to
> work :)

In the face of repository reorgs, git-svn is happiest tracking partial
history.  Or tracking the entire repository from the root.

Hopefully I've been reasonably coherent, having insomnia lately.

-- 
Eric Wong
