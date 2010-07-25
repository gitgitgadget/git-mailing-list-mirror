From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH ab/i18n v2] tests: locate i18n lib&data correctly under --valgrind
Date: Sun, 25 Jul 2010 16:55:46 +0200
Message-ID: <06b6dd297e87a92e1c9000f5998e7bc955933235.1280069635.git.trast@student.ethz.ch>
References: <201007251515.08916.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 16:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2ck-0007MA-88
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0GYO4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 10:56:10 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:30266 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab0GYO4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:56:09 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 16:56:07 +0200
Received: from localhost.localdomain (217.162.250.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 16:55:46 +0200
X-Mailer: git-send-email 1.7.2.289.g93c76
In-Reply-To: <201007251515.08916.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151753>

The new t020[01] for gettext support did not find git-sh-i18n and the
translation data when run under --valgrind: lib-gettext.sh tried to
locate them under $GIT_EXEC_PATH, which normally is the git build
directory, but is changed by --valgrind to point to the wrappers.

Introduce a new variable $GIT_BUILD_DIR which can be used to locate
data that resides under the build directory, and use that instead.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This approach fixes both problems in one go.

 t/lib-gettext.sh |    6 +++---
 t/test-lib.sh    |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 831ee38..f0cdd3d 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -5,11 +5,11 @@
 
 . ./test-lib.sh
 
-GIT_TEXTDOMAINDIR="$GIT_EXEC_PATH/share/locale"
-GIT_PO_PATH="$GIT_EXEC_PATH/po"
+GIT_TEXTDOMAINDIR="$GIT_BUILD_DIR/share/locale"
+GIT_PO_PATH="$GIT_BUILD_DIR/po"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
-. "$GIT_EXEC_PATH"/git-sh-i18n
+. "$GIT_BUILD_DIR"/git-sh-i18n
 
 if test_have_prereq GETTEXT
 then
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4ae0de8..08e5438 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -768,6 +768,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 		PATH="$TEST_DIRECTORY/..:$PATH"
 	fi
 fi
+GIT_BUILD_DIR=$(pwd)/..
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
-- 
1.7.2.289.g93c76
