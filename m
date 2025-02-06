Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46067148FF5
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823636; cv=none; b=kCbVr4+WYDWOS5czyGIzbFbeqBfpXiDw3wkhu8wVQm5WLMqYF7LKOWPqPsFjUygC6cDLsr6wjIxaqNkyXl7LQUL+Fsja+4iXWp9FZk6+vcG88jJeSUqlEeHYWWeKYm2bfiToLUSvo0Lf2l3yd4ryaBh62VR9MrmKGFpD2d6fpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823636; c=relaxed/simple;
	bh=tUnRtj8/LDYFMykWUhbQGewNnZEcJHZ1ERsxlpMkCUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CwLbZSzOCfhpHKky9r6PezGYanXFR+pkYArsAwhrA9QFchCCGVxWeeDP7Bl3uVQdVUpK5xUt2rUtboB/XXyFj14nYR/3Z6HLOPszRikE3UEUPM2Q/N4Cc37LV3/k9jWOyjtq6Kmq7aLNC0YxA1NxShhmVjHRG+9stymghtl7IbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=rNUp5sIF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="rNUp5sIF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738823629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAcsC8dqdAPyNFqywfsdUkFSTvPozPyX/NhH/fdUWeM=;
	b=rNUp5sIFNhUS9MfsYZg3PK6QzBysfZhn6MjDcga8eCBWj6kDAzTWsr3oCrgi0vhIeRm6vK
	7m9JOr/stVRWwbq1/FLKulkncCmgJhxYkIQEDd4SlJN6E/R53Lg6OU3/Xs3KrpTpGnBJO4
	hD9bGSWPgeUNZqbON0QOD4OMXR9nTDg=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 06 Feb 2025 07:33:29 +0100
Subject: [PATCH v7 1/7] clone: cut down on global variables in clone.c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-toon-clone-refs-v7-1-4622b7392202@iotcl.com>
References: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
In-Reply-To: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In clone.c the `struct option` which is used to parse the input options
for git-clone(1) is a global variable. Due to this, many variables that
are used to parse the value into, are also global.

Make `builtin_clone_options` a local variable in cmd_clone() and carry
along all variables that are only used in that function.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c | 195 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 101 insertions(+), 94 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fd001d800c635e46bbc7027a8fdda2a8c9fbf069..5ed0802f1d0ddebaf512aac93bf8c8b340494323 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -56,42 +56,22 @@
  *  - dropping use-separate-remote and no-separate-remote compatibility
  *
  */
-static const char * const builtin_clone_usage[] = {
-	N_("git clone [<options>] [--] <repo> [<dir>]"),
-	NULL
-};
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
-static int option_reject_shallow = -1;    /* unspecified */
 static int config_reject_shallow = -1;    /* unspecified */
-static int deepen;
-static char *option_template, *option_depth, *option_since;
-static char *option_origin = NULL;
 static char *remote_name = NULL;
 static char *option_branch = NULL;
-static struct string_list option_not = STRING_LIST_INIT_NODUP;
-static const char *real_git_dir;
-static const char *ref_format;
-static const char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
-static int option_progress = -1;
-static int option_sparse_checkout;
-static enum transport_family family;
-static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
-static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
-static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
-static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
-static const char *bundle_uri;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -107,78 +87,6 @@ static int recurse_submodules_cb(const struct option *opt,
 	return 0;
 }
 
