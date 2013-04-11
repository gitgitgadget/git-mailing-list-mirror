From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] t9903: Don't fail when run from path accessed through
 symlink
Date: Thu, 11 Apr 2013 20:53:22 +0200
Message-ID: <20130411185322.GF14619@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: szeder@ira.uka.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 21:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMvY-00064K-Iq
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 21:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab3DKTMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 15:12:52 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:51309 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3DKTMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 15:12:51 -0400
X-Greylist: delayed 1163 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2013 15:12:51 EDT
Received: from horisont.pvv.ntnu.no ([129.241.210.175] ident=Debian-exim)
	by microbel.pvv.ntnu.no with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1UQMcd-0003p2-4C; Thu, 11 Apr 2013 20:53:26 +0200
Received: from torstehe by horisont.pvv.ntnu.no with local (Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1UQMcc-0004k0-SR; Thu, 11 Apr 2013 20:53:22 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220917>

When the git directory is accessed through a symlink like

  ln -s /tmp/git /tmp/git-symlink
  cd /tmp/git-symlink/t
  make -C .. && ./t9903-bash-prompt.sh

$TRASH_DIRECTORY is /tmp/git-symlink/t/trash directory.t9903-bash-prompt
and $(pwd -P) is /tmp/git/t/trash directory.t9903-bash-prompt.

When __gitdir looks up the path through 'git rev-parse --git-dir', it
will return paths similar to $(pwd -P). This behavior is already tested in
t9903 'gitdir - resulting path avoids symlinks'.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
 t/t9903-bash-prompt.sh |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 2101d91..e147a8d 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -59,7 +59,7 @@ test_expect_success 'gitdir - .git directory in cwd' '
 '
 
 test_expect_success 'gitdir - .git directory in parent' '
-	echo "$TRASH_DIRECTORY/.git" > expected &&
+	echo "$(pwd -P)/.git" > expected &&
 	(
 		cd subdir/subsubdir &&
 		__gitdir > "$actual"
@@ -77,7 +77,7 @@ test_expect_success 'gitdir - cwd is a .git directory' '
 '
 
 test_expect_success 'gitdir - parent is a .git directory' '
-	echo "$TRASH_DIRECTORY/.git" > expected &&
+	echo "$(pwd -P)/.git" > expected &&
 	(
 		cd .git/refs/heads &&
 		__gitdir > "$actual"
@@ -115,7 +115,7 @@ test_expect_success 'gitdir - non-existing $GIT_DIR' '
 '
 
 test_expect_success 'gitdir - gitfile in cwd' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$(pwd -P)/otherrepo/.git" > expected &&
 	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
@@ -126,7 +126,7 @@ test_expect_success 'gitdir - gitfile in cwd' '
 '
 
 test_expect_success 'gitdir - gitfile in parent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$(pwd -P)/otherrepo/.git" > expected &&
 	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
@@ -137,7 +137,7 @@ test_expect_success 'gitdir - gitfile in parent' '
 '
 
 test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$(pwd -P)/otherrepo/.git" > expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
 	ln -s otherrepo/dir link &&
-- 
1.7.10.4
