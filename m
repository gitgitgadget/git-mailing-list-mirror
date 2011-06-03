From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t: add tests for cloning remotes with detached HEAD
Date: Fri, 3 Jun 2011 01:10:10 -0400
Message-ID: <20110603051009.GA1008@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 07:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSMeL-0007jc-J1
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 07:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab1FCFKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 01:10:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35896
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab1FCFKM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 01:10:12 -0400
Received: (qmail 4312 invoked by uid 107); 3 Jun 2011 05:10:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jun 2011 01:10:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2011 01:10:10 -0400
Content-Disposition: inline
In-Reply-To: <20110603050901.GA883@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174997>

We didn't test this setup at all, and doing so reveals a few
bugs:

  1. Cloning a repository with an orphaned detached HEAD
     (i.e., one that points to history that is not
     referenced by any ref) will fail.

  2. Cloning a repository with a detached HEAD that points
     to a tag will cause us to write a bogus "refs/tags/..."
     ref into the HEAD symbolic ref. We should probably
     detach instead.

  3. Cloning a repository with a detached HEAD that points
     to a branch will cause us to checkout that branch. This
     is a known limitation of the git protocol (we have to
     guess at HEAD's destination, since the symref contents
     aren't shown to us). This test serves to document the
     desired behavior, which can only be achieved once the
     git protocol learns to share symref information.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a repost of my earlier patch.

 t/t5707-clone-detached.sh |   76 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100755 t/t5707-clone-detached.sh

diff --git a/t/t5707-clone-detached.sh b/t/t5707-clone-detached.sh
new file mode 100755
index 0000000..fca8609
--- /dev/null
+++ b/t/t5707-clone-detached.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='test cloning a repository with detached HEAD'
+. ./test-lib.sh
+
+head_is_detached() {
+	git --git-dir=$1/.git rev-parse --verify HEAD &&
+	test_must_fail git --git-dir=$1/.git symbolic-ref HEAD
+}
+
+test_expect_success 'setup' '
+	echo one >file &&
+	git add file &&
+	git commit -m one &&
+	echo two >file &&
+	git commit -a -m two &&
+	git tag two &&
+	echo three >file &&
+	git commit -a -m three
+'
+
+test_expect_success 'clone repo (detached HEAD points to branch)' '
+	git checkout --detach master &&
+	git clone "file://$PWD" detached-branch
+'
+test_expect_success 'cloned HEAD matches' '
+	echo three >expect &&
+	git --git-dir=detached-branch/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+test_expect_failure 'cloned HEAD is detached' '
+	head_is_detached detached-branch
+'
+
+test_expect_success 'clone repo (detached HEAD points to tag)' '
+	git checkout --detach two &&
+	git clone "file://$PWD" detached-tag
+'
+test_expect_success 'cloned HEAD matches' '
+	echo two >expect &&
+	git --git-dir=detached-tag/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+test_expect_failure 'cloned HEAD is detached' '
+	head_is_detached detached-tag
+'
+
+test_expect_success 'clone repo (detached HEAD points to history)' '
+	git checkout --detach two^ &&
+	git clone "file://$PWD" detached-history
+'
+test_expect_success 'cloned HEAD matches' '
+	echo one >expect &&
+	git --git-dir=detached-history/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'cloned HEAD is detached' '
+	head_is_detached detached-history
+'
+
+test_expect_failure 'clone repo (orphan detached HEAD)' '
+	git checkout --detach master &&
+	echo four >file &&
+	git commit -a -m four &&
+	git clone "file://$PWD" detached-orphan
+'
+test_expect_failure 'cloned HEAD matches' '
+	echo four >expect &&
+	git --git-dir=detached-orphan/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+test_expect_failure 'cloned HEAD is detached' '
+	head_is_detached detached-orphan
+'
+
+test_done
-- 
1.7.6.rc0.36.g5a0d
