From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/4 v2] Add tests for .git file
Date: Wed,  6 Feb 2008 08:56:23 +0100
Message-ID: <1202284583-24478-1-git-send-email-hjemli@gmail.com>
References: <7vfxw66a0s.fsf@gitster.siamese.dyndns.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 08:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMfBs-0002fa-6R
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 08:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760136AbYBFH67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 02:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760216AbYBFH66
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 02:58:58 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:53750 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759848AbYBFH66 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 02:58:58 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id m167vYKS025446;
	Wed, 6 Feb 2008 08:57:34 +0100 (MET)
X-Mailer: git-send-email 1.5.4.6.g6627
In-Reply-To: <7vfxw66a0s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72766>

Verify that the basic plumbing works when .git is a file pointing at
the real git directory.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This updated patch replaces cut with sed and tries to do proper quoting.


 t/t0002-gitfile.sh |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100755 t/t0002-gitfile.sh

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
new file mode 100755
index 0000000..7f8ee2f
--- /dev/null
+++ b/t/t0002-gitfile.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='.git file
+
+Verify that plumbing commands work when .git is a file
+'
+. ./test-lib.sh
+
+objpath() {
+    echo $1 | sed -re 's|(..)(.+)|\1/\2|'
+}
+
+objck() {
+	p=$(objpath $1)
+	if test ! -f "$REAL/objects/$p"
+	then
+		echo "Object not found: $REAL/objects/$p"
+		false
+	fi
+}
+
+test_expect_success 'setup' '
+	REAL="$(pwd)/.real" &&
+	mv .git "$REAL" &&
+	echo "gitdir: $REAL" >.git
+'
+
+test_expect_success 'check rev-parse --git-dir' '
+	test "$REAL" = "$(git rev-parse --git-dir)"
+'
+
+test_expect_success 'check hash-object' '
+	echo "foo" >bar &&
+	SHA=$(cat bar | git hash-object -w --stdin) &&
+	objck $SHA
+'
+
+test_expect_success 'check cat-file' '
+	git cat-file blob $SHA >actual &&
+	diff -u bar actual
+'
+
+test_expect_success 'check update-index' '
+	if test -f "$REAL/index"
+	then
+		echo "Hmm, $REAL/index exists?"
+		false
+	fi &&
+	rm -f "$REAL/objects/$(objpath $SHA)" &&
+	git update-index --add bar &&
+	if ! test -f "$REAL/index"
+	then
+		echo "$REAL/index not found"
+		false
+	fi &&
+	objck $SHA
+'
+
+test_expect_success 'check write-tree' '
+	SHA=$(git write-tree) &&
+	objck $SHA
+'
+
+test_expect_success 'check commit-tree' '
+	SHA=$(echo "commit bar" | git commit-tree $SHA) &&
+	objck $SHA
+'
+
+test_expect_success 'check rev-list' '
+	echo $SHA >"$REAL/HEAD" &&
+	test "$SHA" = "$(git rev-list HEAD)"
+'
+
+test_done
-- 
1.5.4.6.g6627
