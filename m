Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A941F8733
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720625; cv=none; b=hsKbtnR3kXHJc+bFXMDo6SEv0H/4QRPZFDdffRk/Rs+jOXDsn9aL3iNQ/h11Z+7Og8nHCQ9rfVgUL4xObunQ3JOAqfHpZcAnhDoLPF0k3Uh7N8YQBHmM2bRNtlzgRJ0+Cu7pYsDn/94ZTpduw1QhkqpiDZOm7sqSbRv8YJY1sRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720625; c=relaxed/simple;
	bh=vl8F7XGWqc9oMcSfDTwG2BKkARt+ASrOyz3JOKcXTHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4wZaCHCXV6MIulnFsQXBXqopFrYlt/y97RisBSzJ1uNkH6dFBIrwfcwLQACjrz/Ak0Z0fRc3haxhR2Dd6rgkodGwu4JJCzmSaZmvBmRCfDJjkVgZ+Qr94ZwzA0WgJWJ69AKGZx9n6b72iwPru7jQnFirifyUt4slKSE+UlGC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9mjtgLU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9mjtgLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720624; x=1782256624;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vl8F7XGWqc9oMcSfDTwG2BKkARt+ASrOyz3JOKcXTHs=;
  b=e9mjtgLUsTNcrh/REAgMdjGu0+xPp8y1chGubkmZBy0TzMBU8kawefRL
   19J+slgx8gmAQWgssbHeefeyJ3XTj0lZcZFH4jAT5Rcjj8TDTunbsAKaK
   VGxA3C+wbqusKbo/o7NYoN3MfuMHTyMAQ1nZdwYpVQu/fvONioDCALq3G
   sw44jay9x3v+DgvuKR6fmrIDPHfhZZWPDaxWfTJgfXikM0ItdD0U1yGzH
   bQumUHgXjq5mTZ0HtTwjgeo7u/Qj7pwomkgZceKkEh7LME7bEuosC60tv
   Teo8HW9Rs4wXqDVprOP3duyHwsEeHi3gjaSkQ1V4JlNoJnkNCkMTHgxej
   g==;
X-CSE-ConnectionGUID: L9Y4XtChQVua8Vfr72eHZw==
X-CSE-MsgGUID: LSnQkZVzQ3ay9FIFe0EQnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53084553"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53084553"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:42 -0700
X-CSE-ConnectionGUID: c/kaFntZSFa61BclpO6m6Q==
X-CSE-MsgGUID: CmibJIjYQ0mSWbT2+s+p/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151888463"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:41 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 16:11:29 -0700
Subject: [PATCH v4 1/7] remote: remove branch->merge_name and fix
 branch_release()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-jk-submodule-helper-use-url-v4-1-133ef3d89569@gmail.com>
References: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
In-Reply-To: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

The branch structure has both branch->merge_name and branch->merge for
tracking the merge information. The former is allocated by add_merge()
and stores the names read from the configuration file. The latter is
allocated by set_merge() which is called by branch_get() when an
external caller requests a branch.

This leads to the confusing situation where branch->merge_nr tracks both
the size of branch->merge (once its allocated) and branch->merge_name.
The branch_release() function incorrectly assumes that branch->merge is
always set when branch->merge_nr is non-zero, and can potentially crash
if read_config() is called without branch_get() being called on every
branch.

In addition, branch_release() fails to free some of the memory
associated with the structure including:

 * Failure to free the refspec_item containers in branch->merge[i]
 * Failure to free the strings in branch->merge_name[i]
 * Failure to free the branch->merge_name parent array.

The set_merge() function sets branch->merge_nr to 0 when there is no
valid remote_name, to avoid external callers seeing a non-zero merge_nr
but a NULL merge array. This results in failure to release most of the
merge data as well.

These issues could be fixed directly, and indeed I initially proposed
such a change at [1] in the past. While this works, there was some
confusion during review because of the inconsistencies.

Instead, its time to clean up the situation properly. Remove
branch->merge_name entirely. Instead, allocate branch->merge earlier
within add_merge() instead of within set_merge(). Instead of having
set_merge() copy from merge_name[i] to merge[i]->src, just have
add_merge() directly initialize merge[i]->src.

Modify the add_merge() to call xstrdup() itself, instead of having
the caller of add_merge() do so. This makes it more obvious which code
owns the memory.

Update all callers which use branch->merge_name[i] to use
branch->merge[i]->src instead.

Add a merge_clear() function which properly releases all of the
merge-related memory, and which sets branch->merge_nr to zero. Use this
both in branch_release() and in set_merge(), fixing the leak when
set_merge() finds no valid remote_name.

Add a set_merge variable to the branch structure, which indicates
whether set_merge() has been called. This replaces the previous use of a
NULL check against the branch->merge array.

With these changes, the merge array is always allocated when merge_nr is
non-zero.

This use of refspec_item to store the names should be safe. External
callers should be using branch_get() to obtain a pointer to the branch,
which will call set_merge(), and the callers internal to remote.c
already handle the partially initialized refpsec_item structure safely.

This end result is cleaner, and avoids duplicating the merge names
twice.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Link: [1] https://lore.kernel.org/git/20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com/
---
 remote.h       |  4 ++--
 branch.c       |  4 ++--
 builtin/pull.c |  2 +-
 remote.c       | 44 ++++++++++++++++++++++++++++----------------
 4 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/remote.h b/remote.h
