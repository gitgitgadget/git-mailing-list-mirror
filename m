From: Jeff King <peff@peff.net>
Subject: [PATCHv3 13/13] t: add test harness for external credential helpers
Date: Sat, 10 Dec 2011 05:35:55 -0500
Message-ID: <20111210103554.GM16529@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:36:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKHh-0007HT-Jf
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1LJKf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:35:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47039
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1LJKf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:35:57 -0500
Received: (qmail 14213 invoked by uid 107); 10 Dec 2011 10:42:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:42:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:35:55 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186746>

We already have tests for the internal helpers, but it's
nice to give authors of external tools an easy way to
sanity-check their helpers.

If you have written the "git-credential-foo" helper, you can
do so with:

  GIT_TEST_CREDENTIAL_HELPER=foo \
  make t0303-credential-external.sh

This assumes that your helper is capable of both storing and
retrieving credentials (some helpers may be read-only, and
they will fail these tests).

If your helper supports time-based expiration with a
configurable timeout, you can test that feature like this:

  GIT_TEST_CREDENTIAL_HELPER_TIMEOUT="foo --timeout=1" \
  make t0303-credential-external.sh

Signed-off-by: Jeff King <peff@peff.net>
---
This version adds GIT_TEST_CREDENTIAL_HELPER_SETUP, which is an
unfortunate hack needed for the OS X helper (I'll post that patch in a
few minutes).

 t/t0303-credential-external.sh |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100755 t/t0303-credential-external.sh

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
new file mode 100755
index 0000000..267f4c8
--- /dev/null
+++ b/t/t0303-credential-external.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='external credential helper tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-credential.sh
+
+pre_test() {
+	test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
+	eval "$GIT_TEST_CREDENTIAL_HELPER_SETUP"
+
+	# clean before the test in case there is cruft left
+	# over from a previous run that would impact results
+	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
+}
+
+post_test() {
+	# clean afterwards so that we are good citizens
+	# and don't leave cruft in the helper's storage, which
+	# might be long-term system storage
+	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
+}
+
+if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
+	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELPER)"
+else
+	pre_test
+	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
+	post_test
+fi
+
+if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
+	say "# skipping external helper timeout tests"
+else
+	pre_test
+	helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
+	post_test
+fi
+
+test_done
-- 
1.7.8.rc2.40.gaf387
