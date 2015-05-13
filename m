From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/4] t7601: test for pull.ff=true overrides merge.ff=false
Date: Wed, 13 May 2015 17:52:17 +0800
Message-ID: <1431510740-9710-2-git-send-email-pyokagan@gmail.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:53:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTLz-0004SS-IC
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbbEMJxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:53:21 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35131 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbbEMJxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:53:19 -0400
Received: by pabtp1 with SMTP id tp1so45579897pab.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C0Z2By8XRhGerAEshD0pE1e0rwHLXv/RIdZKhXKaD6Q=;
        b=GQ3TgHgnAbgGf103x9D0wf/ScGwGixCvI48g1k37rW15nirJ+Z7Skv39pivjxIaZKz
         uJK76GF9r97HzXTz+KYzAGDDh3Yfs9zWN8YJdp5HPMLpXNq3BX3DUKtlHpsq1Z4EhWyw
         B1tMXIK7YO+LqXt5CAh9eMgUGSg5FxGQvkZR1iWwVg9fMMG5eMnNQGsMs7lrEXIQ0VZv
         /cdEqFUa+hj6abAsWaNRaYwG3o9smp/TltRUBUUkOLh5xyB2yxaQSXSZO9te1vf4K5xB
         2KjwKYikkvLP6Ss8QbIX4xPkBl9lnceRNClt7I2qOJ5woEDTkxa7pjISZHC3kCF61TJR
         PLjQ==
X-Received: by 10.68.213.198 with SMTP id nu6mr10832196pbc.60.1431510798809;
        Wed, 13 May 2015 02:53:18 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id k3sm18777927pdr.50.2015.05.13.02.53.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:53:17 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268973>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15), running
git-pull with the configuration pull.ff=false or pull.ff=only is
equivalent to passing --no-ff and --ff-only to git-merge. However, if
pull.ff=true, no switch is passed to git-merge. This leads to the
confusing behavior where pull.ff=false or pull.ff=only is able to
override merge.ff, while pull.ff=true is unable to.

Add a failing test that demonstrates this case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

 t/t7601-merge-pull-config.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index f768c90..cef94e6 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -45,6 +45,14 @@ test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
 	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
 '
 
+test_expect_failure 'pull.ff=true overrides merge.ff=false' '
+	git reset --hard c0 &&
+	test_config merge.ff false &&
+	test_config pull.ff true &&
+	git pull . c1 &&
+	verbose test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
+'
+
 test_expect_success 'fast-forward pull creates merge with "false" in pull.ff' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
-- 
2.1.4
