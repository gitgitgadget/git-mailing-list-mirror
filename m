Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9517A586
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732881696; cv=none; b=Cnm/HilpS4thEucCJmXs950VqcJNV+GM2X1sJpLQ5InlWOO0tQIiDvLD8PSGWzCb5zJ82aMjqTY82b3mTD7PJ70y2AqG0Gw+NmeiD5p7TISNb4WAXCVWX3nYUkGCnfvyQjbLkcc951H0BMgQqWOBafohTek8GiMIw2JtePkCit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732881696; c=relaxed/simple;
	bh=4HtP9zZKuEDuunZdT/TdQNY1qvtXhm3F1w5TACMi23w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EgbeFEJ34uaUuzFZXJ8ljD8NfI1PA0D99f3npvFMpTUfncPkRQ2uAehYmGCAwVlNNlklrtN0crpVle4mzK331i/nfH8D73TbwDcX4YnvgxIcc2NL8GdSKXbJx6BUxbC0nxu6GdxYAMoxi7uETvldgV8HPeM0iQXmRXE+Z/3VuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
Date: Fri, 29 Nov 2024 13:00:42 +0100
Subject: [PATCH v2] builtin/clone: teach git-clone(1) the --revision=
 option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAOmsSWcC/x2NQQqDMBBFryKzbiQzsVW76j2KC4mxDtiMJCItk
 rs3zfI9+O+fEF1gF+FenRDcwZHFZ6BLBXYZ/cspnjIDaWoQqVe7iFd2Fe9UcHNU42RuZNqW5p4
 gr7Zs+VOKzyHzwnGX8C0HB/5taemeWt1dG9PVqFE3BhWW9oNlt2tt5Q1DSukHpuTml6EAAAA=
X-Change-ID: 20241129-toon-clone-refs-ad3623772f92
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
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
cannot selected upon git-clone(1).

Add option `--revision` to git-clone(1). This option accepts a fully
qualified reference, or a raw commit hash. This enables the user to
clone and checkout any revision they want. `--revision` can be used in
conjunction with `--depth` to do a minimal clone that only contains the
sources for a single revision. This can be useful for automated tests.

This type of shallow clone could also be achieved with the following set
of commands:

    git init the-repo
    cd ./the-repo
    git remote add origin <url>
    git fetch --depth=1 origin <commit-id>
    git checkout <commit-id>

Unfortunately, this approach uses git-fetch(1) instead of git-clone(1),
and only on git-clone(1) the bundle URIs advertised by the server are
used. By adding this option `--revision` to git-clone(1) allows us to
get the same end result, while benefiting from bundle URIs if advertised
by the server.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
I've submitted a similar change before[1], but this is a little bit of
an alternative approach. There was a request[2] to also make it possible
to clone a revision by a commit hash, so I've reworked the patch to
enable that. Because of this I've renamed the option from `--ref` to
`--revision`.

In the previous patch the code was heavily intertwined with handling
`--single-branch`, `--branch`, and `--no-tags`. This make the code a lot
more complicated. In this version of the patch I've made the new option
incompatible with those and added a separate code path to deal with it
specifically.

[1]: https://lore.kernel.org/git/20240927085438.1010431-1-toon@iotcl.com/
[2]: https://lore.kernel.org/git/ZzNJGHMlxGQyFV_c@kitsune.suse.cz/
---
 Documentation/git-clone.txt |  7 ++++
 builtin/clone.c             | 64 +++++++++++++++++++++++++-----
 t/t5620-clone-revision.sh   | 97 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7acb4cb17618c6cbee5d6ebe41a53be03ebfaa6c..2a3f6d9deae4b817db50d8c4e555a6f33b8296f1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -218,6 +218,13 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
+`--revision` _<rev>_::
+	This clones the given revision, and that revision only. The argument can
+	be a symbolic ref name (e.g. `refs/heads/main`), or a raw commit hash.
+	Unless the revision points to a branch (i.e. ref starting with
+	`refs/heads/`), the HEAD is detached.
+	This option is incompatible with `--branch`, `--mirror`, and `--bare`.
+
 `-u` _<upload-pack>_::
 `--upload-pack` _<upload-pack>_::
 	When given, and the repository to clone from is accessed
diff --git a/builtin/clone.c b/builtin/clone.c
index c0013c75cdc7672abced893c36d2aaf4ff246045..0b118388e059068e78ac1eff4c0a9685a1c4e26b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -69,6 +69,7 @@ static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
 static char *remote_name = NULL;
 static char *option_branch = NULL;
+static char *option_rev = NULL;
 static struct string_list option_not = STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
 static const char *ref_format;
@@ -141,6 +142,8 @@ static struct option builtin_clone_options[] = {
 		   N_("use <name> instead of 'origin' to track upstream")),
 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
 		   N_("checkout <branch> instead of the remote's HEAD")),
+	OPT_STRING(0, "revision", &option_rev, N_("rev"),
+		   N_("clone single revision <rev> and check out")),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
 		   N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
