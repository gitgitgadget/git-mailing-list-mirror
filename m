From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/5] t7610-mergetool: add test cases for mergetool.writeToTemp
Date: Wed, 15 Oct 2014 01:35:19 -0700
Message-ID: <1413362121-17361-3-git-send-email-davvid@gmail.com>
References: <1413362121-17361-1-git-send-email-davvid@gmail.com>
 <1413362121-17361-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:35:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeK3P-00053f-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 10:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbaJOIfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 04:35:21 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41247 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbaJOIfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 04:35:03 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so908337pad.29
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pbiWAxyzfgFyDiYuscsYcvWc681tYHJXwftDvxTkfiI=;
        b=I7GRmbrYjzg07SvgDWJqMrlnYU6bjE2cdYMGbv+NoOxGv9GPQ+9Roimd8z6paaECG6
         mZdxXtoWIi7wlDNsKBkeSiT1JYvIjyANieq7zXEEzGzfHMa/9qJYP0BIGfQqtIZmWazV
         psx81NkF2uY175qG7TiMyA2FGjXCaqXoNx6ti8Zt7Ylfs8c6MlntzLVeeJnEQoeNauQU
         hHXwMXsl9tUxwzEMhUs9cRfGv0W7wWjd98PISsOUHng+A8RRBZR3Flfu7DE9l7TnHtCt
         Utv9rojnfrjnAXRsCXRJE/OTfq1rKPoNPqqfdJLm6E9568Z2Kb6wyF/fhT/ABIFs24wW
         W2aQ==
X-Received: by 10.70.102.162 with SMTP id fp2mr11049278pdb.112.1413362102824;
        Wed, 15 Oct 2014 01:35:02 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id o4sm16371416pdh.56.2014.10.15.01.35.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Oct 2014 01:35:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.453.g1b015e3
In-Reply-To: <1413362121-17361-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to ensure that filenames start with "./" when
mergetool.writeToTemp is false and do not start with "./" when
mergetool.writeToTemp is true.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7610-mergetool.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 214edfb..1a15e06 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -516,4 +516,27 @@ test_expect_success 'custom commands override built-ins' '
 	git reset --hard master >/dev/null 2>&1
 '
 
+test_expect_success 'filenames seen by tools start with ./' '
+	git checkout -b test15 branch1 &&
+	test_config mergetool.writeToTemp false &&
+	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
+	test_config mergetool.myecho.trustExitCode true &&
+	test_must_fail git merge master &&
+	git mergetool --no-prompt --tool myecho -- both >actual &&
+	grep ^\./both_LOCAL_ actual >/dev/null &&
+	git reset --hard master >/dev/null 2>&1
+'
+
+test_expect_success 'temporary filenames are used with mergetool.writeToTemp' '
+	git checkout -b test16 branch1 &&
+	test_config mergetool.writeToTemp true &&
+	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
+	test_config mergetool.myecho.trustExitCode true &&
+	test_must_fail git merge master &&
+	git mergetool --no-prompt --tool myecho -- both >actual &&
+	test_must_fail grep ^\./both_LOCAL_ actual >/dev/null &&
+	grep /both_LOCAL_ actual >/dev/null &&
+	git reset --hard master >/dev/null 2>&1
+'
+
 test_done
-- 
2.1.2.453.g1b015e3
