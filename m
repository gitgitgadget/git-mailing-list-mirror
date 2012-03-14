From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2 1/2] t0303: immediately bail out w/o GIT_TEST_CREDENTIAL_HELPER
Date: Wed, 14 Mar 2012 15:18:23 +0100
Message-ID: <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
References: <20120314141401.GC28595@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 15:18:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7p2O-0002By-Jy
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030688Ab2CNOSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 10:18:42 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55763 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932377Ab2CNOSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:18:41 -0400
Received: from escher.fuw.edu.pl ([193.0.82.249])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S7p2D-0008Md-6N; Wed, 14 Mar 2012 15:18:38 +0100
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <20120314141401.GC28595@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193109>

t0300-credential-helpers.sh requires GIT_TEST_CREDENTIAL_HELPER to be
configured to do something sensible. If it is not set, prove will say:
  ./t0303-credential-external.sh .. skipped: (no reason given)
which isn't very nice.

Use skip_all=3D"..." && test_done to bail out immediately and provide a
nicer message. In case GIT_TEST_CREDENTIAL_HELPER is set, but the
timeout tests are skipped, mention GIT_TEST_CREDENTIAL_HELPER_TIMEOUT.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t0303-credential-external.sh |   40 ++++++++++++++++----------------=
--------
 1 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-extern=
al.sh
index 267f4c8..4479bf8 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -4,36 +4,28 @@ test_description=3D'external credential helper tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
-pre_test() {
-	test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
-	eval "$GIT_TEST_CREDENTIAL_HELPER_SETUP"
-
-	# clean before the test in case there is cruft left
-	# over from a previous run that would impact results
-	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
-}
-
-post_test() {
-	# clean afterwards so that we are good citizens
-	# and don't leave cruft in the helper's storage, which
-	# might be long-term system storage
-	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
-}
-
 if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
-	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELPER=
)"
-else
-	pre_test
-	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
-	post_test
+	skip_all=3D"used to test external credential helpers"
+	test_done
 fi
=20
+$GIT_TEST_CREDENTIAL_HELPER_SETUP
+
+# clean before the test in case there is cruft left
+# over from a previous run that would impact results
+helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
+
+helper_test "$GIT_TEST_CREDENTIAL_HELPER"
+
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
1.7.9.1
