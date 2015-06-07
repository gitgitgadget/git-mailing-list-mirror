From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/3] git-p4: test with limited p4 server results
Date: Sun,  7 Jun 2015 11:21:44 +0100
Message-ID: <1433672505-11940-3-git-send-email-luke@diamand.org>
References: <1433672505-11940-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 12:23:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Xj7-0004so-Mk
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 12:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbFGKWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 06:22:43 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33086 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbbFGKWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 06:22:36 -0400
Received: by wgez8 with SMTP id z8so83028958wge.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QvIG6FRM4wQVlr3IzfRihgpIyCvk/qRID61fe9so3GA=;
        b=jIm+gTXnjCqETxaEpqLukI3JyY67L/svlVuCguoq7RnI/LvMJrMD812roqqxjSWGtk
         fceIODJuy/CQBxTFkgpPiPOfeiXTFG+Yi73XIXQf1XtY9HB08xWmMy8QAsLLIuf0nRRf
         nUe9zwOtmYeikViUCkg6rArc1uS9kb78KdI1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QvIG6FRM4wQVlr3IzfRihgpIyCvk/qRID61fe9so3GA=;
        b=POXQFBPRuVlhI8Hr/H5JhOCBrJOlD/IdfUK5MA+lwZfuqbDrmn5e5gh9r/+kz80/Ya
         qq5n2Vf9UGvwvnIx0mZRViRUE9U3IVdANUQI+EipxTHMqRSoIf1joxVb/UbyuVzzFldV
         Rbq4PeeulWK8XfSO/N10Wx/f8WZljjbB+LuwXZuTXyjT3AV6RtxBy3F/u074FJmAcvjA
         z6sTBujd+ZB76CHD4Up6SSt6EU322DINO76DXqzs1Hj5eRuhHkGELMVctMAupCGcPKua
         TLV/nAbnsAKGnsQnxLu04yHnF2zJk4y+AvZXdBkLDR702bjYTzalgqg4+7+S0QD+/uXH
         N3dw==
X-Gm-Message-State: ALoCoQmaO2n7US63EKzEdPVlUiBqcIcvmD04VX9jCzXgUe52BLOqg/l7lSwDjP4NV44og8KVgunY
X-Received: by 10.180.95.163 with SMTP id dl3mr12236699wib.30.1433672555821;
        Sun, 07 Jun 2015 03:22:35 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id w11sm18911961wjr.48.2015.06.07.03.22.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 03:22:35 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1433672505-11940-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270963>

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
2.3.4.48.g223ab37
