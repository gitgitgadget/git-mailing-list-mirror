From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Ensure git ls-tree exits with a non-zero exit code if read_tree_recursive fails.
Date: Sat, 23 Jul 2011 22:27:31 +1000
Message-ID: <1311424051-29644-3-git-send-email-jon.seymour@gmail.com>
References: <1311424051-29644-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 14:28:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkbJI-0004cp-Gr
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 14:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab1GWM15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 08:27:57 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56307 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1GWM1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 08:27:55 -0400
Received: by yia27 with SMTP id 27so1686060yia.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4v2nmYTZ3nO1OAmoMOxRTcq1pRPaGDWldOgf43b6L30=;
        b=SKPx53Y5k+djpfpaQr02ywABX6WeT6SJezuFH7qEsEsSHTF8LKGscOdeS1YODsDahx
         HKBnQxpeY93g6/3MdPEdf9mZJliHvr5hLqUkTfGyWregz2UmOi43Hi+OCa8+vHRKPpyT
         jNbo0DoxZloo9MUWRmulUWEJLdHQy352fvTjs=
Received: by 10.142.122.27 with SMTP id u27mr1587737wfc.2.1311424074006;
        Sat, 23 Jul 2011 05:27:54 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id q2sm2683647pbj.3.2011.07.23.05.27.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 05:27:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g6a5a9c
In-Reply-To: <1311424051-29644-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177693>

In the case of a corrupt repository, git ls-tree may report an error but
presently it exits with a code of 0.

This change uses the return code of read_tree_recursive instead.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 builtin/ls-tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

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
-- 
1.7.6.347.g6a5a9c
