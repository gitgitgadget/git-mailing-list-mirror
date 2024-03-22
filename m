Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54C3D978
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103708; cv=none; b=jj5q9LVdXsNkjf7qYWFp7Uq1ypQcmJz9xOn21A/u5Q4QcYUlVAsTgzyODSlFwbULpAomlbjoK2thwezWCnFr9Oh7mVvIyt3LyYgUOsQiIHEINUPvLrYCf37Sn5Rb+e56bk1ntZexwyjL1jvNJkymobeQQh8TmvhTlljQhA3jN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103708; c=relaxed/simple;
	bh=vGMee+whxpR/aLrWUz5/gs71y7PLsdODQsUZZ6hPjuI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YGmAxma35MtIJhRUKJpruh5/MClmvlobbSPrDNk4GCij1CaJnh0lbNtOTJeY/ymPeAwMvfuP9f5BiwcxEM8dP4V4LokrifrO8jrd1uDNo9qOJOBNnMOeCjhYmbNvxcxvi3BLE+rxesv7bIeEDR5gjcbC1rTOD5MGJCO9dRQKbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5679 invoked by uid 109); 22 Mar 2024 10:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Mar 2024 10:35:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6320 invoked by uid 111); 22 Mar 2024 10:35:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Mar 2024 06:35:08 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Mar 2024 06:35:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] rebase: use child_process_clear() to clean
Message-ID: <20240322103502.GA2045297@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

In the run_am() function, we set up a child_process struct to run
"git-am", allocating memory for its args and env strvecs. These are
normally cleaned up when we call run_command(). But if we encounter
certain errors, we exit the function early and try to clean up ourselves
by clearing the am.args field. This leaks the "env" strvec.

We should use child_process_clear() instead, which covers both. And more
importantly, it future proofs us against the struct ever growing more
allocated fields.

These are unlikely errors to happen in practice, so they don't actually
trigger the leak sanitizer in the tests. But we can add a new test which
does exercise one of the paths (and fails SANITIZE=leak without this
patch).

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this when investigating a different leak, since that other one
caused format-patch to crash, hitting one of the error paths. ;)

The results of "git grep 'strvec_clear.*\.args'" imply the problem
doesn't exist elsewhere (arguably the hit in test-trace2.c should use
child_process_clear() to set a good example, but it's already a bit of
an oddball use of the struct).

Not sure if the test is overkill. It really does nothing useful in a
non-leak-checking build.

 builtin/rebase.c               | 6 +++---
 t/t3438-rebase-broken-files.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e444ab102d..b9d0fb3269 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -610,7 +610,7 @@ static int run_am(struct rebase_options *opts)
 		status = error_errno(_("could not open '%s' for writing"),
 				     rebased_patches);
 		free(rebased_patches);
-		strvec_clear(&am.args);
+		child_process_clear(&am);
 		return status;
 	}
 
@@ -638,7 +638,7 @@ static int run_am(struct rebase_options *opts)
 		struct reset_head_opts ropts = { 0 };
 		unlink(rebased_patches);
 		free(rebased_patches);
-		strvec_clear(&am.args);
+		child_process_clear(&am);
 
 		ropts.oid = &opts->orig_head->object.oid;
 		ropts.branch = opts->head_name;
@@ -659,7 +659,7 @@ static int run_am(struct rebase_options *opts)
 		status = error_errno(_("could not open '%s' for reading"),
 				     rebased_patches);
 		free(rebased_patches);
-		strvec_clear(&am.args);
+		child_process_clear(&am);
 		return status;
 	}
 
diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
index c614c4f2e4..821f08e5af 100755
--- a/t/t3438-rebase-broken-files.sh
+++ b/t/t3438-rebase-broken-files.sh
@@ -58,4 +58,13 @@ test_expect_success 'unknown key in author-script' '
 	check_resolve_fails
 '
 
+test_expect_success POSIXPERM,SANITY 'unwritable rebased-patches does not leak' '
+	>.git/rebased-patches &&
+	chmod a-w .git/rebased-patches &&
+
+	git checkout -b side HEAD^ &&
+	test_commit unrelated &&
+	test_must_fail git rebase --apply --onto tmp HEAD^
+'
+
 test_done
-- 
2.44.0.682.g01e1dab148
