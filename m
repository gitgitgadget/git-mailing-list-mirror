From: Linus Torvalds <torvalds@osdl.org>
Subject: A note on merging conflicts..
Date: Fri, 30 Jun 2006 19:44:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jul 01 04:44:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwVTN-0000cM-Fx
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 04:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWGACoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 22:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWGACoi
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 22:44:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750907AbWGACoh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 22:44:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k612iXnW022238
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Jun 2006 19:44:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k612iWI8007539;
	Fri, 30 Jun 2006 19:44:33 -0700
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23032>


Ok, over the last week or so, I've been having a lot more content 
conflicts than usual, mostly because of 

 (a) just the fact that the way the merge window happens for the kernel 
     these days, rather than have incremental small merges, we often end 
     up having lots of big ones.
and

 (b) I ended up merging a few trees that had lots of small changes all 
     over, notably to header files having their <config.h> include 
     removed, causing trivial conflicts.

Now, the good news is that I have to say that our conflict resolution 
rocks. It's all been _very_ easy to do. In fact, it's been even more 
pleasant than BK was, because of one big issue: you could resolve the 
conflict in the tree, then _test_ it (perhaps just compile-test it), and 
commit the resolved result separately. With BK, you had to resolve and 
commit atomically, and you never had access to a "preliminary resolve" to 
test.

However, I also notived one particular thing that I did that we make less 
than perfectly easy.

One thing that is _very_ useful to do is to do when you have a conflict is 
this:

	git log -p HEAD MERGE_BASE..MERGE_HEAD -- conflicting-filename

because this shows all the changes (with their explanations) for that 
filename since the MERGE_BASE in _both_ branches you're trying to merge. 
This simple command really makes conflict resolution a hell of a lot 
easier, because you can see what caused the conflict, and you get a real 
feel for what both branches were doing, making it a _lot_ more likely that 
you actually do the right thing.

Now, the downside is that the above is both a pain to type, and we don't 
actually even save the MERGE_BASE as a head, so you actually have to 
compute it yourself. It's easy enough to do:

	git-merge-base HEAD MERGE_HEAD > .git/MERGE_BASE

will do it, but the fact is, we should make this even easier.

In fact, after writing the above a few times, I really think there's a 
case for making a helper function that does exactly the above for us. 
Including all the "conflicting-filename" thing. It would be nice if

	git log -p --merge [[--] filenames...]

would basically expand to

	git log -p HEAD MERGE_HEAD
		^$(git-merge-base HEAD MERGE_HEAD)
		-- $(git-ls-files -u [filenames...])

so that I wouldn't have to type that by hand ever again, and doing a

	git log -p --merge drivers/

would automatically give me exactly that for all the unmerged files in 
drivers/.

Anybody want to try to make me happy, and learn some git internals at the 
same time?

			Linus
