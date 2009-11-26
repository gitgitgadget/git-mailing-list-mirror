From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: dcommit --commiturl rebases against fetch url rather
	than against commit url
Date: Wed, 25 Nov 2009 17:59:19 -0800
Message-ID: <20091126015919.GA22762@dcvr.yhbt.net>
References: <1259198081-sup-3175@cannonball>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingmar Vanhassel <ingmar@exherbo.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 02:59:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDTdl-0001g0-Vw
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 02:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZKZB7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 20:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZKZB7O
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 20:59:14 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48723 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbZKZB7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 20:59:13 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67A11F684;
	Thu, 26 Nov 2009 01:59:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1259198081-sup-3175@cannonball>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133753>

Ingmar Vanhassel <ingmar@exherbo.org> wrote:
> Hi Eric & list,
> 
> I'm using a git-svn setup where svn-remote.svn.url is set to use
> anonymouse svn, and svn-remote.svn.commiturl uses my ssh+svn:// login.
> 
> I'm using anonymous svn for fetching because this git-svn import is
> shared with a few other developers, who don't have commit access, but
> who do prefer to use a git-svn import over SVN, for their work. Since I
> use anonsvn for the import they can continue my import.
> 
> When I dcommit to svn, git-svn happily commits the first commit. When it
> tries to rebase after that it fetches from the anonsvn url, which is
> synced only ever 5 or 10 minutes. Thus, it doesn't find my commit, and
> it aborts, meaning I need to wait until anonsvn catches up, before being
> able to do another commit.

Hi Ingmar,

Wow, talk about weird corner cases.  Is this the monster KDE SVN repo?
I suppose the sync delay and multiple servers is necessary for that
thing.  I wrote commitUrl because I needed to work on a tiny repo :)
(and it was migrated fully to git shortly after)

> Any suggestions on how this could be solved without reimporting with
> the rewriteRoot option set?

Depending on how big your imported repo is, I might want to keep two
copies since rewriteRoot can be messy.  So keep using the anonymous one
shared with your developers, and make a full copy of $GIT_DIR for
yourself to run git filter-branch against.

That means don't write to the anonymous one at all here, just copy that
entire $GIT_DIR in case something goes wrong, you can recopy and tweak
the procedure (It's been a while since I've tried this :)

 * write a git filter-branch script that rewrites the git-svn-id:
   lines to the svn+ssh:// URL,  I haven't used filter-branch in
   a while but this should work...

 * remove all .rev_map.* files under $GIT_DIR/svn

 * change your $GIT_CONFIG file to point to the svn+ssh URL
   no need to use the commitUrl option anymore, either

 * remove $GIT_DIR/svn/.metadata to be safe, too

 * run "git svn fetch"
   This last step should rebuild all the .rev_map.* files under
   $GIT_DIR/svn.

Hopefully that works for you, let us know how it goes.

-- 
Eric Wong
