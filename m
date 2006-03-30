From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Thu, 30 Mar 2006 09:32:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603300919280.27203@g5.osdl.org>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
 <7vmzfac7gn.fsf@assigned-by-dhcp.cox.net> <1143687710.2524.1.camel@mattlaptop.metaesthetics.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 19:33:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP10x-0005Ek-2h
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 19:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWC3Rcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 12:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWC3Rcw
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 12:32:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17811 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751329AbWC3Rcv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 12:32:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2UHWdCo015689
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Mar 2006 09:32:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2UHWcW3018150;
	Thu, 30 Mar 2006 09:32:39 -0800
To: Matt McCutchen <hashproduct@verizon.net>
In-Reply-To: <1143687710.2524.1.camel@mattlaptop.metaesthetics.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.71__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18200>



On Wed, 29 Mar 2006, Matt McCutchen wrote:
> 
> Perhaps this is just politics, but which kernel repository is more
> official, and why?  Linus's or the one I have been using,
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> ?

The beauty of git should be (and maybe that's not entirely true simply 
because of practical concerns) that there really need not be any notion of 
"more official".

You can fetch multiple different git trees from different sources into the 
same git tree, and then keep them _all_ around equally as different 
branches. You can move fixes between the different branches with "git 
cherry-pick", and you can merge different branches with "git merge"

Now, the reason I say "_should_ be" rather than "is" is two-fold:

 - right now, a lot of the infrastructure is simply set up more towards 
   the "one single source repository" model. When you do a "git clone", it 
   kind of makes the origin special. That's how all the documentation is 
   written, and that's also the only remote branch that git creates 
   _automatically_ for you.

   This really isn't a technical issue: the git code code doesn't care 
   about any special "original" repository. But the fact that you have to 
   create the ".git/remotes/linus" file by hand, and that all the examples 
   in the docs end up talking about a single "origin" branch means that 
   people _think_ of git as a "single origin" thing.

 - the more fundamental one is that when you start mixing branches, you 
   have to be very careful if you expect the upstream projects to pull the 
   changes _back_. In particular, that's where you have to think twice (or 
   three times) about doing a "git merge" (or a "git pull", which 
   implicitly merges for you if it's not a pure fast-forward).

   In particular, the fact that _you_ want to merge two trees that came 
   from different sources does _not_ imply that either of the two sources 
   might want to merge with each other. So if you merge the two together, 
   you may find it impossible to have either of them then pull from you: 
   they way want your changes, but they might not like the merge you did, 
   because they have different policies about that work than you did.

So while the first point is purely a "mental model" issue and about lack 
of helper scripts, the second point is fundamental.

For example, in your case it was almost certainly the right thing to do to 
cherry-pick your changes from the 2.6.15.6 branch onto the development 
branch, because I simply don't want to merge the 2.6.15.6 stuff into the 
standard tree: part of the _rules_ for the stable branch is that the 
things it fixes should have been fixed in the development tree already, so 
merging the stable tree should always be unnecessary (and often clash, 
although _hopefully_ in many cases the fixes in the stable tree are 1:1 
identical and will merge beautifully).

Anyway: from a technical standpoint, no tree should be "special" or "more 
official" for git usage. But when merging data back to any of those trees 
that aren't special, the source/history of the data is important to keep 
in mind. Branch "a" may not be any more special than branch "b", but when 
you push changes back to the source of branch "a", the history of those 
changes (relative to what the source was) is meaningful.

			Linus
