From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/3] t7603: add new testcases to ensure builtin-commit uses reduce_heads()
Date: Wed, 10 Sep 2008 22:10:33 +0200
Message-ID: <e2b601d3a89785ec9da5de061adc37693a3bd323.1221077214.git.vmiklos@frugalware.org>
References: <cover.1221077214.git.vmiklos@frugalware.org>
 <11d30964e7de652a790f5362f0b49e2a19de17ee.1221077214.git.vmiklos@frugalware.org>
 <2984711bae2f0777b210ed04210693ac02164519.1221077214.git.vmiklos@frugalware.org>
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 22:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdW2S-0003is-I2
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 22:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbYIJUKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 16:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbYIJUKf
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 16:10:35 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36732 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbYIJUKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 16:10:34 -0400
Received: from vmobile.example.net (dsl5401CEA5.pool.t-online.hu [84.1.206.165])
	by yugo.frugalware.org (Postfix) with ESMTPA id 433C1149C61;
	Wed, 10 Sep 2008 22:10:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BAD8784CC; Wed, 10 Sep 2008 22:10:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <2984711bae2f0777b210ed04210693ac02164519.1221077214.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1221077214.git.vmiklos@frugalware.org>
References: <cover.1221077214.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95550>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7603-merge-reduce-heads.sh |   53 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index b47b7b9..7e17eb4 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -60,4 +60,57 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
 	test -f c5.c
 '
 
+test_expect_success 'setup' '
+	for i in A B C D E
+	do
+		echo $i > $i.c &&
+		git add $i.c &&
+		git commit -m $i &&
+		git tag $i
+	done &&
+	git reset --hard A &&
+	for i in F G H I
+	do
+		echo $i > $i.c &&
+		git add $i.c &&
+		git commit -m $i &&
+		git tag $i
+	done
+'
+
+test_expect_success 'merge E and I' '
+	git reset --hard A &&
+	git merge E I
+'
+
+test_expect_success 'verify merge result' '
+	test $(git rev-parse HEAD^1) = $(git rev-parse E) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse I)
+'
+
+test_expect_success 'add conflicts' '
+	git reset --hard E &&
+	echo foo > file.c &&
+	git add file.c &&
+	git commit -m E2 &&
+	git tag E2 &&
+	git reset --hard I &&
+	echo bar >file.c &&
+	git add file.c &&
+	git commit -m I2 &&
+	git tag I2
+'
+
+test_expect_success 'merge E2 and I2, causing a conflict and resolve it' '
+	git reset --hard A &&
+	test_must_fail git merge E2 I2 &&
+	echo baz > file.c &&
+	git add file.c &&
+	git commit -m "resolve conflict"
+'
+
+test_expect_success 'verify merge result' '
+	test $(git rev-parse HEAD^1) = $(git rev-parse E2) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse I2)
+'
 test_done
-- 
1.6.0.1
