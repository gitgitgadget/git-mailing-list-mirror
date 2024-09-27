Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D5157490
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427936; cv=none; b=K4torgikyo7PbskfMZOLH022CmJZgLs54RcWUl5924D6OojM0LXbL/8p2wE+LbL89qz39LF8P/4amNnKJMt0y2Rbu2R7PaFw5hfi1HcjduKe8r/H8yTJ5/RIPYxfp7qhfztyGgOshj+zqahAtwb1hMa7xl2Hl7gRsT3P4XoQJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427936; c=relaxed/simple;
	bh=myRGJCIElEKoRINCpT46mMxgZWRKTS1ecQxUOeeLISo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhRcqidFEjrjXAkTMZnZBrBh0HiM2JEbFq+LNIzDBA0ulu/ba2dqFYmXhBUQZW/wd7pYC/zbYVaJZjvmw4PRcLlsivetDVEPk7GNlS+ABYUWgYr+UPWL8XFmxdby2zhJfjjiFjZczbGosalnaOJePOBdyRWRytD8CQzUlX3vU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=w9makM4l; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="w9makM4l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1727427930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMBjJFMt5KYgON4vKH9f+MgIy9KvDuhccNUcyv3CrWg=;
	b=w9makM4lsKTZGSIxWbSVt84JXL3Xg634OjMpp8ken2cvhVX+8c0+jMfvk7uSq/hgVhwtCu
	H2PIyuLzrMTwX2GDZfnyEFoHSF0aY54sshfUpxwBYLoo8agsD+d+Hyv38G/wifRgiujhtA
	BMAwGSH7QS8bF1Bt2MuSHgJSjPPwi90=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2] builtin/clone: teach git-clone(1) the --ref= argument
Date: Fri, 27 Sep 2024 11:04:55 +0200
Message-ID: <20240927090455.1014896-2-toon@iotcl.com>
In-Reply-To: <20240927090455.1014896-1-toon@iotcl.com>
References: <20240722080705.2614195-1-toon@iotcl.com>
 <20240927090455.1014896-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add option `--ref` to git-clone(1). This enables the user to clone and
checkout the given named reference. It's pretty similar to --branch and
while --branch takes a branch name or tag name, it doesn't take a fully
qualified reference. This allows the user to clone a reference that
doesn't start with refs/heads or refs/tags. This can be useful when the
server uses custom references.

This new argument can be used in conjuction with --single-branch to only
clone the given ref.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-clone.txt |  9 ++++-
 builtin/clone.c             | 67 ++++++++++++++++++++++++++++++++-----
 t/t5612-clone-refspec.sh    | 35 +++++++++++++++++++
 3 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8e925db7e9..ae82f1c1c3 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -215,6 +215,13 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the HEAD at that commit
 	in the resulting repository.

+`--ref` _<name>_::
+	This detaches HEAD and makes it point to the commit where the _<name>_
+	reference is pointing to. In a non-bare repository, this is the ref that
+	will be checked out.
+	Can be used in conjunction with `--single-branch` and `--no-tags` to
+	clone only the given ref. Cannot be combined with `--branch`.
+
 `-u` _<upload-pack>_::
 `--upload-pack` _<upload-pack>_::
 	When given, and the repository to clone from is accessed
@@ -259,7 +266,7 @@ corresponding `--mirror` and `--no-tags` options instead.

 `--`[`no-`]`single-branch`::
 	Clone only the history leading to the tip of a single branch,
-	either specified by the `--branch` option or the primary
+	either specified by the `--branch` or `--ref` option or the primary
 	branch remote's `HEAD` points at.
 	Further fetches into the resulting repository will only update the
 	remote-tracking branch for the branch this option was used for the
diff --git a/builtin/clone.c b/builtin/clone.c
index e77339c847..1081478905 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -69,6 +69,7 @@ static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
 static char *remote_name = NULL;
 static char *option_branch = NULL;
+static char *option_ref = NULL;
 static struct string_list option_not = STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
 static const char *ref_format;
@@ -141,6 +142,8 @@ static struct option builtin_clone_options[] = {
 		   N_("use <name> instead of 'origin' to track upstream")),
 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
 		   N_("checkout <branch> instead of the remote's HEAD")),
+	OPT_STRING(0, "ref", &option_ref, N_("ref"),
+		   N_("checkout <ref> (detached) instead of the remote's HEAD")),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
 		   N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
