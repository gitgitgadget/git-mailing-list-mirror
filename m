Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048953939C2
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888055; cv=none; b=rJ1RAURrvbgelcPdnjUxDD9eMNc9iaG+JLbvt7tiOValS/je7NuFn6dDwEozC1wqPt/DrLaVhmuwsNUWMHrwqsl2Oy6ObTnM3U7lzrnEgnNUaObEVl1Dn6EnMH6PCVS7uz2uBVoifViwUY21frEFjWnYCDvaG/uEwciJeVEm538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888055; c=relaxed/simple;
	bh=pKCFXZchARLvjku23bQLmRteFEbhZEa2QJrVBjFqzjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT15fzsHF9TdpCXd0w6fIkxBCNo+nP1a8JdXKUvPtE7MLb4Uq30dAtVHVSE6tm0HYVNkrwocj6+gMbsdu8qSwfNAPbL6Lza8G3vrIo9s2oXMsbtjm/4D3vBqowwrJgr0xodwkFnjSakPh5beiOuEZHt/N3XaoS1RVhhT92TYYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ghVDAKP7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ghVDAKP7"
Received: (qmail 76997 invoked by uid 106); 1 Jul 2026 06:40:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pKCFXZchARLvjku23bQLmRteFEbhZEa2QJrVBjFqzjk=; b=ghVDAKP761Ctq7C1OvPL6HhVb63s94RHuTKU3nlQGQ8eQXvYAwd3l8Px7LR2mPOfmVDEFhzy4V97vGfwYZjVIgWEC7PbrnHlpdzEELvFlXcZhK+G0ZM+bpvIYx5lujStoRWrZzhBFnGQJq6CvPrYnLeghR2JDjLHFEAfgWZ9WzsXoaxE7R/8IZzGMr+GFhcT9wyF5bSaU6Tf1sSBIvBnJsjf9GRVZ/lI0K6cry2fcyDLYKvaebKUjhU7tbTSGzhjPTPXYZf7GOchcu6C+1cjDmMkImp7cYVJadLopqvEm2FcNXTM7EHZGm1n9uaos9ECm7xEUyYmo9Uoapz38VqKXg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2026 06:40:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157827 invoked by uid 111); 1 Jul 2026 06:40:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2026 02:40:52 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jul 2026 02:40:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/3] revision: avoid leaking bloom keyvecs with multiple
 traversals
Message-ID: <20260701064052.GB2580331@coredump.intra.peff.net>
References: <20260701063538.GA2579765@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701063538.GA2579765@coredump.intra.peff.net>

In prepare_revision_walk(), we convert the pruning pathspecs into
bloom-filter "keyvecs" via prepare_to_use_bloom_filter(). This allocates
memory which is then freed eventually by release_revisions(), via
release_revisions_bloom_keyvecs().

But there's one case where we leak. If a caller uses the same rev_info
for multiple walks, calling prepare_revision_walk() multiple times, then
subsequent calls will overwrite the earlier keyvecs, leaking them. This
can happen with "git show foo bar", which does a separate no-walk
traversal for "foo" and "bar". Building with SANITIZE=leak and running
the test suite like:

  GIT_TEST_COMMIT_GRAPH=1 \
  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1 \
  ./t4013-diff-various.sh

will trigger a complaint from LSan. It does not happen without those
extra flags because we don't store on-disk bloom filters by default, and
thus we optimize out the keyvec computation.

We can fix the leak by discarding the old entries before generating new
ones.

There's an alternative fix, which is that prepare_to_use_bloom_filter()
could notice that we already have keyvec entries and just reuse them.
But this is less safe; the keyvec depends on the pruning pathspec, and
we don't know if that has changed.

I think it would _probably_ work in practice, since any caller using a
rev_info for multiple traversals is probably doing so with the same
pathspec. But it would also create a very subtle bug if that assumption
is violated. So we'll do the safer thing here, and generate fresh keyvec
entries for each traversal. The efficiency difference is probably not
noticeable, and this is what was happening already (we just weren't
bothering to free the old ones!).

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/revision.c b/revision.c
index e91d7e1f11..0ef9d895f0 100644
--- a/revision.c
+++ b/revision.c
@@ -707,6 +707,8 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
 
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
+	release_revisions_bloom_keyvecs(revs);
+
 	if (!revs->commits)
 		return;
 
-- 
2.55.0.394.gcf1c5597d2

