Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A052512D8
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321960; cv=none; b=LqHLRVRKtTG+U9uJqu8gz+LTShJtvcPWkS3Y4BetMRMHOc6lGdGdHafvlSL4XwiC6rKbT+3mv2shsSG4gezAhKCoaFloqxVxAJG93p9abtzWc56qbLwY+SDfNqN0itPZWHqK0quRDfw4bgfjcNDP3FmSenwlakOPEY+yT0ssGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321960; c=relaxed/simple;
	bh=ZwfR1eJft+iDNlLBDE+UWM64KB4WZjOVOAfYVeGcoR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpBMViF0tWENJp8J2aaqEeSHz0Sj7tATaYoTV7E/HOCXonjvjcR+gHxrM4ZEiZcT4VQKYFz6vzcIOdxSEPUSwHKVO1IgJiRZYQwmV4xg/hpz0QZAYRjz+Bz8XTr/YksEke782x5tM/JsfJD06G4rLOvRv5QThFHml5VNq6M3hO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EqvtTjUK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EqvtTjUK"
Received: (qmail 134762 invoked by uid 109); 19 Sep 2025 22:45:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZwfR1eJft+iDNlLBDE+UWM64KB4WZjOVOAfYVeGcoR0=; b=EqvtTjUKFOkjwSwKajtILZGYWfOY52izv5S0IrT61tca6zsvOB6znJMCLJCMj5XqJQ8YZ4bQm5lqJKPUywqPbdRDDup+0mxaFkppwgzDzDV+5/pErs4C5tbrnSNkerfYJy/T7lB1PzDOTWxQA0YbJrzCpIaz3TO3TlQ84kcop9GECPRaNrqW2hQp2n/NQ27uDtSo2vrbK13gCbmoS/DKD6qgJyaGThWZzv8xA4aCToIwAMzLpN31m9VyrxMgeXsFfKBNWjecFaeU6sTr9Sg19z7Bebtt688SB2mQDRAyeDxQzblUmFSMW14GyCz70YZm/kB6MNObu7Q72V/OByArdg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 22:45:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211390 invoked by uid 111); 19 Sep 2025 22:45:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 18:45:57 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 18:45:56 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/6] revision: manage memory ownership of argv in
 setup_revisions()
Message-ID: <20250919224556.GB594545@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919223351.GA3906184@coredump.intra.peff.net>

The setup_revisions() function takes an argc/argv pair and consumes
arguments from it, returning a reduced argc count to the caller. But it
may also overwrite entries within the argv array, as it shifts unknown
options to the front of argv (so they can be found in the range of
0..argc-1 after we return).

For a normal argc/argv coming from the operating system, this is OK.
We don't need to worry about memory ownership of the strings in those
entries. But some callers pass in allocated strings from a strvec, and
we do need to care about those.

We faced a similar issue in f92dbdbc6a (revisions API: don't leak memory
on argv elements that need free()-ing, 2022-08-02), which added an
option for callers to tell us that elements need to be freed. But the
implementation within setup_revisions() was incomplete.  It only covered
the case of dropping "--", but not the movement of unknown options.

When we shift argv entries around, we should free the elements we are
about to overwrite, so they are not leaked. For example, in:

  git stash show -p --invalid

we will pass this to setup_revisions():

  argc = 3, argv[] = { "show", "-p", "--invalid", NULL }

which will then return:

   argc = 2, argv[] = { "show", "--invalid", "--invalid", NULL }

overwriting the "-p" entry, which is leaked unless we free it at that
moment.

You can see in the output above another potential problem. We now have
two copies of the "--invalid" string. If the caller does not respect the
new argc when free-ing the strings via strvec_clear(), we'll get a
double-free. And git-stash suffers from this, and will crash with the
above command.

So it seems at first glance that the solution is to just assign the
reduced argc to the strvec.nr field in the caller. Then it would stop
after freeing only any copied entries. But that's not always right
either!

Remember that we are reducing "argc" to account for elements we've
consumed. So if there isn't an invalid option, we'd turn:

  argc = 2, argv[] = { "show", "-p", NULL }

