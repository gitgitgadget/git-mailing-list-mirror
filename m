Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EF224AEA
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823639; cv=none; b=uBypxjUzMNip6I6ef0wkcxkSnDj58qM1tQxEj4DXQ/gcKVUIpR3+BkirkHkv9mcCHGzmMiBS7R3dwOmlGGDRzq9RJ7GGV723ZFz0cwu7zZNERjbNYCjtgAj6uu11/o1UG0JFhC7EZErVB3Q7uqzUzamBlaFjj3ca5jzTYiqaJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823639; c=relaxed/simple;
	bh=DB7Dh1AsEzH2VIao0gHpEm2C/pRrg3sNB+XuScCa4u8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2xSuBDBJ2WVLRVTIQyYnqFzD+mJaJ1MCUl6oKqzmO9ALcwE48N7ES9EoiKDP/5Ti/rYYiEfBhGjpvjcOP4lULp8nHM6We3kQpdfxSgAiT2VNVgIMpCnHwpHxnnZPrws5WBOtWm7Q3MGh1F9UnItRZwyoT7pozQ/TLFEpTbbW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=J+RrBMwF; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="J+RrBMwF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738823635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/8I1F1/B70GdkroRtnDo8OXE6LKQ/lQvrZDOwPt7tc=;
	b=J+RrBMwFMgS+Pz9U1C8ZjzrcVQ6WETMdyzLJhFm95VK0vQSbqX9ziPKWEkrxE1YqvsXmCi
	Rffmm7FfBTDEOceh3Hteb4BKgi+j9Y2Ads3Wc3pYmM/RPCHo9AtX+AtQip32OL3LoKJ3EZ
	4m/ga1kj7JwGRVzkyXIB0YRmc3Q2UmM=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 06 Feb 2025 07:33:30 +0100
Subject: [PATCH v7 2/7] clone: make it possible to specify --tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-toon-clone-refs-v7-2-4622b7392202@iotcl.com>
References: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
In-Reply-To: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Option --no-tags was added in 0dab2468ee (clone: add a --no-tags option
to clone without tags, 2017-04-26). At the time there was no need to
support --tags as well, although there was some conversation about
it[1].

To simplify the code and to prepare for future commits, invert the flag
internally. Functionally there is no change, because the flag is
default-enabled passing `--tags` has no effect, so there's no need to
add tests for this.

[1]: https://lore.kernel.org/git/CAGZ79kbHuMpiavJ90kQLEL_AR0BEyArcZoEWAjPPhOFacN16YQ@mail.gmail.com/

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-clone.txt | 17 ++++++++++-------
 builtin/clone.c             | 14 +++++++-------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index de8d8f58930ecff305f79480b13ddce10cd96c60..8d0476f6dcaf6fed7ccd48a20398556dd4e20722 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -13,7 +13,7 @@ git clone [--template=<template-directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git-dir>]
-	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
+	  [--depth <depth>] [--[no-]single-branch] [--[no-]tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
 	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
@@ -273,12 +273,15 @@ corresponding `--mirror` and `--no-tags` options instead.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
-`--no-tags`::
-	Don't clone any tags, and set
-	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
-	that future `git pull` and `git fetch` operations won't follow
-	any tags. Subsequent explicit tag fetches will still work,
-	(see linkgit:git-fetch[1]).
+`--[no-]tags`::
+	Control whether or not tags will be cloned. When `--no-tags` is
+	given, the option will be become permanent by setting the
+	`remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
+	future `git pull` and `git fetch` won't follow any tags. Subsequent
+	explicit tag fetches will still work (see linkgit:git-fetch[1]).
+
+	By default, tags are cloned and passing `--tags` is thus typically a
+	no-op, unless it cancels out a previous `--no-tags`.
 +
 Can be used in conjunction with `--single-branch` to clone and
 maintain a branch with no references other than a single cloned
diff --git a/builtin/clone.c b/builtin/clone.c
index 5ed0802f1d0ddebaf512aac93bf8c8b340494323..69d1ad029dfa84a2f7136fa4a3c4c8a594b179c4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -59,7 +59,7 @@
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared;
-static int option_no_tags;
+static int option_tags = 1; /* default enabled */
 static int option_shallow_submodules;
 static int config_reject_shallow = -1;    /* unspecified */
 static char *remote_name = NULL;
@@ -470,7 +470,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			get_fetch_map(refs, &refspec->items[i], &tail, 0);
 	}
 
-	if (!option_mirror && !option_single_branch && !option_no_tags)
+	if (!option_mirror && !option_single_branch && option_tags)
 		get_fetch_map(refs, &tag_refspec, &tail, 0);
 
 	refspec_item_clear(&tag_refspec);
@@ -562,7 +562,7 @@ static void update_remote_refs(const struct ref *refs,
 
 	if (refs) {
 		write_remote_refs(mapped_refs);
-		if (option_single_branch && !option_no_tags)
+		if (option_single_branch && option_tags)
 			write_followtags(refs, msg);
 	}
 
@@ -964,8 +964,8 @@ int cmd_clone(int argc,
 				N_("deepen history of shallow clone, excluding ref")),
 		OPT_BOOL(0, "single-branch", &option_single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
-		OPT_BOOL(0, "no-tags", &option_no_tags,
-			 N_("don't clone any tags, and make later fetches not to follow them")),
+		OPT_BOOL(0, "tags", &option_tags,
+			 N_("clone tags, and make later fetches not to follow them")),
 		OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
 			 N_("any cloned submodules will be shallow")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
@@ -1296,7 +1296,7 @@ int cmd_clone(int argc,
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_no_tags) {
+	if (!option_tags) {
 		strbuf_addf(&key, "remote.%s.tagOpt", remote_name);
 		git_config_set(key.buf, "--no-tags");
 		strbuf_reset(&key);
@@ -1389,7 +1389,7 @@ int cmd_clone(int argc,
 	if (option_branch)
 		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
 				  option_branch);
-	if (!option_no_tags)
+	if (option_tags)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
 

-- 
2.48.1.447.gc0086e9015

