Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7E1DDEE
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941750; cv=none; b=CgoAOCsGPQjfPwvewBNzEr9A3wuMwCW3CM3IfBnquXWT+K5PzguEbnLIgl4XGms17fBSX0EE4YpjMugAarjfClceeoa9KtADAp1U5pQu/WtXgGxaJ2iPRF4P3RhEsi1vGQhqqyFun+iS4gIqfb1imZwoBWUQ/I7Q2J4TixeTKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941750; c=relaxed/simple;
	bh=qlR3O3C4XFiY600c0vhJ7nFu4TrBblodSA1AdNM06Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et0T+kFMhpC4HG5XR7sk6JvMsLmf0AmldNnFpqZFqgkUZyrYTeNw6VstwmKndiBNBfbPNXoUG0s6cD0sRIrEHprQC9fXT6rJPovREWKM+AhqeLBLQ93sT+4+lVs6NX6Z2GfCn57pbozakkZUevHG/Gz/kcMZ8Xe3jwcPfjuVe+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21893 invoked by uid 109); 26 Feb 2024 10:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 10:02:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14096 invoked by uid 111); 26 Feb 2024 10:02:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 05:02:32 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 05:02:26 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] Revert "refs: allow @{n} to work with n-sized reflog"
Message-ID: <20240226100226.GA2685600@coredump.intra.peff.net>
References: <20240226100010.GA1214708@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226100010.GA1214708@coredump.intra.peff.net>

This reverts commit 6436a20284f33d42103cac93bd82e65bebb31526.

