From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add tests for git-stash
Date: Sat, 30 Jun 2007 17:06:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301705490.4438@racer.site>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
 <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 18:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4fT9-0002NL-Lj
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 18:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbXF3QGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 12:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbXF3QGe
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 12:06:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:40805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752171AbXF3QGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 12:06:33 -0400
Received: (qmail invoked by alias); 30 Jun 2007 16:06:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 30 Jun 2007 18:06:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+urpw4UnauDk+8grRQl7l42lvBB+06Z/wX9ROhdJ
	G/9YjQgutRyIuH
X-X-Sender: gene099@racer.site
In-Reply-To: <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51222>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	In the current version of git-stash, the last test fails.
	Basically, it tests if different changes to the file "file"
	in the working directory and the index are reconstructed.
	They are not (index changes are not there), but I think they 
	should be.

 t/t3903-stash.sh |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 t/t3903-stash.sh

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
new file mode 100755
index 0000000..6d42373
--- /dev/null
+++ b/t/t3903-stash.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E Schindelin
+#
+
+test_description='Test git-stash'
+
+. ./test-lib.sh
+
+test_expect_success 'stash some dirty working directory' '
+	echo 1 > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo 2 > file &&
+	git add file &&
+	echo 3 > file &&
+	test_tick &&
+	git stash &&
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD
+'
+
+cat > expect << EOF
+diff --git a/file b/file
+index 0cfbf08..00750ed 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-2
++3
+EOF
+
+test_expect_success 'parents of stash' '
+	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
+	git diff stash^2..stash > output &&
+	diff -u output expect
+'
+
+test_expect_success 'apply needs clean working directory' '
+	echo 4 > other-file &&
+	git add other-file &&
+	! git stash apply
+'
+
+test_expect_success 'apply stashed changes' '
+	test_tick &&
+	git commit -m other-file &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
+test_done
-- 
1.5.2.2.3249.g33841
