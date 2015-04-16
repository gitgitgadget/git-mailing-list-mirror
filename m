From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/5] add -p: demonstrate failure when running 'edit' after a split
Date: Thu, 16 Apr 2015 09:02:28 +0200
Message-ID: <1429167751-19398-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
 <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Tanky Woo <wtq1990@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 16 09:03:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YidpD-000452-81
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 09:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873AbbDPHCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 03:02:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33526 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbbDPHCv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 03:02:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72cSk029312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2015 09:02:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72dcb021223;
	Thu, 16 Apr 2015 09:02:39 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yidot-0005CA-6j; Thu, 16 Apr 2015 09:02:39 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Apr 2015 09:02:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3G72cSk029312
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429772559.30514@ZpxX/o3Y9UNvRdi8HlSixQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267254>

The test passes if one replaces the 'e' command with a 'y' command in
the 'add -p' session.

Reported-by: Tanky Woo <wtq1990@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b63b9d4..deae948 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -332,6 +332,28 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '
 
+test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
+	cat >test <<-\EOF &&
+	5
+	10
+	20
+	21
+	30
+	31
+	40
+	50
+	60
+	EOF
+	git reset &&
+	# test sequence is s(plit), n(o), y(es), e(dit)
+	# q n q q is there to make sure we exit at the end.
+	printf "%s\n" s n y e   q n q q |
+	EDITOR=: git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff >actual &&
+	! grep "^+31" actual
+'
+
 test_expect_success 'patch mode ignores unmerged entries' '
 	git reset --hard &&
 	test_commit conflict &&
-- 
2.4.0.rc1.42.g9642cc6
