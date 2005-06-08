From: Linus Torvalds <torvalds@osdl.org>
Subject: Handling merge conflicts a bit more gracefully..
Date: Wed, 8 Jun 2005 13:55:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:56:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg7Y3-00065h-P2
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 22:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVFHU5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVFHU5J
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 16:57:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:20415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261618AbVFHU4x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 16:56:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58KrJjA021783
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 13:53:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58KrHiE015787;
	Wed, 8 Jun 2005 13:53:18 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, Jeff reported that whenever there is a merge conflict, he ends up 
really punting on it and doing it all with diffs, which clearly meant that 
I had to fix up my silly things for this. Which I think I've done now.

What happens now in the case of a merge conflict is:
 - the merge is obviously not committed
 - we do all the successful merges, and update the index file for them
 - for the files that conflict, we force the index to contain the old
   version of the file (ie we remove the merge from the index), and we
   write the (failed) output of the merge into the working directory, and
   we complain loudly:

	Auto-merging xyzzy.
	merge: warning: conflicts during merge
	ERROR: Merge conflict in xyzzy.
	fatal: merge program failed
	Automatic merge failed, fix up by hand

at which point a normal "git-diff-files -p xyzzy" will show the incomplete
merge results (as relative to the original BRANCH you started with), and
in fact you can also do "git-diff-cache -p MERGE_HEAD xyzzy" to see the
same thing (but relative to the branch you tried to merge).

You then fix up the merge failure by hand (exactly the way you'd do with 
CVS), and you do a "git-update-cache xyzzy" when you're happy with the end 
result. Then a simple "git commit" should do the right thing.

If you decide that the merge is too hard to undo, you'd do:

	git-read-tree -u -m HEAD
	rm .git/MERGE_HEAD

and use git-checkout-cache judiciously to remove any edits the merge did.

This is definitely not perfect, but it's a hell of a lot more usable than
it used to be, and not really worse than what CVS people are used to (and
usually a lot better, since git will obviously get the origin of a
three-way merge right, unlike CVS).

Comments? It would be good to have people test this and maybe even write a 
few automated tests that it all works as expected..

		Linus
