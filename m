From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 13/13] t: add test harness for external credential
 helpers
Date: Tue, 6 Dec 2011 17:08:26 -0500
Message-ID: <20111206220826.GC28493@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <20111206062313.GM29233@sigill.intra.peff.net>
 <7vvcpte5cg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 23:08:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY3Bi-0008QZ-4g
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 23:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab1LFWI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 17:08:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41540
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312Ab1LFWI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 17:08:28 -0500
Received: (qmail 9220 invoked by uid 107); 6 Dec 2011 22:15:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 17:15:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 17:08:26 -0500
Content-Disposition: inline
In-Reply-To: <7vvcpte5cg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186397>

On Tue, Dec 06, 2011 at 01:51:43PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
> > new file mode 100755
> > index 0000000..79b046f
> > --- /dev/null
> > +++ b/t/t0303-credential-external.sh
> > @@ -0,0 +1,23 @@
> > ...
> > +else
> > +	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
> > +	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
> > +#	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
> > +fi
> 
> Huh? Leftover debugging cruft?

Oops, yes. It should be:

  clean
  do_the_test
  clean

The first clean is "remove any cruft accidentally leftover from a
previous run, so we can do our test". The second clean is "be a good
citizen and get rid of cruft we just accumulated".

As part of my testing, I commented out the second clean momentarily so
that I could verify that the cruft was left without the clean, but gone
with the clean. And then I accidentally committed with the "#" left in.

Here's the correct version, with some extra comments about the
clean-test-clean cycle:

-- >8 --
Subject: [PATCHv2 13/13] t: add test harness for external credential helpers

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
 t/t0303-credential-external.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100755 t/t0303-credential-external.sh

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
new file mode 100755
index 0000000..092dd3c
--- /dev/null
+++ b/t/t0303-credential-external.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='external credential helper tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-credential.sh
+
+if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
+	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELPER)"
+else
+	# clean before the test in case there is cruft left
+	# over from a previous run that would impact results
+	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
+
+	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
+
+	# then clean afterwards so that we are good citizens
+	# and don't leave cruft in the helper's storage, which
+	# might be long-term system storage
+	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
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
1.7.8.rc2.8.gf076c
