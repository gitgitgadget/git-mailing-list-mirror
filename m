From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v3 3/4] t4150-am: refactor am -3 tests
Date: Tue,  2 Jun 2015 19:34:05 +0200
Message-ID: <1433266446-2845-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 19:34:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzq5A-0006eG-I7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759895AbbFBRe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:34:27 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:46578 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759888AbbFBReV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 13:34:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0313E360D;
	Tue,  2 Jun 2015 19:34:19 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id are8H8RSXsqT; Tue,  2 Jun 2015 19:34:18 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DDECD360B;
	Tue,  2 Jun 2015 19:34:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id D688D20E4;
	Tue,  2 Jun 2015 19:34:18 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bq8+ydZMx6v4; Tue,  2 Jun 2015 19:34:18 +0200 (CEST)
Received: from Groseille.grenet.fr (wificampus-030200.grenet.fr [130.190.30.200])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 0983F20DD;
	Tue,  2 Jun 2015 19:34:17 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270570>

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
