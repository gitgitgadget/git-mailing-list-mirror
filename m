From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v6 01/10] t9001-send-email: move script creation in a setup test
Date: Tue, 23 Jun 2015 22:30:07 +0200
Message-ID: <1435091416-9394-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 22:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Upy-0000dL-L6
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbbFWUa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:30:26 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:35890 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754891AbbFWUaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 16:30:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DD23037E3;
	Tue, 23 Jun 2015 22:30:21 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0KRKwErp3CKI; Tue, 23 Jun 2015 22:30:21 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id BB1ED37DE;
	Tue, 23 Jun 2015 22:30:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id B2BA520DC;
	Tue, 23 Jun 2015 22:30:21 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bKprGXa0Yynu; Tue, 23 Jun 2015 22:30:21 +0200 (CEST)
Received: from localhost.localdomain (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 465FC20DA;
	Tue, 23 Jun 2015 22:30:21 +0200 (CEST)
X-Mailer: git-send-email 2.4.4.418.ga60dbe1
In-Reply-To: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272499>

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
