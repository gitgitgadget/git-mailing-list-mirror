Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1142EBDFD
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772895; cv=none; b=iZJ9+z2ZAKVxEgzcAOYZiW9BSENSkINU5uN9eyGwh3nio8Zz1qxJVVwZ63twZndES3kUjSyiYKG70hcFhQ7kK/asu4H9LELjiNf2+6w0FNyeh1gJOqVlpYFSF98GVJWOe1fEyh7zsWN1Uu417py2RI5asq61Xfx8W1A0GJoCCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772895; c=relaxed/simple;
	bh=xUuHmmZX+2YRHLArMvATk7xFhvx8NNrCWhVMy5ccIHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqAGvwr8z6/ZMkYsflT8oT1VS8O3rv17n2ZeMHcErQDVHLqi8hgRm6KkN0q55BvbLnxTBtiVHhshIS6mctxug+jNGUjx5lLeB6iZKWJPurPMkKRoTurRjV7Ph6KkPX3JP/7pXA+kN8cN+z8sZjUjKPPTLPjjpqJzb4M8jcTvAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=v2WIMsbu; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="v2WIMsbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V+/naCxXXTwirr2u73tw88zs+LUKGOkdW0/4Z0kt/0U=;
  b=v2WIMsbuacbFG4grWmR7lrQvsrsngeG8Vb35a2pEl4J+mujNPwHffBb9
   QLODMWPpL1h0123SVCQzoJVyfG1d9AG4yCd/RELArTRkzK9/N6V5NzRVY
   RKvYsCU7Jx36wdmy3VlcrSPUNASGfeLknVMZzk9IaEjCcw4iEgh2p8hq4
   s=;
X-CSE-ConnectionGUID: wIufFj+LSDqjwUySFHpN3g==
X-CSE-MsgGUID: m0Q7CrQcR3ueGXzxGasFtw==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=gabriel.scherer@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,261,1751234400"; 
   d="scan'208";a="125412459"
Received: from 88-126-14-38.subs.proxad.net (HELO localhost) ([88.126.14.38])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 16:13:41 +0200
From: Gabriel Scherer <gabriel.scherer@inria.fr>
To: git@vger.kernel.org
Cc: Gabriel Scherer <gabriel.scherer@inria.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/3] checkout: provide hint when failing due to another worktree
Date: Sat, 13 Sep 2025 16:13:18 +0200
Message-ID: <20250913141327.2775228-2-gabriel.scherer@inria.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gabriel.Scherer" <gabriel.scherer@inria.fr>

When checkout/switch fails because the target branch is already used
by another worktree, we now hint that the user could use --detach or
--ignore-other-worktrees.

Note: this error can also happen on rebase, which unfortunately does
not support --ignore-other-worktrees. We do not show advice in this
case, and leave 'rebase --ignore-other-worktrees' to future work.

Signed-off-by: Gabriel Scherer <gabriel.scherer@inria.fr>
---
 Documentation/config/advice.adoc |  3 +++
 advice.c                         |  1 +
 advice.h                         |  1 +
 branch.c                         | 13 +++++++++++--
 branch.h                         |  4 ++++
 builtin/checkout.c               | 12 ++++++++++--
 6 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db58918..9ee64f44ea 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -27,6 +27,9 @@ all advice messages.
 		Shown when a fetch refspec for multiple remotes maps to
 		the same remote-tracking branch namespace and causes branch
 		tracking set-up to fail.
+	branchUsedInOtherWorktree::
+		Shown when the user attemps to switch to a branch
+		that is already checked out in another worktree.
 	checkoutAmbiguousRemoteBranchName::
 		Shown when the argument to
 		linkgit:git-checkout[1] and linkgit:git-switch[1]
diff --git a/advice.c b/advice.c
index e5f0ff8449..5c9b763472 100644
--- a/advice.c
+++ b/advice.c
@@ -50,6 +50,7 @@ static struct {
 	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec" },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
+	[ADVICE_BRANCH_USED_IN_OTHER_WORKTREE]		= { "branchUsedInOtherWorktree" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
 	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
diff --git a/advice.h b/advice.h
index 727dcecf4a..6b11df945b 100644
--- a/advice.h
+++ b/advice.h
@@ -16,6 +16,7 @@ enum advice_type {
 	ADVICE_ADD_IGNORED_FILE,
 	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
 	ADVICE_AM_WORK_DIR,
+	ADVICE_BRANCH_USED_IN_OTHER_WORKTREE,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DEFAULT_BRANCH_NAME,
diff --git a/branch.c b/branch.c
index 26be358347..76aa2cbf44 100644
--- a/branch.c
+++ b/branch.c
@@ -844,7 +844,7 @@ void remove_branch_state(struct repository *r, int verbose)
 	remove_merge_branch_state(r);
 }
 
-void die_if_checked_out(const char *branch, int ignore_current_worktree)
+int die_message_if_checked_out(const char *branch, int ignore_current_worktree)
 {
 	struct worktree **worktrees = get_worktrees();
 
@@ -854,10 +854,19 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 
 		if (is_shared_symref(worktrees[i], "HEAD", branch)) {
 			skip_prefix(branch, "refs/heads/", &branch);
-			die(_("'%s' is already used by worktree at '%s'"),
+			return die_message(
+				_("'%s' is already used by worktree at '%s'"),
 				branch, worktrees[i]->path);
 		}
 	}
 
 	free_worktrees(worktrees);
+	return 0;
+}
+
+void die_if_checked_out(const char *branch, int ignore_current_worktree)
+{
+	int code = die_message_if_checked_out(branch, ignore_current_worktree);
+	if (code)
+		exit(code);
 }
diff --git a/branch.h b/branch.h
index ec2f35fda4..84c81508e9 100644
--- a/branch.h
+++ b/branch.h
@@ -155,4 +155,8 @@ int read_branch_desc(struct strbuf *, const char *branch_name);
  */
 void die_if_checked_out(const char *branch, int ignore_current_worktree);
 
+/* Similar to 'die_if_checked_out' above, but returns a non-zero
+   error code after printing the message instead of dying immediately. */
+int die_message_if_checked_out(const char *branch, int ignore_current_worktree);
+
 #endif
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe..e4b78f4a05 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1582,8 +1582,16 @@ static void die_if_switching_to_a_branch_in_use(struct checkout_opts *opts,
 		return;
 	head_ref = refs_resolve_refdup(get_main_ref_store(the_repository),
 				       "HEAD", 0, NULL, &flags);
-	if (head_ref && (!(flags & REF_ISSYMREF) || strcmp(head_ref, full_ref)))
-		die_if_checked_out(full_ref, 1);
+	if (head_ref && (!(flags & REF_ISSYMREF) || strcmp(head_ref, full_ref))) {
+		int code = die_message_if_checked_out(full_ref, 1);
+		if (code) {
+			advise_if_enabled(
+				ADVICE_BRANCH_USED_IN_OTHER_WORKTREE,
+				_("Use --detach to avoid this restriction,\n"
+				"or --ignore-other-worktrees to ignore it."));
+			exit(code);
+		}
+	}
 	free(head_ref);
 }
 
-- 
2.51.0

