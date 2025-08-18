Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C21E868
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550917; cv=none; b=jeB0G0pU9VTbBVvEDOtlNahWxgx8apdfuYkZ/0UsHcs9t76Os/nAoGJLxBMGySeVA5Huk/EmRb1ygwLJ59JpOx4LOyBxCu4rydvut+WqC2RTvflX3h7wj3aUB+f/o6FbQ5yTRMhyQ2pj/k0+v2u4rJem15xGhEFKkYrA9Yy+xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550917; c=relaxed/simple;
	bh=uU2zIoljent+LioL4vXhQUm1q8stLdsfQVFGdsEmNHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8PgDXpml2iMc0IR+/3NY39w3oxXr9RcamFufHEH7hgWI6VU3dmc+Sumwitbdt0KrvTw+BGL0AHACxTKIN07CfrwtRaOSa0BvKVZnD1929PzncJZbM+mXuIwrMxLoDSmiZ02N/vuzlVEYrkBQBRNrKC1/IKNqn/JA9fuKj5CYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ewO3Vsv3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ewO3Vsv3"
Received: (qmail 23295 invoked by uid 109); 18 Aug 2025 21:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uU2zIoljent+LioL4vXhQUm1q8stLdsfQVFGdsEmNHA=; b=ewO3Vsv3wJkPHH/DDkC6y4Hh9tDi9epVhDQyFgmVAdfPluVFVZa8PShe989DKTJAskm4OLvT5yIrKp13zgeFgHSngx49SRn/Eq2oUpT5RfNflJfB4OUUFPjjYARlTYvRAqwtXWVidD8n0XsXPYbz09PJMfVqKGJLMDsDFZRidASBJZy3OagnC2Wn6O4+D9y/6Bcr+m3rcO37VLkAXFlkBIF/MsUBbf039ty/+uonm01U5l/EurF2vgFSInKDaF/UZZvSzcYvRRv72+i9upu55xSCdkiHUZ21TblZ0SG0CV2Z1s6YJUY9Nss46escgrpRobKHXaTqHw1HuLPMPtZmSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 21:01:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30320 invoked by uid 111); 18 Aug 2025 21:01:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 17:01:54 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 17:01:54 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: [PATCH 3/5] describe: catch unborn branch in describe_blob()
Message-ID: <20250818210154.GC1024556@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818205812.GA1018043@coredump.intra.peff.net>

When describing a blob, we search for it by traversing from HEAD. We do
this by feeding the name HEAD to setup_revisions(). But if we are on an
unborn branch, this will fail with a confusing message:

  $ git describe $blob
  fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

It is OK for this to be an error (we cannot find $blob in an empty
traversal, so we'd eventually complain about that). But the error
message could be more helpful.

Let's resolve HEAD ourselves and pass the resolved object id to
setup_revisions(). If resolving fails, then we can print a more useful
message.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c  | 8 +++++++-
 t/t6120-describe.sh | 8 ++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 06e413d937..f7bea3c8c5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -518,10 +518,16 @@ static void describe_blob(const struct object_id *oid, struct strbuf *dst)
 {
 	struct rev_info revs;
 	struct strvec args = STRVEC_INIT;
+	struct object_id head_oid;
 	struct process_commit_data pcd = { *null_oid(the_hash_algo), oid, dst, &revs};
 
+	if (repo_get_oid(the_repository, "HEAD", &head_oid))
+		die(_("cannot search for blob '%s' on an unborn branch"),
+		    oid_to_hex(oid));
+
 	strvec_pushl(&args, "internal: The first arg is not parsed",
-		     "--objects", "--in-commit-order", "--reverse", "HEAD",
+		     "--objects", "--in-commit-order", "--reverse",
+		     oid_to_hex(&head_oid),
 		     NULL);
 
 	repo_init_revisions(the_repository, &revs, NULL);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 470631d17d..feec57bcbc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -415,6 +415,14 @@ test_expect_success 'describe an unreachable blob' '
 	test_grep "blob .$blob. not reachable from HEAD" actual
 '
 
+test_expect_success 'describe blob on an unborn branch' '
+	oldbranch=$(git symbolic-ref HEAD) &&
+	test_when_finished "git symbolic-ref HEAD $oldbranch" &&
+	git symbolic-ref HEAD refs/heads/does-not-exist &&
+	test_must_fail git describe test-blob 2>actual &&
+	test_grep "cannot search .* on an unborn branch" actual
+'
+
 test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
-- 
2.51.0.326.gecbb38d78e