@@ -682,12 +685,14 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			install_branch_config(0, head, remote_name, our->name);
 		}
 	} else if (our) {
-		struct commit *c = lookup_commit_reference(the_repository,
-							   &our->old_oid);
-		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		refs_update_ref(get_main_ref_store(the_repository), msg,
-				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
-				UPDATE_REFS_DIE_ON_ERR);
+		struct commit *c =
+			lookup_commit_reference(the_repository, &our->old_oid);
+
+		if (c)
+			/* --branch specifies a non-branch (i.e. tags), detach HEAD */
+			refs_update_ref(get_main_ref_store(the_repository), msg,
+					"HEAD", &c->object.oid, NULL,
+					REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
@@ -889,7 +894,7 @@ static void write_refspec_config(const char *src_ref_prefix,
 	struct strbuf key = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
 
-	if (option_mirror || !option_bare) {
+	if (!option_rev && (option_mirror || !option_bare)) {
 		if (option_single_branch && !option_mirror) {
 			if (option_branch) {
 				if (starts_with(our_head_points_at->name, "refs/tags/"))
@@ -968,7 +973,7 @@ int cmd_clone(int argc,
 	char *repo_to_free = NULL;
 	char *path = NULL, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
-	const struct ref *refs, *remote_head;
+	const struct ref *refs = NULL, *remote_head;
 	struct ref *remote_head_points_at = NULL;
 	const struct ref *our_head_points_at;
 	char *unborn_head = NULL;
@@ -1345,6 +1350,18 @@ int cmd_clone(int argc,
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
+	if (option_rev) {
+		if (option_branch)
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--revision", "--branch");
+		if (option_mirror)
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--revision", "--mirror");
+		if (option_bare)
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--revision", "--bare");
+	}
+
 	if (reject_shallow)
 		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
 	if (option_depth)
@@ -1387,7 +1404,27 @@ int cmd_clone(int argc,
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
 
-	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
+	if (option_rev) {
+		refspec_clear(&remote->fetch);
+		refspec_init(&remote->fetch, REFSPEC_FETCH);
+		refspec_append(&remote->fetch, option_rev);
+
+		strvec_clear(&transport_ls_refs_options.ref_prefixes);
+		refspec_ref_prefixes(&remote->fetch,
+				     &transport_ls_refs_options.ref_prefixes);
+
+		if (transport_ls_refs_options.ref_prefixes.nr == 0)
+			/*
+			 * We need to talk to the server to determine the hash
+			 * algorithm, but when no ref prefixes are set the
+			 * server announces all known refs, so ask the server to
+			 * only tell us about HEAD.
+			 */
+			strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	}
+
+	refs = transport_get_remote_refs(transport,
+					 &transport_ls_refs_options);
 
 	/*
 	 * Now that we know what algorithm the remote side is using, let's set
@@ -1461,8 +1498,13 @@ int cmd_clone(int argc,
 		}
 	}
 
-	if (refs)
+	if (option_rev) {
+		struct ref **tail = &mapped_refs;
+
+		get_fetch_map(refs, &remote->fetch.items[0], &tail, 1);
+	} else if (refs) {
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
+	}
 
 	if (mapped_refs) {
 		/*
@@ -1495,6 +1537,8 @@ int cmd_clone(int argc,
 		if (!our_head_points_at)
 			die(_("Remote branch %s not found in upstream %s"),
 			    option_branch, remote_name);
+	} else if (option_rev) {
+		our_head_points_at = mapped_refs;
 	} else if (remote_head_points_at) {
 		our_head_points_at = remote_head_points_at;
 	} else if (remote_head) {
diff --git a/t/t5620-clone-revision.sh b/t/t5620-clone-revision.sh
new file mode 100755
index 0000000000000000000000000000000000000000..833438e46d1c648ca46cf9d0a2948aad261c7f89
--- /dev/null
+++ b/t/t5620-clone-revision.sh
@@ -0,0 +1,97 @@
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
+	test_commit "second commit" README "Hello world" v1.0 &&
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
+	test_cmp expect actual &&
+	git for-each-ref refs/heads/feature > expect &&
+	git -C dst for-each-ref > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with --depth and --revision being a branch' '
+	test_when_finished "rm -rf dst" &&
+	git clone --depth=1 --revision=refs/heads/feature . dst &&
+	git rev-parse refs/heads/feature >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with --revision being a tag' '
+	test_when_finished "rm -rf dst" &&
+	git clone --revision=refs/tags/v1.0 . dst &&
+	git rev-parse refs/tags/v1.0 >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with --revision being HEAD' '
+	test_when_finished "rm -rf dst" &&
+	git clone --revision=HEAD . dst &&
+	git rev-parse HEAD >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with --revision being a raw commit hash' '
+	test_when_finished "rm -rf dst" &&
+	oid=$(git rev-parse refs/heads/feature) &&
+	git clone --revision=$oid . dst &&
+	echo $oid >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with --revision being a short raw commit hash' '
+	test_when_finished "rm -rf dst" &&
+	oid=$(git rev-parse --short refs/heads/feature) &&
+	git clone --revision=$oid . dst 2>err &&
+	grep "warning: remote HEAD refers to nonexistent ref, unable to checkout" err
+'
+
+test_expect_success 'clone with --revision being a tree hash' '
+	test_when_finished "rm -rf dst" &&
+	oid=$(git rev-parse refs/heads/feature^{tree}) &&
+	git clone --revision=$oid . dst 2>err &&
+	grep "warning: remote HEAD refers to nonexistent ref, unable to checkout" err
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
+test_expect_success 'clone with --revision and --bare fails' '
+	test_when_finished "rm -rf dst" &&
+	test_must_fail git clone --revision=refs/heads/main --bare . dst
+'
+
+test_done

---
base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
change-id: 20241129-toon-clone-refs-ad3623772f92

Best regards,
-- 
Toon Claes <toon@iotcl.com>

