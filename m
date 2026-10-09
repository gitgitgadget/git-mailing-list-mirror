Received: from smtp92.iad3b.emailsrvr.com (smtp92.iad3b.emailsrvr.com [146.20.161.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EA4657D0
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574243; cv=none; b=GhBCmyydvEI591XOqz4fjXOCy10ZtyVhMh8vX0fM/n+QvgPJO+vsJd7tK1lF3JFDllg9eQnEsAe8FuIi6PFXfGFGG4YpKPPLz/Lb7OMbG8pttgbd/P+tksaCwnT3mRjZ5G5RmWZPBZWeQoHNaiW45Mp/ssdWxLM6YN9YF91FnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574243; c=relaxed/simple;
	bh=WqhgXYTLcOyTBB+Uh723L03oCXPE8TNXtn+P8X6J7iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJwXFV4C9+EeL4LN1bStt+Om82bm9qgwyMOwlS6Ot4SZMZJmmobztVov+mbOVkxPmxx27xG6iI4MOUKWNI1KhK4iYqHIceqRkT9jGF58R/slUA0JI7L+cFiMeXg6yxnMx61847jaRSVo73p/Sx6tCkJAuqK6wMkyDRbCPYNeOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=DaK00mym; arc=none smtp.client-ip=146.20.161.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="DaK00mym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574223;
	bh=WqhgXYTLcOyTBB+Uh723L03oCXPE8TNXtn+P8X6J7iI=;
	h=From:To:Subject:Date:From;
	b=DaK00mym+/qlPVbAnsk8gICkbQRpZWnDOo2TmS2y0Ci9lIBRtHiDu/fbFwrwHjZK4
	 DqD2UiRCGnqBbShghIq39INq8HR3oTlE94EBZxHMl7ML6THtvV9NYRxhn/xJbje9mA
	 b33Lqfd8JQC7ssqnFmsgAbJp9rkM+e8LNEk/PJlM=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 2E98820394;
	Fri,  9 Oct 2026 15:30:23 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 11/15] remote: reject duplicate destinations on an empty remote
Date: Fri,  9 Oct 2026 15:29:49 -0400
Message-ID: <20261009192953.81794-12-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009192953.81794-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-12-1

match_explicit_refs() passes the head of the remote ref list, 'dst',
to match_explicit() for every refspec.  match_explicit() searches that
list via count_refspec_match() and, when nothing matches, appends a
new destination through 'dst_tail'.

This works when the remote already has refs: 'dst' is non-NULL, so each
loop iteration walks from the same head and finds destinations linked
at the tail.

This fails when the remote is empty and 'dst' is NULL.  match_push_refs()
computes 'dst_tail' with tail_ref(), which for an empty list is the head
slot itself: so the first link writes through '*dst'.  But each loop
iteration still provides the original NULL to match_explicit(), with
the result that newly-linked destinations are not seen.

The behavior dates back to f88395ac23 (Renaming push., 2005-08-03),
where match_explicit_refs() searches the destination list from the
'dst' it was given while appending new destinations through 'dst_tail'.

Pass the remote refs head by pointer in match_explicit_refs() so that
each loop iteration re-reads '*dst' and detects a destination created
by an earlier refspec.

With this, failing tests in t5408, t5516 now pass and are toggled to
test_expect_success.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 remote.c                   | 6 +++---
 t/t5408-send-pack-stdin.sh | 6 +++---
 t/t5516-fetch-push.sh      | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index 91d35b37fe..f4cf63b756 100644
--- a/remote.c
+++ b/remote.c
@@ -1416,12 +1416,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	return ret;
 }
 
-static int match_explicit_refs(struct ref *src, struct ref *dst,
+static int match_explicit_refs(struct ref *src, struct ref **dst,
 			       struct ref ***dst_tail, struct refspec *rs)
 {
 	int i, errs;
 	for (i = errs = 0; i < rs->nr; i++)
-		errs += match_explicit(src, dst, dst_tail, &rs->items[i]);
+		errs += match_explicit(src, *dst, dst_tail, &rs->items[i]);
 	return errs;
 }
 
@@ -1673,7 +1673,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	if (!rs->nr)
 		refspec_append(rs, ":");
 
-	errs = match_explicit_refs(src, *dst, &dst_tail, rs);
+	errs = match_explicit_refs(src, dst, &dst_tail, rs);
 
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index 0321519f21..1e34880323 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -97,21 +97,21 @@ test_expect_success '--stdin refs are sent after cmdline refs' '
 	verify_push A bar
 '
 
-test_expect_failure 'two cmdline refs for the same destination are rejected' '
+test_expect_success 'two cmdline refs for the same destination are rejected' '
 	clear_remote &&
 	test_must_fail git send-pack remote.git A:foo B:foo 2>err &&
 	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
-test_expect_failure 'three cmdline refs for the same destination are rejected' '
+test_expect_success 'three cmdline refs for the same destination are rejected' '
 	clear_remote &&
 	test_must_fail git send-pack remote.git A:foo B:foo C:foo 2>err &&
 	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
-test_expect_failure 'cmdline and --stdin refs for the same destination are rejected' '
+test_expect_success 'cmdline and --stdin refs for the same destination are rejected' '
 	clear_remote &&
 	echo A:foo >input &&
 	test_must_fail git send-pack remote.git --stdin B:foo <input 2>err &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index e150246577..2f46ddc9ba 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -412,25 +412,25 @@ test_expect_success 'push two refspecs targeting the same ref fails' '
 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
 '
 
-test_expect_failure 'push --dry-run two refspecs creating the same ref fails on empty repo' '
+test_expect_success 'push --dry-run two refspecs creating the same ref fails on empty repo' '
 	mk_empty testrepo &&
 	test_must_fail git push --dry-run testrepo main:frotz main:frotz 2>err &&
 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
 '
 
-test_expect_failure 'push two refspecs creating the same ref fails on empty repo' '
+test_expect_success 'push two refspecs creating the same ref fails on empty repo' '
 	mk_empty testrepo &&
 	test_must_fail git push testrepo main:frotz main:frotz 2>err &&
 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
 '
 
-test_expect_failure 'push --dry-run abbreviated then full refspec creating the same ref fails on empty repo' '
+test_expect_success 'push --dry-run abbreviated then full refspec creating the same ref fails on empty repo' '
 	mk_empty testrepo &&
 	test_must_fail git push --dry-run testrepo main:frotz main:refs/heads/frotz 2>err &&
 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
 '
 
-test_expect_failure 'push abbreviated then full refspec creating the same ref fails on empty repo' '
+test_expect_success 'push abbreviated then full refspec creating the same ref fails on empty repo' '
 	mk_empty testrepo &&
 	test_must_fail git push testrepo main:frotz main:refs/heads/frotz 2>err &&
 	test_grep "dst ref refs/heads/frotz receives from more than one src" err
-- 
2.55.0

