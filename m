From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 1/4] t5541-http-push: add test for chunked
Date: Tue,  3 May 2011 23:47:26 +0800
Message-ID: <1304437649-7052-2-git-send-email-rctay89@gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 17:48:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHHpQ-0003ZP-O7
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 17:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab1ECPru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 11:47:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61216 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1ECPrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 11:47:49 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so105338pwi.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=24ChLgkL7tkE3xBdU4sKV1MMaN/wcpaHU9D4Qb2U2BI=;
        b=HtcYU/VGgvVyvgIv64Zki/YEkVeMY24NyA5VBoS2FY23HIclHoG+sX27zXzpQWQXRT
         sQ9lZ1Ki4lGn+OjVdCYBfDl63VMPZgn1sZEr5m6TvllCszayNdFayc/kjmwmCT8CisFC
         WHeJd+Mas3NmqRmHj1MT+L2T5ZRx+l8BHba5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EZTWwnO8jBfLwyEcX4AfxBx/DiKHirvuFQBslI4ozQ0nQ1AWbEwRm5724f22y+xZPs
         bUoCvnFDEVsSePVEGyexmwlTcJUtBmL/h1HZ0BLZxMi+kMY4eoCKx+nB4ucv7khoNbOr
         w8pRg+bNxKNBzH7isQLxL4GL6bhS7Rdu5Wh7Q=
Received: by 10.68.39.105 with SMTP id o9mr19130pbk.45.1304437668986;
        Tue, 03 May 2011 08:47:48 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id p7sm117856pbp.1.2011.05.03.08.47.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 08:47:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
In-Reply-To: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172664>

Trigger the chunked type of pushing for smart HTTP. This can serve as a
regression test for the issue fixed in 1e41827 (http: clear POSTFIELDS
when initializing a slot).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

New.

 t/t5541-http-push.sh |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 0492877..f589221 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -65,14 +65,16 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
 '
 
-test_expect_success 'push to remote repository' '
+test_expect_success 'push to remote repository (standard)' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -m path2 &&
 	HEAD=$(git rev-parse --verify HEAD) &&
-	git push &&
+	GIT_CURL_VERBOSE=1 git push -v -v 2>err &&
+	! grep "Expect: 100-continue" err &&
+	grep "POST git-receive-pack (376 bytes)" err &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
@@ -140,5 +142,27 @@ test_expect_success C_LOCALE_OUTPUT 'push fails for non-fast-forward refs unmatc
 		output
 '
 
+test_expect_success 'push (chunked)' '
+	BRANCH=master-chunked &&
+	REPO=test_repo_chunked &&
+
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH" &&
+	 cp -R test_repo.git $REPO) &&
+	git remote set-url origin $HTTPD_URL/smart/$REPO &&
+
+	# to trigger chunked pushing, we need a sufficiently large pack - use
+	# git v0.99
+	GIT_REPO=$TEST_DIRECTORY/../.git &&
+	test -d $GIT_REPO &&
+	echo $GIT_REPO/objects > .git/objects/info/alternates &&
+	git fetch $GIT_REPO refs/tags/v0.99 &&
+	git branch $BRANCH FETCH_HEAD &&
+	BRANCH_REF=$(git rev-parse --verify refs/heads/$BRANCH) &&
+	git push -v -v origin $BRANCH 2>err &&
+	grep "POST git-receive-pack (chunked)" err &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/$REPO &&
+	 test $BRANCH_REF = $(git rev-parse --verify refs/heads/$BRANCH))
+'
+
 stop_httpd
 test_done
-- 
1.7.3.3.585.g74f6e
