From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 13/19] pull: implement pulling into an unborn branch
Date: Sun, 14 Jun 2015 16:42:00 +0800
Message-ID: <1434271326-11349-14-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43Vx-0006ZY-0J
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbFNInb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:31 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35162 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbFNInH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:07 -0400
Received: by pdbnf5 with SMTP id nf5so51491427pdb.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sCbJoXKNsQ7K4X6X9wLxeZAGSMoj3Bf7ynjnXPMqfiQ=;
        b=qtvggTXLGXLrk9jxeCDbdbWLQF6b5yMcP3/3Da0LakCOodoHYzJGVETNw4vPlnKp5y
         fdf/pIsFA3pAc77/bGjsiN8uypqiYEZop5EUXIxqG6j+B4Ig5fX+S2h019lA8Ea9wMQA
         Vu0qOKV5YKf5ctHzbh2Dao2C3a9k1V0rPiRpGphD1WaIHouItRdbtAG78VwaUTWjxGld
         MfsCZwXQjiWMzP3V89lPlX3YGRzT7NAYjMywtPaGj5M3waEPeAjslLjFdoG54EKyBLrs
         HDrtk0pHQgeDITITHfFycSBzmTJ9NvJU4Q8L8/8ky/lZNH1dmrHgqXfApRm/FwqzyAD/
         RlFg==
X-Received: by 10.68.224.35 with SMTP id qz3mr37684858pbc.165.1434271386709;
        Sun, 14 Jun 2015 01:43:06 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.43.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:43:05 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271626>

b4dc085 (pull: merge into unborn by fast-forwarding from empty
tree, 2013-06-20) established git-pull's current behavior of pulling
into an unborn branch by fast-forwarding the work tree from an empty
tree to the merge head, then setting HEAD to the merge head.

Re-implement this behavior by introducing pull_into_void() which will be
called instead of run_merge() if HEAD is invalid.

Helped-by: Stephen Robin <stephen.robin@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v3
    
    * style fixes

 builtin/pull.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 0e48a14..a2dd0ba 100644
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
