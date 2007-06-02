From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add basic test-script for git-submodule
Date: Sat,  2 Jun 2007 03:27:42 +0200
Message-ID: <1180747662110-git-send-email-hjemli@gmail.com>
References: <7vmyzjzc76.fsf@assigned-by-dhcp.cox.net>
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 03:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuINE-0005Iy-QS
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 03:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbXFBBZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 21:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758054AbXFBBZ2
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 21:25:28 -0400
Received: from mail44.e.nsc.no ([193.213.115.44]:64169 "EHLO mail44.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755870AbXFBBZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 21:25:27 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail44.nsc.no (8.13.8/8.13.5) with ESMTP id l521PKnR015436;
	Sat, 2 Jun 2007 03:25:20 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.839.ga3b1-dirty
In-Reply-To: <7vmyzjzc76.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48903>

This test tries to verify basic sanity of git-submodule, i.e. that it is
able to clone and update a submodule repository, that its status output is
sane, and that it barfs when the submodule path is occupied during init.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On 6/1/07, Junio C Hamano <junkio@cox.net> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
> > +test_expect_success 'the --cached sha1 should be rev1' '
> > +     git-submodule --cached status | grep "^\+$rev1"
> > +'
> 
> What's the purpose of that solitary backslash?

That's just a sign of me being sloppy, expecting the behaviour of 'grep -E' without
bothering to study the man-page. Sorry.


 t/t7400-submodule-basic.sh |  143 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 143 insertions(+), 0 deletions(-)
 create mode 100755 t/t7400-submodule-basic.sh

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
new file mode 100755
index 0000000..6274729
--- /dev/null
+++ b/t/t7400-submodule-basic.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Lars Hjemli
+#
+
+test_description='Basic porcelain support for submodules
+
+This test tries to verify basic sanity of the init, update and status
+subcommands of git-submodule.
+'
+
+. ./test-lib.sh
+
+#
+# Test setup:
+#  -create a repository in directory lib
+#  -add a couple of files
+#  -add directory lib to 'superproject', this creates a DIRLINK entry
+#  -add a couple of regular files to enable testing of submodule filtering
+#  -mv lib subrepo
+#  -add an entry to .gitmodules for path 'lib'
+#
+test_expect_success 'Prepare submodule testing' '
+	mkdir lib &&
+	cd lib &&
+	git-init &&
+	echo a >a &&
+	git-add a &&
+	git-commit -m "submodule commit 1" &&
+	git-tag -a -m "rev-1" rev-1 &&
+	rev1=$(git-rev-parse HEAD) &&
+	if test -z "$rev1"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	fi &&
+	cd .. &&
+	echo a >a &&
+	echo z >z &&
+	git-add a lib z &&
+	git-commit -m "super commit 1" &&
+	mv lib .subrepo &&
+	GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo
+'
+
+test_expect_success 'status should only print one line' '
+	lines=$(git-submodule status | wc -l) &&
+	test $lines = 1
+'
+
+test_expect_success 'status should initially be "missing"' '
+	git-submodule status | grep "^-$rev1"
+'
+
+test_expect_success 'init should fail when path is used by a file' '
+	echo "hello" >lib &&
+	if git-submodule init
+	then
+		echo "[OOPS] init should have failed"
+		false
+	elif test -f lib && test "$(cat lib)" != "hello"
+	then
+		echo "[OOPS] init failed but lib file was molested"
+		false
+	else
+		rm lib
+	fi
+'
+
+test_expect_success 'init should fail when path is used by a nonempty directory' '
+	mkdir lib &&
+	echo "hello" >lib/a &&
+	if git-submodule init
+	then
+		echo "[OOPS] init should have failed"
+		false
+	elif test "$(cat lib/a)" != "hello"
+	then
+		echo "[OOPS] init failed but lib/a was molested"
+		false
+	else
+		rm lib/a
+	fi
+'
+
+test_expect_success 'init should work when path is an empty dir' '
+	rm -rf lib &&
+	mkdir lib &&
+	git-submodule init &&
+	head=$(cd lib && git-rev-parse HEAD) &&
+	if test -z "$head"
+	then
+		echo "[OOPS] Failed to obtain submodule head"
+		false
+	elif test "$head" != "$rev1"
+	then
+		echo "[OOPS] Submodule head is $head but should have been $rev1"
+		false
+	fi
+'
+
+test_expect_success 'status should be "up-to-date" after init' '
+	git-submodule status | grep "^ $rev1"
+'
+
+test_expect_success 'status should be "modified" after submodule commit' '
+	cd lib &&
+	echo b >b &&
+	git-add b &&
+	git-commit -m "submodule commit 2" &&
+	rev2=$(git-rev-parse HEAD) &&
+	cd .. &&
+	if test -z "$rev2"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	fi &&
+	git-submodule status | grep "^+$rev2"
+'
+
+test_expect_success 'the --cached sha1 should be rev1' '
+	git-submodule --cached status | grep "^+$rev1"
+'
+
+test_expect_success 'update should checkout rev1' '
+	git-submodule update &&
+	head=$(cd lib && git-rev-parse HEAD) &&
+	if test -z "$head"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	elif test "$head" != "$rev1"
+	then
+		echo "[OOPS] init did not checkout correct head"
+		false
+	fi
+'
+
+test_expect_success 'status should be "up-to-date" after update' '
+	git-submodule status | grep "^ $rev1"
+'
+
+test_done
-- 
1.5.2.839.ga3b1-dirty
