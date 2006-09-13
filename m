From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 17:08:17 -0400
Message-ID: <20060913210817.GA30782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 13 23:08:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNby4-0007Vx-5j
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWIMVIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWIMVIV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:08:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:11501 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751192AbWIMVIV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 17:08:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNbxq-0004DY-Vt
	for git@vger.kernel.org; Wed, 13 Sep 2006 17:08:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 858C920E49A; Wed, 13 Sep 2006 17:08:17 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26946>

Any thoughts on something like the following?

I was talking with Jakub Narebski on #git today about using a
diff/apply pipeline as a merge strategy.

I was talking about implementing this within the merge-recur driver
as an alternative to invoking the RCS 'merge' program.  The idea
would be to take the current branch's file and try to apply the
diff of merge_base and the other branch to it.  If that has any
rejects then try the other direction (apply diff of merge_base and
current to other) and leave the user with whichever one resulted
in the smallest number of rejected lines.

But that's a little bit more work, this is a quick hack.  :-)  


-- >8 --
Create merge strategy 'applyreject'.

The applyreject merge strategy is a two head merge strategy which performs
the merge by obtaining the diff between the common base and the branch
being merged and applies it to the current branch using git-apply --reject.
Consequently any failures are written to .rej files, rather than using
the RCS <<<<<<< ======= >>>>>>> format.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore               |    1 +
 Makefile                 |    1 +
 git-merge-applyreject.sh |   26 ++++++++++++++++++++++++++
 git-merge.sh             |    2 +-
 4 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0d608fe..0f43ece 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,6 +56,7 @@ git-ls-tree
 git-mailinfo
 git-mailsplit
 git-merge
+git-merge-applyreject
 git-merge-base
 git-merge-index
 git-merge-tree
diff --git a/Makefile b/Makefile
index 7b3114f..a57dab5 100644
--- a/Makefile
+++ b/Makefile
@@ -161,6 +161,7 @@ SCRIPT_SH = \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
+	git-merge-applyreject.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
 	git-lost-found.sh git-quiltimport.sh
 
diff --git a/git-merge-applyreject.sh b/git-merge-applyreject.sh
new file mode 100755
index 0000000..e4c8703
--- /dev/null
+++ b/git-merge-applyreject.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+#
+# Simple merge strategy which produces reject files on failed merges.
+# Only handles two heads and one merge base, thus the command line
+# parameters must be:  base -- head1 head2
+
+base="$1"; shift; [ -z "$base" ] && exit 2
+while [ $# -gt 2 -a "X$1" != "X--" ]
+do
+	shift
+done
+if [ "X$1" = "X--" ]
+then
+	shift
+else
+	exit 2
+fi
+current="$1"; shift; [ -z "$current" ] && exit 2
+incoming="$1"; shift; [ -z "$incoming" ] && exit 2
+[ $# -gt 0 ] && exit 2
+
+git-read-tree --reset $current || exit 2
+git-update-index --refresh 2>/dev/null
+git-diff --binary -M $base $incoming \
+	| git-apply --index --reject --verbose
+[ $? = 0 ] || exit 1
diff --git a/git-merge.sh b/git-merge.sh
index d049e16..e39de0a 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -9,7 +9,7 @@ USAGE='[-n] [--no-commit] [--squash] [-s
 LF='
 '
 
-all_strategies='recursive recur octopus resolve stupid ours'
+all_strategies='recursive recur octopus resolve stupid ours applyreject'
 case "${GIT_USE_RECUR_FOR_RECURSIVE}" in
 '')
 	default_twohead_strategies=recursive ;;
-- 
1.4.2.gc52f
