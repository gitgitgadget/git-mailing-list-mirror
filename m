From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 2/2] Ensure git ls-tree exits with a non-zero exit code if read_tree_recursive fails.
Date: Mon, 25 Jul 2011 00:59:14 +1000
Message-ID: <1311519554-16587-3-git-send-email-jon.seymour@gmail.com>
References: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 16:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql09g-0008BH-43
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab1GXO7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:59:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53698 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab1GXO7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:59:35 -0400
Received: by yxi11 with SMTP id 11so1899770yxi.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jSoP7z5qfs+MVT971ipPhOBBtZAq5Op2NqjNHxhYVsk=;
        b=jIFkzR2qrZjOGeY84uaalDdmPmmeX18GF1TmdfzwbJKjKcdzw0jZR/lBDFp+ONeFu6
         IUebcpttYGIRGa35yI2Zqf5ZiAWX6M5UOhi7iVhluCq/hnNKZq7BrtmyVqLgozAGbEDn
         2OjeNECm7HDVQExeOPFjucoQg9bgbPCqI1xaw=
Received: by 10.236.187.71 with SMTP id x47mr1030941yhm.433.1311519575419;
        Sun, 24 Jul 2011 07:59:35 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id v25sm3598186yhk.8.2011.07.24.07.59.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:59:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.gf855
In-Reply-To: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177761>

In the case of a corrupt repository, git ls-tree may report an error but
presently it exits with a code of 0.

This change uses the return code of read_tree_recursive instead.

Improved-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 builtin/ls-tree.c       |    3 +--
 t/t3103-ls-tree-misc.sh |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f08c5b0..d96e9c4 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,7 +173,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-	read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
+	return read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
 
-	return 0;
 }
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index c9c20f9..09dcf04 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' '
 	git commit -m test
 '
 
-test_expect_failure 'ls-tree fails with non-zero exit code on broken tree' '
+test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
 	test_must_fail git ls-tree -r HEAD
 '
-- 
1.7.6.347.gf855
