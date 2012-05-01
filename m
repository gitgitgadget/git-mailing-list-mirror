From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/4] tests: check --[short]stat output after chmod
Date: Tue,  1 May 2012 19:10:13 +0200
Message-ID: <1335892215-21331-3-git-send-email-zbyszek@in.waw.pl>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mj@ucw.cz,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 01 19:10:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGbG-0003IL-TE
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477Ab2EARKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:10:52 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35793 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757101Ab2EARKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:10:51 -0400
Received: from ip-37-209-134-178.free.aero2.net.pl ([37.209.134.178] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPGbB-0003uH-Mq; Tue, 01 May 2012 19:10:50 +0200
X-Mailer: git-send-email 1.7.10.539.g288dd
In-Reply-To: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196700>

Add a test to check 'diff --stat' output with a text file after chmod,
and the same for a binary file. This demonstrates that text and binary
files are treated differently, which can be misleading.

While at it, duplicate the tests to check --shortstat output too.

Reported-by: Martin Mare=C5=A1 <mj@ucw.cz>
Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t4006-diff-mode.sh |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index c8f5180..a81c095 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -25,4 +25,41 @@ test_expect_success 'chmod' '
 	test_cmp expected check
 '
=20
+test_expect_success 'prepare binary file' '
+	git commit -m rezrov &&
+	dd if=3D/dev/zero of=3Dbinbin bs=3D1024 count=3D1 &&
+	git add binbin &&
+	git commit -m binbin
+'
+
+test_expect_success '--stat output after text chmod' '
+	test_chmod -x rezrov &&
+	echo " 0 files changed" >expect &&
+	git diff HEAD --stat >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--shortstat output after text chmod' '
+	git diff HEAD --shortstat >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--stat output after binary chmod' '
+	test_chmod +x binbin &&
+	cat >expect <<-EOF &&
+	 binbin |  Bin 1024 -> 1024 bytes
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	git diff HEAD --stat >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--shortstat output after binary chmod' '
+	cat >expect <<-EOF &&
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	git diff HEAD --shortstat >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.10.539.g288dd
