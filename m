From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] test combinations of @{} syntax
Date: Thu, 28 Jan 2010 04:50:20 -0500
Message-ID: <20100128095020.GA14253@coredump.intra.peff.net>
References: <20100128094446.GA14244@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 10:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaR1D-0002b4-Sg
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 10:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab0A1Ju0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 04:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756018Ab0A1Ju0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 04:50:26 -0500
Received: from peff.net ([208.65.91.99]:41068 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756020Ab0A1JuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 04:50:25 -0500
Received: (qmail 20794 invoked by uid 107); 28 Jan 2010 09:50:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 Jan 2010 04:50:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jan 2010 04:50:20 -0500
Content-Disposition: inline
In-Reply-To: <20100128094446.GA14244@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138237>

Now that we have several different types of @{} syntax, it
is a good idea to test them together, which reveals some
failures.

Signed-off-by: Jeff King <peff@peff.net>
---
While this is conceptually similar to the tests in t0101, it feels
better to me to test features in combination only after they have been
tested by themselves. Thus a new script > 1507.

 t/t1508-at-combinations.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100755 t/t1508-at-combinations.sh

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
new file mode 100755
index 0000000..59f0463
--- /dev/null
+++ b/t/t1508-at-combinations.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='test various @{X} syntax combinations together'
+. ./test-lib.sh
+
+check() {
+test_expect_${3:-success} "$1 = $2" "
+	echo '$2' >expect &&
+	git log -1 --format=%s '$1' >actual &&
+	test_cmp expect actual
+"
+}
+nonsense() {
+test_expect_${2:-success} "$1 is nonsensical" "
+	test_must_fail git log -1 '$1'
+"
+}
+fail() {
+	"$@" failure
+}
+
+test_expect_success 'setup' '
+	test_commit master-one &&
+	test_commit master-two &&
+	git checkout -b upstream-branch &&
+	test_commit upstream-one &&
+	test_commit upstream-two &&
+	git checkout -b old-branch &&
+	test_commit old-one &&
+	test_commit old-two &&
+	git checkout -b new-branch &&
+	test_commit new-one &&
+	test_commit new-two &&
+	git config branch.old-branch.remote . &&
+	git config branch.old-branch.merge refs/heads/master &&
+	git config branch.new-branch.remote . &&
+	git config branch.new-branch.merge refs/heads/upstream-branch
+'
+
+check HEAD new-two
+check "@{1}" new-one
+check "@{-1}" old-two
+check "@{-1}@{1}" old-one
+check "@{u}" upstream-two
+check "@{u}@{1}" upstream-one
+fail check "@{-1}@{u}" master-two
+fail check "@{-1}@{u}@{1}" master-one
+fail nonsense "@{u}@{-1}"
+nonsense "@{1}@{u}"
+
+test_done
-- 
1.7.0.rc0.41.g538720
