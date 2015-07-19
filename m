From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 05/12] t4150: am --resolved fails if index has no changes
Date: Sun, 19 Jul 2015 23:49:11 +0800
Message-ID: <1437320958-11192-6-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqb-0005gH-IT
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbbGSPto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:44 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34772 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbGSPtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:42 -0400
Received: by pacan13 with SMTP id an13so89691786pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xbX48/SH4sStOGSlJC6ZdLTfkmcO0QEBoXDewbyZieY=;
        b=G+DlsLFehKQq+srPSL+XCjYUddjQw2xtaLTx/QmEIT9wzP0qh5eIEssouaTpaDWJ/d
         78lfYIXf86tM0G10NMj2D5D4cPsoJ5cb0B+zhzD3Q2VCnPiLnQdZAanwX8SG7nsB1mPo
         OZJdAIkVw3vmSBo5LHtcPzvN+vECV/NHUL3vTEx4gLisSIo4J9zVLIEtJQ8wy6i9dR1c
         KVjeAtGwpGIWRSjWgnq/fmxZfNlL+sNtTwqfa1IXr+ITj2A02xEpXfbrfi1JhDHcexi0
         D2WW/yORXlQmjdXPfwKcHgjUxkvqgwuFwdlJQAC5AX54ANCuYp/+vNzmj3OszA4wV7H1
         2sxg==
X-Received: by 10.66.158.65 with SMTP id ws1mr49614303pab.18.1437320982204;
        Sun, 19 Jul 2015 08:49:42 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274215>

Since 6d28644 (git-am: do not allow empty commits by mistake.,
2006-02-23), git-am --resolved will check to see if the index has any
changes to prevent the user from creating an empty commit by mistake.

Add a test for this.

Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index c350967..430ae71 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -425,6 +425,18 @@ test_expect_success 'am --resolved works' '
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
2.5.0.rc2.110.gf2a5fc6
