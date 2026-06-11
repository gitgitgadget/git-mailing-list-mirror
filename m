Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4C1A3029
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162985; cv=none; b=AEplI5GxymRo2Sx478lkegWO1Jxd7OxaeSzF09DQOdjm1D8uDgDgP2RIbpmtghLrp4s1FaeIaC60Fz/46zQDX+e6Ni5I9rekN0v/VANoL3gvDjuYrxtBQZxsasXMQ+0H4P+RSc9dqRRsQlxhItcXHf56lYCHwd84Wu7TQFnOD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162985; c=relaxed/simple;
	bh=9/1DmfcXYibWYVjoIYVlMM/FqSNk9+PP0Bm0mPqHFVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK+KMuKCx8KOm+0MzKYSEyiHwF76BMEu2Yw78hobJ6XZLIurB+KELUCJ0oQVow1Xsljr0oCv/tpjCKBWX61bEP2IXwwTbXGWyE1Lgr+cg9agjQkjfviNRgHBEulpBcJBi4w420dpmMe116DKM+IsSebRwYN46dmWP7SuznEQKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UQkR6VvK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UQkR6VvK"
Received: (qmail 106486 invoked by uid 106); 11 Jun 2026 07:29:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9/1DmfcXYibWYVjoIYVlMM/FqSNk9+PP0Bm0mPqHFVY=; b=UQkR6VvKErjC1z2Jm8YVnlBSmk03hJRDb6mGQJmLuBvLOi/omzbepY/CFAa0eCe0NdSydkILcpcpbVhjp+L7KLrzC5uVvrqcqbo/1XJ+1LnnzELtIZh3IoJfMCIFAQG0NyX1gAjyxMbsRq9oww+yTf7C4j8M5WtUo/ZoMLILujUyluwTWztvvrJbbadL997BfhYGj+m+q6OKgDh4ic2o4B7EIryl57LXALSY/Mg3WExBscFnGecjiDvfHD5bDCX/C2uMB+mLeKoe5QvTEQ3sV90ZuURiR8DcOo3VokQZQfbDIANI0v4coHwB+PYAk24CRGKevZS0Z85pfSlKn0SqvA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 07:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 314520 invoked by uid 111); 11 Jun 2026 07:29:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 03:29:47 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 03:29:42 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] commit-reach: handle cycles in contains walk
Message-ID: <20260611072942.GG2191159@coredump.intra.peff.net>
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
 <20260608-ref-filter-memoized-contains-v2-1-e72720344a7c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608-ref-filter-memoized-contains-v2-1-e72720344a7c@gmail.com>

On Mon, Jun 08, 2026 at 07:36:34PM -0700, Tamir Duberstein wrote:

> @@ -744,7 +745,7 @@ static void push_to_contains_stack(struct commit *candidate, struct contains_sta
>  }
>  
>  static enum contains_result contains_tag_algo(struct commit *candidate,
> -					      const struct commit_list *want,
> +					      struct commit_list *want,
>  					      struct contains_cache *cache)

OK, we must lose the const here because repo_is_descendant_of() does not
have it. We could add const to that function, though that cascades down
to a few other helpers (see below). I'm not sure if that is making the
world a better place, or if it is just const pedantry.

diff --git a/commit-reach.c b/commit-reach.c
index 5df471a313..8cede01f01 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -563,7 +563,7 @@ int repo_get_merge_bases(struct repository *r,
  */
 int repo_is_descendant_of(struct repository *r,
 			  struct commit *commit,
-			  struct commit_list *with_commit)
+			  const struct commit_list *with_commit)
 {
 	if (!with_commit)
 		return 1;
@@ -955,11 +955,12 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	return result;
 }
 
