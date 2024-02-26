Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC41537E4
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941850; cv=none; b=p5yNlZPHLnxcglV4HQybKIsjjQp1ohSI0Pz14K1dtB3gH9m58FfsCvvVaAnCs/JvaexwU2dp6giuNuOVHbwL6AXkuG95pwyZLsgKZrAXuN4J1lyext6nTB/iYDu5Is+3BowA2hgxomT3GaYaVkf5hJdAlM46uJR0AvSzeSAOATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941850; c=relaxed/simple;
	bh=aq1Qqz1w3CrFhAbt+aubuW+xpd0CWmpgGp8dOdFWsh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbL3eBndREa9jGOBmHbs8qGXf1rm8UHYZEXwLub2mMMN3XcBYyHpNioUhFoytXZwB7EP+NAh5pjEnfjUDPVBpY4U10kVvAIc3SvDcyOKr/fK51oYMMm7qeVwmNL1bshEz1uAjwy5C0qUMKdXR691YNNz8Fe6vjyQnjlDCZSGr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21928 invoked by uid 109); 26 Feb 2024 10:04:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 10:04:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14376 invoked by uid 111); 26 Feb 2024 10:04:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 05:04:12 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 05:04:07 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] get_oid_basic(): special-case ref@{n} for oldest reflog
 entry
Message-ID: <20240226100407.GB2685600@coredump.intra.peff.net>
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

The goal of 6436a20284 (refs: allow @{n} to work with n-sized reflog,
2021-01-07) was that if we have "n" entries in a reflog, we should still
be able to resolve ref@{n} by looking at the "old" value of the oldest
entry.

Commit 6436a20284 tried to put the logic into read_ref_at() by shifting
its idea of "n" by one. But we reverted that in the previous commit,
since it led to bugs in other callers which cared about the details of
the reflog entry we found. Instead, let's put the special case into the
caller that resolves @{n}, as it cares only about the oid.

read_ref_at() is even kind enough to return the "old" value from the
final reflog; it just returns "1" to signal to us that we ran off the
end of the reflog. But we can notice in the caller that we read just
enough records for that "old" value to be the one we're looking for, and
use it.

Note that read_ref_at() could notice this case, too, and just return 0.
But we don't want to do that, because the caller must be made aware that
we only found the oid, not an actual reflog entry (and the call sites in
show-branch do care about this).

There is one complication, though. When read_ref_at() hits a truncated
reflog, it will return the "old" value of the oldest entry only if it is
not the null oid. Otherwise, it actually returns the "new" value from
that entry! This bit of fudging is due to d1a4489a56 (avoid null SHA1 in
oldest reflog, 2008-07-08), where asking for "ref@{20.years.ago}" for a
ref created recently will produce the initial value as a convenience
(even though technically it did not exist 20 years ago).

But this convenience is only useful for time-based cutoffs. For
count-based cutoffs, get_oid_basic() has always simply complained about
going too far back:

  $ git rev-parse HEAD@{20}
  fatal: log for 'HEAD' only has 16 entries

and we should continue to do so, rather than returning a nonsense value
(there's even a test in t1508 already which covers this). So let's have
the d1a4489a56 code kick in only when doing timestamp-based cutoffs.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-name.c              | 9 +++++++++
 refs.c                     | 2 +-
 t/t1508-at-combinations.sh | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index 3a2ef5d680..511f09bc0f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1034,6 +1034,15 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 						len, str,
 						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
 				}
+			} else if (nth == co_cnt && !is_null_oid(oid)) {
+				/*
+				 * We were asked for the Nth reflog (counting
+				 * from 0), but there were only N entries.
+				 * read_ref_at() will have returned "1" to tell
+				 * us it did not find an entry, but it did
+				 * still fill in the oid with the "old" value,
+				 * which we can use.
+				 */
 			} else {
 				if (flags & GET_OID_QUIETLY) {
 					exit(128);
diff --git a/refs.c b/refs.c
index ba1a4db754..6b826b002e 100644
--- a/refs.c
+++ b/refs.c
@@ -1083,7 +1083,7 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
 
 	set_read_ref_cutoffs(cb, timestamp, tz, message);
 	oidcpy(cb->oid, ooid);
-	if (is_null_oid(cb->oid))
+	if (cb->at_time && is_null_oid(cb->oid))
 		oidcpy(cb->oid, noid);
 	/* We just want the first entry */
 	return 1;
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 3e5f32f604..370bf7137e 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -103,7 +103,7 @@ test_expect_success 'create path with @' '
 check "@:normal" blob content
 check "@:fun@ny" blob content
 
-test_expect_failure '@{1} works with only one reflog entry' '
+test_expect_success '@{1} works with only one reflog entry' '
 	git checkout -B newbranch main &&
 	git reflog expire --expire=now refs/heads/newbranch &&
 	git commit --allow-empty -m "first after expiration" &&
-- 
2.44.0.rc2.424.gbdbf4d014b

