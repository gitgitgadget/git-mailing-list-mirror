From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 16/16] checkout: drop intimate knowledge of new worktree initial population
Date: Fri, 10 Jul 2015 20:05:46 -0400
Message-ID: <1436573146-3893-17-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDosz-00070n-So
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbbGKHHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:07:41 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34340 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbbGKHHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:07:41 -0400
Received: by iebmu5 with SMTP id mu5so208152997ieb.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B92DjJvKi4YeDyAJcMEyKhlZdx2HflbqftZy3VsPikA=;
        b=DFkGCcjGsk39MRu2N4/HuvIyeOq3b7x68aL71FX56QYCF60NwUxpO+d8swqzccbJrE
         jqxTciKafZR6CDVYzhwAK+iqEgwuAopFSakRi6ZrO993PZ7yDgQHbj2pSvxb8sVSsnaq
         FU/mI/DnbpHTsxMTvjbrVOhmuAtavB4RQj6yO5DGJS/FkLDwnpohC3kte2GgqUTKKbbc
         kOUFt7MSM2Pj4CPLhnqsyKVp8L5Fu+KM0sjMxkK1rgUloCFfX7+YRFPS+Fha6xa9B4jb
         swdGeDamC8h83SDGR5Ut2B2vagT2SQE0JGzDbWP7Y7mIGCOWJPXPtwzJ5ONOColCbqzI
         ZK/w==
X-Received: by 10.107.46.159 with SMTP id u31mr35092074iou.69.1436573201705;
        Fri, 10 Jul 2015 17:06:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.40
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273855>

Now that git-worktree no longer relies upon git-checkout to perform
initial population of the new worktree, git-checkout no longer needs
intimate knowledge that it may be working on a newly created worktree.
Therefore, drop 'new_worktree_mode' and the private
GIT_CHECKOUT_NEW_WORKTREE environment variable by which git-worktree
communicated to git-checkout that it was being invoked to populate a new
worktree.

This reverts the remaining changes to checkout.c by 529fef2 (checkout:
support checking out into a new working directory, 2014-11-30).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4ae895c..02d78ba 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -48,8 +48,6 @@ struct checkout_opts {
 	const char *prefix;
 	struct pathspec pathspec;
 	struct tree *source_tree;
-
-	int new_worktree_mode;
 };
 
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -491,7 +489,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			topts.dir->flags |= DIR_SHOW_IGNORED;
 			setup_standard_excludes(topts.dir);
 		}
-		tree = parse_tree_indirect(old->commit && !opts->new_worktree_mode ?
+		tree = parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   EMPTY_TREE_SHA1_BIN);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
@@ -807,8 +805,7 @@ static int switch_branches(const struct checkout_opts *opts,
 		return ret;
 	}
 
-	if (!opts->quiet && !old.path && old.commit &&
-	    new->commit != old.commit && !opts->new_worktree_mode)
+	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
 		orphaned_commit_warning(old.commit, new->commit);
 
 	update_refs_for_switch(opts, &old, new);
@@ -1151,8 +1148,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	opts.new_worktree_mode = getenv("GIT_CHECKOUT_NEW_WORKTREE") != NULL;
-
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
-- 
2.5.0.rc1.201.ga12d9f8
