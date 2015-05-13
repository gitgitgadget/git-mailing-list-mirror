From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 6/9] t5520: test --rebase with multiple branches
Date: Wed, 13 May 2015 17:08:53 +0800
Message-ID: <1431508136-15313-7-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:09:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfl-0003Ls-M1
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039AbbEMJJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:45 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36356 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbbEMJJk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:40 -0400
Received: by pdea3 with SMTP id a3so45311379pde.3
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JaE5YrsSIeC9dJyxINaKo0KeUQSHsTgH6czxWLWTwZk=;
        b=yqQT7gUzBM2OJI6kCEnOwSNEyZF2grdH2qoz6S/n41uwG7pspo5u74D6pURAwY+IX2
         MUd/T/7eM7QdKhYLcGgC2hcz6XLd3tudCrvm6qY+0nYPNhAeFgwmkD5NvWpe/2UHev8Q
         Ih2YfjJhkvTCt4097R7Qycb0Od+gZMdT1e1samKvs01cmc9QZoDQNxEn/ngH/b6Nq5tk
         NCeW7xO1h8dOdhnTx9PoClqz8khfPubd8M2ll+esg2Sraz25sO/taKSitvF89xj1tG3p
         mngg137r/iV8I7z0zGkzqSMDTX66DBvkO06DYtvsK0Z+Xw4aRIEZGoZCYtaUX0NWpv3Y
         BOjA==
X-Received: by 10.68.132.103 with SMTP id ot7mr35139521pbb.81.1431508180517;
        Wed, 13 May 2015 02:09:40 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:39 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268957>

Since rebasing on top of multiple upstream branches does not make sense,
since 51b2ead (disallow providing multiple upstream branches to rebase,
pull --rebase, 2009-02-18), git-pull explicitly disallowed specifying
multiple branches in the rebase case.

Implement tests to ensure that git-pull fails and prints out the
user-friendly error message in such a case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

* Quoted file content comparisons.

 t/t5520-pull.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 954e581..e957368 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -218,6 +218,15 @@ test_expect_success '--rebase' '
 	verbose test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
 	verbose test new = "$(git show HEAD:file2)"
 '
+
+test_expect_success '--rebase fails with multiple branches' '
+	git reset --hard before-rebase &&
+	test_must_fail git pull --rebase . copy master 2>err &&
+	verbose test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
+	test_i18ngrep "Cannot rebase onto multiple branches" err &&
+	verbose test modified = "$(git show HEAD:file)"
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.1.4
