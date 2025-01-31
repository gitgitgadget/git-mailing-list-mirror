Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A631E3DFF
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337500; cv=none; b=lx0OSZOpFEkGWfQ+hPVbVptbFT7l+jGFtRVvu/bKszHTrgqoPJ8Nkko9boIutVkBClC6vxhuOJKhg5Fo5HBJVC+uMtsGHoTr/1w0WYRxRKPdLe4ZmFuiDUMiFPNCu8zmb7jgpsIAdqnvpuReS7TpOWYecY5ALKDHTlDvpsd5NTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337500; c=relaxed/simple;
	bh=DQn1aQx/A9Sx55Aq01jZhKQBLpVJ/DQ9oa6DP5PdYR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HM8Qgr+TZlyfvdai1UGestrptiJVUo+93RnsYFoCjqs8h8+jmwHtCP7BQiuNtpKF1512nxIYt25OjmJQc4vJoZ5F051oZK8trVzSY2vPTjWLg1SzMzTdmmAiAQt5HwcoJu+QbElWlSY7bmmMgmX6X/5rMFHhe4naIuRNqnpohSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wG3gKV4Z; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wG3gKV4Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738337495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3aA87Ep9CuUhtjN4tPJRD1apf3HumgpRK35RuKP+ss=;
	b=wG3gKV4Zs0mRAhLym3pYMBNGE80IrOJ6oLr/2K0PHbidPfUM6f/j0vYS23KtqGd//uzicD
	j/KqTxTc7p7FsBCmmtPhEsT94ESFTHuvlcB5UAiuYTjBKNIYvIuYABVBKxr04OsgrTA8f7
	T4ZLEuTiW8jh/P2c1f/jmYG99ihS+0U=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 31 Jan 2025 16:30:34 +0100
Subject: [PATCH v4 6/6] builtin/clone: teach git-clone(1) the --revision=
 option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-toon-clone-refs-v4-6-2a4ff851498f@iotcl.com>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
In-Reply-To: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The git-clone(1) command has the option `--branch` that allows the user
to select the branch they want HEAD to point to. In a non-bare
repository this also checks out that branch.

Option `--branch` also accepts a tag. When a tag name is provided, the
commit this tag points to is checked out and HEAD is detached. Thus
`--branch` can be used to clone a repository and check out a ref kept
under `refs/heads` or `refs/tags`. But some other refs might be in use
as well. For example Git forges might use refs like `refs/pull/<id>` and
`refs/merge-requests/<id>` to track pull/merge requests. These refs
cannot be selected upon git-clone(1).

Add option `--revision` to git-clone(1). This option accepts a fully
qualified reference, or a hexadecimal commit ID. This enables the user
to clone and check out any revision they want. `--revision` can be used
in conjunction with `--depth` to do a minimal clone that only contains
the blob and tree for a single revision. This can be useful for
automated tests running in CI systems.

Using option `--branch` and `--single-branch` together is a similar
scenario, but serves a different purpose. Using these two options, a
singlet remote tracking branch is created and the fetch refspec is set
up so git-fetch(1) will receive updates on that branch from the remote.
This allows the user work on that single branch.

Option `--revision` on contrary detaches HEAD, creates no tracking
branches, and writes no fetch refspec.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-clone.txt |  10 ++++
 builtin/clone.c             |  59 +++++++++++++++++----
 parse-options.h             |   9 ++++
 t/meson.build               |   1 +
 t/t5621-clone-revision.sh   | 123 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 193 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 99a9222e63429b3447deb3e7c08962d4ec60a295..6c882b6fc56c2595059124cd0ecdaf825e310160 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -221,6 +221,16 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
