From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: [OT] ancestor branch in cvsps is wrong for branch-of-branch
Date: Mon, 31 Oct 2005 22:51:48 -0500
Message-ID: <20051101035148.GA11807@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 04:52:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWnBo-0001fj-Ek
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 04:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVKADvu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 22:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVKADvu
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 22:51:50 -0500
Received: from eastrmmtao06.cox.net ([68.230.240.33]:22919 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932357AbVKADvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 22:51:50 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051101035055.ITIA21663.eastrmmtao06.cox.net@localhost>;
          Mon, 31 Oct 2005 22:50:55 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1EWnBd-00038X-0w; Mon, 31 Oct 2005 22:51:49 -0500
To: cvsps@dm.cobite.com, David Mansfield <david@cobite.com>
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10924>

[ Maybe the git list is interested in a problem with cvsps? ]

Summary: When creating a patchset for the first modification in a
branch-off-a-branch, cvsps (version 2.1) declares that the ancestor
branch is HEAD.  Presumably this is because the file in the patchset
hadn't been modified since it was on HEAD.  But this means that files
that are *added* to the first branch are never counted as added to the
branch-off-a-branch.

Figure:

-HEAD-(add file 'a')--+-------------------------
                       \
                        \-stable-(add file 'b')-+
                                                 \
                                                  \-dev-(change 'a')-->

In CVS, branch "dev" clearly contains both 'a' and 'b'.  But cvsps
makes it look like this:

                        /-dev-(change 'a') ---->
                       /
-HEAD-(add file 'a')--+-------------------------
                       \
                        \-stable-(add file 'b')---->

So that in the imported git repository, the "dev" branch contains ONLY
'a'.

Below are: a script to reproduce this example, the cvs log output, and
cvsps output.  It's clear from the cvs log that 'b' has the 'dev'
symbolic tag, so it seems like we should be able to recreate 'dev'.

Before I look into fixing this, I wanted to see if there were any
comments from the list.  David?

-chris

#!/bin/sh
dirname=`date +"%Y%m%d%H%M%S"`
mkdir $dirname && cd $dirname

# create the repository
mkdir cvsroot && cd cvsroot
export CVSROOT=`pwd`
cd ..
cvs init

# import an empty project
mkdir project && cd project
cvs import -m "Create initial repo" project yoyo start
cd ..
rmdir project

# checkout the project
cvs co project && cd project

# create a new file on HEAD
echo 1 >a
cvs add a
cvs ci -m "added file a to HEAD" a

# create and switch to "stable" branch
cvs tag -b stable
cvs update -r stable 

# add a new file to stable branch
echo 2 > b
cvs add b
cvs ci -m "added file b to 'stable' branch" b

# create and switch to "dev" branch from "stable"
cvs tag -b dev
cvs update -r dev

# modify file 'a' on "dev" branch
echo "change" >> a
cvs ci -m "changed file a on dev branch" a

# see what CVS thinks the "dev" branch looks like
cd ..
rm -rf project
cvs checkout -r dev project
ls project && echo "Note how b is PRESENT"

# check output of cvsps
cd project
cvs log > ../cvslog
cd ..
cvsps -A --test-log cvslog project > cvsps.out

# check behavior of git-cvsimport
git-cvsimport -i -d $CVSROOT -C project.git project
cd project.git
git-checkout -f dev
ls && echo "Note how b is ABSENT!"
#***********EOF*********************

cvsps output
---------------------
PatchSet 1 
Date: 2005/10/31 22:30:46
Author: chris
Branch: HEAD
Tag: (none) 
Log:
added file a to HEAD

Members: 
	a:INITIAL->1.1 

---------------------
PatchSet 2 
Date: 2005/10/31 22:30:47
Author: chris
Branch: stable
Ancestor branch: HEAD
Tag: (none) 
Log:
added file b to 'stable' branch

Members: 
	b:1.1->1.1.2.1 

---------------------
PatchSet 3 
Date: 2005/10/31 22:30:48
Author: chris
Branch: dev
Ancestor branch: HEAD
Tag: (none) 
Log:
changed file a on dev branch

Members: 
	a:1.1->1.1.4.1 

******************EOF*********
cvs log output
RCS file: /home/chris/import/20051031223046/cvsroot/project/a,v
Working file: a
head: 1.1
branch:
locks: strict
access list:
symbolic names:
	dev: 1.1.0.4
	stable: 1.1.0.2
keyword substitution: kv
total revisions: 2;	selected revisions: 2
description:
----------------------------
revision 1.1
date: 2005/11/01 03:30:46;  author: chris;  state: Exp;
branches:  1.1.4;
added file a to HEAD
----------------------------
revision 1.1.4.1
date: 2005/11/01 03:30:48;  author: chris;  state: Exp;  lines: +1 -0
changed file a on dev branch
=============================================================================

RCS file: /home/chris/import/20051031223046/cvsroot/project/Attic/b,v
Working file: b
head: 1.1
branch:
locks: strict
access list:
symbolic names:
	dev: 1.1.2.1.0.2
	stable: 1.1.0.2
keyword substitution: kv
total revisions: 2;	selected revisions: 2
description:
----------------------------
revision 1.1
date: 2005/11/01 03:30:47;  author: chris;  state: dead;
branches:  1.1.2;
file b was initially added on branch stable.
----------------------------
revision 1.1.2.1
date: 2005/11/01 03:30:47;  author: chris;  state: Exp;  lines: +1 -0
added file b to 'stable' branch
=============================================================================
