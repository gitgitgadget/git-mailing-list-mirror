Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEB348C52
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251702; cv=none; b=cHYh9YQXYKg0ih6IOd16NQICQGRvhgbYYqG+FvQy97oZbhZWdlt63YJEEXA/e/lRMwD/W3gwr6b3lgrKQaF9uH2Ee4fp2JD2PyOs4CLs0B5hQcsDZs9P6k8OaVv6OqponcxFn0mOASbsuBkFjHoLApC8NlTUW9/E9zEB2sT5SmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251702; c=relaxed/simple;
	bh=L3NA1H/PqzTywcb6Q3Arw9Iu2X6MB2WcByfYLE6+9ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5mmATCbalX0N+vGs1Z+F9qqH/6rVc0gKyzYReyrcO1cjuOYFFs594cvv/jZbyXDG2Y7bXQR4SnjE6DZUBTZHf//nmJ4YLDVzjy2oIXWTrnKwfxIYs5QAdhHgSsVHTA4vzWkvYuB9DEvxLn8ZJ6cdU0Uo/RlahkXTA/VdEXfbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z3Bd79jW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z3Bd79jW"
Received: (qmail 81024 invoked by uid 106); 28 Jul 2026 15:14:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=L3NA1H/PqzTywcb6Q3Arw9Iu2X6MB2WcByfYLE6+9ZU=; b=Z3Bd79jW26XCoXMsL1KcLTrG5YimXk6aRch0kDfGc7Cxp27TjX133aWC+VjfYxn1SiGBT1rx0QmVD28HNh6F1kOvog+GvEYMO9NyoqzPTDXaTPV7rpm7iF06ZPxXtzMbqXn7XtpVPRKulXdbseoYK8E/KJ7Hu4+aIKyX0yD+eCkdIRn1zPpbo0KGR5AyzB9Qf9IAbymfuLBbl6aPtaTYT/5d2HMVVm94FJwkw0AyK6e4Hy7EgPLY7Eq6W/VhGKGnjaNZDY6tb8WonQxdYl6v04BiE+VpxB6wEieX9UYHnvKDrLDXhXJd1NyGkkH+eZ4h7Bf7B3eJdLkRNuIdTBVH7A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 15:14:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 100132 invoked by uid 111); 28 Jul 2026 15:15:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 11:15:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 11:14:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH] diff-lib: add idx/tree sanity check to oneway_diff
Message-ID: <20260728151458.GB41931@coredump.intra.peff.net>
References: <20260726084550.GC2366012@coredump.intra.peff.net>
 <20260726084705.GB3529698@coredump.intra.peff.net>
 <20260727093912.GA591426@coredump.intra.peff.net>
 <xmqq4ihkgd06.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ihkgd06.fsf@gitster.g>

On Mon, Jul 27, 2026 at 05:43:21PM -0700, Junio C Hamano wrote:

> > Possibly adding:
> >
> >   if (!idx && !tree)
> > 	BUG("oneway diff with no endpoints");
> >
> > would help static analysis, but I don't know if that makes things more
> > or less clear to a human.
> 
> We could help humans that the BUG is not expected to fire and only
> to help static analysis by a crafted message, perhaps?
> 
>    if (!idx && !tree)
>  	BUG("Hey, Coverity, this does not happen");

If we are helping humans we can probably afford to be a little more
eloquent. ;)

So maybe this on top of jk/diff-relative-cached-unmerged? I'd also be
happy to just let it be. It would not be the first Coverity false
positive by a long shot.

-- >8 --
Subject: [PATCH] diff-lib: add idx/tree sanity check to oneway_diff

When looking just at the code in oneway_diff(), it seems possible for
both "idx" and "tree" to be NULL, in which case we'd potentially
segfault while checking the relative prefix.

But if you consider what these items actually mean, it shouldn't be
possible for both to be NULL. Let's add an assertion and a comment
documenting this. It might help human readers, but should also silence
static analyzers like Coverity which complain about the potential
segfault.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 9986f5b141..d07e5d8d5b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -528,6 +528,16 @@ static int oneway_diff(const struct cache_entry * const *src,
 	if (tree == o->df_conflict_entry)
 		tree = NULL;
 
+	/*
+	 * We should only see a NULL idx when the entry was present in the tree
+	 * but deleted in the idx. In which case it should be impossible
+	 * that a NULL tree was passed in (there would have been no entry at
+	 * all) or that we got a df conflict above (you need a directory and a
+	 * file to get such a conflict, which implies both sides are present).
+	 */
+	if (!idx && !tree)
+		BUG("oneway_diff with neither idx nor tree");
+
 	if (revs->diffopt.prefix &&
 	    strncmp((idx ? idx : tree)->name, revs->diffopt.prefix,
 		    revs->diffopt.prefix_length))
-- 
2.55.0.749.g30c495c7a6