+`--revision` _<rev>_::
+	Create a new repository, and fetch the history leading to the given
+	revision _<rev>_ (and nothing else), without making any remote-tracking
+	branch, and without making any local branch, and point `HEAD` to
+	_<rev>_. When creating a non-bare repository, the revision is checked
+	out on a detached `HEAD`. The argument can be a ref name
+	(e.g. `refs/heads/main` or `refs/tags/v1.0`) that peels down to a
+	commit, or a hexadecimal object name.
+	This option is incompatible with `--branch` and `--mirror`.
+
 `-u` _<upload-pack>_::
 `--upload-pack` _<upload-pack>_::
 	When given, and the repository to clone from is accessed
diff --git a/builtin/clone.c b/builtin/clone.c
index f92017c751dd31cb25a3ba31667b015d5766ce84..40d6ecfa74608193a88715a29b4ca765687a0c86 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -59,6 +59,7 @@
 
 struct clone_opts {
 	int wants_head;
+	int detach;
 };
 #define CLONE_OPTS_INIT { \
 	.wants_head = 1 /* default enabled */ \
@@ -568,11 +569,11 @@ static void update_remote_refs(const struct ref *refs,
 	}
 }
 
-static void update_head(const struct ref *our, const struct ref *remote,
+static void update_head(struct clone_opts *opts, const struct ref *our, const struct ref *remote,
 			const char *unborn, const char *msg)
 {
 	const char *head;
-	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
+	if (our && !opts->detach && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL) < 0)
 			die(_("unable to update HEAD"));
@@ -585,6 +586,10 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
 							   &our->old_oid);
