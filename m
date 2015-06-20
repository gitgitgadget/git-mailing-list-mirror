From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 01/10] t9001-send-email: move script creation in a setup test
Date: Sun, 21 Jun 2015 01:17:44 +0200
Message-ID: <1434842273-30945-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 01:18:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6S1o-0007nJ-Ul
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 01:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbbFTXSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 19:18:03 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:59602 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234AbbFTXR5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jun 2015 19:17:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7417428C3;
	Sun, 21 Jun 2015 01:17:55 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cIAVbc0C9T4X; Sun, 21 Jun 2015 01:17:55 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 51EED2891;
	Sun, 21 Jun 2015 01:17:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 3E58020D9;
	Sun, 21 Jun 2015 01:17:55 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2B4Ohe5SGu0; Sun, 21 Jun 2015 01:17:55 +0200 (CEST)
Received: from localhost.localdomain (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id BB22220D6;
	Sun, 21 Jun 2015 01:17:54 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272244>

Move the creation of the scripts used in to-cmd and cc-cmd tests
in a setup test to make them available for later tests.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 t/t9001-send-email.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a3663da..eef12e6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -312,13 +312,19 @@ test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email'
 	)
 '
 
+test_expect_success $PREREQ 'setup tocmd and cccmd scripts' '
+	write_script tocmd-sed <<-\EOF &&
+	sed -n -e "s/^tocmd--//p" "$1"
+	EOF
+	write_script cccmd-sed <<-\EOF
+	sed -n -e "s/^cccmd--//p" "$1"
+	EOF
+'
+
 test_expect_success $PREREQ 'tocmd works' '
 	clean_fake_sendmail &&
 	cp $patches tocmd.patch &&
 	echo tocmd--tocmd@example.com >>tocmd.patch &&
-	write_script tocmd-sed <<-\EOF &&
-	sed -n -e "s/^tocmd--//p" "$1"
-	EOF
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to-cmd=./tocmd-sed \
@@ -332,9 +338,6 @@ test_expect_success $PREREQ 'cccmd works' '
 	clean_fake_sendmail &&
 	cp $patches cccmd.patch &&
 	echo "cccmd--  cccmd@example.com" >>cccmd.patch &&
-	write_script cccmd-sed <<-\EOF &&
-	sed -n -e "s/^cccmd--//p" "$1"
-	EOF
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-- 
1.9.1
