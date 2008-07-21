From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] builtin-merge: missing structure bzero.
Date: Mon, 21 Jul 2008 19:03:50 +0200
Message-ID: <1216659830-22063-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 19:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKyrL-0003zG-4W
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 19:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYGURGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 13:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbYGURGj
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 13:06:39 -0400
Received: from pan.madism.org ([88.191.52.104]:42003 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbYGURGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 13:06:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A0E483166B;
	Mon, 21 Jul 2008 19:06:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2ABC7E55A7; Mon, 21 Jul 2008 19:03:50 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.137.g3832.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89366>

This cause segfaults when replacing a directory with a submodule in a
fast-forward.

Adds tests that revealed the issue, even if the second one isn't yet fixed for
another reason.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    In the process of writing a test for a problem with submodules that quite
    bugs me so that I can fix it, I found a segfault that this patch fix.

    The problem I tried to fix (hence I first wrote a test) is what happens
    when you have in your repository a "dir/file.c" and that you replace
    "dir/" witha submodule that also has a "file.c". git-merge pretends the
    submodule checkout would clobber unversionned files, probably due to a too
    late removal. anyways, that's for a next patch when I will understand the
    root of this issue ;)

 builtin-merge.c            |    1 +
 t/t7403-submodule-merge.sh |   62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100755 t/t7403-submodule-merge.sh

diff --git a/builtin-merge.c b/builtin-merge.c
index e97c79e..0ed1acf 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -580,6 +580,7 @@ static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
 	memset(&trees, 0, sizeof(trees));
 	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
+	memset(&dir, 0, sizeof(dir));
 	dir.show_ignored = 1;
 	dir.exclude_per_dir = ".gitignore";
 	opts.dir = &dir;
diff --git a/t/t7403-submodule-merge.sh b/t/t7403-submodule-merge.sh
new file mode 100755
index 0000000..a803829
--- /dev/null
+++ b/t/t7403-submodule-merge.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Pierre Habouzit
+#
+
+test_description='Test merging with submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'Setup a repository used as a submodule for other tests' '
+	mkdir submodule &&
+	cd submodule &&
+	git init &&
+	echo a > a &&
+	git add a &&
+	git commit -asm"submodule init" &&
+	cd ..
+'
+
+test_expect_success 'Replace a directory with a submodule, no file conflict' '
+	mkdir test &&
+	cd test &&
+	: create our repository with a sub/b file &&
+	git init &&
+	mkdir sub && echo b > sub/b &&
+	git add sub && git commit -asm"initial repository" &&
+	: save this state in a new branch &&
+	git branch temp &&
+	: then replace sub with it &&
+	git rm -rf sub &&
+        git submodule add -- "$(pwd)/../submodule/.git/" sub &&
+	git commit -asm "replace sub/ with a submodule" &&
+	: then try to update the "temp" branch &&
+	git checkout temp &&
+	git merge master &&
+	: and finally cleanse the mess &&
+	cd .. &&
+	rm -rf test
+'
+
+test_expect_failure 'Replace a directory with a submodule, with a file conflict' '
+	mkdir test &&
+	cd test &&
+	: create our repository with a sub/a file &&
+	git init &&
+	mkdir sub && echo a > sub/a &&
+	git add sub && git commit -asm"initial repository" &&
+	: save this state in a new branch &&
+	git branch temp &&
+	: then replace sub with it &&
+	git rm -rf sub &&
+        git submodule add -- "$(pwd)/../submodule/.git/" sub &&
+	git commit -asm "replace sub/ with a submodule" &&
+	: then try to update the "temp" branch &&
+	git checkout temp &&
+	git merge master &&
+	: and finally cleanse the mess &&
+	cd .. &&
+	rm -rf test
+'
+
+test_done
-- 
1.5.6.3
