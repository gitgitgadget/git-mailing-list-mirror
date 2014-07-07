From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 10/10] replace: add test for --graft with a mergetag
Date: Mon, 07 Jul 2014 08:35:39 +0200
Message-ID: <20140707063540.3708.57409.chriscool@tuxfamily.org>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:37:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X42Y1-00085i-4V
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 08:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbaGGGg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 02:36:59 -0400
Received: from [194.158.98.45] ([194.158.98.45]:37423 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751923AbaGGGgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 02:36:39 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 9851A74;
	Mon,  7 Jul 2014 08:36:17 +0200 (CEST)
X-git-sha1: 3c294a392164fe1360fe7e29af0a9313ae3d3277 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252955>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 15fd541..3bb8d06 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -416,4 +416,26 @@ test_expect_success GPG '--graft with a signed commit' '
 	git replace -d $HASH8
 '
 
+test_expect_success GPG 'set up a merge commit with a mergetag' '
+	git reset --hard HEAD &&
+	git checkout -b test_branch HEAD~2 &&
+	echo "line 1 from test branch" >>hello &&
+	echo "line 2 from test branch" >>hello &&
+	git add hello &&
+	test_tick &&
+	git commit -m "hello: 2 more lines from a test branch" &&
+	HASH9=$(git rev-parse --verify HEAD) &&
+	git tag -s -m "tag for testing with a mergetag" test_tag HEAD &&
+	git checkout master &&
+	git merge -s ours test_tag &&
+	HASH10=$(git rev-parse --verify HEAD) &&
+	git cat-file commit $HASH10 | grep "^mergetag object"
+'
+
+test_expect_success GPG '--graft on a commit with a mergetag' '
+	test_must_fail git replace --graft $HASH10 $HASH8^1 &&
+	git replace --graft $HASH10 $HASH8^1 $HASH9 &&
+	git replace -d $HASH10
+'
+
 test_done
-- 
2.0.0.421.g786a89d.dirty
