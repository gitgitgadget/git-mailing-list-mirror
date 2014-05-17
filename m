From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 08/10] replace: add tests for --edit
Date: Sat, 17 May 2014 14:16:37 +0200
Message-ID: <20140517121640.27582.46088.chriscool@tuxfamily.org>
References: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 17:58:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlh07-0002cP-LH
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbaEQP5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:57:54 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:55868 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757442AbaEQP5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 11:57:40 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 9D75D5E;
	Sat, 17 May 2014 17:57:39 +0200 (CEST)
X-git-sha1: d3a91c5d115962181ae2ebd8509eec72045e2628 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249480>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 719a116..68b3cb2 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -318,6 +318,33 @@ test_expect_success 'test --format long' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup a fake editor' '
+	write_script fakeeditor <<-\EOF
+		sed -e "s/A U Thor/A fake Thor/" "$1" >"$1.new"
+		mv "$1.new" "$1"
+	EOF
+'
+
+test_expect_success '--edit with and without already replaced object' '
+	test_must_fail env GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
+	GIT_EDITOR=./fakeeditor git replace --force --edit "$PARA3" &&
+	git replace -l | grep "$PARA3" &&
+	git cat-file commit "$PARA3" | grep "A fake Thor" &&
+	git replace -d "$PARA3" &&
+	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
+	git replace -l | grep "$PARA3" &&
+	git cat-file commit "$PARA3" | grep "A fake Thor"
+'
+
+test_expect_success '--edit and change nothing or command failed' '
+	git replace -d "$PARA3" &&
+	test_must_fail env GIT_EDITOR=true git replace --edit "$PARA3" &&
+	test_must_fail env GIT_EDITOR="./fakeeditor;false" git replace --edit "$PARA3" &&
+	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
+	git replace -l | grep "$PARA3" &&
+	git cat-file commit "$PARA3" | grep "A fake Thor"
+'
+
 test_expect_success 'replace ref cleanup' '
 	test -n "$(git replace)" &&
 	git replace -d $(git replace) &&
-- 
1.9.rc0.17.g651113e
