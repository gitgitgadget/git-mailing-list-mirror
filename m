From: Jeff King <peff@peff.net>
Subject: [PATCH 13/13] t: add test harness for external credential helpers
Date: Thu, 24 Nov 2011 06:09:04 -0500
Message-ID: <20111124110904.GK8417@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 12:09:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTXB3-0007U7-52
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 12:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab1KXLJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 06:09:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49657
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288Ab1KXLJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 06:09:07 -0500
Received: (qmail 10413 invoked by uid 107); 24 Nov 2011 11:09:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 06:09:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 06:09:04 -0500
Content-Disposition: inline
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185908>

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
I haven't tried porting or testing any of the older helpers to the new
interface. So this script has only been lightly tested with:

  GIT_TEST_CREDENTIAL_HELPER=cache

 t/t0303-credential-external.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100755 t/t0303-credential-external.sh

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
new file mode 100755
index 0000000..f3953d4
--- /dev/null
+++ b/t/t0303-credential-external.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='external credential helper tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-credential.sh
+
+if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
+	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELPER)"
+else
+	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
+fi
+
+if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
+	say "# skipping external helper timeout tests"
+else
+	helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
+fi
+
+test_done
-- 
1.7.7.4.5.gb32a5
