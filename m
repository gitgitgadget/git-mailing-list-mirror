From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Ensure git ls-tree exits with a non-zero exit code if read_tree_recursive fails.
Date: Sun, 24 Jul 2011 11:07:50 +1000
Message-ID: <1311469670-15392-3-git-send-email-jon.seymour@gmail.com>
References: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 03:08:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QknB7-0000ki-6j
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 03:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab1GXBIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 21:08:12 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57057 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab1GXBII (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 21:08:08 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so5971353pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 18:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r3UHd9bUf7Fjhs2qs5QNqwC9eTqgGEhRhs2ZRDCXIjs=;
        b=kLtj6FC0uPotJmXKOUZgzifyd+MrD36KpPNeU9dUsXhn0v7+XbC6Tric2pIk4wusRF
         ZxHiaEjDGW1aNalgoNwiSidsj+iIuZsbUgnyiCRStRJcSOdWb9hDtygDpFA6Jqnf3HOc
         KA/401q97CA1IdnUii+ER4Sc2u8i8ZRWCXK08=
Received: by 10.142.60.16 with SMTP id i16mr1765045wfa.343.1311469688117;
        Sat, 23 Jul 2011 18:08:08 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id d1sm3160283pbj.72.2011.07.23.18.08.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 18:08:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b
In-Reply-To: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177709>

In the case of a corrupt repository, git ls-tree may report an error but
presently it exits with a code of 0.

This change uses the return code of read_tree_recursive instead.

Improved-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 builtin/ls-tree.c               |    6 +++---
 t/t3103-ls-tree-missing-tree.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f08c5b0..6d6c992 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -120,7 +120,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20];
 	struct tree *tree;
-	int i, full_tree = 0;
+	int i, full_tree = 0, err;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, "only show trees",
 			LS_TREE_ONLY),
@@ -173,7 +173,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-	read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
+	err = read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
 
-	return 0;
+	return err;
 }
diff --git a/t/t3103-ls-tree-missing-tree.sh b/t/t3103-ls-tree-missing-tree.sh
index cd17fa7..365ac07 100755
--- a/t/t3103-ls-tree-missing-tree.sh
+++ b/t/t3103-ls-tree-missing-tree.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	git commit -m test
 '
 
-test_expect_failure 'ls-tree fails with non-zero exit code on broken tree' '
+test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
 	test_must_fail git ls-tree -r HEAD
 '
-- 
1.7.6.347.g96e0b
