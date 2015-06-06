From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v2 1/5] t9001-send-email: move script creation in a setup test
Date: Sat,  6 Jun 2015 18:59:32 +0200
Message-ID: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 19:00:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1HS6-0001u9-AS
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 19:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbbFFRAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 13:00:03 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:42302 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751782AbbFFRAB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2015 13:00:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 72B1C4881A;
	Sat,  6 Jun 2015 18:59:58 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MH+PivbqtmZ; Sat,  6 Jun 2015 18:59:58 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 57BE348814;
	Sat,  6 Jun 2015 18:59:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 4AD7A20E4;
	Sat,  6 Jun 2015 18:59:58 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-97V5U8pT1E; Sat,  6 Jun 2015 18:59:58 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-407-223.w90-42.abo.wanadoo.fr [90.42.42.223])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 0CC1A20DF;
	Sat,  6 Jun 2015 18:59:56 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270934>

Move the creation of the scripts used in to-cmd and cc-cmd tests
in a setup test to make them available for later tests.

This will be used in the next commit.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 t/t9001-send-email.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 7be14a4..e63fc83 100755
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
