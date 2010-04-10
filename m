From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 3/9] git rm: test failure behaviour for multiple removals
Date: Sat, 10 Apr 2010 19:23:44 +0100
Message-ID: <1270923830-11830-4-git-send-email-peter@pcc.me.uk>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fLu-0007Ck-77
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0DJSYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:24:00 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37796 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab0DJSX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:56 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLV-0006qQ-G2; Sat, 10 Apr 2010 19:23:53 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-00036E-Ci; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144562>

This patch causes the failure cases for the "git rm" command
to be tested.  Specifically it tests that if the first removal
fails the operation is aborted with an error message, and that
if subsequent removals fail, the operation proceeds.

Based-on-work-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 t/t3600-rm.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0aaf0ad..5186844 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -126,6 +126,60 @@ test_expect_success 'Remove nonexistent file with --ignore-unmatch' '
 	git rm --ignore-unmatch nonexistent
 '
 
+test_expect_success 'If the first (in alphabetical order) removal fails, rm is cancelled' '
+	touch xyzzy &&
+	mkdir -p plugh &&
+	touch plugh/xyzzy &&
+	git add xyzzy plugh/xyzzy &&
+	git commit --allow-empty -a -m "two files to remove" &&
+	chmod a-w plugh &&
+	git ls-files --stage >before &&
+	test $(grep xyzzy before | wc -l) = 2 &&
+
+	test_must_fail git rm xyzzy plugh/xyzzy &&
+
+	test -e plugh/xyzzy &&
+	test -e xyzzy &&
+	git ls-files --stage >after &&
+	test_cmp before after
+'
+! test -e plugh || chmod 775 plugh
+rm -fr before after plugh xyzzy
+
+test_expect_success 'Best-effort behavior if the second removal fails' '
+	touch plugh &&
+	mkdir -p xyzzy &&
+	touch xyzzy/plugh &&
+	git add plugh xyzzy/plugh &&
+	git commit --allow-empty -a -m "two files to remove" &&
+	chmod a-w xyzzy &&
+	: >expect &&
+
+	git rm plugh xyzzy/plugh &&
+
+	test -e xyzzy/plugh &&
+	! test -e plugh &&
+	git ls-files --stage plugh xyzzy/plugh >actual &&
+	test_cmp expect actual
+'
+! test -e xyzzy || chmod 775 xyzzy
+rm -fr expect actual plugh xyzzy
+
+test_expect_success 'Message when first removal fails' '
+	touch xyzzy &&
+	mkdir -p plugh &&
+	touch plugh/xyzzy &&
+	git add xyzzy plugh/xyzzy &&
+	git commit --allow-empty -a -m "two files to remove" &&
+	chmod a-w plugh &&
+
+	test_must_fail git rm xyzzy plugh/xyzzy 2>msg &&
+
+	grep "git rm: '\''plugh/xyzzy'\'':" msg
+'
+! test -e plugh || chmod 775 plugh
+rm -fr msg plugh xyzzy
+
 test_expect_success '"rm" command printed' '
 	echo frotz > test-file &&
 	git add test-file &&
-- 
1.6.5
