From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC/PATCH 4/4] t4203: consolidate test-repository setup
Date: Wed, 10 Jul 2013 15:04:01 -0400
Message-ID: <1373483041-27901-5-git-send-email-sunshine@sunshineco.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 21:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwzpS-0006ju-W5
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 21:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab3GJTN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 15:13:27 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:58556 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3GJTN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 15:13:26 -0400
Received: by mail-yh0-f51.google.com with SMTP id l109so2953607yhq.10
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Fj3dy9Ql3funvdfMCIc0iv4UWZwPRfhyXwKs17Ja/gw=;
        b=D+XjEyq4PYWO3dqIlvGwOjD4d6XJc0hMM50kreXe6vA5iH+pAE8Q3xE4uSYIChhlp0
         MFHPfz6Ra/A+Kz23FGafGSmcGAJ/avGoAGD7R6JWOPcolUZvPhsQISdUp8bEKgj+AeeJ
         7d3kXQOSgaZQkKSpWoVEA8cCRFmg9mEgadi8U+SG5FXSx03rM6AYngfb9RO/rU4A4sok
         ScxHyn1tH1GO9DXZznCM/rwEcEA1PPoR5e7sucvk5O/xi1XKoRekKGvpuchBIo2J1E4G
         Pkft8kD5aPTqMzc7duL6ICg2iYTRrXcaWkvHiQ61/zYmXfzfqwSdRY8IquT0hYdmcjeT
         Kf8w==
X-Received: by 10.236.152.228 with SMTP id d64mr19373550yhk.88.1373483113025;
        Wed, 10 Jul 2013 12:05:13 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id 66sm54426527yhe.20.2013.07.10.12.05.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 12:05:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230069>

The simple two-commit test-repository created by 'setup' is no longer
needed by any of the tests retrofitted to use check-mailmap. Subsequent,
more complex tests of git-shortlog, git-log, and git-blame functionality
expand the repository by adding five commits. Consolidate the creation
of this seven-commit repository into a single repository-setup function.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

The code near the top of the file which creates two commits, and the
code later which creates five commits have been consolidated into a
single repository-setup function. The patch is primarily code movement,
but the noisy diff makes it look more busy than it actually is.


 t/t4203-mailmap.sh | 69 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 48a000b..7e8b3cc 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -13,19 +13,10 @@ fuzz_blame () {
 }
 
 test_expect_success setup '
-	cat >contacts <<-\EOF &&
+	cat >contacts <<-\EOF
 	A U Thor <author@example.com>
 	nick1 <bugs@company.xx>
 	EOF
-
-	echo one >one &&
-	git add one &&
-	test_tick &&
-	git commit -m initial &&
-	echo two >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "nick1 <bugs@company.xx>" -m second
 '
 
 test_expect_success 'check-mailmap no arguments' '
@@ -168,8 +159,10 @@ test_expect_success 'No mailmap files, but configured' '
 '
 
 test_expect_success 'setup mailmap blob tests' '
+	git checkout --orphan empty &&
+	git commit --allow-empty --allow-empty-message &&
 	git checkout -b map &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout empty" &&
 	cat >just-bugs <<-\EOF &&
 	Blob Guy <bugs@company.xx>
 	EOF
@@ -254,28 +247,19 @@ test_expect_success 'cleanup after mailmap.blob tests' '
 	rm -f .mailmap
 '
 
-# Extended mailmap configurations should give us the following output for shortlog
-cat >expect <<\EOF
-A U Thor <author@example.com> (1):
-      initial
-
-CTO <cto@company.xx> (1):
-      seventh
+test_expect_success 'setup mailmap test repo' '
+	git checkout --orphan master &&
 
-Other Author <other@author.xx> (2):
-      third
-      fourth
-
-Santa Claus <santa.claus@northpole.xx> (2):
-      fifth
-      sixth
-
-Some Dude <some@dude.xx> (1):
-      second
+	echo one >one &&
+	git add one &&
+	test_tick &&
+	git commit -m initial &&
 
-EOF
+	echo two >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "nick1 <bugs@company.xx>" -m second &&
 
-test_expect_success 'Shortlog output (complex mapping)' '
 	echo three >>one &&
 	git add one &&
 	test_tick &&
@@ -299,8 +283,31 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	echo seven >>one &&
 	git add one &&
 	test_tick &&
-	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
+	git commit --author "CTO <cto@coompany.xx>" -m seventh
+'
+
+# Extended mailmap configurations should give us the following output for shortlog
+cat >expect <<\EOF
+A U Thor <author@example.com> (1):
+      initial
+
+CTO <cto@company.xx> (1):
+      seventh
 
+Other Author <other@author.xx> (2):
+      third
+      fourth
+
+Santa Claus <santa.claus@northpole.xx> (2):
+      fifth
+      sixth
+
+Some Dude <some@dude.xx> (1):
+      second
+
+EOF
+
+test_expect_success 'Shortlog output (complex mapping)' '
 	mkdir -p internal_mailmap &&
 	echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
 	echo "<cto@company.xx>                       <cto@coompany.xx>" >> internal_mailmap/.mailmap &&
-- 
1.8.3.2
