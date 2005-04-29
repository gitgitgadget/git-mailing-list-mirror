From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 13:21:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
 <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Russell King <rmk@arm.linux.org.uk>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:28:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRc6C-0007Kj-6b
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVD2U34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVD2U30
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:29:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:35474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262930AbVD2UUX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 16:20:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TKJMs4002491
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 13:19:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TKJLGh001919;
	Fri, 29 Apr 2005 13:19:22 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050429195055.GE1233@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Ryan Anderson wrote:
> 
> Why not just use "rsync" for both remote and local synchronization, and
> provide a "relink" command to scan two .git/objects/ repositories and
> hardlink matching files together?

Absolutely. I use the same "git-pull-script" between two local directories 
on disk. The only issue there is that you have to give the ".git" 
directory, ie you should do

	git-pull-script ~/by/other/repository/.git

instead of pointing to the other repo's root.

Of course, I don't bother with the linking. But that's the trivial part.

> With the SHA1 hash, you can even have a --unsafe option that just
> compares the has names and does a link based purely off of that and the
> stat(2) results of both files.  (I'd expect that a ... safer variant
> would extract both files and compare them, but the --unsafe should be
> sufficient, in practice, I would think.)

I don't think there is any point to unsafe. The assumption is that if you 
do things this way, the "unlinked" files will the the uncommon case, so 
what you do is

 - remember the list of files you copied when you did the pull (you had to 
   have this list at some point anyway). Sort by name,
 - create a list of names of both repositories, sorted by name
 - do the union of those three lists (cheap, thanks to the sorting)
 - stat each name to see if it's already linked (which it will be, most of 
   the time), continue to the next one..
 - if they aren't linked, just do a "cmp" on them, and warn if they aren't 
   the same, continue to the next one.
 - else link them.

And if you want to, you can skip the first stage, and just relink two
trees without looking at a list of "known new" files - it's going to be
expensive to link two big repositories the _first_ time, but hey even the
"expensive" part is likely to be pretty cheap in the end. If it takes an
hour or two to relink some years of history, big deal. Do it overnight,
you only need it once.

		Linus
