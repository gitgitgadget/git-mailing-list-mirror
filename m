Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CC37F0F2
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674472; cv=none; b=rAqG7gEvoW0uE+Mlg2k4y68zBFGzGGI7lvhTCYHeLAfoE+afkg662JnzpwsIJcJQSatEpa7PLeN0diO8Um+/bb2bV4QmooyHnCPynDwpccV8CJmosutqvFCOa1givdYRAk/uWiSs4xrQwoJhSef9ZqvhhnIhacYZpteXOQUdPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674472; c=relaxed/simple;
	bh=z4T/FH1TVBrKIzgQbsOsdhlz5VpNtSclCBIrJ2SeImg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5DRfbz7jO2pl6/ffNOPQI3uwZsnAzwoNGN72y3WXSfWNndag81f3dxKl2es5YhS+plQXHhgyTS8e/3rTFgdJh6ZI3frTrrB+xJqpAikZd9GXqSuobxszki/GOozwxQ3aCntBg7H3+sKzbk2bNkhtgIdBYArJUxkKwW1hmtn2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CUgc2J4i; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CUgc2J4i"
Received: (qmail 209062 invoked by uid 109); 29 Jan 2026 08:14:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=z4T/FH1TVBrKIzgQbsOsdhlz5VpNtSclCBIrJ2SeImg=; b=CUgc2J4i1XhbzEsXuX795j1D/QqjKTh3r93ppSfPVDAwMxpWiI1JWfTtD8us+lTDNPIG743l3uJEE89sz15j6mNGKjXer7AxfjCPWj+M/6lKJq+XIamacI86Ko6XYFvjt8jlk+zUC/EqnMk8xwMd4d86hhk3kBZUYGrPFczyPxOPxQ+oHcGL+nA3H9OPVaBYRTMaXN9mYxfgAuJ9HZM3IBIHqCMaP50/VPVUiDm+cQV1XyAKMAwFM3rPaWH2EQU7RXpHLFNgAJfvsNFuhvv/F4DzUO65SK79wbWV/FBQTnFltvQZMopmapmRuMMnpMY8bpq+0cYokUPmF2kq+4WC0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jan 2026 08:14:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 397722 invoked by uid 111); 29 Jan 2026 08:14:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jan 2026 03:14:25 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Jan 2026 03:14:20 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] bisect: fix misuse of `refs_for_each_ref_in()`
Message-ID: <20260129081420.GA589284@coredump.intra.peff.net>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-3-deccae3ea725@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-3-deccae3ea725@pks.im>

On Wed, Jan 28, 2026 at 09:49:22AM +0100, Patrick Steinhardt wrote:

> Furthermore, taking a closer look, we strip the prefix only to re-add it
> in `mark_for_removal()`. This is somewhat roundabout, as we can instead
> call `refs_for_each_fullref_in()` to not do any stripping at all. Do so
> to simplify the code a bit.

Yeah, I think the result is much better.

We might also want this simplification on top:

-- >8 --
Subject: [PATCH] bisect: simplify string_list memory handling

We declare the refs_for_removal string_list as NODUP, forcing us to
manually allocate strings we insert. And then when it comes time to
clean up, we set strdup_strings so that string_list_clear() will free
them for us.

This is a confusing pattern, and can be done much more simply by just
declaring the list with the DUP initializer in the first place.

It was written this way originally because one of the callsites
generated the item using xstrfmt(). But that spot switched to a plain
xstrdup() in cf01f617b9 (bisect: fix misuse of `refs_for_each_ref_in()`,
2026-01-28). That means we can now just let the string_list code handle
allocation itself.

Signed-off-by: Jeff King <peff@peff.net>
---
Even before cf01f617b9 we could have done:

  string_list_append_nodup(&refs, xstrfmt(...));

to get a similar simplification, but after that commit it is even
easier.

 bisect.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2cd97bc9fe..6b9e9d81c3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1183,8 +1183,7 @@ int estimate_bisect_steps(int all)
 static int mark_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *bisect_ref = xstrdup(ref->name);
-	string_list_append(refs, bisect_ref);
+	string_list_append(refs, ref->name);
 	return 0;
 }
 
@@ -1193,16 +1192,15 @@ int bisect_clean_state(void)
 	int result = 0;
 
 	/* There may be some refs packed during bisection */
-	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
 	refs_for_each_fullref_in(get_main_ref_store(the_repository),
 				 "refs/bisect/", NULL, mark_for_removal,
 				 &refs_for_removal);
-	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
-	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
+	string_list_append(&refs_for_removal, "BISECT_HEAD");
+	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
 	result = refs_delete_refs(get_main_ref_store(the_repository),
 				  "bisect: remove", &refs_for_removal,
 				  REF_NO_DEREF);
-	refs_for_removal.strdup_strings = 1;
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_ancestors_ok());
 	unlink_or_warn(git_path_bisect_log());
-- 
2.53.0.rc2.296.g6748ed0491

