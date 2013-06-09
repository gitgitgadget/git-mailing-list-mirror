From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] t/push-default: test pushdefault with all modes
Date: Sun,  9 Jun 2013 22:43:20 +0530
Message-ID: <1370798000-2358-5-git-send-email-artagnon@gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:15:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljDf-000296-06
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab3FIRPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:15:34 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:47525 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab3FIRPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:15:32 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so6488974pbc.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TaxzxWHX1mw24CpB9GrB6/FAXop9QkeEmVG5s3mRtwQ=;
        b=sFk/7vZ5EazlRl+NqM0C+d5gyharHSuA9rJuEYgVC2oaFUU/U78ruWAHv6Fn7TxpyK
         Czv42+lUjpvRsPZrP5cHgRRUrr5P30W/hNP1n14gcApDIADGCceLqm+voytQ31c9JC/Z
         3dbIfSgLzqrkOe4a1UjE5Pctg40cx+Kk5XE0jiw0NGpM7uMVAHZQm9vEMFGmcunJEbOh
         cHNb7+DngPUEx6aAQ5Oqm7ueOSWpB1EPxGa4zefC8E4pnRL+CEuV1xHb99SBMnfq5EPg
         wTJWQt2/Za8wcIpCmjxa9WQ4hRo5rkxrZom7Ayr/gsm+2imv171oJxZ1wFKgsqUSCvuH
         //KQ==
X-Received: by 10.68.191.167 with SMTP id gz7mr6937055pbc.16.1370798132001;
        Sun, 09 Jun 2013 10:15:32 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm7235373pbc.12.2013.06.09.10.15.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:15:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227031>

Introduce test_pushdefault_with_mode() to test that remote.pushdefault
works with all the push.default modes correctly.  Exercise it with all
four modes to illustrate how triangular workflows work, and to guard
against regressions.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5528-push-default.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 9ddd3a9..9762515 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -39,6 +39,19 @@ test_push_failure () {
 	test_cmp expect actual
 }
 
+# $1 = push.default value
+# $2 = branch.master.merge value (master or foo)
+# $3 = branch to check for actual output (master or foo)
+test_pushdefault_with_mode () {
+test_expect_success "push.default = $1 works with remote.pushdefault" "
+	test_config branch.master.remote parent1 &&
+	test_config branch.master.merge refs/heads/$2 &&
+	test_config remote.pushdefault parent2 &&
+	test_commit commit-for-$1 &&
+	test_push_success $1 $3 repo2
+"
+}
+
 test_expect_success '"upstream" pushes to configured upstream' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
@@ -115,4 +128,9 @@ test_expect_success 'push to existing branch, upstream configured with different
 	test_cmp expect-other-name actual-other-name
 '
 
+test_pushdefault_with_mode "matching" "foo" "master"
+test_pushdefault_with_mode "upstream" "foo" "foo"
+test_pushdefault_with_mode "simple" "master" "master"
+test_pushdefault_with_mode "current" "foo" "master"
+
 test_done
-- 
1.8.3.247.g485169c
