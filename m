Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818EC3209
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489845; cv=none; b=LwTyoJIWXTtn7p93b3fauwPmY901Z0twHmftBoT0ITmGCPIUJibQHGzZoAkcifJwws1xboUazTywHCy1VOmXYPsk595Fc6dJkRoiPVxdYf+tvIiITAkOvMhJybR6/h2Mcve5ZXqCGqEShXwWABO2uWbC+WVWPrjFSeR7YZD93/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489845; c=relaxed/simple;
	bh=1Z3foLPQzWARbRt/Mlws5YuN9WcvabLcv6fDkW4RVEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikee0/XjPygkEy35QKQWE47DLO7krx2hrRffAXxUJ6YrQD2mRbUaEGvunSzPchSqwXSbXueUYWMqcUkXsqMhk202J7aBMQx+UFoRsc0thB0E98qOuZobGQQjONHO0sRDuurckQ7Y2f9Q3PeuNX7jv2WlHghr/N2o7t2f02tcHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sz5SWTNK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sz5SWTNK"
Received: (qmail 4804 invoked by uid 109); 9 Mar 2025 03:10:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1Z3foLPQzWARbRt/Mlws5YuN9WcvabLcv6fDkW4RVEc=; b=Sz5SWTNKQo+vflLnm2gM34UH8/Pjd50tTc0jS7r1LkXZ3XhyD1vM1lI3Fr2jdMP9ubuIC1iS8a+Qfn27aO5bfyP3heu8FpxxNBOt7U/wYjSfh0DQsrt27w5KL7vAApgqdmB+pxejaab7up+wcwAgRcUn7etmS1Tt9NAfoA190/BpzIYiaTyy53znfltXg6IfFkKKOZLCdxiFSCtOBT7QsjX0GlqF7Z1RhBlLUbHEFnAEjsY8VqMCG2DK8uUxITfVebN5t6I5ZbAChtbM6/y9UqWQoOxNaoS03sXVdwDXsYkEsuvyJheBcpKJEGZSIbIhVYSyWl/w1WObgIygM7Abmw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:10:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4974 invoked by uid 111); 9 Mar 2025 03:10:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:10:40 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:10:39 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 7/9] fetch: stop protecting additions to ref-prefix list
Message-ID: <20250309031039.GG2334191@coredump.intra.peff.net>
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

When using the ref-prefix feature of protocol v2, a client which sends
no prefixes at all will get the full advertisement. And so the code in
git-fetch was historically loose about setting up that list based on our
refspecs. There were cases where we needed to know about some refs, so
we just didn't add anything to the ref-prefix list.

And hence further code, like that for tag-following and updating
origin/HEAD, had to be careful about adding to an empty list. E.g., see
the bug fixed by bd52d9a058 (fetch: fix following tags when fetching
specific OID, 2025-03-07).

But the previous commit removed the last such case, and now we know an
empty ref-prefix list (at least inside git-fetch's do_fetch() function)
means that we really don't need to see any refs. So we can drop those
extra conditionals.

This simplifies the code a little. But it also means that some cases can
now use ref prefixes when they would not otherwise. As the test shows,
fetching an exact oid into a local ref can now avoid enumerating all of
the refs. The refspec itself doesn't need to know about any remote refs,
and the tag auto-following can just ask about refs/tags/.

The same is true for asking about HEAD to update the local origin/HEAD.
I didn't add a test for that yet, though, as we can optimize it even
further.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c        | 10 ++++------
 t/t5702-protocol-v2.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f142756441..6ab101fa6d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1778,16 +1778,14 @@ static int do_fetch(struct transport *transport,
 
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
-		if (transport_ls_refs_options.ref_prefixes.nr)
-			strvec_push(&transport_ls_refs_options.ref_prefixes,
-				    "refs/tags/");
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    "refs/tags/");
 	}
 
 	if (uses_remote_tracking(transport, rs)) {
 		must_list_refs = 1;
-		if (transport_ls_refs_options.ref_prefixes.nr)
-			strvec_push(&transport_ls_refs_options.ref_prefixes,
-				    "HEAD");
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    "HEAD");
 	}
 
 	if (must_list_refs) {
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2f0a52a72d..626deb05f0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -682,6 +682,7 @@ test_expect_success 'default refspec is used to filter ref when fetching' '
 test_expect_success 'set up parent for prefix tests' '
 	git init prefix-parent &&
 	git -C prefix-parent commit --allow-empty -m foo &&
+	git -C prefix-parent tag my-tag &&
 	git -C prefix-parent branch unrelated-branch
 '
 
@@ -694,6 +695,19 @@ test_expect_success 'empty refspec filters refs when fetching' '
 	test_grep ! unrelated-branch log
 '
 
+test_expect_success 'exact oid fetch with tag following' '
+	git init exact-oid-tags &&
+
+	commit=$(git -C prefix-parent rev-parse --verify HEAD) &&
+
+	test_when_finished "rm -f log" &&
+	GIT_TRACE_PACKET="$(pwd)/log" \
+		git -C exact-oid-tags fetch ../prefix-parent \
+			$commit:refs/heads/exact &&
+	test_grep ! unrelated-branch log &&
+	git -C exact-oid-tags rev-parse --verify my-tag
+'
+
 test_expect_success 'fetch supports various ways of have lines' '
 	rm -rf server client trace &&
 	git init server &&
-- 
2.49.0.rc1.381.gc60f5426ff

