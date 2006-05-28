From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/4] Start migrating away from the "struct tree_entry" list
Date: Sun, 28 May 2006 15:03:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605281453460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 00:04:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkTMi-0004ae-2F
	for gcvg-git@gmane.org; Mon, 29 May 2006 00:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWE1WDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 18:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWE1WDz
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 18:03:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750986AbWE1WDy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 18:03:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4SM3o2g030332
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 May 2006 15:03:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4SM3nr5015688;
	Sun, 28 May 2006 15:03:50 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20900>


The old "tree.h" parsing logic (before I did the "tree-walk" tree buffer 
parser) would generate a list of "struct tree_entry" objects, which was 
basically a simpler-to-walk version of the raw tree buffer.

Now, the problem with that simpler-to-walk version is that it's a lot less 
efficient than just walking the raw tree buffer in-place, and a lot of the 
core git tree walkers already use the much more efficient in-place 
tree-walker interfaces. Which means that we have _two_ independent ways of 
walking the tree. Very annoying.

This series of four patches (on top of my trivial memory leak fix for git 
rev-list) gets rid of the tree-entry list from tree parsing, and converts 
most users over to use the tree-walker, and has a small compatibility 
helper function to keep some users that are hard to convert using what is 
now obviously just a temporary list.

Apart from being one more step in the direction of cleaning up tree 
walking, it also makes things more efficient, by not needlessly creating 
that silly list that most users don't actually want. I used the same test 
vector as I did for the git rev-list leaker: doing a

	git-rev-list --all --objects

on the historical kernel archive (that one has 566k objects and is more 
than twice the size of the current kernel git tree). The series brings 
that down from

	74.67user 0.45system 1:15.43elapsed

to

	62.50user 0.41system 1:02.93elapsed

for me.

NOTE! I think the git-rev-list leak fix can go into the main tree 
immediately, but this series should probably be kept in "next" for a 
while, just to verify that it all is good..

		Linus
