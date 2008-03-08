From: Iustin Pop <iusty@k1024.org>
Subject: [PATCH 1/2] Add a quiet option to git merge
Date: Sun,  9 Mar 2008 00:52:35 +0100
Message-ID: <1205020356-6682-2-git-send-email-iusty@k1024.org>
References: <1205020356-6682-1-git-send-email-iusty@k1024.org>
Cc: Iustin Pop <iusty@k1024.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 00:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8qv-0005gC-St
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYCHXwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYCHXwo
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:52:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:13903 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbYCHXwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:52:43 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1247761fga.17
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 15:52:41 -0800 (PST)
Received: by 10.82.116.15 with SMTP id o15mr7912803buc.11.1205020360916;
        Sat, 08 Mar 2008 15:52:40 -0800 (PST)
Received: from teal.hq.k1024.org ( [84.75.117.152])
        by mx.google.com with ESMTPS id j9sm21262021mue.6.2008.03.08.15.52.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 15:52:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by teal.hq.k1024.org (Postfix) with ESMTP id CD4B740C817;
	Sun,  9 Mar 2008 00:52:36 +0100 (CET)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1205020356-6682-1-git-send-email-iusty@k1024.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76625>

Currently it's not possible to do quiet merges in case of no changes
because git merge always outputs the 'Already up to date' message.

This small patch adds a quiet option to git merge that in this case will
skip the output of this message.
---
 Documentation/git-merge.txt     |    2 +-
 Documentation/merge-options.txt |    4 ++++
 git-merge.sh                    |   19 +++++++++++++------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c136b10..0c4cd19 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,7 +9,7 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git-merge' [-n] [--summary] [--no-commit] [--squash] [-s <strategy>]...
+'git-merge' [-n] [-q] [--summary] [--no-commit] [--squash] [-s <strategy>]...
 	[-m <msg>] <remote> <remote>...
 'git-merge' <msg> HEAD <remote>...
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 9f1fc82..dbedf40 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -5,6 +5,10 @@
 -n, \--no-summary::
 	Do not show diffstat at the end of the merge.
 
+-q, \--quiet::
+	Supress the 'Already up to date' message if no merge is
+	needed.
+
 --no-commit::
 	Perform the merge but pretend the merge failed and do
 	not autocommit, to give the user a chance to inspect and
diff --git a/git-merge.sh b/git-merge.sh
index 7dbbb1d..625457e 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -15,6 +15,7 @@ commit               perform a commit if the merge sucesses (default)
 ff                   allow fast forward (default)
 s,strategy=          merge strategy to use
 m,message=           message to be used for the merge commit (if any)
+q,quiet              suppress some default messages
 "
 
 SUBDIRECTORY_OK=Yes
@@ -38,6 +39,7 @@ use_strategies=
 allow_fast_forward=t
 allow_trivial_merge=t
 squash= no_commit=
+quiet=
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
@@ -59,12 +61,15 @@ restorestate() {
 }
 
 finish_up_to_date () {
-	case "$squash" in
-	t)
-		echo "$1 (nothing to squash)" ;;
-	'')
-		echo "$1" ;;
-	esac
+	if test -z "$quiet"
+	then
+		case "$squash" in
+		t)
+			echo "$1 (nothing to squash)" ;;
+		'')
+			echo "$1" ;;
+		esac
+	fi
 	dropsave
 }
 
@@ -182,6 +187,8 @@ parse_config () {
 			merge_msg="$1"
 			have_message=t
 			;;
+		-q|--quiet)
+			quiet=t ;;
 		--)
 			shift
 			break ;;
-- 
1.5.4.3

