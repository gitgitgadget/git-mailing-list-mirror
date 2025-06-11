Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F034CF5
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603151; cv=none; b=sbmB1G4tVHoKPJ+MoRE+iePeNQQBXJWFpvJKwJAkGkN3Mpj6FP25kHdey451Bx8fkWMMXluX4/Z7Jzj4b4i4EvHqdOpmp7y0OrzhOha7VgEyce2CGzNWGYUkJvUC99kQUdDuLhDr8Wj8i9W29dEBsjBPh/0jmWQb82A38J3bnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603151; c=relaxed/simple;
	bh=e+GVOOwo+evIfEY70gAFatPUvzj0jSK40R/708GBQfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIBpdPOkwmYhMbwdf54CiUF/obPcxuQcvhBiZCajeHOeQ19Ay9nKyuEsTc7J1WBtH+061yVybDeqykuvaAd16HoDwHFK1VVkcRfkc19Zzlso5PzY5SWncilf2Iue/qWBq0X4k4yc4KMp5NwFmFYWhNAOe4jdkL/LTczsaSto6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcpAj+JK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcpAj+JK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749603149; x=1781139149;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e+GVOOwo+evIfEY70gAFatPUvzj0jSK40R/708GBQfs=;
  b=AcpAj+JK41B7mjFpcOc/lYl+zjsqwOlq50mQEEClW1h5vOgvxVCWJtoZ
   sO+FX4hX4rwWKZ2y2Yhq440C1qidm4l0Pm1np68xBCNgpuuVxb4TDdls0
   hPylNtzLKnc28sP7KN2GoV+JE86a9bZEtvKeGiJR+IKjbo4YY7yI7bx4s
   +RLFSlTvWomLxWtRCZ7P9IFZ/Jzn0MTJM46ZdL4W0kW7g9+hn/plhsdhK
   7zNXg7lwWHg3+bBKZj6T20qcV7JJUFjEvjtOdsc0v5iSnMfL5ALj6ERED
   r1z7GdPOVU3xyM8uufG/86DGLTNilEJiB01qw6dFDo79/CfsXTxHSQroR
   Q==;
X-CSE-ConnectionGUID: 8mMDblDdTqGlyoAvGx7Liw==
X-CSE-MsgGUID: IbWGXiQ6T1GkHy44RH7RrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62012591"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62012591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:27 -0700
X-CSE-ConnectionGUID: cz7C1YuETtqAIXmbZXyrkA==
X-CSE-MsgGUID: Z/vXFOjEQV6hKCVT+0r/Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="170199744"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Jun 2025 17:52:18 -0700
Subject: [PATCH 4/6] submodule--helper: improve logic for fallback remote
 name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-jk-submodule-helper-use-url-v1-4-6d14c1504e91@gmail.com>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

The repo_get_default_remote() function in submodule--helper currently
tries to figure out the proper remote name to use for a submodule based
on a few factors.

First, it tries to find the remote for the currently checked out branch.
This works if the submodule is configured to checkout to a branch
instead of a detached HEAD state.

In the detached HEAD state, the code calls back to using "origin", on
the assumption that this is the default remote name. Some users may
change this, such as by setting clone.defaultRemoteName, or by changing
the remote name manually within the submodule repository.

As a first step to improving this situation, refactor to reuse the logic
from remotes_remote_for_branch(). This function uses the remote from the
branch if it has one. If it doesn't then it checks to see if there is
exactly one remote. It uses this remote first before attempting to fall
back to "origin".

To allow using this helper function, introduce a repo_default_remote()
helper to remote.c which takes a repository structure. This helper will
load the remote configuration and get the "HEAD" branch. Then it will
call remotes_remote_for_branch to find the default remote.

This method allows re-using the same existing logic as other flows,
rather than duplicating it in submodule--helper.c.

This isn't a perfect solution for users who change remote names, but it
should help in cases where the remote name is changed but users haven't
added any additional remotes.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 remote.h                    |  2 ++
 builtin/submodule--helper.c | 18 +++---------------
 remote.c                    | 25 ++++++++++++++++++++-----
 t/t7406-submodule-update.sh | 29 +++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/remote.h b/remote.h
index 7e4943ae3a70ecefa3332d211084762ca30b59b6..ef0de4aa64e9ccd32cc2eea076c00386dcba1161 100644
--- a/remote.h
+++ b/remote.h
@@ -338,6 +338,8 @@ const char *remote_for_branch(struct branch *branch, int *explicit);
 const char *pushremote_for_branch(struct branch *branch, int *explicit);
 char *remote_ref_for_branch(struct branch *branch, int for_push);
 
