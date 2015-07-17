From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 22/22] checkout: drop intimate knowledge of newly created worktree
Date: Fri, 17 Jul 2015 19:00:17 -0400
Message-ID: <1437174017-81687-23-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdT-0002S0-7l
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbbGQXBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:34 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33078 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbbGQXBd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:33 -0400
Received: by igbpg9 with SMTP id pg9so5823549igb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uA9uh61emNNf5TLIwESAfF9vqxdLdHOCHpkVzFXEwzY=;
        b=ceL2m/fo6NLSWBbRFV/1FEqCJFebvhiDc1+VXRzGOWLJkoZVTMWcGBwJPwcXEuGhS2
         wSdQQfbCR6NCP9FwnvLtFGYzMVNBLzlN9XqwMRrdvxHRNGj8wD47jOSa2VCLwstNFNuv
         fQS6pJMS6zASKAmHrXcsKTl21CVJPeOOAm/07iESqcluhrvFI6ja7TALx3xIjn7pB8aq
         ejspMr5cpqjMfooZxeuu25VSPksI2uSY1D4Fj1PXpj5BG8IgzJJUibtmhXzm9M6/gVGz
         s+dhiSahRWgWqp+yU4thpe78XEaBsgz1bY55hd9SLNnAFhUdtnfVlD5X55ZJanQE8J53
         0Wcg==
X-Received: by 10.50.30.65 with SMTP id q1mr883331igh.28.1437174092725;
        Fri, 17 Jul 2015 16:01:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.31
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274137>

Now that git-worktree no longer relies upon git-checkout for new branch
creation, new worktree HEAD set up, or initial worktree population,
git-checkout no longer needs intimate knowledge that it may be operating
in a newly created worktree. Therefore, drop 'new_worktree_mode' and the
private GIT_CHECKOUT_NEW_WORKTREE environment variable by which
git-worktree communicated to git-checkout that it was being invoked to
manipulate a new worktree.

This reverts the remaining changes to checkout.c by 529fef2 (checkout:
support checking out into a new working directory, 2014-11-30).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

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
2.5.0.rc2.378.g0af52e8
