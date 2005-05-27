From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Diff updates, fixing pathspec and rename/copy interaction.
Date: Fri, 27 May 2005 08:56:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
 <7vsm091887.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 17:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbh94-0004TO-Cy
	for gcvg-git@gmane.org; Fri, 27 May 2005 17:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVE0PzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 11:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVE0PzM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 11:55:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:20878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262477AbVE0Pyk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 11:54:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RFsVjA016072
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 08:54:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RFsUta026911;
	Fri, 27 May 2005 08:54:31 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm091887.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Junio C Hamano wrote:
>
> During the mailing list discussion about diff-tree omitting to
> call diffcore-pathspec, I realized that the current rename/copy
> differentiator has a major flaw interacting with pathspec (or
> any other filepair filters, including pickaxe).
> 
> The problem was that in order to tell if the rename-copy source
> still remains in the resulting tree (that is what determines if
> one of the rename-copy can become a rename or everybody needs to
> be a copy), diffcore-rename was sending a filepair that records
> unmodified source downstream, expecting that it reaches
> resolve_rename_copy() which happens as the final stage before
> actual output happens.  Of course, pathspec and pickaxe can
> interfere and happily remove that entry, in which case what
> should be shown as a copy suddenly becomes a rename.

Umm.

I would much prefer a _much_ simpler fix at least for the pathname part,
which is to just always require that pathspec handling is done _first_.

Why? Because that's fundamentally how git-diff-tree has to work, and it's
how my mental model has always been: the path limitations are a
first-order filter, and if you give a directory, the end result should
always look exactly as if that directory was a project of its own.

In other words, if you limit yourself to a directory, and there was a
rename that moved a file from outside that directory into it, then it is
not a rename at all, it is a "create". The stuff outside the pathspec
limit simply doesn't exist.

This is fundamentally how git-diff-tree has to work for pathspec to make
any sense at all, and it's also the only usage that makes any sense (ie
when I say "git-whatchanged -p arch/i386 include/asm-i386", I expect that
the patches that show up _only_ concern themselves with what happened in
x86, and there's no cross-pollination with other stuff at all, even if
rename detection is enabled).

That in turn implies that the other pathspec users have to work the same
way, for the thing to be consistent.

Now, I don't know how you want pickaxe to work, and maybe you want that to 
run _after_ rename detection, I dunno. So I suspect you still want to do 
what this patch does, but I really don't want pathspec to be involved in 
this thing..

		Linus
