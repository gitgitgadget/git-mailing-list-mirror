From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] add tests for reflogs of deleted refs
Date: Thu, 19 Jul 2012 17:33:32 -0400
Message-ID: <20120719213332.GC20385@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexey Muranov <alexey.muranov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 23:33:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SryLs-0001WI-HI
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 23:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab2GSVdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 17:33:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55604 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab2GSVde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 17:33:34 -0400
Received: (qmail 3231 invoked by uid 107); 19 Jul 2012 21:33:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jul 2012 17:33:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2012 17:33:32 -0400
Content-Disposition: inline
In-Reply-To: <20120719213225.GA20311@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201755>

These tests cover the basic functionality of retaining
reflogs for deleted refs.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1413-reflog-deletion.sh | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 t/t1413-reflog-deletion.sh

diff --git a/t/t1413-reflog-deletion.sh b/t/t1413-reflog-deletion.sh
new file mode 100755
index 0000000..e00d038
--- /dev/null
+++ b/t/t1413-reflog-deletion.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='test retention of reflog after ref deletion'
+. ./test-lib.sh
+
+test_expect_success 'setup deleted branch' '
+	test_tick && echo one >file && git add file && git commit -m one &&
+	test_tick && echo two >file && git add file && git commit -m two &&
+	git checkout -b foo/bar &&
+	test_tick && echo three >file && git add file && git commit -m three &&
+	git checkout master &&
+	git branch -D foo/bar &&
+	rm -f .git/logs/HEAD
+'
+
+test_expect_success 'branch is no longer accessible' '
+	test_must_fail git rev-parse --verify foo/bar
+'
+
+test_expect_success 'final reflog is null sha1' '
+	echo $_z40 >expect &&
+	git rev-parse --verify foo/bar@{0} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'deleted reflog entries are accessible' '
+	cat >expect <<-\EOF &&
+	three
+	two
+	EOF
+	{
+		git log -1 --format=%s foo/bar@{1}
+		git log -1 --format=%s foo/bar@{2}
+	} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reflog walker can find deleted entries' '
+	cat >expect <<-\EOF &&
+	three
+	two
+	EOF
+	git log -g --format=%s foo/bar@{1} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'can still create/delete same ref' '
+	git branch foo/bar &&
+	git branch -D foo/bar
+'
+
+test_expect_success 'can still create/delete parent ref' '
+	git branch foo &&
+	git branch -D foo
+'
+
+test_expect_success 'can still create/delete child ref' '
+	git branch foo/bar/baz &&
+	git branch -D foo/bar/baz
+'
+
+test_expect_success 'deleted reflog entries are still reachable' '
+	>expect &&
+	git fsck --unreachable >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'deleted reflog entries are expired normally' '
+	git reflog expire --all --expire=now &&
+	git fsck --unreachable >actual &&
+	test_line_count = 3 actual
+'
+
+test_done
-- 
1.7.10.5.40.g059818d
