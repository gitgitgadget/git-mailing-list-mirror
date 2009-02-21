From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/5] Test contents of entire cvsimported "master" tree contents
Date: Sat, 21 Feb 2009 14:04:38 +0100
Message-ID: <cda1b6751447f990ca0e45e2e54f62ae9c53e6c1.1235220105.git.mhagger@alum.mit.edu>
References: <1235221480-31473-1-git-send-email-mhagger@alum.mit.edu>
 <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235220105.git.mhagger@alum.mit.edu>
 <7d834a5a7542df6bfa8963bb6440cc4b4531ead7.1235220105.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 14:06:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LarYu-00041j-GD
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 14:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZBUNFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 08:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbZBUNFG
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 08:05:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:57475 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZBUNFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 08:05:03 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1LD4fLF022313;
	Sat, 21 Feb 2009 14:04:43 +0100
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <7d834a5a7542df6bfa8963bb6440cc4b4531ead7.1235220105.git.mhagger@alum.mit.edu>
In-Reply-To: <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235220105.git.mhagger@alum.mit.edu>
References: <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235220105.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110946>

Test added for completeness (it passes).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/lib-cvs.sh         |   41 +++++++++++++++++++++++++++++++++++++++++
 t/t9600-cvsimport.sh |    2 ++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 6738901..47f0e55 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -32,3 +32,44 @@ case "$cvsps_version" in
 	exit
 	;;
 esac
+
+test_cvs_export () {
+	# Usage: test_cvs_export BRANCH_NAME
+	rm -rf module-cvs-"$1"
+	if [ "$1" = "master" ]
+	then
+		$CVS co -P -d module-cvs-"$1" -A module
+	else
+		$CVS co -P -d module-cvs-"$1" -r "$1" module
+	fi
+	# Remove the CVS directories to make directory comparisons
+	# easier:
+	find module-cvs-"$1" -type d -name CVS -exec rm -rf '{}' ';' -prune
+}
+
+test_git_co_branch () {
+	# Usage: test_git_co BRANCH_NAME
+	(cd module-git && git checkout "$1")
+}
+
+test_cmp_branch_tree () {
+	# Usage: test_cmp_branch_tree BRANCH_NAME
+	# Check BRANCH_NAME out of CVS and git and make sure that all
+	# of the files and directories are identical.
+
+	test_cvs_export "$1" &&
+	test_git_co_branch "$1" &&
+	(
+		cd module-cvs-"$1"
+		find . -type d -name CVS -prune -o -type f -print
+	) | sort >module-cvs-"$1".list &&
+	(
+		cd module-git
+		find . -type d -name .git -prune -o -type f -print
+	) | sort >module-git-"$1".list &&
+	test_cmp module-cvs-"$1".list module-git-"$1".list &&
+	cat module-cvs-"$1".list | while read f
+	do
+		test_cmp_branch_file "$1" "$f" || return 1
+	done
+}
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 3110a8c..e3734b3 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -121,4 +121,6 @@ test_expect_success 'import from a CVS working tree' '
 
 '
 
+test_expect_success 'test entire HEAD' 'test_cmp_branch_tree master'
+
 test_done
-- 
1.6.1.3
