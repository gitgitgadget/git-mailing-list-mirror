Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96CB201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdBWI1g (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:27:36 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34799 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdBWI1d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:27:33 -0500
Received: by mail-it0-f68.google.com with SMTP id r141so1572332ita.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 00:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MrG7pvjdW1xWdQ73SGD89gTQaFx9DqrQXc+SSQnto8E=;
        b=ZVKuBhvpj1TReDbUnhVwqYCrK6uk0W8o9uYP0nC/LlBKzU20b7bvmIhDCubX9YgUds
         SedyO3Pfb6eiKP8f7YG5Em1jY5bDsf+hmr5oysAnFzS9525H6C1vvv5REI+xeB80dpzw
         y0g4+mh1xhdIQfWjCBO+ECuDz6s64HTuiRxgSPnh13ihwHLvijSC+lh9UaFVhg53FU7M
         +9oRHHeDO/QTu+9sN57k0qyRRmHXt6LJnAUVehan6kht8/kqXIf35l9Ye140AnMNYArE
         c8g8VThSe/MPp4NLscBEe1Xysd+CZRwiDEVSV69W1IapqXI2F+NilGwpkbLrTbKdGtYQ
         Bydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MrG7pvjdW1xWdQ73SGD89gTQaFx9DqrQXc+SSQnto8E=;
        b=UMyuUC82PvXUFmIFwxtBu1LBN/cGaNdCUL+P5T+yg88o+ayKODzTBbd0pWJ9ydB7yx
         cQgcxXMOLmbj2PqUfkkg8kQ2PcylbDHZFkdU7eX9/wYya7SJpcMaImKdnMQ3C/1mldnq
         SBVLqa2fDaVeQhjTrJ50d4xXug5pxjCjpxNllp6tc/sUjjaevQmfG1rU5e4X+s8HhiSK
         BDTTLBh57ZPh3Ub27hLW43FqlKY6GlA/z839qLhYg1QwvJhiibAbWAd231QNDJ2mYJTf
         P+P4S+LlvXQdxsnLOWke7pXnxZYAcYzh3jU6SMEFtsEMvnTayIb5r+V81bY3rovdLd7c
         Ie6w==
X-Gm-Message-State: AMke39nyD63O4hyjRPI3WAaUhL7KMBKwvrKtXUw2+7Uizjkimih3Yso8p9OtgyBB4FS2cw==
X-Received: by 10.36.166.78 with SMTP id r14mr1718288iti.51.1487838452443;
        Thu, 23 Feb 2017 00:27:32 -0800 (PST)
Received: from prospect.wheaton.edu (wcnat-96-27.wheaton.edu. [209.147.96.27])
        by smtp.gmail.com with ESMTPSA id e126sm1779353itb.18.2017.02.23.00.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 00:27:32 -0800 (PST)
From:   "Devin J. Pohly" <djpohly@gmail.com>
To:     git@vger.kernel.org
Cc:     "Devin J. Pohly" <djpohly@gmail.com>
Subject: [PATCH 3/4] filter-branch: fix --prune-empty on parentless commits
Date:   Thu, 23 Feb 2017 02:27:35 -0600
Message-Id: <20170223082736.31283-3-djpohly@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170223082736.31283-1-djpohly@gmail.com>
References: <20170223082736.31283-1-djpohly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the git_commit_non_empty_tree function would always pass any
commit with no parents to git-commit-tree, regardless of whether the
tree was nonempty.  The new commit would then be recorded in the
filter-branch revision map, and subsequent commits which leave the tree
untouched would be correctly filtered.

With this change, parentless commits with an empty tree are correctly
pruned, and an empty file is recorded in the revision map, signifying
that it was rewritten to "no commits."  This works naturally with the
parent mapping for subsequent commits.

Signed-off-by: Devin J. Pohly <djpohly@gmail.com>
---
 Documentation/git-filter-branch.txt | 14 ++++++--------
 git-filter-branch.sh                |  2 ++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 0a09698c0..6e4bb0220 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -167,14 +167,12 @@ to other tags will be rewritten to point to the underlying commit.
 	project root. Implies <<Remap_to_ancestor>>.
 
 --prune-empty::
-	Some kind of filters will generate empty commits, that left the tree
-	untouched.  This switch allow git-filter-branch to ignore such
-	commits.  Though, this switch only applies for commits that have one
-	and only one parent, it will hence keep merges points. Also, this
-	option is not compatible with the use of `--commit-filter`. Though you
-	just need to use the function 'git_commit_non_empty_tree "$@"' instead
-	of the `git commit-tree "$@"` idiom in your commit filter to make that
-	happen.
+	Some filters will generate empty commits that leave the tree untouched.
+	This option instructs git-filter-branch to remove such commits if they
+	have exactly one or zero non-pruned parents; merge commits will
+	therefore remain intact.  This option cannot be used together with
+	`--commit-filter`, though the same effect can be achieved by using the
+	provided `git_commit_non_empty_tree` function in a commit filter.
 
 --original <namespace>::
 	Use this option to set the namespace where the original commits
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 86b2ff1e0..2b8cdba15 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -46,6 +46,8 @@ git_commit_non_empty_tree()
 {
 	if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
 		map "$3"
+	elif test $# = 1 && test "$1" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904; then
+		:
 	else
 		git commit-tree "$@"
 	fi
-- 
2.11.1

