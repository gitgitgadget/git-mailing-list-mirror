From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some adhocery
Date: Mon, 26 Jun 2006 15:48:48 -0700
Message-ID: <7vr71bh6sv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 27 00:49:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuztN-0006Vs-08
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 00:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350AbWFZWtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933355AbWFZWs5
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 18:48:57 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52886 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S933327AbWFZWst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 18:48:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626224849.NHCX16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 18:48:49 -0400
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 27 Jun 2006 10:20:51 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22686>

I'll be pushing out a new test for format-patch shortly in
"next".

>From ece3c67f9c8f0074cae76204a648cbfc6075bb44 Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Mon, 26 Jun 2006 15:40:09 -0700
Subject: [PATCH] t4014: add format-patch --ignore-if-in-upstream test

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t4014-format-patch.sh |   69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
new file mode 100755
index 0000000..c044044
--- /dev/null
+++ b/t/t4014-format-patch.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Junio C Hamano
+#
+
+test_description='Format-patch skipping already incorporated patches'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	for i in 1 2 3 4 5 6 7 8 9 10; do echo "$i"; done >file &&
+	git add file &&
+	git commit -m Initial &&
+	git checkout -b side &&
+
+	for i in 1 2 5 6 A B C 7 8 9 10; do echo "$i"; done >file &&
+	git update-index file &&
+	git commit -m "Side change #1" &&
+
+	for i in D E F; do echo "$i"; done >>file &&
+	git update-index file &&
+	git commit -m "Side change #2" &&
+	git tag C1 &&
+
+	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >file &&
+	git update-index file &&
+	git commit -m "Side change #3" &&
+
+	git checkout master &&
+	git diff-tree -p C1 | git apply --index &&
+	git commit -m "Master accepts moral equivalent of #1"
+
+'
+
+test_expect_success "format-patch --ignore-if-in-upstream" '
+
+	git format-patch --stdout master..side >patch0 &&
+	cnt=`grep "^From " patch0 | wc -l` &&
+	test "$cnt" = 3
+
+'
+
+test_expect_success "format-patch --ignore-if-in-upstream" '
+
+	git format-patch --stdout \
+		--ignore-if-in-upstream master..side >patch1 &&
+	cnt=`grep "^From " patch1 | wc -l` &&
+	test "$cnt" = 2
+
+'
+
+test_expect_success "format-patch result applies" '
+
+	git checkout -b rebuild-0 master &&
+	git am -3 patch0 &&
+	cnt=`git rev-list master.. | wc -l` &&
+	test "$cnt" = 2
+'
+
+test_expect_success "format-patch --ignore-if-in-upstream result applies" '
+
+	git checkout -b rebuild-1 master &&
+	git am -3 patch1 &&
+	cnt=`git rev-list master.. | wc -l` &&
+	test "$cnt" = 2
+'
+
+test_done
-- 
1.4.1.rc1.g96b82
