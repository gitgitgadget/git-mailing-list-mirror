From: Eric Wong <normalperson@yhbt.net>
Subject: [RFH/RFC] typechange tests for git apply (currently failing)
Date: Sun, 16 Jul 2006 03:38:40 -0700
Message-ID: <1153046320538-git-send-email-normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 16 12:39:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G241Y-0008PQ-4r
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 12:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWGPKip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 06:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWGPKio
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 06:38:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:15002 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751565AbWGPKio (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 06:38:44 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 721F97DC022;
	Sun, 16 Jul 2006 03:38:40 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 16 Jul 2006 03:38:40 -0700
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g9d8f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23949>

I've found that git apply is incapable of handling patches
involving object type changes to the same path.

Of course git itself is perfectly capable of making commits that
generate these changes, as it only tracks trees states.  It's
just that the diffs between them are less useful if they can't
be applied.

Some of these are rare, but I've hit one of them (file becoming
a symlink) recently in real-world usage, and was inspired to
find more potential breakages :)

I'm not sure when I'll have time to fix these myself and I'm not
very familiar with the apply code.   So if someone could get
some or all of these cases working, they would be my hero :)

Some of these are what I would refer to as corner-cases from
hell.  Most (if not all) other systems fail some of these.  In
fact, they aren't even capable of representing most of these
changes in their histories; much less being able to handle
patches to that effect.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t4114-apply-typechange.sh |  105 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
new file mode 100755
index 0000000..ca81d72
--- /dev/null
+++ b/t/t4114-apply-typechange.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+#
+
+test_description='git-apply should not get confused with type changes.
+
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup repository and commits' '
+	echo "hello world" > foo &&
+	echo "hi planet" > bar &&
+	git update-index --add foo bar &&
+	git commit -m initial &&
+	git branch initial &&
+	rm -f foo &&
+	ln -s bar foo &&
+	git update-index foo &&
+	git commit -m "foo symlinked to bar" &&
+	git branch foo-symlinked-to-bar &&
+	rm -f foo &&
+	echo "how far is the sun?" > foo &&
+	git update-index foo &&
+	git commit -m "foo back to file" &&
+	git branch foo-back-to-file &&
+	rm -f foo &&
+	git update-index --remove foo &&
+	mkdir foo &&
+	echo "if only I knew" > foo/baz &&
+	git update-index --add foo/baz &&
+	git commit -m "foo becomes a directory" &&
+	git branch "foo-becomes-a-directory" &&
+	echo "hello world" > foo/baz &&
+	git update-index foo/baz &&
+	git commit -m "foo/baz is the original foo" &&
+	git branch foo-baz-renamed-from-foo
+	'
+
+test_expect_success 'file renamed from foo to foo/baz' '
+	git checkout -f initial &&
+	git diff-tree -M -p HEAD foo-baz-renamed-from-foo > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+
+test_expect_success 'file renamed from foo/baz to foo' '
+	git checkout -f foo-baz-renamed-from-foo &&
+	git diff-tree -M -p HEAD initial > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+
+test_expect_success 'directory becomes file' '
+	git checkout -f foo-becomes-a-directory &&
+	git diff-tree -p HEAD initial > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+
+test_expect_success 'file becomes directory' '
+	git checkout -f initial &&
+	git diff-tree -p HEAD foo-becomes-a-directory > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+
+test_expect_success 'file becomes symlink' '
+	git checkout -f initial &&
+	git diff-tree -p HEAD foo-symlinked-to-bar > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+
+test_expect_success 'symlink becomes file' '
+	git checkout -f foo-symlinked-to-bar &&
+	git diff-tree -p HEAD foo-back-to-file > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+
+test_expect_success 'symlink becomes directory' '
+	git checkout -f foo-symlinked-to-bar &&
+	git diff-tree -p HEAD foo-becomes-a-directory > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+
+test_expect_success 'directory becomes symlink' '
+	git checkout -f foo-becomes-a-directory &&
+	git diff-tree -p HEAD foo-symlinked-to-bar > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+
+test_done
-- 
1.4.1.g9d8f
