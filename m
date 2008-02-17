From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/5] Fix setup of $GIT_DIR in git-sh-setup.sh
Date: Sun, 17 Feb 2008 23:14:13 +0100
Message-ID: <1203286456-26033-3-git-send-email-hjemli@gmail.com>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
 <1203286456-26033-2-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 23:17:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQros-0004RH-DS
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbYBQWQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754507AbYBQWQ3
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:16:29 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:36805 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228AbYBQWQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:16:28 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m1HMFTkq007281;
	Sun, 17 Feb 2008 23:15:32 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.gfde78
In-Reply-To: <1203286456-26033-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74195>

Since .git can be a file refering to the real GIT_DIR, git-sh-setup needs
to use 'git rev-parse --git-dir' to obtain the location of the git
repository.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-sh-setup.sh |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index f388275..a7dbce2 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -127,20 +127,18 @@ get_author_ident_from_commit () {
 # if we require to be in a git repository.
 if test -z "$NONGIT_OK"
 then
+	GIT_DIR=$(git rev-parse --git-dir) || {
+		exit=$?
+		echo >&2 "Failed to find a valid git directory."
+		exit $exit
+	}
 	if [ -z "$SUBDIRECTORY_OK" ]
 	then
-		: ${GIT_DIR=.git}
 		test -z "$(git rev-parse --show-cdup)" || {
 			exit=$?
 			echo >&2 "You need to run this command from the toplevel of the working tree."
 			exit $exit
 		}
-	else
-		GIT_DIR=$(git rev-parse --git-dir) || {
-		    exit=$?
-		    echo >&2 "Failed to find a valid git directory."
-		    exit $exit
-		}
 	fi
 	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
 		echo >&2 "Unable to determine absolute path of git directory"
-- 
1.5.4.1.188.gdfa6c