+
+		if (!c)
+			die(_("couldn't look up commit object for '%s'"), our->name);
+
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		refs_update_ref(get_main_ref_store(the_repository), msg,
 				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
@@ -903,6 +908,7 @@ int cmd_clone(int argc,
 	int option_filter_submodules = -1; /* unspecified */
 	struct string_list server_options = STRING_LIST_INIT_NODUP;
 	const char *bundle_uri = NULL;
+	char *option_rev = NULL;
 
 	struct clone_opts opts = CLONE_OPTS_INIT;
 
@@ -946,6 +952,8 @@ int cmd_clone(int argc,
 			   N_("use <name> instead of 'origin' to track upstream")),
 		OPT_STRING('b', "branch", &option_branch, N_("branch"),
 			   N_("checkout <branch> instead of the remote's HEAD")),
+		OPT_STRING(0, "revision", &option_rev, N_("rev"),
+			   N_("clone single revision <rev> and check out")),
 		OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
 			   N_("path to git-upload-pack on the remote")),
 		OPT_STRING(0, "depth", &option_depth, N_("depth"),
@@ -1282,7 +1290,7 @@ int cmd_clone(int argc,
 		strbuf_addstr(&branch_top, src_ref_prefix);
 
 		git_config_set("core.bare", "true");
-	} else {
+	} else if (!option_rev) {
 		strbuf_addf(&branch_top, "refs/remotes/%s/", remote_name);
 	}
 
@@ -1301,8 +1309,9 @@ int cmd_clone(int argc,
 
 	remote = remote_get_early(remote_name);
 
-	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
-			branch_top.buf);
+	if (!option_rev)
+		refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
+				branch_top.buf);
 
 	path = get_repo_path(remote->url.v[0], &is_bundle);
 	is_local = option_local != 0 && path && !is_bundle;
@@ -1345,6 +1354,12 @@ int cmd_clone(int argc,
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
+	die_for_incompatible_opt2(!!option_rev, "--revision",
+				  !!option_branch, "--branch");
+	die_for_incompatible_opt2(!!option_rev, "--revision",
+				  option_mirror, "--mirror");
+	// TODO --no-single-branch
+
 	if (reject_shallow)
 		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
 	if (option_depth)
@@ -1381,7 +1396,15 @@ int cmd_clone(int argc,
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	if (option_rev) {
+		option_tags = 0;
+		option_branch = 0;
+		option_single_branch = 0;
+		opts.wants_head = 0;
+		opts.detach = 1;
+
+		refspec_append(&remote->fetch, option_rev);
+	}
 
 	if (option_tags || option_branch)
 		refspec_append(&remote->fetch, TAG_REFSPEC);
@@ -1392,6 +1415,17 @@ int cmd_clone(int argc,
 		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
 				  option_branch);
 
+	/*
+	 * As part of transport_get_remote_refs() the server tells us the hash
+	 * algorithm, which we require to initialize the repo. But calling that
+	 * function without any ref prefix, will cause the server to announce
+	 * all known refs. If the argument passed to --revision was a hex oid,
+	 * ref_prefixes will be empty so we fall back to asking about HEAD to
+	 * reduce traffic from the server.
+	 */
+	if (opts.wants_head || transport_ls_refs_options.ref_prefixes.nr == 0)
+		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
 	/*
@@ -1500,6 +1534,12 @@ int cmd_clone(int argc,
 		if (!our_head_points_at)
 			die(_("Remote branch %s not found in upstream %s"),
 			    option_branch, remote_name);
+	} else if (option_rev) {
+		our_head_points_at = mapped_refs;
+		if (!our_head_points_at)
+			die(_("Remote revision %s not found in upstream %s"),
+			    option_rev, remote_name);
+		//mapped_refs->name[0] = 0;
 	} else if (remote_head_points_at) {
 		our_head_points_at = remote_head_points_at;
 	} else if (remote_head) {
@@ -1538,8 +1578,9 @@ int cmd_clone(int argc,
 		free(to_free);
 	}
 
-	write_refspec_config(src_ref_prefix, our_head_points_at,
-			remote_head_points_at, &branch_top);
+	if (!option_rev)
+		write_refspec_config(src_ref_prefix, our_head_points_at,
+				     remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
 		partial_clone_register(remote_name, &filter_options);
@@ -1555,7 +1596,7 @@ int cmd_clone(int argc,
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
-	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
+	update_head(&opts, our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
 
 	/*
 	 * We want to show progress for recursive submodule clones iff
diff --git a/parse-options.h b/parse-options.h
index 39f088625494f20dea96b9a9cbe986916773bf60..fca944d9a93d643d984c58de2ead9154c8b16c94 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -436,6 +436,15 @@ static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
 				  0, "");
 }
 
+static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
+					     int opt2, const char *opt2_name)
+{
+	die_for_incompatible_opt4(opt1, opt1_name,
+				  opt2, opt2_name,
+				  0, "",
+				  0, "");
+}
+
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
diff --git a/t/meson.build b/t/meson.build
index 35f25ca4a1d960564190288e9456620a46ccc80a..b5f917926b61de379b6cef45e5f750912422a7d1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -721,6 +721,7 @@ integration_tests = [
   't5617-clone-submodules-remote.sh',
   't5618-alternate-refs.sh',
   't5619-clone-local-ambiguous-transport.sh',
+  't5621-clone-revision.sh',
   't5700-protocol-v1.sh',
   't5701-git-serve.sh',
   't5702-protocol-v2.sh',
diff --git a/t/t5621-clone-revision.sh b/t/t5621-clone-revision.sh
new file mode 100755
index 0000000000000000000000000000000000000000..d4889a954e6300e0e327ebe7dfcf73569d966829
--- /dev/null
+++ b/t/t5621-clone-revision.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+test_description='tests for git clone --revision'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit --no-tag "initial commit" README "Hello" &&
+	test_commit --annotate "second commit" README "Hello world" v1.0 &&
+	test_commit --no-tag "third commit" README "Hello world!" &&
+	git switch -c feature v1.0 &&
+	test_commit --no-tag "feature commit" README "Hello world!" &&
+	git switch main
+'
+
+test_expect_success 'clone with --revision being a branch' '
+	test_when_finished "rm -rf dst" &&
+	git clone --revision=refs/heads/feature . dst &&
+	git rev-parse refs/heads/feature >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
+	test_cmp expect actual &&
+	git -C dst for-each-ref refs >expect &&
+	test_must_be_empty expect &&
+	test_must_fail git -C dst config remote.origin.fetch
+'
+
+test_expect_success 'clone with --depth and --revision being a branch' '
+	test_when_finished "rm -rf dst" &&
+	git clone --no-local --depth=1 --revision=refs/heads/feature . dst &&
+	git rev-parse refs/heads/feature >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
+	test_cmp expect actual &&
+	git -C dst for-each-ref refs >expect &&
+	test_must_be_empty expect &&
+	test_must_fail git -C dst config remote.origin.fetch &&
+	git -C dst rev-list HEAD >actual &&
+	test_line_count = 1 actual
+'
+
+test_expect_success 'clone with --revision being a tag' '
+	test_when_finished "rm -rf dst" &&
+	git clone --revision=refs/tags/v1.0 . dst &&
+	git rev-parse refs/tags/v1.0^{} >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
+	test_cmp expect actual &&
+	git -C dst for-each-ref refs >expect &&
+	test_must_be_empty expect &&
+	test_must_fail git -C dst config remote.origin.fetch
+'
+
+test_expect_success 'clone with --revision being HEAD' '
+	test_when_finished "rm -rf dst" &&
+	git clone --revision=HEAD . dst &&
+	git rev-parse HEAD >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
+	test_cmp expect actual &&
+	git -C dst for-each-ref refs >expect &&
+	test_must_be_empty expect &&
+	test_must_fail git -C dst config remote.origin.fetch
+'
+
+test_expect_success 'clone with --revision being a raw commit hash' '
+	test_when_finished "rm -rf dst" &&
+	oid=$(git rev-parse refs/heads/feature) &&
+	git clone --revision=$oid . dst &&
+	echo $oid >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
+	test_cmp expect actual &&
+	git -C dst for-each-ref refs >expect &&
+	test_must_be_empty expect &&
+	test_must_fail git -C dst config remote.origin.fetch
+'
+
+test_expect_success 'clone with --revision and --bare' '
+	test_when_finished "rm -rf dst" &&
+	git clone --revision=refs/heads/main --bare . dst &&
+	oid=$(git rev-parse refs/heads/main) &&
+	git -C dst cat-file -t $oid >actual &&
+	echo "commit" >expect &&
+	test_cmp expect actual &&
+	git -C dst for-each-ref refs >expect &&
+	test_must_be_empty expect &&
+	test_must_fail git -C dst config remote.origin.fetch
+'
+
+test_expect_success 'clone with --revision being a short raw commit hash' '
+	test_when_finished "rm -rf dst" &&
+	oid=$(git rev-parse --short refs/heads/feature) &&
+	test_must_fail git clone --revision=$oid . dst 2>err &&
+	test_grep "fatal: Remote revision $oid not found in upstream origin" err
+'
+
+test_expect_success 'clone with --revision being a tree hash' '
+	test_when_finished "rm -rf dst" &&
+	oid=$(git rev-parse refs/heads/feature^{tree}) &&
+	test_must_fail git clone --revision=$oid . dst 2>err &&
+	test_grep "error: object $oid is a tree, not a commit" err
+'
+
+test_expect_success 'clone with --revision being the parent of a ref fails' '
+	test_when_finished "rm -rf dst" &&
+	test_must_fail git clone --revision=refs/heads/main^ . dst
+'
+
+test_expect_success 'clone with --revision and --branch fails' '
+	test_when_finished "rm -rf dst" &&
+	test_must_fail git clone --revision=refs/heads/main --branch=main . dst
+'
+
+test_expect_success 'clone with --revision and --mirror fails' '
+	test_when_finished "rm -rf dst" &&
+	test_must_fail git clone --revision=refs/heads/main --mirror . dst
+'
+
+test_done

-- 
2.48.1.164.g9a5474a648.dirty

