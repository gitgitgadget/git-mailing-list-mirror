From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] add tests for merge message headings
Date: Sun, 9 Aug 2009 06:01:48 -0400
Message-ID: <20090809100148.GA25231@coredump.intra.peff.net>
References: <20090809100045.GA25197@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 12:02:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma5Dy-0004jy-H2
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 12:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbZHIKBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 06:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbZHIKBu
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 06:01:50 -0400
Received: from peff.net ([208.65.91.99]:52368 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677AbZHIKBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 06:01:49 -0400
Received: (qmail 3101 invoked by uid 107); 9 Aug 2009 10:04:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 06:04:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 06:01:48 -0400
Content-Disposition: inline
In-Reply-To: <20090809100045.GA25197@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125338>

When calling "git merge $X", we automatically generate a
commit message containing something like "Merge branch
'$X'". This test script checks that those messages say what
they should, and exposes a failure when merging a refname
that is ambiguous between a tag and a branch.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7608-merge-messages.sh |   50 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100755 t/t7608-merge-messages.sh

diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
new file mode 100755
index 0000000..9d10583
--- /dev/null
+++ b/t/t7608-merge-messages.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='test auto-generated merge messages'
+. ./test-lib.sh
+
+check_oneline() {
+	echo "$1" | sed "s/Q/'/g" >expect &&
+	git log -1 --pretty=tformat:%s >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'merge local branch' '
+	test_commit master-1 &&
+	git checkout -b local-branch &&
+	test_commit branch-1 &&
+	git checkout master &&
+	test_commit master-2 &&
+	git merge local-branch &&
+	check_oneline "Merge branch Qlocal-branchQ"
+'
+
+test_expect_success 'merge octopus branches' '
+	git checkout -b octopus-a master &&
+	test_commit octopus-1 &&
+	git checkout -b octopus-b master &&
+	test_commit octopus-2 &&
+	git checkout master &&
+	git merge octopus-a octopus-b &&
+	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ"
+'
+
+test_expect_success 'merge tag' '
+	git checkout -b tag-branch master &&
+	test_commit tag-1 &&
+	git checkout master &&
+	test_commit master-3 &&
+	git merge tag-1 &&
+	check_oneline "Merge commit Qtag-1Q"
+'
+
+test_expect_failure 'ambiguous tag' '
+	git checkout -b ambiguous master &&
+	test_commit ambiguous &&
+	git checkout master &&
+	test_commit master-4 &&
+	git merge ambiguous &&
+	check_oneline "Merge commit QambiguousQ"
+'
+
+test_done
-- 
1.6.4.178.g7a987
