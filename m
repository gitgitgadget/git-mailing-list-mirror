From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 1/4] git-p4: additional testing of --changes-block-size
Date: Wed, 10 Jun 2015 08:30:56 +0100
Message-ID: <1433921459-16555-2-git-send-email-luke@diamand.org>
References: <1433921459-16555-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 09:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2aUf-0000Hh-50
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbbFJHcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:32:06 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36147 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511AbbFJHb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:31:56 -0400
Received: by wgbgq6 with SMTP id gq6so28788158wgb.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vO8NcHJyPWYP1mLB0bTwh/NHwckIAEutwSag4XHNqJI=;
        b=UHaKDJJ3kUQkULLUSMg0FMQDch3cF7cJRElQBS2u+0SGNlJleIYZGnfmx9tU3zvS+j
         ZcyPboc+/PnlL2tsGDCJT6mDVI6/pXbLRwklVGdTEF8LBaJQA3ambXlA89VMaAFb7J6U
         oMnioII2OoiyqFWafT2WwDM2FIPAoHed/HsLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vO8NcHJyPWYP1mLB0bTwh/NHwckIAEutwSag4XHNqJI=;
        b=N34jBTqLW99CF3S7+DkVvoVbn+MoJTReYSxWuLtgHEglaXJ5bTGAZaENLcMrOU6eDf
         gIXM8NcLzozBGTz9izCEYj8hUi/Y6411SPY8LiEzOezqZ8cOdZ3aYh5M/VxaJPUZcTiM
         cvDGcC9ASZomrR8jq3UNup+T/nfKilh8rw42snCNSWHarDnUgFR7xMqj18jQc6gce11S
         jh5BvGg/nnNxsgKcVp1a3CVcfkpbGijPakLa/K82+UPiAGk2WtGwL1B80siBFXPyXLiP
         7XXe7VBb+d1+2EknmEy3JDrkeBAWbkcJ1ZKQINWZS3B4bU5z2uF88NH47LV8jgrBKDxs
         9dQQ==
X-Gm-Message-State: ALoCoQkqi6aglGH72EvtKu7D4STTGlvHayT+ih46KkpVdirKlx7nfA9+OS0LRKcD9gu1LU8E8pjt
X-Received: by 10.181.11.193 with SMTP id ek1mr5556471wid.15.1433921514632;
        Wed, 10 Jun 2015 00:31:54 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id n8sm6453997wiy.19.2015.06.10.00.31.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 00:31:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1433921459-16555-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271265>

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
