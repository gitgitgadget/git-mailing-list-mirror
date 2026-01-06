Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3A336EE8
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695164; cv=none; b=VFDtRk/IgFQAWuXjPGTah38VW2f8guYzu+IFy8X+YfHaHTqazUcRzzI1h1vb2IDctK2NowlCnaFzuFhlD6GeMr0c/mL8FaBQroO32vO1T53/sagBZAK01Hjy2jn2oKUFwOS2Ap7B+Z0O4vFGl8hGNRW0bXpNEOx60jnnBTE0Yfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695164; c=relaxed/simple;
	bh=JDzr92AXJ0aMmbEaOklcsFaNmhqCWkgAmmhZXRQ3QYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gz/IdGd05iUaEuLLnJdbxddw4MKwwgbqXOvpdvaEcfoKSLAgtfweMPEz8kOS+dgfFRG+SrAa3nCCK5vl6pFRqmd3k1w/HNPoyeZ3L63/46TjnTz3ynO4NZUHEtH7E7+MFTDSYku39ufNdlQ7OtV6M4cPAW4DY/wL48qJmdqhVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dSqaQPss; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dSqaQPss"
Received: (qmail 600989 invoked by uid 109); 6 Jan 2026 10:25:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=JDzr92AXJ0aMmbEaOklcsFaNmhqCWkgAmmhZXRQ3QYM=; b=dSqaQPsscbWpz+APM0L9U+LBU2NFmigol7EQ8VDMe+fNPsj0RXQIWXOj2J/Uqu+KYquFZAgQgXuTp4SqvjcwNAhGRvKmp7IaVPs7B3S6PfbW316xvbvmeylultbotBVbx8zlEZylKPu/a/JK7amCIBvLQSYIiQWclZL/QZ6bzwnKuZvnBbr6t9BxubcnrGYQfwGVCp7wpynk2bvVFPmh9e0coB7TyiWZ4Gm16j1EZ5xqfEGVOHjLTfPO/nzgwwiDegIKeOoMmy0KcQT8bvMVir03aNHfe97wHe3r/2Ocr/kzqKuIOSHnUinh/dR+JnYJL6FC5jNze4uM4NZypQzBEw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Jan 2026 10:25:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 789176 invoked by uid 111); 6 Jan 2026 10:26:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Jan 2026 05:26:04 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 6 Jan 2026 05:25:58 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] cat-file: only use bitmaps when filtering
Message-ID: <20260106102558.GA68914@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Commit 8002e8ee18 (builtin/cat-file: use bitmaps to efficiently filter
by object type, 2025-04-02) introduced a performance regression when we
are not filtering objects: it uses bitmaps even when they won't help,
incurring extra costs. For example, running the new perf tests from this
commit, which check the performance of listing objects by oid:

  $ export GIT_PERF_LARGE_REPO=/path/to/linux.git
  $ git -C "$GIT_PERF_LARGE_REPO" repack -adb
  $ GIT_SKIP_TESTS=p1006.1 ./run 8002e8ee18^ 8002e8ee18 p1006-cat-file.sh
  [...]
  Test                                  8002e8ee18^       8002e8ee18
  -------------------------------------------------------------------------------
  1006.2: list all objects (sorted)     1.48(1.44+0.04)   6.39(6.35+0.04) +331.8%
  1006.3: list all objects (unsorted)   3.01(2.97+0.04)   3.40(3.29+0.10) +13.0%
  1006.4: list blobs                    4.85(4.67+0.17)   1.68(1.58+0.10) -65.4%

An invocation that filters, like listing all blobs (1006.4), does
benefit from using the bitmaps; it now doesn't have to check the type of
each object from the pack data, so the tradeoff is worth it.

But for listing all objects in sorted idx order (1006.2), we otherwise
would never open the bitmap nor the revindex file. Worse, our sorting
step gets much worse. Normally we append into an array in pack .idx
order, and the sort step is trivial. But with bitmaps, we get the
objects in pack order, which is apparently random with respect to oid,
and have to sort the whole thing. (Note that this freshly-packed state
represents the best case for .idx sorting; if we had two packs, then
we'd have their objects one after the other and qsort would have to
interleave them).

