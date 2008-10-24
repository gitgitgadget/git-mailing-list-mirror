From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] add userdiff textconv tests
Date: Thu, 23 Oct 2008 22:50:17 -0400
Message-ID: <20081024025017.GB2831@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 04:51:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtClx-00041s-6J
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 04:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYJXCuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 22:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbYJXCuU
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 22:50:20 -0400
Received: from peff.net ([208.65.91.99]:2527 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbYJXCuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 22:50:19 -0400
Received: (qmail 12838 invoked by uid 111); 24 Oct 2008 02:50:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 22:50:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 22:50:17 -0400
Content-Disposition: inline
In-Reply-To: <20081024024631.GA20365@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99001>

These tests provide a basic sanity check that textconv'd
files work. The tests try to describe how this configuration
_should_ work; thus some of the tests are marked to expect
failure.

In particular, we fail to actually textconv anything because
the 'diff.foo.binary' config option is not set, which will
be fixed in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that this just tests actual patch generation. Diffstat, etc, are
left for later, as is discussed in the next patch.

 t/t4030-diff-textconv.sh |   80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100755 t/t4030-diff-textconv.sh

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
new file mode 100755
index 0000000..d0d7691
--- /dev/null
+++ b/t/t4030-diff-textconv.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description='diff.*.textconv tests'
+. ./test-lib.sh
+
+find_diff() {
+	sed '1,/^index /d' | sed '/^-- $/,$d'
+}
+
+cat >expect.binary <<'EOF'
+Binary files a/file and b/file differ
+EOF
+
+cat >expect.text <<'EOF'
+--- a/file
++++ b/file
+@@ -1 +1,2 @@
+ 0
++1
+EOF
+
+cat >hexdump <<'EOF'
+#!/bin/sh
+perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' "$1"
+EOF
+chmod +x hexdump
+
+test_expect_success 'setup binary file with history' '
+	printf "\\0\\n" >file &&
+	git add file &&
+	git commit -m one &&
+	printf "\\1\\n" >>file &&
+	git add file &&
+	git commit -m two
+'
+
+test_expect_success 'file is considered binary by porcelain' '
+	git diff HEAD^ HEAD >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.binary actual
+'
+
+test_expect_success 'file is considered binary by plumbing' '
+	git diff-tree -p HEAD^ HEAD >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.binary actual
+'
+
+test_expect_success 'setup textconv filter' '
+	echo file diff=foo >.gitattributes &&
+	git config diff.foo.textconv "$PWD"/hexdump
+'
+
+test_expect_failure 'diff produces text' '
+	git diff HEAD^ HEAD >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.text actual
+'
+
+test_expect_success 'diff-tree produces binary' '
+	git diff-tree -p HEAD^ HEAD >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.binary actual
+'
+
+test_expect_failure 'log produces text' '
+	git log -1 -p >log &&
+	find_diff <log >actual &&
+	test_cmp expect.text actual
+'
+
+# actually passes, but only because textconv is broken
+# and its failure mode happens to be the same as success
+test_expect_failure 'format-patch produces binary' '
+	git format-patch --no-binary --stdout HEAD^ >patch &&
+	find_diff <patch >actual &&
+	test_cmp expect.binary actual
+'
+
+test_done
-- 
1.6.0.3.518.gdb328.dirty