into:

  argc = 1, argv[] = { "show", "-p", NULL }

In that case strvec_clear() must keep looking past the shortened argc we
return to find the original "-p" to free. It needs to use the original
argc to do that.

We can solve this by turning our argv writes into strict moves, not
copies. When we shuffle an unknown option to the front, we'll overwrite
its old position with NULL. That leaves an argv array that may have NULL
"holes" in it.

So in the "--invalid" example above we get:

   argc = 2, argv[] = { "show", "--invalid", NULL, NULL }

but something like "git stash -p --invalid -p" would yield:

  argc = 3, argv[] = { "show", "--invalid", NULL, "-p", NULL }

because we move "--invalid" to overwrite the first "-p", but the second
one is quietly consumed. But strvec_clear() can handle that fine (it
iterates over the "nr" field, and passing NULL to free() is OK).

To ease the implementation, I've introduced a helper function. It's a
little hacky because it must take a double-pointer to set the old
position to NULL. Which in turn means we cannot pass "&arg", our local
alias for the current entry we're parsing, but instead "&argv[i]", the
pointer in the original array. And to make it even more confusing, we
delegate some of this work to handle_revision_opt(), which is passed a
subset of the argv array, so is always working on "&argv[0]".

Likewise, because handle_revision_opt() only receives the part of argv
left to parse, it receives the array to accumulate unknown options as a
separate unkc/unkv pair. But we're always working on the same argv
array, so our strategy works fine. I suspect this would be a bit more
obvious (and avoid some pointer cleverness) if all functions saw the
full argv array and worked with positions within it (and our new helper
would take two positions, a src and dst). But that would involve
refactoring handle_revision_opt().  I punted on that, as what's here is
not too ugly and is all contained within revision.c itself.

The new test demonstrates that "git stash show -p --invalid" no longer
crashes with a double-free (because we move instead of copy). And it
passes with SANITIZE=leak because we free "-p" before overwriting.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c       | 24 +++++++++++++++++++++---
 t/t3903-stash.sh |  5 +++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 6ba8f67054..6c140d969d 100644
--- a/revision.c
+++ b/revision.c
@@ -2321,6 +2321,24 @@ static timestamp_t parse_age(const char *arg)
 	return num;
 }
 
+static void overwrite_argv(int *argc, const char **argv,
+			   const char **value,
+			   const struct setup_revision_opt *opt)
+{
+	/*
+	 * Detect the case when we are overwriting ourselves. The assignment
+	 * itself would be a noop either way, but this lets us avoid corner
+	 * cases around the free() and NULL operations.
+	 */
+	if (*value != argv[*argc]) {
+		if (opt && opt->free_removed_argv_elements)
+			free((char *)argv[*argc]);
+		argv[*argc] = *value;
+		*value = NULL;
+	}
+	(*argc)++;
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2342,7 +2360,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    starts_with(arg, "--branches=") || starts_with(arg, "--tags=") ||
 	    starts_with(arg, "--remotes=") || starts_with(arg, "--no-walk="))
 	{
-		unkv[(*unkc)++] = arg;
+		overwrite_argv(unkc, unkv, &argv[0], opt);
 		return 1;
 	}
 
@@ -2706,7 +2724,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
-			unkv[(*unkc)++] = arg;
+			overwrite_argv(unkc, unkv, &argv[0], opt);
 		return opts;
 	}
 
@@ -3018,7 +3036,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 			if (!strcmp(arg, "--stdin")) {
 				if (revs->disable_stdin) {
-					argv[left++] = arg;
+					overwrite_argv(&left, argv, &argv[i], opt);
 					continue;
 				}
 				if (revs->read_from_stdin++)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 1c9e589bbe..7ebeb057d3 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1747,4 +1747,9 @@ test_expect_success 'stash show handles --' '
 	test_cmp expect actual
 '
 
+test_expect_success 'controlled error return on unrecognized option' '
+	test_expect_code 129 git stash show -p --invalid 2>usage &&
+	grep -e "^usage: git stash show" usage
+'
+
 test_done
-- 
2.51.0.568.g6b54b97edf

