From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [REVISED PATCH 4/6] Add a test script for "git notes"
Date: Thu, 19 Jul 2007 03:32:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707190331430.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160024060.14781@racer.site> <7v3azp6igt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 04:32:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBLob-0005Uc-EM
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 04:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbXGSCcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 22:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXGSCcL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 22:32:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:37612 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750727AbXGSCcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 22:32:09 -0400
Received: (qmail invoked by alias); 19 Jul 2007 02:32:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 19 Jul 2007 04:32:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1984PYQJ5V8YClTgglurtHCBH3Vhqn1izr4VbApxC
	3xc4noMcZtPjby
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3azp6igt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52926>


Incidentally, a test for "git notes" implies a test for the
whole commit notes machinery.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3301-notes.sh |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100755 t/t3301-notes.sh

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
new file mode 100755
index 0000000..ba42c45
--- /dev/null
+++ b/t/t3301-notes.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test commit notes'
+
+. ./test-lib.sh
+
+cat > fake_editor.sh << \EOF
+echo "$MSG" > "$1"
+echo "$MSG" >& 2
+EOF
+chmod a+x fake_editor.sh
+VISUAL=./fake_editor.sh
+export VISUAL
+
+test_expect_success 'cannot annotate non-existing HEAD' '
+	! MSG=3 git notes edit
+'
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
+test_expect_success 'need valid notes ref' '
+	! MSG=1 GIT_NOTES_REF='/' git notes edit &&
+	! MSG=2 GIT_NOTES_REF='/' git notes show
+'
+
+test_expect_success 'create notes' '
+	git config core.notesRef refs/notes/commits &&
+	MSG=b1 git notes edit &&
+	test ! -f .git/new-notes &&
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
1.5.3.rc1.16.g9d6f-dirty
