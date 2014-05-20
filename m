From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] rebase -i: test "Nothing to do" case with autostash
Date: Tue, 20 May 2014 09:49:31 +0200
Message-ID: <1400572171-28372-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAPig+cSWrc-W+9CZQ9vF-E3xcLY3OFoRMpHLb3K8Vsx3iz1Mjw@mail.gmail.com>
Cc: ether@cpan.org, felipe.contreras@gmail.com,
	philippe.vaucher@gmail.com, artagnon@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 20 10:18:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmeo0-0000zT-39
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 09:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaETHto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 03:49:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40426 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbaETHtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 03:49:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s4K7nWv2010819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 May 2014 09:49:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4K7nXEG000821;
	Tue, 20 May 2014 09:49:33 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Wmenk-0007OO-Sb; Tue, 20 May 2014 09:49:32 +0200
X-Mailer: git-send-email 2.0.0.rc3.499.gd6dc9ad
In-Reply-To: <CAPig+cSWrc-W+9CZQ9vF-E3xcLY3OFoRMpHLb3K8Vsx3iz1Mjw@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 20 May 2014 09:49:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4K7nWv2010819
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1401176974.86515@44mgi3JiTPD9+Py4H6Q71Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249650>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Eric Sunshine <sunshine@sunshineco.com> writes:

> Simpler (replace above two lines):
>
>     test_set_editor "$(pwd)/abort-editor.sh" &&

Indeed.

And I had debug statements left.

Hopefully, this after-coffee-v2 will be clear enough and correct ;-).

 t/t3420-rebase-autostash.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 90eb264..ff1e2dc 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -167,4 +167,19 @@ testrebase "" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
 
+test_expect_success 'abort rebase -i with --autostash' '
+	test_when_finished "git reset --hard" &&
+	echo uncommited-content >file0 &&
+	(
+		write_script abort-editor.sh <<-\EOF &&
+			echo > "$1"
+		EOF
+		test_set_editor "$(pwd)/abort-editor.sh" &&
+		test_must_fail git rebase -i --autostash HEAD^ &&
+		rm -f abort-editor.sh
+	) &&
+	echo uncommited-content >expected &&
+	test_cmp expected file0
+'
+
 test_done
-- 
2.0.0.rc3.499.gd6dc9ad
