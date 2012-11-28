From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] t: add tests for "git var"
Date: Wed, 28 Nov 2012 13:26:43 -0500
Message-ID: <20121128182643.GE17122@sigill.intra.peff.net>
References: <20121128182534.GA21020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:27:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdmLd-0002ws-75
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab2K1S0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:26:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33900 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab2K1S0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:26:45 -0500
Received: (qmail 9914 invoked by uid 107); 28 Nov 2012 18:27:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 13:27:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 13:26:43 -0500
Content-Disposition: inline
In-Reply-To: <20121128182534.GA21020@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210754>

We do not currently have any explicit tests for "git var" at
all (though we do exercise it to some degree as a part of
other tests). Let's add a few basic sanity checks.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0007-git-var.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100755 t/t0007-git-var.sh

diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
new file mode 100755
index 0000000..5868a87
--- /dev/null
+++ b/t/t0007-git-var.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='basic sanity checks for git var'
+. ./test-lib.sh
+
+test_expect_success 'get GIT_AUTHOR_IDENT' '
+	test_tick &&
+	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
+	git var GIT_AUTHOR_IDENT >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get GIT_COMMITTER_IDENT' '
+	test_tick &&
+	echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" >expect &&
+	git var GIT_COMMITTER_IDENT >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success !AUTOIDENT 'requested identites are strict' '
+	(
+		sane_unset GIT_COMMITTER_NAME &&
+		sane_unset GIT_COMMITTER_EMAIL &&
+		test_must_fail git var GIT_COMMITTER_IDENT
+	)
+'
+
+# For git var -l, we check only a representative variable;
+# testing the whole output would make our test too brittle with
+# respect to unrelated changes in the test suite's environment.
+test_expect_success 'git var -l lists variables' '
+	git var -l >actual &&
+	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
+	sed -n s/GIT_AUTHOR_IDENT=//p <actual >actual.author &&
+	test_cmp expect actual.author
+'
+
+test_expect_success 'git var -l lists config' '
+	git var -l >actual &&
+	echo false >expect &&
+	sed -n s/core\\.bare=//p <actual >actual.bare &&
+	test_cmp expect actual.bare
+'
+
+test_expect_success 'listing and asking for variables are exclusive' '
+	test_must_fail git var -l GIT_COMMITTER_IDENT
+'
+
+test_done
-- 
1.8.0.207.gdf2154c
