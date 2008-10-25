From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] add userdiff textconv tests
Date: Fri, 24 Oct 2008 20:51:41 -0400
Message-ID: <20081025005141.GB23903@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 02:53:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtXOi-0003U9-Sc
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 02:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbYJYAvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 20:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbYJYAvo
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 20:51:44 -0400
Received: from peff.net ([208.65.91.99]:1779 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbYJYAvn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 20:51:43 -0400
Received: (qmail 25790 invoked by uid 111); 25 Oct 2008 00:51:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 20:51:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 20:51:41 -0400
Content-Disposition: inline
In-Reply-To: <20081025004815.GA23851@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99086>

These tests provide a basic sanity check that textconv'd
files work. The tests try to describe how this configuration
_should_ work; thus some of the tests are marked to expect
failure.

In particular, we fail to actually textconv anything because
the 'diff.foo.binary' config option is not set, which will
be fixed in the next patch.

This also means that some "expect_failure" tests actually
seem to be fixed; in reality, this is just because textconv
is broken and its failure mode happens to make these tests
work.

Signed-off-by: Jeff King <peff@peff.net>
---
This brings in Johannes' typechange test, and adds a diffstat test
which we will fix along the way.

 t/t4030-diff-textconv.sh |  118 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100755 t/t4030-diff-textconv.sh

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
new file mode 100755
index 0000000..1b09648
--- /dev/null
+++ b/t/t4030-diff-textconv.sh
@@ -0,0 +1,118 @@
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
+test_expect_success 'setup textconv filters' '
+	echo file diff=foo >.gitattributes &&
+	git config diff.foo.textconv "$PWD"/hexdump &&
+	git config diff.fail.textconv false
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
+test_expect_failure 'format-patch produces binary' '
+	git format-patch --no-binary --stdout HEAD^ >patch &&
+	find_diff <patch >actual &&
+	test_cmp expect.binary actual
+'
+
+cat >expect.stat <<'EOF'
+ file |  Bin 2 -> 4 bytes
+ 1 files changed, 0 insertions(+), 0 deletions(-)
+EOF
+test_expect_failure 'diffstat does not run textconv' '
+	echo file diff=fail >.gitattributes &&
+	git diff --stat HEAD^ HEAD >actual &&
+	test_cmp expect.stat actual
+'
+# restore working setup
+echo file diff=foo >.gitattributes
+
+cat >expect.typechange <<'EOF'
+--- a/file
++++ /dev/null
+@@ -1,2 +0,0 @@
+-0
+-1
+diff --git a/file b/file
+new file mode 120000
+index ad8b3d2..67be421
+--- /dev/null
++++ b/file
+@@ -0,0 +1 @@
++frotz
+\ No newline at end of file
+EOF
+# make a symlink the hard way that works on symlink-challenged file systems
+test_expect_failure 'textconv does not act on symlinks' '
+	echo -n frotz > file &&
+	git add file &&
+	git ls-files -s | sed -e s/100644/120000/ |
+		git update-index --index-info &&
+	git commit -m typechange &&
+	git show >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.typechange actual
+'
+
+test_done
-- 
1.6.0.3.523.g38597.dirty
