Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0AD367B7B
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801786; cv=none; b=PHMFtUp+nbVizaZhB3jTqGZfEEbpw8Kfr3XqVhkxsHAdXorPpYXgNICzM/+DKuZIPdlrz3BobSxaVLcrQjM/Q+PZ54liwy28D+bZ1LAPExnv2sfkKiLU4+2Nx1MrklOu/agUGdd7T6xVFUFVXLtVYKMW53K+Sntaihml47S1Vp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801786; c=relaxed/simple;
	bh=vf1Y4TUKnDo8yR63DTjIT/Xi6HM+85VruPzkY3kn9rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFIyapUJybmQXmh94M4mlbIPv/pNWLLI9jdDrE7yZl6djXaVuWd9zcQzBqp/n7HVUiBCRaNIIvuJnokO41gXAZeIjD7g1cb5jvLUX3yv5ZLP6iCYLwyQ78dlVS3EmCbK1bKmCDm8F+k5zfzAqkvPucbfgpGi2shtMzuP6VbELDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hW958gxN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hW958gxN"
Received: (qmail 69919 invoked by uid 106); 30 Jun 2026 06:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vf1Y4TUKnDo8yR63DTjIT/Xi6HM+85VruPzkY3kn9rQ=; b=hW958gxN1bsI31pYw8bbxqFLtzMpQLp4pOmAljcorWGegZToL0nqzOELk6z0Fbtk2XPDP89lh6YWo0b++sScawFrfIoKVaTNDg4gcFN3d4fVwWrGrbVD+nXTDACgOvovoGj5HegXPg+F2zcrMyV0kyDgKjusj74AvONWs0z34T+Py7S8bTMDeYpBPH0DO49WxL/KO4dtMKBp4NbidhrcHvoMfQfSxIN9uSHJTWgkFY/9s6JzTzg1ueQ6zZgah2ziQ8kfkBWMGhdfVHc4Jj2/FhgUKVLUy7uKC4EKhhnK0hA+BfnaAlpsAqmeyLWKVu6v5EsA0cGSWQppGiZw/9N9Tg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 06:43:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 141398 invoked by uid 111); 30 Jun 2026 06:43:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 02:43:01 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 02:43:01 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <20260630064301.GB3733961@coredump.intra.peff.net>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630063944.GA3733670@coredump.intra.peff.net>

In prepare_bases() we do a custom revision walk, separate from the main
format-patch walk. After we finish, we fail to call release_revisions(),
possibly leaking its contents.

We failed to notice it so far because the revision machinery doesn't
always allocate. But at least one case can trigger the leak: if a commit
graph is present, then the topo-walk allocates revs.topo_walk_info and
some associated data structures. You can see it in the test suite by
running:

  make SANITIZE=leak
  cd t
  GIT_TEST_COMMIT_GRAPH=1 ./t4014-format-patch.sh

which yields many entries like:

  ==git==3687620==ERROR: LeakSanitizer: detected memory leaks
  Direct leak of 200 byte(s) in 1 object(s) allocated from:
      #0 0x7f4ccba185cb in malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:74
      #1 0x55cd452cdd0b in do_xmalloc wrapper.c:55
      #2 0x55cd452cdd9d in xmalloc wrapper.c:76
      #3 0x55cd45255473 in init_topo_walk revision.c:3845
      #4 0x55cd45255bef in prepare_revision_walk revision.c:4017
      #5 0x55cd44ffec40 in prepare_bases builtin/log.c:1872
      #6 0x55cd450010ec in cmd_format_patch builtin/log.c:2439

The un-released rev_info has been there since the code was added in
fa2ab86d18 (format-patch: add '--base' option to record base tree info,
2016-04-26), but back then we didn't even have a way to release rev_info
resources! The actual leak probably started around f0d9cc4196
(revision.c: begin refactoring --topo-order logic, 2018-11-01), but it's
hard to bisect because there were so many other unrelated leaks back
then.

So I'm not sure exactly when the leak started beyond "long ago", but it
is easy-ish to find now (since we've plugged all those other leaks) and
the solution is clear.

I didn't add a new test since we can demonstrate it with the existing
ones, but it does require tweaking a test variable. We might consider
ways to get more automatic leak-checking coverage there, but I think it
should be done outside of this fix.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/log.c b/builtin/log.c
index d027ce1e0b..350b35c556 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1888,6 +1888,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		bases->nr_patch_id++;
 	}
 	clear_commit_base(&commit_base);
+	release_revisions(&revs);
 }
 
 static void print_bases(struct base_tree_info *bases, FILE *file)
-- 
2.55.0.346.g83d0ea82e4
