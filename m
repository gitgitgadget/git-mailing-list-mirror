From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/3] am: do not corrupt the index stat state
Date: Fri, 21 Aug 2015 01:02:30 -0700
Message-ID: <1440144151-24026-2-git-send-email-davvid@gmail.com>
References: <1440144151-24026-1-git-send-email-davvid@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 10:02:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZShHg-0005Yh-8j
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 10:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbbHUICi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 04:02:38 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32962 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbHUICf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 04:02:35 -0400
Received: by pacgr6 with SMTP id gr6so4252299pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ftEVhhbwH1je7tSLxEIO9yRiWxIYMcwvTaga+IdRllo=;
        b=sc2tcTADwv17fDYQjXiCRxn6xZtKrmLjq1AIQEbJo6ILOuxPwt3fcQ+/FZYED+mJxT
         NzYh/8tfGzLoIpuPV8dGfEqW8d9tX0+oBS0f14e1XqpWPoFX2x4DFojmVWeLRUFkhhEr
         4HHy3BSUYytcjIYETKcGMHhMfjqe90Wk3iy4Y6QFFxIcEJcyf+f4tfS05OdaXXTEmflm
         5ciaqunw6uesB/gfWw/QDk0Z/CG4gSlsQqvgUKB+vijhO0dmHreWfbgxLeo9l4Gorw4c
         au77S792Fk8Gg3G+fqb2Kg1oSHu0JTLeZN410N3iYZki4MOv+LpEpBb8UsPq6IhCR9kw
         eEzA==
X-Received: by 10.66.231.36 with SMTP id td4mr15077570pac.33.1440144155188;
        Fri, 21 Aug 2015 01:02:35 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id ng13sm488238pdb.21.2015.08.21.01.02.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 01:02:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.403.gd17121e
In-Reply-To: <1440144151-24026-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276279>

Reported-by: Linus Torvalds
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/am.c        | 14 +++++++++++++-
 t/t4151-am-abort.sh |  2 +-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1399c8d..9db1b34 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1949,6 +1949,8 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
 	struct tree *head_tree, *remote_tree, *index_tree;
 	unsigned char index[GIT_SHA1_RAWSZ];
 	struct pathspec pathspec;
+	struct tree_desc desc;
+	struct unpack_trees_options opts;
 
 	head_tree = parse_tree_indirect(head);
 	if (!head_tree)
@@ -1975,10 +1977,20 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
 
 	memset(&pathspec, 0, sizeof(pathspec));
 
+	memset(&opts, 0, sizeof(opts));
+	opts.fn = oneway_merge;
+	opts.pathspec = &pathspec;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.head_idx = 1;
+	opts.merge = 1;
+	opts.reset = 1;
+	init_tree_desc(&desc, remote_tree->buffer, remote_tree->size);
+
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 	hold_locked_index(lock_file, 1);
 
-	if (read_tree(remote_tree, 0, &pathspec)) {
+	if (unpack_trees(1, &desc, &opts)) {
 		rollback_lock_file(lock_file);
 		return -1;
 	}
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index bf2e6f4..9c3bbd1 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -168,7 +168,7 @@ test_expect_success 'am --abort on unborn branch will keep local commits intact'
 	test_cmp expect actual
 '
 
-test_expect_failure 'am --abort leaves index stat info alone' '
+test_expect_success 'am --abort leaves index stat info alone' '
 	git checkout -f --orphan stat-info &&
 	git reset &&
 	test_commit should-be-untouched &&
-- 
2.5.0.403.gd17121e