@@ -531,32 +534,64 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	if (option_single_branch) {
 		struct ref *remote_head = NULL;

-		if (!option_branch)
+		if (!option_branch && !option_ref)
 			remote_head = guess_remote_head(head, refs, 0);
 		else {
 			free_one_ref(head);
 			local_refs = head = NULL;
 			tail = &local_refs;
-			remote_head = copy_ref(find_remote_branch(refs, option_branch));
+			if (option_branch)
+				remote_head = copy_ref(find_remote_branch(refs, option_branch));
+			else
+				remote_head = copy_ref(find_ref_by_name(refs, option_ref));
 		}

 		if (!remote_head && option_branch)
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
+		else if (!remote_head && option_ref)
+			warning(_("Could not find remote ref %s to clone."),
+				option_ref);
 		else {
 			int i;
 			for (i = 0; i < refspec->nr; i++)
 				get_fetch_map(remote_head, &refspec->items[i],
 					      &tail, 0);

-			/* if --branch=tag, pull the requested tag explicitly */
-			get_fetch_map(remote_head, &tag_refspec, &tail, 0);
+			if (option_ref) {
+				struct strbuf spec = STRBUF_INIT;
+				struct refspec_item ref_refspec;
+
+				strbuf_addf(&spec, "%s:%s", option_ref, option_ref);
+				refspec_item_init(&ref_refspec, spec.buf, 0);
+
+				get_fetch_map(remote_head, &ref_refspec, &tail, 0);
+
+				refspec_item_clear(&ref_refspec);
+				strbuf_release(&spec);
+			} else {
+				/* if --branch=tag, pull the requested tag explicitly */
+				get_fetch_map(remote_head, &tag_refspec, &tail, 0);
+			}
 		}
 		free_refs(remote_head);
 	} else {
 		int i;
 		for (i = 0; i < refspec->nr; i++)
 			get_fetch_map(refs, &refspec->items[i], &tail, 0);
+
+		if (option_ref) {
+			struct strbuf spec = STRBUF_INIT;
+			struct refspec_item ref_refspec;
+
+			strbuf_addf(&spec, "%s:%s", option_ref, option_ref);
+			refspec_item_init(&ref_refspec, spec.buf, 0);
+
+			get_fetch_map(refs, &ref_refspec, &tail, 0);
+
+			refspec_item_clear(&ref_refspec);
+			strbuf_release(&spec);
+		}
 	}

 	if (!option_mirror && !option_single_branch && !option_no_tags)
@@ -684,10 +719,15 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
 							   &our->old_oid);
-		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		refs_update_ref(get_main_ref_store(the_repository), msg,
-				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
-				UPDATE_REFS_DIE_ON_ERR);
+		if (c)
+			/* --branch specifies a non-branch (i.e. tags), detach HEAD */
+			refs_update_ref(get_main_ref_store(the_repository), msg,
+					"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
+					UPDATE_REFS_DIE_ON_ERR);
+		else
+			refs_update_ref(get_main_ref_store(the_repository), msg,
+					"HEAD", &our->old_oid, NULL, REF_NO_DEREF,
+					UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
@@ -898,6 +938,9 @@ static void write_refspec_config(const char *src_ref_prefix,
 				else
 					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
 						branch_top->buf, option_branch);
+			} else if (option_ref) {
+				strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
+					our_head_points_at->name);
 			} else if (remote_head_points_at) {
 				const char *head = remote_head_points_at->name;
 				if (!skip_prefix(head, "refs/heads/", &head))
@@ -1383,6 +1426,9 @@ int cmd_clone(int argc,
 	if (option_branch)
 		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
 				  option_branch);
+	if (option_ref)
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    option_ref);
 	if (!option_no_tags)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
