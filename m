From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Question on GIT usage.
Date: Fri, 28 Oct 2005 19:06:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510281847220.3348@g5.osdl.org>
References: <4362C700.6020901@candelatech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 29 04:07:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVg7F-0004Lv-Sv
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 04:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVJ2CG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 22:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVJ2CG3
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 22:06:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35816 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751088AbVJ2CG2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 22:06:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9T26PFC015118
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Oct 2005 19:06:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9T26MuZ032507;
	Fri, 28 Oct 2005 19:06:23 -0700
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <4362C700.6020901@candelatech.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10780>



On Fri, 28 Oct 2005, Ben Greear wrote:
> 
> I have a kernel GIT tree to hold my developing patches...
> 
> I need to build this kernel for 4-5 different processors (c3, p2, p4, p4-smp,
> etc).

Sounds like you just want to use a separate build directory for the 
kernel, which you can do quite independently of git (of course, not too 
many people use it, so the separate-object-directory Kbuild infrastructure 
has bugs every once in a while..)

The way it _should_ work is that you can do something like this:

	.. have a clean source-tree in ~/src/linux ..

	# set up the build tree
	cd
	mkdir build-tree
	cd ~/src/linux
	make O=~/build-tree oldconfig

	# go there and build it
	cd ~/build-tree
	make

and now you can have a build-tree for each of your different 
architectures.

Now, you _can_ certainly do the very same thing with just multiple git 
repositories, and pull between them. That has its own set of advantages 
too: you can have slight differences between the trees. Of course, if you 
know you don't want any differences between the trees, that's not an 
advantage, that's a disadvantage.

You can also have just one single real git repository, and then have that 
one checked out multiple times. Use GIT_OBJECT_DIRECTORY to share the core 
objects, and then you can have ten different git trees without duplicating 
all your objects and pack-files.

> Is there any clever way to have this one git repository keep these
> other source trees in sync so that I can do incremental builds?

If you really want them 100%, the separate build trees is the best option.

That said, a lot of _other_ projects don't do separate build trees that 
well (and as mentioned, sometimes it breaks for the kernel too), and git 
certainly could be set up to be a "poor mans separate build tree".

Right now the easiest way to do that is to just have separate repositories 
(and share at least _some_ objects by just using "git clone -l -s" to 
clone them), but it could be hacked to be more geared explicitly towards 
that..

		Linus
