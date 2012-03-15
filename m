From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v3 1/2] t0303: immediately bail out w/o GIT_TEST_CREDENTIAL_HELPER
Date: Thu, 15 Mar 2012 12:08:00 +0100
Message-ID: <1331809681-26113-1-git-send-email-zbyszek@in.waw.pl>
References: <4F61C828.8060506@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, jrnieder@gmail.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 15 12:08:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S88Xh-0004pP-BF
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 12:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab2COLIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 07:08:20 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55803 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685Ab2COLIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 07:08:19 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S88XZ-0000Ds-HN; Thu, 15 Mar 2012 12:08:17 +0100
X-Mailer: git-send-email 1.7.10.rc0.160.g12d89
In-Reply-To: <4F61C828.8060506@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193211>

t0300-credential-helpers.sh requires GIT_TEST_CREDENTIAL_HELPER to be
configured to do something sensible. If it is not set, prove will say:
  ./t0303-credential-external.sh .. skipped: (no reason given)
which isn't very nice.

Use skip_all=3D"..." && test_done to bail out immediately and provide a
nicer message. In case GIT_TEST_CREDENTIAL_HELPER is set, but the
timeout tests are skipped, mention GIT_TEST_CREDENTIAL_HELPER_TIMEOUT.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Acked-by: Jeff King <peff@peff.net>
---
This is v3: the only change is the removal of the removal of the eval a=
round
$GIT_TEST_CREDENTIAL_HELPER_SETUP.

 t/t0303-credential-external.sh |   39 ++++++++++++++++----------------=
-------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-extern=
al.sh
index 267f4c8..e771075 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -4,36 +4,29 @@ test_description=3D'external credential helper tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
-pre_test() {
-	test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
-	eval "$GIT_TEST_CREDENTIAL_HELPER_SETUP"
+if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
+	skip_all=3D"used to test external credential helpers"
+	test_done
+fi
=20
-	# clean before the test in case there is cruft left
-	# over from a previous run that would impact results
-	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
-}
+test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
+	eval "$GIT_TEST_CREDENTIAL_HELPER_SETUP"
=20
-post_test() {
-	# clean afterwards so that we are good citizens
-	# and don't leave cruft in the helper's storage, which
-	# might be long-term system storage
-	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
-}
+# clean before the test in case there is cruft left
+# over from a previous run that would impact results
+helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
=20
-if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
-	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELPER=
)"
-else
-	pre_test
-	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
-	post_test
-fi
+helper_test "$GIT_TEST_CREDENTIAL_HELPER"
=20
 if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
-	say "# skipping external helper timeout tests"
+	say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not=
 set)"
 else
-	pre_test
 	helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
-	post_test
 fi
=20
+# clean afterwards so that we are good citizens
+# and don't leave cruft in the helper's storage, which
+# might be long-term system storage
+helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
+
 test_done
--=20
1.7.10.rc0.160.g12d89
