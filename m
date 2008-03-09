From: Iustin Pop <iusty@k1024.org>
Subject: [PATCH] Add a quiet option to git merge
Date: Sun, 9 Mar 2008 13:18:22 +0100
Message-ID: <20080309121822.GA25890@teal.hq.k1024.org>
References: <1205020356-6682-2-git-send-email-iusty@k1024.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 13:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYKUm-0001wo-9R
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 13:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbYCIMS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 08:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbYCIMS3
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 08:18:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:58911 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYCIMS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 08:18:28 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1500769fga.17
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 05:18:26 -0700 (PDT)
Received: by 10.82.115.8 with SMTP id n8mr9553353buc.28.1205065106197;
        Sun, 09 Mar 2008 05:18:26 -0700 (PDT)
Received: from teal.hq.k1024.org ( [84.75.117.152])
        by mx.google.com with ESMTPS id w5sm23536905mue.2.2008.03.09.05.18.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Mar 2008 05:18:24 -0700 (PDT)
Received: by teal.hq.k1024.org (Postfix, from userid 4004)
	id 1AD5140A051; Sun,  9 Mar 2008 13:18:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1205020356-6682-2-git-send-email-iusty@k1024.org>
X-Linux: This message was written on Linux
X-Header: /usr/include gives great headers
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76655>

Currently it's not possible to do quiet merges in case of no changes
because git merge always outputs the 'Already up to date' message.

This small patch adds a quiet option to git merge that in this case will
skip the output of this message. It also adds a test for this new
option.

Signed-off-by: Iustin Pop <iusty@k1024.org>
---
 This new version has a test too for this option but I'm not sure if
 it's the right place to add it.

 Documentation/git-merge.txt     |    2 +-
 Documentation/merge-options.txt |    4 ++++
 git-merge.sh                    |   19 +++++++++++++------
 t/t7600-merge.sh                |    5 +++++
 4 files changed, 23 insertions(+), 7 deletions(-)

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
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5d16628..cb7e2e4 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -247,6 +247,11 @@ test_expect_success 'test option parsing' '
 	then
 		echo "[OOPS] missing commit references accepted"
 		false
+	fi &&
+	if ! git merge --quiet c1
+	then
+		echo "[OOPS] quiet not accepted"
+		false
 	fi
 '
 
-- 
1.5.4.3
