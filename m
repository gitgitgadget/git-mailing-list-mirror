From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 17:32:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151723530.7211@ppc970.osdl.org>
References: <000701c5420e$e89177b0$6400a8c0@gandalf>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 02:27:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMb9S-0004RN-E1
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 02:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVDPAa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 20:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVDPAa2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 20:30:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:59526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262489AbVDPAaT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 20:30:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G0UGs4016855
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 17:30:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G0UFYs025049;
	Fri, 15 Apr 2005 17:30:15 -0700
To: Barry Silverman <barry@disus.com>
In-Reply-To: <000701c5420e$e89177b0$6400a8c0@gandalf>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Barry Silverman wrote:
>
> The issue I am trying to come to grips with in the current design, is
> that the git repository of a number of interrelated projects will soon
> become the logical OR of all blobs, commits, and trees in ALL the
> projects. 

Nope. I'm actually against the notion of sharing object directories
between projects. The git model _allows_ it, and I think it can be a valid 
approach, but it's absolutely not an approach that I would personally 
suggest be used for the kernel.

In other words, the default git behaviour - and the one I personally am a 
proponent of - is to have one object directory per work tree, and really 
consider all such trees independent. Then you can merge between trees if 
you want to, and bring in objects that way, but normally you would _not_ 
have tons of objects from other trees, and _especially_ not from other 
unrelated projects.

The reason git supports shared object archives is that (a) it falls out 
trivially as part of the design, so not allowing it is silly and (b) it is 
part of a merge, where you _do_ want to get the objects of the trees you 
merge, and in particular you need to generate a seperate tree that has all 
those objects without having to copy them.

(Before you do the merge, you need to bring the new objects into your 
repository of course, but that I consider to be a separate issue, not 
part of the actual technical merge process).

So normally, you'd probably have a totally pruned tree, with only the 
objects you need (and you might even consider the "commit parent links" 
less than necessary, especially if you're just a regular user and not a 
developer who wants to merge).

But the ability to have extra objects is wonderful. It makes going
backwards in time basically free (while the equivalent "bk undo" in the BK
world is a very expensive operation), and it makes it easy to
incrementally keep up-to-date with trees that you know you're _eventually_
going to merge with. But it's not an excuse to put just any random crap in 
that object directory..

		Linus
