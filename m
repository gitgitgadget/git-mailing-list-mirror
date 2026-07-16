Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFA26ED3D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176093; cv=none; b=J1xty0gjbd8BuO2jY3pV9vm7qfSPRlSdjSLK9Qv08EfqqGjaZUbXTYQUtBQm5c0RhIC07RaEhzj+sYfzDvdeITL2Djib1/3rYZvvVP0S2CgYINoEjjXTma6zb9N0RyCuRij9j6H++fxX/Cti3NRAqEPAxL0iiRHUtm2q+b9WagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176093; c=relaxed/simple;
	bh=iEYglrFnwSuD+KsjvriYQX4Uv26j/hpV/s+GISPlLuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwCXb1J2tUUKY3tMM6RgnCwjHtVvqviJuMWHCwLOgO6Z6eOH2+Cx6nJIfgbzWBXuL08Fnm054U5Dj7buuiRQdXw6l0OqED9wNsSlYdOeURBUQsc9sS16TjEkfTV/aPA05DnRJSWjcwYmFAGqd1ooz38cxQb4dbcRgCj5wSb3GSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PJ0saUAo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PJ0saUAo"
Received: (qmail 39557 invoked by uid 106); 16 Jul 2026 04:28:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iEYglrFnwSuD+KsjvriYQX4Uv26j/hpV/s+GISPlLuA=; b=PJ0saUAomh3rNT4CIwf/nzMxQemIRgH56+V4USmEpBVRrV2ReYJh8dmNBYilM6HKselY53XEpKn0K0hasFSZ84r1Q1le6yN19/AhfYJrlIbkU4ocJcWNseTDm4ja7oCyY4HvpRGTTWjmuVAimZH0RPWfXxfzCwCq5uiK/IHuYxcJj21lRp8YsDsRmT4skolapt8FsYMUWV8TrQ4EGa4oTltHxXirqfiTUazoDVNnSMmZiPhRcxVT8OmNVt0c2d8W7xanppmCaLzQHvUpvV+YTCiEdtqq+zuW3q8d2Xg0ClrHJd7cjRpem28Q/VCa5voNXwHIeB0tb/3+RpDG0lh36w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2026 04:28:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 74516 invoked by uid 111); 16 Jul 2026 04:28:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2026 00:28:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jul 2026 00:28:08 -0400
From: Jeff King <peff@peff.net>
To: Gusted <gusted@codeberg.org>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: git-last-modified(1) slower than git-log(1)?
Message-ID: <20260716042808.GA1151612@coredump.intra.peff.net>
References: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>

On Tue, Jul 14, 2026 at 08:33:59PM +0200, Gusted wrote:

> The repository I'm currently using to evaluate the performance is
> https://codeberg.org/ziglang/zig
> 
> Reproduction steps:
> 1. `git clone https://codeberg.org/ziglang/zig $(mktemp -d)`
> 2. cd to tmp directory.
> 3. `git commit-graph write --changed-paths`. As git-last-modified(1)
> makes good use of the bloom filters.
> 4. `hyperfine 'git last-modified -z -t --max-depth=0
> 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- doc/langref/' 'git log
> --name-status -c "--format=commit%x00%H %P%x00" --parents --no-renames
> -t -z 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- ":(literal)doc/langref"'`

Thanks for this concrete reproduction. I can see the same problem here.
Interestingly, if we turn off changed-paths, we get very different
results.

Without a commit graph at all, last-modified wins (this is using the zig
repo and the commands above):

  - log: 150ms
  - last-modified: 79ms

But with a graph and no changed-paths, they're about equal:

  - log: 61ms
  - last-modified: 61ms

And then with changed-paths, the log command gets much faster but
last-modified gets slower!

  - log: 20ms
  - last-modified: 64ms

I think there's a tradeoff in the way that last-modified uses the bloom
filters. It makes a key for every path we're interested in, and then for
each commit, we check each key to say "is this in the commit's filter?".

So if you have a subdirectory with a non-trivial number of entries (like
doc/langref here which has 290), but most commits don't touch that path
at all (only 120 out of ~39k in this case), we'll spend a lot of time
checking each key against each filter. We save ourselves opening the
trees, but at the cost of 290*39k filter comparisons).

Whereas in the git-log case, we make a filter key out of the single
pathspec we're given, and then check each commit against that. So we
only do a single filter check for each commit to narrow it down to those
120 that matter (modulo a few filter false positives).

But I don't see any reason that last-modified couldn't _also_ do that:
pre-filter the commits with a commit matching the original pathspec, and
discard most commits with a single filter check.

The hacky patch below does this, and brings my last-modified runtime
down to 16ms (a 4x improvement, and just a bit faster than git-log).

