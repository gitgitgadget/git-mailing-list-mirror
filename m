Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549D40DFC3
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245725; cv=none; b=ZWHqkcTu6+5E/BaD8OXwcjOad9sthVd033ptYJINNWXQK4t2kE6JLhzjvOVE5Ui41TAjkpSry1XHNTbH1GdZd7RVay6dvUf4hGlE1wdMjTk8jOBn6iaTbWpMDhZblAuPs9QNEB58j1vZzUNLeOcFXDnnB5HfehcYPz/bA3iU4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245725; c=relaxed/simple;
	bh=OPfy4eBDuN3EHjNbvX/pnwkBxvkIapScUlelGfm9hZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLfPnzCkiP5GdTs6BfaVz5U3eqMERuMDtwd1awuZ/I6A1uYY7xmCqVMYr+QRMX5+MwuUTqYYsS6Nyn7nJv8aJ9JUhmU4GS3vSCPnlnvZQw81jtQGNm6c8Bh1N2GPvDGbwf9+inchgOA3E98giR9G2E2OB3vgRt7xz1cXoBeFpyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y10s0r/y; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y10s0r/y"
Received: (qmail 110170 invoked by uid 106); 23 Mar 2026 06:02:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OPfy4eBDuN3EHjNbvX/pnwkBxvkIapScUlelGfm9hZE=; b=Y10s0r/y/q+yNXjCyCyMoqI2zom1xoxbvNGsd0i4MgXe5DPawnCbXiyWI9qRRlg72Vy9gpzoS/UUnRzgALTlcXcvj0WRiQQ8Tb3TcQL7vOF94bLZp4VKSxnsEtc4OI7KkeaW9NfyReR7ksLdSeZZgE7HWbJhlZOQzzRAuqGF7aBlCbB1KqpzNCpqiJEcW8c1YPXZ40fpMkLTSYKK5VhDSvG1KgPz6G+zOBqmWvmts1LxLRQXoVRqpdBxnEnw2gUIQpMhu5mbryoeHCGhCI95sheKtwpBd+KX8ibz33KapYRaR45nAQkuLxLFO+FHNrMHiWzaWX8+upTNPd88s3gG6g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:02:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146984 invoked by uid 111); 23 Mar 2026 06:02:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:02:02 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:02:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 2/8] diff-highlight: drop perl version dependency back to
 5.8
Message-ID: <20260323060202.GB10482@coredump.intra.peff.net>
References: <20260323060139.GA10215@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323060139.GA10215@coredump.intra.peff.net>

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
2.53.0.1051.ga14e96f895