-static struct option builtin_clone_options[] = {
-	OPT__VERBOSITY(&option_verbosity),
-	OPT_BOOL(0, "progress", &option_progress,
-		 N_("force progress reporting")),
-	OPT_BOOL(0, "reject-shallow", &option_reject_shallow,
-		 N_("don't clone shallow repository")),
-	OPT_BOOL('n', "no-checkout", &option_no_checkout,
-		 N_("don't create a checkout")),
-	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
-	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
-			N_("create a bare repository")),
-	OPT_BOOL(0, "mirror", &option_mirror,
-		 N_("create a mirror repository (implies --bare)")),
-	OPT_BOOL('l', "local", &option_local,
-		N_("to clone from a local repository")),
-	OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
-		    N_("don't use local hardlinks, always copy")),
-	OPT_BOOL('s', "shared", &option_shared,
-		    N_("setup as shared repository")),
-	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
-	  N_("pathspec"), N_("initialize submodules in the clone"),
-	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
-	OPT_ALIAS(0, "recursive", "recurse-submodules"),
-	OPT_INTEGER('j', "jobs", &max_jobs,
-		    N_("number of submodules cloned in parallel")),
-	OPT_STRING(0, "template", &option_template, N_("template-directory"),
-		   N_("directory from which templates will be used")),
-	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
-			N_("reference repository")),
-	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
-			N_("repo"), N_("reference repository")),
-	OPT_BOOL(0, "dissociate", &option_dissociate,
-		 N_("use --reference only while cloning")),
-	OPT_STRING('o', "origin", &option_origin, N_("name"),
-		   N_("use <name> instead of 'origin' to track upstream")),
-	OPT_STRING('b', "branch", &option_branch, N_("branch"),
-		   N_("checkout <branch> instead of the remote's HEAD")),
-	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
-		   N_("path to git-upload-pack on the remote")),
-	OPT_STRING(0, "depth", &option_depth, N_("depth"),
-		    N_("create a shallow clone of that depth")),
-	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
-		    N_("create a shallow clone since a specific time")),
-	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("ref"),
-			N_("deepen history of shallow clone, excluding ref")),
-	OPT_BOOL(0, "single-branch", &option_single_branch,
-		    N_("clone only one branch, HEAD or --branch")),
-	OPT_BOOL(0, "no-tags", &option_no_tags,
-		 N_("don't clone any tags, and make later fetches not to follow them")),
-	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
-		    N_("any cloned submodules will be shallow")),
-	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
-		   N_("separate git dir from working tree")),
-	OPT_STRING(0, "ref-format", &ref_format, N_("format"),
-		   N_("specify the reference format to use")),
-	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
-			N_("set config inside the new repository")),
-	OPT_STRING_LIST(0, "server-option", &server_options,
-			N_("server-specific"), N_("option to transmit")),
-	OPT_IPVERSION(&family),
-	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
-	OPT_BOOL(0, "also-filter-submodules", &option_filter_submodules,
-		    N_("apply partial clone filters to submodules")),
-	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
-		    N_("any cloned submodules will use their remote-tracking branch")),
-	OPT_BOOL(0, "sparse", &option_sparse_checkout,
-		    N_("initialize sparse-checkout file to include only files at root")),
-	OPT_STRING(0, "bundle-uri", &bundle_uri,
-		   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
-	OPT_END()
-};
-
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static const char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -989,10 +897,103 @@ int cmd_clone(int argc,
 	int hash_algo;
 	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
 	const int do_not_override_repo_unix_permissions = -1;
+	int option_reject_shallow = -1; /* unspecified */
+	int deepen = 0;
+	char *option_template = NULL, *option_depth = NULL, *option_since = NULL;
+	char *option_origin = NULL;
+	struct string_list option_not = STRING_LIST_INIT_NODUP;
+	const char *real_git_dir = NULL;
+	const char *ref_format = NULL;
+	const char *option_upload_pack = "git-upload-pack";
+	int option_progress = -1;
+	int option_sparse_checkout = 0;
+	enum transport_family family = TRANSPORT_FAMILY_ALL;
+	struct string_list option_config = STRING_LIST_INIT_DUP;
+	int option_dissociate = 0;
+	int option_filter_submodules = -1; /* unspecified */
+	struct string_list server_options = STRING_LIST_INIT_NODUP;
+	const char *bundle_uri = NULL;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 
+	struct option builtin_clone_options[] = {
+		OPT__VERBOSITY(&option_verbosity),
+		OPT_BOOL(0, "progress", &option_progress,
+			 N_("force progress reporting")),
+		OPT_BOOL(0, "reject-shallow", &option_reject_shallow,
+			 N_("don't clone shallow repository")),
+		OPT_BOOL('n', "no-checkout", &option_no_checkout,
+			 N_("don't create a checkout")),
+		OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
+		OPT_HIDDEN_BOOL(0, "naked", &option_bare,
+				N_("create a bare repository")),
+		OPT_BOOL(0, "mirror", &option_mirror,
+			 N_("create a mirror repository (implies --bare)")),
+		OPT_BOOL('l', "local", &option_local,
+			 N_("to clone from a local repository")),
+		OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
+			 N_("don't use local hardlinks, always copy")),
+		OPT_BOOL('s', "shared", &option_shared,
+			 N_("setup as shared repository")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
+		  N_("pathspec"), N_("initialize submodules in the clone"),
+		  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
+		OPT_ALIAS(0, "recursive", "recurse-submodules"),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("number of submodules cloned in parallel")),
+		OPT_STRING(0, "template", &option_template, N_("template-directory"),
+			   N_("directory from which templates will be used")),
+		OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
+				N_("reference repository")),
+		OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
+				N_("repo"), N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &option_dissociate,
+			 N_("use --reference only while cloning")),
+		OPT_STRING('o', "origin", &option_origin, N_("name"),
+			   N_("use <name> instead of 'origin' to track upstream")),
+		OPT_STRING('b', "branch", &option_branch, N_("branch"),
+			   N_("checkout <branch> instead of the remote's HEAD")),
+		OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
+			   N_("path to git-upload-pack on the remote")),
+		OPT_STRING(0, "depth", &option_depth, N_("depth"),
+			   N_("create a shallow clone of that depth")),
+		OPT_STRING(0, "shallow-since", &option_since, N_("time"),
+			   N_("create a shallow clone since a specific time")),
+		OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("ref"),
+				N_("deepen history of shallow clone, excluding ref")),
+		OPT_BOOL(0, "single-branch", &option_single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
+		OPT_BOOL(0, "no-tags", &option_no_tags,
+			 N_("don't clone any tags, and make later fetches not to follow them")),
+		OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
+			 N_("any cloned submodules will be shallow")),
+		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
+			   N_("separate git dir from working tree")),
+		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
+			   N_("specify the reference format to use")),
+		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
+				N_("set config inside the new repository")),
+		OPT_STRING_LIST(0, "server-option", &server_options,
+				N_("server-specific"), N_("option to transmit")),
+		OPT_IPVERSION(&family),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+		OPT_BOOL(0, "also-filter-submodules", &option_filter_submodules,
+			 N_("apply partial clone filters to submodules")),
+		OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
+			 N_("any cloned submodules will use their remote-tracking branch")),
+		OPT_BOOL(0, "sparse", &option_sparse_checkout,
+			 N_("initialize sparse-checkout file to include only files at root")),
+		OPT_STRING(0, "bundle-uri", &bundle_uri,
+			   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
+		OPT_END()
+	};
+
+	const char * const builtin_clone_usage[] = {
+		N_("git clone [<options>] [--] <repo> [<dir>]"),
+		NULL
+	};
+
 	packet_trace_identity("clone");
 
 	git_config(git_clone_config, NULL);
@@ -1138,8 +1139,8 @@ int cmd_clone(int argc,
 		for_each_string_list_item(item, &option_recurse_submodules) {
 			strbuf_addf(&sb, "submodule.active=%s",
 				    item->string);
-			string_list_append(&option_config,
-					   strbuf_detach(&sb, NULL));
+			string_list_append(&option_config, sb.buf);
+			strbuf_reset(&sb);
 		}
 
 		if (!git_config_get_bool("submodule.stickyRecursiveClone", &val) &&
@@ -1161,6 +1162,8 @@ int cmd_clone(int argc,
 			string_list_append(&option_config,
 				"submodule.alternateErrorStrategy=info");
 		}
+
+		strbuf_release(&sb);
 	}
 
 	/*
@@ -1578,6 +1581,10 @@ int cmd_clone(int argc,
 	err = checkout(submodule_progress, filter_submodules,
 		       ref_storage_format);
 
+	string_list_clear(&option_not, 0);
+	string_list_clear(&option_config, 0);
+	string_list_clear(&server_options, 0);
+
 	free(remote_name);
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);

-- 
2.48.1.447.gc0086e9015

