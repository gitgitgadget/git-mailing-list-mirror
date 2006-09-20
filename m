From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 08:28:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
References: <20060920080308.673a1e93@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 17:34:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ457-0007ss-Ug
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 17:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWITPdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWITPdr
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 11:33:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37589 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751630AbWITPdq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 11:33:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KFS9nW018660
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 08:28:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KFS8iV001066;
	Wed, 20 Sep 2006 08:28:08 -0700
To: Stephen Hemminger <shemminger@osdl.org>
In-Reply-To: <20060920080308.673a1e93@localhost.localdomain>
X-Spam-Status: No, hits=-0.508 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27351>



On Wed, 20 Sep 2006, Stephen Hemminger wrote:
> 
> This doesn't work with all the branches for some reason. Is this a git
> bug?

It's a "Jeff bug". He rebases some of his branches, and git by default 
refuses to throw away the old data (so if the new branch is not a fast 
forward, it will _not_ just silently throw away the old state).

However, you can tell git that Jeff is being difficult by marking such 
branches individually as being rebased.

The git archive itself has one such branch: Junio re-writes the "pu" 
branch all the time, and so it seldom fast-forwards nicely (the thing 
about a fast forward is that you do _not_ lose any old history, you only 
append to it, while a rebase will throw the old history away and generate 
new history in its place).

So for example, for git itself, you might have a "remotes" file like mine:

	[torvalds@g5 git]$ cat .git/remotes/parent 
	URL: master.kernel.org:/pub/scm/git/git
	Pull: master:parent
	Pull: next:next
	Pull: +pu:pu

which just says that the "parent" repo is the master repo for git, and 
notice how the "Pull: +pu:pu" line has that extra "+" at the head. That's 
a marker that the remote "pu" branch (which is fetched into the _local_ 
"pu" branch) should be updated even if it doesn't fast-forward.

So you could either mark _all_ the remote branches with the extra "+" (to 
say that you always want to fetch that exact state for whatever branch 
you're tracking), or you can ask Jeff which branches he expects to do 
strange things and just mark those individual ones.

> A temporary workaround is to prune the offending branches locally
> first, but that seems like a hack.

So there's a non-hack version of this as per above, and it's even 
documented, although hard to find (see Documentation/pull-fetch-param.txt)

		Linus
