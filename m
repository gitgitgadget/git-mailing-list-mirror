From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/3] git-p4: additional testing of --changes-block-size
Date: Sun,  7 Jun 2015 22:35:03 +0100
Message-ID: <1433712905-7508-2-git-send-email-luke@diamand.org>
References: <55747A05.3070704@diamand.org>
 <1433712905-7508-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 23:36:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1iEo-0007IA-GZ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 23:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbbFGVgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 17:36:00 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33704 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbFGVf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 17:35:57 -0400
Received: by wiwd19 with SMTP id d19so67515852wiw.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vO8NcHJyPWYP1mLB0bTwh/NHwckIAEutwSag4XHNqJI=;
        b=E2UrliXtRRmCspb0XCqYcieEJgVptFWZh6XbqeZ/ZSHDFYvKLQAyvbNh/SCWaVfB7a
         5TV7tn7Cb5l8+D8PC1Fo0u6YlnzgAtPkb+MKDZq50tpVZWHh96KkNX95ULnFE5nhD/y0
         2ljtKsRfOUxsFrvxJ1826L+zNacr5m3nrUNu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vO8NcHJyPWYP1mLB0bTwh/NHwckIAEutwSag4XHNqJI=;
        b=DgFvwocIRc2iQAJ6oaqtH8JzUJ3hptB9Iz88QyDfK/yppEBipWB5E278AT7edgR4eQ
         rZ+t4Yo43E21SNhfoCfvzV+l/BVQpWGLGQPhz2+x55X1za/rDTGLj1N3N9CldKck6teR
         L8u2rAr5JJzhP0qz+ybjLifOsVbOTxwtTfiRWKYWDeNyvajzOVVBxM4BO0g4ZyvQxeM5
         4PVCrK8GFcPkc53PdMZS2VZvlUrHAuHly0fMVICYB9+6J79aTxhNZW6Gkvc5cyuaSirp
         SfeQM2Crdlt0t9u4aadwlyr9tC0lDQNOB8tRn/fADP4fOLICOlypggP+S1lU67LfG4Wb
         xM3A==
X-Gm-Message-State: ALoCoQlNSyN9Z14AyAqlFxqG46yL4Jlnkc3+AN11zfXWTr2iwQ+ylc7dihl0m5EmS5LghwuVRbkH
X-Received: by 10.194.82.38 with SMTP id f6mr25264107wjy.16.1433712955919;
        Sun, 07 Jun 2015 14:35:55 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id w11sm1140489wjr.48.2015.06.07.14.35.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 14:35:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1433712905-7508-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270980>

Add additional tests of some corner-cases of the
--changes-block-size git-p4 parameter.

Also reduce the number of p4 changes created during the
tests, so that they complete faster.

Signed-off-by: Luke Diamand <luke@diamand.org>
Acked-by: Lex Spoon <lex@lexspoon.org>
---
 t/t9818-git-p4-block.sh | 56 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 153b20a..79765a4 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -8,18 +8,21 @@ test_expect_success 'start p4d' '
 	start_p4d
 '
 
-test_expect_success 'Create a repo with ~100 changes' '
+test_expect_success 'Create a repo with many changes' '
 	(
-		cd "$cli" &&
+		client_view "//depot/included/... //client/included/..." \
+			    "//depot/excluded/... //client/excluded/..." &&
+		mkdir -p "$cli/included" "$cli/excluded" &&
+		cd "$cli/included" &&
 		>file.txt &&
 		p4 add file.txt &&
 		p4 submit -d "Add file.txt" &&
-		for i in $(test_seq 0 9)
+		for i in $(test_seq 0 5)
 		do
 			>outer$i.txt &&
 			p4 add outer$i.txt &&
 			p4 submit -d "Adding outer$i.txt" &&
-			for j in $(test_seq 0 9)
+			for j in $(test_seq 0 5)
 			do
 				p4 edit file.txt &&
 				echo $i$j >file.txt &&
@@ -30,33 +33,68 @@ test_expect_success 'Create a repo with ~100 changes' '
 '
 
 test_expect_success 'Clone the repo' '
-	git p4 clone --dest="$git" --changes-block-size=10 --verbose //depot@all
+	git p4 clone --dest="$git" --changes-block-size=7 --verbose //depot/included@all
 '
 
 test_expect_success 'All files are present' '
 	echo file.txt >expected &&
 	test_write_lines outer0.txt outer1.txt outer2.txt outer3.txt outer4.txt >>expected &&
-	test_write_lines outer5.txt outer6.txt outer7.txt outer8.txt outer9.txt >>expected &&
+	test_write_lines outer5.txt >>expected &&
 	ls "$git" >current &&
 	test_cmp expected current
 '
 
 test_expect_success 'file.txt is correct' '
-	echo 99 >expected &&
+	echo 55 >expected &&
 	test_cmp expected "$git/file.txt"
 '
 
 test_expect_success 'Correct number of commits' '
 	(cd "$git" && git log --oneline) >log &&
-	test_line_count = 111 log
+	wc -l log &&
+	test_line_count = 43 log
 '
 
 test_expect_success 'Previous version of file.txt is correct' '
 	(cd "$git" && git checkout HEAD^^) &&
-	echo 97 >expected &&
+	echo 53 >expected &&
 	test_cmp expected "$git/file.txt"
 '
 
+# Test git-p4 sync, with some files outside the client specification.
+
+p4_add_file() {
+	(cd "$cli" &&
+		>$1 &&
+		p4 add $1 &&
+		p4 submit -d "Added a file" $1
+	)
+}
+
+test_expect_success 'Add some more files' '
+	for i in $(test_seq 0 10)
+	do
+		p4_add_file "included/x$i" &&
+		p4_add_file "excluded/x$i"
+	done &&
+	for i in $(test_seq 0 10)
+	do
+		p4_add_file "excluded/y$i"
+	done
+'
+
+# This should pick up the 10 new files in "included", but not be confused
+# by the additional files in "excluded"
+test_expect_success 'Syncing files' '
+	(
+		cd "$git" &&
+		git p4 sync --changes-block-size=7 &&
+		git checkout p4/master &&
+		ls -l x* > log &&
+		test_line_count = 11 log
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.4.1.502.gb11c5ab
