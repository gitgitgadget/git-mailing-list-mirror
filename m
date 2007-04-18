From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Cloning of git-svn repos?
Date: Wed, 18 Apr 2007 10:21:49 -0700
Message-ID: <462653AD.5060902@midwinter.com>
References: <20070418092916.GI31488@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 19:21:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeDql-0001R1-GU
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 19:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992883AbXDRRVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 13:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992905AbXDRRVo
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 13:21:44 -0400
Received: from tater.midwinter.com ([216.32.86.90]:48737 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992883AbXDRRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 13:21:43 -0400
Received: (qmail 2981 invoked from network); 18 Apr 2007 17:21:43 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.133?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 18 Apr 2007 17:21:42 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <20070418092916.GI31488@curie-int.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44917>

Robin H. Johnson wrote:
> Is there a sane and git-recommended way to clone repos created with
> git-svn?
>
> If I do: 'git-svn clone ....', and then git-clone of that directory, the
> second clone cannot use git-svn to follow the original SVN or feed stuff
> back to the original SVN.
>   

There is some git-svn-specific data in the .git directory that isn't 
copied by git clone. You could perhaps get away with just copying that 
(some stuff in .git/config, and the .git/svn subdirectory) into a cloned 
child.

What I usually do instead is make a parent repository with git-svn, then 
clone that as needed. I have a cron job that does "git-svn fetch" in the 
parent periodically, so the child repositories can just update from the 
parent to stay current. When I want to commit to svn, I push to the 
parent repo (be careful here since git-svn can't create non-bare 
repositories, so don't ever push to the currently checked-out branch in 
the parent), git-reset the parent to whatever svn branch I want to check 
into, merge the just-pushed change into the parent's current branch, 
then do my git-svn dcommit.

That workflow could undoubtedly be made simpler. In particular, one 
could use hooks in the parent repository to automatically do the 
reset-merge-dcommit dance. If you had that, then pushing to the parent 
would immediately commit those changes to svn and there'd be little 
reason to want to do svn operations from the cloned children.

-Steve
