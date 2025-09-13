Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2982F0666
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772897; cv=none; b=CGH8oVK9KjPiuXDiQFyC4SfKzDW57B3H5ryhe38nsPgYkCoWp+QC50pB2LS9Id8me/zf9SvpTcyC+E9y4koP6jNAn2fkhZQQTsdhiAshYA9LOq93JwRJlv6CV1cKPhi605J5iX0X8wZJrT7GwhO7y3V63LvmN04MhrN5xlEIDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772897; c=relaxed/simple;
	bh=8XQLrxqLa5PeL3p2VrB03Q+5SGOe19D87Jn6yA8MET0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIayRAEiJsh81DmL32JXHvM1q1qch64iiZQ329Q+p/4cjCPF21puH6S6AiAzgqGrnQxeZg9fnwY5ggIpY32xIMGp3/y9NqKiUE6BbNCYA0cjEKNrCU5q9/UGAIr6eMeahMxHbhqedqZdGZZzlmVX5FPTZvxMPp8yxPQWiPkFedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ct4q2j3o; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ct4q2j3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jcx+Cfhf8u4fyU7cpYEy7j4aUiB2CkyENoVUz57G0YU=;
  b=ct4q2j3oYL3aePvdrDPEPgLj2LyfH2mS4q79oYQL0eB2soVFOHRCvPy5
   6JPQUg41bFNX/Fw0cL/qE8puXbplLNVZTYPChp9ew9iWNwBYZx1aTklMi
   k/j7kEvl70rfarfvjvpK9rVZSk/cWxRqq4szkvdX7wI4aKP0mkTvimVmj
   A=;
X-CSE-ConnectionGUID: mbj1YnqSRX2vV/nLPcylQg==
X-CSE-MsgGUID: ZzpihIDMTuyXu4Tff/SphA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=gabriel.scherer@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,261,1751234400"; 
   d="scan'208";a="238904508"
Received: from 88-126-14-38.subs.proxad.net (HELO localhost) ([88.126.14.38])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 16:13:42 +0200
From: Gabriel Scherer <gabriel.scherer@inria.fr>
To: git@vger.kernel.org
Cc: Gabriel Scherer <gabriel.scherer@inria.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/3] rebase: support --ignore-other-worktrees
Date: Sat, 13 Sep 2025 16:13:19 +0200
Message-ID: <20250913141327.2775228-3-gabriel.scherer@inria.fr>
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

rebase can currently fail if the branch to rebase is checked out in
another worktree, and there is no way for users to override this
error. We add support for the '--ignore-other-worktrees' option of
'checkout'.

Signed-off-by: Gabriel Scherer <gabriel.scherer@inria.fr>
---
 Documentation/git-rebase.adoc |  6 ++++++
 builtin/rebase.c              | 11 ++++++++++-
 t/t3400-rebase.sh             |  4 +++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 005caf6164..b703d4056e 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -305,6 +305,12 @@ see the `--empty` flag.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--ignore-other-worktrees::
+	By default, `git rebase` refuses when the branch to rebase is
+	already checked out or otherwise in use by another
+	worktree. With this option, other worktrees are ignored and
+	the rebase proceeds anyway.
+
 --reapply-cherry-picks::
 --no-reapply-cherry-picks::
 	Reapply all clean cherry-picks of any upstream commit instead
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3c85768d29..7a57ebd852 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -128,6 +128,7 @@ struct rebase_options {
 	struct strbuf git_format_patch_opt;
 	int reschedule_failed_exec;
 	int reapply_cherry_picks;
+	int ignore_other_worktrees;
 	int fork_point;
 	int update_refs;
 	int config_autosquash;
@@ -146,6 +147,7 @@ struct rebase_options {
 		.git_format_patch_opt = STRBUF_INIT,	\
 		.fork_point = -1,			\
 		.reapply_cherry_picks = -1,             \
+		.ignore_other_worktrees = -1,           \
 		.allow_empty_message = 1,               \
 		.autosquash = -1,                       \
 		.rebase_merges = -1,                    \
@@ -1234,6 +1236,8 @@ int cmd_rebase(int argc,
 			 N_("automatically re-schedule any `exec` that fails")),
 		OPT_BOOL(0, "reapply-cherry-picks", &options.reapply_cherry_picks,
 			 N_("apply all changes, even those already present upstream")),
+		OPT_BOOL(0, "ignore-other-worktrees", &options.ignore_other_worktrees,
+			 N_("do not check if another worktree is using the branch to rebase")),
 		OPT_END(),
 	};
 	int i;
@@ -1580,6 +1584,10 @@ int cmd_rebase(int argc,
 			(options.flags & REBASE_INTERACTIVE_EXPLICIT);
 	}
 
+	if (options.ignore_other_worktrees == -1) {
+		options.ignore_other_worktrees = 0;
+	}
+
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			options.type = REBASE_MERGE;
@@ -1679,7 +1687,8 @@ int cmd_rebase(int argc,
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/%s", branch_name);
 		if (!refs_read_ref(get_main_ref_store(the_repository), buf.buf, &branch_oid)) {
-			die_if_checked_out(buf.buf, 1);
+			if (!options.ignore_other_worktrees)
+				die_if_checked_out(buf.buf, 1);
 			options.head_name = xstrdup(buf.buf);
 			options.orig_head =
 				lookup_commit_object(the_repository,
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index c0c00fbb7b..08448b4d4e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -407,7 +407,9 @@ test_expect_success 'switch to branch checked out elsewhere fails' '
 	# we test in both worktrees to ensure that works
 	# as expected with "first" and "next" worktrees
 	test_must_fail git -C wt1 rebase shared shared &&
-	test_must_fail git -C wt2 rebase shared shared
+	test_must_fail git -C wt2 rebase shared shared &&
+        # with --ignore-other-worktrees the rebase succeeds
+	git -C wt1 rebase --ignore-other-worktrees shared shared
 '
 
 test_expect_success 'switch to branch not checked out' '
-- 
2.51.0

