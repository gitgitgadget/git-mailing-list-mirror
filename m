From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] read-tree -m 3-way: handle more trivial merges
 internally
Date: Thu, 9 Jun 2005 08:15:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <7vis0o30sc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
 <7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net> <7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 17:20:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgOg7-0001bJ-Jx
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 17:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVFIPOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 11:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVFIPOU
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 11:14:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261830AbVFIPOB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 11:14:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j59FDljA009538
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Jun 2005 08:13:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j59FDkHF005999;
	Thu, 9 Jun 2005 08:13:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 9 Jun 2005, Junio C Hamano wrote:
>
> This patch teaches "read-tree -m O A B" that some more trivial
> cases can be handled internally.

No, I think this is quite possibly wrong for several reasons.

For one, it makes the rest of the system unaware of the deleted files, so 
nothing ever deletes them from the working directory.

And that's not entirely trivial to fix either, since the obvious fix 
(which is to just do a

	if (update)
		unlink(b->name);

or something like that) is wrong. It's wrong because we must not do the
update until the very end, when we've either merged all entries or we've
failed on an entry that couldn't be merged (that's why I did the extra
CE_UPDATE flag, instead of updating as we go along).

Now, you could fix that by creating a separate list of files to be 
deleted (so this is not fundamental, it's just more complicated than the 
trivial case), but that doesn't help, because there's _another_ reason why 
read-tree shouldn't handle these cases.

Namely that read-tree doesn't have a frigging clue about renames, and 
shouldn't have.

But a real merge program _could_ have a frigging clue, and might notice 
patterns like

 - file got modified in one branch, removed in the other
 - a file got added in the other branch
 - "Hey, that added file looks like the removed one!"
 - Let's merge the modifications from the first branch into the move of 
   the second branch!

See? Now, git-read-tree won't handle the first case anyway, but your 
change _does_ make it handle the "file got added" case, which means that 
now the added file is invisible the the "smart merger", and the smart 
merger can't really tell that it was a rename any more.

So our current stupid file-by-file "git-merge-cache" will never do this, 
but that's a limitation of me being less than the intellectual giant I 
wish I was. So I just do the stupid merges. But I _know_ they are stupid, 
and I would like to leave the door open for somebody else to fix up the 
cases I don't handle.

You're basically closing that door.

Now, you can (validly) argue that you could still just look at the
original trees ("git-diff-tree -C $O $M") and grep for copies/movement and
do it by hand _there_ instead of looking at the result of the read-tree, 
and you may well be right. So again, this is not a _fundamental_ problem, 
although it's a bit more fundamental than the first one. 

So if you want to convince me that it's better to do the rename detection
outside of the index file, go wild. Alternatively, you can argue that we
can always undo this later, when once we _do_ have rename and copy
detection and can try to merge things automatically (what _do_ you do if a
file is copied in one branch and modified in the other? Just warn the poor
user, I guess).

So I just need a little convincing that this is a good idea.

		Linus