+const char *repo_default_remote(struct repository *repo);
+
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9e8cdfe1b2a8c2985d9c1b8ad6f1b0d1f9401714..ef3ff65a80f398c5ac35660288290ad92c7132c7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -43,8 +43,6 @@ typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 
 static int repo_get_default_remote(struct repository *repo, char **default_remote)
 {
-	char *dest = NULL;
-	struct strbuf sb = STRBUF_INIT;
 	struct ref_store *store = get_main_ref_store(repo);
 	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
 						      NULL);
@@ -52,23 +50,13 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 	if (!refname)
 		return die_message(_("No such ref: %s"), "HEAD");
 
-	/* detached HEAD */
-	if (!strcmp(refname, "HEAD")) {
-		*default_remote = xstrdup("origin");
-		return 0;
-	}
-
-	if (!skip_prefix(refname, "refs/heads/", &refname))
+	if (strcmp(refname, "HEAD") &&
+	    !skip_prefix(refname, "refs/heads/", &refname))
 		return die_message(_("Expecting a full ref name, got %s"),
 				   refname);
 
-	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (repo_config_get_string(repo, sb.buf, &dest))
-		*default_remote = xstrdup("origin");
-	else
-		*default_remote = dest;
+	*default_remote = xstrdup(repo_default_remote(repo));
 
-	strbuf_release(&sb);
 	return 0;
 }
 
diff --git a/remote.c b/remote.c
index 1035f0cd32d034cce05bd2a3d829ec90795ff4e2..fcda185ecfab5102afbe8918fed65c74971ef8c2 100644
--- a/remote.c
+++ b/remote.c
@@ -1759,20 +1759,35 @@ static void set_merge(struct repository *repo, struct branch *ret)
 	}
 }
 
-struct branch *branch_get(const char *name)
+static struct branch *repo_branch_get(struct repository *repo, const char *name)
 {
 	struct branch *ret;
 
-	read_config(the_repository, 0);
+	read_config(repo, 0);
 	if (!name || !*name || !strcmp(name, "HEAD"))
-		ret = the_repository->remote_state->current_branch;
+		ret = repo->remote_state->current_branch;
 	else
-		ret = make_branch(the_repository->remote_state, name,
+		ret = make_branch(repo->remote_state, name,
 				  strlen(name));
-	set_merge(the_repository, ret);
+	set_merge(repo, ret);
 	return ret;
 }
 
+struct branch *branch_get(const char *name)
+{
+	return repo_branch_get(the_repository, name);
+}
+
+const char *repo_default_remote(struct repository *repo)
+{
+	struct branch *branch;
+
+	read_config(repo, 0);
+	branch = repo_branch_get(repo, "HEAD");
+
+	return remotes_remote_for_branch(repo->remote_state, branch, NULL);
+}
+
 int branch_has_merge_config(struct branch *branch)
 {
 	return branch && !!branch->merge;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c562bad042ab2d4d0f82cb8b57a1eadbe24044d1..748b529745a5121f121768bb4e0cbc11bc833ea4 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1134,6 +1134,35 @@ test_expect_success 'setup clean recursive superproject' '
 	git clone --recurse-submodules top top-clean
 '
 
+test_expect_success 'submodule update with renamed remote' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	# Create a commit in each repo, starting with bottom
+	test_commit -C bottom rename_commit &&
+	# Create middle commit
+	git -C middle/bottom fetch &&
+	git -C middle/bottom checkout -f FETCH_HEAD &&
+	git -C middle add bottom &&
+	git -C middle commit -m "rename_commit" &&
+	# Create top commit
+	git -C top/middle fetch &&
+	git -C top/middle checkout -f FETCH_HEAD &&
+	git -C top add middle &&
+	git -C top commit -m "rename_commit" &&
+
+	# rename the submodule remote
+	git -C top-cloned/middle remote rename origin upstream &&
+
+	# Make the update of "middle" a no-op, otherwise we error out
+	# because of its unmerged state
+	test_config -C top-cloned submodule.middle.update !true &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	cat >expect.err <<-\EOF &&
+	EOF
+	test_cmp expect.err actual.err
+'
+
 test_expect_success 'submodule update should skip unmerged submodules' '
 	test_when_finished "rm -fr top-cloned" &&
 	cp -r top-clean top-cloned &&

-- 
2.48.1.397.gec9d649cc640

