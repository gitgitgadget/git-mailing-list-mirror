From: Jeff King <peff@peff.net>
Subject: [PATCHv2 13/13] t: add test harness for external credential helpers
Date: Tue, 6 Dec 2011 01:23:13 -0500
Message-ID: <20111206062313.GM29233@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:23:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoRC-0004u8-5K
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954Ab1LFGXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:23:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40064
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932909Ab1LFGXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:23:16 -0500
Received: (qmail 1413 invoked by uid 107); 6 Dec 2011 06:29:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 01:29:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 01:23:13 -0500
Content-Disposition: inline
In-Reply-To: <20111206062127.GA29046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186332>

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
 t/t0303-credential-external.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100755 t/t0303-credential-external.sh

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
new file mode 100755
index 0000000..79b046f
--- /dev/null
+++ b/t/t0303-credential-external.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='external credential helper tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-credential.sh
+
+if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
+	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELPER)"
+else
+	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
+	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
+#	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
+fi
+
+if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
+	say "# skipping external helper timeout tests"
+else
+	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
+	helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
+	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
+fi
+
+test_done
-- 
1.7.8.rc4.4.g884ec
