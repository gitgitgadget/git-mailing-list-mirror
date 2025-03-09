Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61A1FC8
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741490419; cv=none; b=k2zSsD9iFKqeO/4xcWRLc7qHga9SUc82K9/LCxmr8sKIWMksp+ZOeTsercmcsuBimqQeg3bQF6nps8FkFslt1UABJzUxwBGPUsyjfmdTcoR0UPa4l58rmDxIrQ2P7gJP2NeozA6N9jeZPqFMVYmPm5dV76QSqfpKk3ZuR/slAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741490419; c=relaxed/simple;
	bh=/xPY1z5CS8RmFHYt7ph+GU1wU4AM0HWpNteoNyhnnng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9OTstS3ax2eknvTMEWcGwrGgPyvxDcOdNOR9uLhySeZZ56tsV6yC9v7O/Dv2bCX3KHFBUvt4AovQRo9DzLOoU67CMWca0iIuMwzyJH6IO0olMINAxbGE8GPnJ4uu/7dRYvoAX7CANRPqNwk1L83v81UyN0uPRp1bGSblaWSsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F6zg5+K+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F6zg5+K+"
Received: (qmail 4969 invoked by uid 109); 9 Mar 2025 03:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/xPY1z5CS8RmFHYt7ph+GU1wU4AM0HWpNteoNyhnnng=; b=F6zg5+K+SlY5GV981yiwmP6ZpGBTNrPEoEJvD2FsMXLcAHftw+6NV0nzBfo0wEBtgK7JUUGP1z07CXGn8QxgAJa+8vtTxsSxJ2qdRSWaXH96XAII6Ob8V7Ve/jt732dS0+DVZoSJDLvfx8wUraeoW2DVD56ac0BVKw5VSuN32Pd459yaqlQlQxwYWBaIHNEASSHZBdDsIIpTeP2s0ZgGzpaS9xJSf6cvuhkap3iBovieHQeG+IILAgGvBJdwRhayaewYLOhgdNOGniFO39rYuZfawxfn4j1d76NXV176CSWuQGoUapZu8E6ERFRDDP6NGYQTS0WC4g+cXBieX0kUEQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:20:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5084 invoked by uid 111); 9 Mar 2025 03:20:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:20:16 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:20:16 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 8/9] fetch: avoid ls-refs only to ask for HEAD symref update
Message-ID: <20250309032016.GH2334191@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

When we fetch from a configured remote, we may try to update the local
refs/remotes/<origin>/HEAD, and so we ask the server to advertise its
HEAD to us.

But if we aren't otherwise asking about any refs at all, then we know
this HEAD update can never happen! To consider a new value for HEAD,
the set_head() function uses guess_remote_head(). And even if it sees an
explicit symref value for HEAD, it will only report that as a match if
we also saw that remote ref advertised, and it mapped to a local
tracking ref via get_fetch_map().

In other words, a fetch like this:

  git fetch origin $exact_oid:refs/heads/foo

can never update HEAD, because we will never have fetched (nor even see
the advertisement for) the ref that HEAD points to.

Currently the command above will still call ls-refs to ask about the
HEAD, even though it is pointless. This patch teaches it to skip the
ls-refs call entirely in this case, which avoids a round-trip to the
server.

Signed-off-by: Jeff King <peff@peff.net>
---
This describes the current behavior of set_head(). But I do wonder if it
should be more aggressive. If we found out that the other side is
pointing to refs/heads/foo, should we map that ourselves to find that it
would be stored as refs/remotes/origin/foo, and update HEAD anyway?

That would let us actually update HEAD in this case (and also in many
other cases where we fetch a specific ref that is not pointed to by
the remote HEAD).

OTOH, it would mean we basically always do an ls-refs just to find out
about HEAD. Which is working against the optimization from e70a3030e7
(fetch: do not list refs if fetching only hashes, 2018-09-27), and the
code before this patch might even be considered a regression.

I also wonder if the uses_remote_tracking() check added by 6c915c3f85
(fetch: do not ask for HEAD unnecessarily, 2024-12-06) is not quite
right. It is looking for a configured remote along with at least one
refspec with a destination. But wouldn't it need to have both a source
ref (not an exact oid) and a destination to work? I suspect we could do
the fix there and end up with the same optimized behavior as I have
here.

 builtin/fetch.c        |  5 ++---
 t/t5702-protocol-v2.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6ab101fa6d..c26866e674 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1782,11 +1782,10 @@ static int do_fetch(struct transport *transport,
 			    "refs/tags/");
 	}
 
-	if (uses_remote_tracking(transport, rs)) {
-		must_list_refs = 1;
+	if (must_list_refs &&
+	    uses_remote_tracking(transport, rs))
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "HEAD");
-	}
 
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 626deb05f0..4d0cbe9872 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -708,6 +708,19 @@ test_expect_success 'exact oid fetch with tag following' '
 	git -C exact-oid-tags rev-parse --verify my-tag
 '
 
+test_expect_success 'exact oid fetch avoids pointless HEAD request' '
+	git init exact-oid-head &&
+	git -C exact-oid-head remote add origin ../prefix-parent &&
+
+	commit=$(git -C prefix-parent rev-parse --verify HEAD) &&
+
+	test_when_finished "rm -f log" &&
+	GIT_TRACE_PACKET="$(pwd)/log" \
+		git -C exact-oid-head fetch --no-tags origin \
+			$commit:refs/heads/exact &&
+	test_grep ! command=ls-refs log
+'
+
 test_expect_success 'fetch supports various ways of have lines' '
 	rm -rf server client trace &&
 	git init server &&
-- 
2.49.0.rc1.381.gc60f5426ff

