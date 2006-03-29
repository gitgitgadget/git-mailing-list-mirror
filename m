From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Tue, 28 Mar 2006 18:10:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603281749060.15714@g5.osdl.org>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 04:10:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOQ99-0006tT-Oo
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 04:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWC2CKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 21:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWC2CKw
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 21:10:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2798 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbWC2CKv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 21:10:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2T2AlCo007330
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Mar 2006 18:10:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2T2AkLU007349;
	Tue, 28 Mar 2006 18:10:47 -0800
To: Matt McCutchen <hashproduct@verizon.net>
In-Reply-To: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Mar 2006, Matt McCutchen wrote:
> 
> I made a customized Linux kernel based on 2.6.15.6 by cloning the stable
> 2.6.15 kernel repository (which was then at version 2.6.15.6) and making
> several commits.  Now I would like a Linux kernel based on 2.6.16 with
> the same customizations.  This seems to be a very simple task, but I
> have been trying various combinations of git commands for several days
> and have not figured out how to do it.
> 
> I believe that means I should pull the 2.6.16 kernel into the "origin"
> branch and then rebase the "master" branch, 

Don't "Pull". "Fetch".

"Pull" implies a merge, which is not what you want.

>		 To this end, I switched my remote file to point to the
> 2.6.16 stable repository and tried to pull.  The result was not what I
> wanted.  The situation is complicated by the fact that 2.6.15.6 is not
> an ancestor of 2.6.16.  The warning in the man page about branches that
> are modified nonlinearly seems to apply.

Just realize that you can have any number of branches, and instead of 
forcing "origin" to be something that it simply is not, just create a new 
branch called "linus".

Make that point to my tree, and do

	git fetch linus

to update it. It really is that easy.

Exact commands something like this:

 (1) Edit your .git/remotes/linus file so that it has the following 
     contents:

	URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
	Pull: refs/heads/master:refs/heads/linus

 (2) Use that to fetch my tree as the "linus" branch:

	git fetch linus

and now you have at least a nice new branch that contains the "standard" 
kernel. At which point you just need to do

 (3) rebase the work since "origin" onto "linus":

	git rebase --onto linus origin

I really really despise the "git rebase" command line syntax, and I find 
it very non-inuitive, but what this does is take your current branch, 
compare its contents to "origin" (ie where you started from), and then 
just rebase the commits onto the state that is "linus".

[ Junio: syntax comments:

  Personally, I think the rebase syntax sucks, because the _natural_ way 
  to do it is to just describe the set of commits to rebase the same way 
  we describe all _other_ commit sets: as a "begin..end" sequence.

  So I think rebase _should_ work something like this:

	git rebase origin.. [--onto] linus

  ie just giving an arbitrary range. This is even more noticeable for 
  "git-format-patch", where that insane "<his> [<mine>]" syntax is even 
  worse, for no good reason, when again it should really just work like 
  "git diff" where giving a single revision implies a single revision, and 
  giving a range implies a range, and no strange "mine" vs "his" rules ]

Oh well. Syntax rant over.

			Linus
