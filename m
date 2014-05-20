From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] rebase -i: test "Nothing to do" case with autostash
Date: Tue, 20 May 2014 08:55:13 +0200
Message-ID: <1400568913-1340-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1400537120-9995-1-git-send-email-artagnon@gmail.com>
Cc: ether@cpan.org, felipe.contreras@gmail.com,
	philippe.vaucher@gmail.com, artagnon@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 20 10:16:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmdxW-0002MX-HX
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 08:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbaETGz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 02:55:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37581 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbaETGz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 02:55:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s4K6tI8F017012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 May 2014 08:55:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4K6tJgf031671;
	Tue, 20 May 2014 08:55:19 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1WmdxH-0000MP-2p; Tue, 20 May 2014 08:55:19 +0200
X-Mailer: git-send-email 2.0.0.rc3.499.gd6dc9ad
In-Reply-To: <1400537120-9995-1-git-send-email-artagnon@gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 20 May 2014 08:55:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4K6tI8F017012
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1401173720.15521@G2JiBdxeYKIILUH6WFY0KA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249649>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Ram's patch lacks a test. Here it is. Fails without Ram's patch, and
passes with it.

Can be squashed into Ram's patch.

 t/t3420-rebase-autostash.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 90eb264..c2e9a4c 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -167,4 +167,21 @@ testrebase "" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
 
+test_expect_success 'Abort rebase with --autostash' '
+	git log &&
+	echo new-content >file0 &&
+	(
+		write_script abort-editor.sh <<-\EOF &&
+			echo > "$1"
+		EOF
+		GIT_EDITOR=\"$(pwd)/abort-editor.sh\" &&
+		export GIT_EDITOR &&
+		test_must_fail git rebase -i --autostash HEAD^ &&
+		rm -f abort-editor.sh
+	) &&
+	git status &&
+	echo new-content >expected &&
+	test_cmp expected file0
+'
+
 test_done
-- 
2.0.0.rc3.499.gd6dc9ad
