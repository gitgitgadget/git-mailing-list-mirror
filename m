From: larsxschneider@gmail.com
Subject: [PATCH v4 1/4] add function test_must_fail_or_sigpipe and use it to fix flaky tests
Date: Fri,  6 Nov 2015 09:58:40 +0100
Message-ID: <1446800323-2914-2-git-send-email-larsxschneider@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, sschuberth@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, avila.jn@gmail.com, luke@diamand.org,
	dturner@twopensource.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 09:59:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZucrL-0007cS-K3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 09:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032915AbbKFI6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 03:58:50 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33151 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032054AbbKFI6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 03:58:48 -0500
Received: by wmec201 with SMTP id c201so11962146wme.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 00:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AmyK5sQK3UH9tkXYARMySnEW5ZBh/YSnsV/DLkBl+4E=;
        b=w9pPIt71H6AUK5cYe+pwkfTzqKiomeTNBIkjqXTEih7uNH/2cnb3g0cvGHdLS7fTdW
         8No6jqOJRJ5kDNqd6hBzLZw8rTPsVS2ZRPwJc+d3B1KyK1dDwHXvXwZDHws3DZWFmz5T
         UWrfU2VN/Xju1YqIRUu5w5tRdggFlii/Ne8MylKijfsdOo+GTyOPL6l6PmnIUmSv+NOm
         fq1Vj6leUmZRrdMqWUi2IMWtwIHa4Bc7Fpaoj8YqkQPD9S6hQvnK/IZnATKiUvMfysdt
         3aAQMPMg++vkW03EuBQw8XbLrnKuPvDg6akKvMugyEXkk4xb7lCi58hHrCl0Q8wu4WYi
         PhiQ==
X-Received: by 10.28.132.13 with SMTP id g13mr8383005wmd.35.1446800327369;
        Fri, 06 Nov 2015 00:58:47 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB59AE.dip0.t-ipconnect.de. [93.219.89.174])
        by smtp.gmail.com with ESMTPSA id cr5sm11098003wjb.16.2015.11.06.00.58.46
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 00:58:46 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280965>

From: Lars Schneider <larsxschneider@gmail.com>

t5516 "75 - deny fetch unreachable SHA1, allowtipsha1inwant=true" is
flaky in the following case:
1. remote upload-pack finds out "not our ref"
2. remote sends a response and closes the pipe
3. fetch-pack still tries to write commands to the remote upload-pack
4. write call in wrapper.c dies with SIGPIPE

t5504 "9 - push with transfer.fsckobjects" is flaky, too, and returns
SIGPIPE once in a while. I had to remove the final "To dst..." output
check because there is no output if the process dies with SIGPIPE.

This patch accepts the SIGPIPE exit as legitimate test exit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t5504-fetch-receive-strict.sh |  3 +--
 t/t5516-fetch-push.sh           |  8 ++++----
 t/test-lib-functions.sh         | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 44f3d5f..129efa8 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -111,8 +111,7 @@ test_expect_success 'push with transfer.fsckobjects' '
 		cd dst &&
 		git config transfer.fsckobjects true
 	) &&
-	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
-	test_cmp exp act
+	test_must_fail_or_sigpipe git push --porcelain dst master:refs/heads/test >act
 '

 cat >bogus-commit <<\EOF
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ec22c98..22a941b 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1162,15 +1162,15 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
-			test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
+			test_must_fail_or_sigpipe git fetch ../testrepo/.git $SHA1_3 &&
+			test_must_fail_or_sigpipe git fetch ../testrepo/.git $SHA1_1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch ../testrepo/.git $SHA1_1 &&
 			git cat-file commit $SHA1_1 &&
-			test_must_fail git cat-file commit $SHA1_2 &&
+			test_must_fail_or_sigpipe git cat-file commit $SHA1_2 &&
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
-			test_must_fail git fetch ../testrepo/.git $SHA1_3
+			test_must_fail_or_sigpipe git fetch ../testrepo/.git $SHA1_3
 		)
 	'
 done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 73e37a1..19a598e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -600,6 +600,29 @@ test_must_fail () {
 	return 0
 }

+# Similar to test_must_fail, but tolerates sigpipe signal, too.
+
+test_must_fail_or_sigpipe () {
+	"$@"
+	exit_code=$?
+	if test $exit_code = 0; then
+		echo >&2 "test_must_fail: command succeeded: $*"
+		return 1
+	elif test $exit_code -ne 141 && \
+		 test $exit_code -gt 129 && \
+		 test $exit_code -le 192; then
+		echo >&2 "test_must_fail: died by signal: $*"
+		return 1
+	elif test $exit_code = 127; then
+		echo >&2 "test_must_fail: command not found: $*"
+		return 1
+	elif test $exit_code = 126; then
+		echo >&2 "test_must_fail: valgrind error: $*"
+		return 1
+	fi
+	return 0
+}
+
 # Similar to test_must_fail, but tolerates success, too.  This is
 # meant to be used in contexts like:
 #
--
2.5.1
