From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add basic test-script for git-submodule
Date: Sun, 27 May 2007 22:34:59 +0200
Message-ID: <11802980992216-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 27 22:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsPQW-0003fg-Ss
	for gcvg-git@gmane.org; Sun, 27 May 2007 22:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbXE0UdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 16:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755396AbXE0UdL
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 16:33:11 -0400
Received: from mail42.e.nsc.no ([193.213.115.42]:64656 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbXE0UdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 16:33:10 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id l4RKWism016846;
	Sun, 27 May 2007 22:32:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.74.g6b2d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48575>

This test verifies the basic operations in git-submodule, i.e. that it is
able to clone and update a submodule repository, that its status output is
sane, and that it errors out when the submodule path is occupied during
init.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Finally the test-script emerges. Btw, thanks for fixing my broken submodule
patch :)

 t/t7400-submodule-basic.sh |   82 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100755 t/t7400-submodule-basic.sh

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
new file mode 100755
index 0000000..2212b29
--- /dev/null
+++ b/t/t7400-submodule-basic.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Lars Hjemli
+#
+
+test_description='Basic submodule support in porcelain
+
+This test tries to run the init, update and status commands of git-submodule
+with a known good setup (and two known bad)
+'
+
+. ./test-lib.sh
+
+
+# create a submodule repository
+mkdir lib && cd lib
+git-init >/dev/null
+echo a >a && git-add a && git-commit -q -m "submodule commit 1"
+git-tag -a -m "rev-1" rev-1
+rev1=$(git-rev-parse HEAD)
+cd ..
+
+# add submodule and other files to super repo
+echo a >a && echo z >z
+git-add a lib z && git-commit -q -m "super commit 1"
+
+# move submodule to another location, register repo url in .gitmodules
+mv lib .subrepo
+GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo
+
+test_expect_success 'status is "missing"' \
+	'git-submodule status | grep "^-$rev1"'
+
+# make sure 'init' will not overwrite a regular file
+touch lib
+test_expect_failure 'init fails when path is used by a file' \
+	'git-submodule init'
+
+# make sure 'init' will not overwrite a nonempty directory
+rm lib
+mkdir -p lib/foo
+test_expect_failure 'init fails when path is used by a nonempty directory' \
+	'git-submodule init'
+
+# turn lib into an empty directory, just like git-checkout would do
+rmdir lib/foo
+test_expect_success 'init works when path is an empty dir' \
+	'git-submodule init && test -d lib/.git && git-diff --exit-code'
+
+head=$(cd lib && git-rev-parse HEAD)
+test_expect_success 'submodule HEAD should match rev1' \
+	'test "$head" = "$rev1"'
+
+test_expect_success 'status is "up-to-date" after init' \
+	'git-submodule status | grep "^ $rev1"'
+
+# change the submodule HEAD
+cd lib
+echo b >b && git-add b && git-commit -q -m "submodule commit 2"
+rev2=$(git-rev-parse HEAD)
+cd ..
+
+test_expect_success 'status is "modified" after submodule commit' \
+	'git-submodule status | grep "^\+$rev2"'
+
+test_expect_success 'the --cached sha1 should be rev1' \
+	'git-submodule --cached status | grep "^\+$rev1"'
+
+test_expect_failure 'git-diff --exit-code reports local modifications' \
+	'git-diff --exit-code'
+
+test_expect_success 'update should checkout the correct commit' \
+	'git-submodule update && git-diff --exit-code'
+
+head=$(cd lib && git-rev-parse HEAD)
+test_expect_success 'submodule HEAD should match rev1' \
+	'test "$head" = "$rev1"'
+
+test_expect_success 'status is "up-to-date" after update' \
+	'git-submodule status | grep "^ $rev1"'
+
+test_done
-- 
1.5.2.74.g6b2d