index 7e4943ae3a70ecefa3332d211084762ca30b59b6..76d93bf88d1fb8c0e2cbc2bc99558f23a256155c 100644
--- a/remote.h
+++ b/remote.h
@@ -315,8 +315,8 @@ struct branch {
 
 	char *pushremote_name;
 
-	/* An array of the "merge" lines in the configuration. */
-	const char **merge_name;
+	/* True if set_merge() has been called to finalize the merge array */
+	int set_merge;
 
 	/**
 	 * An array of the struct refspecs used for the merge lines. That is,
diff --git a/branch.c b/branch.c
index 6d01d7d6bdb2e4d969429433b1b6bc88446a96c5..93f5b4e8dd9fe53ae4412827c458bade7c341278 100644
--- a/branch.c
+++ b/branch.c
@@ -230,7 +230,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 		return -1;
 	}
 
-	if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_name[0]) {
+	if (branch->merge_nr < 1 || !branch->merge || !branch->merge[0] || !branch->merge[0]->src) {
 		warning(_("asked to inherit tracking from '%s', but no merge configuration is set"),
 			bare_ref);
 		return -1;
@@ -238,7 +238,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 
 	tracking->remote = branch->remote_name;
 	for (i = 0; i < branch->merge_nr; i++)
-		string_list_append(tracking->srcs, branch->merge_name[i]);
+		string_list_append(tracking->srcs, branch->merge[i]->src);
 	return 0;
 }
 
diff --git a/builtin/pull.c b/builtin/pull.c
index a1ebc6ad3328e074b105246f6bf5c41b063c17c9..f4556ae155ce22ea91f9878d772eb9228fe4e604 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -487,7 +487,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	} else
 		fprintf_ln(stderr, _("Your configuration specifies to merge with the ref '%s'\n"
 			"from the remote, but no such ref was fetched."),
-			*curr_branch->merge_name);
+			curr_branch->merge[0]->src);
 	exit(1);
 }
 
diff --git a/remote.c b/remote.c
index 4099183cacdc8a607a8b5eaec86e456b2ef46b48..ee95126f3f20080a932b82314e8017e277569cc1 100644
--- a/remote.c
+++ b/remote.c
@@ -174,9 +174,15 @@ static void remote_clear(struct remote *remote)
 
 static void add_merge(struct branch *branch, const char *name)
 {
-	ALLOC_GROW(branch->merge_name, branch->merge_nr + 1,
+	struct refspec_item *merge;
+
+	ALLOC_GROW(branch->merge, branch->merge_nr + 1,
 		   branch->merge_alloc);
-	branch->merge_name[branch->merge_nr++] = name;
+
+	merge = xcalloc(1, sizeof(*merge));
+	merge->src = xstrdup(name);
+
+	branch->merge[branch->merge_nr++] = merge;
 }
 
 struct branches_hash_key {
@@ -247,15 +253,23 @@ static struct branch *make_branch(struct remote_state *remote_state,
 	return ret;
 }
 
+static void merge_clear(struct branch *branch)
+{
+	for (int i = 0; i < branch->merge_nr; i++) {
+		refspec_item_clear(branch->merge[i]);
+		free(branch->merge[i]);
+	}
+	FREE_AND_NULL(branch->merge);
+	branch->merge_nr = 0;
+}
+
 static void branch_release(struct branch *branch)
 {
 	free((char *)branch->name);
 	free((char *)branch->refname);
 	free(branch->remote_name);
 	free(branch->pushremote_name);
-	for (int i = 0; i < branch->merge_nr; i++)
-		refspec_item_clear(branch->merge[i]);
-	free(branch->merge);
+	merge_clear(branch);
 }
 
 static struct rewrite *make_rewrite(struct rewrites *r,
@@ -429,7 +443,7 @@ static int handle_config(const char *key, const char *value,
 		} else if (!strcmp(subkey, "merge")) {
 			if (!value)
 				return config_error_nonbool(key);
-			add_merge(branch, xstrdup(value));
+			add_merge(branch, value);
 		}
 		return 0;
 	}
@@ -692,7 +706,7 @@ char *remote_ref_for_branch(struct branch *branch, int for_push)
 	if (branch) {
 		if (!for_push) {
 			if (branch->merge_nr) {
-				return xstrdup(branch->merge_name[0]);
+				return xstrdup(branch->merge[0]->src);
 			}
 		} else {
 			char *dst;
@@ -1731,32 +1745,30 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 
 	if (!ret)
 		return; /* no branch */
-	if (ret->merge)
+	if (ret->set_merge)
 		return; /* already run */
 	if (!ret->remote_name || !ret->merge_nr) {
 		/*
 		 * no merge config; let's make sure we don't confuse callers
 		 * with a non-zero merge_nr but a NULL merge
 		 */
-		ret->merge_nr = 0;
+		merge_clear(ret);
 		return;
 	}
+	ret->set_merge = 1;
 
 	remote = remotes_remote_get(remote_state, ret->remote_name);
 
-	CALLOC_ARRAY(ret->merge, ret->merge_nr);
 	for (i = 0; i < ret->merge_nr; i++) {
-		ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
-		ret->merge[i]->src = xstrdup(ret->merge_name[i]);
 		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
-		if (repo_dwim_ref(the_repository, ret->merge_name[i],
-				  strlen(ret->merge_name[i]), &oid, &ref,
+		if (repo_dwim_ref(the_repository, ret->merge[i]->src,
+				  strlen(ret->merge[i]->src), &oid, &ref,
 				  0) == 1)
 			ret->merge[i]->dst = ref;
 		else
-			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
+			ret->merge[i]->dst = xstrdup(ret->merge[i]->src);
 	}
 }
 
@@ -1776,7 +1788,7 @@ struct branch *branch_get(const char *name)
 
 int branch_has_merge_config(struct branch *branch)
 {
-	return branch && !!branch->merge;
+	return branch && branch->set_merge;
 }
 
 int branch_merge_matches(struct branch *branch,

-- 
2.48.1.397.gec9d649cc640

