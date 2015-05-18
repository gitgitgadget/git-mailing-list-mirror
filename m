From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 09/14] pull: implement pulling into an unborn branch
Date: Mon, 18 May 2015 23:06:06 +0800
Message-ID: <1431961571-20370-10-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:08:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMeK-0004bU-UD
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbbERPIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:08:01 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36207 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbbERPHz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:55 -0400
Received: by pabts4 with SMTP id ts4so155764418pab.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kBEfNaZfhFEXUR48js3oDCAAeQJk9PIACjfNl+JN7To=;
        b=CSne8AtPOivYal9P4cVTXkkEXC10QVCS2MGLxcAB65g/BnZCAVbd8Fa00J6sYqr2qw
         hyE6CBdNytdrsS3/2/U0whVOrhO/jMTyrDvKQu5ezoyCU9Ym5OheT9YjEaGXhdw5Rrp3
         fs6se1JqF+hcBqy+u5oZ6Mi58q+g+GUUcyCkT1w6v+ug1iGZUL7kjtUzt8SZWfmu2A9l
         wthtxvHyqo5R1yV2/nB8VBgjbG3KFktSP3w4eUct/duVsZmWjvzLOkyQNglorO5eoGeg
         LihSHS2e8yn5N1tDqZRLmmFIpU9bHGYpKnXYNNwLv/+u+dPAvISfFQAK8pN11XMoNx2o
         u8Iw==
X-Received: by 10.66.145.162 with SMTP id sv2mr44950994pab.124.1431961675093;
        Mon, 18 May 2015 08:07:55 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:53 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269267>

b4dc085 (pull: merge into unborn by fast-forwarding from empty
tree, 2013-06-20) established git-pull's current behavior of pulling
into an unborn branch by fast-forwarding the work tree from an empty
tree to the merge head, then setting HEAD to the merge head.

Re-implement this behavior by introducing pull_into_void() which will be
called instead of run_merge() if HEAD is invalid.

Helped-by: Stephen Robin <stephen.robin@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  | 29 ++++++++++++++++++++++++++++-
 t/t5520-pull.sh |  4 ++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3b7029f..ba2ff01 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -13,6 +13,7 @@
 #include "sha1-array.h"
 #include "remote.h"
 #include "dir.h"
+#include "refs.h"
 
 /**
  * Given an option opt, where opt->value points to a char* and opt->defval is a
@@ -424,6 +425,27 @@ static int run_fetch(const char *repo, const char **refspecs)
 }
 
 /**
+ * "Pulls into void" by branching off merge_head.
+ */
+static int pull_into_void(unsigned char merge_head[GIT_SHA1_RAWSZ],
+		unsigned char curr_head[GIT_SHA1_RAWSZ])
+{
+	/*
+	 * Two-way merge: we claim the index is based on an empty tree,
+	 * and try to fast-forward to HEAD. This ensures we will not lose
+	 * index/worktree changes that the user already made on the unborn
+	 * branch.
+	 */
+	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, merge_head, 0))
+		return 1;
+
+	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
+		return 1;
+
+	return 0;
+}
+
+/**
  * Runs git-merge, returning its exit status.
  */
 static int run_merge(void)
@@ -524,5 +546,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!merge_heads.nr)
 		die_no_merge_candidates(repo, refspecs);
 
-	return run_merge();
+	if (is_null_sha1(orig_head)) {
+		if (merge_heads.nr > 1)
+			die(_("Cannot merge multiple branches into empty head."));
+		return pull_into_void(*merge_heads.sha1, curr_head);
+	} else
+		return run_merge();
 }
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 3645a59..2131749 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -26,7 +26,7 @@ test_expect_success 'pulling into void' '
 	test_cmp file cloned/file
 '
 
-test_expect_failure 'pulling into void using master:master' '
+test_expect_success 'pulling into void using master:master' '
 	git init cloned-uho &&
 	(
 		cd cloned-uho &&
@@ -76,7 +76,7 @@ test_expect_success 'pulling into void does not remove new staged files' '
 	)
 '
 
-test_expect_failure 'pulling into void must not create an octopus' '
+test_expect_success 'pulling into void must not create an octopus' '
 	git init cloned-octopus &&
 	(
 		cd cloned-octopus &&
-- 
2.1.4
