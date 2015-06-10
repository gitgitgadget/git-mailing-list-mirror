From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 2/4] git-p4: test with limited p4 server results
Date: Wed, 10 Jun 2015 08:30:57 +0100
Message-ID: <1433921459-16555-3-git-send-email-luke@diamand.org>
References: <1433921459-16555-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 09:32:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2aUe-0000Hh-J8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbbFJHcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:32:02 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33232 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbbFJHb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:31:57 -0400
Received: by wgez8 with SMTP id z8so28771506wge.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pNyrSxBWaxieR35A0CMpdkaTRBvGhYV3U1v1nGgBLOQ=;
        b=Qz6bdbcaCKLVdmZgwJQcu6gmzeRrgNydLhDgMMiyYNlb00iGTdyOpgsM5w4FaRX5hi
         w7pBk/Y1uQ6VHkvJPqp36fHIfeRoNbay6VtlHFofsmxwRxhHnBly4u11SwB71Ip7z3Jy
         uZi65ckKn50puzQ23Lmd8BGtOoeK6cgPgC0ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pNyrSxBWaxieR35A0CMpdkaTRBvGhYV3U1v1nGgBLOQ=;
        b=jgDTE0xmk3uah60t+A92L3td8Ns1bAgsGovfPblXtnFa/W01WrJE6JEgYVkDcmuG0O
         zZmjoOzJg9jDJsFn6uFDBsTMzO08I9jhjgZHE84E7Qi72rtExslc4rjSV7WXVzUc1z3G
         zD+bWKVta0g/UJzMT2XQLXDBYesaC4nFcWHDdXkpocFn5d5zosuTU6Mty11TSj9uf6MB
         tdoODazWLyJtb6uxrsv0zUv+qF2QwdqfgCg89Nt66bSrCgFpeiFzbkVLoHVRmZM8P2MN
         z/d0Z6H8qbXQeMMx6Rhh1iR0RdykwZNYm2KfBGeI9ZlvRiGYbCaG0UlaktjgORQCfKDO
         CtCg==
X-Gm-Message-State: ALoCoQl8tQ37rnO/2GRAXzYBRv2UQNr84rsAnQq/ProSSMk1r+YwuKRnIMguq+OHKu6NkQXah7cw
X-Received: by 10.181.11.229 with SMTP id el5mr5689074wid.40.1433921516290;
        Wed, 10 Jun 2015 00:31:56 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id n8sm6453997wiy.19.2015.06.10.00.31.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 00:31:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1433921459-16555-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271264>

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
