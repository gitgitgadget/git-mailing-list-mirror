From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Fri, 7 Jan 2011 14:54:17 -0500
Message-ID: <20110107195417.GC6175@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIOH-0001kC-GE
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab1AGTyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 14:54:20 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43953 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab1AGTyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:54:20 -0500
Received: (qmail 17728 invoked by uid 111); 7 Jan 2011 19:54:19 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Jan 2011 19:54:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jan 2011 14:54:17 -0500
Content-Disposition: inline
In-Reply-To: <20110107194909.GB6175@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164752>

On Fri, Jan 07, 2011 at 02:49:09PM -0500, Jeff King wrote:

> That being said, it probably would make more sense for "git checkout" to
> prefer branches to tags. That's probably going to take a lot more
> surgery, and we're in -rc right now. So I think the best thing to do is
> to fix the broken message and add some tests, and then if somebody wants
> to revisit it with a larger patch, they can do so on top.
> 
> I'll work on the first part and post a patch in a few minutes.

Ah, never mind. After reading Junio's response, it looks like we already
try to do the right thing in checkout, but it's just broken. So forget
my two-step plan.

Here is the test script I worked out which shows the issue (and checks
that the right messages are shown to the user):

---
 t/t2019-checkout-amiguous-ref.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100755 t/t2019-checkout-amiguous-ref.sh

diff --git a/t/t2019-checkout-amiguous-ref.sh b/t/t2019-checkout-amiguous-ref.sh
new file mode 100755
index 0000000..12edce8
--- /dev/null
+++ b/t/t2019-checkout-amiguous-ref.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='checkout handling of ambiguous (branch/tag) refs'
+. ./test-lib.sh
+
+test_expect_success 'setup ambiguous refs' '
+	test_commit branch file &&
+	git branch ambiguity &&
+	test_commit tag file &&
+	git tag ambiguity &&
+	test_commit other file
+'
+
+test_expect_success 'checkout ambiguous ref succeeds' '
+	git checkout ambiguity >stdout 2>stderr
+'
+
+test_expect_success 'checkout produces ambiguity warning' '
+	grep "warning.*ambiguous" stderr
+'
+
+test_expect_failure 'checkout chooses branch over tag' '
+	echo branch >expect &&
+	test_cmp expect file
+'
+
+test_expect_success 'checkout reports switch to detached HEAD' '
+	grep "Switched to branch" stderr &&
+	! grep "^HEAD is now at" stderr
+'
+
+test_done
-- 
1.7.4.rc1.23.g84303
