From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/7] t554[01]-http-push: refactor, add non-ff tests
Date: Sun, 21 Feb 2010 11:08:23 +0800
Message-ID: <1266721708-1060-3-git-send-email-rctay89@gmail.com>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:59:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2Bp-0004jO-3c
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757104Ab0BUDIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:08:47 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:49688 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059Ab0BUDIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:08:46 -0500
Received: by qw-out-2122.google.com with SMTP id 8so262931qwh.37
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 19:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dQpvIPNx1zTSw1zjer/ZsPHbWoywL2Htg5x8xptCmpc=;
        b=V+QibmQi9I1iTtUvcDspgIdah/71zopilieX9YruVgKU96aY+3ZtQpIhsqDyhxiE8D
         UjYeABz7ckBUUZR6eJDLNca8hiCgbOVcORXxY4znYvd2Oro6lsW1/N+1alH3Yf2PaTS5
         QA8alhWOa7iqWUT9mJXzSX15gU1NwsMu7V0NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qWjed0fTQ6+9x/QvD/MsDD3TckcXQzUFZIcORBdaY54GnCEvagMtX8lesPv5dvbu7m
         mt76pG/mnH9V3xiAV6cmgcLbzqATWtigG3YZe/9gJu37a6Uzz2ffuInq3WgVfSujCnAZ
         AHJZ0xM3SnRE9Qqil4fNHOD94YUztiJUDTcpE=
Received: by 10.224.59.224 with SMTP id m32mr150970qah.76.1266721725557;
        Sat, 20 Feb 2010 19:08:45 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 22sm1412717qyk.14.2010.02.20.19.08.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 19:08:45 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140589>

Move non-fast forward tests to lib-httpd.sh so that we don't have to
duplicate the tests in both t5540 and t5541.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/lib-httpd.sh       |   29 +++++++++++++++++++++++++++++
 t/t5540-http-push.sh |    3 +++
 t/t5541-http-push.sh |   24 ++----------------------
 3 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 28aff88..da4b8d5 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -131,3 +131,32 @@ stop_httpd() {
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
 }
+
+test_http_push_nonff() {
+	REMOTE_REPO=$1
+	LOCAL_REPO=$2
+	BRANCH=$3
+
+	test_expect_success 'non-fast-forward push fails' '
+		cd "$REMOTE_REPO" &&
+		HEAD=$(git rev-parse --verify HEAD) &&
+
+		cd "$LOCAL_REPO" &&
+		git checkout $BRANCH &&
+		echo "changed" > path2 &&
+		git commit -a -m path2 --amend &&
+
+		!(git push -v origin >output 2>&1) &&
+		(cd "$REMOTE_REPO" &&
+		 test $HEAD = $(git rev-parse --verify HEAD))
+	'
+
+	test_expect_success 'non-fast-forward push show ref status' '
+		grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" output
+	'
+
+	test_expect_success 'non-fast-forward push shows help message' '
+		grep "To prevent you from losing history, non-fast-forward updates were rejected" \
+			output
+	'
+}
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index bb18f8b..37fe875 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -137,6 +137,9 @@ test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
 
 '
 
+test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
+	"$ROOT_PATH"/test_repo_clone master
+
 stop_httpd
 
 test_done
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index ff947f3..795dc2b 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -88,28 +88,8 @@ test_expect_success 'used receive-pack service' '
 	test_cmp exp act
 '
 
-test_expect_success 'non-fast-forward push fails' '
-	cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	HEAD=$(git rev-parse --verify HEAD) &&
-
-	cd "$ROOT_PATH"/test_repo_clone &&
-	git checkout master &&
-	echo "changed" > path2 &&
-	git commit -a -m path2 --amend &&
-
-	!(git push -v origin >output 2>&1) &&
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	 test $HEAD = $(git rev-parse --verify HEAD))
-'
-
-test_expect_success 'non-fast-forward push show ref status' '
-	grep "^ ! \[rejected\][ ]*master -> master (non-fast-forward)$" output
-'
-
-test_expect_success 'non-fast-forward push shows help message' '
-	grep "To prevent you from losing history, non-fast-forward updates were rejected" \
-		output
-'
+test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
+	"$ROOT_PATH"/test_repo_clone master
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
 	# create a dissimilarly-named remote ref so that git is unable to match the
-- 
1.7.0.26.gbfa16
