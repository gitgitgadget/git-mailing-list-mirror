From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix rev-list when showing objects involving submodules
Date: Sun, 11 Nov 2007 23:35:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711112335020.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 12 00:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrMLH-0002p3-M3
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 00:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbXKKXfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 18:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754961AbXKKXfg
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 18:35:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:39913 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752485AbXKKXff (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 18:35:35 -0500
Received: (qmail invoked by alias); 11 Nov 2007 23:35:34 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp030) with SMTP; 12 Nov 2007 00:35:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Jjnpj3aAJ/txLec/EN5iUnYqrDqJVgL2cpNPPL8
	uVvpiR6e6IctBe
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64536>


The function mark_tree_uninteresting() assumed that the tree entries
are blob when they are not trees.  This is not so.  Since we do
not traverse into submodules (yet), the gitlinks should be ignored.

Noticed by Ilari on IRC.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 revision.c                    |    2 +-
 t/t6008-rev-list-submodule.sh |   42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletions(-)
 create mode 100755 t/t6008-rev-list-submodule.sh

diff --git a/revision.c b/revision.c
index 931f978..81b5a93 100644
--- a/revision.c
+++ b/revision.c
@@ -69,7 +69,7 @@ void mark_tree_uninteresting(struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
 			mark_tree_uninteresting(lookup_tree(entry.sha1));
-		else
+		else if (!S_ISGITLINK(entry.mode))
 			mark_blob_uninteresting(lookup_blob(entry.sha1));
 	}
 
diff --git a/t/t6008-rev-list-submodule.sh b/t/t6008-rev-list-submodule.sh
new file mode 100755
index 0000000..88e96fb
--- /dev/null
+++ b/t/t6008-rev-list-submodule.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='git rev-list involving submodules that this repo has'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	: > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo 1 > file &&
+	test_tick &&
+	git commit -m second file &&
+	echo 2 > file &&
+	test_tick &&
+	git commit -m third file &&
+
+	rm .git/index &&
+
+	: > super-file &&
+	git add super-file &&
+	git submodule add . sub &&
+	git symbolic-ref HEAD refs/heads/super &&
+	test_tick &&
+	git commit -m super-initial &&
+	echo 1 > super-file &&
+	test_tick &&
+	git commit -m super-first super-file &&
+	echo 2 > super-file &&
+	test_tick &&
+	git commit -m super-second super-file
+'
+
+test_expect_success "Ilari's test" '
+	git rev-list --objects super master ^super^
+'
+
+test_done
-- 
1.5.3.5.1695.g146d07
