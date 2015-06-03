From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 13/19] pull: implement pulling into an unborn branch
Date: Wed,  3 Jun 2015 14:48:57 +0800
Message-ID: <1433314143-4478-14-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Va-0004sO-3v
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbbFCGue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:34 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35790 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbFCGuY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:24 -0400
Received: by padjw17 with SMTP id jw17so699983pad.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7p2jQaLdB7KHvc+FHaNIaLWv/tM4TNya5jWnUDI4XAw=;
        b=pWzk7LmVy/+7xyl12mW6G24ehy90y/VKMcG7DrAbAh37s7Opm8255UAQgkxZOmVopI
         A0rrxzy6taVJEBVmzSyq7535GZiOs8FK5SXsBrmzzIL6jQ+0QQmNB5bV1oQ/x8mkCfdy
         WK6Jok5kPdbE7j6UEugorJQnBzkLmaOMfxvPy4+tSBmCDk5LiVxdWmDe/Hi2kh/fsIc3
         TjVGU3rYEET1eOjfWgNHRib/FD0CjlCVnVbIWKb5JQJFJso4VzEHbbjndNw+QuDHD4Th
         M3Q+7VhR7ty9fa8VqRPJiAOXwAfT92esFSlZqlHM8Tk2fvbCzYh+VXp/0/3bBnJj5E3g
         iO2w==
X-Received: by 10.66.139.70 with SMTP id qw6mr56886190pab.112.1433314223703;
        Tue, 02 Jun 2015 23:50:23 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:22 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270649>

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
index 8db0db2..f0d4710 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -13,6 +13,7 @@
 #include "sha1-array.h"
 #include "remote.h"
 #include "dir.h"
+#include "refs.h"
 
 static const char * const pull_usage[] = {
 	N_("git pull [options] [<repository> [<refspec>...]]"),
@@ -367,6 +368,27 @@ static int run_fetch(const char *repo, const char **refspecs)
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
@@ -475,5 +497,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
