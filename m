From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Sun,  8 Apr 2012 21:36:54 -0400
Message-ID: <1333935414-10389-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 09 03:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SH3Xl-0002Xj-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 03:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043Ab2DIBhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 21:37:04 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:53396 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab2DIBhD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 21:37:03 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:48661 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SH3XR-00017Q-Dc; Sun, 08 Apr 2012 21:37:01 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SH3XR-0002i4-Cf; Sun, 08 Apr 2012 21:37:01 -0400
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195010>

The sed provided by Solaris in /usr/xpg4/bin has a bug whereby an
unanchored regex using * for zero or more repetitions sees two
separate matches fed to the substitution engine in some cases.

This is evidenced by:

$ for sed in /usr/xpg4/bin/sed /usr/bin/sed /opt/csw/gnu/sed; do \
echo 'ab' | $sed -e 's|[a]*|X|g'; \
done
XXbX
XbX
XbX

This bug was triggered during a git submodule clone operation as
exercised in the setup stage of t5526-fetch-submodules when using the
default SANE_TOOL_PATH for Solaris.  It led to paths such as
..../.. being used in the submodule .git gitdir reference.

Using the expression 's|\([^/]*\(/*\)\)|..\2|g' provides the desired
result with all three three tested sed implementations but is harder
to read.  Instead, use an additional -e script to clean up after the
bug on Solaris.  The second script will be a functional no-op on most
sed implementations.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-submodule.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index efc86ad..0adad22 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -167,10 +167,12 @@ module_clone()
 	a=${a%/}
 	b=${b%/}
 
-	rel=$(echo $b | sed -e 's|[^/]*|..|g')
+	# Note: The second -e is to work around a bug in Solairs'
+	# xpg4/sed.  It will be a no-op in a working implementation.
+	rel=$(echo $b | sed -e 's|[^/]*|..|g' -e 's|\.\{4\}|..|g')
 	echo "gitdir: $rel/$a" >"$path/.git"
 
-	rel=$(echo $a | sed -e 's|[^/]*|..|g')
+	rel=$(echo $a | sed -e 's|[^/]*|..|g' -e 's|\.\{4\}|..|g')
 	(clear_local_git_env; cd "$path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
 }
 
-- 
1.7.9
