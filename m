From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/6] Add a test script for "git notes"
Date: Mon, 16 Jul 2007 00:24:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160024060.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:25:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADSf-0001Zb-O7
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbXGOXYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757799AbXGOXYb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:24:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:54508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753712AbXGOXYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:24:30 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:24:29 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp047) with SMTP; 16 Jul 2007 01:24:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+omWI0MEqo+ZP2BsXvfefqQU+6YWAVS9WhzC7LgC
	R5NgzQJ4+rcu5D
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707152326080.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52603>


Incidentally, a test for "git notes" implies a test for the
whole commit notes machinery.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3301-notes.sh |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100755 t/t3301-notes.sh

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
new file mode 100755
index 0000000..eb50191
--- /dev/null
+++ b/t/t3301-notes.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test commit notes'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	: > a1 &&
+	git add a1 &&
+	test_tick &&
+	git commit -m 1st &&
+	: > a2 &&
+	git add a2 &&
+	test_tick &&
+	git commit -m 2nd
+'
+
+cat > fake_editor.sh << EOF
+echo "\$MSG" > "\$1"
+echo "\$MSG" >& 2
+EOF
+chmod a+x fake_editor.sh
+VISUAL="$(pwd)"/fake_editor.sh
+export VISUAL
+
+
+test_expect_success 'need notes ref' '
+	! MSG=1 git notes edit &&
+	! MSG=2 git notes show
+'
+
+test_expect_success 'create notes' '
+	git config core.notesRef refs/notes/commits &&
+	MSG=b1 git notes edit &&
+cat .git/new-notes &&
+test b1 = "$(cat .git/new-notes)" &&
+	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
+	test b1 = $(git notes show) &&
+	git show HEAD^ &&
+	! git notes show HEAD^
+'
+
+cat > expect << EOF
+commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    2nd
+
+Notes:
+    b1
+EOF
+
+test_expect_success 'show notes' '
+	! (git cat-file commit HEAD | grep b1) &&
+	git log -1 > output &&
+	git diff expect output
+'
+
+test_done
-- 
1.5.3.rc1.2718.gd2dc9-dirty
