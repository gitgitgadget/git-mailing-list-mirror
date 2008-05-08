From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking
	branches
Date: Thu, 8 May 2008 04:21:41 -0400
Message-ID: <20080508082141.GB2197@pe.Belkin>
References: <20080508013956.GA24956@midwinter.com> <alpine.DEB.1.00.0805072332300.6948@swallowtail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Thu May 08 10:22:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju1Oc-0002k1-KZ
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 10:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbYEHIVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 04:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbYEHIVp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 04:21:45 -0400
Received: from eastrmmtao103.cox.net ([68.230.240.9]:49012 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbYEHIVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 04:21:43 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20080508082143.CTBF24465.eastrmmtao103.cox.net@eastrmimpo02.cox.net>;
          Thu, 8 May 2008 04:21:43 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id NwMh1Z00D0epFYL02wMhoA; Thu, 08 May 2008 04:21:42 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1Ju1Nl-0000gj-KX; Thu, 08 May 2008 04:21:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805072332300.6948@swallowtail>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81518>

On Wed, May 07, 2008 at 11:48:17PM -0700, Asheesh Laroia wrote:
> On Wed, 7 May 2008, Steven Grimm wrote:
>
>> In environments where a lot of people are sharing an svn repository using
>> git-svn, everyone has identical, but individually maintained, tracking
>> branches.
>
> To further muddy the waters, let me talk about my setup, also one with a 
> "central git repository" from which all developers clone, and also one 
> based on a Subversion tree.
>
> The way I handle it is that, hidden somewhere, I have an account with a 
> cron job that does this:
>
> $ git svn fetch
> $ git push origin refs/remotes/*:refs/heads/*
> $ git push origin refs/remotes/trunk:refs/heads/master
>
> The first push synchronizes "origin" to have the same branches as this 
> git-svn copy of the git repository, and the second updates "origin" so that 
> it has a "master"; without that second step, "git clone" will error out 
> when it get to its checkout phase.

This got me thinking about a potential design for a git-svnserver.
[Warning: engineering hack ahead, proceeed with caution.]

Instead of re-implementing any part of svn, just use a stock svn repo
+ server.  From the svn post-commit hook, update a git-svn repo as
above.  From the git post-commit, do a git-svn rebase.  Of course, you
need a shared lock between the two pairs of pre/post commit hooks.

The problem of attribution in svn from git-svn is probably easier to
solve from within the context of a post-commit hook.  The problem of
having to round-trip git commits through svn in a way that changes
their ids remains.  Effectively, that means commits have to be
considered "unpublished" (for the purpose of not basing other work
upon them) until they are pushed to the git-half of the git+svn.

Still, this scenario is a pretty gentle migration path from svn to git
- one that allows regular git users to use only git-core, not git-svn,
and still allows svn clients to work.  Maybe some git-alias magic
could hide the fact that a git push has to really become a push +
fetch.


-chris
