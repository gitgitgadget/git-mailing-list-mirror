From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH v2 1/7] Add GIT_TEST_AUTO_CRLF environment variable to set core.autocrlf on init
Date: Wed, 13 May 2009 15:35:42 -0400
Message-ID: <1242243348-6690-2-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 21:36:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KFb-0005kd-Gr
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbZEMTgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZEMTgG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:36:06 -0400
Received: from krl.krl.com ([192.147.32.3]:59285 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbZEMTgF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:36:05 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4DJa2vf006787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 15:36:02 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4DJa2f7006786;
	Wed, 13 May 2009 15:36:02 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119092>

Normal usage:

GIT_TEST_AUTO_CRLF=true make test

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/test-lib.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index dad1437..6178e8c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -59,7 +59,12 @@ export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
-GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
+
+if test ! -z $GIT_TEST_AUTO_CRLF && test $GIT_TEST_AUTO_CRLF = true; then
+	GIT_TEST_CMP=${GIT_TEST_CMP:-diff -uw}
+else
+	GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
+fi
 
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
@@ -493,6 +498,11 @@ test_create_repo () {
 	cd "$repo" || error "Cannot setup test environment"
 	"$GIT_EXEC_PATH/git-init" "--template=$TEST_DIRECTORY/../templates/blt/" >&3 2>&4 ||
 	error "cannot run git init -- have you built things yet?"
+	test ! -z "$GIT_TEST_AUTO_CRLF" &&
+	test_debug "echo Switching to autocrlf=$GIT_TEST_AUTO_CRLF" && {
+		git config core.autocrlf $GIT_TEST_AUTO_CRLF ||
+		error "Failed to switch to autocrlf=$GIT_TEST_AUTO_CRLF"
+	}
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
 }
-- 
1.6.3.15.g49878
