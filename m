From: larsxschneider@gmail.com
Subject: [PATCH v6 2/6] add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
Date: Thu, 19 Nov 2015 09:58:07 +0100
Message-ID: <1447923491-15330-3-git-send-email-larsxschneider@gmail.com>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 09:58:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzL32-0001tC-MZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 09:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049AbbKSI6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 03:58:20 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35113 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419AbbKSI6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 03:58:18 -0500
Received: by wmdw130 with SMTP id w130so230971393wmd.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 00:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RpAGQqjEPJ+VzcKsndt4iFzIo0a7bjTdAittO+AT5Zo=;
        b=VXQzNoPNOw43wuepMut7bsgJJWMPSGxgiuVVdxJvwL7ukU5IBhv+i76J8d422DoKN5
         hFGD1z8j9XvBWGLD2Sj70Lh8mcx5fYJp05HdftftPMvND0DYEM5N8IktFdkimFJ3Ne+X
         e9JVTHh+bnmfFNLC3R7s2x64k/TWT548KvapqHPXJ1iYBzWdE2mf90U9hiBCUWGb9NoJ
         A9oPNDq5HbX3fFBCu33WbnjFclG8V3DuUFYSAcEgUcRLGl8dX6S+zm5yVgIvgj3H7F1x
         B8f2yU3AAvfI7nN23X3VL1HjUrTWV9svJBANLd9LrJXlsHTTTyNRwuHtHil72d+Zx9Cx
         ZG+A==
X-Received: by 10.194.115.129 with SMTP id jo1mr7046373wjb.28.1447923496959;
        Thu, 19 Nov 2015 00:58:16 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB77F3.dip0.t-ipconnect.de. [93.219.119.243])
        by smtp.gmail.com with ESMTPSA id m64sm7237965wmf.14.2015.11.19.00.58.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Nov 2015 00:58:16 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281468>

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
