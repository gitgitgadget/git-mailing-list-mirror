From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 24/40] Windows: Work around incompatible sort and find.
Date: Wed, 27 Feb 2008 19:54:47 +0100
Message-ID: <1204138503-6126-25-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVQ-00022R-Cl
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbYB0Szs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbYB0Szr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:47 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40452 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbYB0SzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 455DD97711;
	Wed, 27 Feb 2008 19:55:08 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75263>

If the PATH lists the Windows system directories before the MSYS
directories, Windows's own incompatible sort and find commands would be
picked up. We implement these commands as functions and call the real
tools by absolute path.

Also add a dummy implementation of sync to avoid an error in git-repack.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-clone.sh    |    4 ++++
 git-sh-setup.sh |   17 +++++++++++++++++
 t/test-lib.sh   |   13 +++++++++++++
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 640e29d..1fc5c92 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -35,6 +35,10 @@ die() {
 # Fix some commands on Windows
 case $(uname -s) in
 *MINGW*)
+	# Windows has its own (incompatible) find
+	find () {
+		/usr/bin/find "$@"
+	}
 	# pwd must return a path with a drive letter
 	bin_pwd() {
 		# there are no symlinks to resolve: /bin/pwd is not needed
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index a44b1c7..822aa6f 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -142,3 +142,20 @@ then
 	}
 	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
 fi
+
+# Fix some commands on Windows
+case $(uname -s) in
+*MINGW*)
+	# Windows has its own (incompatible) sort and find
+	sort () {
+		/usr/bin/sort "$@"
+	}
+	find () {
+		/usr/bin/find "$@"
+	}
+	# sync is missing
+	sync () {
+		:	# no implementation
+	}
+	;;
+esac
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 83889c4..e2010d5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -366,3 +366,16 @@ do
 		test_done
 	esac
 done
+
+# Fix some commands on Windows
+case $(uname -s) in
+*MINGW*)
+	# Windows has its own (incompatible) sort and find
+	sort () {
+		/usr/bin/sort "$@"
+	}
+	find () {
+		/usr/bin/find "$@"
+	}
+	;;
+esac
-- 
1.5.4.1.126.ge5a7d
