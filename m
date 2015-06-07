From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/3] git-p4: additional testing of --changes-block-size
Date: Sun,  7 Jun 2015 11:21:43 +0100
Message-ID: <1433672505-11940-2-git-send-email-luke@diamand.org>
References: <1433672505-11940-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 12:22:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Xj6-0004so-At
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 12:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbbFGKWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 06:22:38 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33993 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbFGKWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 06:22:36 -0400
Received: by wibut5 with SMTP id ut5so58274700wib.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eDVdQV/X3ktSvs3wuIqfM9NooxiZw0+JDVGuyHACPWw=;
        b=gxuwNMmi0gaZuPKTNTQD8rq1NtBCy1c1dbMjkD/Xf+yhtaYldAJzgq9HVUWcmAteD1
         2dru2nubZjPoeVhYWZFDaTadhPWbYlNOJW8ohl6Tpqe6I58ST/k5h3/pmCQfG2Z9jlG/
         gOihrwUCYn4rtyZPNsorBdErGJfu8QhsRvCr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eDVdQV/X3ktSvs3wuIqfM9NooxiZw0+JDVGuyHACPWw=;
        b=gvhF6y5U5NuOHl2JJKlRKu4plElZ1C7dV6DVXwme+ZBg/LcGH2x2wgjDhVyGjnBh0e
         XiyUgM6yU+iEtjtHGANDOzzTpuUlmL+HO0sgwfgZZNCrlyCQAoIDajGNHq2M0uKAEbFK
         aetPvMVDL0pmrudoQLxfOVmNZhjCCeylZKqMfmIcVImvkniUXpdOA/lzGVVOa+JxqQWp
         d8bcw8sM6/37ED4Ctsl2FPJICtkgZcM6oCPnIXX4bsx/NVQT0soMDeIr/vB+/lERaDSK
         EuFbrcmooDXxG51oZ7IEWJu+7//4qchi7jgAMAI3pPyTx70K+V1HvPrt4njafVi9ORLO
         b7ew==
X-Gm-Message-State: ALoCoQnBx6VuKyuyGxWnWDRVPm5gNOGjtzQZh51PEMIbxyFX11tiPhGKZKgzoPJdFMFu9vfsNSYh
X-Received: by 10.180.90.73 with SMTP id bu9mr12192121wib.88.1433672555011;
        Sun, 07 Jun 2015 03:22:35 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id w11sm18911961wjr.48.2015.06.07.03.22.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 03:22:34 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1433672505-11940-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270961>

Add additional tests of some corner-cases of the
--changes-block-size git-p4 parameter.

Also reduce the number of p4 changes created during the
tests, so that they complete faster.

Signed-off-by: Luke Diamand <luke@diamand.org>
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
2.3.4.48.g223ab37
