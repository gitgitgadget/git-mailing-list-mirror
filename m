From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/4] add -p: demonstrate failure when running 'edit' after a split
Date: Tue, 14 Apr 2015 13:32:45 +0200
Message-ID: <1429011168-23216-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7ftfkpue.fsf@anie.imag.fr>
 <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 14 13:33:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhz5r-0001p1-0x
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 13:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbbDNLdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 07:33:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38771 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186AbbDNLdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 07:33:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EBWqfe010994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Apr 2015 13:32:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EBWsKC010335;
	Tue, 14 Apr 2015 13:32:54 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yhz5K-0006F5-03; Tue, 14 Apr 2015 13:32:54 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 14 Apr 2015 13:32:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3EBWqfe010994
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429615973.92482@euOK+D0tY5T6Ay+i5wj5OQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267135>

The test passes if one replaces the 'e' command with a 'y' command in
the 'add -p' session.

Reported-by: Tanky Woo <wtq1990@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t3701-add-interactive.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 24ddd8a..b48a75c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -335,6 +335,31 @@ test_expect_success 'split hunk "add -p (edit)"' '
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
+	for a in s n y e   q n q q
+	do
+		echo $a
+	done |
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
