From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 05/12] t4150: am --resolved fails if index has no changes
Date: Fri,  3 Jul 2015 02:16:33 +0800
Message-ID: <1435861000-25278-6-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3E-0006LQ-MT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbbGBSRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:30 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35019 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbbGBSRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:23 -0400
Received: by pactm7 with SMTP id tm7so44106525pac.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jQ6B9Vh0IpUERepdFlDTLDeaWDu+0v3E29Q22mdcxGU=;
        b=eiD1HdRveXQVB2shp7pFXB5pP4ZypfZCpJvF8/uJut2w0zIRXDVGd/ss9Ne2X2pPVy
         0161kOs/YeMho99yu20KI4H4emQOTlPr/z/iOJztHobQys1+pmy6uC927R+Wn/NrBVGK
         O0+mLDtrIQ5nRjjU31IBbIr3U2kac5+8lvW0rbHPi/Q1zDmmiaKtQqyVju7d9SQ2HKv9
         31bAlwoz70X/xMNNS3KEdg46WxAQpDT1cz/kwkrosG1VuPbj2JZ0YesyEZAvUqjL1Thf
         MIDKd4Ke93nT/HwpykOQ/59Tw94Cslj0wOJYiUknEFsWSeF+kDDj2NSc7wmFQ4fI6Z5E
         cT5Q==
X-Received: by 10.68.163.37 with SMTP id yf5mr68983460pbb.103.1435861042989;
        Thu, 02 Jul 2015 11:17:22 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273259>

Since 6d28644 (git-am: do not allow empty commits by mistake.,
2006-02-23), git-am --resolved will check to see if the index has any
changes to prevent the user from creating an empty commit by mistake.

Add a test for this.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index e5506f5..a2bcffe 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -424,6 +424,18 @@ test_expect_success 'am --resolved works' '
 	test_cmp expected another
 '
 
+test_expect_success 'am --resolved fails if index has no changes' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout lorem2^^ &&
+	test_must_fail git am lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev lorem2^^ HEAD &&
+	test_must_fail git am --resolved &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev lorem2^^ HEAD
+'
+
 test_expect_success 'am takes patches from a Pine mailbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc1.81.gfe77482
