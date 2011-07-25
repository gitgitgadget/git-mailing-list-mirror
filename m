From: Jon Seymour <jon.seymour@gmail.com>
Subject: [v4 2/2] Ensure git ls-tree exits with a non-zero exit code if read_tree_recursive fails.
Date: Tue, 26 Jul 2011 08:03:11 +1000
Message-ID: <1311631391-12842-3-git-send-email-jon.seymour@gmail.com>
References: <1311631391-12842-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, schwab@linux-m68k.org,
	gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 00:04:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlTFr-0007xw-9P
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 00:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab1GYWDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 18:03:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62012 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab1GYWDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 18:03:48 -0400
Received: by ywe9 with SMTP id 9so2536572ywe.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VgmFFIa0VRGn+h2iuvC3DcJyNlDTHU3dcWnlmQBNtPo=;
        b=R7A7dNLXThV+Si1lvLIkI+6/+v42yNnWJWz8ZqNhDiDxaD6OkDvC4zR3oZQ4nytvUX
         F/VI8eYhMLrbkiMIT0LBAqwIfMFma+eO9VRwqzTGB9Tj9MlaZBhj93pOlDGEzx8RmzoJ
         oX7Fh8SYDzIc9rHLmU/29GS9H2Hj4+tx/mKWQ=
Received: by 10.142.223.15 with SMTP id v15mr3257438wfg.100.1311631427053;
        Mon, 25 Jul 2011 15:03:47 -0700 (PDT)
Received: from localhost.localdomain ([120.17.170.52])
        by mx.google.com with ESMTPS id d1sm4966401pbj.88.2011.07.25.15.03.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 15:03:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g8394c
In-Reply-To: <1311631391-12842-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177827>

In the case of a corrupt repository, git ls-tree may report an error but
presently it exits with a code of 0.

This change sets the exit code to 1, if the read_tree_recursive returns
non-zero and 0 otherwise.

Improved-by: Jens Lehmann <Jens.Lehmann@web.de>
Improved-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Improved-by: Andreas Schwab <schwab@linux-m68k.org>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 builtin/ls-tree.c       |    3 +--
 t/t3103-ls-tree-misc.sh |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f08c5b0..b1dcebd 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,7 +173,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-	read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
 
-	return 0;
+	return !!read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
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
1.7.6.347.g8394c
