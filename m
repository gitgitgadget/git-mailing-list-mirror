From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Is this an acceptable workflow in git-svn, or a user error?
Date: Sat, 9 Jun 2007 12:38:36 -0700
Message-ID: <20070609193835.GB32225@muzzle>
References: <7vy7itdjv6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 21:38:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx6lk-0007un-9p
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 21:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758900AbXFITij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 15:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758904AbXFITij
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 15:38:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42212 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758655AbXFITii (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 15:38:38 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BDF872DC032;
	Sat,  9 Jun 2007 12:38:36 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 09 Jun 2007 12:38:36 -0700
Content-Disposition: inline
In-Reply-To: <7vy7itdjv6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49607>

Junio C Hamano <gitster@pobox.com> wrote:
> Suppose you are interacting with svn://some.where/ and you want
> to have a public git://my.svn/mirror.git maintained with your
> effort for others to consume.  I am wondering if the following
> workflow, especially the push part, is kosher.
> 
> ----------------------------------------------------------------
> 0. Priming the process
> 
> $ (mkdir mirror.git && cd mirror.git && git init)
> 
> $ mkdir private.git && cd private.git && git init
> $ git svn init svn://some.where/
> $ git push ../mirror.git/ refs/heads/master:refs/heads/master
> 
> After this step, mirror.git would be in-sync with the SVN; we
> haven't done any of our own development yet.
> 
> 1. Hack away
> 
> $ edit/git-add/etc.
> $ git commit
> 
> 2. Publish the result
> 
> git push ../mirror.git/
> 
> 3. Re-sync with SVN
> 
> $ git svn dcommit
> ----------------------------------------------------------------
> 
> I suspect that the above sequence is a user error, in that
> re-syncing with SVN using git-svn (either dcommit or rebase)
> would need to redo the commits to embed SVN metadata, but the
> public mirror now has commits made with git without such
> rewriting.  In other words, I suspect that "git push" should
> never be done if you made changes on the git side since you
> sync'ed with the SVN.

Yes.  This is an unfortunate sore point for git-svn users unfamiliar
with what rebase does (inside dcommit).  Users using the the old
'set-tree' workflow are immune to this, but they have their own set of
complications...

Using "git push --force" would work after dcommit, however that
makes extra work for people tracking the git mirror

> The reason I am asking is that somebody on #git got in a very
> confusing situation.  After the Re-sync, "git push" to the
> mirror would refuse because it is not a fast forward.  "git
> fetch" from the mirror reveals that what after 3. is done, we
> see two identically-looking commits, one that was pushed (before
> re-sync with SVN) and the other (replaced because of re-sync)
> are different.
> 
> If that is the case, then I presume that the correct workflow
> would be:
> 
> 1. Hack away
> 2. Re-sync with SVN
> 3. Publish the result; do not do anything between 2. and 3.
> 
> Is my understanding correct?

Yes.  Since dcommit uses rebase, it'll rewrite history.

The "git svn dcommit" workflow is analogous to me making commits and
mailing patches to you to apply to the mainline git.git.  When you apply
them to git.git, they'll be different than the commits I've made even
though they're only metadata changes.

-- 
Eric Wong
