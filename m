From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/3 v5] diff --stat: tests for long filenames and big change counts
Date: Wed, 15 Feb 2012 12:03:26 +0100
Message-ID: <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 15 12:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxceW-0006N9-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 12:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758964Ab2BOLD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 06:03:56 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52614 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758110Ab2BOLDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 06:03:55 -0500
Received: from [193.0.104.42] (helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RxceO-0000Yn-Ao; Wed, 15 Feb 2012 12:03:53 +0100
X-Mailer: git-send-email 1.7.9.5.g91d5
In-Reply-To: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190824>

Eleven tests for various combinations of a long filename and/or big
change count and ways to specify widths for diff --stat.
---
Tests added in previous version of 'diff --stat: use full terminal width'
are extracted into a separate patch. The tests are usefull independently
of that patch anyway.

changes to tests since v4:
- seq is replaced with a while loop for windows compatibility
- grep -m 1 is replaced with grep " | "
- redirects are made portable
- piped output is split into two commands to verify that the first command
  sucessfully runs to completion

 t/t4014-format-patch.sh | 101 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 6797512..f6ebb51 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -894,4 +894,105 @@ test_expect_success 'format patch ignores color.ui' '
 	test_cmp expect actual
 '
 
+# 120 character name
+name=aaaaaaaaaa
+name=$name$name$name$name$name$name$name$name$name$name$name$name
+test_expect_success 'preparation' "
+	>\"$name\" &&
+	git add \"$name\" &&
+	git commit -m message &&
+	echo a >\"$name\" &&
+	git commit -m message \"$name\"
+"
+
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
+EOF
+test_expect_success 'format patch graph width defaults to 80 columns' '
+	git format-patch --stat --stdout -1 >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
+EOF
+test_expect_success 'format patch --stat=width with long name' '
+	git format-patch --stat=40 --stdout -1 >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch --stat-width=width works with long name' '
+	git format-patch --stat-width=40 --stdout -1 >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch --stat=...,name-width with long name' '
+	git format-patch --stat=60,29 --stdout -1 >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch --stat-name-width with long name' '
+	git format-patch --stat-name-width=29 --stdout -1 >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'preparation' '
+	>abcd &&
+	git add abcd &&
+	git commit -m message &&
+	i=0 &&
+	while test $i -lt 1000; do
+		echo $i &&
+		i=$(($i + 1))
+	done >abcd &&
+	git commit -m message abcd
+'
+
+cat >expect <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
+EOF
+test_expect_success 'format patch graph part width is 40 columns' '
+	git format-patch --stat --stdout -1 >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch ignores COLUMNS' '
+	COLUMNS=200 git format-patch --stat --stdout -1 >output
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++
+EOF
+test_expect_success 'format patch --stat=width with big change' '
+	git format-patch --stat=40 --stdout -1 >output
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch --stat-width=width with big change' '
+	git format-patch --stat-width=40 --stdout -1 >output
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
+EOF
+test_expect_success 'format patch --stat=width with big change and long name' '
+	cp abcd aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	git add aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	git commit -m message &&
+	git format-patch --stat-width=60 --stdout -1 >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.9.5.g91d5
