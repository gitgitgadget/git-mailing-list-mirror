From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/7] t554[01]-http-push: refactor, add non-ff tests
Date: Tue,  2 Mar 2010 18:49:26 +0800
Message-ID: <1267526971-5552-3-git-send-email-rctay89@gmail.com>
References: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPg5-0003k4-VT
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0CBKtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:49:52 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:40254 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab0CBKtu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:49:50 -0500
Received: by mail-yx0-f182.google.com with SMTP id 12so38910yxe.33
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dQpvIPNx1zTSw1zjer/ZsPHbWoywL2Htg5x8xptCmpc=;
        b=pVZl+JWyavaxMaXMYJ4S5JPtT1LMGj09pxv6jV1t+1+yF0XKQHsdzW3TSlG6l6QQ3L
         qXmX0i8MYYlQ1CpyZhJgw83k2XpC6mJTnCa+ZINZFA/uSaDGnsMVi1wEJ0pE6x0S+SYf
         tnuwDRbcsRh9ENhchmY0yZnOL4PzQm4I904y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GqRJmBCzMOHXWwEqoNbdM0bxdqKqNxKFJsqbzkyBUtoSBVN4xmRWr9EoaKgel7PWfO
         NLQt934vH8ty4hIRmWfDMsrYd4IUccUsqZ8zEsJIx/Kf9E5p9QEGSm7EdZHtzaDbwYeg
         W7bs/amCcqnhubbSRserGXSMBJv+mn9qynjL0=
Received: by 10.101.144.1 with SMTP id w1mr334517ann.61.1267526990170;
        Tue, 02 Mar 2010 02:49:50 -0800 (PST)
Received: from localhost.localdomain (cm212.zeta152.maxonline.com.sg [116.87.152.212])
        by mx.google.com with ESMTPS id 13sm2393991gxk.12.2010.03.02.02.49.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:49:49 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141383>

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
