From: worley@alum.mit.edu (Dale R. Worley)
Subject: Difficulty adding a symbolic link, part 2
Date: Mon, 24 Jun 2013 22:36:42 -0400
Message-ID: <201306250236.r5P2ag85022808@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 04:44:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrJEq-0001Ig-At
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 04:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102Ab3FYCnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 22:43:52 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:47804
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750784Ab3FYCnv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 22:43:51 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2013 22:43:51 EDT
Received: from omta09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id sSAR1l0040SCNGk5CScjTH; Tue, 25 Jun 2013 02:36:43 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta09.westchester.pa.mail.comcast.net with comcast
	id sScj1l00N1KKtkw3VScj8V; Tue, 25 Jun 2013 02:36:43 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.5/8.14.5) with ESMTP id r5P2agYD022809;
	Mon, 24 Jun 2013 22:36:42 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.5/8.14.5/Submit) id r5P2ag85022808;
	Mon, 24 Jun 2013 22:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372127803;
	bh=EQMao+FkJSGhoDTzZLbUzkrIBibeW5ls0OS62VbEw08=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=BCWurCXnqC0mVPPDWXSS3QAE729S4Nch7l8IKwJkxVg3RRAshBri6tA9SWlhNwiLl
	 DIPUw7UTkVW3Ck/rK2TtjyRTiTEBzJNoepcubaffiKTa025HxSXgbvBpRf4l36L7fd
	 uXW7hJPBf5pU2ny8Ia+d75k5EcLXwwunaaFeiUQ8fvziGma0OrGFEmKdimzKOHY8qU
	 LHqLkBYNUkoP9ykazfRRLjAtGzVmCZP59A3IVwGzS079Ffnk0zxADPIo/ifQR/1I+x
	 RvEoMjlQwD+0oavcpQNKp8sLORS/qbtH5G8rWQHJ+wXy2cUxMvysZ9zaCwvhPrLa1P
	 TYMvQilep9Auw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228941>

Here's a slightly simpler test case for adding a symbolic link.  This
test exploits the fact that on my system, /bin/awk is a symbolic link
to "gawk".  As you can see, the behavior of Git differs if the link's
path is given to "git add" as an absolute path or a relative path.

Here is the test script:
----------------------------------------------------------------------
#! /bin/bash

# Illustrates a problem with applying "git add" to a symbolic link.

set -x

# To be run from a directory one step below the root directory.  E.g.,
# "/git-add-link".
# Exploits the fact that /bin/awk is a symbolic link to "gawk".

# Show the Git version.
git version

# Make a test directory and cd to it.
DIR=temp.$$
mkdir $DIR
cd $DIR

# Create a Git repository.
git init
# Set the worktree to be /
git config core.worktree /
# Create an empty commit.
git commit --allow-empty -m Empty.

# Add the symbolic link using its absolute name.
ABSOLUTE=/bin/awk
ls -l $ABSOLUTE
git add $ABSOLUTE
# Notice that the target of the link is added, not the link itself.
git status -uno

# Reset the index.
git reset

# Add the symbolic link using its relative name.
# Remember that we are two directory levels below the root directory now.
RELATIVE=../..$ABSOLUTE
ls -l $RELATIVE
git add $RELATIVE
# Notice that now the link itself is added.
git status -uno
----------------------------------------------------------------------
Here is the output of the script:
----------------------------------------------------------------------
+ git version
git version 1.7.7.6
+ DIR=temp.22366
+ mkdir temp.22366
+ cd temp.22366
+ git init
Initialized empty Git repository in /git-add-link/temp.22366/.git/
+ git config core.worktree /
+ git commit --allow-empty -m Empty.
[master (root-commit) fb232e5] Empty.
+ ABSOLUTE=/bin/awk
+ ls -l /bin/awk
lrwxrwxrwx. 1 root root 4 Nov  2  2012 /bin/awk -> gawk
+ git add /bin/awk
+ git status -uno
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   ../../bin/gawk
#
# Untracked files not listed (use -u option to show untracked files)
+ git reset
+ RELATIVE=../../bin/awk
+ ls -l ../../bin/awk
lrwxrwxrwx. 1 root root 4 Nov  2  2012 ../../bin/awk -> gawk
+ git add ../../bin/awk
+ git status -uno
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   ../../bin/awk
#
# Untracked files not listed (use -u option to show untracked files)
----------------------------------------------------------------------
I can't see any principle of operation of Git that would cause "git
add /bin/awk" and "git add ../../bin/awk" to be handled differently.

Dale
