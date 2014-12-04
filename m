From: Luis Henriques <henrix@camandro.org>
Subject: [PATCH] test/send-email: --[no-]xmailer tests
Date: Thu, 4 Dec 2014 19:11:30 +0000
Message-ID: <20141204190845.GA4906@charon.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:36:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwcC0-00034V-EK
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbaLDTf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 14:35:56 -0500
Received: from haggis.mythic-beasts.com ([93.93.131.56]:53860 "EHLO
	haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaLDTfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:35:55 -0500
Received: from [2.81.129.121] (port=62129 helo=localhost)
	by haggis.mythic-beasts.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1XwboL-0005nT-HP; Thu, 04 Dec 2014 19:11:34 +0000
Content-Disposition: inline
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260788>

Add tests for the --[no-]xmailer option.

Signed-off-by: Luis Henriques <henrix@camandro.org>
---
 t/t9001-send-email.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e37efef..7a3f996 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1556,5 +1556,37 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 		2>errors >out &&
 	grep "^!someone@example\.org!$" commandline1
 '
+do_xmailer_test() {
+	expected=$1
+	params=$2
+	git format-patch -1
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=someone@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$params \
+		0001-*.patch \
+		2>errors >out
+	test "z$(grep ^X-Mailer: out | wc -l)" = "z$expected"
+	return $?
+}
+
+test_expect_success $PREREQ '--xmailer uses X-Mailer header' '
+	do_xmailer_test "1" "--xmailer"
+'
+
+test_expect_success $PREREQ '--no-xmailer supresses X-Mailer header' '
+	do_xmailer_test "0" "--no-xmailer"
+'
+
+test_expect_success $PREREQ 'sendemail.xmailer=true uses X-Mailer header' '
+	git config sendemail.xmailer true &&
+	do_xmailer_test "1" ""
+'
+
+test_expect_success $PREREQ 'sendemail.xmailer=false supresses X-Mailer header' '
+	git config sendemail.xmailer false &&
+	do_xmailer_test "0" ""
+'
 
 test_done
