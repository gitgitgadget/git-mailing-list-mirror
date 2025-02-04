Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5321C17E
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704906; cv=none; b=c8Fxbs73H/pBgJk+tEYHRky5fyT2QsfLhknifZC8ZHOHFvPm2+d9XAbQg8HXvat6f+WeUP3khRG4EdW8wd/ib5BwGYnqUrGTKbM2Ly+/XaZyVGDFCJ8okP4c2b7V1sE97BXshSeg3iGhqdILOizKI4Q5kiDIoTwxePErTSQcio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704906; c=relaxed/simple;
	bh=3VOBjfj4Xikmz6eM66lV1tnsXcB09bJdPbc/BUp9Wxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F737Pax9ylYXrZWQ1kvtdjDW6vzk9dRg5PQjBnX3k0b0ATreMAyoquv2FLqwi3sbrfiJO+ubgGEm2r5dQJ6I2Sk0i6AFdU4RBQuZv70mbTOjyDeH9Bj5FxVFYRR4j73TlVjhGhPJPJYPj765qzFB1aPW8Pw/GOvySypu6VRbutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yoyUzYFp; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yoyUzYFp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738704891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uK2sYAIKIw9maMaRRGYwSRv+1aIq1YFGEXsnJi3GXqs=;
	b=yoyUzYFpbzrBZa/E1WBia6rD3pwmHh04+aG9IbDK7yV7knYpgttoedNGbNowCdPUHJHiyG
	MG0EThs5Fvvr7y7JojCw09cPMC7BefsGncbGqwHP0Sfpz5lQcZN0ytF9jQvkajKw17TnGz
	RdZDJx0z24pDgoQU/XKsK0eb394Rj10=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 04 Feb 2025 22:34:06 +0100
Subject: [PATCH v5 7/7] builtin/clone: teach git-clone(1) the --revision=
 option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-toon-clone-refs-v5-7-37e34af283c8@iotcl.com>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
In-Reply-To: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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
 builtin/clone.c             |  57 ++++++++++++++++----
 t/meson.build               |   1 +
 t/t5621-clone-revision.sh   | 123 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index e89ae2e8c664f4d4e15e5f05264c8df988295e3d..7bf6adb98350a9202b01a58f86ee210d9cb85abc 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -221,6 +221,16 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
+`--revision=<rev>`::
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
index 275940f4f5037de65d0f33eba3e7bc031f9b122b..e66105a62186740845d2014e088ff7cb97ca30f2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -59,6 +59,7 @@
 
 struct clone_opts {
 	int wants_head;
+	int detach;
 };
 #define CLONE_OPTS_INIT { \
 	.wants_head = 1 /* default enabled */ \
@@ -565,11 +566,11 @@ static void update_remote_refs(const struct ref *refs,
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
@@ -580,8 +581,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			install_branch_config(0, head, remote_name, our->name);
 		}
 	} else if (our) {
-		struct commit *c = lookup_commit_reference(the_repository,
-							   &our->old_oid);
+		struct commit *c = lookup_commit_or_die(&our->old_oid,
+						        our->name);
+
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		refs_update_ref(get_main_ref_store(the_repository), msg,
 				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
@@ -900,6 +902,7 @@ int cmd_clone(int argc,
 	int option_filter_submodules = -1; /* unspecified */
 	struct string_list server_options = STRING_LIST_INIT_NODUP;
 	const char *bundle_uri = NULL;
+	char *option_rev = NULL;
 
 	struct clone_opts opts = CLONE_OPTS_INIT;
 
@@ -943,6 +946,8 @@ int cmd_clone(int argc,
 			   N_("use <name> instead of 'origin' to track upstream")),
 		OPT_STRING('b', "branch", &option_branch, N_("branch"),
 			   N_("checkout <branch> instead of the remote's HEAD")),
+		OPT_STRING(0, "revision", &option_rev, N_("rev"),
+			   N_("clone single revision <rev> and check out")),
 		OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
 			   N_("path to git-upload-pack on the remote")),
 		OPT_STRING(0, "depth", &option_depth, N_("depth"),
@@ -1279,7 +1284,7 @@ int cmd_clone(int argc,
 		strbuf_addstr(&branch_top, src_ref_prefix);
 
 		git_config_set("core.bare", "true");
-	} else {
+	} else if (!option_rev) {
 		strbuf_addf(&branch_top, "refs/remotes/%s/", remote_name);
 	}
 
@@ -1298,8 +1303,9 @@ int cmd_clone(int argc,
 
 	remote = remote_get_early(remote_name);
 
-	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
-			branch_top.buf);
+	if (!option_rev)
+		refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
+				branch_top.buf);
 
 	path = get_repo_path(remote->url.v[0], &is_bundle);
 	is_local = option_local != 0 && path && !is_bundle;
@@ -1342,6 +1348,11 @@ int cmd_clone(int argc,
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
+	die_for_incompatible_opt2(!!option_rev, "--revision",
+				  !!option_branch, "--branch");
+	die_for_incompatible_opt2(!!option_rev, "--revision",
+				  option_mirror, "--mirror");
+
 	if (reject_shallow)
 		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
 	if (option_depth)
@@ -1378,7 +1389,14 @@ int cmd_clone(int argc,
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	if (option_rev) {
+		option_tags = 0;
+		option_single_branch = 0;
+		opts.wants_head = 0;
+		opts.detach = 1;
+
+		refspec_append(&remote->fetch, option_rev);
+	}
 
 	if (option_tags || option_branch)
 		/*
@@ -1393,6 +1411,17 @@ int cmd_clone(int argc,
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
@@ -1501,6 +1530,11 @@ int cmd_clone(int argc,
 		if (!our_head_points_at)
 			die(_("Remote branch %s not found in upstream %s"),
 			    option_branch, remote_name);
+	} else if (option_rev) {
+		our_head_points_at = mapped_refs;
+		if (!our_head_points_at)
+			die(_("Remote revision %s not found in upstream %s"),
+			    option_rev, remote_name);
 	} else if (remote_head_points_at) {
 		our_head_points_at = remote_head_points_at;
 	} else if (remote_head) {
@@ -1539,8 +1573,9 @@ int cmd_clone(int argc,
 		free(to_free);
 	}
 
-	write_refspec_config(src_ref_prefix, our_head_points_at,
-			remote_head_points_at, &branch_top);
+	if (!option_rev)
+		write_refspec_config(src_ref_prefix, our_head_points_at,
+				     remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
 		partial_clone_register(remote_name, &filter_options);
@@ -1556,7 +1591,7 @@ int cmd_clone(int argc,
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
-	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
+	update_head(&opts, our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
 
 	/*
 	 * We want to show progress for recursive submodule clones iff
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
2.48.1.447.gc0086e9015

