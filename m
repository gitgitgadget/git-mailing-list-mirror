Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C013CFAD
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750629; cv=none; b=u9Va9XQgWkmJzq35zCJZ9E14HDq/2AG4VRICI2bpItZAXfsKIcGaCtZMCvVWa4591crR+EQpQxYkqyqJk8qZhixo6nJb4lJtDypqJRGvhikfbjhhrjuRrjsA8tY3pcByY/9l+jyYDloq+TMC4svlPIwNOdiXoEzWpJ9LljeNOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750629; c=relaxed/simple;
	bh=131wflMGKlY03DacQbmiqqKB9cPhf7gPPK6vHPh/n/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D1U0SjUsxcUmfdhwl0SfBmCz5IMBVnNlA1K65M/sUjmVKBVl7oNZ2A3X+poSv1monjwPNKOUL+lAlcQYzdK1NAF3lVEeQ32iXqhmAHFWMixfdvdAfsEtMdZgYPhC0KpPPRn4dSaGChn4In3K81pFwMeje48ISzY3nWVoiaaaF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v2MCaSER; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v2MCaSER"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 292CE31D4B;
	Fri, 29 Mar 2024 18:17:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=131wflMGKlY03DacQbmiqqKB9cPhf7gPPK6vHP
	h/n/Y=; b=v2MCaSERNLcpszx+uWVoePp2XIcNhhSLiRavSvZvmnxGmxB1dCMiFN
	V2qCxSNiobPDzbjfwovwPFV+MGfo3bubwwXu2tQZzZqyg4mhz7gWGJBBQ3Ps+ItW
	KNeITfRDxToKu/EMtcFAkzeFiuB9rJ7sIXTxSZye9Zj6pHCznH0jI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 117B131D4A;
	Fri, 29 Mar 2024 18:17:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C9EF31D48;
	Fri, 29 Mar 2024 18:16:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] read-cache: optionally collect pathspec matching
 info
In-Reply-To: <xmqqjzlkwwk9.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	29 Mar 2024 14:35:34 -0700")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240329205649.1483032-3-shyamthakkar001@gmail.com>
	<xmqqjzlkwwk9.fsf@gitster.g>
Date: Fri, 29 Mar 2024 15:16:55 -0700
Message-ID: <xmqqo7awvg2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E7B963C-EE1A-11EE-BABF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> A new parameter to run_diff_files() came as a bit of surprise to me.
>
> When I responded to the previous round, I somehow thought that we'd
> add a new member to the rev structure that points at an optional
> .ps_matched member next to the existing .prune_data member.  
>
> That way, it would hopefully be easy for a future code to see if a
> "diff" invocation, not necessarily run_diff_files() that compares
> the working tree and the index, consumed all the pathspec elements.
> If such a new .ps_matched member is initialized to NULL, all the
> patch noise we see in this patch will become unnecessary, no?

This is how such a change may look like.  After applying [2/3] and
[3/3] steps from your series on top of this patch, the updated tests
in your series (2200 and 7501) seem to still pass.

------- >8 ------------- >8 ------------- >8 ------------- >8 -------

Subject: [PATCH] revision: optionally record matches with pathspec elements

Unlike "git add" and other end-user facing command, where it is
diagnosed as an error to give a pathspec with an element that does
not match any path, the diff machinery does not care if some
elements of the pathspec does not match.  Given that the diff
machinery is heavily used in pathspec-limited "git log" machinery,
and it is common for a path to come and go while traversing the
project history, this is usually a good thing.

However, in some cases we would want to know if all the pathspec
elements matched.  For example, "git add -u <pathspec>" internally
uses the machinery used by "git diff-files" to decide contents from
what paths to add to the index, and as an end-user facing command,
"git add -u" would want to report an unmatched pathspec element.

Add a new .ps_matched member next to the .prune_data member in
"struct rev_info" so that we can optionally keep track of the use of
.prune_data pathspec elements that can be inspected by the caller.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c      |  4 ++--
 builtin/checkout.c |  3 ++-
 builtin/commit.c   |  2 +-
 diff-lib.c         | 11 ++++++++++-
 read-cache-ll.h    |  4 ++--
 read-cache.c       |  8 +++++---
 revision.h         |  1 +
 7 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 393c10cbcf..dc4b42d0ad 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -553,8 +553,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
 	else
 		exit_status |= add_files_to_cache(the_repository, prefix,
-						  &pathspec, include_sparse,
-						  flags);
+						  &pathspec, NULL,
+						  include_sparse, flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e8b0d18f4..56d1828856 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -878,7 +878,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(the_repository, NULL, NULL, 0, 0);
+			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
+					   0);
 			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/commit.c b/builtin/commit.c
index b27b56c8be..8f31decc6b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -444,7 +444,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, 0, 0);
+				   &pathspec, NULL, 0, 0);
 		refresh_cache_or_die(refresh_flags);
 		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
diff --git a/diff-lib.c b/diff-lib.c
index 1cd790a4d2..683f11e509 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -127,7 +127,16 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
 
-		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
+		/*
+		 * NEEDSWORK:
+		 * Here we filter with pathspec but the result is further
+		 * filtered out when --relative is in effect.  To end-users,
+		 * a pathspec element that matched only to paths outside the
+		 * current directory is like not matching anything at all;
+		 * the handling of ps_matched[] here may become problematic
+		 * if/when we add the "--error-unmatch" option to "git diff".
+		 */
+		if (!ce_path_match(istate, ce, &revs->prune_data, revs->ps_matched))
 			continue;
 
 		if (revs->diffopt.prefix &&
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2a50a784f0..09414afd04 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -480,8 +480,8 @@ extern int verify_ce_order;
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
-		       const struct pathspec *pathspec, int include_sparse,
-		       int flags);
+		       const struct pathspec *pathspec, char *ps_matched,
+		       int include_sparse, int flags);
 
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/read-cache.c b/read-cache.c
index f546cf7875..e1723ad796 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3958,8 +3958,8 @@ static void update_callback(struct diff_queue_struct *q,
 }
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
-		       const struct pathspec *pathspec, int include_sparse,
-		       int flags)
+		       const struct pathspec *pathspec, char *ps_matched,
+		       int include_sparse, int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -3971,8 +3971,10 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 
 	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-	if (pathspec)
+	if (pathspec) {
 		copy_pathspec(&rev.prune_data, pathspec);
+		rev.ps_matched = ps_matched;
+	}
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
diff --git a/revision.h b/revision.h
index 94c43138bc..0e470d1df1 100644
--- a/revision.h
+++ b/revision.h
@@ -142,6 +142,7 @@ struct rev_info {
 	/* Basic information */
 	const char *prefix;
 	const char *def;
+	char *ps_matched; /* optionally record matches of prune_data */
 	struct pathspec prune_data;
 
 	/*
-- 
2.44.0-413-gd6fd04375f

