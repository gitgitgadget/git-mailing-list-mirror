From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3 v2] rev-parse: add test script for "--verify"
Date: Mon, 12 May 2008 05:41:42 +0200
Message-ID: <20080512054142.5e524e6f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 05:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvOrJ-0004vM-Ai
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 05:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbYELDhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 23:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753682AbYELDhC
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 23:37:02 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:40818 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbYELDhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 23:37:01 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A72091AB2B8;
	Mon, 12 May 2008 05:36:59 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 621911AB2B6;
	Mon, 12 May 2008 05:36:59 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81829>

This patch documents the current behavior of "git rev-parse --verify".

This command is tested both with and without the "--quiet" and
"--default" options.

This shows some problems with the current behavior that will be fixed
in latter patches:

	- in case of errors, there should be no good rev output on
	stdout,
	- with "--default" one test case is broken.

The setup code in this patch comes from "t6030-bisect-porcelain.sh".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1503-rev-parse-verify.sh |  112 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 112 insertions(+), 0 deletions(-)
 create mode 100755 t/t1503-rev-parse-verify.sh

	Junio wrote:
	> > +exec </dev/null
	> > +. ./test-lib.sh
	>
	> Who gets stuck by attempting to read from the stdin?  I am wondering if
	> that belongs to "test-lib.sh"...

	I copy pasted the setup code from "t6030-bisect-porcelain.sh" and that's
	where "exec </dev/null" comes from.

	I removed it in this new version and added a line to the commit message.

	Thanks.

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
new file mode 100755
index 0000000..90f0801
--- /dev/null
+++ b/t/t1503-rev-parse-verify.sh
@@ -0,0 +1,112 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Christian Couder
+#
+test_description='test git rev-parse --verify'
+
+. ./test-lib.sh
+
+add_line_into_file()
+{
+    _line=$1
+    _file=$2
+
+    if [ -f "$_file" ]; then
+        echo "$_line" >> $_file || return $?
+        MSG="Add <$_line> into <$_file>."
+    else
+        echo "$_line" > $_file || return $?
+        git add $_file || return $?
+        MSG="Create file <$_file> with <$_line> inside."
+    fi
+
+    test_tick
+    git-commit --quiet -m "$MSG" $_file
+}
+
+HASH1=
+HASH2=
+HASH3=
+HASH4=
+
+test_expect_success 'set up basic repo with 1 file (hello) and 4 commits' '
+	add_line_into_file "1: Hello World" hello &&
+	HASH1=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "2: A new day for git" hello &&
+	HASH2=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "3: Another new day for git" hello &&
+	HASH3=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "4: Ciao for now" hello &&
+	HASH4=$(git rev-parse --verify HEAD)
+'
+
+test_expect_success 'works with one good rev' '
+	rev_hash1=$(git rev-parse --verify $HASH1) &&
+	test "$rev_hash1" = "$HASH1" &&
+	rev_hash2=$(git rev-parse --verify $HASH2) &&
+	test "$rev_hash2" = "$HASH2" &&
+	rev_hash3=$(git rev-parse --verify $HASH3) &&
+	test "$rev_hash3" = "$HASH3" &&
+	rev_hash4=$(git rev-parse --verify $HASH4) &&
+	test "$rev_hash4" = "$HASH4" &&
+	rev_master=$(git rev-parse --verify master) &&
+	test "$rev_master" = "$HASH4" &&
+	rev_head=$(git rev-parse --verify HEAD) &&
+	test "$rev_head" = "$HASH4"
+'
+
+test_expect_success 'fails with any bad rev or many good revs' '
+	test_must_fail git rev-parse --verify 2>error &&
+	grep "single revision" error &&
+	test_must_fail git rev-parse --verify foo 2>error &&
+	grep "single revision" error &&
+	test_must_fail git rev-parse --verify HEAD bar 2>error &&
+	grep "single revision" error &&
+	test_must_fail git rev-parse --verify baz HEAD 2>error &&
+	grep "single revision" error &&
+	test_must_fail git rev-parse --verify $HASH2 HEAD 2>error &&
+	grep "single revision" error
+'
+
+test_expect_success 'fails silently when using -q' '
+	test_must_fail git rev-parse --verify --quiet 2>error &&
+	test -z "$(cat error)" &&
+	test_must_fail git rev-parse -q --verify foo 2>error &&
+	test -z "$(cat error)" &&
+	test_must_fail git rev-parse --verify -q HEAD bar 2>error &&
+	test -z "$(cat error)" &&
+	test_must_fail git rev-parse --quiet --verify baz HEAD 2>error &&
+	test -z "$(cat error)" &&
+	test_must_fail git rev-parse -q --verify $HASH2 HEAD 2>error &&
+	test -z "$(cat error)"
+'
+
+test_expect_success '1 no stdout output on error' '
+	test -z "$(git rev-parse --verify)" &&
+	test -z "$(git rev-parse --verify foo)" &&
+	test -z "$(git rev-parse --verify baz HEAD)"
+'
+
+test_expect_failure '2 no stdout output on error' '
+	test -z "$(git rev-parse --verify HEAD bar)"
+'
+
+test_expect_failure '3 no stdout output on error' '
+	test -z "$(git rev-parse --verify $HASH2 HEAD)"
+'
+
+test_expect_success '1 with --default' '
+	git rev-parse --verify --default master &&
+	git rev-parse --verify --default master HEAD &&
+	git rev-parse --default master --verify &&
+	git rev-parse --default master --verify HEAD &&
+	test_must_fail git rev-parse --verify foo --default master &&
+	test_must_fail git rev-parse --default HEAD --verify bar &&
+	test_must_fail git rev-parse --verify --default HEAD baz
+'
+
+test_expect_failure '2 with --default' '
+	git rev-parse --verify HEAD --default master
+'
+
+test_done
-- 
1.5.5.1.345.g69ef
