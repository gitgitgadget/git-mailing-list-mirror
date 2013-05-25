From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 29/48] remote-hg: add test for failed double push
Date: Fri, 24 May 2013 21:29:45 -0500
Message-ID: <1369449004-17981-30-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4II-0002Nn-Vi
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab3EYCdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:15 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:60104 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab3EYCdL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:11 -0400
Received: by mail-ob0-f178.google.com with SMTP id v19so6230020obq.37
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wbY/bk8UaGeEtzgva6nJ8mxoS5Jhrdh8OSQu6D/nZQU=;
        b=ZYzJd8tOHXTloTCRnz5uuqkIks8QNRmDP0KHE1cc9cuqAk6TJ3VueqSlfKQS3HJXzb
         taITND2wHA0YEABkCqECbi5HUnqjwIxxyIy9i+uFTinQb09kLlkmJu6dBeMRE6ggckiP
         0b34d/72RvO7sehKe2/ZwkSsI89NrcJQmXWr47XcQGY2MKF1IcdtMXMq8UQjciHirPB+
         SrA3TDtvqDmqu6xTuAND+gyAe8hkiLdA/oaPw1EUI2LT3mEr1n6mvYnzNlRuP3cobgxg
         9nHW42rmDsJ+h4OE5RlkCkrnSdcpMR1NzZKV9VFXHbbVs1YBdXporLdm27NKXw0diozJ
         TlbA==
X-Received: by 10.60.149.231 with SMTP id ud7mr13446835oeb.119.1369449191301;
        Fri, 24 May 2013 19:33:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kd10sm20550662oeb.7.2013.05.24.19.33.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225443>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 1855d1a..c4d98b5 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -486,4 +486,28 @@ test_expect_failure 'remote big push' '
 	check_bookmark hgrepo new_bmark ''
 '
 
+test_expect_failure 'remote double failed push' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	echo one > content &&
+	hg commit -m one
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git reset --hard HEAD^ &&
+	echo two > content &&
+	git commit -a -m two &&
+	test_expect_code 1 git push &&
+	test_expect_code 1 git push
+	)
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
