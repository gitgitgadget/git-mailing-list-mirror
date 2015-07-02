From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 06/12] t4150: am --resolved fails if index has unmerged entries
Date: Fri,  3 Jul 2015 02:16:34 +0800
Message-ID: <1435861000-25278-7-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3K-0006Qa-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbbGBSRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:34 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36497 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbbGBSR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:26 -0400
Received: by pdcu2 with SMTP id u2so49996013pdc.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGDY3U3/tGuxcl1qGodhqNuis2n5C3ZmN8sh1RNBDEQ=;
        b=04IgGPLTFqC8gGrRMN8VOPo4K6ekc+jdvIrSrpxGGG97AVZBkE5LD50xDCvXWkFQQA
         d+IEI8YGngqAtcThyfVQcg5EnBupaVz9zYV9IUVvKDqHQKV1MEFLaKIezwQ7dyCHqqrk
         A5ew8Mng99As4CykQk0AK9aIXWvMER/LxT9BBi08wgJ+O8HsXIhmn3KtZm2MkZMxPgkY
         6rPtgNv9tP4qBdAf3PQaFys7MOyDpZzAqjXF3rPVcWJvr5qKENtdeFCXtD5sVOavfq1c
         zgQocOSlI3j3yEa89+ZBBS7WZqyECsVD67KNtc/GvfDu3qJVkcW4jIO+R7tOyJ/8H7sj
         nF3g==
X-Received: by 10.69.26.4 with SMTP id iu4mr68060417pbd.140.1435861045673;
        Thu, 02 Jul 2015 11:17:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273260>

Since c1d1128 (git-am --resolved: more usable error message.,
2006-04-28), git-am --resolved will check to see if there are any
unmerged entries, and will error out with a user-friendly error message
if there are.

Add a test for this.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index a2bcffe..05494e9 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -436,6 +436,19 @@ test_expect_success 'am --resolved fails if index has no changes' '
 	test_cmp_rev lorem2^^ HEAD
 '
 
+test_expect_success 'am --resolved fails if index has unmerged entries' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	test_must_fail git am -3 lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev second HEAD &&
+	test_must_fail git am --resolved >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev second HEAD &&
+	test_i18ngrep "still have unmerged paths" err
+'
+
 test_expect_success 'am takes patches from a Pine mailbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc1.81.gfe77482
