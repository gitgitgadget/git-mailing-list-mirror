Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F753394
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942086; cv=none; b=B1p38JydGWJEqxXVRvttZZ4+3+4cA0PIknHPnekyIeI4mgGwrG9xasH3bDMKekBEHv7doVBYnpXECi3/lgVyMelLRb0awAUG8taMGoY5TlwU+/RXvMeVOH5H2bncBRq8pGXwACgl6yNzxzdyPqQfnXA6dBGHxfQn/2FqQbMVx8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942086; c=relaxed/simple;
	bh=L1US0GykuobW6uDsTNjpjMKN2e/FEFC3W6eyUFFNZ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ixww201urEv5dN2U/wgYN2txEeSYIG1FD1+m4s2UtM2oj7SFBNmIEH0twPUNL5v2/iIm0B1SN0OeKa8RqOWU0ZUEYNJ1k1fGQpj/fd16xVOMXi2m/Fc/MrxLBuGIVnFJKsyIev78l0MndkxmcXorHzFwteS3IMtcC1mmmyN/J1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21995 invoked by uid 109); 26 Feb 2024 10:08:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 10:08:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15064 invoked by uid 111); 26 Feb 2024 10:08:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 05:08:08 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 05:08:03 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] read_ref_at(): special-case ref@{0} for an empty reflog
Message-ID: <20240226100803.GC2685600@coredump.intra.peff.net>
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

The previous commit special-cased get_oid_basic()'s handling of ref@{n}
for a reflog with n entries. But its special case doesn't work for
ref@{0} in an empty reflog, because read_ref_at() dies when it notices
the empty reflog!

We can make this work by special-casing this in read_ref_at(). It's
somewhat gross, for two reasons:

  1. We have no reflog entry to describe in the "msg" out-parameter. So
     we have to leave it uninitialized or make something up.

  2. Likewise, we have no oid to put in the "oid" out-parameter. Leaving
     it untouched is actually the best thing here, as all of the callers
     will have initialized it with the current ref value via
     repo_dwim_log(). This is rather subtle, but it is how things worked
     in 6436a20284 (refs: allow @{n} to work with n-sized reflog,
     2021-01-07) before we reverted it.

The key difference from 6436a20284 here is that we'll return "1" to
indicate that we _didn't_ find the requested reflog entry. Coupled with
the special-casing in get_oid_basic() in the previous commit, that's
enough to make looking up ref@{0} work, and we can flip 6436a20284's
test back to expect_success.

It also means that the call in show-branch which segfaulted with
6436a20284 (and which is now tested in t3202) remains OK. The caller
notices that we could not find any reflog entry, and so it breaks out of
its loop, showing nothing. This is different from the current behavior
of producing an error, but it's just as reasonable (and is exactly what
we'd do if you asked it to walk starting at ref@{1} but there was only 1
entry).

Thus nobody should actually look at the reflog entry info we return. But
we'll still put in some fake values just to be on the safe side, since
this is such a subtle and confusing interface. Likewise, we'll document
what's going on in a comment above the function declaration. If this
were a function with a lot of callers, the footgun would probably not be
worth it. But it has only ever had two callers in its 18-year existence,
and it seems unlikely to grow more. So let's hold our noses and let
users enjoy the convenience of a simulated ref@{0}.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                     | 15 +++++++++++++++
 refs.h                     | 15 ++++++++++++++-
 t/t1508-at-combinations.sh |  2 +-
 t/t3202-show-branch.sh     |  4 ++--
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 6b826b002e..8eaec5eca7 100644
--- a/refs.c
+++ b/refs.c
@@ -1109,6 +1109,21 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
+		if (cnt == 0) {
+			/*
+			 * The caller asked for ref@{0}, and we had no entries.
+			 * It's a bit subtle, but in practice all callers have
+			 * prepped the "oid" field with the current value of
+			 * the ref, which is the most reasonable fallback.
+			 *
+			 * We'll put dummy values into the out-parameters (so
+			 * they're not just uninitialized garbage), and the
+			 * caller can take our return value as a hint that
+			 * we did not find any such reflog.
+			 */
+			set_read_ref_cutoffs(&cb, 0, 0, "empty reflog");
+			return 1;
+		}
 		if (flags & GET_OID_QUIETLY)
 			exit(128);
 		else
diff --git a/refs.h b/refs.h
index 303c5fac4d..37116ad2b2 100644
--- a/refs.h
+++ b/refs.h
@@ -440,7 +440,20 @@ int refs_create_reflog(struct ref_store *refs, const char *refname,
 		       struct strbuf *err);
 int safe_create_reflog(const char *refname, struct strbuf *err);
 
-/** Reads log for the value of ref during at_time. **/
+/**
+ * Reads log for the value of ref during at_time (in which case "cnt" should be
+ * negative) or the reflog "cnt" entries from the top (in which case "at_time"
+ * should be 0).
+ *
+ * If we found the reflog entry in question, returns 0 (and details of the
+ * entry can be found in the out-parameters).
+ *
+ * If we ran out of reflog entries, the out-parameters are filled with the
+ * details of the oldest entry we did find, and the function returns 1. Note
+ * that there is one important special case here! If the reflog was empty
+ * and the caller asked for the 0-th cnt, we will return "1" but leave the
+ * "oid" field untouched.
+ **/
 int read_ref_at(struct ref_store *refs,
 		const char *refname, unsigned int flags,
 		timestamp_t at_time, int cnt,
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 370bf7137e..e841309d0e 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -110,7 +110,7 @@ test_expect_success '@{1} works with only one reflog entry' '
 	test_cmp_rev newbranch~ newbranch@{1}
 '
 
-test_expect_failure '@{0} works with empty reflog' '
+test_expect_success '@{0} works with empty reflog' '
 	git checkout -B newbranch main &&
 	git reflog expire --expire=now refs/heads/newbranch &&
 	test_cmp_rev newbranch newbranch@{0}
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 35f35f8091..a1139f79e2 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -279,8 +279,8 @@ test_expect_success '--reflog shows reflog entries' '
 
 test_expect_success '--reflog handles missing reflog' '
 	git reflog expire --expire=now branch &&
-	test_must_fail git show-branch --reflog branch 2>err &&
-	grep "log .* is empty" err
+	git show-branch --reflog branch >actual &&
+	test_must_be_empty actual
 '
 
 test_done
-- 
2.44.0.rc2.424.gbdbf4d014b
