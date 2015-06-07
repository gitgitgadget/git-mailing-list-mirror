From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/3] git-p4: test with limited p4 server results
Date: Sun,  7 Jun 2015 22:35:04 +0100
Message-ID: <1433712905-7508-3-git-send-email-luke@diamand.org>
References: <55747A05.3070704@diamand.org>
 <1433712905-7508-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 23:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1iEp-0007IA-9V
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 23:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbbFGVgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 17:36:03 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34714 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbFGVf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 17:35:58 -0400
Received: by wibut5 with SMTP id ut5so67483021wib.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pNyrSxBWaxieR35A0CMpdkaTRBvGhYV3U1v1nGgBLOQ=;
        b=UU0JxHir+Tpz45bWDdpskYSC1sPZ0cDKAhAyDaokwTnqEI+1PF6TqqVv8i6rjR2hxT
         inrdwivGP3d1o3N3N7bkLznaglMG1cSzmUbDhOxyjvfD+lpNbUh4SR2pOg2pJ5Wt0sWF
         XhdxWdj8ROQ6PFsK1WgMQ0iJaBghk2lDY6dLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pNyrSxBWaxieR35A0CMpdkaTRBvGhYV3U1v1nGgBLOQ=;
        b=ecuamP7Atf1/veleg5OzYrpOgeKxj4eDY2BreieFtCf42eEJmccctrhxwHOCBI1m26
         5q65j/9PMXutOmFI4JYgTk2zUhiFG42bQpZDj0xXFtLF9e7uqlPt+RMXi2vM16WpGU4Z
         /51z/M9OSbJAMPIK1AiTNCNOP/6+SykpYOgC+DGAAC1mFzM9j6dGyUpliyOXyDIxdU/D
         rcFeOIEFvp7+/KhUXpDlJNaPQrwV2Hf4lqehLK77LkSIVq8v2OfWCVOXrO80+/axYCh1
         ZQyNArJPcgNZ480MPhKsFJ5YI1ZM1iVcqF63g096pAow+yh9oTsckdJAMu9AaEBSLIqQ
         O6+A==
X-Gm-Message-State: ALoCoQkjgtaWftTSB1hKzgmh3Ku41r0r56w/FGE+zngO5aU1E5thMQqCdDy9WPJLGzPOgmHyTWeT
X-Received: by 10.194.109.36 with SMTP id hp4mr25711801wjb.4.1433712957355;
        Sun, 07 Jun 2015 14:35:57 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id w11sm1140489wjr.48.2015.06.07.14.35.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 14:35:56 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1433712905-7508-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270982>

Change the --changes-block-size git-p4 test to use an account with
limited "maxresults" and "maxscanrows" values.

These conditions are applied in the server *before* the "-m maxchanges"
parameter to "p4 changes" is applied, and so the strategy that git-p4
uses for limiting the number of changes does not work. As a result,
the tests all fail.

Note that "maxscanrows" is set quite high, as it appears to not only
limit results from "p4 changes", but *also* limits results from
"p4 print". Files that have more than "maxscanrows" changes seem
(experimentally) to be impossible to print. There's no good way to
work around this.

Signed-off-by: Luke Diamand <luke@diamand.org>
Acked-by: Lex Spoon <lex@lexspoon.org>
---
 t/t9818-git-p4-block.sh | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 79765a4..aae1121 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -8,6 +8,19 @@ test_expect_success 'start p4d' '
 	start_p4d
 '
 
+create_restricted_group() {
+	p4 group -i <<-EOF
+	Group: restricted
+	MaxResults: 7
+	MaxScanRows: 40
+	Users: author
+	EOF
+}
+
+test_expect_success 'Create group with limited maxrows' '
+	create_restricted_group
+'
+
 test_expect_success 'Create a repo with many changes' '
 	(
 		client_view "//depot/included/... //client/included/..." \
@@ -32,11 +45,15 @@ test_expect_success 'Create a repo with many changes' '
 	)
 '
 
-test_expect_success 'Clone the repo' '
+test_expect_success 'Default user cannot fetch changes' '
+	! p4 changes -m 1 //depot/...
+'
+
+test_expect_failure 'Clone the repo' '
 	git p4 clone --dest="$git" --changes-block-size=7 --verbose //depot/included@all
 '
 
-test_expect_success 'All files are present' '
+test_expect_failure 'All files are present' '
 	echo file.txt >expected &&
 	test_write_lines outer0.txt outer1.txt outer2.txt outer3.txt outer4.txt >>expected &&
 	test_write_lines outer5.txt >>expected &&
@@ -44,18 +61,18 @@ test_expect_success 'All files are present' '
 	test_cmp expected current
 '
 
-test_expect_success 'file.txt is correct' '
+test_expect_failure 'file.txt is correct' '
 	echo 55 >expected &&
 	test_cmp expected "$git/file.txt"
 '
 
-test_expect_success 'Correct number of commits' '
+test_expect_failure 'Correct number of commits' '
 	(cd "$git" && git log --oneline) >log &&
 	wc -l log &&
 	test_line_count = 43 log
 '
 
-test_expect_success 'Previous version of file.txt is correct' '
+test_expect_failure 'Previous version of file.txt is correct' '
 	(cd "$git" && git checkout HEAD^^) &&
 	echo 53 >expected &&
 	test_cmp expected "$git/file.txt"
@@ -85,7 +102,7 @@ test_expect_success 'Add some more files' '
 
 # This should pick up the 10 new files in "included", but not be confused
 # by the additional files in "excluded"
-test_expect_success 'Syncing files' '
+test_expect_failure 'Syncing files' '
 	(
 		cd "$git" &&
 		git p4 sync --changes-block-size=7 &&
-- 
2.4.1.502.gb11c5ab