The unsorted test in 1006.3 is interesting: there we are going in pack
order, so we load the revindex for the pack anyway. And though we don't
sort the result, we do use an oidset to check for duplicates. So we can
see in the 8002e8ee18^ timings that those two things cost ~1.5s over the
sorted case (mostly the oidset hash cost). We also incur the extra cost
to open the bitmap file as of 8002e8ee18, which seems to be ~400ms.
(This would probably be faster with a bitmap lookup table, but writing
that out is not yet the default).

So we know that bitmaps help when there's filtering to be done, but
otherwise make things worse. Let's only use them when there's a filter.

The perf script shows that we've fixed the regressions without hurting
the bitmap case:

  Test                                  8002e8ee18^       8002e8ee18                HEAD
  --------------------------------------------------------------------------------------------------------
  1006.2: list all objects (sorted)     1.56(1.53+0.03)   6.44(6.37+0.06) +312.8%   1.62(1.54+0.06) +3.8%
  1006.3: list all objects (unsorted)   3.04(2.98+0.06)   3.45(3.38+0.07) +13.5%    3.04(2.99+0.04) +0.0%
  1006.4: list blobs                    5.14(4.98+0.15)   1.76(1.68+0.06) -65.8%    1.73(1.64+0.09) -66.3%

Note that there's another related case: we might have a filter that
cannot be used with bitmaps. That check is handled already for us in
for_each_bitmapped_object(), though we'd still load the bitmap and
revindex files pointlessly in that case. I don't think it can happen in
practice for cat-file, though, since it allows only blob:none,
blob:limit, and object:type filters, all of which work with bitmaps.

It would be easy-ish to insert an extra check like:

  can_filter_bitmap(&opt->objects_filter);

into the conditional, but I didn't bother here. It would be redundant
with the call in for_each_bitmapped_object(), and the can_filter helper
function is static local in the bitmap code (so we'd have to make it
public).

Signed-off-by: Jeff King <peff@peff.net>
---
There are some timing tests in 8002e8ee18 that claim the non-filter case
is not regressed, but it's not clear to me exactly which commands were
run. Given the size of the repo there and the fact that it's more I/O
bound, I'd guess it is using an output format that requires looking at
the packed objects.

You can see the mean user CPU does jump by almost 2 seconds in the
timings given there. So it may be that the problem was there but drowned
out by I/O noise. At any rate, the new t/perf tests isolate it better
and reproduce consistently for me.

 builtin/cat-file.c       |  8 +++++---
 t/perf/p1006-cat-file.sh | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 505ddaa12f..3cb725940d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -846,12 +846,14 @@ static void batch_each_object(struct batch_options *opt,
 		.callback = callback,
 		.payload = _payload,
 	};
-	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
+	struct bitmap_index *bitmap = NULL;
 
 	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
 
-	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
-						 batch_one_object_bitmapped, &payload)) {
+	if (opt->objects_filter.choice != LOFC_DISABLED &&
+	    (bitmap = prepare_bitmap_git(the_repository)) &&
+	    !for_each_bitmapped_object(bitmap, &opt->objects_filter,
+				       batch_one_object_bitmapped, &payload)) {
 		struct packed_git *pack;
 
 		repo_for_each_pack(the_repository, pack) {
diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
index dcd8015379..da34ece242 100755
--- a/t/perf/p1006-cat-file.sh
+++ b/t/perf/p1006-cat-file.sh
@@ -9,4 +9,18 @@ test_perf 'cat-file --batch-check' '
 	git cat-file --batch-all-objects --batch-check
 '
 
+test_perf 'list all objects (sorted)' '
+	git cat-file --batch-all-objects --batch-check="%(objectname)"
+'
+
+test_perf 'list all objects (unsorted)' '
+	git cat-file --batch-all-objects --batch-check="%(objectname)" \
+		--unordered
+'
+
+test_perf 'list blobs' '
+	git cat-file --batch-all-objects --batch-check="%(objectname)" \
+		--unordered --filter=object:type=blob
+'
+
 test_done
-- 
2.52.0.664.g9f53c65b4c
