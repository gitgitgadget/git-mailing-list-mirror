From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 13:24:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505221259110.2307@ppc970.osdl.org>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
 <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
 <20050522184237.GG18500@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org> <7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
 <7vy8a7cavf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 22:22:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZwww-0003Te-OS
	for gcvg-git@gmane.org; Sun, 22 May 2005 22:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVEVUWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 16:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVEVUWc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 16:22:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:50621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261272AbVEVUWV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 16:22:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MKMDjA019133
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 13:22:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MKMBk8027216;
	Sun, 22 May 2005 13:22:12 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8a7cavf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Junio C Hamano wrote:
>
> I deliberatly chose not to record rename/copy distinction in diff-raw
> --- it is to be inferred from which entry touches the src _last_.  
> Everything but the last one to touch the same path is copy, and the last
> one is rename.

My counter-example: there is no rename at all, just a copy.

The current raw-diff output simply _cannot_ distinguish this from the case
where there is a rename, as far as I can tell. 

Basically, imagine doing something like this:

	mkdir test-copy
	cd test-copy
	git-init-db 
	cp ~/v2.6/linux/kernel/sched.c .
	git-update-cache --add sched.c 
	echo duh | git-commit-tree $(git-write-tree) > .git/HEAD
	sed 's/sched\.c/other\.c/g' < sched.c > other.c
	git-update-cache --add other.c 
	echo duh2 | git-commit-tree $(git-write-tree) -p HEAD

and dammit, if "other.c" doesn't show up as a copy (with small
differences) of sched.c, then the whole diff algorithm is broken and
clearly isn't doing copy-diffs right at all (right now it doesn't do it
since diff-tree doesn't even do the "check copies against old", but that's
a different issue).

In other words, how do you propose to _describe_ that copy?

The whole point to the "raw diff" format is that you should be able to 
get the same output with

	git-diff-tree -C HEAD | git-diff-helper
	git-diff-tree -C -p HEAD

and right now I don't see how you can do that.. And if you can't do that,
then the raw diff format is pointless. It's not "raw diff" at all, it's a
"less capable diff" format.

THAT is why I think the raw diff output is broken right now. All the rest 
was about just trying to also make it a bit more readable while at it.

Try it. I added in the "&& detect_rename < 2" thing to diff-tree.c, and I 
get:

	git-whatchanged -C --root | git-diff-helper | less -S

resulting in:

	diff-tree eb773598aa29bb642d6016a0d5961c80628ce490 (from 8c63fcad1f27ceed6825110aa806349dad99d89f)
	Author: Linus Torvalds <torvalds@ppc970.osdl.org>
	Date:   Sun May 22 13:17:40 2005 -0700
	    
	    duh2
	
	diff --git a/sched.c b/other.c
	--- a/sched.c
	+++ b/other.c
	@@ -1,5 +1,5 @@
	 /*
	- *  kernel/sched.c
	+ *  kernel/other.c
	  *
	  *  Kernel scheduler and related syscalls
	  *

ie it does NOT say it is a copy, because it _cannot_ say it is a copy. It 
just doesn't know. A copy and a rename look exactly the same in the raw 
diff output, and that's a BUG.

		Linus