The idea of that commit is that if read_ref_at() is counting back to the
Nth reflog but the reflog is short by one entry (e.g., because it was
pruned), we can find the oid of the missing entry by looking at the
"before" oid value of the entry that comes after it (whereas before, we
looked at the "after" value of each entry and complained that we
couldn't find the one from before the truncation).

This works fine for resolving the oid of ref@{n}, as it is used by
get_oid_basic(), which does not look at any other aspect of the reflog
we found (e.g., its timestamp or message). But there's another caller of
read_ref_at(): in show-branch we use it to walk over the reflog, and we
do care about the reflog entry. And so that commit broke "show-branch
--reflog"; it shows the reflog message for ref@{0} as ref@{1}, ref@{1}
as ref@{2}, and so on.

For example, in the new test in t3202 we produce:

  ! [branch@{0}] (0 seconds ago) commit: three
   ! [branch@{1}] (0 seconds ago) commit: three
    ! [branch@{2}] (60 seconds ago) commit: two
     ! [branch@{3}] (2 minutes ago) reset: moving to HEAD^

instead of the correct:

  ! [branch@{0}] (0 seconds ago) commit: three
   ! [branch@{1}] (60 seconds ago) commit: two
    ! [branch@{2}] (2 minutes ago) reset: moving to HEAD^
     ! [branch@{3}] (2 minutes ago) commit: one

But there's another bug, too: because it is looking at the "old" value
of the reflog after the one we're interested in, it has to special-case
ref@{0} (since there isn't anything after it). That's why it doesn't
show the offset bug in the output above. But this special-case code
fails to handle the situation where the reflog is empty or missing; it
returns success even though the reflog message out-parameter has been
left uninitialized. You can't trigger this through get_oid_basic(), but
"show-branch --reflog" will pretty reliably segfault as it tries to
access the garbage pointer.

Fixing the segfault would be pretty easy. But the off-by-one problem is
inherent in this approach. So let's start by reverting the commit to
give us a clean slate to work with.

This isn't a pure revert; all of the code changes are reverted, but for
the tests:

  1. We'll flip the cases in t1508 to expect_failure; making these work
     was the goal of 6436a2028, and we'll want to use them for our
     replacement approach.

  2. There's a test in t3202 for "show-branch --reflog", but it expects
     the broken output! It was added by f2463490c4 (show-branch: show
     reflog message, 2021-12-02) which was fixing another bug, and I
     think the author simply didn't notice that the second line showed
     the wrong reflog.

     Rather than fixing that test, let's replace it with one that is
     more thorough (while still covering the reflog message fix from
     that commit). We'll use a longer reflog, which lets us see more
     entries (thus making the "off by one" pattern much more clear). And
     we'll use a more recent timestamp for "now" so that our relative
     dates have more resolution. That lets us see that the reflog dates
     are correct (whereas when you are 4 years away, two entries that
     are 60 seconds apart will have the same "4 years ago" relative
     date). Because we're adjusting the repository state, I've moved
     this new test to the end of the script, leaving the other tests
     undisturbed.

     We'll also add a new test which covers the missing reflog case;
     previously it segfaulted, but now it reports the empty reflog).

Reported-by: Yasushi SHOJI <yasushi.shoji@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                     | 48 +++++++++++--------------------------
 t/t1508-at-combinations.sh |  4 ++--
 t/t3202-show-branch.sh     | 49 ++++++++++++++++++++++++++------------
 3 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/refs.c b/refs.c
index c633abf284..ba1a4db754 100644
--- a/refs.c
+++ b/refs.c
@@ -1038,55 +1038,40 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 			   const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
-	int reached_count;
 
 	cb->tz = tz;
 	cb->date = timestamp;
 
-	/*
-	 * It is not possible for cb->cnt == 0 on the first iteration because
-	 * that special case is handled in read_ref_at().
-	 */
-	if (cb->cnt > 0)
-		cb->cnt--;
-	reached_count = cb->cnt == 0 && !is_null_oid(ooid);
-	if (timestamp <= cb->at_time || reached_count) {
+	if (timestamp <= cb->at_time || cb->cnt == 0) {
 		set_read_ref_cutoffs(cb, timestamp, tz, message);
 		/*
 		 * we have not yet updated cb->[n|o]oid so they still
 		 * hold the values for the previous record.
 		 */
-		if (!is_null_oid(&cb->ooid) && !oideq(&cb->ooid, noid))
-			warning(_("log for ref %s has gap after %s"),
+		if (!is_null_oid(&cb->ooid)) {
+			oidcpy(cb->oid, noid);
+			if (!oideq(&cb->ooid, noid))
+				warning(_("log for ref %s has gap after %s"),
 					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
-		if (reached_count)
-			oidcpy(cb->oid, ooid);
-		else if (!is_null_oid(&cb->ooid) || cb->date == cb->at_time)
+		}
+		else if (cb->date == cb->at_time)
 			oidcpy(cb->oid, noid);
 		else if (!oideq(noid, cb->oid))
 			warning(_("log for ref %s unexpectedly ended on %s"),
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
+		cb->reccnt++;
+		oidcpy(&cb->ooid, ooid);
+		oidcpy(&cb->noid, noid);
 		cb->found_it = 1;
+		return 1;
 	}
 	cb->reccnt++;
 	oidcpy(&cb->ooid, ooid);
 	oidcpy(&cb->noid, noid);
-	return cb->found_it;
-}
-
-static int read_ref_at_ent_newest(struct object_id *ooid UNUSED,
-				  struct object_id *noid,
-				  const char *email UNUSED,
-				  timestamp_t timestamp, int tz,
-				  const char *message, void *cb_data)
-{
-	struct read_ref_at_cb *cb = cb_data;
-
-	set_read_ref_cutoffs(cb, timestamp, tz, message);
-	oidcpy(cb->oid, noid);
-	/* We just want the first entry */
-	return 1;
+	if (cb->cnt > 0)
+		cb->cnt--;
+	return 0;
 }
 
 static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
@@ -1121,11 +1106,6 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	cb.cutoff_cnt = cutoff_cnt;
 	cb.oid = oid;
 
-	if (cb.cnt == 0) {
-		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent_newest, &cb);
-		return 0;
-	}
-
 	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index e841309d0e..3e5f32f604 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -103,14 +103,14 @@ test_expect_success 'create path with @' '
 check "@:normal" blob content
 check "@:fun@ny" blob content
 
-test_expect_success '@{1} works with only one reflog entry' '
+test_expect_failure '@{1} works with only one reflog entry' '
 	git checkout -B newbranch main &&
 	git reflog expire --expire=now refs/heads/newbranch &&
 	git commit --allow-empty -m "first after expiration" &&
 	test_cmp_rev newbranch~ newbranch@{1}
 '
 
-test_expect_success '@{0} works with empty reflog' '
+test_expect_failure '@{0} works with empty reflog' '
 	git checkout -B newbranch main &&
 	git reflog expire --expire=now refs/heads/newbranch &&
 	test_cmp_rev newbranch newbranch@{0}
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 6a98b2df76..35f35f8091 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -4,9 +4,6 @@ test_description='test show-branch'
 
 . ./test-lib.sh
 
-# arbitrary reference time: 2009-08-30 19:20:00
-GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
-
 test_expect_success 'error descriptions on empty repository' '
 	current=$(git branch --show-current) &&
 	cat >expect <<-EOF &&
@@ -187,18 +184,6 @@ test_expect_success 'show branch --merge-base with N arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'show branch --reflog=2' '
-	sed "s/^>	//" >expect <<-\EOF &&
-	>	! [refs/heads/branch10@{0}] (4 years, 5 months ago) commit: branch10
-	>	 ! [refs/heads/branch10@{1}] (4 years, 5 months ago) commit: branch10
-	>	--
-	>	+  [refs/heads/branch10@{0}] branch10
-	>	++ [refs/heads/branch10@{1}] initial
-	EOF
-	git show-branch --reflog=2 >actual &&
-	test_cmp actual expect
-'
-
 # incompatible options
 while read combo
 do
@@ -264,4 +249,38 @@ test_expect_success 'error descriptions on orphan branch' '
 	test_branch_op_in_wt -c new-branch
 '
 
+test_expect_success 'setup reflogs' '
+	test_commit base &&
+	git checkout -b branch &&
+	test_commit one &&
+	git reset --hard HEAD^ &&
+	test_commit two &&
+	test_commit three
+'
+
+test_expect_success '--reflog shows reflog entries' '
+	cat >expect <<-\EOF &&
+	! [branch@{0}] (0 seconds ago) commit: three
+	 ! [branch@{1}] (60 seconds ago) commit: two
+	  ! [branch@{2}] (2 minutes ago) reset: moving to HEAD^
+	   ! [branch@{3}] (2 minutes ago) commit: one
+	----
+	+    [branch@{0}] three
+	++   [branch@{1}] two
+	   + [branch@{3}] one
+	++++ [branch@{2}] base
+	EOF
+	# the output always contains relative timestamps; use
+	# a known time to get deterministic results
+	GIT_TEST_DATE_NOW=$test_tick \
+	git show-branch --reflog branch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--reflog handles missing reflog' '
+	git reflog expire --expire=now branch &&
+	test_must_fail git show-branch --reflog branch 2>err &&
+	grep "log .* is empty" err
+'
+
 test_done
-- 
2.44.0.rc2.424.gbdbf4d014b

