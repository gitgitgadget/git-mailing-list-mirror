From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH 1/6] Add core.autocrlf=true on cygwin by default during tests
Date: Mon, 11 May 2009 15:28:56 -0400
Message-ID: <1242070141-2936-2-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:30:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bCF-0007Nk-FQ
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036AbZEKT3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757366AbZEKT3M
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:29:12 -0400
Received: from krl.krl.com ([192.147.32.3]:46835 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755085AbZEKT3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:29:09 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4BJT8b1002989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 May 2009 15:29:08 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4BJT8DF002988;
	Mon, 11 May 2009 15:29:08 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118829>

It can be disabled or enabled by using the GIT_TEST_AUTO_CRLF environment
variable.

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/test-lib.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index dad1437..218bd82 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -119,6 +119,17 @@ do
 	esac
 done
 
+# Switch to core.autolf = true on cygwin but only by default
+case $(uname -s) in
+*CYGWIN*)
+	GIT_TEST_AUTO_CRLF=${GIT_TEST_AUTO_CRLF:-true}
+	test "$debug" = "" ||
+	echo "Test in mode" $(cygpath --mode . | cut -d: -f2-) "mount"
+	;;
+*)
+	;;
+esac
+
 if test -n "$color"; then
 	say_color () {
 		(
@@ -493,6 +504,11 @@ test_create_repo () {
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
