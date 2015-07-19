From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 04/12] t4150: am refuses patches when paused
Date: Sun, 19 Jul 2015 23:49:10 +0800
Message-ID: <1437320958-11192-5-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqa-0005gH-Vv
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbbGSPtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:41 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34745 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbbGSPtk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:40 -0400
Received: by pdbbh15 with SMTP id bh15so44025402pdb.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qa5VeXHbM1rEFcmAOYthV7zvsgM4xu42yzdtqVZrVaA=;
        b=E14SiZLMgredDWkUISoQ8SPuezC3pdX9g0R+AXC7CrDipVwt76dYWq+0cyFS8rrWDm
         xH7jbidhziPCFfGk6NLfOL2sRICBKaR73FeSkJS+R+gFUl92Pd/ZUQPKOgwS0nwbCCOG
         pbIUtYicg/XhV4Da+glPsPVMP3pTgFQBMeb8b/oSpIMlNm+a5zNe1PNIAVvder5eeh6M
         AApf0UMLMLzhVCNWdinB5QdNfj0atBme73S6NuslH72Bxi1OGn+FJ+LmNWpqWu2envIt
         M8NlcMv87GEtAYq+o9a+RbwA4iwuPlClTjd93CJ5iB2AK7H3T3YX/yo+sSqDvwZh2zud
         61Mw==
X-Received: by 10.70.140.101 with SMTP id rf5mr49837623pdb.112.1437320979712;
        Sun, 19 Jul 2015 08:49:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274217>

Since c95b138 (Fix git-am safety checks, 2006-09-15), when there is a
session in progress, git-am will check the command-line arguments and
standard input to ensure that the user does not pass it any patches.

Add a test for this.

Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
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
2.5.0.rc2.110.gf2a5fc6