@@ -1468,6 +1514,11 @@ int cmd_clone(int argc,
 		if (!our_head_points_at)
 			die(_("Remote branch %s not found in upstream %s"),
 			    option_branch, remote_name);
+	} else if (option_ref) {
+		our_head_points_at = find_ref_by_name(mapped_refs, option_ref);
+		if (!our_head_points_at)
+			die(_("Remote ref %s not found in upstream %s"),
+			    option_ref, remote_name);
 	} else if (remote_head_points_at) {
 		our_head_points_at = remote_head_points_at;
 	} else if (remote_head) {
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 72762de977..bbdf66b7cb 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -17,6 +17,7 @@ test_expect_success 'setup' '
 	git tag two &&
 	echo three >file &&
 	git commit -a -m three &&
+	git update-ref refs/some/three HEAD &&
 	git checkout -b side &&
 	echo four >file &&
 	git commit -a -m four &&
@@ -236,4 +237,38 @@ test_expect_success '--single-branch with detached' '
 	test_must_be_empty actual
 '

+test_expect_success 'with --ref' '
+	git clone --ref=refs/some/three . dir_ref &&
+	git -C dir_ref for-each-ref refs > refs &&
+	sed -e "/HEAD$/d" \
+	    -e "s|/remotes/origin/|/heads/|" refs >actual &&
+	git for-each-ref refs >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'with --ref and --no-tags' '
+	git clone --ref=refs/some/three --no-tags . dir_ref_notags &&
+	git -C dir_ref_notags for-each-ref refs > refs &&
+	sed -e "/HEAD$/d" \
+	    -e "s|/remotes/origin/|/heads/|" refs >actual &&
+	git for-each-ref refs/heads >expect &&
+	git for-each-ref refs/some >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch with --ref' '
+	git clone --single-branch --ref=refs/some/three . dir_single_ref &&
+	git -C dir_single_ref for-each-ref refs > actual &&
+	git for-each-ref refs/some >expect &&
+	git for-each-ref refs/tags >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch with --ref and --no-tags' '
+	git clone --single-branch --ref=refs/some/three --no-tags . dir_single_ref_notags &&
+	git -C dir_single_ref_notags for-each-ref refs > actual &&
+	git for-each-ref refs/some >expect &&
+	test_cmp expect actual
+'
+
 test_done

Range-diff against v1:
1:  8ee6a42431 ! 1:  07363b1de5 builtin/clone: teach git-clone(1) the --ref= argument
    @@ Commit message
         checkout the given named reference. It's pretty similar to --branch and
         while --branch takes a branch name or tag name, it doesn't take a fully
         qualified reference. This allows the user to clone a reference that
    -    doesn't start with refs/heads/ or refs/tags. This can be useful when the
    +    doesn't start with refs/heads or refs/tags. This can be useful when the
         server uses custom references.

    -    Allow the user to clone a certain ref, similar to --branch.
    +    This new argument can be used in conjuction with --single-branch to only
    +    clone the given ref.

         Signed-off-by: Toon Claes <toon@iotcl.com>

    @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
     +	reference is pointing to. In a non-bare repository, this is the ref that
     +	will be checked out.
     +	Can be used in conjunction with `--single-branch` and `--no-tags` to
    -+	clone only given ref. Cannot be combined with `--branch`.
    ++	clone only the given ref. Cannot be combined with `--branch`.
     +
      `-u` _<upload-pack>_::
      `--upload-pack` _<upload-pack>_::
    @@ builtin/clone.c: static void update_head(const struct ref *our, const struct ref
     +		else
     +			refs_update_ref(get_main_ref_store(the_repository), msg,
     +					"HEAD", &our->old_oid, NULL, REF_NO_DEREF,
    -+					UPDATE_REFS_MSG_ON_ERR);
    ++					UPDATE_REFS_DIE_ON_ERR);
      	} else if (remote) {
      		/*
      		 * We know remote HEAD points to a non-branch, or
    @@ t/t5612-clone-refspec.sh: test_expect_success '--single-branch with detached' '

     +test_expect_success 'with --ref' '
     +	git clone --ref=refs/some/three . dir_ref &&
    -+        git -C dir_ref for-each-ref refs > refs &&
    -+        sed -e "/HEAD$/d" \
    ++	git -C dir_ref for-each-ref refs > refs &&
    ++	sed -e "/HEAD$/d" \
     +	    -e "s|/remotes/origin/|/heads/|" refs >actual &&
     +	git for-each-ref refs >expect &&
     +	test_cmp expect actual
    @@ t/t5612-clone-refspec.sh: test_expect_success '--single-branch with detached' '
     +
     +test_expect_success 'with --ref and --no-tags' '
     +	git clone --ref=refs/some/three --no-tags . dir_ref_notags &&
    -+        git -C dir_ref_notags for-each-ref refs > refs &&
    -+        sed -e "/HEAD$/d" \
    ++	git -C dir_ref_notags for-each-ref refs > refs &&
    ++	sed -e "/HEAD$/d" \
     +	    -e "s|/remotes/origin/|/heads/|" refs >actual &&
     +	git for-each-ref refs/heads >expect &&
     +	git for-each-ref refs/some >>expect &&
    @@ t/t5612-clone-refspec.sh: test_expect_success '--single-branch with detached' '
     +
     +test_expect_success '--single-branch with --ref' '
     +	git clone --single-branch --ref=refs/some/three . dir_single_ref &&
    -+        git -C dir_single_ref for-each-ref refs > actual &&
    ++	git -C dir_single_ref for-each-ref refs > actual &&
     +	git for-each-ref refs/some >expect &&
     +	git for-each-ref refs/tags >>expect &&
     +	test_cmp expect actual
    @@ t/t5612-clone-refspec.sh: test_expect_success '--single-branch with detached' '
     +
     +test_expect_success '--single-branch with --ref and --no-tags' '
     +	git clone --single-branch --ref=refs/some/three --no-tags . dir_single_ref_notags &&
    -+        git -C dir_single_ref_notags for-each-ref refs > actual &&
    ++	git -C dir_single_ref_notags for-each-ref refs > actual &&
     +	git for-each-ref refs/some >expect &&
     +	test_cmp expect actual
     +'
--
2.46.0
