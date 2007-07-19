From: Eric Lesh <eclesh@ucla.edu>
Subject: [PATCH guilt] Handles slashes in branch names
Date: Thu, 19 Jul 2007 11:35:11 -0700
Message-ID: <87y7hctf6o.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Joseph "Jeff" Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:32:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbjT-0000HM-KW
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933921AbXGSTcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbXGSTcK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:32:10 -0400
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:50543 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763551AbXGSTcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:32:09 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.157])
	by smtp-7.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6JIZF8J005284;
	Thu, 19 Jul 2007 11:35:15 -0700
Received: from localhost (adsl-75-26-187-235.dsl.scrm01.sbcglobal.net [75.26.187.235])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6JIZFWm004614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Jul 2007 11:35:15 -0700
Received: by localhost (Postfix, from userid 1000)
	id 9A6A21E8009; Thu, 19 Jul 2007 11:35:11 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53025>

When a branch name has a slash and autotagging is enabled, guilt barfs
when updating the stack tags.  Escape the branch name in the tags to
allow this to work.

Also allow guilt to create the patches directory for these branches.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt      |   15 +++++++++------
 guilt-init |    2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/guilt b/guilt
index 214def4..9e4789a 100755
--- a/guilt
+++ b/guilt
@@ -334,20 +334,23 @@ update_stack_tags()
 		return 0
 	fi
 
+        # handle branches with slashes
+        newbranch=`echo $branch | sed -e 's,\/,-,'`
+
 	if [ `wc -l < $applied` -gt 0 ]; then
 		# there are patches applied, therefore we must get the top,
 		# bottom and base hashes, and update the tags
 
-		git-rev-parse HEAD > "$GIT_DIR/refs/tags/${branch}_top"
-		head -1 < $applied | cut -d: -f1 > "$GIT_DIR/refs/tags/${branch}_bottom"
-		git-rev-parse $(head -1 < $applied | cut -d: -f1)^ > "$GIT_DIR/refs/tags/${branch}_base"
+		git-rev-parse HEAD > "$GIT_DIR/refs/tags/${newbranch}_top"
+		head -1 < $applied | cut -d: -f1 > "$GIT_DIR/refs/tags/${newbranch}_bottom"
+		git-rev-parse $(head -1 < $applied | cut -d: -f1)^ > "$GIT_DIR/refs/tags/${newbranch}_base"
 	else
 		# there are no patches applied, therefore we must remove the
 		# tags to old top, bottom, and base
 
-		rm -f "$GIT_DIR/refs/tags/${branch}_top"
-		rm -f "$GIT_DIR/refs/tags/${branch}_bottom"
-		rm -f "$GIT_DIR/refs/tags/${branch}_base"
+		rm -f "$GIT_DIR/refs/tags/${newbranch}_top"
+		rm -f "$GIT_DIR/refs/tags/${newbranch}_bottom"
+		rm -f "$GIT_DIR/refs/tags/${newbranch}_base"
 	fi
 }
 
diff --git a/guilt-init b/guilt-init
index ffe2434..9136f89 100755
--- a/guilt-init
+++ b/guilt-init
@@ -24,7 +24,7 @@ if [ -d "$GUILT_DIR/$branch" ]; then
 fi
 
 [ ! -d "$GUILT_DIR" ] && mkdir $GUILT_DIR
-mkdir $GUILT_DIR/$branch
+mkdir -p $GUILT_DIR/$branch
 touch $GUILT_DIR/$branch/series
 touch $GUILT_DIR/$branch/status
 
-- 
1.5.2
