From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 01/10] Add Testcases for time-stamping functionality
Date: Thu, 17 Mar 2016 19:46:52 +0100
Message-ID: <1458240421-3593-2-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:47:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxR-0007QH-Fy
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935927AbcCQSrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:37 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43304 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933303AbcCQSrf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:35 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id E5DB358C4CC;
	Thu, 17 Mar 2016 19:47:31 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:31 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289141>

This commit adds testcases for the new time-stamping functionality. To =
trigger
these testcases, the environment variables $GIT_TEST_TSA_URL and
$GIT_TEST_TSA_CAPATH have to be set. They do not default to any value t=
o avoid
spamming a pre-defined Time Stamping Authority (TSA).
As testing the RFC3161 functionality without a trusted time-stamp signa=
ture is
not possible, all tests are disabled by default.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 t/t7031-verify-tag.sh | 69 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 t/t7031-verify-tag.sh

diff --git a/t/t7031-verify-tag.sh b/t/t7031-verify-tag.sh
new file mode 100755
index 0000000..bc7953b
--- /dev/null
+++ b/t/t7031-verify-tag.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description=3D'signed time-stamped tag tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+# Tests for RFC3161 implementation
+
+if test -n "$NO_OPENSSL"
+then
+	skip_all=3D'skipping test, git built without openssl support'
+	test_done
+fi
+
+# Disable remote tests by default to avoid spamming of TSAs and to be =
able to
+# test without internet connection
+
+if test -z "$GIT_TEST_TSA_URL"
+then
+	skip_all=3D'Remote TSA testing disabled (set GIT_TEST_TSA_URL to enab=
le)'
+	test_done
+fi
+
+if test -z "$GIT_TEST_TSA_CAPATH"
+then
+	skip_all=3D'Remote TSA testing disabled (set GIT_TEST_TSA_CAPATH to e=
nable)'
+	test_done
+fi
+
+test_expect_success 'create a tag with a timestamp signature' '
+	git config ts.tsaurl $GIT_TEST_TSA_URL &&
+	git config ts.capath $GIT_TEST_TSA_CAPATH &&
+	git config ts.failonverify 1 &&
+	test_tick &&
+	echo foo > foo &&
+	git add foo &&
+	git commit -m foo &&
+	git tag -t -m onlytime tsa_onlytime
+'
+
+test_expect_success GPG 'create a tag with gpg and timestamp signature=
s' '
+	echo foobar > bar &&
+	git add bar &&
+	git commit -m test123 &&
+	git tag -s -t -m tsa_both tsa_both
+'
+
+test_expect_success 'verify tag with gpg and timestamp signature' '
+	git verify-tag tsa_both
+'
+
+test_expect_success 'verify tag with timestamp signature' '
+	test_must_fail git verify-tag tsa_onlytime
+'
+
+test_expect_success 'verify tag with timestamp signature with -t' '
+	git verify-tag -t tsa_onlytime
+'
+
+test_expect_success 'verify fudged timestamp' '
+	git cat-file tag tsa_onlytime >raw &&
+	sed -e "s/onlytime/morethantime/" raw >forged1 &&
+	git hash-object -w -t tag forged1 >forged1.tag &&
+	test_must_fail git verify-tag $(cat forged1.tag) >actual1 2>&1 &&
+	grep "BAD time-stamp signature" actual1 &&
+	! grep "Verified timestamp" actual1
+'
+
+test_done
--=20
2.8.0.rc0.62.gfc8aefa.dirty
