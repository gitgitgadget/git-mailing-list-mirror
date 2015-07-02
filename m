From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 02/12] t4150: am fails if index is dirty
Date: Fri,  3 Jul 2015 02:16:30 +0800
Message-ID: <1435861000-25278-3-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj36-0006Ie-J9
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbbGBSRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:20 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36394 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbGBSRO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:14 -0400
Received: by pdcu2 with SMTP id u2so49993254pdc.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=obkIUG01kF0exHDVK5oDRz4OlF1MabaXwk4Vm2a+Ov4=;
        b=q3vd4p/HrbHGkCHXnePNUtpyrPZovOjMUHDF2oWZ+mPpOPk47mDQ0WbSEXBffTdoTM
         zRlUgkTSMZUneGyjxwYrlB4VPto8LK/Oqqwd2d0GZfjggVfm6nGXZIiRi5nSJ66ZLM48
         QoUJKWKrMLDQGINEMjmc31q+RNO9H/r/7oELjb4GEBAquFNKg5003BMZTT0B8Zwux/4M
         dH1S0pUPrmChHIKswOvsr1OTyV+OeWcrtbN2X314hIbmituVdXc7WxnFeWwAz/dmU1Sc
         GwFI69RwC75nIXJ449aip4P4JbpWrM5WYTVaN+fYNvl3Nj8OR1haV9gxypqVL0FfNz75
         Ez2A==
X-Received: by 10.70.41.33 with SMTP id c1mr68879071pdl.114.1435861033744;
        Thu, 02 Jul 2015 11:17:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273256>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will ensure that the index is clean before applying the patch. This is
to prevent changes unrelated to the patch from being committed.

Add a test for this check.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 3f54bdf..0a19136 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -154,6 +154,17 @@ test_expect_success 'am applies patch correctly' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am fails if index is dirty' '
+	test_when_finished "rm -fr dirtyfile" &&
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	echo dirtyfile >dirtyfile &&
+	git add dirtyfile &&
+	test_must_fail git am patch1 &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev first HEAD
+'
+
 test_expect_success 'am applies patch e-mail not in a mbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc1.81.gfe77482
