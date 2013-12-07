From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/10] t6050: add tests for listing with --format
Date: Sat, 07 Dec 2013 17:21:03 +0100
Message-ID: <20131207162106.21478.8850.chriscool@tuxfamily.org>
References: <20131207160514.21478.72966.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:22:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpKdr-0004rk-TZ
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758850Ab3LGQWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:22:00 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:44315 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758793Ab3LGQVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:21:51 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 3329D4C;
	Sat,  7 Dec 2013 17:21:50 +0100 (CET)
X-git-sha1: cf5b3e1a703b8388c77ed7f17c60b55d358bb761 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131207160514.21478.72966.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238993>

This patch adds tests for "git replace -l --format=<fmt>".
Only tests when <fmt> is 'medium' and 'full' are needed
because 'short' is the same as with no --format option.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index bb785ec..3627b4c 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -281,6 +281,33 @@ test_expect_success 'git cat-file --batch works on replace objects' '
 	echo $PARA3 | git cat-file --batch
 '
 
+test_expect_success 'test --format medium' '
+	H1=$(git --no-replace-objects rev-parse HEAD~1) &&
+	HT=$(git --no-replace-objects rev-parse HEAD^{tree}) &&
+	MYTAG=$(git --no-replace-objects rev-parse mytag) &&
+	{
+		echo "$H1 -> $BLOB" &&
+		echo "$BLOB -> $REPLACED" &&
+		echo "$HT -> $H1" &&
+		echo "$PARA3 -> $S" &&
+		echo "$MYTAG -> $HASH1"
+	} | sort >expected &&
+	git replace -l --format medium | sort > actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'test --format full' '
+	{
+		echo "$H1 (commit) -> $BLOB (blob)" &&
+		echo "$BLOB (blob) -> $REPLACED (blob)" &&
+		echo "$HT (tree) -> $H1 (commit)" &&
+		echo "$PARA3 (commit) -> $S (commit)" &&
+		echo "$MYTAG (tag) -> $HASH1 (commit)"
+	} | sort >expected &&
+	git replace --format=full | sort > actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'replace ref cleanup' '
 	test -n "$(git replace)" &&
 	git replace -d $(git replace) &&
-- 
1.8.5.1.102.g090758b
