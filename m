From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH 2/2] Show interpreted branch name in error messages
Date: Sat, 20 Aug 2011 14:49:49 -0700
Message-ID: <1313876989-16328-3-git-send-email-conrad.irwin@gmail.com>
References: <1313876989-16328-1-git-send-email-conrad.irwin@gmail.com>
Cc: gitster@pobox.com, Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 23:50:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QutR5-0003z5-Ul
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 23:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab1HTVu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 17:50:29 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37483 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab1HTVu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 17:50:26 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so7812235iye.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=++MZRNW1RESxsLTGrloXSBZsG/ZHFfjcadplmsE0IgI=;
        b=obmoejTJSMoLuS5Rv33bocqJb25daqKl32lILwYBPbTCFAm7dQ8jb5BITfsgGqyfK0
         0gb+JsBxcitAWLsnQHzbxRcgq2VzYGOJAwc85i3JzHauOyPf2Lk26DA0fG1by7dEywyA
         NEPp8UChjF6bAC00yvZ6XodP7fKGKJ812fE84=
Received: by 10.231.54.104 with SMTP id p40mr2119634ibg.39.1313877025672;
        Sat, 20 Aug 2011 14:50:25 -0700 (PDT)
Received: from localhost.localdomain (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id v16sm2391221ibe.51.2011.08.20.14.50.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 14:50:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.562.g0b2d4
In-Reply-To: <1313876989-16328-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179784>

Change the error message when doing: "git branch @{-1}",
"git checkout -b @{-1}", or "git branch -m foo @{-1}"

 * was: A branch named '@{-1}' already exists.
 * now: A branch named 'bar' already exists.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 branch.c                   |    2 +-
 t/t2018-checkout-branch.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/branch.c b/branch.c
index ff84b5b..1fe3078 100644
--- a/branch.c
+++ b/branch.c
@@ -146,7 +146,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 	if (!ref_exists(ref->buf))
 		return 0;
 	else if (!force)
-		die("A branch named '%s' already exists.", name);
+		die("A branch named '%s' already exists.", ref->buf + strlen("refs/heads/"));
 
 	head = resolve_ref("HEAD", sha1, 0, NULL);
 	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index b66db2b..75874e8 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -118,6 +118,15 @@ test_expect_success 'checkout -b to an existing branch fails' '
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
+test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
+	git reset --hard HEAD &&
+	git checkout branch1 &&
+	git checkout branch2 &&
+	echo  >expect "fatal: A branch named '\''branch1'\'' already exists." &&
+	test_must_fail git checkout -b @{-1} 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
 	git checkout branch1 &&
 
-- 
1.7.6.562.g0b2d4
