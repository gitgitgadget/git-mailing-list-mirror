From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 13/19] pull: implement pulling into an unborn branch
Date: Thu, 18 Jun 2015 18:54:06 +0800
Message-ID: <1434624852-6869-14-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:56:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XUP-0002Ow-AY
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbbFRKzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:55:50 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33098 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbbFRKzV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:21 -0400
Received: by padev16 with SMTP id ev16so59045013pad.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/k+vWUL/JxsqLyD0yksuaQE/7LjO/lMMrokyLs+r0I=;
        b=i7dvgtbvpCq8Ee24YOl9MsmXdUBvKO2zuC9Pe6rtjIMlS3RaOqu8BVdOvjt2P9Z14F
         FEcl2CziYjHD0m4mMSRquLxeSbn+8Kk2a4w716QH6d8qAUElcv8oO84HG8tT1KxOaxDE
         t8kmt1PxsVEmdYRmI0kQ46BqiwZJd0LCo9hroX/ciCdgp4psif2S5nI6rAGzF7AW9zHx
         qDyInmsrkAHNWydZVQeRokGxE9VdLoeNa88tGs7/3ZRGHwEZlSjfOvikIY520O4SkkWM
         RhO37plI+Be/veJ6CyqmKk1m0Q5/1Vx/mnnX4OpWfH161vVgxU37EiDngyTuwqGlddJ3
         i3Lg==
X-Received: by 10.70.103.200 with SMTP id fy8mr19927151pdb.136.1434624920592;
        Thu, 18 Jun 2015 03:55:20 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:19 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271953>

b4dc085 (pull: merge into unborn by fast-forwarding from empty
tree, 2013-06-20) established git-pull's current behavior of pulling
into an unborn branch by fast-forwarding the work tree from an empty
tree to the merge head, then setting HEAD to the merge head.

Re-implement this behavior by introducing pull_into_void() which will be
called instead of run_merge() if HEAD is invalid.

Helped-by: Stephen Robin <stephen.robin@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 110e719..492bb0e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -13,6 +13,7 @@
 #include "sha1-array.h"
 #include "remote.h"
 #include "dir.h"
+#include "refs.h"
 
 static const char * const pull_usage[] = {
 	N_("git pull [options] [<repository> [<refspec>...]]"),
@@ -368,6 +369,27 @@ static int run_fetch(const char *repo, const char **refspecs)
 }
 
 /**
+ * "Pulls into void" by branching off merge_head.
+ */
+static int pull_into_void(const unsigned char *merge_head,
+		const unsigned char *curr_head)
+{
+	/*
+	 * Two-way merge: we treat the index as based on an empty tree,
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
@@ -476,5 +498,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
-- 
2.1.4
