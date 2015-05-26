From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/3] t4150-am: refactor am -3 tests
Date: Tue, 26 May 2015 23:32:54 +0200
Message-ID: <1432675975-11020-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 23:40:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMaZ-0000tA-IW
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbbEZVki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 17:40:38 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:46214 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751570AbbEZVkh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 17:40:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 438E84881A;
	Tue, 26 May 2015 23:33:48 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jntWXEOKWHrq; Tue, 26 May 2015 23:33:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2B7FF48813;
	Tue, 26 May 2015 23:33:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 282EE20DF;
	Tue, 26 May 2015 23:33:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vcVq2h6n+W-Z; Tue, 26 May 2015 23:33:48 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-368-161.w82-122.abo.wanadoo.fr [82.122.243.161])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id AF71B20D1;
	Tue, 26 May 2015 23:33:47 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269980>

Move the creation of the file, commit and branch used in git am -3 tests
in a setup test, to avoid creating this setup several time.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 t/t4150-am.sh | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8370951..8f85098 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -272,13 +272,17 @@ test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
 	grep "^\[foo\] third" actual
 '
 
+test_expect_success 'setup: am -3' '
+	setup_fixed_branch lorem2 master2 &&
+	sed -n -e "3,\$p" msg >file &&
+	head -n 9 msg >>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "copied stuff"
+'
+
 test_expect_success 'am -3 falls back to 3-way merge' '
+	setup_temporary_branch lorem2 &&
-	setup_fixed_branch lorem2 master2 &&
-	sed -n -e "3,\$p" msg >file &&
-	head -n 9 msg >>file &&
-	git add file &&
-	test_tick &&
-	git commit -m "copied stuff" &&
 	git am -3 lorem-move.patch &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code lorem
@@ -286,11 +290,6 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 
 test_expect_success 'am -3 -p0 can read --no-prefix patch' '
 	setup_temporary_branch lorem2 &&
-	sed -n -e "3,\$p" msg >file &&
-	head -n 9 msg >>file &&
-	git add file &&
-	test_tick &&
-	git commit -m "copied stuff" &&
 	git am -3 -p0 lorem-zero.patch &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code lorem
@@ -325,11 +324,6 @@ test_expect_success 'am -3 can rename a file after falling back to 3-way merge'
 
 test_expect_success 'am -3 -q is quiet' '
 	setup_temporary_branch lorem2 &&
-	sed -n -e "3,\$p" msg >file &&
-	head -n 9 msg >>file &&
-	git add file &&
-	test_tick &&
-	git commit -m "copied stuff" &&
 	git am -3 -q lorem-move.patch >output.out 2>&1 &&
 	! test -s output.out
 '
-- 
1.9.1