-int can_all_from_reach(struct commit_list *from, struct commit_list *to,
+int can_all_from_reach(const struct commit_list *from,
+		       const struct commit_list *to,
 		       int cutoff_by_min_date)
 {
 	struct object_array from_objs = OBJECT_ARRAY_INIT;
-	struct commit_list *from_iter = from, *to_iter = to;
+	const struct commit_list *from_iter = from, *to_iter = to;
 	int result;
 	timestamp_t min_commit_date = cutoff_by_min_date ? from->item->date : 0;
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
diff --git a/commit-reach.h b/commit-reach.h
index 3f3a563d8a..76e82f827e 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -37,7 +37,7 @@ int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result)
 
 int repo_is_descendant_of(struct repository *r,
 			  struct commit *commit,
-			  struct commit_list *with_commit);
+			  const struct commit_list *with_commit);
 int repo_in_merge_bases(struct repository *r,
 			struct commit *commit,
 			struct commit *reference);
@@ -93,7 +93,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int assign_flag,
 				 timestamp_t min_commit_date,
 				 timestamp_t min_generation);
-int can_all_from_reach(struct commit_list *from, struct commit_list *to,
+int can_all_from_reach(const struct commit_list *from,
+		       const struct commit_list *to,
 		       int commit_date_cutoff);
 
 
> +cycle:
> +	free(contains_stack.contains_stack);
> +	clear_contains_cache(cache);
> +	init_contains_cache(cache);
> +
> +	result = repo_is_descendant_of(the_repository, candidate, want);
> +	if (result < 0)
> +		exit(128);

We are feeding the whole initial "want" list, so we should get a correct
answer regardless of how far we got into the cycle, which would run into
problems (e.g., if the cycle existed only on some branch of the
history). But going back to the initial list will always be correct.
Good.

Two small points, though.

One, the call to init_contains_cache() is redundant here; the clear
function is documented as making things ready for use (it's a little
hard to grep for, due to macros, but the docs are in commit-slab.h).
It's probably not hurting anything.

Two, the call to exit(128) is unusual for our code base (I'd guess it
was cribbed off of the top-level exits in builtin/pull.c). We'd usually
die() instead. Even if repo_is_descendant_of() produced its own error
message, it may be useful to mention that we were falling back to it due
to a cycle.

But even better is if we can return the error up the stack. We do not
return errors from contains_tag_algo() currently, but it has only one
caller. And that caller may also directly return the result of
repo_is_descendant_of(). So could we just pass that along?

Perhaps not. Looking at the callers of commit_contains(), they treat the
result as a pure boolean. So probably calling die() is reasonable, and
we already do so via parse_commit_or_die() elsewhere in the algorithm.
That does leave a potential lurking bug for the non-tag-algo code path.

> +	*contains_cache_at(cache, candidate) =
> +		result ? CONTAINS_YES : CONTAINS_NO;
> +	return result ? CONTAINS_YES : CONTAINS_NO;

So we actually cache our discovered value. Cute, and it might save us
from hitting the cycle again, though not always. E.g., two candidates A
and B share a parent P, and the cycle starts at P but does not include A
or B. We discover the cycle and cache the value for A, but discover it
again for B.

We do lose all of the existing non-cycle cached values when we call
clear_contains_cache(). But we have to at least clear out all of the
IN_PROGRESS commits. It is hard to care too much about optimizing the
outcome for this case which we expect to happen approximately never.
So I think doing the simplest correct thing is OK.

> +test_expect_success 'tag --contains handles cyclic replacement histories' '
> +	first=$(git rev-parse HEAD~2) &&
> +	second=$(git rev-parse HEAD~) &&
> +	third=$(git rev-parse HEAD) &&
> +	test_when_finished "
> +		git replace -d $first
> +		git replace -d $third
> +		git tag -d cycle-a cycle-b
> +	" &&

We usually &&-chain the commands inside test_when_finished. If they
fail, the test harness will note this and complain (if the test was not
otherwise failing). It's usually not a big deal either way, though
sometimes it can catch silly mistakes (e.g., if you wrote $second
instead of $third and the "replace -d" is quietly doing nothing at all).

I'm a little surprised that the chainlint checker doesn't catch this,
but I guess it doesn't know to recurse into the snippet handed to
test_when_finished. It probably is not really worth the trouble to teach
it to do so.

Otherwise the test looks good to me.

-Peff
