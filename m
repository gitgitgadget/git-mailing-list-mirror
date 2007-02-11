From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] Use patch file's modtime as the git author and commiter date
Date: Sun, 11 Feb 2007 18:24:35 -0500
Message-ID: <11712362751442-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Mon Feb 12 01:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOse-00066y-D1
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 01:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbXBLARK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 19:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbXBLARJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 19:17:09 -0500
Received: from thunk.org ([69.25.196.29]:36699 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbXBLARI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 19:17:08 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HGOxe-0008FN-3I; Sun, 11 Feb 2007 19:22:26 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HGO3f-0001DK-QL; Sun, 11 Feb 2007 18:24:35 -0500
X-Mailer: git-send-email 1.5.0.rc4.2.g4249
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39343>

By using the same author and committer date, it keeps the git commit
id's stable if the patches haven't changed.  Otherwise, repeated
invocations of "guilt pop -a; guilt push -a" will create new commit's
with different commit dates, creating a lot of garbage commits that
won't disappear for a LONG time, even after running "git-gc --prune",
thanks to the reflog in git 1.5.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 guilt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/guilt b/guilt
index ced441b..7cb52c4 100755
--- a/guilt
+++ b/guilt
@@ -248,6 +248,10 @@ function push_patch
 
 		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 	fi
+	local backup_author_date="$GIT_AUTHOR_DATE"
+	local backup_committer_date="$GIT_COMMITTER_DATE"
+	export GIT_AUTHOR_DATE=`stat -c %y $p`
+	export GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE
 
 	# commit
 	local treeish=`git-write-tree`
@@ -271,6 +275,16 @@ function push_patch
 			unset GIT_AUTHOR_EMAIL
 		fi
 	fi
+	if [ ! -z "$backup_author_date" ]; then
+		export GIT_AUTHOR_DATE="$backup_author_date"
+	else
+		unset GIT_AUTHOR_DATE
+	fi
+		if [ ! -z "$backup_committer_date" ]; then
+		export GIT_COMMITTER_DATE="$backup_committer_date"
+	else
+		unset GIT_COMMITTER_DATE
+	fi
 
 	rm -f /tmp/guilt.msg.$$ /tmp/guilt.log.$$
 
-- 
1.5.0.rc4.2.g4249
