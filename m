From: larsxschneider@gmail.com
Subject: [PATCH v5 2/6] add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
Date: Sun, 15 Nov 2015 14:08:36 +0100
Message-ID: <1447592920-89228-3-git-send-email-larsxschneider@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 14:09:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zxx3h-0002ry-85
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 14:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbbKONJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 08:09:20 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33834 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbKONIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 08:08:45 -0500
Received: by wmvv187 with SMTP id v187so140225228wmv.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 05:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RpAGQqjEPJ+VzcKsndt4iFzIo0a7bjTdAittO+AT5Zo=;
        b=ycNn472yphOXne9RMhO0Mk2IR8wosuIbJIh8zssPXBGn0ZBNUXUDSO2o2iyY3mKJy5
         3KUt4giuk505qj9eut3b2Rl7wAJD6rgS1YJlS1TGQn2mVR7bkrRJ4A/8SVNW620xPuw8
         mJaHf+pR5+RFIVKqn8jisk3vcObWtD1Rcuy+2zid2aw7Qtvu1J737IaJbBrKyT/h6xMd
         OdZ2nHpW8iUKhqUfXHfvP74Eek8W1hWiw3apqA/+Gbz6h+4VtK1w8R3lJkJ1zYTizfg/
         978vOocosjIQ0PF9sgCTgAHybJXVIFaI5aRgLSN5Rr+EBV7cCl0rP+0hlwibWk/K99iO
         21qg==
X-Received: by 10.28.96.4 with SMTP id u4mr14789663wmb.52.1447592924605;
        Sun, 15 Nov 2015 05:08:44 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id t2sm13472567wme.0.2015.11.15.05.08.43
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Nov 2015 05:08:44 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281317>

From: Lars Schneider <larsxschneider@gmail.com>

t5516 "75 - deny fetch unreachable SHA1, allowtipsha1inwant=true" is
flaky in the following case:
1. remote upload-pack finds out "not our ref"
2. remote sends a response and closes the pipe
3. fetch-pack still tries to write commands to the remote upload-pack
4. write call in wrapper.c dies with SIGPIPE

t5504 "9 - push with transfer.fsckobjects" is flaky, too, and returns
SIGPIPE once in a while. I had to remove the final "To dst..." output
check because there is no output if the process dies with SIGPUPE.

Accept such a death-with-sigpipe also as OK when we are expecting a
failure.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 3 +--
 t/t5516-fetch-push.sh           | 6 +++---
 t/test-lib-functions.sh         | 4 ++++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 44f3d5f..a9e382c 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -111,8 +111,7 @@ test_expect_success 'push with transfer.fsckobjects' '
 		cd dst &&
 		git config transfer.fsckobjects true
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
-	test_cmp exp act
+	test_must_fail ok=sigpipe git push --porcelain dst master:refs/heads/test >act
 '
 
 cat >bogus-commit <<\EOF
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ec22c98..0a87e19 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1162,15 +1162,15 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
-			test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
+			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3 &&
+			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch ../testrepo/.git $SHA1_1 &&
 			git cat-file commit $SHA1_1 &&
 			test_must_fail git cat-file commit $SHA1_2 &&
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
-			test_must_fail git fetch ../testrepo/.git $SHA1_3
+			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3
 		)
 	'
 done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1e762da..1fdc58c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -598,6 +598,10 @@ test_must_fail () {
 	then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 0
+	elif ! case ",$_test_ok," in *,sigpipe,*) false;; esac &&
+		test $exit_code = 141
+	then
+		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
 	then
 		echo >&2 "test_must_fail: died by signal: $*"
-- 
2.5.1
