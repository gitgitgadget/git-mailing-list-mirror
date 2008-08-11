From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add a new test to ensure merging a submodule is handled properly.
Date: Mon, 11 Aug 2008 22:48:00 +0200
Message-ID: <1218487680-7933-1-git-send-email-vmiklos@frugalware.org>
References: <20080811204511.GV18960@genesis.frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeJl-0002kR-G3
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbYHKUrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbYHKUrd
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:47:33 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:50316 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbYHKUrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:47:32 -0400
Received: from vmobile.example.net (dsl5401CD7E.pool.t-online.hu [84.1.205.126])
	by yugo.frugalware.org (Postfix) with ESMTP id 0ABCC1DDC5B;
	Mon, 11 Aug 2008 22:47:30 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9A2451A5FBF; Mon, 11 Aug 2008 22:48:00 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <20080811204511.GV18960@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92000>

In this test we cause a directory / submodule conflict then we check if
the index is unlocked properly.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I'm no exactly sure if this should be included or not, I just wrote it
to make sure that a die() insure merge-recursive will not cause an
unlocked index at the end.

 t/t7607-merge-submodule.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 t/t7607-merge-submodule.sh

diff --git a/t/t7607-merge-submodule.sh b/t/t7607-merge-submodule.sh
new file mode 100755
index 0000000..552930a
--- /dev/null
+++ b/t/t7607-merge-submodule.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing if a directory / submodule conflict is handled properly.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir lib &&
+	cd lib &&
+	git init &&
+	echo c1 >c1.c &&
+	git add c1.c &&
+	git commit -m "submodule init" &&
+	mkdir ../main &&
+	cd ../main &&
+	git init &&
+	echo main >main.c &&
+	git add main.c &&
+	git commit -m "c0: main init" &&
+	git tag c0 &&
+	mkdir lib &&
+	echo lib >lib/c1.c &&
+	git add lib/c1.c &&
+	git commit -m "c1: lib init" &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	git submodule add "`pwd`/../lib" lib &&
+	git commit -m "c2: add submodule" &&
+	git tag c2
+'
+
+test_expect_success 'dir/submodule conflict' '
+	git reset --hard c1 &&
+	test_must_fail git merge c2 &&
+	test ! -f .git/index.lock
+'
+
+test_done
-- 
1.6.0.rc0.14.g95f8.dirty
