From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: [PATCH v4 1/6] t9001: non order-sensitive file comparison
Date: Wed,  8 Jun 2016 15:01:37 +0200
Message-ID: <20160608130142.29879-2-samuel.groot@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, gitster@pobox.com, aaron@schrab.com,
	e@80x24.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 15:04:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAd9N-0003Kf-66
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425495AbcFHNDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 09:03:42 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:53412 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425335AbcFHNDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 09:03:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 74AFD20B4;
	Wed,  8 Jun 2016 15:03:36 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id acxf5HG2ukJh; Wed,  8 Jun 2016 15:03:36 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 5CD9820B2;
	Wed,  8 Jun 2016 15:03:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 59BE32066;
	Wed,  8 Jun 2016 15:03:36 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkgih7_aRnRJ; Wed,  8 Jun 2016 15:03:36 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id F41892064;
	Wed,  8 Jun 2016 15:03:34 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.667.gf43de12
In-Reply-To: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296790>

Tests might fail if lines compared in text files don't have the same
order.

Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 t/t9001-send-email.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b3355d2..56ad8ce 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -39,6 +39,13 @@ test_expect_success $PREREQ 'Extract patches' '
 	patches=$(git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1)
 '
 
+# Check if two files have the same content, non-order sensitive
+test_cmp_noorder () {
+	sort "$1" >"$1_noorder"
+	sort "$2" >"$2_noorder"
+	test_cmp $1 $2
+}
+
 # Test no confirm early to ensure remaining tests will not hang
 test_no_confirm () {
 	rm -f no_confirm_okay
@@ -97,7 +104,7 @@ test_expect_success $PREREQ 'setup expect' '
 '
 
 test_expect_success $PREREQ 'Verify commandline' '
-	test_cmp expected commandline1
+	test_cmp_noorder expected commandline1
 '
 
 test_expect_success $PREREQ 'Send patches with --envelope-sender' '
@@ -117,7 +124,7 @@ test_expect_success $PREREQ 'setup expect' '
 '
 
 test_expect_success $PREREQ 'Verify commandline' '
-	test_cmp expected commandline1
+	test_cmp_noorder expected commandline1
 '
 
 test_expect_success $PREREQ 'Send patches with --envelope-sender=auto' '
@@ -137,7 +144,7 @@ test_expect_success $PREREQ 'setup expect' '
 '
 
 test_expect_success $PREREQ 'Verify commandline' '
-	test_cmp expected commandline1
+	test_cmp_noorder expected commandline1
 '
 
 test_expect_success $PREREQ 'setup expect' "
-- 
2.8.2.537.gb153d2a
