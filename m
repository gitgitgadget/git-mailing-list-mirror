Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733B22C355
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720628; cv=none; b=ZRA4SVG3C3hognarCYBrWTtGgjn2pGCRWGucX0AyWhODS71XLUhA5U80Ol7pv0SUs6xBcz4m1ELmgpzTG4H8w+QsW8xdzIsVcmSvBSlfLEHJajNatts+5O4bI7tXTIDwI4ljrILxiTbtFyy65K1kAy347aOl8oq6tjRTgtRcWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720628; c=relaxed/simple;
	bh=0ZJrvMnNmlLvD45TgjmQ7BQOtvGYQlCsq/iGJ9dA6ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRyQphbPFrRaT6smU0MDtrM8PozilSIyQMK+IbkFK+59ntKxUazV0EZeAZSVcqRNPdco3qHJIEK3wJDl0s0aaOTDLFmjvImtkNILvhggGHzvpTvcdtFTZwKdXKtlN3Ju2j5gRjtAdFupDduFSg6bGByc2aM4XbLYsh6lYZLOUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKSWdson; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKSWdson"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720626; x=1782256626;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0ZJrvMnNmlLvD45TgjmQ7BQOtvGYQlCsq/iGJ9dA6ow=;
  b=HKSWdsonHJMvudaAEksD76XmEjjw2hNSTgtGXLirHYOwGrdNymTqxMDr
   h14K4nv9v6x9hStd5GxZ0sFISSr+/G2n42dvKE6UBNAYhhSIUkFsyuQ/r
   BCi60AbJzT3/Zf4LpEAJb49RhNns4A3JZF4dmyTsSr1W2N4+XRP3iE+xf
   EkzPm4R738BBCWuewkTr5qmWoWo5dIZMJVgXFwYwIOEKnlFcmhh1GobR0
   PKeUPQMh49KDSIzpC0QiyXKrUNTEEMJKagpxs3eY2VR4OlQYBMvA/h3Ri
   p2rl74ItXbcOjSZR55m1mhNwrTi4u0IGX+8H0JK0Oil1eJL2S/F66COlZ
   w==;
X-CSE-ConnectionGUID: atY0Pb92SoGp3D7ezFSmOQ==
X-CSE-MsgGUID: 6UPLr32SSR+QAzABWo2UYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53084570"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53084570"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:42 -0700
X-CSE-ConnectionGUID: FVlbCDi4TfOwLzXsJtMygA==
X-CSE-MsgGUID: qsVadAB5RQWJtjIc7eVl+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151888474"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:42 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 16:11:33 -0700
Subject: [PATCH v4 5/7] submodule--helper: improve logic for fallback
 remote name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-jk-submodule-helper-use-url-v4-5-133ef3d89569@gmail.com>
References: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
In-Reply-To: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
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

Replace calls of repo_get_default_remote() with the calls to this new
function. To maintain consistency with the existing callers, continue
copying the returned string with xstrdup.

This isn't a perfect solution for users who change remote names, but it
should help in cases where the remote name is changed but users haven't
added any additional remotes.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 remote.h                    |  3 +++
 builtin/submodule--helper.c | 46 +++++----------------------------------------
 remote.c                    | 25 +++++++++++++++++++-----
 t/t7406-submodule-update.sh | 29 ++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 46 deletions(-)

diff --git a/remote.h b/remote.h
index 76d93bf88d1fb8c0e2cbc2bc99558f23a256155c..8dc5cfa49ef78808348a84c9b3f416b31cd3bbd7 100644
--- a/remote.h
+++ b/remote.h
@@ -9,6 +9,7 @@
 
 struct option;
 struct transport_ls_refs_options;
+struct repository;
 
 /**
  * The API gives access to the configuration related to remotes. It handles
@@ -338,6 +339,8 @@ const char *remote_for_branch(struct branch *branch, int *explicit);
 const char *pushremote_for_branch(struct branch *branch, int *explicit);
 char *remote_ref_for_branch(struct branch *branch, int for_push);
 
+const char *repo_default_remote(struct repository *repo);
+
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9e8cdfe1b2a8c2985d9c1b8ad6f1b0d1f9401714..4aa237033a526fca29cce2926419462179d40ee3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -41,61 +41,25 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static int repo_get_default_remote(struct repository *repo, char **default_remote)
-{
-	char *dest = NULL;
-	struct strbuf sb = STRBUF_INIT;
-	struct ref_store *store = get_main_ref_store(repo);
-	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
-						      NULL);
-
-	if (!refname)
-		return die_message(_("No such ref: %s"), "HEAD");
-
-	/* detached HEAD */
-	if (!strcmp(refname, "HEAD")) {
-		*default_remote = xstrdup("origin");
-		return 0;
-	}
-
-	if (!skip_prefix(refname, "refs/heads/", &refname))
-		return die_message(_("Expecting a full ref name, got %s"),
-				   refname);
-
-	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (repo_config_get_string(repo, sb.buf, &dest))
-		*default_remote = xstrdup("origin");
-	else
-		*default_remote = dest;
-
-	strbuf_release(&sb);
-	return 0;
-}
-
 static int get_default_remote_submodule(const char *module_path, char **default_remote)
 {
 	struct repository subrepo;
-	int ret;
 
 	if (repo_submodule_init(&subrepo, the_repository, module_path,
 				null_oid(the_hash_algo)) < 0)
 		return die_message(_("could not get a repository handle for submodule '%s'"),
 				   module_path);
-	ret = repo_get_default_remote(&subrepo, default_remote);
+
+	*default_remote = xstrdup(repo_default_remote(&subrepo));
+
 	repo_clear(&subrepo);
 
-	return ret;
+	return 0;
 }
 
 static char *get_default_remote(void)
 {
-	char *default_remote;
-	int code = repo_get_default_remote(the_repository, &default_remote);
-
-	if (code)
-		exit(code);
-
-	return default_remote;
+	return xstrdup(repo_default_remote(the_repository));
 }
 
 static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
diff --git a/remote.c b/remote.c
index e7ff21dc0340fd81b0c0c21c9d2199c3c0d53946..e35cf7ec61ac946d1e84c5a0ae309e63c66d0335 100644
--- a/remote.c
+++ b/remote.c
@@ -1772,20 +1772,35 @@ static void set_merge(struct repository *repo, struct branch *ret)
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
 	return branch && branch->set_merge;
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

