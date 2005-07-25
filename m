From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Mon, 25 Jul 2005 16:00:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org>
References: <20050712213531.GA10936@pc117b.liacs.nl> <20050713011818.GM9915@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven Verdoolaege <skimo@liacs.nl>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 01:04:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxBzo-0008W7-HN
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 01:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVGYXDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVGYXDu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 19:03:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261249AbVGYXBu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 19:01:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6PN0pjA021535
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Jul 2005 16:00:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6PN0nCn017030;
	Mon, 25 Jul 2005 16:00:50 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050713011818.GM9915@kiste.smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Matthias Urlichs wrote:
> 
> Sven Verdoolaege:
> > Previously, git-cvsimport-script would fail
> > on revisions with more than one digit.
> > 
> Ouch. Thanks.

Hmm.. I finally tried to import the bkcvs kernel tree into git, and while 
I'm cursing the slowness of CVS (I'm _hoping_ that part of the problem is 
just that CVS is especially slow with old versions of files, and that the 
import will eventually start speeding up), there's definitely something 
wrong going on with new files in an archive...

In particular, they always end up being imported as zero-sized empty
files, and will be filled in only later if that file is ever touched 
again. In other words, the resulting git tree ends up being bogus.

The command line I used was

	git cvsimport -d /home/torvalds/bkcvs -p --bkcvs linux-2.5

and I wonder if it's the "--bkcvs" thing that confuses cvsimport, but I 
also wonder if anybody has actually tried this before. With or without 
the --bkcvs line, I get

	Argument "28213 has collisions" isn't numeric in addition (+) at /home/torvalds/bin/git-cvsimport-script line 600, <CVS> line 1.
	* UNKNOWN LINE * PatchSet 28209 has collisions
	* UNKNOWN LINE * PatchSet 28194 has collisions
	* UNKNOWN LINE * PatchSet 28181 has collisions
	* UNKNOWN LINE * PatchSet 28180 has collisions
	...

Sadly, since I don't know perl, I can't tell whether this is a problem 
with cvsps on the kernel, or the cvsimport perl script. I'm going to try 
my old hacky C + shell alternative next just to see, but I thought I'd ask 
whether people have tried this before and already know what's wrong.

Btw, looking at what the perl script _seems_ to do, it does seem to do
insane things for the local CVS archive case. As far as I can tell from
the spaghetti that is perl, it uses a CVS server to handle even the local 
file case, which just _can't_ be right. I realize you'd want to do that to 
avoid connecting millions of times, but maybe it's better to use something 
like cvsnup to download the whole thing, and then always use a local CVS 
archive?

			Linus
