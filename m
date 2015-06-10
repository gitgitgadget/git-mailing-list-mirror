From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 3/4] git-p4: add tests for non-numeric revision range
Date: Wed, 10 Jun 2015 08:30:58 +0100
Message-ID: <1433921459-16555-4-git-send-email-luke@diamand.org>
References: <1433921459-16555-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 09:32:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2aUf-0000Hh-NE
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbbFJHcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:32:10 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34216 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964891AbbFJHb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:31:58 -0400
Received: by wgv5 with SMTP id 5so28774927wgv.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 00:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROTUGIsyE06569Y/tql7dT0fYjGQnRwK4Obb/j4mu8E=;
        b=PsNFvAkrJmy5HXj+nCEiJ75hT2MfJITUekgLNP87Gl5riQoUMI6RLDOWnvdb244deB
         0mdc9QpL2IBdTJeNBRddCaiR7QBUVC1MVQIoa0sW/UpPDaGyforp7hHqUowPVx6meP6v
         FC0HI6vk4oiY1LKwGLGpydIa+m10f68SUm3pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ROTUGIsyE06569Y/tql7dT0fYjGQnRwK4Obb/j4mu8E=;
        b=MCwdU+JjdtRxjeh2FbcGAw5RRLaIT0nqcSlWxK3lpghWXSceYLldC44tEFnoJazoJp
         XNInNdFpwfoL4I2siF+YkPaMEaYu6io8JeacN6UjApkHVmEJKtgEMHE5Y+yfw9Ks3RJX
         yLuZHUhaweQVozEZggS51eMtFaUTvFNxIJ9xjpoOjVidC8EqGtTnex+Jpc0WpovcE8Lw
         cTzwNubRnU6hiTJ/TPeuZwXQ56feEQckTNiWzi8iHkioIrq2dCpwyXV7GmkbhvjQXwHV
         9BF07fsXP2+YVqxa5Z6aIYlHuTp8mUd1a2OAJjytjnryC8NOL17BwL6tF29neK9RTBxH
         yusw==
X-Gm-Message-State: ALoCoQl41QWywtx1JZRof09JUPSYNdrx0La0EpA2l8KFCkZtR6VX/whJQLKbT7je2JC0/7Ea/940
X-Received: by 10.180.231.40 with SMTP id td8mr5693619wic.9.1433921517602;
        Wed, 10 Jun 2015 00:31:57 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id n8sm6453997wiy.19.2015.06.10.00.31.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 00:31:56 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1433921459-16555-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271263>

Test that git-p4 can handle a sync with a non-numeric revision
range (e.g. a date).

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9800-git-p4-basic.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 5b56212..90d41ed 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -131,6 +131,44 @@ test_expect_success 'clone two dirs, @all, conflicting files' '
 	)
 '
 
+revision_ranges="2000/01/01,#head \
+		 1,2080/01/01 \
+		 2000/01/01,2080/01/01 \
+		 2000/01/01,1000 \
+		 1,1000"
+
+test_expect_success 'clone using non-numeric revision ranges' '
+	test_when_finished cleanup_git &&
+	for r in $revision_ranges
+	do
+		rm -fr "$git" &&
+		test ! -d "$git" &&
+		git p4 clone --dest="$git" //depot@$r &&
+		(
+			cd "$git" &&
+			git ls-files >lines &&
+			test_line_count = 6 lines
+		)
+	done
+'
+
+test_expect_success 'clone with date range, excluding some changes' '
+	test_when_finished cleanup_git &&
+	before=$(date +%Y/%m/%d:%H:%M:%S) &&
+	sleep 2 &&
+	(
+		cd "$cli" &&
+		:>date_range_test &&
+		p4 add date_range_test &&
+		p4 submit -d "Adding file"
+	) &&
+	git p4 clone --dest="$git" //depot@1,$before &&
+	(
+		cd "$git" &&
+		test_path_is_missing date_range_test
+	)
+'
+
 test_expect_success 'exit when p4 fails to produce marshaled output' '
 	mkdir badp4dir &&
 	test_when_finished "rm badp4dir/p4 && rmdir badp4dir" &&
-- 
2.4.1.502.gb11c5ab
