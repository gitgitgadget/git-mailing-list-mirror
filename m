From: worley@alum.mit.edu (Dale R. Worley)
Subject: Difficulty adding a symbolic link, part 3
Date: Wed, 31 Jul 2013 16:29:04 -0400
Message-ID: <201307312029.r6VKT4vC023100@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 22:36:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4d89-00009O-C3
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 22:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab3GaUgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 16:36:17 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:48376
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752209Ab3GaUgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Jul 2013 16:36:16 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2013 16:36:16 EDT
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id 73Mo1m0080mv7h0588V6HJ; Wed, 31 Jul 2013 20:29:06 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id 78V61m0081KKtkw3X8V6Hw; Wed, 31 Jul 2013 20:29:06 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.5/8.14.5) with ESMTP id r6VKT5Y0023101;
	Wed, 31 Jul 2013 16:29:05 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.5/8.14.5/Submit) id r6VKT4vC023100;
	Wed, 31 Jul 2013 16:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375302546;
	bh=qWv++Shzm18dnO3/Q487onwfoe9hGp/bPyL0Pi1M9Ls=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=jULPZP/8kZ8P7MA0LgQ/HlAeucsFj7BkDuVU7Vccuo3LGxq/VmpKpjFFq5ZHPJYX2
	 36fLtNmZGWN4sunuGlSGLDTaVRSAhVMQe5mJAsZbcZISM5cOqj/BJpMEuzm6trTFgJ
	 mBLCA4hQKW9A538Do96ZPOqb/lYodMmUMUmAICYP6B4tRFk49LiBcPrvDoolzBo/Fy
	 kOdAl9KRhLwTTcru9bIt6AUMH7353YL9BkCyQ74OaOebvWP+ErUBby4xu2Xq1qLV8F
	 Hks2vWhuQEk7ZgQjSd5XJXKZn9/LdtOUI8F+fztH/fL0c3UPI4StXYVGJFqtzSdnmK
	 mTUCO0qyywiRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231455>

I've run into a problem (with Git 1.8.3.3) where I cannot add a
symbolic link (as such) to the repository *if* its path is given
absolutely; instead Git adds the file the symbolic link points to.
(If I give the path relatively, Git does what I expect, that is, adds
the symbolic link.)

I've written a test script that shows the problem and included it
below.

I would not expect *how* a path is presented to Git to change how Git
processes the path.  In the test case, I would expect "/bin/awk" and
"../../bin/awk" to produce the same effect when used as arguments to
"git add".

What is going on in the code is this:  In "git add", all paths are
normalized by the function prefix_path_gently() in abspath.c.  That
function removes symbolic links from the pathspec *only if* it is
absolute, as shown in the first few lines of the function:

 static char *prefix_path_gently(const char *prefix, int len, const char *path)
 {
	 const char *orig = path;
	 char *sanitized;
	 if (is_absolute_path(orig)) {
-	         const char *temp = real_path(path);
+	         const char *temp = absolute_path(path);
		 sanitized = xmalloc(len + strlen(temp) + 1);
		 strcpy(sanitized, temp);
	 } else {

real_path() is specified to remove symbolic links.  As shown, I've
replaced real_path() with absolute_path(), based on the comment at the
top of real_path():

/*
 * Return the real path (i.e., absolute path, with symlinks resolved
 * and extra slashes removed) equivalent to the specified path.  (If
 * you want an absolute path but don't mind links, use
 * absolute_path().)  The return value is a pointer to a static
 * buffer.
 *

If I replace real_path() with absolute_path() as shown, the problem I
am testing for disappears.

With the above change, the test suite runs with zero failures, so it
doesn't affect any common Git usage.

But I don't know enough about the internal architecture of Git to know
that my change is correct in all cases.  I'm almost certain that the
normalization process for pathspecs should *not* normalize a final
component that is a symbolic link.  But I would expect it would be
desirable to normalize non-final components that are symbolic links.
On the other hand, that might not matter.

Can someone give me advice on what this code *should* do?

I believe I can prepare a proper test for the test suite for this, so
once I know what the code change should be, I can prepare a proper
patch for it.

Dale
----------------------------------------------------------------------		
Here's a test case for adding a symbolic link.  This test exploits the
fact that on my system, /bin/awk is a symbolic link to "gawk".  As you
can see, the behavior of Git differs if the link's path is given to
"git add" as an absolute path or a relative path.

Here is the test script:
----------------------------------------------------------------------
#! /bin/bash

# Illustrates a problem with applying "git add" to a symbolic link.

set -x

# To be run from a directory one step below the root directory.  E.g.,
# "/tmp".
# On this system, /bin/awk is a symbolic link to "gawk", which
# means /tmp/gawk.

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
Here is sample output of the script:
----------------------------------------------------------------------
+ git version
git version 1.8.3.3.756.g07a2553.dirty
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

Dale
