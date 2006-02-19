From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Keep Porcelainish from failing by broken ident after making changes.
Date: Sat, 18 Feb 2006 20:59:17 -0800
Message-ID: <7v1wy0lza2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 19 05:59:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAgfJ-0004Ky-PX
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 05:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWBSE7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 23:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWBSE7T
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 23:59:19 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:26508 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750902AbWBSE7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 23:59:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060219045923.KMPG25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 23:59:23 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16424>

"empty ident not allowed" error makes commit-tree fail, so we
are already safer in that we would not end up with commit
objects that have bogus names on the author or committer fields.
However, before commit-tree is called there are already changes
made to the index file and the working tree.  The operation can
be resumed after fixing the environment problem, but when this
triggers to a newcomer with unusable gecos, the first question
becomes "what did I lose and how would I recover".

This patch modifies some Porcelainish commands to verify
GIT_COMMITTER_IDENT as soon as we know we are going to make some
commits before doing much damage to prevent confusion.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is a follow-up on the previous "delay empty ident" error
   one.  "git pull random-place" otherwise would confuse and
   scare new users, even though what it leaves would often be a
   perfectly fine committable state.

 git-am.sh        |    4 +++-
 git-applymbox.sh |    2 ++
 git-merge.sh     |    5 +++++
 git-resolve.sh   |    3 +++
 4 files changed, 13 insertions(+), 1 deletions(-)

e3b59a44f6705896db80965427a7cf9e2112634b
diff --git a/git-am.sh b/git-am.sh
index 98b9215..85ecada 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -1,11 +1,13 @@
 #!/bin/sh
 #
-#
+# Copyright (c) 2005, 2006 Junio C Hamano
 
 USAGE='[--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way] <mbox>
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
 
+git var GIT_COMMITTER_IDENT >/dev/null || exit
+
 stop_here () {
     echo "$1" >"$dotest/next"
     exit 1
diff --git a/git-applymbox.sh b/git-applymbox.sh
index 61c8c02..5569fdc 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -21,6 +21,8 @@
 USAGE='[-u] [-k] [-q] [-m] (-c .dotest/<num> | mbox) [signoff]'
 . git-sh-setup
 
+git var GIT_COMMITTER_IDENT >/dev/null || exit
+
 keep_subject= query_apply= continue= utf8= resume=t
 while case "$#" in 0) break ;; esac
 do
diff --git a/git-merge.sh b/git-merge.sh
index 74f0761..2b4a603 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -142,6 +142,8 @@ case "$#,$common,$no_commit" in
 1,*,)
 	# We are not doing octopus, not fast forward, and have only
 	# one common.  See if it is really trivial.
+	git var GIT_COMMITTER_IDENT >/dev/null || exit
+
 	echo "Trying really trivial in-index merge..."
 	git-update-index --refresh 2>/dev/null
 	if git-read-tree --trivial -m -u $common $head "$1" &&
@@ -179,6 +181,9 @@ case "$#,$common,$no_commit" in
 	;;
 esac
 
+# We are going to make a new commit.
+git var GIT_COMMITTER_IDENT >/dev/null || exit
+
 case "$use_strategies" in
 '')
 	case "$#" in
diff --git a/git-resolve.sh b/git-resolve.sh
index 9263070..b53ede8 100755
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -50,6 +50,9 @@ case "$common" in
 	;;
 esac
 
+# We are going to make a new commit.
+git var GIT_COMMITTER_IDENT >/dev/null || exit
+
 # Find an optimum merge base if there are more than one candidates.
 LF='
 '
-- 
1.2.1.g2902
