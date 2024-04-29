Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD374205E13
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379736; cv=none; b=pfrap10Q2fJCiM2mgjcXzJN5b+0M1fg4baHTK2kfWWoM8xw8XmLsDPgVDmM2LKnTZid7OxZjbzQBbbjgzobqsqJiw+AQCdguKHgu1e+ro04PLZucdr+EerQWCRDKvQFJKpEmxIdym9RD+0lw7EX8uIjdZTx9db+BmEpozuoKg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379736; c=relaxed/simple;
	bh=Z6WjMcpmUhJ+8ov6ZYmsprz3FFeWkST34NneN8GxQ08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jVxk3KRPbJGIY8jjwr/kwq53EsBEKRd3P37QEWboadRIECjlAFljhWIe6T4TlQFa27u83/z04ZvdrHdN9N7zuvbo9Y5ch+8s6C/+MENxnYepDkYi4L9ick+FzTnCQmNBvfABJjoJqLfM6qrw+KKwKFUxfjHBKp4C8RB9dTwSvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20271 invoked by uid 109); 29 Apr 2024 08:35:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:35:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26987 invoked by uid 111); 29 Apr 2024 08:35:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:35:38 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:35:33 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 8/8] refs: check refnames as fully qualified when resolving
Message-ID: <20240429083533.GG233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Most code paths for resolving refs end up in refs_resolve_ref_unsafe(),
which checks the names using check_refname_format(). The names we have
at this stage are always full refnames, but we pass the ALLOW_ONELEVEL
flag so that the function allows pseudorefs like MERGE_HEAD. We should
instead pass the FULLY_QUALIFIED flag, which lets check_refname_format()
do some extra syntactic checks on those pseudorefs.

With this patch we'll refuse to read anything outside of refs/ that does
not match the usual pseudoref syntax (all caps plus dashes). This should
not be a loss of functionality (since such refs cannot be written as of
the previous commit), but may protect us from mischief. For example, you
can ask for silly things like "info/refs", "rr-cache/<sha1>/postimage",
or "objects/info/commit-graphs/commit-graph-chain". It's doubtful you
can really do anything _too_ terrible there, but it seems like peeking
at random files in .git in response to possibly untrusted input is
something we should avoid.

Note that because we can't actually write such refs using Git, our tests
have to munge the filesystem manually (and hence only run with the files
backend). They also can only check that resolution fails (and not a
specific error message), since we don't return the "bad name" detail all
the way to the caller.

The second test here, for "main-worktree/bad", actually fails even
without this patch. The worktree-ref code enforces the pseudoref syntax
itself via is_current_worktree_ref(), so the extra checks for this in
check_refname_format() are redundant (though the parsing there is still
necessary so we know _not_ to reject "main-worktree/HEAD"). But either
way it's good to have a test which makes sure this remains the case.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                  |  4 ++--
 t/t1430-bad-ref-name.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 57663cfe9e..96f489861b 100644
--- a/refs.c
+++ b/refs.c
@@ -1951,7 +1951,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
 	*flags = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+	if (check_refname_format(refname, REFNAME_FULLY_QUALIFIED)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname))
 			return NULL;
@@ -2010,7 +2010,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 			oidclr(oid);
 			return refname;
 		}
-		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (check_refname_format(refname, REFNAME_FULLY_QUALIFIED)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname))
 				return NULL;
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 120e1557d7..5fb780cb08 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -400,4 +400,14 @@ test_expect_success 'update-ref refuses non-underscore outside of refs/' '
 	test_grep "refusing to update ref with bad name" err
 '
 
+test_expect_success REFFILES 'rev-parse refuses non-pseudoref outside of refs/' '
+	git rev-parse HEAD >.git/bad &&
+	test_must_fail git rev-parse --verify bad
+'
+
+test_expect_success REFFILES 'rev-parse recognizes non-pseudoref via worktree' '
+	git rev-parse HEAD >.git/bad &&
+	test_must_fail git rev-parse --verify main-worktree/bad
+'
+
 test_done
-- 
2.45.0.rc1.416.gbe2a76c799
