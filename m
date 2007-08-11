From: David Kastrup <dak@gnu.org>
Subject: [PATCH] git-sh-setup.sh: make GIT_DIR absolute
Date: Sat, 11 Aug 2007 15:36:28 +0200
Organization: Organization?!?
Message-ID: <85r6maurab.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 15:36:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJr8x-0007YT-Lu
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 15:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbXHKNgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 09:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXHKNgc
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 09:36:32 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:50322 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751681AbXHKNgb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 09:36:31 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id C64273030FF
	for <git@vger.kernel.org>; Sat, 11 Aug 2007 15:36:29 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id B05EF13ED88
	for <git@vger.kernel.org>; Sat, 11 Aug 2007 15:36:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-066.pools.arcor-ip.net [84.61.49.66])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 894788C463
	for <git@vger.kernel.org>; Sat, 11 Aug 2007 15:36:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 17FE41C3C79D; Sat, 11 Aug 2007 15:36:29 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3923/Sat Aug 11 10:03:45 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55610>

Quite a few of the scripts are rather careless about using GIT_DIR
while changing directories.

Some try their hands (with different likelihood of success) in making
GIT_DIR absolute.

This patch lets git-sh-setup.sh cater for absolute directories (in a
way that should work reliably also with non-Unix path names) and
removes the respective kludges in git-filter-branch.sh and
git-instaweb.sh.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 git-filter-branch.sh |    7 -------
 git-instaweb.sh      |    8 +-------
 git-sh-setup.sh      |   12 +++++++++++-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index b5fa449..c42e451 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -170,13 +170,6 @@ do
 	esac
 done < "$tempdir"/backup-refs
 
-case "$GIT_DIR" in
-/*)
-	;;
-*)
-	GIT_DIR="$(pwd)/../../$GIT_DIR"
-	;;
-esac
 export GIT_DIR GIT_WORK_TREE=.
 
 # These refs should be updated if their heads were rewritten
diff --git a/git-instaweb.sh b/git-instaweb.sh
index cbc7418..b79c6b6 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -8,13 +8,7 @@ USAGE='[--start] [--stop] [--restart]
 
 . git-sh-setup
 
-case "$GIT_DIR" in
-/*)
-	fqgitdir="$GIT_DIR" ;;
-*)
-	fqgitdir="$PWD/$GIT_DIR" ;;
-esac
-
+fqgitdir="$GIT_DIR"
 local="`git config --bool --get instaweb.local`"
 httpd="`git config --get instaweb.httpd`"
 browser="`git config --get instaweb.browser`"
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 8cbd153..185c5c6 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -116,6 +116,16 @@ then
 		exit $exit
 	}
 else
-	GIT_DIR=$(git rev-parse --git-dir) || exit
+	GIT_DIR=$(git rev-parse --git-dir) || {
+	    exit=$?
+	    echo >&2 "Failed to find a valid git directory."
+	    exit $exit
+	}
 fi
+
+test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
+    echo >&2 "Unable to determine absolute path of git directory"
+    exit 1
+}
+
 : ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
-- 
1.5.3.rc2.187.g9a1d2-dirty
