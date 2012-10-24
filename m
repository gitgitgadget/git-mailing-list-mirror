From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Wed, 24 Oct 2012 10:03:35 +0200
Message-ID: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
Cc: Krzysztof Mazur <krzysiek@podlesie.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 10:05:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQvxc-0006NC-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 10:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757990Ab2JXIEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 04:04:37 -0400
Received: from shrek-modem2.podlesie.net ([83.13.132.46]:32965 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757975Ab2JXIEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 04:04:33 -0400
Received: from geronimo.kss.ia.polsl.pl (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 2B9683AB;
	Wed, 24 Oct 2012 10:04:30 +0200 (CEST)
X-Mailer: git-send-email 1.8.0.3.gf4c35fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208297>

The git-send-email always use RFC2047 subject quoting for files
with "broken" encoding - non-ASCII files without Content-Transfer-Encoding,
even for ASCII subjects. Now for ASCII subjects the RFC2047 quoting will be
skipped.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 git-send-email.perl   |  3 ++-
 t/t9001-send-email.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index adcb4e3..efeae4c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1327,7 +1327,8 @@ foreach my $t (@files) {
 		$body_encoding = $auto_8bit_encoding;
 	}
 
-	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
+	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject) &&
+			($subject =~ /[^[:ascii:]]/)) {
 		$subject = quote_rfc2047($subject, $auto_8bit_encoding);
 	}
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 89fceda..6c6af7d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1143,6 +1143,23 @@ EOF
 '
 
 test_expect_success $PREREQ 'setup expect' '
+cat >expected <<EOF
+Subject: subject goes here
+EOF
+'
+
+test_expect_success $PREREQ 'ASCII subject is not RFC2047 quoted' '
+	clean_fake_sendmail &&
+	echo bogus |
+	git send-email --from=author@example.com --to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			--8bit-encoding=UTF-8 \
+			email-using-8bit >stdout &&
+	grep "Subject" msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success $PREREQ 'setup expect' '
 cat >content-type-decl <<EOF
 MIME-Version: 1.0
 Content-Type: text/plain; charset=UTF-8
-- 
1.8.0.3.gf4c35fc
