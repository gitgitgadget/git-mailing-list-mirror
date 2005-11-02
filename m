X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add 'ours' merge strategy.
Date: Tue, 01 Nov 2005 21:37:30 -0800
Message-ID: <7vll071ug5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 2 Nov 2005 05:38:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1EXBJW-0007n1-O2 for gcvg-git@gmane.org; Wed, 02 Nov
 2005 06:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932308AbVKBFhc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 2 Nov 2005
 00:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVKBFhc
 (ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 00:37:32 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12438 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1751510AbVKBFhb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 00:37:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127]) by
 fed1rmmtao11.cox.net (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with
 ESMTP id
 <20051102053708.CBKL9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>; Wed,
 2 Nov 2005 00:37:08 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This adds the coolest merge strategy ever, "ours".  It can take
arbitrary number of foreign heads and merge them into the
current branch, with the resulting tree always taken from our
branch head, hence its name.

What this means is that you can declare that the current branch
supersedes the development histories of other branches usnig
this merge strategy.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 This can be used to terminate an old maintenance branch without
 leaving people's repositories behind.  The old 0.99.8[a-z]
 lettered releases were done from a maintenance branch that
 forked off from the master branch at 0.99.8.  The maintenance
 branch for 0.99.9 has the tip of the last 0.99.8 maintenance
 commit as one of the ancestors, as well as 0.99.9 commit, while
 content-wise it forks off purely from 0.99.9.

 I could have done the current maint branch like this,
 immediately after 0.99.9:

  $ git commit -m 'GIT 0.99.9'
  $ git checkout -b newmaint
  $ git pull -s ours . maint ;# still 0.99.8 maintenance
  $ git checkout maint
  $ git reset --hard newmaint ;# now based on both old maint and 0.99.9
  $ git branch -d newmaint

 .gitignore        |    1 +
 Makefile          |    2 +-
 git-merge-ours.sh |    7 +++++++
 git-merge.sh      |    2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)
 create mode 100755 git-merge-ours.sh

applies-to: 9e58de65fa92cce061c8c4064141bc91856097ed
38431c13669432dfeac16a9142aff5a293331e9d
diff --git a/.gitignore b/.gitignore
index 927c89c..3edf6b4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@ git-merge-base
 git-merge-index
 git-merge-octopus
 git-merge-one-file
+git-merge-ours
 git-merge-recursive
 git-merge-resolve
 git-merge-stupid
diff --git a/Makefile b/Makefile
index 357cb3e..bda829e 100644
--- a/Makefile
+++ b/Makefile
@@ -89,7 +89,7 @@ SCRIPT_SH = \
 	git-tag.sh git-verify-tag.sh git-whatchanged.sh git.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
-	git-merge-resolve.sh git-grep.sh
+	git-merge-resolve.sh git-merge-ours.sh git-grep.sh
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-merge-ours.sh b/git-merge-ours.sh
new file mode 100755
index 0000000..a64704f
--- /dev/null
+++ b/git-merge-ours.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+# Pretend we resolved the heads, but declare our tree trumps everybody else.
+#
+exit 0
diff --git a/git-merge.sh b/git-merge.sh
index dd104db..b810fce 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -14,7 +14,7 @@ usage () {
 
 # all_strategies='resolve recursive stupid octopus'
 
-all_strategies='recursive octopus resolve stupid'
+all_strategies='recursive octopus resolve stupid ours'
 default_strategies='resolve octopus'
 use_strategies=
 
---
0.99.9.GIT

