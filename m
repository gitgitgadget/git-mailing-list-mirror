Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCD4A23
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376653; cv=none; b=jbZAzidHxCYYwV8PRqn8W/JAeD7i+g3D0uRYVzLnzM+BVA9OsciSS7E9DmWo3IOJ2ABSbBMhgklzoQdjuWvUavJGsfEsL1XSCRWY/GDs5iwizLey8z34eMa6VF6eNVcpEg9sagr5xRZU7FRdyHaBqi/6P0kuAsudmO9s0N1UQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376653; c=relaxed/simple;
	bh=dY3gw9hDL7+v7em8T/KOTjQ2+MVzyCHgrARxinkokPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6fE8K1T8m6y3rmMI6TBCKQgS+RmWy423cw40x4M8+1IrXV4mG9XnxwVQBCtZ6T51QDj3jgtbK++mQybfRQ5hfcgWk7/+EpX2GoiHhNn/bTU07ba/J27YjNj42osBQHGq365Tm106SSht6chi2VwgZyYdmaGfVD/1xPvPnEg3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O94d1BNG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O94d1BNG"
Received: (qmail 9957 invoked by uid 109); 1 Feb 2025 02:24:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dY3gw9hDL7+v7em8T/KOTjQ2+MVzyCHgrARxinkokPs=; b=O94d1BNGU1WrOKGI5wO0ondZoNxFVnFVfRyxIrd5fM1SUVbwHDLrqlvFf+hscs+Gq7Daz3/pw6k89zp+UzRlyjPQpPTDg7qCZkn6lnQfue84niana0YSSOv7boUP8Ki0teHQgeDebxQBAq8yS+90rHo6tRc0la94BKiXtEl+7WJ9AFxK7dPWIFmTONIWsHqBceEqE1Q4zfjYTH2u1YAHOjRJtX/G242qhS2m0VyCKtpINzDhCMKJJHPBGKvT/TdYbcf2RS5aedhr9hhocjPYGQegFwpawwPjSO9qVCFx42YJEH0l60teJZVl4TNbalequzlWKzPDbxSM6PxcNd5BHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Feb 2025 02:24:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8146 invoked by uid 111); 1 Feb 2025 02:24:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2025 21:24:13 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 31 Jan 2025 21:24:09 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: undefined behavior in unit tests, was Re: [PATCH v3 3/3] reftable:
 prevent 'update_index' changes after adding records
Message-ID: <20250201022409.GA4082344@coredump.intra.peff.net>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
 <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>

On Wed, Jan 22, 2025 at 06:35:49AM +0100, Karthik Nayak wrote:

> +static void t_reftable_invalid_limit_updates(void)
> +{
> +	struct reftable_ref_record ref = {
> +		.refname = (char *) "HEAD",
> +		.update_index = 1,
> +		.value_type = REFTABLE_REF_SYMREF,
> +		.value.symref = (char *) "master",
> +	};
> +	struct reftable_write_options opts = {
> +		.default_permissions = 0660,
> +	};
> +	struct reftable_addition *add = NULL;
> +	char *dir = get_tmp_dir(__LINE__);
> +	struct reftable_stack *st = NULL;
> +	int err;
> +
> +	err = reftable_new_stack(&st, dir, &opts);
> +	check(!err);
> +
> +	reftable_addition_destroy(add);
> +
> +	err = reftable_stack_new_addition(&add, st, 0);
> +	check(!err);

Coverity complains that this function may have undefined behavior. It's
an issue we have in a lot of other tests that have moved to the
unit-test framework. I've mostly been ignoring it, but this is a pretty
straight-forward example, so I thought I'd write a note.

The issue is that reftable_new_stack() might fail, leaving "st" as NULL.
And then we feed it to reftable_stack_new_addition(), which dereferences
it.

In normal production code, we'd expect something like:

  if (err)
	return -1;

to avoid running the rest of the function after the first error. But the
test harness check() function doesn't return. It just complains to
stdout and keeps running!  So you'll get something like[1]:

  $ t/unit-tests/bin/t-reftable-stack
  ok 1 - empty addition to stack
  ok 2 - read_lines works
  ok 3 - expire reflog entries
  # check "!err" failed at t/unit-tests/t-reftable-stack.c:1404
  Segmentation fault

So...yes, we will probably notice that the test failed from the exit
code. But it's not great when the harness itself barfs so had. Plus a
compiler may be free to reorder things in a confusing way if it can see
that "st" must never be NULL.

It feels like we probably ought to return as soon as a check() fails.
That does create other headaches, though. E.g., we'd potentially leak
from an early return (which our LSan builds will complain about),
meaning that test code needs to start doing the usual "goto out" type of
cleanup.

So I dunno. Maybe we just live with it. But it feels pretty ugly.

-Peff

[1] This would happen in practice if malloc() failed, but you can
    simulate it yourself like this, which is what I used to create the
    output above:

diff --git a/reftable/stack.c b/reftable/stack.c
index 026a9f9742..fe77132102 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -861,6 +861,11 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 	int err = 0;
 	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
 
+	if (flags & (1 << 16)) {
+		*dest = NULL;
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+	}
+
 	REFTABLE_CALLOC_ARRAY(*dest, 1);
 	if (!*dest)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index c3f0059c34..73ed9792a5 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -1400,7 +1400,7 @@ static void t_reftable_invalid_limit_updates(void)
 
 	reftable_addition_destroy(add);
 
-	err = reftable_stack_new_addition(&add, st, 0);
+	err = reftable_stack_new_addition(&add, st, (1 << 16));
 	check(!err);
 
 	/*
