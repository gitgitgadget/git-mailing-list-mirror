Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E92222D50
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609600; cv=none; b=qDLKolN80nTTgyWm5SImHFixEoHhFLWKqjXEX16YUFQPyFjfNMI0NfzCus6DeBX706fKJ4LX9DE/istN011tnJ3WBFe/difBI5CDBetmEDYs+AXCCJBleJvfyDEghAKhZCDERPUaYdqbZ0Zg9BfsAGeyaBLOmrOOdm4wg3MdGMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609600; c=relaxed/simple;
	bh=CZMthqkL8DtzTZe8l0yDuAGuvZ3TE9zkBlgRzUAJQuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=MsfD/M8RRvOg0c9rgL/UTM8jrhJjdAqw6A+w8j4CX1Of5bp9dxva/4OTIZwWf8JEIDDqSKpRj03Ik/9dWVMCnOufV3v72E1VKyeo2Y2PoUMgi7xQk29expEwrTRxLbcLs1cTKeur87zlSGq8RjKbaYnu8d5MA81WWwvbRRShrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=I8LtZrMg; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="I8LtZrMg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734609593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4prdGstbGuCUxqJXm1fug2mfkO+dTT1vg8RlQxt84WU=;
	b=I8LtZrMgEutqAfKBkRmgvecc0F52J6nyW9WflZFJTAu96RZdp8GDSs8+zLiEJO4UEd5xcN
	FhXD4z0zuxwKERPVcVLR+3QzV0HNpKyIo7Fam2l+0Eujf2z6OLPj2lfxqz4JdINHjyUF+U
	Ax5B8n5MrkUd2DwwBMCgInW4njeB0IU=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 19 Dec 2024 12:58:50 +0100
Subject: [PATCH v3] builtin/clone: teach git-clone(1) the --revision=
 option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-toon-clone-refs-v3-1-1484faea3008@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAHkKZGcC/22NwQ7CIBAFf6XhLA27oC2e/A/jgVBqN6lgoCGap
 v8u5WA8eJyXzLyVJRfJJXZuVhZdpkTBF5CHhtnJ+LvjNBRmKFABoOZLCJ7bOXjHoxsTN4M8oew
 6HDWyYj3LSq9avN4KT5SWEN/1IMO+1pbQ2In+qGTfggChJHCo7QuFxc6tDQ+26xm/yt/7jMUbr
 FEWtJFHEL/+tm0fXa0/oOEAAAA=
X-Change-ID: 20241129-toon-clone-refs-ad3623772f92
In-Reply-To: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>
References: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>
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
qualified reference, or a raw commit hash. This enables the user to
clone and check out any revision they want. `--revision` can be used in
conjunction with `--depth` to do a minimal clone that only contains the
sources for a single revision. This can be useful for automated tests
running in CI systems.

This type of shallow clone could also be achieved with the following set
of commands:

    git init the-repo
    cd ./the-repo
    git remote add origin <url>
    git fetch --depth=1 origin <commit-id>
    git checkout <commit-id>

Adding this new option to git-clone(1) simplifies this not uncommon
use-case. And besides simplifying this, it enables the use of
git-clone(1) over git-fetch(1). This is beneficial in case bundle URIs
are available on the server. Bundle URIs are only used on clone, not on
fetch, so using allowing the user to use git-clone(1) here makes them
benefit from bundle URIs if advertised by the server.

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
Changes in v3:
- Fail early when the revision was not found on the remote, instead of
  creating a clone that's in an invalid state.
- State more clearly in the commit message adding this option is useful
  for a not uncommon use-case.
- Be explicit in the documentation the ref needs to peel down to a
  commit.
- Die in case we try to update_head() to an object that's not a commit.
- Allow combining `--revision` with `--bare`.
- Add die_for_incompatible_opt2() to parse-options.h and use it for the
  options that are not compatible with the new `--revision` option.
- Small tweaks to the added tests.
- Small touchups on commit messages.
- Link to v2: https://lore.kernel.org/r/20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com
---
Range-diff versus v2:

