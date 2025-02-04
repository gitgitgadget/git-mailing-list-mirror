Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B621B181
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704879; cv=none; b=h1pmEy1YNjhA04i9ZfMsiVycSfeGNF0pJyBQbVUccWru7mnK8ylNr/ZsdbBPVPxhE8ZLpWHtLMAbR3918P6NShtCNXq27rj+gXSynQ/sbzQ3Lj51pWK5Rewbp0j0QScH1KKuMNgLxZvzXoWjC9XNIbjrPjlo0566OeasXdvEWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704879; c=relaxed/simple;
	bh=zUqzWBHo+7R4VAhUDQ7vCML9b9abQe4J6EfolOKN2Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMCKzWi5auPDZeMxefuwuVAkMhhzal04bAJSlIzHMIP8PP2Pj1MuFy7eRYOoArPRGq4bYeb2SjgfDDTSSwVykYwHh6uknZ2Nn2Jw0OmU7QTlIGa+jQjT2pc+Mp+OA0GHA4ahBbF0jiOsoDm9GgckuXzIk22q5/+G3QxUp4YCmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=j++SVZDS; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="j++SVZDS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738704866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nn2XinKXFQcFkSaPYfJk5Xa4oTqeS1YRWyXHc5eLIHo=;
	b=j++SVZDSG1TrKKOzY+q+l5i66A/ohEDk8iYsrmTz/5JYnDAucC5xgSZ+ZwYf+HP/EF6GTp
	8AFom2Y8I+/o9OWetal35TIsN3gfHOFm4yclCoZe+JGyQlc5nKvhbMi7cBMfQgvqOF4Kf4
	RpjnW1G8aYgcqi5IhBvaTFOIMV8AZqQ=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 04 Feb 2025 22:34:01 +0100
Subject: [PATCH v5 2/7] clone: make it possible to specify --tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-toon-clone-refs-v5-2-37e34af283c8@iotcl.com>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
In-Reply-To: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
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
 Documentation/git-clone.txt |  7 ++++---
 builtin/clone.c             | 14 +++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index de8d8f58930ecff305f79480b13ddce10cd96c60..e89ae2e8c664f4d4e15e5f05264c8df988295e3d 100644
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
@@ -273,12 +273,13 @@ corresponding `--mirror` and `--no-tags` options instead.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
-`--no-tags`::
-	Don't clone any tags, and set
+`--[no-]tags`::
+	With `--no-tags`, no tags are cloned, and set
 	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
 	that future `git pull` and `git fetch` operations won't follow
 	any tags. Subsequent explicit tag fetches will still work,
 	(see linkgit:git-fetch[1]).
+	By default tags are cloned, and passing `--tags` doesn't change that.
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

