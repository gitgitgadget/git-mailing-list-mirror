From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 1/7] t9001-send-email: move script creation in a setup test
Date: Tue,  9 Jun 2015 19:56:21 +0200
Message-ID: <1433872587-15515-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433872587-15515-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 19:56:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2NlT-0004oA-3D
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 19:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbbFIR4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 13:56:40 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:40060 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752460AbbFIR4i (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 13:56:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A59F72826;
	Tue,  9 Jun 2015 19:56:36 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXXUqpMNCHwv; Tue,  9 Jun 2015 19:56:36 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 94F58278F;
	Tue,  9 Jun 2015 19:56:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 8FB2620E2;
	Tue,  9 Jun 2015 19:56:36 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KaUDmtj8K2f2; Tue,  9 Jun 2015 19:56:36 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-286-96.w82-122.abo.wanadoo.fr [82.122.169.96])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id AA83120DC;
	Tue,  9 Jun 2015 19:56:35 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433872587-15515-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271208>

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
