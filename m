From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 04/12] t4150: am refuses patches when paused
Date: Fri,  3 Jul 2015 02:16:32 +0800
Message-ID: <1435861000-25278-5-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3D-0006LQ-V0
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbbGBSR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:28 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33256 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbbGBSRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:20 -0400
Received: by pacws9 with SMTP id ws9so44906247pac.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cGLvTMCFT4LixURCIBHsSMhBXoFg2axU3k6WHMXMPgg=;
        b=diybYL1+B/YAjD5yLY4JZdAVNg3KJzh8lHxPXP6hj9n7zl/qKeStyqA1jWZU+KI1J8
         FUqPilwnEkz14oFUg3zTcrnTzjtIrCwqYFsLGjirhx8HuOxv2wMxK/HptvCQSM1CmEpJ
         YUOkI0GOdphVLH4MxfCyaP/GbQlYEOPlgkH9Xhw6xky3Pi2A8xNtwjcSHg9YUA/giMNh
         dFM29smeyN54CU7eRcnnMJDiW1txYCowcN+A284DoeQ6hPl4LTa2Ak9EFxH0dSeXazrG
         eIP6BIBmavpue4nDxUZqmJ05bKpGdU7NfTgy8IPgRHsjeypQU7m8NV9GGfvI5LqoFriL
         bqJQ==
X-Received: by 10.70.134.163 with SMTP id pl3mr68014962pdb.142.1435861039772;
        Thu, 02 Jul 2015 11:17:19 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273258>

Since c95b138 (Fix git-am safety checks, 2006-09-15), when there is a
session in progress, git-am will check the command-line arguments and
standard input to ensure that the user does not pass it any patches.

Add a test for this.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 0a19136..e5506f5 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -396,6 +396,20 @@ test_expect_success 'am --abort removes a stray directory' '
 	test_path_is_missing .git/rebase-apply
 '
 
+test_expect_success 'am refuses patches when paused' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout lorem2^^ &&
+
+	test_must_fail git am lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev lorem2^^ HEAD &&
+
+	test_must_fail git am <lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev lorem2^^ HEAD
+'
+
 test_expect_success 'am --resolved works' '
 	echo goodbye >expected &&
 	rm -fr .git/rebase-apply &&
-- 
2.5.0.rc1.81.gfe77482
