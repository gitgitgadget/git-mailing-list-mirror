From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 2/3] t4150-am: refactor am -3 tests
Date: Fri,  5 Jun 2015 01:24:43 +0200
Message-ID: <1433460284-20240-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433460284-20240-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 01:25:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0eVY-00006S-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 01:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbbFDXZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 19:25:00 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:56880 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714AbbFDXY6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 19:24:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 58A6B4886B;
	Fri,  5 Jun 2015 01:24:56 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XebU3vM815ay; Fri,  5 Jun 2015 01:24:56 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 39BAA48864;
	Fri,  5 Jun 2015 01:24:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 32CAE20DC;
	Fri,  5 Jun 2015 01:24:56 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqRBZmw+wchc; Fri,  5 Jun 2015 01:24:56 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-407-223.w90-42.abo.wanadoo.fr [90.42.42.223])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 5062A20D4;
	Fri,  5 Jun 2015 01:24:55 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433460284-20240-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270807>

Create a setup for git am -3 in a separate test instead of creating
this setup each time.

This prepares for the next commit which will use this setup as well.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 t/t4150-am.sh | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 306e6f3..6ced98c 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -274,15 +274,21 @@ test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
 	grep "^\[foo\] third" actual
 '
 
+test_expect_success 'setup am -3' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout -b base3way master2 &&
+	sed -n -e "3,\$p" msg >file &&
+	head -n 9 msg >>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "copied stuff"
+'
+
 test_expect_success 'am -3 falls back to 3-way merge' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-	git checkout -b lorem2 master2 &&
-	sed -n -e "3,\$p" msg >file &&
-	head -n 9 msg >>file &&
-	git add file &&
-	test_tick &&
-	git commit -m "copied stuff" &&
+	git checkout -b lorem2 base3way &&
 	git am -3 lorem-move.patch &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code lorem
@@ -291,12 +297,7 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 test_expect_success 'am -3 -p0 can read --no-prefix patch' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-	git checkout -b lorem3 master2 &&
-	sed -n -e "3,\$p" msg >file &&
-	head -n 9 msg >>file &&
-	git add file &&
-	test_tick &&
-	git commit -m "copied stuff" &&
+	git checkout -b lorem3 base3way &&
 	git am -3 -p0 lorem-zero.patch &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code lorem
@@ -338,12 +339,7 @@ test_expect_success 'am -3 can rename a file after falling back to 3-way merge'
 test_expect_success 'am -3 -q is quiet' '
 	rm -fr .git/rebase-apply &&
 	git checkout -f lorem2 &&
-	git reset master2 --hard &&
-	sed -n -e "3,\$p" msg >file &&
-	head -n 9 msg >>file &&
-	git add file &&
-	test_tick &&
-	git commit -m "copied stuff" &&
+	git reset base3way --hard &&
 	git am -3 -q lorem-move.patch >output.out 2>&1 &&
 	! test -s output.out
 '
-- 
1.9.1
