From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] Clean up and optimize tree walking some more
Date: Wed, 21 Mar 2007 10:07:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703210955370.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU4Hj-0001Oi-7S
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 18:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbXCURHR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 13:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbXCURHQ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 13:07:16 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44168 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933094AbXCURHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 13:07:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LH7AcD029013
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 10:07:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LH79CZ030824;
	Wed, 21 Mar 2007 09:07:10 -0800
X-Spam-Status: No, hits=-0.969 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42803>


This series of three patches improves blame performance on the eclipse 
tree by about 15% in my tests by improving the tree walk a bit.

  [ Before-best-of-five: 11.649s
    After-best-of-five:   9.675s ]

The first two patches are just boring cleanups: the first removes an 
unnecessary field from the "name_entry" structure, because I wanted to 
embed it into the "tree_desc" one and it was just totally redundant and I 
felt bad about growing tree_desc more than necessary. No real code 
changes, just replacing the use of "pathlen" with the helper function we 
introduced ealier ("tree_entry_len()").

The second one just makes sure that we always initialize the tree_desc 
structure with a helper function rather than doing it by hand. Again, this 
doesn't actually change any code, although I changed the name of the "buf" 
entry to "buffer", and the type of "size", so that we get nice compiler 
warnings if they are used the old way by mistake.

The second patch is the largest of the lot, but really doesn't do 
anything interesting, just preparatory cleanup.

The third patch is the one that actually changes any code, and is fairly 
straightforward: it just switches around where we actually do the tree 
entry parsing, which is now possible thanks to patch #2. By doing it 
up-front, we only need to do it once (we used to have to do it both when 
doing the "extract" *and* when doing the "update" op - now we do it only 
once per entry, and "extract" is just about looking at the cached 
contents).

The resulting diffstat of the tree patches ends up removing a few more 
lines than it adds (not by a lot), but perhaps more importantly (even more 
than the performance advantage) the code looks nicer, I think.

 builtin-fsck.c         |    5 +-
 builtin-grep.c         |   13 +++--
 builtin-pack-objects.c |    8 +--
 builtin-read-tree.c    |    3 +-
 builtin-reflog.c       |   10 ++--
 fetch.c                |    3 +-
 http-push.c            |    3 +-
 list-objects.c         |    3 +-
 merge-tree.c           |    9 ++--
 reachable.c            |    3 +-
 revision.c             |   12 ++---
 tree-diff.c            |   22 +++++----
 tree-walk.c            |  123 ++++++++++++++++++++++--------------------------
 tree-walk.h            |   20 ++++++--
 tree.c                 |   18 +++----
 unpack-trees.c         |    3 +-
 16 files changed, 125 insertions(+), 133 deletions(-)

I'm pretty sure this is all good, and it obviously passes all the tests, 
but more importantly none of the changes were really very complicated, and 
patch#2 (which is the big one) was set up so that the compiler would not 
even compile code that wasn't properly converted, so it should all be 
good.

			Linus
