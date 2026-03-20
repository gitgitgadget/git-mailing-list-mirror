Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931C1F5847
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967365; cv=none; b=MoCvx9mTjZOl6qixUoUhbAle4jvXncDwBr86Yq6QSldQQFwVt7C+ZXLJicpGHZtCzu1lwB9WzpkGYHqAmUVhNT9dF9y+oDiQMWmj/rEO42dMRKDueFZuXwJkQJW7Oq9/Ef4MUUtWaVIMKHpYnoGqD51v9e4yQmp4DA30qPBP+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967365; c=relaxed/simple;
	bh=mbq/delS/zDD/B50dKzS7KEKMJkFIgbNI/5Y18MNNLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li4hBoyY1QD4gsoRtzPZOt+sBr+jMzC112HXHFBfxL/w0EqQYghJ2LWzBNwhAXRG+kQjTFduDjydjGN8NQWBFjZNGX70NUb/UoAt3lZKSspfYsbzOzs3DYDclxbDA+k++oZ1VjiYFrtyNRxsf2guCB0QAq4L8bAJEjaqBoYvsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E+NABHIZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E+NABHIZ"
Received: (qmail 62413 invoked by uid 106); 20 Mar 2026 00:42:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mbq/delS/zDD/B50dKzS7KEKMJkFIgbNI/5Y18MNNLg=; b=E+NABHIZLG3kCBBp17SlXTlCb3P0v8BYAaQmKfwNgmi8/u9DxY6nWqvGgtDnvbBkdyxBrJGXKFjc9guzeQ5lhx5XcwvEgS4beEIL6fmYuYoGkwraZS2GumWGTy7ZqMl9QNdtF8m/CcIHiUgXTx2mvlWoWhw/Ig8kT1YkESqFXSp2E7Jvgyoi01kFl6Vh0Yb5BmwU63eW7CWX0ITSIJ+GXAxqOiRbRPvt8ww0N5BIxvdeNTKPocVBRCYJ7FhfQEGRoiXkFcUDUCt+D722UwCQvDQj138qk3ZHEQ4uJ/AEX1TIrXj2gjuiDslqW4TVCR5hlvbR7QoahgoDi7r0T15jIQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 00:42:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 91633 invoked by uid 111); 20 Mar 2026 00:42:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 20:42:43 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 20:42:42 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH 2/8] diff-highlight: drop perl version dependency back to 5.8
Message-ID: <20260320004242.GB3654226@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320004138.GA3653623@coredump.intra.peff.net>

From: Scott Baker <scott@perturb.org>

The diff-highlight code does not rely on any perl features beyond what
perl 5.8 provides. We bumped it to v5.26 along with the rest of the
project's perl scripts in 702d8c1f3b (Require Perl 5.26.0, 2024-10-23).

There's some value in just having a uniform baseline for the project,
but I think diff-highlight is special here:

  - it's in a contrib/ directory that is not frequently touched, so
    there is little risk of Git developers getting annoyed that modern
    perl features are not available

  - it provides a module used by other projects. In particular,
    diff-so-fancy relies on DiffHighlight.pm but does not otherwise
    require a perl version more modern than 5.8.

Let's drop back to the more conservative requirement.

Signed-off-by: Scott Baker <scott@perturb.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/DiffHighlight.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index f0607a4b68..a5e5de3b18 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -1,6 +1,6 @@
 package DiffHighlight;
 
-require v5.26;
+require v5.008;
 use warnings FATAL => 'all';
 use strict;
 
-- 
2.53.0.945.ge67b727e8d

