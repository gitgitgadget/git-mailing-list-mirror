Received: from smtp118.iad3a.emailsrvr.com (smtp118.iad3a.emailsrvr.com [173.203.187.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE439A803
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947658; cv=none; b=Dum9cKtCP2KQ8IqetvqFtg5q1oShOIxYMAnFDn0FSLh5H81clErRYWXnQ/jCvZRoCLQ6t5fBfnto9HQXmcX04NhckxqExsURMNXb5pp2QFdASNxBfaJS9ly8niPxBH5BlGOcrAetR/RinFsT6RMLbJnsiPn1HCbEjokS5Vt9vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947658; c=relaxed/simple;
	bh=bX9LfeD/6LU7SzEZ+a1I4ah6gpYOHWHouAg5hBzYtIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HO+1MSuAdNG7Gb0rx//pv/7njFXjpmMck7MnbH4gdS0/WlsHyN9BK0Eac5+1/QurvVqI5NcxKsSxLw8sNs9ucp1zCLxGxwdSfOHRZJz18HmV9LaD9cgAvk92NBZa9fBv+0HGvkPIwMPJ+MhmGMH6YgNDKIu4cptAbuzI0UwNszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=HMPLRDix; arc=none smtp.client-ip=173.203.187.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="HMPLRDix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947655;
	bh=bX9LfeD/6LU7SzEZ+a1I4ah6gpYOHWHouAg5hBzYtIU=;
	h=From:To:Subject:Date:From;
	b=HMPLRDixuXmsgQSECb2gev+bxWvNya03gS5vsCFLcKE7SEYJPOhy4KbYzUqZSQ+Mj
	 3K1DDk+LoIZlJb1fWs312mv4Q6cIpZWwBXaJnI3mrMa2YYot36/lCU8ITOp/VPFmz8
	 vYKSAICRlBewhMptDd1ZRW0qZmgAoJ9L0SEr7RnI=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 8EEA325328;
	Tue, 13 Oct 2026 23:14:15 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 08/12] remote: reject duplicate destinations on an empty remote
Date: Tue, 13 Oct 2026 23:13:43 -0400
Message-ID: <20261014031347.50433-9-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014031347.50433-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
 <20261014031347.50433-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-9-1

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

Tests are added and updated for the observable behavior change:

 - t5408: update to expect the client-side error for duplicate
   destinations, change test descriptions to note they have not
   been asserting anything about the order of partial ref update,
   and fix a missing "2>err"

 - t5516: test pushing two refspecs creating the same new branch

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 remote.c                   |  6 +++---
 t/t5408-send-pack-stdin.sh | 14 +++++++-------
 t/t5516-fetch-push.sh      | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 10 deletions(-)

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
index 7af350f01c..1e34880323 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -97,25 +97,25 @@ test_expect_success '--stdin refs are sent after cmdline refs' '
 	verify_push A bar
 '
 
-test_expect_success 'cmdline refs written in order' '
+test_expect_success 'two cmdline refs for the same destination are rejected' '
 	clear_remote &&
 	test_must_fail git send-pack remote.git A:foo B:foo 2>err &&
-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
-test_expect_success 'cmdline refs with multiple duplicates' '
+test_expect_success 'three cmdline refs for the same destination are rejected' '
 	clear_remote &&
 	test_must_fail git send-pack remote.git A:foo B:foo C:foo 2>err &&
-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
-test_expect_success '--stdin refs come after cmdline' '
+test_expect_success 'cmdline and --stdin refs for the same destination are rejected' '
 	clear_remote &&
 	echo A:foo >input &&
-	test_must_fail git send-pack remote.git --stdin B:foo <input &&
-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_must_fail git send-pack remote.git --stdin B:foo <input 2>err &&
+	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 81ad6cd52f..2f46ddc9ba 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -400,6 +400,42 @@ test_expect_success 'push with no ambiguity (2)' '
 	check_push_result testrepo $the_commit remotes/origin/main
 '
 
+test_expect_success 'push --dry-run two refspecs targeting the same ref fails' '
+	mk_test testrepo heads/main &&
+	test_must_fail git push --dry-run testrepo main:frotz main:frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_success 'push two refspecs targeting the same ref fails' '
+	mk_test testrepo heads/main &&
+	test_must_fail git push testrepo main:frotz main:frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_success 'push --dry-run two refspecs creating the same ref fails on empty repo' '
+	mk_empty testrepo &&
+	test_must_fail git push --dry-run testrepo main:frotz main:frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_success 'push two refspecs creating the same ref fails on empty repo' '
+	mk_empty testrepo &&
+	test_must_fail git push testrepo main:frotz main:frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_success 'push --dry-run abbreviated then full refspec creating the same ref fails on empty repo' '
+	mk_empty testrepo &&
+	test_must_fail git push --dry-run testrepo main:frotz main:refs/heads/frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_success 'push abbreviated then full refspec creating the same ref fails on empty repo' '
+	mk_empty testrepo &&
+	test_must_fail git push testrepo main:frotz main:refs/heads/frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
 test_expect_success 'push with colon-less refspec, no ambiguity' '
 	mk_test testrepo heads/main heads/t/main &&
 	git branch -f t/main main &&
-- 
2.55.0