It tries to reuse the logic from revision.c, so it's doing the exact
same filtering that git-log would do. I think there are other ways to do
it. E.g., we could make our own "root" bloom key that contains all of
the paths and pre-filter with that. But it seemed to be a little slower
when I tried it (~24ms). I'd guess that the problem is that because the
bloom filter is probabilistic, if you shove too many items into a single
key you'll end getting more and more false positives. So putting all 290
entries into one key is too much, and we are better off just considering
the shared prefix.

Anyway, here's the patch. Toon, I'm not planning to take it further
immediately, but you may be interested in poking at it. It probably
needs at least:

  - some light refactoring of revision.c

  - tests? We don't seem to cover last-modified with changed-paths at
    all, and just rely on the test-vars CI job which sets
    GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS. It did pass for me with that
    flag, so surely I didn't introduce any bugs. :)

  - more timing exploration; e.g., might it make things worse if
    doc/langref were touched in 99% of the commits? Probably not, but it
    might be nice to check timings against a few repo shapes and request
    depths.

  - Not all pathspecs can support bloom filters (e.g., "*.c" would not).
    So in theory:

       git last-modified HEAD -- "*.c"

    could work, but wouldn't be optimized. I don't think it _does_ work
    now, because last-modified's max-depth logic complains. So it might
    be a non-issue.

    But I think it is solvable if we really wanted. Rather than
    traversing looking for "*.c", we actually expand the pathspec in the
    tip commit to a set of literal paths, and then as we traverse we
    look for those paths. So we could collect all of "*.c" and then
    add bloom keys for the shared prefixes. I think this does get tricky
    in the general case, though. If you have "a/b/c" and "a/b/d",
    looking for "a/b" is reasonable. But what if you also have "a/e"?
    Should you just have a key for "a/", or both "a/b" and "a/e"?
    There are some tradeoffs between how often uninteresting things in
    "a/" will give us a false positive, versus the cost of checking
    extra keys.

    So maybe an interesting area, but given that in practice most people
    will feed a single pathspec to last-modified, it's a lot easier to
    just use that.

  - I know that last-modified was derived from GitHub's blame-tree
    implementation (which I originally wrote, but stopped paying
    attention to well before it learned about changed-path filters). I
    don't know if the problem was solved separately there, but it would
    be worth checking. +cc Taylor

-Peff

---
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 5478182f2e..c07169258f 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -254,6 +254,29 @@ static void pass_to_parent(struct bitmap *c,
 	bitmap_set(p, pos);
 }
 
+/*
+ * revision.c already has this functionality, but it is not public
+ * and it looks up the filter itself. But probably some refactoring
+ * could make it available at the right level?
+ */
+static bool filter_contains_keyvec(const struct bloom_filter *filter,
+				   struct rev_info *rev)
+{
+	/*
+	 * If we have no keys, we must pessimistically assume a match.
+	 */
+	if (!rev->bloom_keyvecs_nr)
+		return true;
+
+	for (int i = 0; i < rev->bloom_keyvecs_nr; i++) {
+		if (bloom_filter_contains_vec(filter,
+					      rev->bloom_keyvecs[i],
+					      rev->bloom_filter_settings))
+			return true;
+	}
+	return false;
+}
+
 static bool maybe_changed_path(struct last_modified *lm,
 			       struct commit *origin,
 			       struct bitmap *active)
@@ -272,6 +295,9 @@ static bool maybe_changed_path(struct last_modified *lm,
 	if (!filter)
 		return true;
 
+	if (!filter_contains_keyvec(filter, &lm->rev))
+		return false;
+
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
 		if (active && !bitmap_get(active, ent->diff_idx))
 			continue;
@@ -499,7 +525,22 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 		return argc;
 	}
 
-	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
+	/*
+	 * Load the bloom settings, but also convert our pathspec into
+	 * bloom_keyvecs that can be used later. This helper should
+	 * probably be factored out, but we don't want to do it ourselves.
+	 * There is logic about which pathspecs are allowed or not that
+	 * we would not want to duplicate.
+	 */
+	prepare_to_use_bloom_filter(&lm->rev);
+
+	/*
+	 * Even if our initial pathspecs forbid using bloom filters, we'd still
+	 * use them for the literal paths we expand below in
+	 * populate_paths_from_revs().
+	 */
+	if (!lm->rev.bloom_filter_settings)
+		lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
 
 	if (populate_paths_from_revs(lm) < 0)
 		return -1;
diff --git a/revision.c b/revision.c
index 137a86d33b..f5b36ea2cc 100644
--- a/revision.c
+++ b/revision.c
@@ -705,7 +705,7 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
 	return res;
 }
 
-static void prepare_to_use_bloom_filter(struct rev_info *revs)
+void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	if (!revs->commits)
 		return;
diff --git a/revision.h b/revision.h
index 569b3fa1cb..1f761b85d0 100644
--- a/revision.h
+++ b/revision.h
@@ -576,4 +576,6 @@ int rewrite_parents(struct rev_info *revs,
  */
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
+void prepare_to_use_bloom_filter(struct rev_info *revs);
+
 #endif