1:  b5cf7362be ! 1:  592a22fdbd builtin/clone: teach git-clone(1) the --revision= option
    @@ Commit message
         under `refs/heads` or `refs/tags`. But some other refs might be in use
         as well. For example Git forges might use refs like `refs/pull/<id>` and
         `refs/merge-requests/<id>` to track pull/merge requests. These refs
    -    cannot selected upon git-clone(1).
    +    cannot be selected upon git-clone(1).
     
         Add option `--revision` to git-clone(1). This option accepts a fully
         qualified reference, or a raw commit hash. This enables the user to
    -    clone and checkout any revision they want. `--revision` can be used in
    +    clone and check out any revision they want. `--revision` can be used in
         conjunction with `--depth` to do a minimal clone that only contains the
    -    sources for a single revision. This can be useful for automated tests.
    +    sources for a single revision. This can be useful for automated tests
    +    running in CI systems.
     
         This type of shallow clone could also be achieved with the following set
         of commands:
    @@ Commit message
             git fetch --depth=1 origin <commit-id>
             git checkout <commit-id>
     
    -    Unfortunately, this approach uses git-fetch(1) instead of git-clone(1),
    -    and only on git-clone(1) the bundle URIs advertised by the server are
    -    used. By adding this option `--revision` to git-clone(1) allows us to
    -    get the same end result, while benefiting from bundle URIs if advertised
    -    by the server.
    +    Adding this new option to git-clone(1) simplifies this not uncommon
    +    use-case. And besides simplifying this, it enables the use of
    +    git-clone(1) over git-fetch(1). This is beneficial in case bundle URIs
    +    are available on the server. Bundle URIs are only used on clone, not on
    +    fetch, so using allowing the user to use git-clone(1) here makes them
    +    benefit from bundle URIs if advertised by the server.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
      
     +`--revision` _<rev>_::
     +	This clones the given revision, and that revision only. The argument can
    -+	be a symbolic ref name (e.g. `refs/heads/main`), or a raw commit hash.
    -+	Unless the revision points to a branch (i.e. ref starting with
    -+	`refs/heads/`), the HEAD is detached.
    ++	be a ref name (e.g. `refs/heads/main`) that peels down to a commit, or a
    ++	raw commit hash.
    ++	The given revision is checked out, and for any revision other than a
    ++	branch (i.e. ref starting with `refs/heads/`), the HEAD is detached.
     +	This option is incompatible with `--branch`, `--mirror`, and `--bare`.
     +
      `-u` _<upload-pack>_::
    @@ builtin/clone.c: static struct option builtin_clone_options[] = {
      		   N_("path to git-upload-pack on the remote")),
      	OPT_STRING(0, "depth", &option_depth, N_("depth"),
     @@ builtin/clone.c: static void update_head(const struct ref *our, const struct ref *remote,
    - 			install_branch_config(0, head, remote_name, our->name);
    - 		}
      	} else if (our) {
    --		struct commit *c = lookup_commit_reference(the_repository,
    --							   &our->old_oid);
    --		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
    --		refs_update_ref(get_main_ref_store(the_repository), msg,
    --				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
    --				UPDATE_REFS_DIE_ON_ERR);
    -+		struct commit *c =
    -+			lookup_commit_reference(the_repository, &our->old_oid);
    + 		struct commit *c = lookup_commit_reference(the_repository,
    + 							   &our->old_oid);
    ++		if (!c)
    ++			die(_("unable to update HEAD"));
     +
    -+		if (c)
    -+			/* --branch specifies a non-branch (i.e. tags), detach HEAD */
    -+			refs_update_ref(get_main_ref_store(the_repository), msg,
    -+					"HEAD", &c->object.oid, NULL,
    -+					REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
    - 	} else if (remote) {
    - 		/*
    - 		 * We know remote HEAD points to a non-branch, or
    + 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
    + 		refs_update_ref(get_main_ref_store(the_repository), msg,
    + 				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
     @@ builtin/clone.c: static void write_refspec_config(const char *src_ref_prefix,
      	struct strbuf key = STRBUF_INIT;
      	struct strbuf value = STRBUF_INIT;
    @@ builtin/clone.c: int cmd_clone(int argc,
      
      	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
      
    -+	if (option_rev) {
    -+		if (option_branch)
    -+			die(_("options '%s' and '%s' cannot be used together"),
    -+			    "--revision", "--branch");
    -+		if (option_mirror)
    -+			die(_("options '%s' and '%s' cannot be used together"),
    -+			    "--revision", "--mirror");
    -+		if (option_bare)
    -+			die(_("options '%s' and '%s' cannot be used together"),
    -+			    "--revision", "--bare");
    -+	}
    ++	die_for_incompatible_opt2(!!option_rev, "--revision",
    ++				  !!option_branch, "--branch");
    ++	die_for_incompatible_opt2(!!option_rev, "--revision",
    ++				  option_mirror, "--mirror");
     +
      	if (reject_shallow)
      		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
    @@ builtin/clone.c: int cmd_clone(int argc,
      			    option_branch, remote_name);
     +	} else if (option_rev) {
     +		our_head_points_at = mapped_refs;
    ++		if (!our_head_points_at)
    ++			die(_("Remote revision %s not found in upstream %s"),
    ++			    option_rev, remote_name);
      	} else if (remote_head_points_at) {
      		our_head_points_at = remote_head_points_at;
      	} else if (remote_head) {
     
    + ## parse-options.h ##
    +@@ parse-options.h: static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
    + 				  0, "");
    + }
    + 
    ++static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
    ++					     int opt2, const char *opt2_name)
    ++{
    ++	die_for_incompatible_opt4(opt1, opt1_name,
    ++				  opt2, opt2_name,
    ++				  0, "",
    ++				  0, "");
    ++}
    ++
    + /*
    +  * Use these assertions for callbacks that expect to be called with NONEG and
    +  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
    +
    + ## t/meson.build ##
    +@@ t/meson.build: integration_tests = [
    +   't5617-clone-submodules-remote.sh',
    +   't5618-alternate-refs.sh',
    +   't5619-clone-local-ambiguous-transport.sh',
    ++  't5620-clone-revision.sh',
    +   't5700-protocol-v1.sh',
    +   't5701-git-serve.sh',
    +   't5702-protocol-v2.sh',
    +
      ## t/t5620-clone-revision.sh (new) ##
     @@
     +#!/bin/sh
    @@ t/t5620-clone-revision.sh (new)
     +
     +test_expect_success 'setup' '
     +	test_commit --no-tag "initial commit" README "Hello" &&
    -+	test_commit "second commit" README "Hello world" v1.0 &&
    ++	test_commit --annotate "second commit" README "Hello world" v1.0 &&
     +	test_commit --no-tag "third commit" README "Hello world!" &&
     +	git switch -c feature v1.0 &&
     +	test_commit --no-tag "feature commit" README "Hello world!" &&
    @@ t/t5620-clone-revision.sh (new)
     +test_expect_success 'clone with --revision being a tag' '
     +	test_when_finished "rm -rf dst" &&
     +	git clone --revision=refs/tags/v1.0 . dst &&
    -+	git rev-parse refs/tags/v1.0 >expect &&
    ++	git rev-parse refs/tags/v1.0^{} >expect &&
     +	git -C dst rev-parse HEAD >actual &&
     +	test_cmp expect actual
     +'
    @@ t/t5620-clone-revision.sh (new)
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success 'clone with --revision and --bare' '
    ++	test_when_finished "rm -rf dst" &&
    ++	git clone --revision=refs/heads/main --bare . dst &&
    ++	oid=$(git rev-parse refs/heads/main) &&
    ++	git -C dst cat-file -t $oid > actual &&
    ++	echo "commit" >expect &&
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'clone with --revision being a short raw commit hash' '
     +	test_when_finished "rm -rf dst" &&
     +	oid=$(git rev-parse --short refs/heads/feature) &&
    -+	git clone --revision=$oid . dst 2>err &&
    -+	grep "warning: remote HEAD refers to nonexistent ref, unable to checkout" err
    ++	test_must_fail git clone --revision=$oid . dst 2>err &&
    ++	test_grep "fatal: Remote revision $oid not found in upstream origin" err
     +'
     +
     +test_expect_success 'clone with --revision being a tree hash' '
     +	test_when_finished "rm -rf dst" &&
     +	oid=$(git rev-parse refs/heads/feature^{tree}) &&
    -+	git clone --revision=$oid . dst 2>err &&
    -+	grep "warning: remote HEAD refers to nonexistent ref, unable to checkout" err
    ++	test_must_fail git clone --revision=$oid . dst 2>err &&
    ++	test_grep "error: object $oid is a tree, not a commit" err
     +'
     +
     +test_expect_success 'clone with --revision being the parent of a ref fails' '
    @@ t/t5620-clone-revision.sh (new)
     +	test_must_fail git clone --revision=refs/heads/main --mirror . dst
     +'
     +
    -+test_expect_success 'clone with --revision and --bare fails' '
    -+	test_when_finished "rm -rf dst" &&
    -+	test_must_fail git clone --revision=refs/heads/main --bare . dst
    -+'
    -+
     +test_done
---
 Documentation/git-clone.txt |   8 ++++
 builtin/clone.c             |  49 +++++++++++++++++++--
 parse-options.h             |   9 ++++
 t/meson.build               |   1 +
 t/t5620-clone-revision.sh   | 101 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index de8d8f58930ecff305f79480b13ddce10cd96c60..67498dae7c7d0315c7026b4ca2e822e48dcb7479 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -221,6 +221,14 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
+`--revision` _<rev>_::
+	This clones the given revision, and that revision only. The argument can
+	be a ref name (e.g. `refs/heads/main`) that peels down to a commit, or a
+	raw commit hash.
+	The given revision is checked out, and for any revision other than a
+	branch (i.e. ref starting with `refs/heads/`), the HEAD is detached.
+	This option is incompatible with `--branch`, `--mirror`, and `--bare`.
+
 `-u` _<upload-pack>_::
 `--upload-pack` _<upload-pack>_::
 	When given, and the repository to clone from is accessed
diff --git a/builtin/clone.c b/builtin/clone.c
index 21721db28a12864621d27d2c70ee5c2598cccc0f..391757e5260a902a87bcf3b435fe39c6cd841b3b 100644
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
@@ -684,6 +687,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
 							   &our->old_oid);
+		if (!c)
+			die(_("unable to update HEAD"));
+
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		refs_update_ref(get_main_ref_store(the_repository), msg,
 				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
@@ -889,7 +895,7 @@ static void write_refspec_config(const char *src_ref_prefix,
 	struct strbuf key = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
 
-	if (option_mirror || !option_bare) {
+	if (!option_rev && (option_mirror || !option_bare)) {
 		if (option_single_branch && !option_mirror) {
 			if (option_branch) {
 				if (starts_with(our_head_points_at->name, "refs/tags/"))
@@ -968,7 +974,7 @@ int cmd_clone(int argc,
 	char *repo_to_free = NULL;
 	char *path = NULL, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
-	const struct ref *refs, *remote_head;
+	const struct ref *refs = NULL, *remote_head;
 	struct ref *remote_head_points_at = NULL;
 	const struct ref *our_head_points_at;
 	char *unborn_head = NULL;
@@ -1345,6 +1351,11 @@ int cmd_clone(int argc,
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
+	die_for_incompatible_opt2(!!option_rev, "--revision",
+				  !!option_branch, "--branch");
+	die_for_incompatible_opt2(!!option_rev, "--revision",
+				  option_mirror, "--mirror");
+
 	if (reject_shallow)
 		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
 	if (option_depth)
@@ -1387,7 +1398,27 @@ int cmd_clone(int argc,
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
@@ -1461,8 +1492,13 @@ int cmd_clone(int argc,
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
@@ -1495,6 +1531,11 @@ int cmd_clone(int argc,
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
diff --git a/parse-options.h b/parse-options.h
index f0801d4532a175b65783689f2a68fb56da2c8e87..72c62311b61f46152d66bcba9328de59fd300df9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -420,6 +420,15 @@ static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
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
index 13fe854ba0a18f9b83dbc48651f581198042ffd3..606fd6ff9d09f5c90c08ee4b9e108a5a04e187d9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -721,6 +721,7 @@ integration_tests = [
   't5617-clone-submodules-remote.sh',
   't5618-alternate-refs.sh',
   't5619-clone-local-ambiguous-transport.sh',
+  't5620-clone-revision.sh',
   't5700-protocol-v1.sh',
   't5701-git-serve.sh',
   't5702-protocol-v2.sh',
diff --git a/t/t5620-clone-revision.sh b/t/t5620-clone-revision.sh
new file mode 100755
index 0000000000000000000000000000000000000000..92fe0b3f1c1268fc29e0e61d543167ea35845066
--- /dev/null
+++ b/t/t5620-clone-revision.sh
@@ -0,0 +1,101 @@
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
+	git rev-parse refs/tags/v1.0^{} >expect &&
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
+test_expect_success 'clone with --revision and --bare' '
+	test_when_finished "rm -rf dst" &&
+	git clone --revision=refs/heads/main --bare . dst &&
+	oid=$(git rev-parse refs/heads/main) &&
+	git -C dst cat-file -t $oid > actual &&
+	echo "commit" >expect &&
+	test_cmp expect actual
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

---

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
change-id: 20241129-toon-clone-refs-ad3623772f92

Thanks
--
Toon

