From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/2] send-email: add tests for refactored prompting
Date: Sat, 28 Mar 2009 21:39:11 -0400
Message-ID: <1238290751-57461-2-git-send-email-jaysoffian@gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 03:41:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnk1F-0004jB-82
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 03:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbZC2BjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 21:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754348AbZC2BjY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 21:39:24 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:63035 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbZC2BjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 21:39:24 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1950537qwh.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TazLa3B3nsfn2vLfXdEcVQOVabjR79f9Y58IlVQMUzk=;
        b=p2ZbYy/aryig1r2GMyW9++oa8vN5go1WG91xUIvStnNpbjQIfXcwRpDziwUE5cG8Sv
         /OL+JczEIRvp2oNBWQQd2QixjvqaE8wowO99OehP1xQktbDnYS1QQhk+kKhGxRxl2+/r
         wa8m2b50+QQrFcs6Q6ts0qbm8MoHHdK0egi4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=E+9G+QBvG1/CYdiCqMxEk2of6CyWN7nnK8QL/dSto+lAFUNEiGfhxQkH6ly2tsUj/S
         sKP+pdRElQi19dMJKbhUAjsKqKrRAkR3lAjZhLIKSSLNh47PIx4SoOzafn9nDCsbpiFv
         F3eK4urnh17ROqrT6XmbvRA61zJskJn6Zxcw8=
Received: by 10.224.28.207 with SMTP id n15mr4677937qac.95.1238290761741;
        Sat, 28 Mar 2009 18:39:21 -0700 (PDT)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 7sm4033406qwb.41.2009.03.28.18.39.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 18:39:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.406.g8b07c
In-Reply-To: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114995>


Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/t9001-send-email.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e426c96..b4de98c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -421,8 +421,8 @@ test_confirm () {
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		$@ \
-		$patches | grep "Send this email"
+		$@ $patches > stdout &&
+	grep "Send this email" stdout
 }
 
 test_expect_success '--confirm=always' '
@@ -444,8 +444,10 @@ test_expect_success '--confirm=compose' '
 test_expect_success 'confirm by default (due to cc)' '
 	CONFIRM=$(git config --get sendemail.confirm) &&
 	git config --unset sendemail.confirm &&
-	test_confirm &&
-	git config sendemail.confirm $CONFIRM
+	test_confirm
+	ret="$?"
+	git config sendemail.confirm ${CONFIRM:-never}
+	test $ret = "0"
 '
 
 test_expect_success 'confirm by default (due to --compose)' '
@@ -457,6 +459,48 @@ test_expect_success 'confirm by default (due to --compose)' '
 	test $ret = "0"
 '
 
+test_expect_success 'confirm detects EOF (inform assumes y)' '
+	CONFIRM=$(git config --get sendemail.confirm) &&
+	git config --unset sendemail.confirm &&
+	GIT_SEND_EMAIL_NOTTY=1 \
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			$patches < /dev/null
+	ret="$?"
+	git config sendemail.confirm ${CONFIRM:-never}
+	test $ret = "0"
+'
+
+test_expect_success 'confirm detects EOF (auto causes failure)' '
+	CONFIRM=$(git config --get sendemail.confirm) &&
+	git config sendemail.confirm auto &&
+	GIT_SEND_EMAIL_NOTTY=1 \
+		test_must_fail git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			$patches < /dev/null
+	ret="$?"
+	git config sendemail.confirm ${CONFIRM:-never}
+	test $ret = "0"
+'
+
+test_expect_success 'confirm doesnt loop forever' '
+	CONFIRM=$(git config --get sendemail.confirm) &&
+	git config sendemail.confirm auto &&
+	yes "bogus" | GIT_SEND_EMAIL_NOTTY=1 \
+		test_must_fail git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			$patches
+	ret="$?"
+	git config sendemail.confirm ${CONFIRM:-never}
+	test $ret = "0"
+'
+
 test_expect_success '--compose adds MIME for utf8 body' '
 	clean_fake_sendmail &&
 	(echo "#!$SHELL_PATH" &&
-- 
1.6.2.313.g33352
