From: worley@alum.mit.edu (Dale R. Worley)
Subject: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Wed, 16 Oct 2013 16:03:30 -0400
Message-ID: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 16 22:10:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWXQe-00070r-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 22:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761611Ab3JPUKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 16:10:40 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:35201
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761255Ab3JPUKi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Oct 2013 16:10:38 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2013 16:10:38 EDT
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id dnfa1m00216LCl056w3XDg; Wed, 16 Oct 2013 20:03:31 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id dw3X1m00H1KKtkw3Sw3XYM; Wed, 16 Oct 2013 20:03:31 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r9GK3UR0014415;
	Wed, 16 Oct 2013 16:03:30 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r9GK3UYj014414;
	Wed, 16 Oct 2013 16:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1381953811;
	bh=NbFQeoALF2M3B4cPfvm3ONX40jFtGqWdlfjCYh436UU=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=HaJPgHA6NV8OXVuHzrkCBphmi8V7YdYoePCpYQKHs9tixKqJ5JNyPY/xjRD2Z2D1M
	 8dx4IkgiK2Oij9cQsenIlPiXbPbR0tPqHhYUrXXnSnuGVVrmn6X3zkc5f5slIbf3S/
	 lcWv2nhZOTAwFpFtdHX2vkeoDutPrQczTMWSOA9oUgul2SOzRZNiAVJe5aiowtvj+q
	 3/OB4IJjH832x07aMgeUwVYHlLWbGV12q8I/OzphUrfGHMUI0bmgqdeWwkheCXzHXd
	 Ra39Meoryn2Jgi6whsaJgwIrbNhJTV/E3EFtuOHv9dbvdsD+NpFCUwRqSpDgJNHfU2
	 kNqyLAlwcqKPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236260>

In Git, one can set up a repository with a "detached worktree", where
the .git directory is not a subdirectory of the top directory of the
work tree.

In general, Git commands on a repository with a detached worktree can
be executed by cd'ing into the directory containing the .git
directory, and executing the Git command there.  E.g., "git add" and
"git commit" execute as one would expect.  (I think they can also be
executed by cd'ing to the worktree and setting GIT_DIR.)

However, this approach does not work with "git filter-branch", which
objects with "You need to run this command from the toplevel of the
working tree."

I suspect that it does not work with other Git commands that are
implemented with shell scripts.  The problem appears to be in the
git-sh-setup script, which is called by the Git shell scripts to set
up the environment and do preliminary tests.

It seems to me that this inconsistency between the script commands and
the binary commands can be fixed by updating git-sh-setup in this way:

--- git-sh-setup.Custom.orig	2013-06-20 12:59:45.000000000 -0400
+++ git-sh-setup	2013-10-07 22:34:06.719946134 -0400
@@ -297,14 +297,18 @@
 # if we require to be in a git repository.
 if test -z "$NONGIT_OK"
 then
-	GIT_DIR=$(git rev-parse --git-dir) || exit
+	export GIT_DIR=$(git rev-parse --git-dir) || exit
 	if [ -z "$SUBDIRECTORY_OK" ]
 	then
-		test -z "$(git rev-parse --show-cdup)" || {
-			exit=$?
-			echo >&2 "You need to run this command from the toplevel of the working tree."
-			exit $exit
-		}
+		cdup="$(git rev-parse --show-cdup)"
+		if [ -n "$cdup" ]
+		then
+			# Current directory is not the toplevel.
+			# Set GIT_DIR to the absolute path of the repository.
+			GIT_DIR=$(cd "$GIT_DIR" && pwd)
+			# cd to the toplevel.
+			cd $cdup
+		fi
 	fi
 	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
 		echo >&2 "Unable to determine absolute path of git directory"

What this change does is, when a command is invoked from a directory
containing a repository with a detached worktree, is to set GIT_DIR to
the directory of the repository, then cd to the top of the worktree.
After that, the script command should work as expected.

I am far from being an expert in Git internals, so I don't know
whether this is the correct approach to take to this problem or not.

Does anyone have any feedback on this?

Dale
