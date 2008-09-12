From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 5/6] t7400: Add short "git submodule add" testsuite
Date: Fri, 12 Sep 2008 23:09:19 +0200
Message-ID: <20080912210918.31628.97855.stgit@localhost>
References: <20080912210817.31628.69014.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 23:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeFuP-0006J2-Ou
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 23:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757666AbYILVJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757795AbYILVJX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:09:23 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:53674 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757666AbYILVJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 17:09:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 1E77B2AC8A7;
	Fri, 12 Sep 2008 23:09:19 +0200 (CEST)
In-Reply-To: <20080912210817.31628.69014.stgit@localhost>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95768>

This patch introduces basic tests for

	git submodule add

covering the basic functionality and the -b parameter.

A trivial update --init test fix freeloads on this commit as well.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 t/t7400-submodule-basic.sh |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index be73f7b..8a002bc 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -200,7 +200,7 @@ test_expect_success 'update --init' '
 
 	mv init init2 &&
 	git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
-	git config --remove-section submodule.example
+	git config --remove-section submodule.example &&
 	git submodule update init > update.out &&
 	grep "not initialized" update.out &&
 	test ! -d init/.git &&
@@ -209,4 +209,30 @@ test_expect_success 'update --init' '
 
 '
 
+test_expect_success 'submodule add' '
+
+	git submodule add "$(pwd)/init2" init-added &&
+	test -d init-added/.git &&
+	[ "$(git config -f .gitmodules submodule.init-added.url)" = "$(pwd)/init2" ] &&
+	[ "$(git config -f .gitmodules submodule.init-added.path)" = "init-added" ]
+
+'
+
+test_expect_success 'submodule add -b' '
+
+	(
+		cd init2 &&
+		git checkout -b branch &&
+		echo t >s &&
+		git add s &&
+		git commit -m "change branch" &&
+		git checkout master
+	) &&
+	git submodule add -b branch -- "$(pwd)/init2" init-added-b &&
+	test -d init-added-b/.git &&
+	[ "$(git config -f .gitmodules submodule.init-added-b.url)" = "$(pwd)/init2" ] &&
+	[ "$(cd init2 && git rev-parse branch)" = "$(cd init-added-b && git rev-parse HEAD)" ]
+
+'
+
 test_done
