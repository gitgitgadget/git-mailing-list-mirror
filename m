From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 04/12] t4150: am refuses patches when paused
Date: Tue,  7 Jul 2015 22:08:26 +0800
Message-ID: <1436278114-28057-5-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTYa-0005YQ-MC
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbbGGOJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:02 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34650 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573AbbGGOJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:00 -0400
Received: by pdbep18 with SMTP id ep18so126541729pdb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jSnsHpAFo0QmFeePkQPy8KfhYCXQa0iwMilukl9iDPw=;
        b=dV3VJyBq8IrEYOTN3mDdoh5EjoecqtOwQ5bzlcGL7rnKK0GNV0AZAPkWTOMLnd8LJP
         6RhFeqAQpFz64C5hHN2iTnKurK9FJ0O244wQYxn6EZAQcGyFsNywQk3oNWzeQ61l363U
         JqwBXn57vlUsBxp44nzMKWPYXL15Kj/tCI5Fu3NBdz5X49ESBLB99XyeLu2VCZljFYSa
         5bLK6nyEBvZE01xWG3BVusOS7M41R+2mb7EplPDC3VKtiG0U3KsnWgLpOAAH3oOKw7YV
         RaGfLYt6Hw7bf83nT0rv6mpzseMIDhKufWUC9H1KbHTljf5KFAtw96OEnnKNwkKgWsdq
         aJXQ==
X-Received: by 10.66.119.174 with SMTP id kv14mr9262927pab.5.1436278139695;
        Tue, 07 Jul 2015 07:08:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.08.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:08:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273510>

Since c95b138 (Fix git-am safety checks, 2006-09-15), when there is a
session in progress, git-am will check the command-line arguments and
standard input to ensure that the user does not pass it any patches.

Add a test for this.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index a85e06a..c350967 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -397,6 +397,20 @@ test_expect_success 'am --abort removes a stray directory' '
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
2.5.0.rc1.76.gf60a929
