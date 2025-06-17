Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42052F0C51
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195859; cv=none; b=eb7crycSHdOYkNyokLDlV3imVLEh8m3jPNh3JlRMYsFzCai2Aq5Eo1Ck7tSZVBiL6TYTChXPQh3BoMyIKNOFCLRaZ9CInDivffJ0D/KYOwBEXBNhyihMZMwImTdjXNc8+JzvP5shjbZL+bfd6oG0tCZ08gVT4hqp1LGbkppQeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195859; c=relaxed/simple;
	bh=e1UdpfWnEK5TwRlehx6FR/Rmu6GylUi8CL5o7WsYq0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JX8qaVoHcGlNxuo1Dv7NN8YHa797Pjb8Z72Rt/0qzKVV++x+u3gP6mAL1lH/0fZHwfKRhyA/WQ7hZEAOx5J64LlY+lcpTc802LMU+RSro5iV4K1H/zD48ewB+9qWy507HU58wA+flG7fjpvObgQCHtz3XZIw+fgN86D7T8b+yrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNj+ePXo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNj+ePXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750195857; x=1781731857;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e1UdpfWnEK5TwRlehx6FR/Rmu6GylUi8CL5o7WsYq0A=;
  b=nNj+ePXoV13EcBc/0Gh6s9msOu1F1b/uuLOJInw2Khx83HFr1rEmb9Kv
   ve8i1KsJHQsVM+88R28Yix7sjoe8XKm5T8obCf0M6zvWIhEUCATfqEtaI
   VJ7k512Pu3vTm/Vk30qy5G5Umpnn93fPN3T860Z6wc30E7qIWG5/XR07A
   zeSwxutwm7hE2876m6cS1b8qOwa2QdTRIXFtZi6bslZEWnYefnjY0wa58
   oIu+7q+0tFIbdYpABHsHwvmrt40oY1J3059qaDPRenYNZIhT+lCwx72On
   9VBIn5YJJ7Rd+MkWTobCArZKpHczsPJb9pZd4JYb810KWMTaQmA8Eiz3N
   A==;
X-CSE-ConnectionGUID: o4ZPHB2NSOGKI97Sk814og==
X-CSE-MsgGUID: gKp4WlsDQeyKTPr03GUthA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56195389"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="56195389"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:52 -0700
X-CSE-ConnectionGUID: WhJm7C0ZQaOmcXr9HETBSA==
X-CSE-MsgGUID: Rn/MdEL0SG+FedzHnJnUyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153856676"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Jun 2025 14:30:44 -0700
Subject: [PATCH v2 4/6] submodule--helper: improve logic for fallback
 remote name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-jk-submodule-helper-use-url-v2-4-04cbb003177d@gmail.com>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
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
index 0fca14348fd3d0734c599b13278afef2e00107b9..672e8e893b8243c09145c340f412aa0eae8d562f 100644
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
index b3a9881a6eacf90bee71d6760858b37d68263502..94b31f4c23057a247a968fc0ebe2e5170e99614d 100644
--- a/remote.c
+++ b/remote.c
@@ -1767,20 +1767,35 @@ static void set_merge(struct repository *repo, struct branch *ret)
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

