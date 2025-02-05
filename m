Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D21FC7CC
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774064; cv=none; b=pq2UpAnhNcPQgmGe4HVlQ7eJZenl6yNSk179MvxNt8PYjCABTcqLxdD62WzsBkU/S8qFWssoaoM8R0mw0hmvBHcud8+/2k3UvGuCZvqWGootvphJuHzybUXP9KrR32cnZgIOzwYjkbqHq9R7N1L+HhVBlICM8dgt1wweFLP/4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774064; c=relaxed/simple;
	bh=DB7Dh1AsEzH2VIao0gHpEm2C/pRrg3sNB+XuScCa4u8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GiIBaqRynTv4JJsPTMfT2Vx3Fb7OBEQ4mrLfprWiSSTd3G4ffVjIvFyFFQZcvGUFLZCNxcJCGGwmfj777lCaDQpRPK/RP796n2y81Ke7hFEWOoCTtrgkWa9K9ubZLXEaT31oFP/O/4msnxPmQ+Q5MqZzv9TwFuDxOvlw5iZyudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Q0+l50CZ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Q0+l50CZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738774059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/8I1F1/B70GdkroRtnDo8OXE6LKQ/lQvrZDOwPt7tc=;
	b=Q0+l50CZAGkTfDb2K1J6Tk3YuSKvwnxcxagn591G9tqeRN2063fh1eyIReCqO4EWKCCAEh
	hM4tpC/ApJw6Zy0wMSQWDvmCQfCQcMKCiR8y84n5X3UNaZ9fQrd3No0DHoxcEBfS7IvIU6
	mzGlaFa0gOh0fGdl+upEa53xIkwYIDk=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 05 Feb 2025 17:47:17 +0100
Subject: [PATCH v6 2/7] clone: make it possible to specify --tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-toon-clone-refs-v6-2-0bbc8e6d89fd@iotcl.com>
References: <20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com>
In-Reply-To: <20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com>
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

